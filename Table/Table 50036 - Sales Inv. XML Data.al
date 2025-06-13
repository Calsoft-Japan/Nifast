table 50036 "Sales Inv. XML Data"
{
    fields
    {
        field(10;"No.";Code[20])
        {
            // cleaned
        }
        field(20;"XML - UUID";Code[36])
        {
            Caption = 'UUID';
            Description = 'CE 1.2';
        }
        field(30;"XML - Invoice Folio";Code[50])
        {
            Caption = 'Invoice Folio';
            Description = 'CE 1.2';
        }
        field(40;"XML - Certified No";Text[20])
        {
            Caption = 'Certified No';
            Description = 'CE 1.2';
        }
        field(50;"XML - SAT Certified No";Text[20])
        {
            Caption = 'SAT Certified No';
            Description = 'CE 1.2';
        }
        field(60;"XML - Date/Time Stamped";Text[50])
        {
            Caption = 'Date/Time Stamped';
            Description = 'CE 1.2';
        }
        field(70;"XML - VAT Registration No";Code[13])
        {
            Caption = 'VAT Registration No';
            Description = 'CE 1.2';
        }
        field(80;"XML - VAT Receptor";Code[13])
        {
            Caption = 'VAT Registration No';
            Description = 'CE 1.2';
        }
        field(90;"XML - Total Invoice";Decimal)
        {
            Caption = 'Total Invoice';
            Description = 'CE 1.2';
        }
        field(100;"XML - Payment Method";Code[50])
        {
            Caption = 'Payment Method';
            Description = 'CE 1.2';
        }
        field(110;"XML - Currency";Code[50])
        {
            Caption = 'Currency';
            Description = 'CE 1.2';
        }
        field(120;"XML - Currency Factor";Decimal)
        {
            Caption = 'Currency Factor';
            Description = 'CE 1.2';
        }
        field(130;XML;BLOB)
        {
            Caption = 'XML';
            Description = 'CE 1.2';
        }
        field(140;PDF;BLOB)
        {
            Caption = 'PDF';
            Description = 'CE 1.2';
        }
    }
}
