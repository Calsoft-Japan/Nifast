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
            /* field("Rework Process Item"; Rec."Rework Process Item")
            {
                Visible = "Rework Process ItemVisible";
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Rework Process Item field.';
            } */

            field("Units per Parcel"; Rec."Units per Parcel")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Units per Parcel field.';
            }
            field("Parts per Pallet"; Rec."Parts per Pallet")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Parts per Pallet field.';
            }
            field("IMDS No."; Rec."IMDS No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the IMDS No. field.';
            }
        }
        addafter("Qty. on Service Order")
        {
            /*   field("Qty. on Blanket PO"; Rec."Qty. on Blanket PO")
              {
                  ApplicationArea = All;
                  ToolTip = 'Specifies the value of the Qty. on Blanket PO field.';
              }
              field("Qty. on Blanket SO"; Rec."Qty. on Blanket SO")
              {
                  ApplicationArea = All;
                  ToolTip = 'Specifies the value of the Qty. on Blanket SO field.';
              }
              field("Qty. on QC Hold"; Rec."Qty. on QC Hold")
              {
                  ApplicationArea = All;
                  ToolTip = 'Specifies the value of the Qty. on QC Hold field.';
              }
              field("Gross Inventory"; Rec."Gross Inventory")
              {
                  ApplicationArea = All;
                  ToolTip = 'Specifies the value of the Gross Inventory field.';
              }
              field(Inactive; Rec.Inactive)
              {
                  Editable = false;
                  ApplicationArea = All;
                  ToolTip = 'Specifies the value of the Inactive field.';
              } */
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
                ToolTip = 'Specifies the value of the National field.';
            }
        }
        addafter("Unit Price")
        {
            field("Unit List Price"; Rec."Unit List Price")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Unit List Price field.';
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
                ToolTip = 'Specifies the value of the HS Tariff Code field.';
                trigger OnValidate()
                BEGIN
                    HSTariffCodeOnAfterValidate();
                END;
            }
            field("HS Tariff Description"; Rec."HS Tariff Description")
            {
                DrillDown = false;
                Visible = "HS Tariff DescriptionVisible";
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the HS Tariff Description field.';
            }
            field("Material Type"; Rec."Material Type")
            {
                Visible = "Material TypeVisible";
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Material Type field.';
            }
            field("Material Finish"; Rec."Material Finish")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Material Finish field.';
            }
            field("HS Code"; Rec."HS Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the HS Code field.';
            }
            field("Carton Weight"; Rec."Carton Weight")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Carton Weight field.';
            }
        }
        addafter("Expiration Calculation")
        {/* 
            field("Item Group Code"; Rec."Item Group Code")
            {
                ToolTip = 'Specifies the value of the Item Group Code field.';
                ApplicationArea = All;
            }
            field("Tool Tracking"; Rec."Tool Tracking")
            {
                ToolTip = 'Specifies the value of the Tool Tracking field.';
                ApplicationArea = All;
            } */
        }
        addlast(content)
        {
            group(QC)
            {
                Caption = 'QC';

                /*   field("QC Hold"; Rec."QC Hold")
                  {
                      Caption = 'QC Hold';
                      ApplicationArea = All;
                      ToolTip = 'Specifies the value of the QC Hold field.';
                  }
                  field("QC Hold Reason Code"; Rec."QC Hold Reason Code")
                  {
                      Caption = 'QC Hold Reason Code';
                      ApplicationArea = All;
                      ToolTip = 'Specifies the value of the QC Hold Reason Code field.';
                  }
                  field("Inspection Type"; Rec."Inspection Type")
                  {
                      Caption = 'Inspection Type';
                      ApplicationArea = All;
                      ToolTip = 'Specifies the value of the Inspection Type field.';
                  }
                  field("Customer No."; Rec."Customer No.")
                  {
                      Caption = 'Customer No.';
                      ApplicationArea = All;
                      ToolTip = 'Specifies the value of the Customer No. field.';
                  } */
                field("Require Revision No."; Rec."Require Revision No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Require Revision No. field.';
                }
                //TODO
                /*  field("Revision No."; Rec."Revision No.")
                 {
                     Caption = 'Revision No.';
                     DrillDown = false;
                     ApplicationArea = All;
                     ToolTip = 'Specifies the value of the Revision No. field.';

                     trigger OnLookup(var Text: Text): Boolean;
                     var
                         CustItemDrawing: Record 50142;
                         ">>NIF_LV": Integer;
                     begin
                         //>> NIF 06-29-05 RTT
                         CustItemDrawing.RESET();
                         CustItemDrawing.SETRANGE("Item No.", Rec."No.");
                         CustItemDrawing.SETRANGE("Customer No.", '');
                         PAGE.RUN(0, CustItemDrawing);
                         Rec.CALCFIELDS("Drawing No.", "Revision No.", "Revision Date");
                         CurrPage.UPDATE(FALSE);
                         //<< NIF 06-29-05 RTT
                     end;
                 }
                //TODO
                /*  field("Revision Date"; Rec."Revision Date")
                 {
                     ApplicationArea = All;
                     ToolTip = 'Specifies the value of the Revision Date field.';
                 }
                 field("Drawing No."; Rec."Drawing No.")
                 {
                     ApplicationArea = All;
                     ToolTip = 'Specifies the value of the Drawing No. field.';
                 }
  */
                field("Item CategoryCode"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the category that the item belongs to. Item categories also contain any assigned item attributes.';
                }
            }
        }
        moveafter("Require Revision No."; "Item Category Code")
        addafter("Item Category Code")
        {
            field(SEMS; Rec.SEMS)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SEMS field.';
            }
            field(Diameter; Rec.Diameter)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Diameter field.';
            }
            field(Length; Rec.Length)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Length field.';
            }
        }
        addafter(QC)
        {
            group("E-Ship")
            {
                /*  field("Std. Pack Unit of Measure Code"; Rec."Std. Pack Unit of Measure Code")
                 {
                     ToolTip = 'Specifies the value of the Std. Pack Unit of Measure Code field.';
                     ApplicationArea = All;
                 }
                 field("Std. Packs per Package"; Rec."Std. Packs per Package")
                 {
                     ToolTip = 'Specifies the value of the Std. Packs per Package field.';
                     ApplicationArea = All;
                 }
                 field("E-Ship Tracking Code"; Rec."E-Ship Tracking Code")
                 {
                     Importance = Promoted;
                     ToolTip = 'Specifies the value of the E-Ship Tracking Code field.';
                     ApplicationArea = All;
                 }
                 field("Receive Rule Code"; Rec."Receive Rule Code")
                 {
                     Importance = Promoted;
                     ToolTip = 'Specifies the value of the Receive Rule Code field.';
                     ApplicationArea = All;
                 } */
                field("<Net Weight2>"; Rec."Net Weight")
                {
                    ToolTip = 'Specifies the net weight of the item.';
                    ApplicationArea = All;
                }
                field("<Gross Weight2>"; Rec."Gross Weight")
                {
                    ToolTip = 'Specifies the gross weight of the item.';
                    ApplicationArea = All;
                }
                /*  field("Dimmed Weight"; Rec."Dimmed Weight")
                 {
                     ToolTip = 'Specifies the value of the Dimmed Weight field.';
                     ApplicationArea = All;
                 } 
                field("Use Unit of Measure Dimensions"; Rec."Use Unit of Measure Dimensions")
                {
                    ToolTip = 'Specifies the value of the Use Unit of Measure Dimensions field.';
                    ApplicationArea = All;
                }
                field("Item UPC/EAN Number"; Rec."Item UPC/EAN Number")
                {
                    ToolTip = 'Specifies the value of the Item UPC/EAN Number field.';
                    ApplicationArea = All;
                }
                field("Always Enter Quantity"; Rec."Always Enter Quantity")
                {
                    ToolTip = 'Specifies the value of the Always Enter Quantity field.';
                    ApplicationArea = All;
                }
                field("LTL Freight Type"; Rec."LTL Freight Type")
                {
                    ToolTip = 'Specifies the value of the LTL Freight Type field.';
                    ApplicationArea = All;
                }
                field("Quantity Packed"; Rec."Quantity Packed")
                {
                    ToolTip = 'Specifies the value of the Quantity Packed field.';
                    ApplicationArea = All;
                }
                field("NMFC Code"; Rec."NMFC Code")
                {
                    ToolTip = 'Specifies the value of the NMFC Code field.';
                    ApplicationArea = All;
                }
                */
            }
        }
        moveafter("<Gross Weight2>"; "Unit Volume")
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
                ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
            }
            field("Forecast on/off"; rec."Forecast on/off")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Forecast on/off field.';
            }
            field("Minimum Inventory Level"; rec."Minimum Inventory Level")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Minimum Inventory Level field.';
            }
            field("Maximum Inventory Level"; Rec."Maximum Inventory Level")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Maximum Inventory Level field.';
            }
            field("Lead Time"; Rec."Lead Time")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Lead Time field.';
            }
            field("Order Qty."; Rec."Order Qty.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Order Qty. field.';
            }
            field("Shipping Agent Code"; Rec."Shipping Agent Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shipping Agent Code field.';
            }
            field("Free Form"; Rec."Free Form")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Free Form field.';
            }
            field("Purchasing Policy"; Rec."Purchasing Policy")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Purchasing Policy field.';
            }
        }
    }
    actions
    {
        addbefore(Navigation_Item)
        {
            /*  group("&NewVision")
             {
                 CaptionML = ENU = '&NewVision';
                 Visible = false;
                 Enabled = false;
                 action("Report Attachments")
                 {
                     CaptionML = ENU = 'Report Attachments';
                     Visible = FALSE;
                     Enabled = FALSE;
                     ToolTip = 'Executes the Report Attachments action.';
                 }
                 action("Soft Block")
                 {
                     CaptionML = ENU = 'Soft Block';
                     Visible = FALSE;
                     Enabled = FALSE;
                     ToolTip = 'Executes the Soft Block action.';
                 }
                 action("Inactive List")
                 {
                     CaptionML = ENU = 'Inactive List';
                     Visible = FALSE;
                     Enabled = FALSE;
                     ToolTip = 'Executes the Inactive List action.';
                 }
             } */
            /*   group(QC_)
              {
                  Caption = 'QC';
                  action("Open Tasks")
                  {
                      CaptionML = ENU = 'Open Tasks';
                      Visible = FALSE;
                      Enabled = FALSE;
                      ToolTip = 'Executes the Open Tasks action.';
                  }
                  action("Closed Tasks")
                  {
                      CaptionML = ENU = 'Closed Tasks';
                      Visible = FALSE;
                      Enabled = FALSE;
                      ToolTip = 'Executes the Closed Tasks action.';
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
                      ToolTip = 'Executes the New Request action.';
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
              } */
        }
        addafter(Identifiers)
        {
            /*   action("Barcode Conversion")
              {
                  Image = BarCode;
                  Caption = 'Barcode Conversion';
                  RunObject = Page 14000733;
                  RunPageLink = Type = CONST(Item),
                                "Item No." = FIELD("No.");
              }
              action("Customer Package UOM")
              {
                  Image = UnitOfMeasure;
                  Caption = 'Customer Package UOM';
                  RunObject = Page 14000728;
                  RunPageLink = "Item No." = FIELD("No.");
              } */
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
                Image = List;
                CaptionML = ENU = 'Purchase Invoice Lines';
                RunObject = Page 50059;
                RunPageLink = Type = FILTER(Item),
                                  "No." = FIELD("No.");
                ToolTip = 'Executes the Purchase Invoice Lines action.';
                ApplicationArea = All;
            }
        }
        addbefore("Prepa&yment Percentages")
        {
            action(CustItemDiscOverviewMenuOptn)
            {
                Image = Report;
                CaptionML = ENU = 'Cust./Item Disc. Overview';
                ToolTip = 'Executes the CustItemDiscOverviewMenuOptn action.';
                ApplicationArea = All;
                trigger OnAction()
                BEGIN
                    ShowCustItemDiscOverview();
                END;
            }
        }
        addafter("Prepa&yment Percentages")
        {
            action("&Sales Invoice Lines")
            {
                Image = List;
                CaptionML = ENU = '&Sales Invoice Lines';
                RunObject = Page 50058;
                RunPageLink = Type = FILTER(Item),
                                 "No." = FIELD("No.");
                ToolTip = 'Executes the &Sales Invoice Lines action.';
                ApplicationArea = All;
            }
        }
        addafter(Purchases)
        {
            /*  group("E-Ship")
             {
                 Caption = 'E-Ship';
                 action("International Shipping")
                 {
                     Caption = 'International Shipping';
                     RunObject = Page 14000687;
                     RunPageLink = "No." = FIELD("No.");
                 }
                 action("E-Ship Agent Options")
                 {
                     Caption = 'E-Ship Agent Options';

                     trigger OnAction();
                     var
                         Shipping: Codeunit 14000701;
                     begin
                         Shipping.ShowOptPageItemResource(DATABASE::Item, "No.");
                     end;
                 }
                 action("Required Shipping Agents")
                 {
                     Caption = 'Required Shipping Agents';
                     RunObject = Page 14000677;
                     RunPageLink = Type = CONST(Item),
                                   Code = FIELD("No.");
                 }
                 action("E-Ship Hazardous Material Card")
                 {
                     Caption = 'E-Ship Hazardous Material Card';
                     RunObject = Page 14050151;
                     RunPageLink = Type = CONST(Item),
                                  "No." = FIELD("No.");
                     RunPageView = SORTING(Type, "No.")
                                   ORDER(Ascending);
                 }
             } */
        }
        addafter("Stockkeepin&g Units")
        {
            action("Lot Bin Contents")
            {
                Image = List;
                CaptionML = ENU = 'Lot Bin Contents';
                ToolTip = 'Executes the Lot Bin Contents action.';
                ApplicationArea = All;
                trigger OnAction()
                VAR
                    Item: Record 27;
                    ItemTrkgMgmt: Codeunit 50178;
                BEGIN
                    Item.GET(Rec."No.");
                    Item.COPYFILTERS(Rec);
                    ItemTrkgMgmt.LotBinContentLookup(Item);
                END;
            }
            action("Lot Listing")
            {
                Image = List;
                CaptionML = ENU = 'Lot Listing';
                RunObject = Page 50024;
                RunPageLink = "Item No." = FIELD("No."),
                                  "Date Filter" = FIELD("Date Filter"),
                                  "Location Filter" = FIELD("Location Filter"),
                                  "Bin Filter" = FIELD("Bin Filter");
                ToolTip = 'Executes the Lot Listing action.';
                ApplicationArea = All;
            }
            action("forecast")
            {
                Image = Forecast;
                CaptionML = ENU = 'forecast';
               // RunObject = Report 50089;
                ToolTip = 'Executes the forecast action.';
                ApplicationArea = All;
            }
        }
        addafter(ApplyTemplate)
        {
            action("Item Reference List")
            {
                Image = List;
                CaptionML = ENU = 'Item Reference List';
                RunObject = Page "Item Reference List";
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Item Reference List action.';
                ApplicationArea = All;
            }
        }

    }
    var
        NVM: Codeunit 50021;
        /*     Text19023983: Label 'Weeks';
            Text19062061: Label 'Units';
            Text19080001: Label 'Weeks';
            Text19080002: Label 'Weeks';
            Text19080003: Label 'Weeks';
            Text19080004: Label 'Units';
     */
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
        OnActivateForm();
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
        // IF NVM.TestPermission(14017931) THEN
        //     "Rework Process ItemVisible" := TRUE
        // ELSE
        //     "Rework Process ItemVisible" := FALSE;
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