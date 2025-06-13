tableextension 50027 "Item Ext" extends "Item"
{
    fields
    {
        field(50000;"Require Revision No.";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001;"Carton per Pallet";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50003;"Minimum Inventory Level";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50004;"Lead Time";Decimal)
        {
            AutoFormatType = 0;
            DataClassification = ToBeClassified;
            InitValue = 0;
        }
        field(50005;"Maximum Inventory Level";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50006;"Order Qty.";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50007;"Parts per Pallet";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50008;"Shipping Agent Code";Code[20])
        {
            // cleaned
        }
        field(50010;SEMS;Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50011;Diameter;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50012;Length;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50013;"Carton Weight";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50014;"Purchasing Policy";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50029;"Forecast on/off";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50030;onoff;Boolean)
        {
            DataClassification = ToBeClassified;
            InitValue = true;
        }
        field(50031;"IMDS No.";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50032;"EC No.";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50033;"MPD Item";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50034;"MPD Forecast On/Off";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50035;"MPD Min";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50036;"MPD Max";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50037;"MPD LT";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50038;"MPD Min Ord Qty";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50039;"HS Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50040;"Free Form";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50802;National;Boolean)
        {
            Caption = 'National';
            DataClassification = ToBeClassified;
            Description = 'AKK1606.01';
        }
        field(60000;"HS Tariff Code";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(60001;"HS Tariff Description";Text[30])
        {
            Editable = false;
        }
        field(60005;Fraccion;Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60008;"Material Type";Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(60009;"Material Finish";Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }
}
