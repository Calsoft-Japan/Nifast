tableextension 70105 "Label Header Ext" extends "LAX Label Header"
{
    fields
    {
        field(50000; "No. of Fields"; Integer)
        {
            CalcFormula = Count("Label Field Content" WHERE("Label Code" = FIELD(Code)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005; "Format Path"; Text[250])
        {
        }
        field(50006; "Label Type"; Option)
        {
            Description = 'CIS.RAM050322';
            OptionCaption = ' ,Const+Date+Serial';
            OptionMembers = " ","Const+Date+Serial";
        }
        field(50007; "Label Constant"; Text[30])
        {
            Description = 'CIS.RAM050322';
        }
    }
}