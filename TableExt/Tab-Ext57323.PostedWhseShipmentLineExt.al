tableextension 57323 "Posted Whse Shipment Line_Ext" extends "Posted Whse. Shipment Line"
{
    fields
    {
        field(14017614; "Special Order Sales No."; Code[20])
        {
            Caption = '';
            DataClassification = ToBeClassified;
        }
        field(14017615; "Special Order Sales Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(14017621; "External Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14017761; "Prod. Kit Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14017762; "Prod. Kit Order Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14017990; "Qty. to Ship Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14017999; "License Plate No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(37015680; "Delivery Load No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(37015681; "Delivery Route"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(37015682; "Delivery Stop"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
    }
}


