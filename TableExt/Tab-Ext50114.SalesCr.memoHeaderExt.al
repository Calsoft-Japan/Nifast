tableextension 50114 "Sales Cr.Memo Header Ext" extends "Sales Cr.Memo Header"
{
    fields
    {
        field(50000; "Freight Code"; Code[10])
        {
            // cleaned
        }
        field(50800; "Entry/Exit Date"; Date)
        {
            Caption = 'Entry/Exit Date';
            Description = 'AKK1606.01';
            Editable = false;
        }
        field(50801; "Entry/Exit No."; Code[20])
        {
            Caption = 'Entry/Exit No.';
            Description = 'AKK1606.01';
            Editable = false;
        }
        field(51000; "Blanket Order No."; Code[20])
        {
            Editable = false;
        }
        field(52000; "Mex. Factura No."; Code[20])
        {
            // cleaned
        }
        field(52001; "Exclude from Virtual Inv."; Boolean)
        {
            // cleaned
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

        field(50001; "Inside Salesperson Code"; Code[10])//NV-FB 14017617->50001 BC Upgrade
        { }
    }
}
