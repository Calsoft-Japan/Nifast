table 70500 "Fix Transfer Lots"
{
    fields
    {
        field(1; "Item Ledg Entry No."; Integer)
        {
            // cleaned
        }
        field(2; "Item No."; Code[20])
        {
            // cleaned
        }
        field(3; "Lot No."; Code[20])
        {
            // cleaned
        }
        field(4; "Bin Code"; Code[20])
        {
            trigger OnLookup()
            var
               // BinContent: Record 7302;
            begin
            end;
        }
        field(5; "Location Code"; Code[20])
        {
            // cleaned
        }
        field(10; Quantity; Decimal)
        {
            // cleaned
        }
        field(11; "Adjmt. Qty"; Decimal)
        {
            // cleaned
        }
        field(15; "Doc No."; Code[20])
        {
            // cleaned
        }
        field(16; "Doc Line No."; Integer)
        {
            // cleaned
        }
        field(20; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(50; Skip; Boolean)
        {
            // cleaned
        }
        field(70; "ILE OnHand"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("Item No."),
                                                                  "Location Code" = FIELD("Location Code"),
                                                                  "Lot No." = FIELD("Lot No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(71; "Whse OnHand"; Decimal)
        {
            CalcFormula = Sum("Warehouse Entry".Quantity WHERE("Location Code" = FIELD("Location Code"),
                                                                "Item No." = FIELD("Item No."),
                                                                "Lot No." = FIELD("Lot No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(72; "Total Adjmt. Qty"; Decimal)
        {
            // cleaned
            FieldClass = FlowField;
            CalcFormula = Sum("Fix Transfer Lots"."Adjmt. Qty" WHERE("Item No." = FIELD("Item No."),
                                                                      "Lot No."=FIELD("Lot No."),
                                                                      "Location Code"=FIELD("Location Code")));
        }
    }
       keys
    {
        key(Key1;"Entry No.")
        {
        }
        key(Key2;"Location Code","Item No.","Lot No.")
        {
            SumIndexFields = "Adjmt. Qty";
        }
    }

    fieldgroups
    {
    }
}
