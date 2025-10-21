tableextension 50252 "General Ledger Setup _Ext" extends "General Ledger Setup"
{
    fields
    {
        field(14017628; "Gross Profit Min %"; Decimal)
        {
            Caption = '';
            DataClassification = ToBeClassified;
        }
        field(14017629; "Gross Profit Max %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14017754; "Gross Profit Option"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Warning,Override,Denied;
        }
        field(14017906; "Resource Allocation"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
    }
}
