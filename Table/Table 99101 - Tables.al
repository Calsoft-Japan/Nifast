table 99101 "Tables"
{
    DrillDownPageID = 99102;
    LookupPageID = 99102;
    fields
    {
        field(1; "Table No."; Integer)
        {
            // cleaned
        }
        field(2; "Table Name"; Text[50])
        {
            // cleaned
        }
        field(3; "No. of Records"; Integer)
        {
            // cleaned
        }
        field(4; Enabled; Integer)
        {
            // cleaned
            FieldClass = Normal;
        }
        field(5; Disabled; Integer)
        {
            // cleaned
            FieldClass = Normal;
        }
        field(6; Modified; Boolean)
        {
            // cleaned
        }
        field(7; Date; Date)
        {
            // cleaned
        }
        field(8; Time; Time)
        {
            // cleaned
        }
        field(9; "Version List"; Text[100])
        {
            // cleaned
        }
        field(10; Caption; Text[100])
        {
            // cleaned
        }
        field(11; "Cost Per Record"; Integer)
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; "Table No.")
        {
        }
        key(Key2; "No. of Records")
        {
        }
        key(Key3; Modified, Date, Time)
        {
        }
        key(Key4; Enabled)
        {
        }
        key(Key5; "Cost Per Record")
        {
        }
    }

    fieldgroups
    {
    }
}
