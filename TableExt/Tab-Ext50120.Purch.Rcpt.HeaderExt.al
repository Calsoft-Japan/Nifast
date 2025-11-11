tableextension 50120 "Purch. Rcpt. Header Ext" extends "Purch. Rcpt. Header"
{
    fields
    {
        field(50000; "Contract Note No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Exchange Contract No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "MOSP Reference No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = '4x contract #9806';
        }
        field(50005; "Sail-on Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = '#10044';
        }
        field(50007; "Vessel Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = '#10044';
        }
        field(50008; "Assembly Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NF1.00:CIS.NG  10/06/15';
            Editable = false;
        }
        field(50020; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            DataClassification = ToBeClassified;
        }
        field(50800; "Entry/Exit Date"; Date)
        {
            Caption = 'Entry/Exit Date';
            DataClassification = ToBeClassified;
            Description = 'AKK1606.01';
        }
        field(50801; "Entry/Exit No."; Code[20])
        {
            Caption = 'Entry/Exit No.';
            DataClassification = ToBeClassified;
            Description = 'AKK1606.01';
        }
        field(60000; "Patente Original"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'Custom Agent License No.';
        }
        field(60002; "Aduana E/S"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'Customer Agent E/S';
        }
        field(60010; "Pediment No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'Summary Entry No.';
        }
        field(60012; "CVE Pedimento"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'Summary Entry Code';
        }
        field(60015; "Fecha de entrada"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'Date of Entry';
        }
        field(60020; "Tipo Cambio (1 day before)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(60022; "Tipo Cambio (USD)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(60023; "Tipo Cambio (JPY)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 15;
            MinValue = 0;
        }

        field(70101; "Entered User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = user."User Name";
        }
        field(70102; "Entered Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(70002; "Entered Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(70003; "Ship-to PO No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70004; "Broker/Agent Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'NF1.00:CIS.CM 09-29-15';
        }
        field(70005; "Rework No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NF1.00:CIS.CM 09-29-15';
        }
        field(70006; "Rework Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(70007; "Carrier Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
        }
        field(70008; "Carrier Trailer ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70103; "Bill of Lading No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

    }
}
