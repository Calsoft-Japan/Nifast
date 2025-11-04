tableextension 57303 "Bin Type_Ext" extends "Bin Type"
{
    fields
    {
        field(70000; "License Plate Enabled"; Boolean)
        {
            Caption = '';
            DataClassification = ToBeClassified;
        }
        field(70001; QC; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                CheckCombination(CurrFieldNo);
            end;
        }
    }
}
