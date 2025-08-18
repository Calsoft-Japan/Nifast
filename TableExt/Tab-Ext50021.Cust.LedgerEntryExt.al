tableextension 50021 "Cust. Ledger Entry Ext" extends "Cust. Ledger Entry"
{
    // version NAVW18.00,NAVNA8.00,SE0.60,NV4.32,NIF1.062,NMX1.000,NIF.N15.C9IN.001,MEI,CE 1.2
    fields
    {
        field(50000; "EDI Control No."; Code[20])
        {
            Description = 'NIF';
        }
        field(50001; "Order No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Invoice Header"."Order No." WHERE("No." = FIELD("Document No.")));
            Description = 'NIF';
        }
        field(50002; "PSH#"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Shipment Header"."No." WHERE("Order No." = field("Order No.")));
            Description = 'NIF';
        }
        field(50003; "Additional-Currency Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("G/L Entry"."Additional-Currency Amount" WHERE("Entry No." = FIELD("Entry No.")));
        }
        field(52000; "Mex. Factura No."; Code[20])
        {
            Description = 'NIF';
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
        //TODO
        /*   field(14017610; "Last Detail Date"; Date)
          {
              CalcFormula = Max("Detailed Cust. Ledg. Entry"."Posting Date" WHERE("Cust. Ledger Entry No." = FIELD("Entry No.")));
              Description = 'NV';
              FieldClass = FlowField;
          }
          field(14018050; "Cr. Mgmt. Comment"; Boolean)
          {
              Description = 'NV    NF1.00:CIS.CM 09-29-15';
              Editable = false;
              Enabled = false;
              FieldClass = FlowField;
          } */
        //TODO
    }
    keys
    {
        key(Key3; "Document Type", "External Document No.", "Customer No.")
        {
        }
        key(Key38; "External Document No.", "Customer No.", "Document Type")
        {
        }
        key(Key39; "Customer No.", "Document Type", Open, "Due Date")
        {
        }
        key(Key40; Open, "Customer No.", "Posting Date")
        {
        }
        key(Key41; "Global Dimension 1 Code", "Customer No.", "Posting Date")
        {
            SumIndexFields = "Sales (LCY)", "Profit (LCY)", "Inv. Discount (LCY)";
        }
        key(Key42; "Document Type", "Document No.", "Customer No.")
        {
        }
    }
    //TODO
    //trigger OnDelete();
    //begin
    /*
    //>> NV 4.32 05.21.04 JWW: Added for Cr. Mgmt
    //CreditManagement.DeleteDocComments(11,'');  //NF1.00:CIS.CM 09-29-15
    //<< NV 4.32 05.21.04 JWW: Added for Cr. Mgmt
    */
    //end;
    //TODO
}
