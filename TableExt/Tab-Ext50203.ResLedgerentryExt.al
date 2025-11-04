tableextension 50203 "Res Ledger entry Ext" extends "Res. Ledger Entry"
{
    fields
    {
        field(14017757; "Vendor No."; Code[20])
        {
            Caption = '';
            DataClassification = ToBeClassified;
        }
        field(14017758; "Vendor Item No."; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14017759; "Sell-to Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }
        field(14017760; "Salesperson Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser".Code;
        }
        field(14017761; "Purchasing Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Purchasing;
        }
        field(14017762; "Special Order Sales No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14017763; "Special Order Sales Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(14017764; "Prod. Kit Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14017765; "Prod. Kit Order Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

    }
}
