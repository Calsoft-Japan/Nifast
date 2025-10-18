table 50028 "Vendor Forecast Ledger Entry"
{
    fields
    {
        field(1; "Item No."; Code[30])
        {
            // cleaned
        }
        field(2; "Vendor No."; Code[10])
        {
            // cleaned
        }
        field(3; "Div Code"; Code[10])
        {
            // cleaned
        }
        field(4; "Forecast Qty for Vendor"; Decimal)
        {
            // cleaned
        }
        field(5; "Receive Date"; Date)
        {
            // cleaned
        }
        field(6; "Order Date"; Date)
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; "Item No.", "Vendor No.", "Receive Date")
        {
        }
        key(Key2; "Forecast Qty for Vendor", "Div Code", "Vendor No.")
        {
        }
    }

    fieldgroups
    {
    }
}
