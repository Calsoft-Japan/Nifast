tableextension 50122 "Purch. Inv. Header Ext" extends "Purch. Inv. Header"
{
    fields
    {
        field(50000; "Contract Note No."; Code[20])
        {
            Description = '4x contract #9806';
        }
        field(50001; "Exchange Contract No."; Code[20])
        {
            Description = '4x contract #9806';
        }
        field(50002; "MOSP Reference No."; Code[20])
        {
            Description = '4x contract #9806';
        }
        field(50003; "Total USD Value"; Decimal)
        {
            Description = 'Forex';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("Purch. Inv. Line"."USD Value" WHERE("Document No." = FIELD("No.")));
        }
        field(50005; "Sail-on Date"; Date)
        {
            Description = '#10044';
        }
        field(50007; "Vessel Name"; Text[50])
        {
            Description = '#10044';
            TableRelation = "Shipping Vessels";
        }
        field(50008; "Assembly Order No."; Code[20])
        {
            Description = 'NF1.00:CIS.NG  10/06/15';
            Editable = false;
            TableRelation = "Assembly Header"."No." WHERE("Document Type" = CONST(Order));
        }
        field(50800; "Entry/Exit Date"; Date)
        {
            Caption = 'Entry/Exit Date';
            Description = 'AKK1606.01';
        }
        field(50801; "Entry/Exit No."; Code[20])
        {
            Caption = 'Entry/Exit No.';
            Description = 'AKK1606.01';
        }
        field(55000; "XML - UUID"; Code[36])
        {
            Caption = 'UUID';
            Description = 'CE 1.2';
        }
        field(55010; "XML - Invoice Folio"; Code[50])
        {
            Caption = 'Invoice Folio';
            Description = 'CE 1.2';
        }
        field(55020; "XML - Certified No"; Text[20])
        {
            Caption = 'Certified No';
            Description = 'CE 1.2';
        }
        field(55030; "XML - SAT Certified No"; Text[20])
        {
            Caption = 'SAT Certified No';
            Description = 'CE 1.2';
        }
        field(55040; "XML - Date/Time Stamped"; Text[50])
        {
            Caption = 'Date/Time Stamped';
            Description = 'CE 1.2';
        }
        field(55050; "XML - VAT Registration No"; Code[13])
        {
            Caption = 'VAT Registration No';
            Description = 'CE 1.2';
        }
        field(55051; "XML - VAT Receptor"; Code[13])
        {
            Caption = 'VAT Registration No';
            Description = 'CE 1.2';
        }
        field(55060; "XML - Total Invoice"; Decimal)
        {
            Caption = 'Total Invoice';
            Description = 'CE 1.2';
        }
        field(55070; "XML - Payment Method"; Code[50])
        {
            Caption = 'Payment Method';
            Description = 'CE 1.2';
        }
        field(55080; "XML - Currency"; Code[50])
        {
            Caption = 'Currency';
            Description = 'CE 1.2';
        }
        field(55090; "XML - Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            Description = 'CE 1.2';
        }
        field(55300; XML; BLOB)
        {
            Caption = 'XML';
            Description = 'CE 1.2';
        }
        field(55310; PDF; BLOB)
        {
            Caption = 'PDF';
            Description = 'CE 1.2';
        }
        field(60000; "Patente Orignal"; Code[10])
        {
            Description = 'Custom Agent License No.';
        }
        field(60002; "Aduana E/S"; Code[10])
        {
            Description = 'Customer Agent E/S';
        }
        field(60010; "Pediment No."; Code[10])
        {
            Description = 'Summary Entry No.';
        }
        field(60012; "CVE Pedimento"; Code[10])
        {
            Description = 'Summary Entry Code';
            TableRelation = "CVE Pedimento";
        }
        field(60015; "Fecha de entrada"; Date)
        {
            Description = 'Date of Entry';
        }
        field(60020; "Tipo Cambio (1 day before)"; Decimal)
        {
            DecimalPlaces = 0 : 15;
            MinValue = 0;
        }
        field(60022; "Tipo Cambio (USD)"; Decimal)
        {
            DecimalPlaces = 0 : 15;
            MinValue = 0;
        }
        field(60023; "Tipo Cambio (JPY)"; Decimal)
        {
            DecimalPlaces = 0 : 15;
            MinValue = 0;
        }
        field(70000; "Entered User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }
        field(70102; "Entered Date"; dATE)
        {
            DataClassification = ToBeClassified;
        }
        field(70002; "Entered Time"; tiME)
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
    }
}