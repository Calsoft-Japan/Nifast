table 99103 "SIFT Levels"
{
    fields
    {
        field(1; "Table No."; Integer)
        {
            // cleaned
        }
        field(2; "Key No."; Integer)
        {
            // cleaned
        }
        field(3; "Bucket No."; Integer)
        {
            // cleaned
        }
        field(10; "SIFT Level"; Text[250])
        {
            // cleaned
        }
        field(11; "SIFT Level 2"; Text[250])
        {
            // cleaned
        }
        field(20; Enabled; Boolean)
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; "Table No.", "Key No.", "Bucket No.")
        {
        }
        key(Key2; Enabled)
        {
        }
    }

    fieldgroups
    {
    }
}
