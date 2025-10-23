tableextension 55813 "Inventory Posting Setup_Ext" extends "Inventory Posting Setup"
{
    fields
    {
        field(14017610; "Supply Expense Account"; Code[20])
        {
            Caption = '';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
    }
}
