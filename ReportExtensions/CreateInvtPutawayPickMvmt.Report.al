report 50012 "Create InvtPutaway/Pick/Mv New"
{
    // NF1.00:CIS.CM  08/04/15 Merged during upgrade
    // >> NIF
    // Code  Modified:
    //   Report - OnInitReport()   (to default PrintDocument := TRUE)
    //   "WareHouse Request" - OnAferGetRecord
    //   "Warehouse Request" - OnPostDataItem
    // Variables Added:
    //   PrintLabels
    //   SalesSetup
    //   SortPick
    // Request Form Changes:
    //   New Field PrintLabels
    //   Code at OnOpenForm to check SalesSetup to see if shipping is enabled
    //   New Field SortPick
    //   Property SaveValues=Yes
    // Functions Added:
    //   PrintNewDocuments
    // Functions Modified:
    //   InitWhseActivHeader
    // 
    // Date     Init   Proj   Desc
    //          MAK           Code added to populate a field called "Blanket ORder No." in the header. ield is populated from the Blnkt SO
    // 06-27-05 RTT  #10124   code to print labels at OnOpenReqForm,OnInitReport,OnAfterGetRec,OnPostDataItem
    // 07-06-05 RTT           code to Sort Pick: new var to Req Form
    //                        -code at OnInitReport
    //                        -code at Warehouse Request-OnPostDataItem and OnAfterGetRecord
    //                        -code at InitWhseActivHeader
    // 07-12-05 RTT           changed SaveValues on req form to Yes
    // << NIF
    // //NF2.00:CIS.RAM 09-29-2017 Added 5 Functionas to automate the Inventory Pics and Generation of package.
    //                             # In Sales & Receivable seup functionality trigger only when the boolean flag "Create Pack & Enable Ship" will true.
    // //NF2.00:CIS.RAM 10-10-2017 Commented The Code
    // 
    // CIS.IoT 07/22/22 RAM Added code to supress Dialog Window

    Caption = 'Create Invt. Put-away/Pick/Movement New';
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Warehouse Request"; "Warehouse Request")
        {
            DataItemTableView = SORTING("Source Document", "Source No.");
            RequestFilterFields = "Source Document", "Source No.";

            trigger OnAfterGetRecord()
            var
                ATOMvmntCreated: Integer;
                TotalATOMvmtToBeCreated: Integer;
            begin
                IF GUIALLOWED THEN BEGIN //CIS.RAM 080122
                    Window.UPDATE(1, "Source Document");
                    Window.UPDATE(2, "Source No.");
                END; //CIS.RAM 080122
                CASE Type OF
                    Type::Inbound:
                        TotalPutAwayCounter += 1;
                    Type::Outbound:
                        IF CreatePick THEN
                            TotalPickCounter += 1
                        ELSE
                            TotalMovementCounter += 1;
                END;

                IF CheckWhseRequest("Warehouse Request") THEN
                    CurrReport.SKIP();

                IF ((Type = Type::Inbound) AND (WhseActivHeader.Type <> WhseActivHeader.Type::"Invt. Put-away")) OR
                   ((Type = Type::Outbound) AND ((WhseActivHeader.Type <> WhseActivHeader.Type::"Invt. Pick") AND
                                                 (WhseActivHeader.Type <> WhseActivHeader.Type::"Invt. Movement"))) OR
                   ("Source Type" <> WhseActivHeader."Source Type") OR
                   ("Source Subtype" <> WhseActivHeader."Source Subtype") OR
                   ("Source No." <> WhseActivHeader."Source No.") OR
                   ("Location Code" <> WhseActivHeader."Location Code")
                THEN BEGIN
                    CASE Type OF
                        Type::Inbound:
                            IF NOT CreateInvtPutAway.CheckSourceDoc("Warehouse Request") THEN
                                CurrReport.SKIP();
                        Type::Outbound:
                            IF NOT CreateInvtPickMovement.CheckSourceDoc("Warehouse Request") THEN
                                CurrReport.SKIP();
                    END;
                    InitWhseActivHeader();
                END;

                CASE Type OF
                    Type::Inbound:
                        BEGIN
                            CreateInvtPutAway.SetWhseRequest("Warehouse Request", TRUE);
                            CreateInvtPutAway.AutoCreatePutAway(WhseActivHeader);
                        END;
                    Type::Outbound:
                        BEGIN
                            CreateInvtPickMovement.SetWhseRequest("Warehouse Request", TRUE);
                            CreateInvtPickMovement.AutoCreatePickOrMove(WhseActivHeader);
                        END;
                END;

                //>>NIF MAK 061504
                IF WhseActivHeader."No." <> '' THEN
                    IF "Source Document" = "Source Document"::"Sales Order" THEN BEGIN
                        NIFSalesHeader.GET(NIFSalesHeader."Document Type"::Order, "Source No.");
                        WhseActivHeader."Blanket Order No." := NIFSalesHeader."Blanket Order No.";
                        WhseActivHeader.MODIFY();
                    END;
                //NOTE: Re-enable this code once the PO Blanket Order stuff has been put in for Nifast
                //    IF "Source Document" = "Source Document"::"Purchase Order" THEN
                //      BEGIN
                //        NIFPurchHeader.GET(NIFPurchHeader."Document Type"::Order, "Source No.");
                //        WhseActivHeader."Blanket Order No." := NIFPurchHeader."Blanket Order No.";
                //        WhseActivHeader.MODIFY();
                //      END;
                //<<NIF
                IF WhseActivHeader."No." <> '' THEN BEGIN
                    DocumentCreated := TRUE;
                    CASE Type OF
                        Type::Inbound:
                            PutAwayCounter := PutAwayCounter + 1;
                        Type::Outbound:
                            IF CreatePick THEN BEGIN
                                PickCounter := PickCounter + 1;

                                CreateInvtPickMovement.GetATOMovementsCounters(ATOMvmntCreated, TotalATOMvmtToBeCreated);
                                MovementCounter += ATOMvmntCreated;
                                TotalMovementCounter += TotalATOMvmtToBeCreated;
                            END ELSE
                                MovementCounter += 1;
                    END;
                    //NF2.00:CIS.RAM 09-29-2017
                    //NF2.00:CIS.RAM 10-10-2017
                    // IF SalesSetup."Create Pack & Enable Ship" THEN
                    //  CreateFastPackAction;
                    //  ReopenPackage;
                    //NF2.00:CIS.RAM 10-10-2017
                    //NF2.00:CIS.RAM 09-29-2017

                    //>> NIF #10124 RTT 06-24-05
                    //  IF PrintDocument THEN
                    IF (PrintDocument) OR (PrintLabels) OR (SortPick > 0) THEN
                        //<< NIF #10124 RTT 06-24-05
                        InsertTempWhseActivHdr();
                    COMMIT();
                END;
            end;

            trigger OnPostDataItem()
            var
                Msg: Text;
                ExpiredItemMessageText: Text[100];
            begin
                ExpiredItemMessageText := CreateInvtPickMovement.GetExpiredItemMessage();
                IF TempWhseActivHdr.FIND('-') THEN
                //>> NIF #10124 RTT 06-24-05
                //  PrintNewDocuments;
                  BEGIN
                    //>> NIF 07-06-05 RTT
                    IF SortPick > 0 THEN BEGIN
                        WhseActivHeader.GET(TempWhseActivHdr.Type, TempWhseActivHdr."No.");
                        WhseActivHeader.SortWhseDoc();
                    END;
                    //<< NIF 07-06-05 RTT
                    IF PrintDocument THEN
                        PrintNewDocuments();
                    IF PrintLabels THEN
                        PrintNewLabels();
                END;
                //<< NIF #10124 RTT 06-24-05
                IF GUIALLOWED THEN //CIS.RAM 080122
                    Window.CLOSE();
                IF NOT SuppressMessagesState THEN
                    IF DocumentCreated THEN BEGIN
                        IF PutAwayCounter > 0 THEN
                            AddToText(Msg, STRSUBSTNO(Text005, WhseActivHeader.Type::"Invt. Put-away", PutAwayCounter, TotalPutAwayCounter));
                        IF PickCounter > 0 THEN
                            AddToText(Msg, STRSUBSTNO(Text005, WhseActivHeader.Type::"Invt. Pick", PickCounter, TotalPickCounter));
                        IF MovementCounter > 0 THEN
                            AddToText(Msg, STRSUBSTNO(Text005, WhseActivHeader.Type::"Invt. Movement", MovementCounter, TotalMovementCounter));

                        IF CreatePutAway OR CreatePick THEN
                            Msg += ExpiredItemMessageText;

                        MESSAGE(Msg);
                    END ELSE BEGIN
                        Msg := Text004 + ' ' + ExpiredItemMessageText;
                        MESSAGE(Msg);
                    END;
            end;

            trigger OnPreDataItem()
            begin
                IF CreatePutAway AND NOT (CreatePick OR CreateMovement) THEN
                    SETRANGE(Type, Type::Inbound);
                IF NOT CreatePutAway AND (CreatePick OR CreateMovement) THEN
                    SETRANGE(Type, Type::Outbound);

                IF GUIALLOWED THEN //CIS.RAM 080122
                    Window.OPEN(
                      Text001 +
                      Text002 +
                      Text003);

                DocumentCreated := FALSE;

                IF CreatePick OR CreateMovement THEN
                    CreateInvtPickMovement.SetReportGlobals(PrintDocument, ShowError);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(CreateInventorytPutAway; CreatePutAway)
                    {
                        Caption = 'Create Invt. Put-Away';
                        ApplicationArea = All;
                    }
                    field(CInvtPick; CreatePick)
                    {
                        Caption = 'Create Invt. Pick';
                        Editable = CreatePickEditable;
                        Enabled = CreatePickEditable;
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            IF CreatePick AND CreateMovement THEN
                                ERROR(Text009);
                            EnableFieldsInPage();
                        end;
                    }
                    field(CInvtMvmt; CreateMovement)
                    {
                        Caption = 'Create Invt. Movement';
                        Editable = CreateMovementEditable;
                        Enabled = CreateMovementEditable;
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            IF CreatePick AND CreateMovement THEN
                                ERROR(Text009);
                            EnableFieldsInPage();
                        end;
                    }
                    field(PrintDocument; PrintDocument)
                    {
                        Caption = 'Print Document';
                        ApplicationArea = All;
                    }
                    field(ShowError; ShowError)
                    {
                        Caption = 'Show Error';
                        ApplicationArea = All;
                    }
                    field(PrintLabels; PrintLabels)
                    {
                        Caption = 'Print Labels';
                        Enabled = PrintLabelsEnable;
                        ApplicationArea = All;
                    }
                    field(SortPick; SortPick)
                    {
                        Caption = 'Sorting Method';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            CreatePickEditable := TRUE;
            CreateMovementEditable := TRUE;
        end;

        trigger OnOpenPage()
        begin
            EnableFieldsInPage();
            //>> NIF #10124 RTT 06-27-05
            SalesSetup.GET();
            //>> NF1.00:CIS.CM 08-01-15
            //RequestOptionsForm.PrintLabels.ENABLED(NOT SalesSetup."Enable Shipping");
            IF SalesSetup."Create Pack & Enable Ship" THEN
                PrintLabelsEnable := SalesSetup."LAX Enable Shipping"
            ELSE
                PrintLabelsEnable := NOT SalesSetup."LAX Enable Shipping";// OLD One;//New One
            //<< NF1.00:CIS.CM 08-01-15
            //<< NIF #10124 RTT 06-27-05
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        //>> NIF 05-18-05
        PrintDocument := TRUE;
        //<< NIF 05-18-05
        //>> NIF #10124 RTT 06-27-05
        SalesSetup.GET();
        PrintLabels := NOT SalesSetup."LAX Enable Shipping";
        //<< NIF #10124 RTT 06-27-05

        //>> NIF 07-06-05 RTT
        SortPick := SortPick::"Shelf/Bin";
        //<< NIF 07-06-05 RTT
    end;

    trigger OnPostReport()
    begin
        TempWhseActivHdr.DELETEALL();
    end;

    trigger OnPreReport()
    begin
        IF NOT CreatePutAway AND NOT (CreatePick OR CreateMovement) THEN
            ERROR(Text008);

        CreateInvtPickMovement.SetInvtMovement(CreateMovement);
    end;

    var
        //ScaleInterface: Record 14000746;
        BillOfLading: Record "LAX Bill of Lading";
        FastPackLine: Record "LAX Fast Pack Line";
        FastPackLineTmp: Record "LAX Fast Pack Line" temporary;
        gPackageRec: Record "LAX Package";
        Package: Record "LAX Package";
        PackingControl: Record "LAX Packing Control";
        PackingRule: Record "LAX Packing Rule";
        PackingStation: Record "LAX Packing Station";
        ShippingSetup: Record "LAX Shipping Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        NIFSalesHeader: Record "Sales Header";
        gSalesLineRec: Record "Sales Line";
        ShippingAgent: Record "Shipping Agent";
        TempWhseActivHdr: Record "Warehouse Activity Header" temporary;
        WhseActivHeader: Record "Warehouse Activity Header";
        CreateInvtPickMovement: Codeunit "Create Inventory Pick/Movement";
        CreateInvtPutAway: Codeunit "Create Inventory Put-away";
        PackageMgt: Codeunit "LAX Package Management";
        ScalesComm: Codeunit "LAX Scales Communication";
        WhseDocPrint: Codeunit "Warehouse Document-Print";
        CreateMovement: Boolean;
        CreateMovementEditable: Boolean;
        CreatePick: Boolean;
        CreatePickEditable: Boolean;
        CreatePutAway: Boolean;
        DocumentCreated: Boolean;
        OrderClosed: Boolean;
        PrintDocument: Boolean;
        PrintLabels: Boolean;
        PrintLabelsEnable: Boolean;
        ShowError: Boolean;
        SuppressMessagesState: Boolean;
        DisplayValue: Decimal;
        TotalDimWeight: Decimal;
        TotalGrossWeight: Decimal;
        TotalNetWeight: Decimal;
        TotalVolume: Decimal;
        Window: Dialog;
        MovementCounter: Integer;
        PickCounter: Integer;
        PutAwayCounter: Integer;
        TotalMovementCounter: Integer;
        TotalPickCounter: Integer;
        TotalPutAwayCounter: Integer;
        Text001: Label 'Creating Inventory Activities...\\';
        Text002: Label 'Source Type     #1##########\';
        Text003: Label 'Source No.      #2##########';
        Text004: Label 'There is nothing to create.';
        Text005: Label 'Number of %1 activities created: %2 out of a total of %3.';
        Text006: Label '%1\\%2', Comment = 'No translation needed. Only a new line separator.';
        Text008: Label 'You must select Create Invt. Put-away, Create Invt. Pick, or Create Invt. Movement.';
        Text009: Label 'You can select either Create Invt. Pick or Create Invt. Movement.';
        Text010: Label 'Nothing to Pack.';
        Text018: Label 'Document must be filtered.';
        Text019: Label 'Package(s) are already open, please close those package(s) before packing new.';
        SortPick: Option " ",Item,Document,"Shelf/Bin","Due Date",Destination,"Bin Ranking","Action Type";
        DisplayCaption: Text[30];
        CaptionText: Text[100];

    local procedure InitWhseActivHeader()
    begin
        WITH WhseActivHeader DO BEGIN
            INIT();
            CASE "Warehouse Request".Type OF
                "Warehouse Request".Type::Inbound:
                    Type := Type::"Invt. Put-away";
                "Warehouse Request".Type::Outbound:
                    IF CreatePick THEN
                        Type := Type::"Invt. Pick"
                    ELSE
                        Type := Type::"Invt. Movement";
            END;
            "No." := '';
            "Location Code" := "Warehouse Request"."Location Code";
            //>> NIF 07-06-05 RTT
            "Sorting Method" := SortPick;
            //<< NIF 07-06-05 RTT
        END;
    end;

    local procedure InsertTempWhseActivHdr()
    begin
        TempWhseActivHdr.INIT();
        TempWhseActivHdr := WhseActivHeader;
        TempWhseActivHdr.INSERT();
    end;

    local procedure PrintNewDocuments()
    begin
        WITH TempWhseActivHdr DO
            REPEAT
                CASE Type OF
                    Type::"Invt. Put-away":
                        WhseDocPrint.PrintInvtPutAwayHeader(TempWhseActivHdr, TRUE);
                    Type::"Invt. Pick":
                        IF CreatePick THEN
                            WhseDocPrint.PrintInvtPickHeader(TempWhseActivHdr, TRUE)
                        ELSE
                            WhseDocPrint.PrintInvtMovementHeader(TempWhseActivHdr, TRUE);
                END;
            UNTIL NEXT() = 0;
    end;

    local procedure CheckWhseRequest(WhseRequest: Record "Warehouse Request"): Boolean
    var
        SalesHeader: Record "Sales Header";
        TransferHeader: Record "Transfer Header";
        GetSrcDocOutbound: Codeunit "Get Source Doc. Outbound";
    begin
        IF WhseRequest."Document Status" <> WhseRequest."Document Status"::Released THEN
            EXIT(TRUE);
        IF (WhseRequest.Type = WhseRequest.Type::Outbound) AND
           (WhseRequest."Shipping Advice" = WhseRequest."Shipping Advice"::Complete)
        THEN
            CASE WhseRequest."Source Type" OF
                DATABASE::"Sales Line":
                    IF WhseRequest."Source Subtype" = WhseRequest."Source Subtype"::"1" THEN BEGIN
                        SalesHeader.GET(SalesHeader."Document Type"::Order, WhseRequest."Source No.");
                        EXIT(GetSrcDocOutbound.CheckSalesHeader(SalesHeader, ShowError));
                    END;
                DATABASE::"Transfer Line":
                    BEGIN
                        TransferHeader.GET(WhseRequest."Source No.");
                        EXIT(GetSrcDocOutbound.CheckTransferHeader(TransferHeader, ShowError));
                    END;
            END;
    end;

    procedure InitializeRequest(NewCreateInvtPutAway: Boolean; NewCreateInvtPick: Boolean; NewCreateInvtMovement: Boolean; NewPrintDocument: Boolean; NewShowError: Boolean)
    begin
        CreatePutAway := NewCreateInvtPutAway;
        CreatePick := NewCreateInvtPick;
        CreateMovement := NewCreateInvtMovement;
        PrintDocument := NewPrintDocument;
        ShowError := NewShowError;
    end;

    procedure EnableFieldsInPage()
    begin
        CreatePickEditable := NOT CreateMovement;
        CreateMovementEditable := NOT CreatePick;
    end;

    procedure SuppressMessages(NewState: Boolean)
    begin
        SuppressMessagesState := NewState;
    end;

    local procedure AddToText(var OrigText: Text; Addendum: Text)
    begin
        IF OrigText = '' THEN
            OrigText := Addendum
        ELSE
            OrigText := STRSUBSTNO(Text006, OrigText, Addendum);
    end;

    procedure GetMovementCounters(var MovementsCreated: Integer; var TotalMovementsToBeCreated: Integer)
    begin
        MovementsCreated := MovementCounter;
        TotalMovementsToBeCreated := TotalMovementCounter;
    end;

    procedure ">>NIF_fcn"()
    begin
    end;

    local procedure PrintNewLabels()
    var
        NIFLabelMgt: Codeunit "Label Mgmt NIF";
    begin
        WITH TempWhseActivHdr DO
            REPEAT
                CASE Type OF
                    Type::"Invt. Put-away":
                        EXIT;
                    Type::"Invt. Pick":
                        NIFLabelMgt.PrintLabelsFromPick(TempWhseActivHdr);
                END;
            UNTIL NEXT() = 0;
    end;

    procedure CreateFastPackAction()
    begin
        //NF2.00:CIS.RAM 09-29-2017

        IF "Warehouse Request"."Source Document" = "Warehouse Request"."Source Document"::"Sales Order" THEN BEGIN
            gSalesLineRec.RESET();
            gSalesLineRec.SETRANGE("Document Type", gSalesLineRec."Document Type"::Order);
            gSalesLineRec.SETRANGE(gSalesLineRec."Document No.", "Warehouse Request"."Source No.");
            IF gSalesLineRec.FINDSET() THEN
                REPEAT
                    FastPackLine.RESET();
                    FastPackLine.SETCURRENTKEY(Type, "No.", "Variant Code", "From Source ID");
                    FastPackLine.SETRANGE("Source Type", DATABASE::"Sales Header");
                    FastPackLine.SETRANGE("Source Subtype", "Warehouse Request"."Source Subtype");
                    FastPackLine.SETRANGE("Source ID", "Warehouse Request"."Source No.");
                    FastPackLine.SETRECFILTER();
                    OnOpenPageTrigger();
                    CreatePackageTrigger(FALSE);
                UNTIL gSalesLineRec.NEXT() = 0;
        END;
    end;

    procedure OnOpenPageTrigger()
    var
        Package2: Record "LAX Package";
    begin

        ShippingSetup.GET();
        PackingStation.GetPackingStation();
        PackageMgt.Initialize(PackingStation, ShippingSetup);

        CLEAR(PackingControl);
        IF NOT EVALUATE(PackingControl."Source Type", FastPackLine.GETFILTER(FastPackLine."Source Type")) THEN
            ERROR(Text018);
        IF NOT EVALUATE(PackingControl."Source Subtype", FastPackLine.GETFILTER(FastPackLine."Source Subtype")) THEN
            ERROR(Text018);
        PackingControl."Source ID" := FastPackLine.GETFILTER(FastPackLine."Source ID");
        PackingControl.TransferFromSource2();
        CaptionText := PackingControl.FormatSource2() + ' ' + PackingControl."Ship-to Name";

        PackingRule.GetPackingRule(
          PackingControl."Ship-to Type", PackingControl."Ship-to No.", PackingControl."Ship-to Code");

        PackingControl."Multi Document No." := PackingControl."Source ID";
        PackingControl."Multi Document Package" := FALSE;
        UpdatePackingLines(PackingControl);

        ShippingSetup.TestPackingAllowed(PackingControl."Source Type", PackingControl."Source Subtype");

        PackingControl.TestReleased2(TRUE);

        IF PackingStation."Reset Order Qty. When Opened" THEN
            PackageMgt.ResetQtyToShip(PackingControl);

        Package2.RESET();
        Package2.SETCURRENTKEY("Source Type", "Source Subtype", "Source ID");
        Package2.SETRANGE("Source Type", PackingControl."Source Type");
        Package2.SETRANGE("Source Subtype", PackingControl."Source Subtype");
        Package2.SETRANGE("Source ID", PackingControl."Source ID");
        IF ShippingSetup."Location Packing" THEN
            Package2.SETRANGE("Location Code", PackingStation."Location Code");
        OrderClosed := NOT FastPackLineTmp.FIND('-') AND NOT Package2.FIND('-');
        //TODO
        /* IF PackingStation."Scale Interface Code" <> '' THEN
            ScaleInterface.GET(PackingStation."Scale Interface Code");
        IF (PackingStation."Scale Update Interval (second)" <> 0) AND
           (PackingStation."Show What During Packing" =
             PackingStation."Show What During Packing"::"Scale Weight")
        THEN
            UpdateScaleWeight();*///TODO
        DisplayCaption := FORMAT(PackingStation."Show What During Packing");
        PackingControl.Prepack := PackingStation."Open with Prepack";
        COMMIT();
        IF PackingStation."Show Order Comments if Exists" THEN
            PackageMgt.ViewDocumentComments(PackingControl, TRUE);

        IF PackingStation."Show Warehouse Stat. on Open" THEN
            PackageMgt.ViewWarehouseStatistics(PackingControl);

        PackageMgt.CreateSelectExportDoc(PackingControl, '', FALSE, FALSE);

        PackageMgt.CheckPackageOpen(Package, PackingControl);
        IF PackingControl."Multi Document Package" THEN
            UpdatePackingLines(PackingControl);

        IF PackingControl."Bill of Lading No." <> '' THEN
            BillOfLading.GET(PackingControl."Bill of Lading No.");
        PackageMgt.UpdateShippingAgent(PackingControl, BillOfLading, ShippingAgent);
        PackageMgt.ShowShippingAgentClosedPackage(BillOfLading, Package, PackingControl);

        IF PackingStation."Check Name Addr. on Open Order" THEN
            PackingControl.CheckNameAddress(ShippingAgent.Code);

        IF PackingControl."Package Open" THEN
            MESSAGE(Text019);
    end;

    procedure CreatePackageTrigger(PrintLabel: Boolean)
    var
        FastPackLine: Record "LAX Fast Pack Line";
    begin
        PackingStation.TESTFIELD("Close Package Command");

        FastPackLineTmp.RESET();
        FastPackLineTmp.VALIDATE(FastPackLineTmp."Qty. to Pack", FastPackLineTmp."Qty. to Ship");
        FastPackLineTmp.MODIFY(TRUE);

        FastPackLineTmp.SETFILTER("Qty. to Pack", '<>0');
        IF NOT FastPackLineTmp.FIND('-') THEN
            ERROR(Text010);

        IF NOT PackingControl."Package Open" THEN
            IF NOT PackageMgt.CreatePackage(Package, PackingControl) THEN
                ERROR(PackingControl."Error Message");

        REPEAT
            PackingControl."Input Type" := FastPackLineTmp.Type.AsInteger();
            PackingControl."Input No." := FastPackLineTmp."No.";
            PackingControl."Input Serial Number" := '';
            PackingControl."Input Unit of Measure Code" :=
              FastPackLineTmp."Qty. to Pack Unit of Meas Code";
            PackingControl."Input Variant Code" := FastPackLineTmp."Variant Code";
            PackingControl."Pack Serial Number" := FastPackLineTmp."Pack Serial Number";
            PackingControl."Pack Serial Number Late" := FALSE;
            PackingControl."Input Lot Number" := '';
            PackingControl."Pack Lot Number" := FastPackLineTmp."Pack Lot Number";
            PackingControl."Pack Lot Number Late" := FALSE;
            PackingControl."Input Warranty Date" := 0D;
            PackingControl."Pack Warranty Date" := FastPackLineTmp."Pack Warranty Date";
            PackingControl."Pack Warranty Date Late" := FALSE;
            PackingControl."Input Expiration Date" := 0D;
            PackingControl."Pack Expiration Date" := FastPackLineTmp."Pack Expiration Date";
            PackingControl."Pack Expiration Date Late" := FALSE;
            PackingControl."Required Shipping Agent Code" :=
              FastPackLineTmp."Required Shipping Agent Code";
            PackingControl."Required E-Ship Agent Service" :=
              FastPackLineTmp."Required E-Ship Agent Service";
            PackingControl."Allow Other Ship. Agent/Serv." :=
              FastPackLineTmp."Allow Other Ship. Agent/Serv.";
            FastPackLine := FastPackLineTmp;
            IF NOT PackageMgt.CreatePackageLine(
                     Package, PackingControl, FastPackLineTmp."Unit of Measure Code",
                     FastPackLineTmp.Quantity, FastPackLineTmp."Qty. to Pack")
            THEN
                ERROR(PackingControl."Error Message");


            FastPackLineTmp := FastPackLine;
        UNTIL FastPackLineTmp.NEXT() = 0;

        COMMIT();

        IF PackingStation."View Opt on Close in Fast Pack" THEN
            PackageMgt.ShowPackageOptions(Package);
        //TODO
        /*  IF NOT PackageMgt.ClosePackage(
                  Package, ShippingAgent, ScaleInterface, PackingControl, PrintLabel)
         THEN
              ERROR(PackingControl."Error Message");*///TODO


        UpdatePackingLines(PackingControl);
    end;

    procedure UpdatePackingLines(var PackingControl: Record "LAX Packing Control")
    begin
        TotalNetWeight := 0;
        TotalGrossWeight := 0;
        TotalDimWeight := 0;
        TotalVolume := 0;
        UpdateDisplayValue();

        PackageMgt.UpdateFastPackLines(PackingControl, FastPackLineTmp, PackingRule, FALSE, FALSE, FALSE, 0, '', '');
    end;

    procedure UpdateScaleWeight()
    begin
        //TODO
        /* IF PackingStation."Scale Interface Code" <> '' THEN
            IF ScalesComm.GetScaleWeight(ScaleInterface, PackingControl."Scale Weight", TRUE) THEN
                UpdateDisplayValue();*///TODO
    end;

    procedure UpdateDisplayValue()
    begin
        CASE PackingStation."Show What During Packing" OF
            PackingStation."Show What During Packing"::"Net Weight":
                DisplayValue := TotalNetWeight;
            PackingStation."Show What During Packing"::"Gross Weight":
                DisplayValue := TotalGrossWeight;
            PackingStation."Show What During Packing"::"Dimmed Weight":
                DisplayValue := TotalDimWeight;
            PackingStation."Show What During Packing"::Volume:
                DisplayValue := TotalVolume;
            PackingStation."Show What During Packing"::"Scale Weight":
                DisplayValue := PackingControl."Scale Weight";
        END;
    end;

    procedure ReopenPackage()
    begin
        gPackageRec.RESET();
        gPackageRec.SETRANGE(gPackageRec."Source ID", "Warehouse Request"."Source No.");
        IF gPackageRec.FINDFIRST() THEN
            REPEAT
                gPackageRec.Closed := FALSE;
                gPackageRec.MODIFY(TRUE);
            UNTIL gPackageRec.NEXT() = 0;
    end;
}

