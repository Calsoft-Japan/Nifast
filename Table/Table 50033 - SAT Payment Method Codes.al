table 50033 "SAT Payment Method Codes"
{
    Caption = 'SAT Payment Method Code';
    DrillDownPageID = 50151;
    LookupPageID = 50151;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
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
