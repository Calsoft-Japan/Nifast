table 50032 "SAT Account Codes"
{
    Caption = 'SAT Account Code';
    DrillDownPageID = 50150;
    LookupPageID = 50150;

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
        field(3; Level; Integer)
        {
            Caption = 'Level';
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
