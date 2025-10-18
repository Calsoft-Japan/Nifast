table 88850 "RenameBins"
{
    fields
    {
        field(1; "Location Code"; Code[10])
        {
            // cleaned
        }
        field(2; "Old Bin"; Code[10])
        {
            // cleaned
        }
        field(3; Currency; Code[10])
        {
            // cleaned
        }
        field(4; "New Bin"; Code[10])
        {
            // cleaned
        }
    }

    keys
    {
        key(Key1; "Location Code", "Old Bin")
        {
        }
    }

    fieldgroups
    {
    }
}
