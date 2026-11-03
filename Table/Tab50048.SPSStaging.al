table 50048 "SPS Staging"
{
    Caption = 'SPS Staging';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            autoIncrement = true;
        }
        field(2; "Posted Shipment No."; code[20])
        {
            Caption = 'Posted Shipment No.';
        }
        field(3; "Package No."; Code[20])
        {
            Caption = 'Package No.';
        }
        field(4; "Package Line No."; Integer)
        {
            Caption = 'Package Line No.';
        }
        field(5; "Serial Number"; Text[250])
        {
            Caption = 'Serial Number';
        }
        field(6; "Units per parcel"; Decimal)
        {
            Caption = 'Units per parcel';
        }
        field(7; "Package Weight"; Decimal)
        {
            Caption = 'Package Weight';
        }
        field(8; "Line Type"; Text[20])
        {
            Caption = 'Line Type';
        }
        field(9; "Master Serial No."; Text[20])
        {
            Caption = 'Master Serial No.';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
