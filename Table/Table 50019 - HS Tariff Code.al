table 50019 "HS Tariff Code"
{
    DrillDownPageID = 50064;
    LookupPageID = 50064;
    fields
    {
        field(1; "Code"; Code[10])
        {
            NotBlank = true;
        }
        field(2; Description; Text[30])
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
