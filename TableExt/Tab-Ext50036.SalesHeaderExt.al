tableextension 50036 "Sales Header Ext" extends "Sales Header"
{
    fields
    {
        field(50000;"Freight Code";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50001;"Date Sent";Date)
        {
            DataClassification = ToBeClassified;
            Description = 'CIS.001 Added as Biztalk is gone';
        }
        field(50002;"Time Sent";Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50003;"ASN Ship-to Code";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50005;"Model Year";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50006;"SCAC Code";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50007;"Mode of Transport";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50051;"Ship Authorization No.";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50200;"PPS Order";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50205;"PPS File Name";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50206;"EDI PO ID";Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'EDI.01';
            Editable = false;
        }
        field(50207;"EDI Batch ID";Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'EDI.01';
            Editable = false;
        }
        field(50800;"Entry/Exit Date";Date)
        {
            Caption = 'Entry/Exit Date';
            DataClassification = ToBeClassified;
            Description = 'AKK1606.01';
        }
        field(50801;"Entry/Exit No.";Code[20])
        {
            Caption = 'Entry/Exit No.';
            DataClassification = ToBeClassified;
            Description = 'AKK1606.01';
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
