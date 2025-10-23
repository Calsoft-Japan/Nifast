table 50000 "Freight Code"
{
    LookupPageID = 50000;

    fields
    {
        field(1; "Code"; Code[10])
        {
            // cleaned
        }
        field(2; Description; Text[30])
        {
            // cleaned
        }
        field(60000; "COL Code"; Text[10])
        {
            // cleaned
        }
        field(60005; "MPD Code"; Text[10])
        {
            // cleaned
        }
        field(60010; "LEN Code"; Text[10])
        {
            // cleaned
        }
        field(60015; "SAL Code"; Text[10])
        {
            // cleaned
        }
        field(60020; "TN Code"; Text[10])
        {
            // cleaned
        }
        field(60025; "MICH Code"; Text[10])
        {
            // cleaned
        }
        field(60030; "IBN Code"; Text[10])
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; "Code")
        {
        }
    }
    fieldgroups
    {
    }
}
