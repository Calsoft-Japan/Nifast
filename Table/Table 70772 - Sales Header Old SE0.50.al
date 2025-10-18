table 70772 "Sales Header Old SE0.50"
{
    fields
    {
        field(1; "Document Type"; Integer)
        {
            // cleaned
        }
        field(2; "No."; Code[20])
        {
            // cleaned
        }
        field(11; "Bill of Lading No."; Code[20])
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; "Document Type", "No.")
        {
        }
    }

    fieldgroups
    {
    }
}
