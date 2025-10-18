codeunit 50025 "Test BTApp"
{
    // NF1.00:CIS.NG  07/07/16 Splved Compilation Issue of Automation Variable
    // 
    // >>IST
    // Date   Init GranID SCRID  Description
    //                           Properties Modified:
    //                           Fields Added:
    //                           Fields Modified:
    //                           Globals Added:
    //                           Globals Modibfied:
    //                           TextConstant Added:
    //                           TextConstant Modified:
    //                           Functions Added:
    //                           Functions Modified:
    // 012609 CCL $12797 #12797    PrintReceiveLineLabel()
    // 012609 CCL $12797 #12797    CreatePackageFromRegPick()
    // 012609 CCL $12797 #12797    PrintPackageLabel()
    // 032009 CCL $12797 #12797    CreatePackageFromPickLine()
    // 032009 CCL $12797 #12797    CreatePackageFromPick()
    // 032409 CCL $12797 #12797    CreatePackageFromRegPick()
    //                           Keys Added:
    //                           Keys Modified:
    //                           Other:
    // Date      Init   SCR  Description
    // 02-27-06  RTT         new function GetPickNo
    // <<IST
    // // >> WC MH 05.01.09 Get Sales Line information


    trigger OnRun()
    var
        LabelHeader: Record 14000841;
        UsePrinterName: Text[250];
    begin

        // BtApplication.Quit(1);
        LabelPrint(LabelHeader, UsePrinterName, FALSE, 1);

        EXIT;
    end;

    var
        SalesHeader: Record 36;
        TempSalesHeader: Record 36 temporary;
        SalesLine: Record 37;
        TempSalesLine: Record 37 temporary;
        ItemCrossRef: Record 5717;
        TempItemCrossRef: Record 5717 temporary;
        TempLotNoInfo: Record 6505 temporary;
        TempLabelValue: Record 50006 temporary;
        ReceiveStation: Record 14000608;
        PackingStation: Record 14000709;
        BtApplication: Automation;
        BtFormat: Automation;
        ItemCrossRefLoaded: Boolean;
        LotInfoLoaded: Boolean;
        SalesHeaderLoaded: Boolean;
        SalesLineLoaded: Boolean;
    //  BtFormats: Automation ;
    //BtSubstrings: Automation ;

    local procedure GetPackingStation()
    begin
        IF PackingStation.Code = '' THEN
            PackingStation.GetPackingStation;
    end;

    local procedure GetReceiveStation()
    begin
        IF ReceiveStation.Code = '' THEN
            ReceiveStation.GetReceiveStation;
    end;

    procedure TestPrintPackageLabel(LabelHeaderCode: Code[10])
    var
        LabelContent: Record 50006;
        LabelHeader: Record 14000841;
        Preview: Boolean;
        PrintSel: Integer;
        UsePrinterName: Text[250];
    begin


        //get label, make sure fields exist and have format path
        LabelHeader.GET(LabelHeaderCode);
        LabelHeader.TESTFIELD("Format Path");
        IF NOT EXISTS(LabelHeader."Format Path") THEN
            ERROR('Format Path %1 not found.', LabelHeader."Format Path");
        LabelHeader.CALCFIELDS("No. of Fields");
        LabelHeader.TESTFIELD("No. of Fields");


        //if receive label, use receive station settings
        IF (LabelHeader."Label Usage" = LabelHeader."Label Usage"::Receive) OR
             (LabelHeader."Label Usage" = LabelHeader."Label Usage"::"Receive Line") THEN BEGIN
            GetReceiveStation();
            ReceiveStation.TESTFIELD("Printer Name");
            UsePrinterName := ReceiveStation."Printer Name";
        END
        ELSE BEGIN
            //get packing station, make sure have printer name
            GetPackingStation();
            PackingStation.TESTFIELD("Printer Name");
            UsePrinterName := PackingStation."Printer Name";
        END;


        //init temp table
        TempLabelValue.DELETEALL();

        //now get the label lines
        LabelContent.SETRANGE("Label Code", LabelHeader.Code);
        LabelContent.FIND('-');
        REPEAT
            TempLabelValue."Label Code" := LabelHeader.Code;
            TempLabelValue."Field Code" := LabelContent."Field Code";
            TempLabelValue."Print Value" := LabelContent."Test Print Value";
            //>> 09-15-05
            IF TempLabelValue."Field Code" = 'QTY' THEN
                TempLabelValue."Print Value" := DELCHR(TempLabelValue."Print Value", '=', ',');
            //<< 09-15-05
            TempLabelValue.INSERT();
        UNTIL LabelContent.NEXT() = 0;

        //prompt for preview mode
        PrintSel := STRMENU('Preview,Print');
        Preview := (PrintSel = 1);

        //exit if nothing chosen
        IF PrintSel = 0 THEN
            EXIT;


        //print label
        LabelPrint(LabelHeader, UsePrinterName, Preview, 1);
    end;

    procedure PromptReceiveLineLabel(ReceiveLine: Record 14000602; QuantityAdded: Decimal; QuantityBaseAdded: Decimal; ManualPrinting: Boolean)
    var
        ReceiveRule: Record 14000612;
        ReceiveLineLabel: Report 14000847;
        ReceiveLineRequest: Page 50037;
    begin
        IF ReceiveLine.Type <> ReceiveLine.Type::Item THEN
            EXIT;

        ReceiveRule.GetReceiveRule(ReceiveLine."No.");

        IF NOT ReceiveRule."Automatic Print Label" AND NOT ManualPrinting THEN
            EXIT;

        IF ReceiveRule."Item Label Code" <> '' THEN BEGIN
            CLEAR(ReceiveLineLabel);
            ReceiveLine.SETRECFILTER;
            ReceiveLineLabel.SETTABLEVIEW(ReceiveLine);
            CASE ReceiveRule."No. of Labels" OF
                ReceiveRule."No. of Labels"::Quantity:
                    ReceiveLineLabel.InitializeRequest(
                      ReceiveRule."Item Label Code", ROUND(QuantityAdded, 1, '>'));
                ReceiveRule."No. of Labels"::"Quantity (Base)":
                    ReceiveLineLabel.InitializeRequest(
                      ReceiveRule."Item Label Code", ROUND(QuantityBaseAdded, 1, '>'));
                ELSE
                    ReceiveLineLabel.InitializeRequest(ReceiveRule."Item Label Code", 1);
            END;
            //>> NIF 03-22-05
            //ReceiveLineLabel.USEREQUESTFORM(FALSE);
            //ReceiveLineLabel.RUNMODAL;
            COMMIT();
            ReceiveLineRequest.SETTABLEVIEW(ReceiveLine);
            ReceiveLineRequest.RUNMODAL();
            CLEAR(ReceiveLineRequest);
            //<< NIF 03-22-05
        END;
    end;

    procedure PrintReceiveLineLabel(Receive: Record 14000601; "Receive Line": Record 14000602; LabelHeaderCode: Code[10]; UseQty: Decimal; NoCopies: Integer)
    var
        Item: Record 27;
        LabelContent: Record 50006;
        LabelHeader: Record 14000841;
    begin
        CLEAR(Item);
        IF ("Receive Line".Type = "Receive Line".Type::Item) AND ("Receive Line"."No." <> '') THEN
            IF NOT Item.GET("Receive Line"."No.") THEN;


        //get receive station, make sure have printer name
        GetReceiveStation();
        ReceiveStation.TESTFIELD("Printer Name");

        //get label, make sure fields exist and have format path
        LabelHeader.GET(LabelHeaderCode);
        LabelHeader.TESTFIELD("Format Path");
        IF NOT EXISTS(LabelHeader."Format Path") THEN
            ERROR('Format Path %1 not found.', LabelHeader."Format Path");
        LabelHeader.CALCFIELDS("No. of Fields");
        LabelHeader.TESTFIELD("No. of Fields");

        //init temp table
        TempLabelValue.DELETEALL();

        //now get the label lines
        LabelContent.SETRANGE("Label Code", LabelHeader.Code);
        LabelContent.FIND('-');
        REPEAT
            TempLabelValue.INIT();
            TempLabelValue."Label Code" := LabelContent."Label Code";
            TempLabelValue."Field Code" := LabelContent."Field Code";

            CASE LabelContent."Field Code" OF
                'ITEM_NO':
                    TempLabelValue."Print Value" := "Receive Line"."No.";
                'LOT_NO':
                    TempLabelValue."Print Value" := "Receive Line"."Lot No.";
                'MFG_LOT_NO':
                    TempLabelValue."Print Value" := "Receive Line"."Mfg. Lot No.";
                'ITEM_DESC':
                    TempLabelValue."Print Value" := "Receive Line".Description;
                'QTY':
                    TempLabelValue."Print Value" := DELCHR(FORMAT(UseQty), '=', ',');
                //>>IST 012609 CCL $12797 #12797
                //    'PURCH_ORD_NO' : TempLabelValue."Print Value" := FORMAT(Receive."Purchase Order No.");
                'PURCH_ORD_NO':
                    TempLabelValue."Print Value" := FORMAT(Receive."Source ID");
                //<<IST 012609 CCL $12797 #12797
                'SYS_DATE':
                    TempLabelValue."Print Value" := FORMAT(TODAY);
                'SYS_TIME':
                    TempLabelValue."Print Value" := FORMAT(TIME);
                ELSE
                    ERROR('Field Code %1 not supported.', LabelContent."Field Code");
            END;

            TempLabelValue.INSERT();
        UNTIL LabelContent.NEXT() = 0;

        //print label
        LabelPrint(LabelHeader, ReceiveStation."Printer Name", FALSE, NoCopies);   //FALSE=No Preview
    end;

    procedure PromptPackageLineLabel(Package: Record 14000701; PackageLine: Record 14000702; QuantityAdded: Decimal; QuantityBaseAdded: Decimal; ManualPrinting: Boolean)
    var
        PackingRule: Record 14000715;
        PackageLineLabel: Report 50041;
        PackageLineRequest: Page 50038;
    begin
        IF PackageLine.Type <> PackageLine.Type::Item THEN
            EXIT;

        PackingRule.GetPackingRule(Package."Ship-to Type", Package."Ship-to No.", Package."Ship-to Code");



        IF NOT PackingRule."Automatic Print Label" AND NOT ManualPrinting THEN
            EXIT;

        IF PackingRule."Item Label Code" <> '' THEN BEGIN
            CLEAR(PackageLineLabel);
            PackageLine.SETRECFILTER;
            PackageLineLabel.SETTABLEVIEW(PackageLine);
            CASE PackingRule."No. of Labels" OF
                PackingRule."No. of Labels"::Quantity:
                    PackageLineLabel.InitializeRequest(
                      PackingRule."Item Label Code", ROUND(QuantityAdded, 1, '>'));
                PackingRule."No. of Labels"::"Quantity (Base)":
                    PackageLineLabel.InitializeRequest(
                      PackingRule."Item Label Code", ROUND(QuantityBaseAdded, 1, '>'));
                ELSE
                    PackageLineLabel.InitializeRequest(PackingRule."Item Label Code", 1);
            END;
            //>> NIF 03-22-05
            //PackageLineLabel.USEREQUESTFORM(FALSE);
            //PackageLineLabel.RUNMODAL;
            COMMIT();
            PackageLineRequest.SETTABLEVIEW(PackageLine);
            PackageLineRequest.RUNMODAL();
            CLEAR(PackageLineRequest);
            //<< NIF 03-22-05
        END;
    end;

    procedure PrintPackageLineLabel(Package: Record 14000701; "Package Line": Record 14000702; LabelHeaderCode: Code[10]; UseQty: Decimal; NoCopies: Integer)
    var
        Item: Record 27;
        LabelContent: Record 50006;
        PackingRule: Record 14000715;
        LabelHeader: Record 14000841;
        NoSeriesMgt: Codeunit 396;
    begin
        CLEAR(Item);

        IF ("Package Line".Type = "Package Line".Type::Item) AND ("Package Line"."No." <> '') THEN
            IF NOT Item.GET("Package Line"."No.") THEN;

        //get Package station, make sure have printer name
        GetPackingStation();
        PackingStation.TESTFIELD("Printer Name");

        //get label, make sure fields exist and have format path
        LabelHeader.GET(LabelHeaderCode);
        LabelHeader.TESTFIELD("Format Path");
        IF NOT EXISTS(LabelHeader."Format Path") THEN
            ERROR('Format Path %1 not found.', LabelHeader."Format Path");
        LabelHeader.CALCFIELDS("No. of Fields");
        LabelHeader.TESTFIELD("No. of Fields");

        //init temp table
        TempSalesHeader.DELETEALL();
        TempSalesLine.DELETEALL();
        TempItemCrossRef.DELETEALL;
        TempLotNoInfo.DELETEALL();
        TempLabelValue.RESET();
        TempLabelValue.DELETEALL();

        ClearPackageVars();

        //now get the label lines
        LabelContent.SETRANGE("Label Code", LabelHeader.Code);
        LabelContent.FIND('-');

        REPEAT
            TempLabelValue.INIT();
            TempLabelValue."Label Code" := LabelContent."Label Code";
            TempLabelValue."Field Code" := LabelContent."Field Code";

            CASE LabelContent."Field Code" OF
                'BOX_WT':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Box Weight");
                    END;
                'CERT_NO':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Certificate No.");
                    END;
                'CONTAINER_NO':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Container No.");
                    END;
                'CROSS_REF_DESC':
                    BEGIN
                        IF NOT ItemCrossRefLoaded THEN
                            LoadItemCrossRef(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempItemCrossRef.Description);
                    END;
                'CROSS_REF_NO':
                    BEGIN
                        IF NOT ItemCrossRefLoaded THEN
                            LoadItemCrossRef(Package, "Package Line");
                        //>> RTT 07-29-05 if ASN customer, use customer part number
                        IF TempItemCrossRef."Cross-Reference No." = '' THEN BEGIN
                            IF NOT SalesHeaderLoaded THEN
                                LoadSalesHeader(Package, "Package Line");
                            PackingRule.GetPackingRule(0, TempSalesHeader."Sell-to Customer No.", TempSalesHeader."Ship-to Code");  //0=customer
                            IF (PackingRule."ASN Summary Type" <> PackingRule."ASN Summary Type"::" ") THEN
                                TempItemCrossRef."Cross-Reference No." := "Package Line"."No.";
                        END;
                        //<< RTT 07-29-05 if ASN customer, use customer part number
                        TempLabelValue."Print Value" := FORMAT(TempItemCrossRef."Cross-Reference No.");
                    END;
                'CUST_NO':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Sell-to Customer No.");
                    END;
                'CUST_PO_NO':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."External Document No.");
                    END;
                'DEL_ORD_NO':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Delivery Order No.");
                    END;
                'DEL_TO':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Deliver To");
                    END;
                'DOCK_CODE':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Dock Code");
                    END;
                'DRAW_NO':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Drawing No.");
                    END;
                'ECN':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Eng. Change No.");
                    END;
                'EXT_DOC_NO':
                    TempLabelValue."Print Value" := FORMAT(Package."External Document No.");
                'FRS_NO':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."FRS No.");
                    END;
                'GROUP_CODE':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Group Code");
                    END;
                'ITEM_DESC':
                    TempLabelValue."Print Value" := "Package Line".Description;
                'ITEM_NO':
                    TempLabelValue."Print Value" := "Package Line"."No.";
                'KANBAN_NO':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Kanban No.");
                    END;
                'LN_SIDE_ADDR':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Line Side Address");
                    END;
                'LS_LOC':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Line Supply Location");
                    END;
                'LOT_NO':
                    TempLabelValue."Print Value" := "Package Line"."Lot No.";
                'LOT_CREATION':
                    BEGIN
                        IF NOT LotInfoLoaded THEN
                            LoadLotNoInfo(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempLotNoInfo."Lot Creation Date");
                    END;
                'MAIN_ROUTE':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Main Route");
                    END;
                'MAN_NO':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Man No.");
                    END;
                'MFG_DATE':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Mfg. Date");
                    END;
                'MFG_LOT_NO':

                    IF "Package Line"."Mfg. Lot No." = '' THEN BEGIN
                        IF NOT LotInfoLoaded THEN
                            LoadLotNoInfo(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempLotNoInfo."Mfg. Lot No.");
                    END
                    ELSE
                        TempLabelValue."Print Value" := "Package Line"."Mfg. Lot No.";
                'MODEL_YR':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Model Year");
                    END;
                'NET_WT':  //base on qty printing/total qty


                    IF "Package Line".Quantity = 0 THEN
                        TempLabelValue."Print Value" := '0'
                    ELSE
                        TempLabelValue."Print Value" := FORMAT(
                              ROUND((UseQty / "Package Line".Quantity) * "Package Line"."Net Weight", 0.1, '>'));
                'PICK_NO':
                    TempLabelValue."Print Value" := GetPackagePickNo(Package, "Package Line");
                'PLANT_CODE':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Plant Code");
                    END;
                'PURCH_ORD_NO':
                    BEGIN
                        IF NOT LotInfoLoaded THEN
                            LoadLotNoInfo(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempLotNoInfo."PO Number");
                    END;
                'QTY':
                    TempLabelValue."Print Value" := DELCHR(FORMAT(UseQty), '=', ',');
                'RAN_NO':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Ran No.");
                    END;
                'REC_AREA':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Receiving Area");
                    END;
                'RELEASE_NO':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Release No.");
                    END;
                'RES_MFG':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Res. Mfg.");
                    END;
                'REV_DATE':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Revision Date");
                    END;
                'REV_NO':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Revision No.");
                    END;
                'REV_NO_LO':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Revision No. (Label Only)");
                    END;
                //>>IST 012609 CCL $12797 #12797
                //    'SALES_ORD_NO': TempLabelValue."Print Value" := "Package Line"."Sales Order No.";
                'SALES_ORD_NO':
                    TempLabelValue."Print Value" := "Package Line"."Source ID";
                //<<IST 012609 CCL $12797 #12797
                'SERIAL_NO':
                    BEGIN
                        LabelContent.TESTFIELD("No. Series");
                        TempLabelValue."Print Value" := FORMAT(NoSeriesMgt.GetNextNo(LabelContent."No. Series", TODAY, TRUE));
                        TempLabelValue."No. Series" := LabelContent."No. Series";
                    END;
                'SHIP_ADDR':
                    TempLabelValue."Print Value" := FORMAT(Package."Ship-to Address");
                'SHIP_ADDR2':
                    TempLabelValue."Print Value" := FORMAT(Package."Ship-to Address 2");
                'SHIP_CITY':
                    TempLabelValue."Print Value" := FORMAT(Package."Ship-to City");
                'SHIP_CITYSTZIP':
                    TempLabelValue."Print Value" :=
     COPYSTR(Package."Ship-to City" + ', ' + Package."Ship-to State" + ' ' + Package."Ship-to ZIP Code", 1, 50);
                'SHIP_CODE':
                    TempLabelValue."Print Value" := FORMAT(Package."Ship-to Code");
                'SHIP_COUNTRY':
                    TempLabelValue."Print Value" := FORMAT(Package."Ship-to Country Code");
                'SHIP_DATE':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Shipment Date");
                    END;
                'SHIP_NAME':
                    TempLabelValue."Print Value" := FORMAT(Package."Ship-to Name");
                'SHIP_NAME2':
                    TempLabelValue."Print Value" := FORMAT(Package."Ship-to Name 2");
                'SHIP_STATE':
                    TempLabelValue."Print Value" := FORMAT(Package."Ship-to State");
                'SHIP_ZIP':
                    TempLabelValue."Print Value" := FORMAT(Package."Ship-to ZIP Code");
                'SID_NO':
                    BEGIN
                        IF NOT SalesHeaderLoaded THEN
                            LoadSalesHeader(Package, "Package Line");
                        IF TempSalesHeader."EDI Control No." = '' THEN
                            TempLabelValue."Print Value" := FORMAT(TempSalesHeader."No.")
                        ELSE
                            TempLabelValue."Print Value" := FORMAT(TempSalesHeader."EDI Control No.");
                    END;
                'SPEC_MARK':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Special Markings");
                    END;
                'STO_LOC':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Storage Location");
                    END;
                'STORE_ADDR':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Store Address");
                    END;
                'SUB_ROUTE':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Sub Route Number");
                    END;
                'SYS_DATE':
                    TempLabelValue."Print Value" := FORMAT(TODAY);
                'SYS_TIME':
                    TempLabelValue."Print Value" := FORMAT(TIME);
                'TOTAL_PCLS':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Total Parcels");
                    END;
                ELSE
                    ERROR('Field Code %1 not supported.', LabelContent."Field Code");
            END;

            TempLabelValue.INSERT();
        UNTIL LabelContent.NEXT() = 0;

        //print label
        LabelPrint(LabelHeader, PackingStation."Printer Name", FALSE, NoCopies);   //FALSE=No Preview
    end;

    procedure PrintPackageLabel(Package: Record 14000701; LabelHeaderCode: Code[10]; NoCopies: Integer; Posted: Boolean; UseLineNo: Integer; UseQty: Decimal)
    var
        Item: Record 27;
        LabelContent: Record 50006;
        "Package Line": Record 14000702;
        TempPackageLine: Record 14000702 temporary;
        PackingRule: Record 14000715;
        LabelHeader: Record 14000841;
        NoSeriesMgt: Codeunit 396;
        MasterLabelReqForm: Page 50060;
    begin
        CLEAR(Item);
        TempLabelValue.RESET();
        TempLabelValue.DELETEALL();

        //get Package station, make sure have printer name
        GetPackingStation();
        PackingStation.TESTFIELD("Printer Name");

        //get label, make sure fields exist and have format path
        LabelHeader.GET(LabelHeaderCode);
        LabelHeader.TESTFIELD("Format Path");
        IF NOT EXISTS(LabelHeader."Format Path") THEN
            ERROR('Format Path %1 not found.', LabelHeader."Format Path");
        LabelHeader.CALCFIELDS("No. of Fields");
        LabelHeader.TESTFIELD("No. of Fields");

        //init temp table
        TempLabelValue.DELETEALL();
        TempSalesHeader.DELETEALL();
        TempSalesLine.DELETEALL();
        TempItemCrossRef.DELETEALL;
        TempLotNoInfo.DELETEALL();

        ClearPackageVars();

        //summarize package lines
        //init temp table
        TempPackageLine.DELETEALL;
        IF Posted THEN
            SummarizePostedPackage(Package, TempPackageLine, UseLineNo)
        ELSE
            SummarizePackage(Package, TempPackageLine, UseLineNo);
        IF NOT TempPackageLine.FIND('-') THEN
            CLEAR(TempPackageLine);

        //>> 02/27/06
        IF UseQty = 0 THEN BEGIN
            CLEAR(MasterLabelReqForm);
            MasterLabelReqForm.SetFormValues(Package."No.", FORMAT(TempPackageLine.Type), TempPackageLine."No.",
                   TempPackageLine.Quantity, TempPackageLine.Description, Package."Ship-to No.", Package."Ship-to Code",
                     1, TempPackageLine.Quantity);
            COMMIT();
            IF MasterLabelReqForm.RUNMODAL() = ACTION::OK THEN
                MasterLabelReqForm.GetFormValues(UseQty, NoCopies)
            ELSE
                EXIT;
        END;

        TempPackageLine.Quantity := UseQty;
        MESSAGE('Qty %1 Copies %2', TempPackageLine.Quantity, NoCopies);
        //<< 02/27/06

        "Package Line" := TempPackageLine;

        //now get the label lines
        LabelContent.SETRANGE("Label Code", LabelHeader.Code);
        LabelContent.FIND('-');
        REPEAT
            TempLabelValue.INIT();
            TempLabelValue."Label Code" := LabelContent."Label Code";
            TempLabelValue."Field Code" := LabelContent."Field Code";

            CASE LabelContent."Field Code" OF
                'BOX_WT':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Box Weight");
                    END;
                'CERT_NO':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Certificate No.");
                    END;
                'CONTAINER_NO':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Container No.");
                    END;
                'CROSS_REF_DESC':
                    BEGIN
                        IF NOT ItemCrossRefLoaded THEN
                            LoadItemCrossRef(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempItemCrossRef.Description);
                    END;
                'CROSS_REF_NO':
                    BEGIN
                        IF NOT ItemCrossRefLoaded THEN
                            LoadItemCrossRef(Package, "Package Line");
                        //>> RTT 07-29-05 if ASN customer, use customer part number
                        IF TempItemCrossRef."Cross-Reference No." = '' THEN BEGIN
                            IF NOT SalesHeaderLoaded THEN
                                LoadSalesHeader(Package, "Package Line");
                            PackingRule.GetPackingRule(0, TempSalesHeader."Sell-to Customer No.", TempSalesHeader."Ship-to Code");  //0=customer
                            IF (PackingRule."ASN Summary Type" <> PackingRule."ASN Summary Type"::" ") THEN
                                TempItemCrossRef."Cross-Reference No." := "Package Line"."No.";
                        END;
                        //<< RTT 07-29-05 if ASN customer, use customer part number
                        TempLabelValue."Print Value" := FORMAT(TempItemCrossRef."Cross-Reference No.");
                    END;
                'CUST_NO':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Sell-to Customer No.");
                    END;
                'CUST_PO_NO':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."External Document No.");
                    END;
                'DEL_ORD_NO':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Delivery Order No.");
                    END;
                'DEL_TO':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Deliver To");
                    END;
                'DRAW_NO':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Drawing No.");
                    END;
                'DOCK_CODE':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Dock Code");
                    END;
                'ECN':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Eng. Change No.");
                    END;
                'EXT_DOC_NO':
                    TempLabelValue."Print Value" := FORMAT(Package."External Document No.");
                'FRS_NO':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."FRS No.");
                    END;
                'GROUP_CODE':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Group Code");
                    END;
                'ITEM_DESC':
                    TempLabelValue."Print Value" := "Package Line".Description;
                'ITEM_NO':
                    TempLabelValue."Print Value" := "Package Line"."No.";
                'KANBAN_NO':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Kanban No.");
                    END;
                'LN_SIDE_ADDR':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Line Side Address");
                    END;
                'LS_LOC':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Line Supply Location");
                    END;
                'LOT_NO':
                    TempLabelValue."Print Value" := "Package Line"."Lot No.";
                'LOT_CREATION':
                    BEGIN
                        IF NOT LotInfoLoaded THEN
                            LoadLotNoInfo(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempLotNoInfo."Lot Creation Date");
                    END;
                'MAN_NO':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Man No.");
                    END;
                'MAIN_ROUTE':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Main Route");
                    END;
                'MFG_DATE':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Mfg. Date");
                    END;
                'MFG_LOT_NO':

                    IF "Package Line"."Mfg. Lot No." = '' THEN BEGIN
                        IF NOT LotInfoLoaded THEN
                            LoadLotNoInfo(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempLotNoInfo."Mfg. Lot No.");
                    END
                    ELSE
                        TempLabelValue."Print Value" := "Package Line"."Mfg. Lot No.";
                'MODEL_YR':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Model Year");
                    END;
                'NET_WT':
                    TempLabelValue."Print Value" := FORMAT("Package Line"."Net Weight");
                'PICK_NO':
                    TempLabelValue."Print Value" := GetPackagePickNo(Package, "Package Line");
                'PLANT_CODE':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Plant Code");
                    END;
                'PURCH_ORD_NO':
                    BEGIN
                        IF NOT LotInfoLoaded THEN
                            LoadLotNoInfo(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempLotNoInfo."PO Number");
                    END;
                'QTY':
                    TempLabelValue."Print Value" := DELCHR(FORMAT("Package Line".Quantity), '=', ',');
                'RAN_NO':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Ran No.");
                    END;
                'REC_AREA':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Receiving Area");
                    END;
                'RELEASE_NO':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Release No.");
                    END;
                'RES_MFG':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Res. Mfg.");
                    END;
                'REV_DATE':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Revision Date");
                    END;
                'REV_NO':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Revision No.");
                    END;
                'REV_NO_LO':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Revision No. (Label Only)");
                    END;
                //>>IST 012609 CCL $12797 #12797
                //    'SALES_ORD_NO': TempLabelValue."Print Value" := Package."Sales Order No.";
                'SALES_ORD_NO':
                    TempLabelValue."Print Value" := Package."Source ID";
                //<<IST 012609 CCL $12797 #12797
                'SERIAL_NO':
                    BEGIN
                        LabelContent.TESTFIELD("No. Series");
                        TempLabelValue."Print Value" := FORMAT(NoSeriesMgt.GetNextNo(LabelContent."No. Series", TODAY, TRUE));
                        TempLabelValue."No. Series" := LabelContent."No. Series";
                    END;
                'SHIP_ADDR':
                    TempLabelValue."Print Value" := FORMAT(Package."Ship-to Address");
                'SHIP_ADDR2':
                    TempLabelValue."Print Value" := FORMAT(Package."Ship-to Address 2");
                'SHIP_CITY':
                    TempLabelValue."Print Value" := FORMAT(Package."Ship-to City");
                'SHIP_CITYSTZIP':
                    TempLabelValue."Print Value" :=
     COPYSTR(Package."Ship-to City" + ', ' + Package."Ship-to State" + ' ' + Package."Ship-to ZIP Code", 1, 50);
                'SHIP_CODE':
                    TempLabelValue."Print Value" := FORMAT(Package."Ship-to Code");
                'SHIP_COUNTRY':
                    TempLabelValue."Print Value" := FORMAT(Package."Ship-to Country Code");
                'SHIP_DATE':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Shipment Date");
                    END;
                'SHIP_NAME':
                    TempLabelValue."Print Value" := FORMAT(Package."Ship-to Name");
                'SHIP_NAME2':
                    TempLabelValue."Print Value" := FORMAT(Package."Ship-to Name 2");
                'SHIP_STATE':
                    TempLabelValue."Print Value" := FORMAT(Package."Ship-to State");
                'SHIP_ZIP':
                    TempLabelValue."Print Value" := FORMAT(Package."Ship-to ZIP Code");
                'SID_NO':
                    BEGIN
                        IF NOT SalesHeaderLoaded THEN
                            LoadSalesHeader(Package, "Package Line");
                        IF TempSalesHeader."EDI Control No." = '' THEN
                            TempLabelValue."Print Value" := FORMAT(TempSalesHeader."No.")
                        ELSE
                            TempLabelValue."Print Value" := FORMAT(TempSalesHeader."EDI Control No.");
                    END;
                'SPEC_MARK':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Special Markings");
                    END;
                'STO_LOC':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Storage Location");
                    END;
                'STORE_ADDR':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Store Address");
                    END;
                'SUB_ROUTE':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Sub Route Number");
                    END;
                'SYS_DATE':
                    TempLabelValue."Print Value" := FORMAT(TODAY);
                'SYS_TIME':
                    TempLabelValue."Print Value" := FORMAT(TIME);
                'TOTAL_PCLS':
                    BEGIN
                        IF NOT SalesLineLoaded THEN
                            LoadSalesLine(Package, "Package Line");
                        TempLabelValue."Print Value" := FORMAT(TempSalesLine."Total Parcels");
                    END;
                ELSE
                    ERROR('Field Code %1 not supported.', LabelContent."Field Code");
            END;

            TempLabelValue.INSERT();
        UNTIL LabelContent.NEXT() = 0;

        //print label
        LabelPrint(LabelHeader, PackingStation."Printer Name", FALSE, NoCopies);   //FALSE=No Preview
    end;

    procedure PrintContractLineLabel(ContractLine: Record 7002; LabelHeaderCode: Code[10]; NoCopies: Integer; UsePackingStation: Boolean)
    var
        ItemCrossRefl: Record 5717;
        LabelContent: Record 50006;
        ContractHeader: Record 50110;
        LabelHeader: Record 14000841;
    begin
        TempLabelValue.RESET();
        TempLabelValue.DELETEALL();

        //get Package station, make sure have printer name
        IF UsePackingStation THEN BEGIN
            GetPackingStation();
            PackingStation.TESTFIELD("Printer Name")
        END ELSE BEGIN
            GetReceiveStation();
            ReceiveStation.TESTFIELD("Printer Name");
        END;

        //get label, make sure fields exist and have format path
        LabelHeader.GET(LabelHeaderCode);
        LabelHeader.TESTFIELD("Format Path");
        IF NOT EXISTS(LabelHeader."Format Path") THEN
            ERROR('Format Path %1 not found.', LabelHeader."Format Path");
        LabelHeader.CALCFIELDS("No. of Fields");
        LabelHeader.TESTFIELD("No. of Fields");

        //init temp table
        TempLabelValue.DELETEALL();

        //set pointers
        IF NOT ContractHeader.GET(ContractLine."Contract No.") THEN
            CLEAR(ContractHeader);

        SETCURRENTKEY("Item No.", "Variant Code", "Unit of Measure", "Cross-Reference Type", "Cross-Reference Type No.");
        SETRANGE("Item No.", ContractLine."Item No.");
        SETRANGE("Cross-Reference Type", ItemCrossRefl."Cross-Reference Type"::Customer);
        SETRANGE("Cross-Reference Type No.", ContractLine."Sales Code");
        IF NOT FIND('-') THEN
            CLEAR(ItemCrossRefl);

        //now get the label lines
        LabelContent.SETRANGE("Label Code", LabelHeader.Code);
        LabelContent.FIND('-');
        REPEAT
            TempLabelValue.INIT();
            TempLabelValue."Label Code" := LabelContent."Label Code";
            TempLabelValue."Field Code" := LabelContent."Field Code";

            CASE LabelContent."Field Code" OF
                'CONTRACT_DESC':
                    TempLabelValue."Print Value" := ContractHeader.Description;
                'CONTRACT_NO':
                    TempLabelValue."Print Value" := ContractLine."Contract No.";
                'CONTRACT_LOC':
                    TempLabelValue."Print Value" := ContractLine."Contract Location Code";
                'CROSS_REF_DESC':
                    TempLabelValue."Print Value" := ItemCrossRefl.Description;
                'CROSS_REF_NO':
                    TempLabelValue."Print Value" := ItemCrossRefl."Cross-Reference No.";
                'CUST_BIN':
                    TempLabelValue."Print Value" := ContractLine."Customer Bin";
                'CUST_BIN_QTY':
                    TempLabelValue."Print Value" := DELCHR(FORMAT(ContractLine."Reorder Quantity"), '=', ',');
                'CUST_BIN_MAX':
                    TempLabelValue."Print Value" := FORMAT(ContractLine."Max. Quantity");
                'CUST_BIN_MIN':
                    TempLabelValue."Print Value" := FORMAT(ContractLine."Min. Quantity");
                'CUST_NO':
                    TempLabelValue."Print Value" := ContractLine."Sales Code";
                'CUST_PO_NO':
                    TempLabelValue."Print Value" := ContractHeader."External Document No.";
                'ITEM_DESC':
                    BEGIN
                        ContractLine.CALCFIELDS("Item Description");
                        TempLabelValue."Print Value" := ContractLine."Item Description";
                    END;
                'ITEM_NO':
                    TempLabelValue."Print Value" := ContractLine."Item No.";
                'REV_NO':
                    TempLabelValue."Print Value" := ContractLine."Revision No.";
                'SHIP_ADDR':
                    TempLabelValue."Print Value" := FORMAT(ContractHeader."Ship-to Address");
                ELSE
                    ERROR('Field Code %1 not supported.', LabelContent."Field Code");
            END;

            TempLabelValue.INSERT();
        UNTIL LabelContent.NEXT() = 0;

        //print label
        IF UsePackingStation THEN
            LabelPrint(LabelHeader, PackingStation."Printer Name", FALSE, NoCopies)   //FALSE=No Preview
        ELSE
            LabelPrint(LabelHeader, ReceiveStation."Printer Name", FALSE, NoCopies);   //FALSE=No Preview
    end;

    procedure LabelPrint(LabelHeader: Record 14000841; PrinterName: Text[250]; Preview: Boolean; NoCopies: Integer)
    begin
        //CLEAR(BtApplication);
        //CLEAR(BtFormat);
        CREATE(BtApplication, TRUE, TRUE);
        CREATE(BtFormat, TRUE, TRUE);
        //BtApplication.Visible(Preview);
        /*
        //get path of format
        FormatPath := LabelHeader."Format Path";
        
        //open format
        BtFormat := BtApplication.Formats.Open(FormatPath,FALSE,PrinterName);
        BtSubstrings := BtFormat.NamedSubStrings;
        
        //2 - set values
        TempLabelValue.FIND('-');
        REPEAT
           BtFormat.SetNamedSubStringValue(TempLabelValue."Field Code",TempLabelValue."Print Value");
        UNTIL TempLabelValue.NEXT=0;
        
        BtFormat.EnablePrompting(FALSE);
        
        //print label
        IF (NOT Preview) THEN
          FOR i := 1 TO NoCopies DO
            BEGIN
              //increment any no. series if additional copies
              IF i>1 THEN BEGIN
                TempLabelValue.SETFILTER("No. Series",'<>%1','');
                IF TempLabelValue.FIND('-') THEN
                  REPEAT
                    TempLabelValue."Print Value" := FORMAT(NoSeriesMgt.GetNextNo(TempLabelValue."No. Series",TODAY,TRUE));
                    BtFormat.SetNamedSubStringValue(TempLabelValue."Field Code",TempLabelValue."Print Value");
                  UNTIL TempLabelValue.NEXT=0;
              END;
              BtFormat.PrintOut(TRUE,FALSE);   //show print dialog
            END;
        */

        IF CONFIRM('Check BT Instance') THEN;
        //close application
        BtApplication.Quit(1);
        //BtApplication.stop();
        //CLEAR(BtApplication);
        //CLEAR(BtFormat);
        MESSAGE('Did BT close');
        EXIT;

    end;

    procedure ClearPackageVars()
    begin
        IF SalesHeaderLoaded THEN BEGIN
            CLEAR(SalesHeader);
            CLEAR(SalesHeaderLoaded);
        END;

        IF SalesLineLoaded THEN BEGIN
            CLEAR(SalesLine);
            CLEAR(SalesLineLoaded);
        END;

        IF ItemCrossRefLoaded THEN BEGIN
            CLEAR(ItemCrossRef);
            CLEAR(ItemCrossRefLoaded);
        END;

        IF LotInfoLoaded THEN
            CLEAR(LotInfoLoaded);
    end;

    procedure LoadSalesHeader(Package: Record 14000701; PackageLine: Record 14000702)
    begin
        //>>IST 012609 CCL $12797 #12797
        //IF NOT SalesHeader.GET(SalesHeader."Document Type"::Order,PackageLine."Sales Order No.") THEN
        IF NOT SalesHeader.GET(SalesHeader."Document Type"::Order, PackageLine."Source ID") THEN
            //<<IST 012609 CCL $12797 #12797
            //CCL012609  IF Package."Sales Shipment No."<>'' THEN
            //CCL012609    BEGIN
            //CCL012609      SalesShptLine.SETRANGE("Document No.",Package."Sales Shipment No.");
            //CCL012609      SalesShptLine.SETRANGE("Order No.",PackageLine."Sales Order No.");
            //CCL012609      SalesShptLine.SETRANGE("Order Line No.",PackageLine."Order Line No.");
            //CCL012609      SalesShptLine.FIND('-');
            //CCL012609      SalesShptHdr.GET(SalesShptLine."Document No.");
            //CCL012609      SalesHeader.TRANSFERFIELDS(SalesShptHdr);
            //CCL012609      SalesHeader."No." := SalesShptHdr."Order No.";
            //CCL012609    END;

            TempSalesHeader := SalesHeader;
        TempSalesHeader.INSERT();

        SalesHeaderLoaded := TRUE;
    end;

    procedure LoadSalesLine(Package: Record 14000701; PackageLine: Record 14000702)
    begin
        //>>IST 012609 CCL $12797 #12797
        //IF NOT SalesLine.GET(SalesLine."Document Type"::Order,PackageLine."Sales Order No.",PackageLine."Order Line No.") THEN
        IF NOT SalesLine.GET(SalesLine."Document Type"::Order, PackageLine."Source ID", PackageLine."Order Line No.") THEN
            // >> WC MH 05.01.09
            CLEAR(SalesLine);
        // << WC MH 05.01.09
        //<<IST 012609 CCL $12797 #12797
        //CCL012609    IF Package."Sales Shipment No."<>'' THEN
        //CCL012609      BEGIN
        //CCL012609        SalesShptLine.SETRANGE("Document No.",Package."Sales Shipment No.");
        //CCL012609        SalesShptLine.SETRANGE("Order No.",PackageLine."Sales Order No.");
        //CCL012609        SalesShptLine.SETRANGE("Order Line No.",PackageLine."Order Line No.");
        //CCL012609        SalesShptLine.FIND('-');
        //CCL012609        SalesLine.TRANSFERFIELDS(SalesShptLine);
        //CCL012609        SalesLine."Document No." := SalesShptLine."Order No.";
        //CCL012609      END;

        TempSalesLine := SalesLine;
        TempSalesLine.INSERT();

        SalesLineLoaded := TRUE;
    end;

    procedure LoadItemCrossRef(Package: Record 14000701; PackageLine: Record 14000702)
    var
        ItemCrossRef: Record 5717;
    begin
        //if not an item or valid cross reference, then exit
        IF (PackageLine.Type <> PackageLine.Type::Item) OR
            ((Package."Ship-to Type" <> Package."Ship-to Type"::Vendor) AND (Package."Ship-to Type" <> Package."Ship-to Type"::Customer)) THEN BEGIN
            ItemCrossRefLoaded := TRUE;
            EXIT;
        END;

        ItemCrossRef.SETRANGE("Item No.", PackageLine."No.");
        ItemCrossRef.SETRANGE("Variant Code", PackageLine."Variant Code");
        ItemCrossRef.SETRANGE("Unit of Measure", PackageLine."Unit of Measure Code");
        ItemCrossRef.SETRANGE("Cross-Reference Type", ItemCrossRef."Cross-Reference Type"::Customer);
        ItemCrossRef.SETRANGE("Cross-Reference Type No.", Package."Ship-to No.");

        //if cannot find, take off uom filter
        IF NOT ItemCrossRef.FIND('-') THEN
            ItemCrossRef.SETRANGE("Unit of Measure");

        IF NOT ItemCrossRef.FIND('-') THEN
            CLEAR(ItemCrossRef);

        TempItemCrossRef := ItemCrossRef;

        ItemCrossRefLoaded := TRUE;
    end;

    procedure LoadLotNoInfo(Package: Record 14000701; PackageLine: Record 14000702)
    var
        LotNoInfo: Record 6505;
    begin
        //if not an item or lot is blank, then exit
        IF (PackageLine.Type <> PackageLine.Type::Item) OR (PackageLine."Lot No." = '') THEN BEGIN
            LotInfoLoaded := TRUE;
            EXIT;
        END;

        IF NOT (LotNoInfo.GET(PackageLine."No.", PackageLine."Variant Code", PackageLine."Lot No.")) THEN BEGIN
            LotInfoLoaded := TRUE;
            EXIT;
        END;


        TempLotNoInfo := LotNoInfo;
        LotInfoLoaded := TRUE;
    end;

    procedure SummarizePackage(Package: Record 14000701; var TempPackageLine: Record 14000702 temporary; UseLineNo: Integer)
    var
        PackageLine: Record 14000702;
        PackageLine2: Record 14000702;
    begin
        PackageLine.RESET;
        PackageLine.SETRANGE("Package No.", Package."No.");
        IF (UseLineNo <> 0) AND (PackageLine2.GET(Package."No.", UseLineNo)) THEN BEGIN
            PackageLine.SETRANGE(Type, PackageLine2.Type);
            PackageLine.SETRANGE("No.", PackageLine2."No.");
        END;

        IF PackageLine.FIND('-') THEN
            REPEAT
                TempPackageLine.RESET;
                TempPackageLine.SETRANGE(Type, PackageLine.Type::Item);
                TempPackageLine.SETRANGE("No.", PackageLine."No.");
                IF TempPackageLine.FIND('-') THEN BEGIN
                    TempPackageLine.Quantity := TempPackageLine.Quantity + PackageLine.Quantity;
                    TempPackageLine."Net Weight" := TempPackageLine."Net Weight" + PackageLine."Net Weight";
                    TempPackageLine.MODIFY;
                END
                ELSE BEGIN
                    TempPackageLine.TRANSFERFIELDS(PackageLine);
                    TempPackageLine.INSERT;
                END;
            UNTIL PackageLine.NEXT = 0;
    end;

    procedure SummarizePostedPackage(Package: Record 14000701; var TempPackageLine: Record 14000702 temporary; UseLineNo: Integer)
    var
        PostedPackageLine: Record 14000705;
        PostedPackageLine2: Record 14000705;
    begin
        PostedPackageLine.RESET;
        PostedPackageLine.SETRANGE("Package No.", Package."No.");
        IF (UseLineNo <> 0) AND (PostedPackageLine2.GET(Package."No.", UseLineNo)) THEN BEGIN
            PostedPackageLine.SETRANGE(Type, PostedPackageLine2.Type);
            PostedPackageLine.SETRANGE("No.", PostedPackageLine2."No.");
        END;

        IF PostedPackageLine.FIND('-') THEN
            REPEAT
                TempPackageLine.RESET;
                TempPackageLine.SETRANGE(Type, PostedPackageLine.Type::Item);
                TempPackageLine.SETRANGE("No.", PostedPackageLine."No.");
                IF TempPackageLine.FIND('-') THEN BEGIN
                    TempPackageLine.Quantity := TempPackageLine.Quantity + PostedPackageLine.Quantity;
                    TempPackageLine."Net Weight" := TempPackageLine."Net Weight" + PostedPackageLine."Net Weight";
                    TempPackageLine.MODIFY;
                END
                ELSE BEGIN
                    TempPackageLine.TRANSFERFIELDS(PostedPackageLine);
                    TempPackageLine.INSERT;
                END;
            UNTIL PostedPackageLine.NEXT = 0;
    end;

    procedure PrintLabelsFromPick(WhseActvHdr: Record 5766)
    var
        Item: Record 27;
        Package: Record 14000701;
        PackageLine: Record 14000702;
        PackingRule: Record 14000715;
        LabelHeaderCode: Code[10];
        SNP: Decimal;
        UseQty: Decimal;
        NoCopies: Integer;
    begin

        CreatePackageFromPick(WhseActvHdr);

        //get label to use
        Package.GET(WhseActvHdr."No.");
        PackingRule.GetPackingRule(Package."Ship-to Type", Package."Ship-to No.", Package."Ship-to Code");
        LabelHeaderCode := PackingRule."Package Line Label Code";


        //loop through the lines of the package and print a label
        PackageLine.SETRANGE("Package No.", Package."No.");
        PackageLine.FIND('-');
        REPEAT
            //determine qty
            Item.GET(PackageLine."No.");
            SNP := Item."Units per Parcel";
            IF SNP <> 0 THEN BEGIN
                NoCopies := ROUND(PackageLine.Quantity / SNP, 1, '>');
                UseQty := SNP;
            END ELSE BEGIN
                NoCopies := 1;
                UseQty := PackageLine.Quantity;
            END;

            PrintPackageLineLabel(Package, PackageLine, LabelHeaderCode, UseQty, NoCopies);
        UNTIL PackageLine.NEXT = 0;

        //clean up
        Package.DELETE(TRUE);
    end;

    procedure PrintLabelsFromPostedPick(PostedInvtPickHdr: Record 7342)
    var
        Item: Record 27;
        PostedInvtPickLine: Record 7343;
        Package: Record 14000701;
        PackageLine: Record 14000702;
        PackingRule: Record 14000715;
        LabelHeaderCode: Code[10];
        UsePkgNo: Code[20];
        SNP: Decimal;
        UseQty: Decimal;
        NoCopies: Integer;
    begin
        UsePkgNo := PostedInvtPickHdr."No." + '[R]';

        PostedInvtPickLine.SETRANGE("No.", PostedInvtPickHdr."No.");
        PostedInvtPickLine.SETFILTER(Quantity, '<>0');
        IF PostedInvtPickLine.FIND('-') THEN
            REPEAT
                CreatePackageFromRegPickLine(PostedInvtPickLine, UsePkgNo);

                //get label to use
                IF NOT Package.GET(UsePkgNo) THEN
                    ERROR('No Packages found for this Pick.');

                PackingRule.GetPackingRule(Package."Ship-to Type", Package."Ship-to No.", Package."Ship-to Code");
                LabelHeaderCode := PackingRule."Package Line Label Code";

                PackageLine.SETRANGE("Package No.", Package."No.");
                PackageLine.FIND('-');

                //determine qty
                Item.GET(PackageLine."No.");
                SNP := Item."Units per Parcel";
                IF SNP <> 0 THEN BEGIN
                    NoCopies := ROUND(PackageLine.Quantity / SNP, 1, '>');
                    UseQty := SNP;
                END ELSE BEGIN
                    NoCopies := 1;
                    UseQty := PackageLine.Quantity;
                END;


                PrintPackageLineLabel(Package, PackageLine, LabelHeaderCode, UseQty, NoCopies);
            UNTIL PostedInvtPickLine.NEXT() = 0;
        //clean up
        Package.DELETE(TRUE);
    end;

    procedure PrintLabelsFromPickLine(WhseActvLine: Record 5767)
    var
        Item: Record 27;
        Package: Record 14000701;
        PackageLine: Record 14000702;
        PackingRule: Record 14000715;
        LabelMgt: Codeunit 14000841;
        LabelHeaderCode: Code[10];
        SNP: Decimal;
        UseQty: Decimal;
        NoCopies: Integer;
    begin

        CreatePackageFromPickLine(WhseActvLine);

        //get label to use
        Package.GET(WhseActvLine."No.");
        PackingRule.GetPackingRule(Package."Ship-to Type", Package."Ship-to No.", Package."Ship-to Code");
        LabelHeaderCode := PackingRule."Package Line Label Code";


        //find package line and print a label
        PackageLine.SETRANGE("Package No.", Package."No.");
        PackageLine.SETRANGE("No.", WhseActvLine."Item No.");
        PackageLine.SETRANGE("Lot No.", WhseActvLine."Lot No.");
        PackageLine.FIND('-');

        //determine qty
        Item.GET(PackageLine."No.");
        SNP := Item."Units per Parcel";

        IF SNP <> 0 THEN BEGIN
            NoCopies := ROUND(PackageLine.Quantity / SNP, 1, '>');
            UseQty := SNP;
        END ELSE BEGIN
            NoCopies := 1;
            UseQty := PackageLine.Quantity;
        END;

        LabelMgt.PrintPackageLineLabel(PackageLine, UseQty, UseQty, TRUE);


        //XPrintPackageLineLabel(Package,PackageLine,LabelHeaderCode,UseQty,NoCopies);

        //clean up
        Package.DELETE(TRUE);
    end;

    procedure PrintLabelsFromPostedPickLine(PostedInvtPickLine: Record 7343)
    var
        Item: Record 27;
        Package: Record 14000701;
        PackageLine: Record 14000702;
        PackingRule: Record 14000715;
        LabelMgt: Codeunit 14000841;
        LabelHeaderCode: Code[10];
        UsePkgNo: Code[20];
        SNP: Decimal;
        UseQty: Decimal;
        NoCopies: Integer;
    begin

        UsePkgNo := PostedInvtPickLine."No." + '[R]';
        CreatePackageFromRegPickLine(PostedInvtPickLine, UsePkgNo);

        //get label to use
        Package.GET(UsePkgNo);
        PackingRule.GetPackingRule(Package."Ship-to Type", Package."Ship-to No.", Package."Ship-to Code");
        LabelHeaderCode := PackingRule."Package Line Label Code";


        //find package line and print a label
        PackageLine.SETRANGE("Package No.", Package."No.");
        PackageLine.FIND('-');

        //determine qty
        Item.GET(PackageLine."No.");
        SNP := Item."Units per Parcel";

        IF SNP <> 0 THEN BEGIN
            NoCopies := ROUND(PackageLine.Quantity / SNP, 1, '>');
            UseQty := SNP;
        END ELSE BEGIN
            NoCopies := 1;
            UseQty := PackageLine.Quantity;
        END;

        LabelMgt.PrintPackageLineLabel(PackageLine, UseQty, UseQty, TRUE);

        //clean up
        Package.DELETE(TRUE);
    end;

    procedure CreatePackageFromPick(WhseActvHdr: Record 5766)
    var
        SalesSetup: Record 311;
        WhseActvLine: Record 5767;
        Package: Record 14000701;
        PackingControl: Record 14000717 temporary;
        PackageMgt: Codeunit 14000702;
    begin
        //make sure sales setup allows
        SalesSetup.GET();
        IF (NOT SalesSetup."Enable Shipping - Picks") THEN
            ERROR('Current configuration does not allow this function.');

        //delete, recreate package
        IF Package.GET(WhseActvHdr."No.") THEN
            Package.DELETE(TRUE);

        WhseActvLine.SETCURRENTKEY("Activity Type", "No.", "Sorting Sequence No.");
        WhseActvLine.SETRANGE("Activity Type", WhseActvHdr.Type);
        WhseActvLine.SETRANGE("No.", WhseActvHdr."No.");
        IF WhseActvLine.FIND('-') THEN BEGIN
            //create package
            //PackingControl."Warehouse Package No." := WhseActvHdr."No.";
            PackingControl."Tote No." := WhseActvHdr."No.";
            //>>IST 032009 CCL $12797 #12797
            //    PackingControl."Multi Document No." := WhseActvHdr."Source No.";
            PackingControl."Source Type" := 36;
            PackingControl."Source Subtype" := 1;
            PackingControl."Source ID" := WhseActvHdr."Source No.";
            //<<IST 032009 CCL $12797 #12797

            PackageMgt.CreatePackageNIF(Package, PackingControl);

            //begin loop
            REPEAT
                PackingControl."Input Type" := PackingControl."Input Type"::Item;
                PackingControl."Input No." := WhseActvLine."Item No.";
                PackingControl."Input Variant Code" := WhseActvLine."Variant Code";
                PackingControl."Input Unit of Measure Code" := WhseActvLine."Unit of Measure Code";
                PackingControl."Order Line No." := WhseActvLine."Source Line No.";
                PackingControl."Pack Lot Number" := (WhseActvLine."Lot No." <> '');
                PackingControl."Input Lot Number" := WhseActvLine."Lot No.";
                PackageMgt.CreatePackageLineNIF(Package, PackingControl, WhseActvLine.Quantity, FALSE);  //FALSE=no summary

                Package.GET(Package."No.");
                Package.ClearTotalValueFields;
                Package.TotalNetWeight;
            UNTIL WhseActvLine.NEXT() = 0;
        END;
    end;

    procedure CreatePackageFromPickLine(WhseActvLine: Record 5767)
    var
        SalesSetup: Record 311;
        WhseActvHdr: Record 5766;
        Package: Record 14000701;
        PackingControl: Record 14000717 temporary;
        PackageMgt: Codeunit 14000702;
    begin
        //<< used to print single line of labels >>

        //make sure sales setup allows
        SalesSetup.GET();
        IF (NOT SalesSetup."Enable Shipping - Picks") THEN
            ERROR('Current configuration does not allow this function.');

        //delete, recreate package
        WhseActvHdr.GET(WhseActvLine."Activity Type", WhseActvLine."No.");
        IF Package.GET(WhseActvHdr."No.") THEN
            Package.DELETE(TRUE);


        //create package
        PackingControl."Tote No." := WhseActvHdr."No.";
        //>>IST 032009 CCL $12797 #12797
        //PackingControl."Multi Document No." := WhseActvHdr."Source No.";
        PackingControl."Source Type" := 36;
        PackingControl."Source Subtype" := 1;
        PackingControl."Source ID" := WhseActvHdr."Source No.";
        //<<IST 032009 CCL $12797 #12797
        PackageMgt.CreatePackageNIF(Package, PackingControl);

        //create package line
        PackingControl."Input Type" := PackingControl."Input Type"::Item;
        PackingControl."Input No." := WhseActvLine."Item No.";
        PackingControl."Input Variant Code" := WhseActvLine."Variant Code";
        PackingControl."Input Unit of Measure Code" := WhseActvLine."Unit of Measure Code";
        PackingControl."Order Line No." := WhseActvLine."Source Line No.";
        PackingControl."Pack Lot Number" := (WhseActvLine."Lot No." <> '');
        PackingControl."Input Lot Number" := WhseActvLine."Lot No.";
        PackageMgt.CreatePackageLineNIF(Package, PackingControl, WhseActvLine.Quantity, FALSE);  //FALSE=No Summary

        Package.GET(Package."No.");
        Package.ClearTotalValueFields;
        Package.TotalNetWeight;
    end;

    procedure CreatePackageFromRegPick(PostedInvtPickHdr: Record 7342)
    var
        SalesShptHdr: Record 110;
        PostedInvtPickLine: Record 7343;
        Package: Record 14000701;
        PackageLine: Record 14000702;
        PostedPackage: Record 14000704;
        PostedPackageLine: Record 14000705;
        PackingRule: Record 14000715;
        PackingControl: Record 14000717 temporary;
        Shipping: Codeunit 14000701;
        PackageMgt: Codeunit 14000702;
        Summary: Boolean;
    begin
        //delete, recreate package
        IF PostedPackage.GET(PostedInvtPickHdr."No.") THEN
            PostedPackage.DELETE(TRUE);

        IF Package.GET(PostedInvtPickHdr."No.") THEN BEGIN
            IF Package.Closed THEN
                Shipping.OpenPackage(Package);
            Package.DELETE(TRUE);
        END;

        SalesShptHdr.GET(PostedInvtPickHdr."Source No.");
        //determine if summarized
        PackingRule.GetPackingRule(0, SalesShptHdr."Sell-to Customer No.", SalesShptHdr."Ship-to Code");
        Summary := (PackingRule."ASN Summary Type" <> PackingRule."ASN Summary Type"::" ");

        PostedInvtPickLine.SETCURRENTKEY("No.", "Sorting Sequence No.");
        PostedInvtPickLine.SETRANGE("No.", PostedInvtPickHdr."No.");
        IF PostedInvtPickLine.FIND('-') THEN BEGIN
            //create package
            PackingControl."Tote No." := PostedInvtPickHdr."No.";
            //>>IST 012609 CCL $12797 #12797
            //    PackingControl."Multi Document No." := SalesShptHdr."Order No.";
            PackingControl."Source Type" := 36;
            PackingControl."Source Subtype" := 1;
            PackingControl."Source ID" := SalesShptHdr."Order No.";
            IF PackingControl."Multi Document Package" THEN BEGIN
                Package."Multi Document Package" := TRUE;
                PackingControl."Multi Document No." := SalesShptHdr."Order No.";
            END;
            //<<IST 012609 CCL $12797 #12797

            IF NOT PackageMgt.CreatePackageNIF(Package, PackingControl) THEN BEGIN
                MESSAGE('%1', PackingControl."Error Message");
                EXIT;
            END;

            //begin loop
            REPEAT
                PackingControl."Input Type" := PackingControl."Input Type"::Item;
                PackingControl."Input No." := PostedInvtPickLine."Item No.";
                PackingControl."Input Variant Code" := PostedInvtPickLine."Variant Code";
                PackingControl."Input Unit of Measure Code" := PostedInvtPickLine."Unit of Measure Code";
                PackingControl."Order Line No." := PostedInvtPickLine."Source Line No.";
                PackingControl."Pack Lot Number" := (PostedInvtPickLine."Lot No." <> '');
                PackingControl."Input Lot Number" := PostedInvtPickLine."Lot No.";

                IF NOT PackageMgt.CreatePackageLineNIF(Package, PackingControl, PostedInvtPickLine.Quantity, Summary) THEN BEGIN
                    MESSAGE('%1', PackingControl."Error Message");
                    EXIT;
                END;

                Package.GET(Package."No.");
                Package.ClearTotalValueFields;
                Package.TotalNetWeight;
            UNTIL PostedInvtPickLine.NEXT() = 0;
        END;


        //close package
        Shipping.ClosePackage(Package, FALSE);

        //transfer fields to posted package
        PostedPackage.INIT;
        PostedPackage.TRANSFERFIELDS(Package);
        //>>IST 032409 CCL $12797 #12797
        //PostedPackage."Sales Shipment No." := PostedInvtPickHdr."Source No.";
        PostedPackage."Posted Source ID" := PostedInvtPickHdr."Source No.";
        //<<IST 032409 CCL $12797 #12797
        PostedPackage."Posting Date" := SalesShptHdr."Posting Date";
        PostedPackage."Packing Date" := WORKDATE();
        PostedPackage.INSERT;

        PackageLine.SETRANGE("Package No.", Package."No.");
        IF PackageLine.FIND('-') THEN
            REPEAT
                PostedPackageLine.INIT;
                PostedPackageLine.TRANSFERFIELDS(PackageLine);
                //>>IST 032409 CCL $12797 #12797
                //     PostedPackageLine."Sales Shipment No." := PostedPackage."Sales Shipment No.";
                PostedPackageLine."Posted Source ID" := PostedPackage."Posted Source ID";
                //<<IST 032409 CCL $12797 #12797
                PostedPackageLine.INSERT;
            UNTIL PackageLine.NEXT = 0;

        IF Package.Closed THEN
            Shipping.OpenPackage(Package);
        Package.DELETE(TRUE);
    end;

    procedure CreatePackageFromSalesShpt(SalesShptHdr: Record 110; Summary: Boolean)
    var
        ItemLedgeEntry: Record 32;
        SalesShptLine: Record 111;
        ItemEntryRelation: Record 6507;
        PostedInvtPickHdr: Record 7342;
        Package: Record 14000701;
        PackageLine: Record 14000702;
        PostedPackage: Record 14000704;
        PostedPackageLine: Record 14000705;
        PackingControl: Record 14000717 temporary;
        Shipping: Codeunit 14000701;
        PackageMgt: Codeunit 14000702;
    begin
        //if a posted pick exists for this shipment, with a posted package, then exit
        PostedInvtPickHdr.SETRANGE("Source No.", SalesShptHdr."No.");
        IF PostedInvtPickHdr.FIND('-') THEN
            IF PostedPackage.GET(PostedInvtPickHdr."No.") THEN
                EXIT;

        //delete, recreate package
        IF PostedPackage.GET(SalesShptHdr."No.") THEN
            PostedPackage.DELETE(TRUE);

        IF Package.GET(SalesShptHdr."No.") THEN BEGIN
            IF Package.Closed THEN
                Shipping.OpenPackage(Package);
            Package.DELETE(TRUE);
        END;

        SalesShptLine.SETRANGE("Document No.", SalesShptHdr."No.");
        SalesShptLine.SETRANGE(Type, SalesShptLine.Type::Item);
        SalesShptLine.SETFILTER(Quantity, '<>0');

        IF SalesShptLine.FIND('-') THEN BEGIN
            //create package
            PackingControl."Tote No." := SalesShptHdr."No.";
            PackingControl."Multi Document No." := SalesShptHdr."Order No.";

            IF NOT PackageMgt.CreatePackageNIF(Package, PackingControl) THEN BEGIN
                MESSAGE('%1', PackingControl."Error Message");
                EXIT;
            END;

            REPEAT
                PackingControl."Input Type" := PackingControl."Input Type"::Item;
                PackingControl."Input No." := SalesShptLine."No.";
                PackingControl."Input Variant Code" := SalesShptLine."Variant Code";
                PackingControl."Input Unit of Measure Code" := SalesShptLine."Unit of Measure Code";
                PackingControl."Order Line No." := SalesShptLine."Order Line No.";

                //use entry relation if found, otherwise use sales shipment line record
                ItemEntryRelation.SETCURRENTKEY(
                   "Source ID", "Source Type", "Source Subtype", "Source Ref. No.", "Source Prod. Order Line", "Source Batch Name");
                ItemEntryRelation.SETRANGE("Source ID", SalesShptHdr."No.");
                ItemEntryRelation.SETRANGE("Source Type", DATABASE::"Sales Shipment Line");
                ItemEntryRelation.SETRANGE("Source Ref. No.", SalesShptLine."Line No.");
                IF ItemEntryRelation.FIND('-') THEN
                    REPEAT
                        PackingControl."Pack Lot Number" := (ItemEntryRelation."Lot No." <> '');
                        PackingControl."Input Lot Number" := ItemEntryRelation."Lot No.";
                        ItemLedgeEntry.GET(ItemEntryRelation."Item Entry No.");
                        IF NOT PackageMgt.CreatePackageLineNIF(Package, PackingControl, -ItemLedgeEntry.Quantity, Summary)
                        THEN BEGIN
                            MESSAGE('%1', PackingControl."Error Message");
                            EXIT;
                        END;
                    UNTIL ItemEntryRelation.NEXT() = 0
                ELSE BEGIN
                    PackingControl."Pack Lot Number" := FALSE;
                    PackingControl."Input Lot Number" := '';
                    IF NOT PackageMgt.CreatePackageLineNIF(Package, PackingControl, SalesShptLine.Quantity, Summary) THEN BEGIN
                        MESSAGE('%1', PackingControl."Error Message");
                        EXIT;
                    END;
                END;

                Package.GET(Package."No.");
                Package.ClearTotalValueFields;
                Package.TotalNetWeight;

            UNTIL SalesShptLine.NEXT() = 0;
        END;


        //close package
        Shipping.ClosePackage(Package, FALSE);

        //transfer fields to posted package
        PostedPackage.INIT;
        PostedPackage.TRANSFERFIELDS(Package);
        //CCL012609PostedPackage."Sales Shipment No." := SalesShptHdr."No.";
        PostedPackage."Posting Date" := SalesShptHdr."Posting Date";
        PostedPackage."Packing Date" := WORKDATE();
        PostedPackage.INSERT;

        // PackageLine.SETRANGE("Package No.", Package."No.");//TODO
        IF PackageLine.FIND('-') THEN
            REPEAT
                PostedPackageLine.INIT;
                PostedPackageLine.TRANSFERFIELDS(PackageLine);
                //CCL012609       PostedPackageLine."Sales Shipment No." := PostedPackage."Sales Shipment No.";
                PostedPackageLine.INSERT;
            UNTIL PackageLine.NEXT = 0;

        IF Package.Closed THEN
            Shipping.OpenPackage(Package);
        Package.DELETE(TRUE);
    end;

    procedure CreatePackageFromRegPickLine(PostedInvtPickLine: Record 7343; UsePkgNo: Code[20])
    var
        SalesShptHdr: Record 110;
        PostedInvtPickHdr: Record 7342;
        Package: Record 14000701;
        PackingControl: Record 14000717 temporary;
        PackageMgt: Codeunit 14000702;
    begin
        //delete, recreate package
        PostedInvtPickHdr.GET(PostedInvtPickLine."No.");

        IF Package.GET(UsePkgNo) THEN
            Package.DELETE(TRUE);

        SalesShptHdr.GET(PostedInvtPickHdr."Source No.");
        PackingControl."Tote No." := UsePkgNo;
        PackingControl."Multi Document No." := SalesShptHdr."Order No.";
        IF NOT PackageMgt.CreatePackageNIF(Package, PackingControl) THEN BEGIN
            MESSAGE('%1', PackingControl."Error Message");
            EXIT;
        END;

        PackingControl."Input Type" := PackingControl."Input Type"::Item;
        PackingControl."Input No." := PostedInvtPickLine."Item No.";
        PackingControl."Input Variant Code" := PostedInvtPickLine."Variant Code";
        PackingControl."Input Unit of Measure Code" := PostedInvtPickLine."Unit of Measure Code";
        PackingControl."Order Line No." := PostedInvtPickLine."Source Line No.";
        PackingControl."Pack Lot Number" := (PostedInvtPickLine."Lot No." <> '');
        PackingControl."Input Lot Number" := PostedInvtPickLine."Lot No.";

        IF NOT PackageMgt.CreatePackageLineNIF(Package, PackingControl, PostedInvtPickLine.Quantity, FALSE) THEN BEGIN
            MESSAGE('%1', PackingControl."Error Message");
            EXIT;
        END;
    end;

    procedure GetPackagePickNo(PackageHdr: Record 14000701; PackageLine: Record 14000702) PickNo: Code[20]
    var
        WhseActvHdr: Record 5766;
        WhseActvLine: Record 5767;
    begin
        //if have shipment no., then is posted
        //CCL012609  IF PackageHdr."Sales Shipment No."<>'' THEN BEGIN
        //CCL012609    PostedInvtPickHdr.SETRANGE("Source No.",PackageHdr."Sales Shipment No.");
        //CCL012609    IF PostedInvtPickHdr.FIND('-') THEN
        //CCL012609      PickNo := PostedInvtPickHdr."Invt Pick No.";
        //CCL012609    EXIT;
        //CCL012609  END;


        //unposted..
        //first try match on ord no and line
        WhseActvLine.SETCURRENTKEY("Source Type", "Source Subtype", "Source No.", "Source Line No.", "Source Subline No.");
        WhseActvLine.SETRANGE("Source Type", DATABASE::"Sales Line");
        WhseActvLine.SETRANGE("Source Subtype", 1);
        //>>IST 012609 CCL $12797 #12797
        //WhseActvLine.SETRANGE("Source No.",PackageLine."Sales Order No.");
        WhseActvLine.SETRANGE("Source No.", PackageLine."Source ID");
        //<<IST 012609 CCL $12797 #12797
        WhseActvLine.SETRANGE("Source Line No.", PackageLine."Order Line No.");
        WhseActvLine.SETFILTER("Activity Type", '%1|%2', WhseActvLine."Activity Type"::"Invt. Pick", WhseActvLine."Activity Type"::Pick);
        IF WhseActvLine.FIND('-') THEN BEGIN
            PickNo := WhseActvLine."No.";
            EXIT;
        END;

        //next try match strictly by order no.
        WhseActvHdr.SETCURRENTKEY("Source Document", "Source No.", "Location Code");
        WhseActvHdr.SETRANGE("Source Document", WhseActvHdr."Source Document"::"Sales Order");
        //>>IST 012609 CCL $12797 #12797
        //WhseActvHdr.SETRANGE("Source No.",PackageLine."Sales Order No.");
        WhseActvHdr.SETRANGE("Source No.", PackageLine."Source ID");
        //<<IST 012609 CCL $12797 #12797
        WhseActvHdr.SETFILTER(Type, '%1|%2', WhseActvHdr.Type::"Invt. Pick", WhseActvHdr.Type::Pick);
        IF WhseActvHdr.FIND('-') THEN
            PickNo := WhseActvHdr."No."
        ELSE
            PickNo := '';
    end;
}

