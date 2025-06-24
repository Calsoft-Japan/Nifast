table 99992 "Label Mapping Table"
{
    Caption = 'Label Mapping Table';

    fields
    {
        field(1; "Table No."; Integer)
        {
            Caption = 'Table No.';
            NotBlank = true;
        }
        field(11; "Table Name"; Text[30])
        {
            Caption = 'Table Name';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Table No.")
        {
        }
    }



}

