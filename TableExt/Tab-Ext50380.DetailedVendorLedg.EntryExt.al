tableextension 50380 "Detailed Vendor Ledg. Entry Ex" extends "Detailed Vendor Ledg. Entry"
{
    // version NAVW18.00,NIF1.062,MEI,CE 1.2
    fields
    {
        field(50001; "Applies-to Doc No."; Code[20])
        {
            // cleaned
            FieldClass = FlowField;
            CalcFormula = Lookup("Vendor Ledger Entry"."Applies-to Doc. No." WHERE("Entry No." = FIELD("Vendor Ledger Entry No.")));
        }
        field(55000; "XML - UUID"; Code[36])
        {
            CaptionML = ENU = 'UUID',
                        ESP = 'UUID';
            Description = 'CE 1.2';
        }
        field(55010; "XML - Invoice Folio"; Code[50])
        {
            CaptionML = ENU = 'Invoice Folio',
                        ESP = 'Folio Factura';
            Description = 'CE 1.2';
        }
        field(55020; "XML - Certified No"; Text[20])
        {
            CaptionML = ENU = 'Certified No',
                        ESP = 'Núm. Certificado';
            Description = 'CE 1.2';
        }
        field(55030; "XML - SAT Certified No"; Text[20])
        {
            CaptionML = ENU = 'SAT Certified No',
                        ESP = 'Núm Certificado SAT';
            Description = 'CE 1.2';
        }
        field(55040; "XML - Date/Time Stamped"; Text[50])
        {
            CaptionML = ENU = 'Date/Time Stamped',
                        ESP = 'Fecha/Hora Timbrado';
            Description = 'CE 1.2';
        }
        field(55050; "XML - VAT Registration No"; Code[13])
        {
            CaptionML = ENU = 'VAT Registration No',
                        ESP = 'RFC';
            Description = 'CE 1.2';
        }
        field(55051; "XML - VAT Receptor"; Code[13])
        {
            CaptionML = ENU = 'VAT Registration No',
                        ESP = 'RFC';
            Description = 'CE 1.2';
        }
        field(55060; "XML - Total Invoice"; Decimal)
        {
            CaptionML = ENU = 'Total Invoice',
                        ESP = 'Total Factura';
            Description = 'CE 1.2';
        }
        field(55070; "XML - Payment Method"; Code[50])
        {
            CaptionML = ENU = 'Payment Method',
                        ESP = 'Método de Pago';
            Description = 'CE 1.2';
        }
        field(55080; "XML - Currency"; Code[50])
        {
            CaptionML = ENU = 'Currency',
                        ESP = 'Moneda';
            Description = 'CE 1.2';
        }
        field(55090; "XML - Currency Factor"; Decimal)
        {
            CaptionML = ENU = 'Currency Factor',
                        ESP = 'Tipo de Cambio';
            Description = 'CE 1.2';
        }
        field(55091; "vendor posting group"; Code[10])
        {
            // cleaned
            FieldClass = FlowField;
            CalcFormula = Lookup("Vendor Ledger Entry"."Vendor Posting Group" WHERE("Entry No." = FIELD("Vendor Ledger Entry No.")));

        }
    }
    keys
    {
        key(Key13; "Initial Document Type", "Vendor No.", "Posting Date", "Currency Code", "Entry Type")
        {
            SumIndexFields = Amount, "Amount (LCY)";
        }
    }
}
