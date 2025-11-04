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
        field(70000; "FB Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70001; "FB Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(70002; "FB Tag No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70003; "FB Customer Bin"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70004; "License Plate No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70005; "Rework Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(70006; "Rework No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70007; "Final Destination"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
        field(70008; "Container No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
}

