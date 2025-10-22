tableextension 70007 "Receive Station Ext" extends "LAX Receive Station"
{
    fields
    {
        field(50000; "Print Server"; Boolean)
        {
            Description = '#9978';
        }
        field(50005; "FTP Command File"; Text[30])
        {
            Description = '#9978';
        }
        field(50010; "Printer Server IP"; Text[30])
        {
            Description = '#9978';
        }
        field(50020; "Printer Name"; Text[250])
        {
            Caption = 'Printer Name';
            Description = '#10005';
            TableRelation = Printer;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50030; "Default Item Receive Rule Code"; Code[10])
        {
            TableRelation = "LAX Receive Rule";
        }
    }
}