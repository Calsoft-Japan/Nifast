table 50006 "Label Field Content"
{
    fields
    {
        field(1; "Label Code"; Code[10])
        {
            // cleaned
        }
        field(2; "Field Code"; Code[20])
        {
            NotBlank = true;
        }
        field(7; Description; Text[50])
        {
            // cleaned
        }
        field(15; "Test Print Value"; Text[50])
        {
            // cleaned
        }
        field(20; "No. Series"; Code[10])
        {
            // cleaned
        }
        field(50; "Print Value"; Text[50])
        {
            Description = 'used internally';
        }
    }
    keys
    {
        key(Key1; "Label Code", "Field Code")
        {
        }
    }
}
