pageextension 50030 "Item Card Ext" extends "Item Card"
{
    layout
    {
        moveafter(Description; "Description 2")
        modify("Automatic Ext. Texts")
        {
            CaptionML = ENU = 'Weeks';
        }
        moveafter("Item Category Code"; "Last Date Modified")
        addafter("Last Date Modified")
        {
            field("Units per Parcel"; Rec."Units per Parcel")
            {
                ApplicationArea = All;
            }
            field("Parts per Pallet"; Rec."Parts per Pallet")
            {
                ApplicationArea = All;
            }
            field("IMDS No."; Rec."IMDS No.")
            {
                ApplicationArea = All;
            }
        }
        modify(Blocked)
        {
            Visible = FALSE;
            trigger OnBeforeValidate()
            BEGIN
                //>>NV
                CheckReqFields(FALSE);
                //<<NV
            END;
        }
        addafter(PreventNegInventoryDefaultNo)
        {
            field(National; Rec.National)
            {
                ApplicationArea = All;
            }
        }
        addafter("Unit Price")
        {
            field("Unit List Price"; Rec."Unit List Price")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Tax Group Code"; "Inventory Value Zero")
        moveafter("Purch. Unit of Measure"; "Lead Time Calculation", "Gross Weight", "Net Weight")
        modify("Stockkeeping Unit Exists")
        {
            CaptionML = ENU = 'Weeks';
        }
        moveafter("Gross Weight"; "Manufacturer Code")
        addafter("Manufacturer Code")
        {
            field("HS Tariff Code"; Rec."HS Tariff Code")
            {
                Visible = "HS Tariff CodeVisible";
                ApplicationArea = All;
                trigger OnValidate()
                BEGIN
                    HSTariffCodeOnAfterValidate;
                END;
            }
            field("HS Tariff Description"; Rec."HS Tariff Description")
            {
                DrillDown = false;
                Visible = "HS Tariff DescriptionVisible";
                ApplicationArea = All;
            }
            field("Material Type"; Rec."Material Type")
            {
                Visible = "Material TypeVisible";
                ApplicationArea = All;
            }
            field("Material Finish"; Rec."Material Finish")
            {
                ApplicationArea = All;
            }
            field("HS Code"; Rec."HS Code")
            {
                ApplicationArea = All;
            }
            field("Carton Weight"; Rec."Carton Weight")
            {
                ApplicationArea = All;
            }
        }
        addlast(content)
        {
            group(QC)
            {
                Caption = 'QC';
                field("Require Revision No."; Rec."Require Revision No.")
                {
                    ApplicationArea = All;
                }
            }
        }
        moveafter("Require Revision No."; "Item Category Code")
        addafter("Item Category Code")
        {
            field(SEMS; Rec.SEMS)
            {
                ApplicationArea = All;
            }
            field(Diameter; Rec.Diameter)
            {
                ApplicationArea = All;
            }
            field(Length; Rec.Length)
            {
                ApplicationArea = All;
            }
        }
        addafter(QC)
        {
            group("E-Ship")
            {

            }
        }
        moveafter("E-Ship"; "Net Weight", "Gross Weight", "Unit Volume")
        addafter("E-Ship")
        {
            group(Forecast_)
            {
                Caption = 'Forecast';
            }
        }
        moveafter(Forecast_; "No.")
        addafter("No.")
        {
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field("Forecast on/off"; rec."Forecast on/off")
            {
                ApplicationArea = All;
            }
            field("Minimum Inventory Level"; rec."Minimum Inventory Level")
            {
                ApplicationArea = All;
            }
            field("Maximum Inventory Level"; Rec."Maximum Inventory Level")
            {
                ApplicationArea = All;
            }
            field("Lead Time"; Rec."Lead Time")
            {
                ApplicationArea = All;
            }
            field("Order Qty."; Rec."Order Qty.")
            {
                ApplicationArea = All;
            }
            field("Shipping Agent Code"; Rec."Shipping Agent Code")
            {
                ApplicationArea = All;
            }
            field("Free Form"; Rec."Free Form")
            {
                ApplicationArea = All;
            }
            field("Purchasing Policy"; Rec."Purchasing Policy")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addbefore(Navigation_Item)
        {
            group("&NewVision")
            {
                CaptionML = ENU = '&NewVision';
                Visible = false;
                Enabled = false;
                action("Report Attachments")
                {
                    CaptionML = ENU = 'Report Attachments';
                    Visible = FALSE;
                    Enabled = FALSE;
                }
                action("Soft Block")
                {
                    CaptionML = ENU = 'Soft Block';
                    Visible = FALSE;
                    Enabled = FALSE;
                }
                action("Inactive List")
                {
                    CaptionML = ENU = 'Inactive List';
                    Visible = FALSE;
                    Enabled = FALSE;
                }
            }
            group(QC_)
            {
                Caption = 'QC';
                action("Open Tasks")
                {
                    CaptionML = ENU = 'Open Tasks';
                    Visible = FALSE;
                    Enabled = FALSE;
                }
                action("Closed Tasks")
                {
                    CaptionML = ENU = 'Closed Tasks';
                    Visible = FALSE;
                    Enabled = FALSE;
                    trigger OnAction()
                    BEGIN
                        //>> NF1.00:CIS.CM 09-29-15
                        //QCItemTaskRec.SETRANGE("Item No.","No.");
                        //QCItemTaskRec.SETRANGE(Closed,TRUE);
                        //QCItemTaskForm.SETTABLEVIEW(QCItemTaskRec);
                        //QCItemTaskForm.EDITABLE(FALSE);
                        //QCItemTaskForm.RUN;
                        //<< NF1.00:CIS.CM 09-29-15
                    END;
                }
                action("New Request")
                {
                    CaptionML = ENU = 'New Request';
                    Visible = FALSE;
                    Enabled = FALSE;
                    trigger OnAction()
                    BEGIN
                        //>> NF1.00:CIS.CM 09-29-15
                        //IF NOT CONFIRM('Do you want to create a new QC Request?') THEN
                        //  ERROR('Operation Canceled');


                        //create document
                        //QCHeader.INIT;
                        //QCHeader."Document Type" := QCHeader."Document Type"::"0";
                        //QCHeader.VALIDATE("Item No.","No.");
                        //QCHeader.INSERT(TRUE);
                        //COMMIT;

                        //run form showing document
                        //QCHeader.SETRANGE("Document Type",QCHeader."Document Type");
                        //QCHeader.SETRANGE("No.",QCHeader."No.");
                        //PAGE.RUN(PAGE::Page37015300,QCHeader);
                        //<< NF1.00:CIS.CM 09-29-15
                    END;
                }
            }
        }
        modify("&Warehouse Entries")
        {
            Visible = false;
        }
        addafter("Item &Tracking Entries")
        {
            action("&Warehouse Entries New")
            {
                ApplicationArea = Warehouse;
                Caption = '&Warehouse Entries';
                Image = BinLedger;
                RunObject = Page "Warehouse Entries";
                RunPageLink = "Item No." = FIELD("No."),
                                  "Location Code" = FIELD("Location Filter"),
                                 "Lot No." = FIELD("Lot No. Filter"),
                                  "Bin Code" = FIELD("Bin Filter");
                RunPageView = sorting("Item No.", "Bin Code", "Location Code", "Variant Code", "Unit of Measure Code", "Lot No.", "Serial No.", "Entry Type", Dedicated);
                ToolTip = 'View the history of quantities that are registered for the item in warehouse activities. ';
            }
        }
        modify("Co&mments")
        {
            Visible = false;
        }
        addafter(Identifiers)
        {
            action("Co&mments New")
            {
                ApplicationArea = Comments;
                Caption = 'Co&mments';
                Image = ViewComments;
                RunObject = Page 50003;
                RunPageLink = "Table Name" = const(Item),
                                  "No." = field("No.");
                ToolTip = 'View or add comments for the record.';
            }
        }
        addafter("Return Orders")
        {
            action("Purchase Invoice Lines")
            {
                CaptionML = ENU = 'Purchase Invoice Lines';
                RunObject = Page 50059;
                RunPageLink = Type = FILTER(Item),
                                  "No." = FIELD("No.");
            }
        }
        addbefore("Prepa&yment Percentages")
        {
            action(CustItemDiscOverviewMenuOptn)
            {
                CaptionML = ENU = 'Cust./Item Disc. Overview';
                trigger OnAction()
                BEGIN
                    ShowCustItemDiscOverview;
                END;
            }
        }
        addafter("Prepa&yment Percentages")
        {
            action("&Sales Invoice Lines")
            {
                CaptionML = ENU = '&Sales Invoice Lines';
                RunObject = Page 50058;
                RunPageLink = Type = FILTER(Item),
                                 "No." = FIELD("No.");
            }
        }
        addafter("Stockkeepin&g Units")
        {
            action("Lot Bin Contents")
            {
                CaptionML = ENU = 'Lot Bin Contents';
                trigger OnAction()
                VAR
                    Item: Record 27;
                    ItemTrkgMgmt: Codeunit 6500;
                BEGIN
                    Item.GET(Rec."No.");
                    Item.COPYFILTERS(Rec);
                    ItemTrkgMgmt.LotBinContentLookup(Item);
                END;
            }
            action("Lot Listing")
            {
                CaptionML = ENU = 'Lot Listing';
                RunObject = Page 50024;
                RunPageLink = "Item No." = FIELD("No."),
                                  "Date Filter" = FIELD("Date Filter"),
                                  "Location Filter" = FIELD("Location Filter"),
                                  "Bin Filter" = FIELD("Bin Filter");
            }
            action("forecast")
            {
                CaptionML = ENU = 'forecast';
                RunObject = Report 50089;
            }
        }
        addafter(ApplyTemplate)
        {
            action("Item Reference List")
            {
                CaptionML = ENU = 'Item Reference List';
                RunObject = Page "Item Reference List";
                Promoted = true;
                PromotedCategory = Process;
            }
        }

    }
    var
        NVM: Codeunit 50021;
        Text19023983: Label 'Weeks';
        Text19062061: Label 'Units';
        Text19080001: Label 'Weeks';
        Text19080002: Label 'Weeks';
        Text19080003: Label 'Weeks';
        Text19080004: Label 'Units';
        "Material TypeVisible": Boolean;
        "Rework Process ItemVisible": Boolean;
        "HS Tariff CodeVisible": Boolean;
        "HS Tariff DescriptionVisible": Boolean;

    trigger OnOpenPage()
    begin
        //>>NIF 040406 RTT #10775
        IF STRPOS(COMPANYNAME, 'Mexi') = 0 THEN BEGIN
            "HS Tariff CodeVisible" := FALSE;
            "HS Tariff DescriptionVisible" := FALSE;
            "Material TypeVisible" := FALSE;
        END;
        //<<NIF 040406 RTT #10775
        OnActivateForm;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //>>NV
        CheckReqFields(TRUE);
        //<<NV
    end;

    trigger OnModifyRecord(): Boolean
    begin
        //>>NV
        CheckReqFields(FALSE);
        //<<NV
    end;

    trigger OnAfterGetCurrRecord()
    begin
        "Material TypeVisible" := TRUE;
        "HS Tariff DescriptionVisible" := TRUE;
        "HS Tariff CodeVisible" := TRUE;
        "Rework Process ItemVisible" := TRUE;
    end;


    LOCAL PROCEDURE OnActivateForm();
    BEGIN
        //>>NV4.32 03.31.04 JWW:
        IF NVM.TestPermission(14017931) THEN
            "Rework Process ItemVisible" := TRUE
        ELSE
            "Rework Process ItemVisible" := FALSE;
        //>>NV4.32 03.31.04 JWW:
    END;

    PROCEDURE CheckReqFields(HideMessage: Boolean);
    VAR
        RecRef: RecordRef;
    BEGIN
        RecRef.GETTABLE(Rec);
        Rec.Blocked := NVM.TestRequiredField(RecRef, COPYSTR(CurrPage.OBJECTID(FALSE), 6), HideMessage);
    END;

    PROCEDURE ShowCustItemDiscOverview();
    BEGIN
        //>> NF1.00:CIS.CM 09-29-15
        //CustItemDiscOverview.SetMatrixFilter("Item Disc. Group");
        //CustItemDiscOverview.RUNMODAL;
        //<< NF1.00:CIS.CM 09-29-15
    END;

    LOCAL PROCEDURE HSTariffCodeOnAfterValidate();
    BEGIN
        Rec.CALCFIELDS("HS Tariff Description");
    END;


}