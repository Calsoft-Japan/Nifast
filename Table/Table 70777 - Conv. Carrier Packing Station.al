table 70777 "Conv. Carrier Packing Station"
{
    Caption = 'Packing Station';
    //TODO
    // LookupPageID = 14000722;
    //TODO
    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(11; Description; Text[30])
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
