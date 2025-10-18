table 50026 "Forecast Log File"
{
    fields
    {
        field(1; "Item No."; Code[20])
        {
            // cleaned
        }
        field(2; "Customer No."; Code[20])
        {
            // cleaned
        }
        field(3; Quantity; Decimal)
        {
            // cleaned
        }
        field(4; "Generation Date"; Date)
        {
            // cleaned
        }
        field(5; "Forecast Month"; Date)
        {
            // cleaned
        }
        field(6; "Div Code"; Code[10])
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; "Item No.", "Customer No.", "Generation Date", "Forecast Month", "Div Code")
        {
        }
    }

    fieldgroups
    {
    }

}
