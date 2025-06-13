tableextension 50017 "G/L Entry Ext" extends "G/L Entry"
{
    fields
    {
        field(50000;"Contract Note No.";Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
        field(50001;"Exchange Contract No.";Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
        field(50002;"4X Currency Rate";Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
        field(50003;"4X Amount JPY";Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
        field(50004;"USD Value";Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Forex';
        }
        field(50005;"Currency Code of Customer";Code[10])
        {
            Description = 'Currency Code of Customer';
        }
        field(50006;"Currency Code of Vendor";Code[10])
        {
            Description = 'Currency Code of Vendor';
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
        field(55100;"Pymt - Payment Method";Code[10])
        {
            Caption = 'SAT - Payment Method';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55105;"Pymt - Bank Source Code";Code[20])
        {
            Caption = 'SAT - Bank Source';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55110;"Pymt - Bank Source Account";Code[30])
        {
            Caption = 'SAT - Bank Account Source';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55115;"Pymt - Bank Source Foreign";Boolean)
        {
            Caption = 'SAT - Source Is Foreign';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55120;"Pymt - Bank Target Code";Code[10])
        {
            Caption = 'SAT - Bank Target';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55125;"Pymt - Bank Target Account";Code[30])
        {
            Caption = 'SAT- Bank Target Account ';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55130;"Pymt - Bank Target Foreign";Boolean)
        {
            Caption = 'SAT - Target Is Foreign';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55135;"Pymt - Currency Code";Code[10])
        {
            Caption = 'SAT - Currency';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55140;"Pymt - Currency Factor";Decimal)
        {
            Caption = 'SAT - Currency Factor';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55145;"Pymt - Beneficiary";Text[150])
        {
            Caption = 'SAT - Beneficiary';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55150;"Pymt - VAT Beneficiary";Code[13])
        {
            Caption = 'SAT - VAT Benecifiary';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(70000;"Original Posting Date";Date)
        {
            DataClassification = ToBeClassified;
            Description = 'Consolidation';
        }
        field(70001;"Original Entry No.";Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'Consolidation';
        }
        field(70002;"Original Transaction No.";Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'Consolidation';
        }
    }
}
