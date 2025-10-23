table 99800 "TEMP - Check Lots"
{
    fields
    {
        field(5; "Location Code"; Code[20])
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
    }
    keys
    {
        key(Key1; "Location Code", "Item No.", "Lot No.")
        {
        }
    }

    fieldgroups
    {
    }
}
