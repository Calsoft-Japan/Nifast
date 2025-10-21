tableextension 57354 "Bin Ext" extends "Bin"
{
    fields
    {
        field(50001; "Location Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Location.Name WHERE(Code = FIELD("Location Code")));
        }
        field(14017991; "Bin Size Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14017994; "Pick Bin Ranking"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(14017997; "Staging Bin"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14018000; "License Plate Enabled"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14018070; "QC Bin"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

    }

}
