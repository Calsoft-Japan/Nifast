tableextension 50203 "Res Ledger entry Ext" extends "Res. Ledger Entry"
{
    fields
    {
        field(70000; "Vendor No."; Code[20])
        {
            Caption = '';
            DataClassification = ToBeClassified;
        }
        field(70001; "Vendor Item No."; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70002; "Sell-to Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }
        field(70003; "Salesperson Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser".Code;
        }
        field(70004; "Purchasing Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Purchasing;
        }
        field(70005; "Special Order Sales No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70006; "Special Order Sales Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(70007; "Prod. Kit Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70008; "Prod. Kit Order Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

    }
}
