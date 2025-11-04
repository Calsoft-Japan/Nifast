tableextension 55745 "Transfer Shipment Line Ext" extends "Transfer Shipment Line"
{
    fields
    {
        field(50000; "Total Parcels"; Decimal)
        {
            DecimalPlaces = 0 : 2;
            Description = '#10069';
        }
        field(51000; "Source PO No."; Code[20])
        {

        }
        field(51010; "Contract Note No."; Code[20])
        {

        }
        field(37015330; "FB Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(37015331; "FB Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(37015332; "FB Tag No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(37015333; "FB Customer Bin"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14017999; "License Plate No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14017931; "Rework Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(14017930; "Rework No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14017791; "Final Destination"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
        field(14017790; "Container No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
}

