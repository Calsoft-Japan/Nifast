table 80003 "Duplicate Branch Items"
{
    fields
    {
        field(1; "Nifast Item No."; Code[30])
        {
            // cleaned
        }
        field(2; "Navision Item No."; Code[20])
        {
            // cleaned
        }
        field(3; Description; Text[50])
        {
            // cleaned
        }
        field(4; "Location Code"; Code[20])
        {
            // cleaned
        }
        field(5; "Do Not Override"; Boolean)
        {
            // cleaned
        }
        field(6; "Source Loc"; Code[20])
        {
            // cleaned
        }
    }

    keys
    {
        key(Key1; "Nifast Item No.")
        {
        }
    }

    fieldgroups
    {
    }
}
