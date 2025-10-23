table 50001 "Lot Bin Content"
{
    // NF1.00:CIS.RAM   06/10/15 Merged during upgrade
    //  # Fixed FORM and PAGE conflict
    //   >> RHO
    //   copied from Bin Content table
    //   -added Lot No. to primary key
    //   -changed "Lot No." Filter calc on flowfields to Lot No.
    //   -removed "Lot No. Filter" field
    //   << RHO

    Caption = 'Lot Bin Content';
    DrillDownPageID = 50021;
    LookupPageID = 50021;
    fields
    {
        field(1; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            NotBlank = true;
            TableRelation = Location;
            trigger OnValidate()
            begin
                IF (CurrFieldNo <> 0) AND ("Location Code" <> xRec."Location Code") THEN BEGIN
                    CheckManualChange(FIELDCAPTION("Location Code"));
                    "Bin Code" := '';
                END;
            end;
        }
        field(2; "Zone Code"; Code[10])
        {
            Caption = 'Zone Code';
            Editable = false;
            NotBlank = true;
            TableRelation = Zone.Code WHERE("Location Code" = FIELD("Location Code"));

            trigger OnValidate()
            begin
                IF (CurrFieldNo <> 0) AND ("Zone Code" <> xRec."Zone Code") THEN
                    CheckManualChange(FIELDCAPTION("Zone Code"));
            end;
        }
        field(3; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            NotBlank = true;
            TableRelation = IF ("Zone Code" = FILTER('')) Bin.Code WHERE("Location Code" = FIELD("Location Code"))
            ELSE IF ("Zone Code" = FILTER(<> '')) Bin.Code WHERE("Location Code" = FIELD("Location Code"),
                                                                             "Zone Code" = FIELD("Zone Code"));

            trigger OnValidate()
            begin
                IF (CurrFieldNo <> 0) AND ("Bin Code" <> xRec."Bin Code") THEN BEGIN
                    CheckManualChange(FIELDCAPTION("Bin Code"));
                    GetBin("Location Code", "Bin Code");
                    "Bin Type Code" := Bin."Bin Type Code";
                    "Warehouse Class Code" := Bin."Warehouse Class Code";
                    "Bin Ranking" := Bin."Bin Ranking";
                    "Block Movement" := Bin."Block Movement";
                    "Zone Code" := Bin."Zone Code";
                END;
            end;
        }
        field(4; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            NotBlank = true;
            TableRelation = Item;

            trigger OnValidate()
            begin
                IF (CurrFieldNo <> 0) AND ("Item No." <> xRec."Item No.") THEN BEGIN
                    CheckManualChange(FIELDCAPTION("Item No."));
                    "Variant Code" := '';
                END;

                IF ("Item No." <> xRec."Item No.") AND ("Item No." <> '') THEN BEGIN
                    GetItem("Item No.");
                    VALIDATE("Unit of Measure Code", Item."Base Unit of Measure");
                END;
            end;

        }
        field(5; "Lot No."; Code[20])
        {
            trigger OnLookup()
            var
                LotNoInfo: Record 6505;
            begin
                //>> 05-20-05
                LotNoInfo.SETRANGE("Item No.", "Item No.");
                LotNoInfo.SETRANGE("Variant Code", "Variant Code");
                LotNoInfo.SETRANGE("Lot No.", "Lot No.");
                PAGE.RUN(0, LotNoInfo);
                //<< 05-20-05
            end;
        }
        field(10; "Bin Type Code"; Code[10])
        {
            Caption = 'Bin Type Code';
            Editable = false;
            TableRelation = "Bin Type";
        }
        field(11; "Warehouse Class Code"; Code[10])
        {
            Caption = 'Warehouse Class Code';
            Editable = false;
            TableRelation = "Warehouse Class";
        }
        field(12; "Block Movement"; Option)
        {
            Caption = 'Block Movement';
            OptionCaption = ' ,Inbound,Outbound,All';
            OptionMembers = " ",Inbound,Outbound,All;
        }
        field(15; "Min. Qty."; Decimal)
        {
            Caption = 'Min. Qty.';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(16; "Max. Qty."; Decimal)
        {
            Caption = 'Max. Qty.';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            trigger OnValidate()
            begin
                IF "Max. Qty." <> xRec."Max. Qty." THEN
                    CheckBinMaxCubageAndWeight();
            end;
        }
        field(21; "Bin Ranking"; Integer)
        {
            Caption = 'Bin Ranking';
            Editable = false;
        }
        field(26; Quantity; Decimal)
        {
            CalcFormula = Sum("Warehouse Entry".Quantity WHERE("Location Code" = FIELD("Location Code"),
                                                                "Bin Code" = FIELD("Bin Code"),
                                                                "Item No." = FIELD("Item No."),
                                                                "Variant Code" = FIELD("Variant Code"),
                                                                "Unit of Measure Code" = FIELD("Unit of Measure Code"),
                                                                "Lot No." = FIELD("Lot No."),
                                                                "Serial No." = FIELD("Serial No. Filter"),
                                                                "License Plate No." = FIELD("License Plate No. Filter")));
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(29; "Pick Qty."; Decimal)
        {
            CalcFormula = Sum("Warehouse Activity Line"."Qty. Outstanding" WHERE("Location Code" = FIELD("Location Code"),
                                                                                  "Bin Code" = FIELD("Bin Code"),
                                                                                  "Item No." = FIELD("Item No."),
                                                                                  "Variant Code" = FIELD("Variant Code"),
                                                                                  "Unit of Measure Code" = FIELD("Unit of Measure Code"),
                                                                                  "Action Type" = CONST(Take),
                                                                                  "Lot No." = FIELD("Lot No."),
                                                                                  "Serial No." = FIELD("Serial No. Filter")));
            Caption = 'Pick Qty.';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "Neg. Adjmt. Qty."; Decimal)
        {
            CalcFormula = Sum("Warehouse Journal Line"."Qty. (Absolute)" WHERE("Location Code" = FIELD("Location Code"),
                                                                                "From Bin Code" = FIELD("Bin Code"),
                                                                                "Item No." = FIELD("Item No."),
                                                                                "Variant Code" = FIELD("Variant Code"),
                                                                                "Unit of Measure Code" = FIELD("Unit of Measure Code"),
                                                                                "Lot No." = FIELD("Lot No."),
                                                                                "Serial No." = FIELD("Serial No. Filter")));
            Caption = 'Neg. Adjmt. Qty.';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(31; "Put-away Qty."; Decimal)
        {
            CalcFormula = Sum("Warehouse Activity Line"."Qty. Outstanding" WHERE("Location Code" = FIELD("Location Code"),
                                                                                  "Bin Code" = FIELD("Bin Code"),
                                                                                  "Item No." = FIELD("Item No."),
                                                                                  "Variant Code" = FIELD("Variant Code"),
                                                                                  "Unit of Measure Code" = FIELD("Unit of Measure Code"),
                                                                                  "Action Type" = CONST(Place),
                                                                                  "Lot No." = FIELD("Lot No."),
                                                                                  "Serial No." = FIELD("Serial No. Filter")));
            Caption = 'Put-away Qty.';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(32; "Pos. Adjmt. Qty."; Decimal)
        {
            CalcFormula = Sum("Warehouse Journal Line"."Qty. (Absolute)" WHERE("Location Code" = FIELD("Location Code"),
                                                                                "To Bin Code" = FIELD("Bin Code"),
                                                                                "Item No." = FIELD("Item No."),
                                                                                "Variant Code" = FIELD("Variant Code"),
                                                                                "Unit of Measure Code" = FIELD("Unit of Measure Code"),
                                                                                "Lot No." = FIELD("Lot No."),
                                                                                "Serial No." = FIELD("Serial No. Filter")));
            Caption = 'Pos. Adjmt. Qty.';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(37; "Fixed"; Boolean)
        {
            Caption = 'Fixed';
        }
        field(40; "Cross-Dock Bin"; Boolean)
        {
            Caption = 'Cross-Dock Bin';
        }
        field(41; Default; Boolean)
        {
            Caption = 'Default';
            trigger OnValidate()
            begin
                IF (xRec.Default <> Default) AND Default THEN
                    IF WMSManagement.CheckDefaultBin(
                      "Item No.", "Variant Code", "Location Code", "Bin Code")
                    THEN
                        ERROR(Text010, "Location Code", "Item No.", "Variant Code");
            end;
        }
        field(5402; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));

            trigger OnValidate()
            begin
                IF (CurrFieldNo <> 0) AND ("Variant Code" <> xRec."Variant Code") THEN
                    CheckManualChange(FIELDCAPTION("Variant Code"));
            end;

        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
        }
        field(5407; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            NotBlank = true;
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item No."));

            trigger OnValidate()
            begin
                IF (CurrFieldNo <> 0) AND ("Unit of Measure Code" <> xRec."Unit of Measure Code") THEN
                    CheckManualChange(FIELDCAPTION("Unit of Measure Code"));

                GetItem("Item No.");
                "Qty. per Unit of Measure" :=
                  UOMMgt.GetQtyPerUnitOfMeasure(Item, "Unit of Measure Code");
            end;
        }
        field(6501; "Serial No. Filter"; Code[20])
        {
            Caption = 'Serial No. Filter';
            FieldClass = FlowFilter;
        }
        field(50000; "Expiration Date"; Date)
        {
            // cleaned
        }
        field(50001; "Creation Date"; Date)
        {
            // cleaned
        }
        field(50005; "External Lot No."; Text[30])
        {
            // cleaned
        }
        field(50010; "Qty. to Handle"; Decimal)
        {
            // cleaned
        }
        field(50020; "Qty. to Handle (Base)"; Decimal)
        {
            // cleaned
        }
        field(50025; "Inspected Parts"; Boolean)
        {
            CalcFormula = Lookup("Lot No. Information"."Passed Inspection" WHERE("Item No." = FIELD("Item No."),
                                                                                  "Lot No." = FIELD("Lot No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50027; Blocked; Boolean)
        {
            CalcFormula = Lookup("Lot No. Information".Blocked WHERE("Item No." = FIELD("Item No."),
                                                                      "Lot No." = FIELD("Lot No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50030; "Units per Parcel"; Decimal)
        {
            // cleaned
        }
        field(50031; "Total Parcels"; Decimal)
        {
            // cleaned
        }
        field(50035; "Revision No."; Code[20])
        {
            CalcFormula = Lookup("Lot No. Information"."Revision No." WHERE("Item No." = FIELD("Item No."),
                                                                             "Lot No." = FIELD("Lot No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50080; "Country of Origin"; Code[10])
        {
            CalcFormula = Lookup("Lot No. Information"."Country of Origin" WHERE("Item No." = FIELD("Item No."),
                                                                                  "Lot No." = FIELD("Lot No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60000; "CVE Pediment No."; Code[10])
        {
            CalcFormula = Lookup("Lot No. Information"."CVE Pedimento" WHERE("Item No." = FIELD("Item No."),
                                                                              "Variant Code" = FIELD("Variant Code"),
                                                                              "Lot No." = FIELD("Lot No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "CVE Pedimento";
        }
        field(14017610; "Wksh. Pos. Adjmt. Qty."; Decimal)
        {
            CalcFormula = Sum("Whse. Worksheet Line"."Qty. Outstanding (Base)" WHERE("Location Code" = FIELD("Location Code"),
                                                                                      "To Bin Code" = FIELD("Bin Code"),
                                                                                      "Item No." = FIELD("Item No."),
                                                                                      "Variant Code" = FIELD("Variant Code"),
                                                                                      "Unit of Measure Code" = FIELD("Unit of Measure Code")));
            DecimalPlaces = 0 : 5;
            Description = 'NV';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14017615; "Min. Replenishment Qty."; Decimal)
        {
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(14017616; "Max. Replenishment Qty."; Decimal)
        {
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(14017617; "Replenishment Multiple"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(14017620; "Break Pick when Qty. on Hand"; Option)
        {
            OptionMembers = " ",">= Min. Qty. (no split pick)","= Max. Qty. (allow split pick)";
        }
        field(14017999; "License Plate No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }

    }
    keys
    {
        key(Key1; "Location Code", "Bin Code", "Item No.", "Variant Code", "Unit of Measure Code", "Lot No.")
        {
        }
        key(Key2; "Bin Type Code")
        {
        }
        key(Key3; "Location Code", "Item No.", "Variant Code", "Cross-Dock Bin", "Qty. per Unit of Measure", "Bin Ranking")
        {
        }
        key(Key4; "Location Code", "Warehouse Class Code", "Fixed", "Bin Ranking")
        {
        }
        key(Key5; "Location Code", "Item No.", "Variant Code", "Warehouse Class Code", "Fixed", "Bin Ranking")
        {
        }
        key(Key6; "Item No.")
        {
        }
        key(Key7; Default, "Location Code", "Item No.", "Variant Code", "Bin Code")
        {
        }
        key(Key8; "Expiration Date", "Lot No.")
        {
        }
        key(Key9; "Creation Date", "Lot No.")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        /*
        CALCFIELDS(
          Quantity,"Pick Qty.","Neg. Adjmt. Qty.",
          "Put-away Qty.","Pos. Adjmt. Qty.");
        IF (Quantity <> 0) THEN
          ERROR(Text000,TABLECAPTION);
        
        IF ("Pick Qty." <> 0) OR ("Neg. Adjmt. Qty." <> 0) OR
           ("Put-away Qty." <> 0) OR ("Pos. Adjmt. Qty." <> 0)
        THEN
          ERROR(Text001,TABLECAPTION);
         */
    end;

    trigger OnInsert()
    begin
        IF Default THEN
            IF WMSManagement.CheckDefaultBin(
              "Item No.", "Variant Code", "Location Code", "Bin Code")
            THEN
                ERROR(Text010, "Location Code", "Item No.", "Variant Code");

        GetLocation("Location Code");
        IF Location."Directed Put-away and Pick" THEN
            TESTFIELD("Zone Code")
        ELSE
            TESTFIELD("Zone Code", '');

        IF "Min. Qty." > "Max. Qty." THEN
            ERROR(
              Text005,
              FIELDCAPTION("Max. Qty."), "Max. Qty.",
              FIELDCAPTION("Min. Qty."), "Min. Qty.");
    end;

    trigger OnModify()
    begin
        IF Default THEN
            IF WMSManagement.CheckDefaultBin(
              "Item No.", "Variant Code", "Location Code", "Bin Code")
            THEN
                ERROR(Text010, "Location Code", "Item No.", "Variant Code");

        GetLocation("Location Code");
        IF Location."Directed Put-away and Pick" THEN
            TESTFIELD("Zone Code")
        ELSE
            TESTFIELD("Zone Code", '');

        IF "Min. Qty." > "Max. Qty." THEN
            ERROR(
              Text005,
              FIELDCAPTION("Max. Qty."), "Max. Qty.",
              FIELDCAPTION("Min. Qty."), "Min. Qty.");
    end;

    var
        Item: Record 27;
        Location: Record 14;
        Bin: Record 7354;
        UOMMgt: Codeunit 5402;
        WMSManagement: Codeunit 7302;/* 
        Text000: Label 'You cannot delete this %1, because the %1 contains items.';
        Text001: Label 'You cannot delete this %1, because warehouse document lines have items allocated to this %1.'; */
        Text002: Label 'The total cubage %1 of the %2 for the %5 exceeds the %3 %4 of the %5.\Do you still want enter this %2?', Comment = '%1 = Cubage value, %2 = Source type, %3 = Limit value, %4 = Limit type, %5 = Entity';
        Text003: Label 'The total weight %1 of the %2 for the %5 exceeds the %3 %4 of the %5.\Do you still want enter this %2?', Comment = '%1 = Weight value, %2 = Source type, %3 = Limit value, %4 = Limit type, %5 = Entity';
        Text004: Label 'Cancelled.', Comment = 'Simple cancellation message';
        Text005: Label 'The %1 %2 must not be less than the %3 %4.', Comment = '%1 = Field name, %2 = Field description, %3 = Comparison field, %4 = Comparison description';
        Text006: Label 'available must not be less than %1', Comment = '%1 = Minimum required value';
        Text007: Label 'You cannot modify the %1, because the %2 contains items.', Comment = '%1 = Record name, %2 = Related entity containing items';
        Text008: Label 'You cannot modify the %1, because warehouse document lines have items allocated to this %2.', Comment = '%1 = Record name, %2 = Related entity';
        Text009: Label 'You must first set up user %1 as a warehouse employee.', Comment = '%1 = User ID';
        Text010: Label 'There is already a default bin content for location code %1, item no. %2 and variant code %3.', Comment = '%1 = Location code, %2 = Item number, %3 = Variant code';

    procedure SetUpNewLine()
    begin
        GetBin("Location Code", "Bin Code");
        "Bin Type Code" := Bin."Bin Type Code";
        "Warehouse Class Code" := Bin."Warehouse Class Code";
        "Bin Ranking" := Bin."Bin Ranking";
        "Block Movement" := Bin."Block Movement";
        "Zone Code" := Bin."Zone Code";
        "Cross-Dock Bin" := Bin."Cross-Dock Bin";
    end;

    procedure CheckManualChange(CaptionField: Text[30])
    begin
        xRec.CALCFIELDS(
          Quantity, "Pos. Adjmt. Qty.", "Put-away Qty.",
          "Neg. Adjmt. Qty.", "Pick Qty.");
        IF (xRec.Quantity <> 0) THEN
            ERROR(Text007, CaptionField, TABLECAPTION);
        IF (xRec."Pos. Adjmt. Qty." <> 0) OR (xRec."Put-away Qty." <> 0) OR
           (xRec."Neg. Adjmt. Qty." <> 0) OR (xRec."Pick Qty." <> 0)
        THEN
            ERROR(Text008, CaptionField, TABLECAPTION);
    end;

    procedure CalcQtyAvailToPick(ExcludeQty: Decimal): Decimal
    begin
        CALCFIELDS(Quantity, "Neg. Adjmt. Qty.", "Pick Qty.");
        EXIT(Quantity - ("Pick Qty." - ExcludeQty + "Neg. Adjmt. Qty."));
    end;

    procedure CalcQtyAvailToPutAway(ExcludeQty: Decimal): Decimal
    begin
        CALCFIELDS(Quantity, "Pos. Adjmt. Qty.", "Put-away Qty.");
        EXIT(
          "Max. Qty." -
          (Quantity + "Put-away Qty." - ExcludeQty + "Pos. Adjmt. Qty."));
    end;

    procedure NeedToReplenish(ExcludeQty: Decimal): Boolean
    begin
        CALCFIELDS(Quantity, "Pos. Adjmt. Qty.", "Put-away Qty.");
        EXIT(
          "Min. Qty." >
          Quantity +
          ABS("Put-away Qty." - ExcludeQty + "Pos. Adjmt. Qty."));
    end;

    procedure CalcQtyToReplenish(ExcludeQty: Decimal) QtyToReplenish_: Decimal
    begin
        // >> NV - 09/19/03 MV
        /*
        CALCFIELDS(Quantity,"Pos. Adjmt. Qty.","Put-away Qty.");
        EXIT(
          "Max. Qty." -
          (Quantity +
          "Put-away Qty." - ExcludeQty + "Pos. Adjmt. Qty."));
        */
        QtyToReplenish_ :=
          "Max. Qty." -
          CalcQtyAvailable(ExcludeQty); // Same as above, but modified to ensure consistency w/ replenishment batch


        IF ("Min. Replenishment Qty." <> 0) AND (QtyToReplenish_ < "Min. Replenishment Qty.") THEN
            QtyToReplenish_ := 0;
        IF ("Max. Replenishment Qty." <> 0) AND (QtyToReplenish_ > "Max. Replenishment Qty.") THEN
            QtyToReplenish_ := "Max. Replenishment Qty.";
        IF ("Replenishment Multiple" <> 0) THEN
            QtyToReplenish_ := ROUND(QtyToReplenish_, "Replenishment Multiple", '<');

        EXIT(QtyToReplenish_);
        // << NV - 09/19/03 MV

    end;

    procedure CheckBinMaxCubageAndWeight()
    var
        BinContent: Record 7302;
        WMSMgt: Codeunit 7302;
        TotalCubage: Decimal;
        TotalWeight: Decimal;
        Cubage: Decimal;
        Weight: Decimal;
    begin
        GetBin("Location Code", "Bin Code");
        IF (Bin."Maximum Cubage" <> 0) OR (Bin."Maximum Weight" <> 0) THEN BEGIN
            BinContent.SETRANGE("Location Code", "Location Code");
            BinContent.SETRANGE("Bin Code", "Bin Code");
            IF BinContent.FIND('-') THEN
                REPEAT
                    IF (BinContent."Location Code" = "Location Code") AND
                       (BinContent."Bin Code" = "Bin Code") AND
                       (BinContent."Item No." = "Item No.") AND
                       (BinContent."Variant Code" = "Variant Code") AND
                       (BinContent."Unit of Measure Code" = "Unit of Measure Code")
                    THEN
                        WMSMgt.CalcCubageAndWeight(
                          "Item No.", "Unit of Measure Code", "Max. Qty.", Cubage, Weight)
                    ELSE
                        WMSMgt.CalcCubageAndWeight(
                          BinContent."Item No.", BinContent."Unit of Measure Code",
                          BinContent."Max. Qty.", Cubage, Weight);
                    TotalCubage := TotalCubage + Cubage;
                    TotalWeight := TotalWeight + Weight;
                UNTIL BinContent.NEXT() = 0;

            IF (Bin."Maximum Cubage" > 0) AND (Bin."Maximum Cubage" - TotalCubage < 0) THEN
                IF NOT CONFIRM(
                  Text002,
                  FALSE, TotalCubage, FIELDCAPTION("Max. Qty."),
                  Bin.FIELDCAPTION("Maximum Cubage"), Bin."Maximum Cubage", Bin.TABLECAPTION)
                THEN
                    ERROR(Text004);
            IF (Bin."Maximum Weight" > 0) AND (Bin."Maximum Weight" - TotalWeight < 0) THEN
                IF NOT CONFIRM(
                  Text003,
                  FALSE, TotalWeight, FIELDCAPTION("Max. Qty."),
                  Bin.FIELDCAPTION("Maximum Weight"), Bin."Maximum Weight", Bin.TABLECAPTION)
                THEN
                    ERROR(Text004);
        END;
    end;

    procedure CheckDecreaseBinContent(Qty: Decimal; DecreaseQty: Decimal)
    var
        QtyAvailToPick: Decimal;
    begin
        IF "Block Movement" IN ["Block Movement"::Outbound, "Block Movement"::All] THEN
            FIELDERROR("Block Movement");

        GetLocation("Location Code");
        IF "Bin Code" = Location."Adjustment Bin Code" THEN
            EXIT;

        QtyAvailToPick := CalcQtyAvailToPick(DecreaseQty);
        IF QtyAvailToPick < Qty THEN
            FIELDERROR(Quantity, STRSUBSTNO(Text006, ABS(Qty)));
    end;

    procedure CheckIncreaseBinContent(Qty: Decimal; DeductQty: Decimal; DeductCubage: Decimal; DeductWeight: Decimal; PutawayCubage: Decimal; PutawayWeight: Decimal; CalledbyPosting: Boolean)
    var
        WhseActivLine: Record 5767;
        WMSMgt: Codeunit 7302;
        QtyAvailToPutAway: Decimal;
        AvailableWeight: Decimal;
        AvailableCubage: Decimal;
    begin
        IF "Block Movement" IN ["Block Movement"::Inbound, "Block Movement"::All] THEN
            FIELDERROR("Block Movement");

        GetLocation("Location Code");
        IF ("Bin Code" = Location."Adjustment Bin Code") OR
           ("Bin Code" = Location."Open Shop Floor Bin Code") OR
           ("Bin Code" = Location."To-Production Bin Code") OR
           ("Bin Code" = Location."From-Production Bin Code")
        THEN
            EXIT;

        CheckWhseClass();

        IF Qty <> 0 THEN
            IF Location."Bin Capacity Policy" IN
               [Location."Bin Capacity Policy"::"Allow More Than Max. Capacity",
               Location."Bin Capacity Policy"::"Prohibit More Than Max. Cap."]
            THEN
                IF "Max. Qty." <> 0 THEN BEGIN
                    QtyAvailToPutAway := CalcQtyAvailToPutAway(DeductQty);
                    WMSMgt.CheckPutAwayAvailability(
                      "Bin Code", WhseActivLine.FIELDCAPTION(Quantity), TABLECAPTION, Qty, QtyAvailToPutAway,
                      (Location."Bin Capacity Policy" =
                       Location."Bin Capacity Policy"::"Prohibit More Than Max. Cap.") AND CalledbyPosting);
                END ELSE BEGIN
                    GetBin("Location Code", "Bin Code");
                    IF (Bin."Maximum Cubage" <> 0) OR (Bin."Maximum Weight" <> 0) THEN BEGIN
                        Bin.CalcCubageAndWeight(AvailableCubage, AvailableWeight, CalledbyPosting);
                        IF NOT CalledbyPosting THEN BEGIN
                            AvailableCubage := AvailableCubage + DeductCubage;
                            AvailableWeight := AvailableWeight + DeductWeight;
                        END;

                        IF (Bin."Maximum Cubage" <> 0) AND (PutawayCubage > AvailableCubage) THEN
                            WMSMgt.CheckPutAwayAvailability(
                              "Bin Code", WhseActivLine.FIELDCAPTION(Cubage), Bin.TABLECAPTION, PutawayCubage, AvailableCubage,
                              (Location."Bin Capacity Policy" =
                               Location."Bin Capacity Policy"::"Prohibit More Than Max. Cap.") AND CalledbyPosting);

                        IF (Bin."Maximum Weight" <> 0) AND (PutawayWeight > AvailableWeight) THEN
                            WMSMgt.CheckPutAwayAvailability(
                              "Bin Code", WhseActivLine.FIELDCAPTION(Weight), Bin.TABLECAPTION, PutawayWeight, AvailableWeight,
                              (Location."Bin Capacity Policy" =
                               Location."Bin Capacity Policy"::"Prohibit More Than Max. Cap.") AND CalledbyPosting);
                    END;
                END;
    end;

    procedure CheckWhseClass()
    var
    // ProductGroup: Record 5723;
    begin
        //TODO
        /*   GetItem("Item No.");
          IF ProductGroup.GET(Item."Item Category Code", Item."Product Group Code") THEN
              TESTFIELD("Warehouse Class Code", ProductGroup."Warehouse Class Code")
          ELSE
              TESTFIELD("Warehouse Class Code", ''); */
        //TODO
    end;

    procedure ShowBinContents(LocationCode: Code[10]; ItemNo: Code[20]; VariantCode: Code[10]; BinCode: Code[20])
    var
        BinContent: Record 7302;
        BinContentLookup: Page 7305;
    begin
        IF BinCode <> '' THEN
            BinContent.SETRANGE("Bin Code", BinCode)
        ELSE
            BinContent.SETCURRENTKEY("Location Code", "Item No.", "Variant Code");
        BinContent.SETRANGE("Item No.", ItemNo);
        BinContent.SETRANGE("Variant Code", VariantCode);
        BinContentLookup.SETTABLEVIEW(BinContent);
        BinContentLookup.Initialize(LocationCode);
        BinContentLookup.RUNMODAL();
        CLEAR(BinContentLookup);
    end;

    local procedure GetLocation(LocationCode: Code[10])
    begin
        IF Location.Code <> LocationCode THEN
            Location.GET(LocationCode);
    end;

    procedure GetBin(LocationCode: Code[10]; BinCode: Code[20])
    begin
        IF (LocationCode = '') OR (BinCode = '') THEN
            Bin.INIT()
        ELSE
            IF (Bin."Location Code" <> LocationCode) OR
               (Bin.Code <> BinCode)
            THEN
                Bin.GET(LocationCode, BinCode);
    end;

    local procedure GetItem(ItemNo: Code[20])
    begin
        IF Item."No." <> ItemNo THEN
            Item.GET(ItemNo);
    end;

    procedure GetItemDescr(ItemNo: Code[20]; VariantCode: Code[10]; var ItemDescription: Text[50])
    var
        Item_: Record 27;
        ItemVariant: Record 5401;
        OldItemNo: Code[20];
    begin
        ItemDescription := '';
        IF ItemNo <> OldItemNo THEN BEGIN
            ItemDescription := '';
            IF ItemNo <> '' THEN BEGIN
                IF Item_.GET(ItemNo) THEN
                    ItemDescription := Item_.Description;
                IF VariantCode <> '' THEN
                    IF ItemVariant.GET(ItemNo, VariantCode) THEN
                        ItemDescription := ItemVariant.Description;
            END;
            OldItemNo := ItemNo;
        END;
    end;

    procedure GetWhseLocation(var CurrentLocationCode: Code[10]; var CurrentZoneCode: Code[10])
    var
        Location_: Record 14;
        WhseEmployee: Record 7301;
        WMSMgt: Codeunit 7302;
    begin
        IF USERID <> '' THEN BEGIN
            WhseEmployee.SETRANGE("User ID", USERID);
            IF NOT WhseEmployee.FIND('-') THEN
                ERROR(Text009, USERID);
            IF CurrentLocationCode <> '' THEN BEGIN
                IF NOT Location_.GET(CurrentLocationCode) THEN BEGIN
                    CurrentLocationCode := '';
                    CurrentZoneCode := '';
                END ELSE
                    IF NOT Location_."Bin Mandatory" THEN BEGIN
                        CurrentLocationCode := '';
                        CurrentZoneCode := '';
                    END ELSE BEGIN
                        WhseEmployee.SETRANGE("Location Code", CurrentLocationCode);
                        IF NOT WhseEmployee.IsEmpty() THEN BEGIN
                            CurrentLocationCode := '';
                            CurrentZoneCode := '';
                        END;
                    END;
                IF CurrentLocationCode = '' THEN BEGIN
                    CurrentLocationCode := WMSMgt.GetDefaultLocation();
                    IF CurrentLocationCode <> '' THEN BEGIN
                        Location_.GET(CurrentLocationCode);
                        IF NOT Location_."Bin Mandatory" THEN
                            CurrentLocationCode := '';
                    END;
                END;
            END;
        END;
        FILTERGROUP := 2;
        IF CurrentLocationCode <> '' THEN
            SETRANGE("Location Code", CurrentLocationCode)
        ELSE
            SETRANGE("Location Code");
        IF CurrentZoneCode <> '' THEN
            SETRANGE("Zone Code", CurrentZoneCode)
        ELSE
            SETRANGE("Zone Code");
        FILTERGROUP := 0;
    end;

    procedure CalcQtyonAdjmtBin(): Decimal
    var
        WhseEntry: Record 7312;
    begin
        GetLocation("Location Code");
        WhseEntry.SETCURRENTKEY(
          "Item No.", "Bin Code", "Location Code", "Variant Code", "Unit of Measure Code");
        WhseEntry.SETRANGE("Item No.", "Item No.");
        WhseEntry.SETRANGE("Bin Code", Location."Adjustment Bin Code");
        WhseEntry.SETRANGE("Location Code", "Location Code");
        WhseEntry.SETRANGE("Variant Code", "Variant Code");
        WhseEntry.SETRANGE("Unit of Measure Code", "Unit of Measure Code");
        WhseEntry.CALCSUMS(Quantity);
        EXIT(WhseEntry.Quantity);
    end;

    procedure ">> NV"()
    begin
    end;

    procedure CalcQtyAvailable(ExcludeQty: Decimal): Decimal
    begin
        // >> NV - 09/19/03
        // --  new function to used replenishment batch -- is called from
        //    "CalcQtyToReplenish" as well to ensure consistency
        CALCFIELDS(Quantity, "Pos. Adjmt. Qty.", "Put-away Qty.");
        EXIT(Quantity + "Put-away Qty." - ExcludeQty + "Pos. Adjmt. Qty.");
        // << NV - 09/19/03
    end;

}
