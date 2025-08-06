tableextension 50017 "G/L Entry Ext" extends "G/L Entry"
{
    fields
    {
        field(50000; "Contract Note No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
        field(50001; "Exchange Contract No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
        field(50002; "4X Currency Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
        field(50003; "4X Amount JPY"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
        field(50004; "USD Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Forex';
        }
        field(50005; "Currency Code of Customer"; Code[10])
        {
            CalcFormula = Lookup(Customer."Currency Code" WHERE("No." = FIELD("Source No.")));
            Description = 'Currency Code of Customer';
            FieldClass = FlowField;
        }
        field(50006; "Currency Code of Vendor"; Code[10])
        {
            CalcFormula = Lookup(Vendor."Currency Code" WHERE("No." = FIELD("Source No.")));
            Description = 'Currency Code of Vendor';
            FieldClass = FlowField;
        }
        field(55000; "XML - UUID"; Code[36])
        {
            CaptionML = ENU = 'UUID',
                        ESP = 'UUID';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55010; "XML - Invoice Folio"; Code[50])
        {
            CaptionML = ENU = 'Invoice Folio',
                        ESP = 'Folio Factura';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55020; "XML - Certified No"; Text[20])
        {
            CaptionML = ENU = 'Certified No',
                        ESP = 'Núm. Certificado';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55030; "XML - SAT Certified No"; Text[20])
        {
            CaptionML = ENU = 'SAT Certified No',
                        ESP = 'Núm Certificado SAT';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55040; "XML - Date/Time Stamped"; Text[50])
        {
            CaptionML = ENU = 'Date/Time Stamped',
                        ESP = 'Fecha/Hora Timbrado';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55050; "XML - VAT Registration No"; Code[13])
        {
            CaptionML = ENU = 'VAT Registration No',
                        ESP = 'RFC';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55051; "XML - VAT Receptor"; Code[13])
        {
            CaptionML = ENU = 'VAT Registration No',
                        ESP = 'RFC';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55060; "XML - Total Invoice"; Decimal)
        {
            CaptionML = ENU = 'Total Invoice',
                        ESP = 'Total Factura';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55070; "XML - Payment Method"; Code[50])
        {
            CaptionML = ENU = 'Payment Method',
                        ESP = 'Método de Pago';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55080; "XML - Currency"; Code[50])
        {
            CaptionML = ENU = 'Currency',
                        ESP = 'Moneda';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55090; "XML - Currency Factor"; Decimal)
        {
            CaptionML = ENU = 'Currency Factor',
                        ESP = 'Tipo de Cambio';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55100; "Pymt - Payment Method"; Code[10])
        {
            CaptionML = ENU = 'SAT - Payment Method',
                        ESP = 'SAT - Método Pago';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55105; "Pymt - Bank Source Code"; Code[20])
        {
            CaptionML = ENU = 'SAT - Bank Source',
                        ESP = 'SAT - Banco Origen';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55110; "Pymt - Bank Source Account"; Code[30])
        {
            CaptionML = ENU = 'SAT - Bank Account Source',
                        ESP = 'SAT - Cuenta Banco Origen';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55115; "Pymt - Bank Source Foreign"; Boolean)
        {
            CaptionML = ENU = 'SAT - Source Is Foreign',
                        ESP = 'SAT - Origen Es Extranjero';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55120; "Pymt - Bank Target Code"; Code[10])
        {
            CaptionML = ENU = 'SAT - Bank Target',
                        ESP = 'SAT - Banco Destino';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55125; "Pymt - Bank Target Account"; Code[30])
        {
            CaptionML = ENU = 'SAT- Bank Target Account ',
                        ESP = 'SAT - Cuenta Banco Destino';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55130; "Pymt - Bank Target Foreign"; Boolean)
        {
            CaptionML = ENU = 'SAT - Target Is Foreign',
                        ESP = 'SAT - Destino Es Extranjero';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55135; "Pymt - Currency Code"; Code[10])
        {
            CaptionML = ENU = 'SAT - Currency',
                        ESP = 'SAT - Moneda';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55140; "Pymt - Currency Factor"; Decimal)
        {
            CaptionML = ENU = 'SAT - Currency Factor',
                        ESP = 'SAT - Tipo Cambio';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55145; "Pymt - Beneficiary"; Text[150])
        {
            CaptionML = ENU = 'SAT - Beneficiary',
                        ESP = 'SAT - Beneficiario';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(55150; "Pymt - VAT Beneficiary"; Code[13])
        {
            CaptionML = ENU = 'SAT - VAT Benecifiary',
                        ESP = 'SAT - RFC Beneficiario';
            DataClassification = ToBeClassified;
            Description = 'CE 1.2';
        }
        field(70000; "Original Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'Consolidation';
        }
        field(70001; "Original Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'Consolidation';
        }
        field(70002; "Original Transaction No."; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'Consolidation';
        }
    }
    keys
    {
        key(Key15; "Close Income Statement Dim. ID")
        {
        }
        /*  key(Key16; "Exchange Contract No.", "Document Type")
         {
             SumIndexFields = "4X Amount JPY";
         } */
    }
}
