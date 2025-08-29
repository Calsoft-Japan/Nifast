table 50022 "Mex Export Pediment"
{
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
            NotBlank = true;
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
