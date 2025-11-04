tableextension 50027 "Item Ext" extends "Item"
{
    //Version NAVW18.00,NAVNA8.00,SE0.55.09,NV4.35,NIF1.104,NMX1.000,NIF.N15.C9IN.001,AKK1606.01;
    fields
    {
        modify("Gross Weight")
        {
            trigger OnBeforeValidate()
            begin
                //>>CIS.RAM 11/14/20
                IF ("Gross Weight" <> 0) AND
                   ("Units per Parcel" <> 0)
                THEN
                    "Carton Weight" := ROUND("Units per Parcel" * "Gross Weight", 1, '>');
                //<<CIS.RAM 11/14/20
            END;
        }
        modify("Units per Parcel")
        {
            trigger OnBeforeValidate()
            begin
                //>>CIS.RAM 11/14/20
                IF ("Gross Weight" <> 0) AND
                   ("Units per Parcel" <> 0)
                THEN
                    "Carton Weight" := ROUND("Units per Parcel" * "Gross Weight", 1, '>');
                //<<CIS.RAM 11/14/20
            END;
        }
        modify("Gen. Prod. Posting Group")
        {
            trigger OnBeforeValidate()
            var
                // ">>NIF_LV": Integer;
                SalesLine: Record 37;
                PurchLine: Record 39;
            begin
                //>> NIF 06-12-05 RTT
                IF (xRec."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group") AND ("Gen. Prod. Posting Group" <> '') THEN BEGIN
                    SalesLine.RESET();
                    SalesLine.SETCURRENTKEY(Type, "No.");
                    SalesLine.SETRANGE(Type, SalesLine.Type::Item);
                    SalesLine.SETRANGE("No.", "No.");

                    PurchLine.RESET();
                    PurchLine.SETCURRENTKEY(Type, "No.");
                    PurchLine.SETRANGE(Type, PurchLine.Type::Item);
                    PurchLine.SETRANGE("No.", "No.");

                    IF (NOT SalesLine.ISEMPTY) OR (NOT PurchLine.ISEMPTY) THEN
                        IF CONFIRM('Do you want to update existing documents?') THEN BEGIN
                            SalesLine.MODIFYALL("Gen. Prod. Posting Group", "Gen. Prod. Posting Group");
                            PurchLine.MODIFYALL("Gen. Prod. Posting Group", "Gen. Prod. Posting Group");
                        END;
                END;
                //<< NIF 06-12-05 RTT
            end;
        }
        modify("Sales Unit of Measure")
        {
            TableRelation = IF ("No." = FILTER(<> '')) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."))
            ELSE
            "Unit of Measure";
        }
        modify("Purch. Unit of Measure")
        {
            TableRelation = IF ("No." = FILTER(<> '')) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."))
            ELSE
            "Unit of Measure";
        }
        modify("Item Category Code")
        {
            trigger OnAfterValidate()
            begin
                //TODO
                //>> NV
                SKU.RESET;
                SKU.SETRANGE("Item No.", "No.");
                SKU.MODIFYALL("Item Category Code", "Item Category Code");
                SKU.MODIFYALL("Product Group Code", "Item Group Code");
                //<< NV 
                //TODO
            end;
        }
        field(50000; "Require Revision No."; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Carton per Pallet"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Minimum Inventory Level"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Lead Time"; Decimal)
        {
            AutoFormatType = 0;
            DataClassification = ToBeClassified;
            InitValue = 0;
        }
        field(50005; "Maximum Inventory Level"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Order Qty."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Parts per Pallet"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Shipping Agent Code"; Code[20])
        {
            // cleaned
            CalcFormula = Lookup(Vendor."Shipping Agent Code" WHERE("No." = FIELD("Vendor No.")));
            FieldClass = FlowField;
        }
        field(50010; SEMS; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; Diameter; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; Length; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Carton Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Purchasing Policy"; Code[30])
        {
            FieldClass = Normal;
            DataClassification = ToBeClassified;
        }
        field(50029; "Forecast on/off"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50030; onoff; Boolean)
        {
            DataClassification = ToBeClassified;
            InitValue = true;
        }
        field(50031; "IMDS No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50032; "EC No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50033; "MPD Item"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50034; "MPD Forecast On/Off"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50035; "MPD Min"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50036; "MPD Max"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50037; "MPD LT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50038; "MPD Min Ord Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50039; "HS Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50040; "Free Form"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50802; National; Boolean)
        {
            Caption = 'National';
            DataClassification = ToBeClassified;
            Description = 'AKK1606.01';
        }
        field(60000; "HS Tariff Code"; Code[10])
        {
            TableRelation = "HS Tariff Code";
            DataClassification = ToBeClassified;
        }
        field(60001; "HS Tariff Description"; Text[30])
        {
            CalcFormula = Lookup("HS Tariff Code".Description WHERE(Code = FIELD("HS Tariff Code")));
            FieldClass = FlowField;
            Editable = false;
        }
        field(60005; Fraccion; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60008; "Material Type"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(60009; "Material Finish"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        //TODO

        /*  field(14000601; "Receive Rule Code"; Code[10])
         {
             TableRelation = "LAX Receive Rule";
             Caption = 'Receive Rule Code';
         }

         field(14000701; "Export License Required"; Boolean)
         {
             Caption = 'Export License Required';
         }

         field(14000703; "Dimmed Weight"; Decimal)
         {
             DecimalPlaces = 0 : 5;
             BlankZero = true;
             Caption = 'Dimmed Weight';
         }

         field(14000704; "Std. Pack Unit of Measure Code"; Code[10])
         {
             TableRelation = "Item Unit of Measure".Code where("Item No." = Field("No."));
             Caption = 'Std. Pack Unit of Measure Code';
         }

         field(14000705; "Std. Packs per Package"; Integer)
         {
             Caption = 'Std. Packs per Package';
         }

         field(14000708; "Always Enter Quantity"; Boolean)
         {
             Caption = 'Always Enter Quantity';
         }

         field(14000709; "Schedule B Code"; Code[10])
         {
             TableRelation = "LAX Schedule B Code".Code;
             Caption = 'Schedule B Code';
             trigger OnValidate()
             var
                 ScheduleBCode: Record "LAX Schedule B Code";
             begin
                 if "Schedule B Code" = '' then begin
                     "Schedule B Unit of Measure 1" := '';
                     "Schedule B Unit of Measure 2" := '';
                     "Schedule B Quantity 1" := 0;
                     "Schedule B Quantity 2" := 0;
                 end else begin
                     ScheduleBCode.Get("Schedule B Code");
                     "Schedule B Unit of Measure 1" := ScheduleBCode."Unit of Measure 1";
                     "Schedule B Unit of Measure 2" := ScheduleBCode."Unit of Measure 2";
                 end;
             end;
         }

         field(14000712; "Quantity Packed"; Decimal)
         {
             FieldClass = FlowField;
             CalcFormula = Sum("Package Line"."Quantity (Base)" where(Type = Const(Item), "No." = Field("No.")));
             DecimalPlaces = 0 : 5;
             Caption = 'Quantity Packed';
             Editable = false;
         }

         field(14000716; "E-Ship Tracking Code"; Code[10])
         {
             TableRelation = "LAX EShip Tracking Code".Code;
             Caption = 'E-Ship Tracking Code';
             trigger OnValidate()
             var
                 EShipTrackingCode: Record "LAX EShip Tracking Code";
                 ItemTrackingCode: Record "Item Tracking Code";
             begin
                 if "E-Ship Tracking Code" <> '' then begin
                     EShipTrackingCode.Get("E-Ship Tracking Code");
                     if EShipTrackingCode."Transfer Serial Numbers" or
                        EShipTrackingCode."Transfer Lot Numbers" or
                        EShipTrackingCode."Transfer Warranty Date" or
                        EShipTrackingCode."Transfer Expiration Date" or
                        EShipTrackingCode."Rec. Transfer Serial Numbers" or
                        EShipTrackingCode."Rec. Transfer Lot Numbers" or
                        EShipTrackingCode."Rec. Transfer Warranty Date" or
                        EShipTrackingCode."Rec. Transfer Expiration Date" then begin
                         TestField("Item Tracking Code");
                         ItemTrackingCode.Get("Item Tracking Code");
                     end;
                 end;
             end;
         }

         field(14000717; "Schedule B Quantity 1"; Decimal)
         {
             DecimalPlaces = 0 : 5;
             Caption = 'Schedule B Quantity 1';
         }

         field(14000718; "Schedule B Unit of Measure 1"; Code[10])
         {
             TableRelation = "LAX Schedule B Unit of Measure".Code;
             Caption = 'Schedule B Unit of Measure 1';
         }

         field(14000719; "Schedule B Quantity 2"; Decimal)
         {
             DecimalPlaces = 0 : 5;
             Caption = 'Schedule B Quantity 2';
         }

         field(14000720; "Schedule B Unit of Measure 2"; Code[10])
         {
             TableRelation = "LAX Schedule B Unit of Measure".Code;
             Caption = 'Schedule B Unit of Measure 2';
         }

         field(14000721; "Use Unit of Measure Dimensions"; Boolean)
         {
             Caption = 'Use Unit of Measure Dimensions';
         }

         field(14000722; "NMFC Code"; Code[10])
         {
             TableRelation = "LAX LTL Freight NMFC Code".Code;
             Caption = 'NMFC Code';
         }

         field(14000761; "Certificate of Origin No."; Code[10])
         {
             Caption = 'Certificate of Origin No.';
         }

         field(14000762; "Goods Not In Free Circulation"; Boolean)
         {
             Caption = 'Goods Not In Free Circulation';
         }

         field(14000782; "Export Control Class No."; Code[15])
         {
             TableRelation = "LAX Export Controls Class Number".Code;
             Caption = 'Export Control Class No.';
         }

         field(14000783; "Preference Criteria"; Option)
         {
             OptionCaption = ' ,A,B,C,D,E,F';
             OptionMembers = "",A,B,C,D,E,F;
             Caption = 'Preference Criteria';
         }

         field(14000784; "Producer of Good Indicator"; Option)
         {
             OptionCaption = ' ,YES,1,2,3';
             OptionMembers = " ",YES,"1","2","3";
             Caption = 'Producer of Good Indicator';
         }

         field(14000785; "RVC in Net Cost Method"; Boolean)
         {
             Caption = 'RVC in Net Cost Method';
         }

         field(14000801; "LTL Freight Type"; Code[10])
         {
             TableRelation = "LAX LTL Freight Type".Code;
             Caption = 'LTL Freight Type';
         }

         field(14000821; "Item UPC/EAN Number"; Code[20])
         {
             Caption = 'Item UPC/EAN Number';
             trigger OnValidate()
             begin
                 if not (StrLen("Item UPC/EAN Number") in [0, 12]) then
                     if not Confirm(Text14000701, false, FieldName("Item UPC/EAN Number")) then
                         Error(Text14000702);
             end;
         }
  */
        //TODO
        field(14017611; "Qty. on Blanket PO"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Purchase Line"."Outstanding Qty. (Base)" where(
        "Document Type" = Const("Blanket Order"),
        "Type" = Const(Item),
        "No." = Field("No."),
        "Shortcut Dimension 1 Code" = Field("Global Dimension 1 Filter"),
        "Shortcut Dimension 2 Code" = Field("Global Dimension 2 Filter"),
        "Location Code" = Field("Location Filter"),
        "Drop Shipment" = Field("Drop Shipment Filter"),
        "Variant Code" = Field("Variant Filter"),
        "Bin Code" = Field("Bin Filter"),
        "Expected Receipt Date" = Field("Date Filter")
    ));
            DecimalPlaces = 0 : 5;
            Editable = false;
        }

        field(70000; "Qty. on Blanket SO"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line"."Outstanding Qty. (Base)" where
    (
        "Document Type" = Const("Blanket Order"),
        "Type" = Const(Item),
        "No." = Field("No."),
        "Shortcut Dimension 1 Code" = Field("Global Dimension 1 Filter"),
        "Shortcut Dimension 2 Code" = Field("Global Dimension 2 Filter"),
        "Location Code" = Field("Location Filter"),
        "Drop Shipment" = Field("Drop Shipment Filter"),
        "Variant Code" = Field("Variant Filter"),
        "Bin Code" = Field("Bin Filter"),
        "Shipment Date" = Field("Date Filter")
    ));
            DecimalPlaces = 0 : 5;
            Editable = false;
        }

        field(70001; "Default Purchasing Code"; Code[10])
        {
            TableRelation = Purchasing.Code;
        }

        field(70002; "Inactive"; Boolean) { }
        field(70003; "Supply Item"; Boolean) { }
        field(70004; "Min. Sales Qty."; Decimal) { }
        field(70005; "Date Created"; Date) { }
        field(70006; "Harmonizing Tariff Code"; Code[20])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
        }

        field(70007; "Usage Velocity Code"; Code[10])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
            Editable = false;
        }

        field(70008; "Turn Ranking Code"; Code[10])
        {
            TableRelation = "Shipping Vessels"."Vessel Name";
            trigger OnValidate()
            begin
                SKU.Reset();
                SKU.SetRange("Item No.", "No.");
                SKU.ModifyAll("Turn Ranking Code", "Turn Ranking Code");
            end;
        }

        field(70009; "Customer Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = Customer."No.";
        }

        field(70010; "Item Group Code"; Code[10])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
        }

        field(70011; "Tool Tracking"; Boolean) { }

        field(70012; "Qty. on Prod. Kit"; Decimal)
        {
            FieldClass = FlowField;
            DecimalPlaces = 0 : 2;
            Description = 'NF1.00:CIS.CM 09-29-15';
            Editable = false;
        }

        field(70013; "Qty. on Prod. Kit Lines"; Decimal)
        {
            FieldClass = FlowField;
            DecimalPlaces = 0 : 2;
            Description = 'NF1.00:CIS.CM 09-29-15';
            Editable = false;
        }

        field(70014; "Rework Process Item"; Boolean) { }

        field(70015; "QC Hold"; Boolean)
        {
            trigger OnValidate()
            begin
                if not UserSetup.Get(UserId) then
                    Error('You are not set up as an authorized user to change the value of this field.');

                if (("QC Hold") and (not UserSetup."Edit QC Hold - On")) or
                   ((not "QC Hold") and (not UserSetup."Edit QC Hold - Off")) then
                    Error('You are not authorized to change the value of this field.');

                UpdateQCHoldFromItem("No.", "QC Hold");
            end;
        }

        field(70016; "QC Hold Reason Code"; Code[10])
        {
            TableRelation = "Reason Code" where(Type = Filter(QC));
        }

        field(70017; "Qty. on QC Hold"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry".Quantity where
    (
        "Item No." = Field("No."),
        "Global Dimension 1 Code" = Field("Global Dimension 1 Filter"),
        "Global Dimension 2 Code" = Field("Global Dimension 2 Filter"),
        "Location Code" = Field("Location Filter"),
        "Drop Shipment" = Field("Drop Shipment Filter"),
        "Variant Code" = Field("Variant Filter"),
        "Lot No." = Field("Lot No. Filter"),
        "Serial No." = Field("Serial No. Filter"),
        "QC Hold" = Const(true)));
            DecimalPlaces = 0 : 5;
            Caption = 'Qty. on QC Hold';
            Editable = false;
        }

        field(70018; "Gross Inventory"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry".Quantity where
    (
        "Item No." = Field("No."),
        "Global Dimension 1 Code" = Field("Global Dimension 1 Filter"),
        "Global Dimension 2 Code" = Field("Global Dimension 2 Filter"),
        "Location Code" = Field("Location Filter"),
        "Drop Shipment" = Field("Drop Shipment Filter"),
        "Variant Code" = Field("Variant Filter"),
        "Lot No." = Field("Lot No. Filter"),
        "Serial No." = Field("Serial No. Filter")
    ));
            DecimalPlaces = 0 : 5;
            Caption = 'Gross Inventory';
            Editable = false;
        }

        field(70019; "QS/TS Item"; Boolean) { }
        field(70020; "First Article Approval"; Boolean) { }
        field(70021; "PPAP Approval"; Boolean) { }

        field(70022; "Special Gauge/Fixture"; Code[20])
        {
            Description = 'NF1.00:CIS.NG  10-10-15';
        }

        field(70023; "First Article Waiver"; Boolean) { }

        field(70024; "Inspection Type"; Code[10])
        {
            Description = 'NF1.00:CIS.NG  10-10-15';
        }

        field(70025; "QC Comment"; Boolean)
        {
            FieldClass = FlowField;
            Caption = 'QC Comment';
            Description = 'NF1.00:CIS.CM 09-29-15';
            Editable = false;
        }

        field(70026; "Customer No."; Code[20])
        {
            TableRelation = "Item Reference"."Reference Type No." where
                    ("Item No." = Field("No."),
                     "Reference Type" = Filter(Customer));

            trigger OnLookup()
            begin
                ItemCrossReference.SetRange("Item No.", "No.");
                ItemCrossReference.SetRange("Reference Type", ItemCrossReference."Reference Type"::Customer);
                if Page.RunModal(Page::"Item Reference Entries", ItemCrossReference) = Action::LookupOK then
                    Validate("Customer No.", ItemCrossReference."Reference Type No.");
            end;
        }

        field(70027; "Drawing No."; Code[30])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Cust./Item Drawing2"."Drawing No." where
                        ("Item No." = Field("No."),
                         Active = Const(true),
                         "Customer No." = Filter('')));
            Editable = false;
        }

        field(70028; "Revision No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Cust./Item Drawing2"."Revision No." where
                        ("Item No." = Field("No."),
                         Active = Const(true),
                         "Customer No." = Filter('')));
            TableRelation = "Cust./Item Drawing2"."Revision No." where("Item No." = Field("No."));
            Editable = false;
        }

        field(70029; "Revision Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Cust./Item Drawing2"."Revision Date" where
                        ("Item No." = Field("No."),
                         Active = Const(true),
                         "Customer No." = Filter('')));
            Editable = false;
        }
        //TODO
        /*   field(14050001; "UPS ISC Type"; Option)
          {
              Caption = 'UPS ISC Type';
              OptionCaption = ' ,Seeds,Perishables,Tobacco,Plants,Alcoholic Beverages,Biological Substance,Special Exceptions';
              OptionMembers = "",Seeds,Perishables,Tobacco,Plants,"Alcoholic Beverages","Biological Substance","Special Exceptions";
          }
   */
        //TODO
    }

    var
        ItemCrossReference: Record 5777;
        SKU: Record "Stockkeeping Unit";
        UserSetup: Record 91;
        InventorySetup: Record "Inventory Setup";
        Item: Record 27;
        NVM: Codeunit 50021;
        HasInvtSetup: Boolean;
        Text14000701: Label '%1 is normally 12 digit, use this number anyway?';
        Text14000702: Label 'Nothing Changed.';

    trigger OnAfterInsert()
    begin
        National := TRUE; //-AKK1606.01++

        //TODO
        //>>NV
        "Date Created" := WORKDATE();
        //>> NF1.00:CIS.CM 09-29-15
        //IF NVM.TestPermission(14017859) THEN
        //MDM.CreateNotification('300',0,"No.",0,'',0,'');
        //<< NF1.00:CIS.CM 09-29-15

        // IF NVM.TestPermission(14018070) THEN BEGIN
        //     GetInvtSetup();
        //     "QC Hold" := InventorySetup."Default New Item QC Hold";
        //     "QC Hold Reason Code" := InventorySetup."New Item QC Reason Code";
        //     //QCMgmt.InsertNewQCItemTask(Rec); //NF1.00:CIS.CM 09-29-15
        // END;
        //<<NV 
        //TODO
    end;

    // trigger OnAfterDelete()
    // var
    //     SocialListeningSearchTopic: Record 871;
    // begin
    //     //TODO
    //     IF NOT SocialListeningSearchTopic.ISEMPTY THEN BEGIN
    //         SocialListeningSearchTopic.FindSearchTopic(SocialListeningSearchTopic."Source Type"::Item, "No.");
    //         SocialListeningSearchTopic.DELETEALL;
    //     END;
    //     //TODO

    //     //>>NV
    //     // >>NF1.00:CIS.CM 09-29-15
    //     //QCItemTask.SETRANGE("Item No.","No.");
    //     //IF QCItemTask.FIND('-') THEN
    //     //  ERROR('QC Item Task %1 is not complete',QCItemTask."Task Code");
    //     // <<NF1.00:CIS.CM 09-29-15
    //     //NV
    // end;

    PROCEDURE "<<NIF>>"();
    BEGIN
    END;

    local procedure GetInvtSetup()
    begin
        if not HasInvtSetup then begin
            InventorySetup.Get();
            HasInvtSetup := true;
        end;
    end;

    PROCEDURE GetLotBinContents(VAR TempLotBinContent: Record 50001 temporary);
    VAR
        LotNoInfo: Record 6505;
        WhseEntry: Record 7312;
        Bin: Record 7354;
        ItemUnitOfMeasure: Record 5404;
        BinContent: Record 7302;
    BEGIN
        
        TempLotBinContent.DELETEALL();

        LotNoInfo.SETRANGE("Item No.", "No.");
        LotNoInfo.SETRANGE("Open Whse. Entries Exist", TRUE);
        LotNoInfo.SETFILTER("Location Filter", GETFILTER("Location Filter"));
        LotNoInfo.SETFILTER("Bin Filter", GETFILTER("Bin Filter"));
        LotNoInfo.SETFILTER("Variant Code", GETFILTER("Variant Filter"));

        IF NOT LotNoInfo.FIND('-') THEN
            EXIT;

        //loop through whse. entry
        WhseEntry.SETCURRENTKEY("Item No.", Open, Positive, "Location Code", "Zone Code",
                                  "Bin Code", "Serial No.", "Lot No.", "Expiration Date", "Posting Date");

        WhseEntry.SETRANGE("Item No.", "No.");
        WhseEntry.SETRANGE(Open, TRUE);
        WhseEntry.SETFILTER("Location Code", GETFILTER("Location Filter"));

        REPEAT
            WhseEntry.SETFILTER("Lot No.", LotNoInfo."Lot No.");
            WhseEntry.SETFILTER("Variant Code", GETFILTER("Variant Filter"));
            WhseEntry.FIND('-');
            REPEAT
                WITH TempLotBinContent DO BEGIN
                    "Location Code" := WhseEntry."Location Code";
                    "Bin Code" := WhseEntry."Bin Code";
                    "Item No." := WhseEntry."Item No.";
                    "Variant Code" := WhseEntry."Variant Code";
                    "Unit of Measure Code" := WhseEntry."Unit of Measure Code";
                    "Lot No." := WhseEntry."Lot No.";
                    "Zone Code" := WhseEntry."Zone Code";
                    "Bin Type Code" := WhseEntry."Bin Type Code";
                    //"Expiration Date" := LotNoInfo."Expiration Date";
                    "Creation Date" := LotNoInfo."Lot Creation Date";
                    "External Lot No." := LotNoInfo."Mfg. Lot No.";

                    //get qty per unit of measure
                    ItemUnitOfMeasure.GET("Item No.", "Unit of Measure Code");
                    "Qty. per Unit of Measure" := ItemUnitOfMeasure."Qty. per Unit of Measure";

                    //get bin fields
                    IF NOT Bin.GET(WhseEntry."Location Code", WhseEntry."Bin Code") THEN
                        CLEAR(Bin);
                    "Warehouse Class Code" := Bin."Warehouse Class Code";
                    "Bin Ranking" := Bin."Bin Ranking";
                    "Cross-Dock Bin" := Bin."Cross-Dock Bin";
                    Default := Bin.Default;
                    IF BinContent.GET("Location Code", "Bin Code", "Item No.", "Variant Code", "Unit of Measure Code") THEN
                        "Block Movement" := BinContent."Block Movement"
                    ELSE
                        "Block Movement" := Bin."Block Movement";
                    //>> 06-14-05
                    "Units per Parcel" := Item."Units per Parcel";
                    //<< 06-14-05
                    //Bin."Adjustment Bin";
                    //Bin."Pick Bin Ranking";
                    //Bin."Bin Size Code";

                    IF NOT INSERT() THEN;
                END;
            UNTIL WhseEntry.NEXT() = 0;
        UNTIL LotNoInfo.NEXT() = 0;
        
    END;

    PROCEDURE UpdateQCHoldFromItem(ItemNo: Code[20]; QCHold: Boolean);
    VAR
        PurchLine: Record 39;
        ItemVend: Record 99;
    BEGIN
        //TODO
        //>> NF1.00:CIS.CM 09-29-15
        PurchLine.SETCURRENTKEY(Type, "No.");
        PurchLine.SETRANGE(Type, PurchLine.Type::Item);
        PurchLine.SETRANGE("No.", ItemNo);
        PurchLine.MODIFYALL("QC Hold", QCHold);

        //if qc hold taken off, then exit
        IF NOT QCHold THEN
            EXIT;

        //if qc hold put on, consider waivers
        ItemVend.SETRANGE("Item No.", ItemNo);
        ItemVend.SETRANGE("Waive QC Hold", TRUE);

        //if no waivers found, then exit
        IF NOT ItemVend.FindLast() THEN
            EXIT;

        REPEAT
            UpdateQCWaiverFromItemVend(ItemVend, QCHold, TRUE);
        UNTIL ItemVend.NEXT() = 0;
        //<< NF1.00:CIS.CM 09-29-15 
        //TODO
    END;

    PROCEDURE UpdateQCWaiverFromItemVend(ItemVend: Record 99; WaiveQCHold: Boolean; CalledFromItem: Boolean);
    VAR
        PurchLine: Record 39;
    BEGIN
        //TODO
        //>> NF1.00:CIS.CM 09-29-15
        //exit if item is blank
        IF ItemVend."Item No." = '' THEN
            EXIT;

        //if called from item, use internal value for hold
        IF CalledFromItem THEN
            WaiveQCHold := ItemVend."Waive QC Hold";

        PurchLine.SETCURRENTKEY(Type, "No.");
        PurchLine.SETRANGE(Type, PurchLine.Type::Item);
        PurchLine.SETRANGE("No.", ItemVend."Item No.");
        PurchLine.SETRANGE("Buy-from Vendor No.", ItemVend."Vendor No.");
        IF PurchLine.FIND('-') THEN
            REPEAT
                PurchLine."QC Hold" := (NOT WaiveQCHold);
                PurchLine.MODIFY();
            UNTIL PurchLine.NEXT() = 0;
        //<< NF1.00:CIS.CM 09-29-15 
        //TODO
    END;
}
