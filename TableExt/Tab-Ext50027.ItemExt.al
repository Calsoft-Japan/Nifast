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
            var
                myInt: Integer;
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
                ">>NIF_LV": Integer;
                SalesLine: Record 37;
                PurchLine: Record 39;
            begin
                //>> NIF 06-12-05 RTT
                IF (xRec."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group") AND ("Gen. Prod. Posting Group" <> '') THEN BEGIN
                    SalesLine.RESET;
                    SalesLine.SETCURRENTKEY(Type, "No.");
                    SalesLine.SETRANGE(Type, SalesLine.Type::Item);
                    SalesLine.SETRANGE("No.", "No.");

                    PurchLine.RESET;
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
                //>> NV
                SKU.RESET;
                SKU.SETRANGE("Item No.", "No.");
                SKU.MODIFYALL("Item Category Code", "Item Category Code");
                SKU.MODIFYALL("Product Group Code", "Product Group Code");
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
    }
    var
        ItemCrossReference: Record 5777;
        SKU: Record "Stockkeeping Unit";
        UserSetup: Record 91;
        Item: Record 27;
        NVM: Codeunit 50021;
        Text14000701: Label '%1 is normally 12 digit, use this number anyway?';
        Text14000702: Label 'Nothing Changed.';

    trigger OnAfterInsert()
    begin
        National := TRUE; //-AKK1606.01++
    end;

    trigger OnAfterDelete()
    var
        SocialListeningSearchTopic: Record 871;
    begin
        IF NOT SocialListeningSearchTopic.ISEMPTY THEN BEGIN
            SocialListeningSearchTopic.FindSearchTopic(SocialListeningSearchTopic."Source Type"::Item, "No.");
            SocialListeningSearchTopic.DELETEALL;
        END;

        //>>NV
        // >>NF1.00:CIS.CM 09-29-15
        //QCItemTask.SETRANGE("Item No.","No.");
        //IF QCItemTask.FIND('-') THEN
        //  ERROR('QC Item Task %1 is not complete',QCItemTask."Task Code");
        // <<NF1.00:CIS.CM 09-29-15
        //NV
    end;

    PROCEDURE "<<NIF>>"();
    BEGIN
    END;

    PROCEDURE GetLotBinContents(VAR TempLotBinContent: Record 50001 temporary);
    VAR
        LotNoInfo: Record 6505;
        WhseEntry: Record 7312;
        Bin: Record 7354;
        ItemUnitOfMeasure: Record 5404;
        BinContent: Record 7302;
    BEGIN
        TempLotBinContent.DELETEALL;

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

                    IF NOT INSERT THEN;
                END;
            UNTIL WhseEntry.NEXT = 0;
        UNTIL LotNoInfo.NEXT = 0;
    END;

    PROCEDURE UpdateQCHoldFromItem(ItemNo: Code[20]; QCHold: Boolean);
    VAR
        PurchLine: Record 39;
        ItemVend: Record 99;
    BEGIN
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
        IF NOT ItemVend.FIND('-') THEN
            EXIT;

        REPEAT
            UpdateQCWaiverFromItemVend(ItemVend, QCHold, TRUE);
        UNTIL ItemVend.NEXT = 0;
        //<< NF1.00:CIS.CM 09-29-15
    END;

    PROCEDURE UpdateQCWaiverFromItemVend(ItemVend: Record 99; WaiveQCHold: Boolean; CalledFromItem: Boolean);
    VAR
        PurchLine: Record 39;
    BEGIN
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
                PurchLine.MODIFY;
            UNTIL PurchLine.NEXT = 0;
        //<< NF1.00:CIS.CM 09-29-15
    END;
}
