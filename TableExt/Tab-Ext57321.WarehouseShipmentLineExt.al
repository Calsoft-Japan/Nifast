tableextension 57321 "Warehouse Shipment Line Ext" extends "Warehouse Shipment Line"
{
    fields
    {
        field(60002; "Assigned User ID"; Code[20])
        {
            Caption = 'Assigned User ID';
            Editable = false;
        }
        field(60004; "Assignment Date"; Date)
        {
            Caption = 'Assignment Date';
            Editable = false;
        }
        field(60005; "Assignment Time"; Time)
        {
            Caption = 'Assignment Time';
            Editable = false;
        }
        field(14017614; "Special Order Sales No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14017615; "Special Order Sales Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(14017620; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14017621; "External Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14017640; "Destination Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF ("Destination Type" = FILTER(Customer)) "Ship-to Address".Code WHERE("Customer No." = FIELD("Destination No."))
            ELSE IF ("Destination Type" = CONST(Vendor)) "Order Address".Code WHERE("Vendor No." = FIELD("Destination No."));
        }
        field(14017761; "Prod. Kit Order No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14017990; "Qty. to Ship Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(14017999; "License Plate No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(37015592; "Destination Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(37015680; "Delivery Load No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
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
