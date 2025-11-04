tableextension 70106 "Packing Station Ext" extends "LAX Packing Station"
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
        field(50030; "Def. Commodity Desc."; Text[100])
        {
        }
        field(50035; "Def. NMFC No."; Text[20])
        {
        }
        field(50037; "Def. Class Code"; Code[10])
        {
        }
        field(70000; "Std. Pack. Label Printer Port"; Code[100])
        {
            Caption = 'Std. Pack. Label Printer';
        }
        field(70001; "UCC/UPC Label Printer Port"; Code[100])
        {
            Caption = 'UCC/UPC Label Printer';
        }
        field(70002; "Label Buffer File"; Text[100])
        {
            Caption = 'Label Buffer File';
        }
        field(70003; "RF-ID Label Printer Port"; Code[100])
        {
            Caption = 'RF-ID Label Printer';
        }
        field(70005; "Label Printing"; Option)
        {
            Caption = 'Label Printing';
            OptionCaption = 'Ports,Printer Name';
            OptionMembers = Ports,"Printer Name";

            trigger OnValidate()
            begin
                IF ("Label Printing" = "Label Printing"::"Printer Name")
                   /* AND ("SHELL Command Type" <> "SHELL Command Type"::".NET Automation")  */THEN BEGIN
                    MESSAGE(Text005,
                      /* FIELDCAPTION("SHELL Command Type"), */ '.NET Automation',
                      FIELDCAPTION("Label Printing"), "Label Printing");
                    "Label Printing" := "Label Printing"::Ports;
                END;
            end;
        }
    }
    var
        Text005: Label 'The %1 must be %2 when %3 is set to %4.', Comment = '%1%2%3%4';
}