table 99801 "TEMP - Fix Prod Kit Lots"
{
    fields
    {
        field(7; "Location Code"; Code[20])
        {
            // cleaned
        }
        field(10; "Item No."; Code[20])
        {
            // cleaned
        }
        field(11; "Lot No."; Code[20])
        {
            // cleaned
        }
        field(12; SumQty; Decimal)
        {
            // cleaned
        }
        field(13; RemQty; Decimal)
        {
            // cleaned
        }
        field(15; BinQty; Decimal)
        {
            // cleaned
        }
        field(20; "Var"; Decimal)
        {
            // cleaned
        }
        field(21; "PROD IN Qty"; Decimal)
        {
            // cleaned
        }
        field(22; "Entry Qty"; Decimal)
        {
            // cleaned
            CalcFormula = Sum("TEMP- Fix Kit Entry".Quantity WHERE ("Item No."=FIELD("Item No."),
                                                                    "Lot No."=FIELD("Lot No."),
                                                                    "Location Code"=FIELD("Location Code")));
            FieldClass = FlowField;
        }
        field(50; Fix; Boolean)
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; "Location Code", "Item No.", "Lot No.")
        {
        }
    }
}
