table 50009 "Eship Ship Buffer"
{
    fields
    {
        field(10; "Document No."; Code[20])
        {
            // cleaned
        }
        field(20; "Line No."; Integer)
        {
            // cleaned
        }
        field(30; "Lot No."; Code[20])
        {
            // cleaned
        }
        field(32; "Location Code"; Code[20])
        {
            // cleaned
        }
        field(33; "Bin Code"; Code[20])
        {
            // cleaned
        }
        field(35; "Item No."; Code[20])
        {
            // cleaned
        }
        field(40; Quantity; Decimal)
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; "Document No.", "Line No.", "Lot No.", "Location Code", "Bin Code", "Item No.")
        {
        }
    }

    fieldgroups
    {
    }
}
