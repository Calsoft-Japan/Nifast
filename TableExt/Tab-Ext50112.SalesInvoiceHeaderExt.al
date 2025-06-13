tableextension 50112 "Sales Invoice Header Ext" extends "Sales Invoice Header"
{
    fields
    {
        field(50000;"Freight Code";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50001;"Posted Shipment Posting Date";Date)
        {
            // cleaned
        }
        field(50002;"Mex IVA";Code[10])
        {
            DateFormula = false;
        }
        field(50003;"Exchange Rate";Decimal)
        {
            // cleaned
        }
        field(50004;"Country Name";Text[30])
        {
            // cleaned
        }
        field(50005;"PSH#";Code[10])
        {
            // cleaned
        }
        field(50007;"FX Rate on Order Creation Date";Decimal)
        {
            DecimalPlaces = 1:6;
        }
        field(50008;"Amount in C$ from G/L 600";Decimal)
        {
            // cleaned
        }
        field(50009;"FX Rate on Inv Posting Date";Decimal)
        {
            DecimalPlaces = 1:6;
        }
        field(50010;"Amount from G/L 730(Add)";Decimal)
        {
            Description = 'SM 03-11-20';
        }
        field(50011;"Amount from G/L 730(LCY)";Decimal)
        {
            Description = 'SM 03-11-20';
        }
        field(50051;"Ship Authorization No.";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(51000;"Blanket Order No.";Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(52000;"Mex. Factura No.";Code[20])
        {
            DataClassification = ToBeClassified;
            
        }
        field(52001;"Exclude from Virtual Inv.";Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = true;
            
        }
        field(60000;"EDI Control No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60001;"EDI No. Series";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(60101;"Plant Code";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(60102;"Dock Code";Code[10])
        {
            DataClassification = ToBeClassified;
        }
    }
}
