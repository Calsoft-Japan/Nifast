tableextension 50081 "Gen. Journal Line Ext" extends "Gen. Journal Line"
{
    fields
    {
        field(50000;"Contract Note No.";Code[20])
        {
            Description = '4x';
            Editable = false;
        }
        field(50001;"Exchange Contract No.";Code[20])
        {
            Description = '4x';
        }
        field(50002;"USD Value";Decimal)
        {
            Description = 'Forex';
        }
        field(50003;"3-Way Applied";Boolean)
        {
            Description = 'Forex';
        }
        field(50004;"3-Way Line applied to";Integer)
        {
            Description = 'Forex';
        }
        field(50010;"EDI Control No.";Code[20])
        {
            // cleaned
        }
        field(52000;"Mex. Factura No.";Code[20])
        {
            Description = 'NiMex';
        }
        field(55000;"XML - UUID";Code[36])
        {
            Caption = 'UUID';
            Description = 'CE 1.2';
        }
        field(55010;"XML - Invoice Folio";Code[50])
        {
            Caption = 'Invoice Folio';
            Description = 'CE 1.2';
        }
        field(55020;"XML - Certified No";Text[20])
        {
            Caption = 'Certified No';
            Description = 'CE 1.2';
        }
        field(55030;"XML - SAT Certified No";Text[20])
        {
            Caption = 'SAT Certified No';
            Description = 'CE 1.2';
        }
        field(55040;"XML - Date/Time Stamped";Text[50])
        {
            Caption = 'Date/Time Stamped';
            Description = 'CE 1.2';
        }
        field(55050;"XML - VAT Registration No";Code[13])
        {
            Caption = 'VAT Registration No';
            Description = 'CE 1.2';
        }
        field(55051;"XML - VAT Receptor";Code[13])
        {
            Description = 'CE 1.2';
        }
        field(55060;"XML - Total Invoice";Decimal)
        {
            Caption = 'Total Invoice';
            Description = 'CE 1.2';
        }
        field(55070;"XML - Payment Method";Code[50])
        {
            Caption = 'Payment Method';
            Description = 'CE 1.2';
        }
        field(55080;"XML - Currency";Code[50])
        {
            Caption = 'Currency';
            Description = 'CE 1.2';
        }
        field(55090;"XML - Currency Factor";Decimal)
        {
            Caption = 'Tipo de Cambio';
            Description = 'CE 1.2';
        }
        field(55100;"Pymt - Payment Method";Code[10])
        {
            Caption = 'SAT - Payment Method';
            Description = 'CE 1.2';
        }
        field(55105;"Pymt - Bank Source Code";Code[20])
        {
            Caption = 'SAT - Bank Source';
            Description = 'CE 1.2';
        }
        field(55110;"Pymt - Bank Source Account";Code[30])
        {
            Caption = 'SAT - Bank Account Source';
            Description = 'CE 1.2';
        }
        field(55115;"Pymt - Bank Source Foreign";Boolean)
        {
            Caption = 'SAT - Source Is Foreign';
            Description = 'CE 1.2';
        }
        field(55120;"Pymt - Bank Target Code";Code[10])
        {
            Caption = 'SAT - Bank Target';
            Description = 'CE 1.2';
        }
        field(55125;"Pymt - Bank Target Account";Code[30])
        {
            Caption = 'SAT- Bank Target Account ';
            Description = 'CE 1.2';
        }
        field(55130;"Pymt - Bank Target Foreign";Boolean)
        {
            Caption = 'SAT - Target Is Foreign';
            Description = 'CE 1.2';
        }
        field(55135;"Pymt - Currency Code";Code[10])
        {
            Caption = 'SAT - Currency';
            Description = 'CE 1.2';
        }
        field(55140;"Pymt - Currency Factor";Decimal)
        {
            Caption = 'SAT - Currency Factor';
            Description = 'CE 1.2';
        }
        field(55145;"Pymt - Beneficiary";Text[150])
        {
            Caption = 'SAT - Beneficiary';
            Description = 'CE 1.2';
        }
        field(55150;"Pymt - VAT Beneficiary";Code[13])
        {
            Caption = 'SAT - VAT Benecifiary';
            Description = 'CE 1.2';
        }
        field(70001;"Original Entry No.";Integer)
        {
            Description = 'Consolidation';
        }
        field(70002;"Original Transaction No.";Integer)
        {
            Description = 'Consolidation';
        }
    }
}
