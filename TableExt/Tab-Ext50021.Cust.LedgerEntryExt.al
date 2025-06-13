tableextension 50021 "Cust. Ledger Entry Ext" extends "Cust. Ledger Entry"
{
    fields
    {
        field(50000;"EDI Control No.";Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
        field(50001;"Order No.";Code[20])
        {
            Description = 'NIF';
        }
        field(50002;"PSH#";Code[20])
        {
            Description = 'NIF';
        }
        field(50003;"Additional-Currency Amount";Decimal)
        {
            // cleaned
        }
        field(52000;"Mex. Factura No.";Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
        field(55000;"XML - UUID";Code[36])
        {
            Caption = 'UUID';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55010;"XML - Invoice Folio";Code[50])
        {
            Caption = 'Invoice Folio';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55020;"XML - Certified No";Text[20])
        {
            Caption = 'Certified No';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55030;"XML - SAT Certified No";Text[20])
        {
            Caption = 'SAT Certified No';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55040;"XML - Date/Time Stamped";Text[50])
        {
            Caption = 'Date/Time Stamped';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55050;"XML - VAT Registration No";Code[13])
        {
            Caption = 'VAT Registration No';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55051;"XML - VAT Receptor";Code[13])
        {
            Caption = 'VAT Registration No';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55060;"XML - Total Invoice";Decimal)
        {
            Caption = 'Total Invoice';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55070;"XML - Payment Method";Code[50])
        {
            Caption = 'Payment Method';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55080;"XML - Currency";Code[50])
        {
            Caption = 'Currency';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55090;"XML - Currency Factor";Decimal)
        {
            Caption = 'Currency Factor';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
    }
}
