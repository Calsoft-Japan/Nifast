table 81240 "MEX - Temp Lots"
{
    fields
    {
        field(1; "Item No."; Code[20])
        {
            // cleaned
        }
        field(2; "Lot No."; Code[20])
        {
            // cleaned
        }
        field(10; "Sales Qty"; Decimal)
        {
            // cleaned
        }
        field(15; "Purch Qty"; Decimal)
        {
            // cleaned
        }
        field(16; "Qty OH"; Decimal)
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; "Item No.", "Lot No.")
        {
        }
    }
}
