table 50022 "Mex Export Pediment"
{
    DrillDownPageID = 50030;
    LookupPageID = 50030;

    fields
    {
        field(1; "Pedimento Virtual No."; Code[20])
        {
            // cleaned
        }
        field(2; "Start Date"; Date)
        {
            // cleaned
        }
        field(3; "End Date"; Date)
        {
            // cleaned
        }
        field(4; "Customer No."; Code[20])
        {
            FieldClass = Normal;
            NotBlank = true;
            TableRelation = Customer."No.";
        }
        field(5; "Pedimento Entry No."; Integer)
        {
            AutoIncrement = true;
        }
    }
    keys
    {
        key(Key1; "Pedimento Entry No.", "Pedimento Virtual No.")
        {
        }
    }
}
