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
        field(70000; "Special Order Sales No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70001; "Special Order Sales Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(70002; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(70003; "External Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70004; "Destination Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF ("Destination Type" = FILTER(Customer)) "Ship-to Address".Code WHERE("Customer No." = FIELD("Destination No."))
            ELSE IF ("Destination Type" = CONST(Vendor)) "Order Address".Code WHERE("Vendor No." = FIELD("Destination No."));
        }
        field(70005; "Prod. Kit Order No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70006; "Qty. to Ship Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(70007; "License Plate No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70008; "Destination Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70009; "Delivery Load No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70010; "Delivery Route"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(70011; "Delivery Stop"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
    }


}
