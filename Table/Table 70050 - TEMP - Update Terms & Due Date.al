table 70050 "TEMP - Update Terms & Due Date"
{
    fields
    {
        field(1; Type; Option)
        {
            OptionMembers = SalesOrder,SalesInvoice,CustLedg;
        }
        field(2; "No."; Code[20])
        {
            // cleaned
        }
        field(7; "Old Terms"; Code[20])
        {
            // cleaned
        }
        field(8; "New Terms"; Code[20])
        {
            // cleaned
        }
        field(17; "Old Due Date"; Date)
        {
            // cleaned
        }
        field(18; "New Due Date"; Date)
        {
            // cleaned
        }
        field(25; "Document No."; Code[20])
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; Type, "No.")
        {
        }
    }
}
