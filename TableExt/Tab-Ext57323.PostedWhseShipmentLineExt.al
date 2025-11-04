tableextension 57323 "Posted Whse Shipment Line_Ext" extends "Posted Whse. Shipment Line"
{
    fields
    {
        field(70000; "Special Order Sales No."; Code[20])
        {
            Caption = '';
            DataClassification = ToBeClassified;
        }
        field(70001; "Special Order Sales Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(70002; "External Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70003; "Prod. Kit Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70004; "Prod. Kit Order Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70005; "Qty. to Ship Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70006; "License Plate No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70007; "Delivery Load No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70008; "Delivery Route"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(70009; "Delivery Stop"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
    }
}


