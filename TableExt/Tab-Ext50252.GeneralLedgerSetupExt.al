tableextension 50252 "General Posting Setup _Ext" extends "General Posting Setup"
{
    fields
    {
        field(70000; "Gross Profit Min %"; Decimal)
        {
            Caption = '';
            DataClassification = ToBeClassified;
        }
        field(70001; "Gross Profit Max %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70002; "Gross Profit Option"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Warning,Override,Denied;
        }
        field(70003; "Resource Allocation"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
    }
}
