tableextension 50018 "Customer Ext" extends "Customer"
{
    fields
    {
        field(50000;"Freight Code";Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
        field(50001;"Custom Broker";Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
        field(50002;"DUNS Number";Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
        field(50003;"Export Pediment No.";Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
        field(50004;"Due Date Calculation";DateFormula)
        {
            Description = 'NIF';
        }
        field(50005;"Default Model Year";Code[10])
        {
            Description = 'NIF';
            Editable = false;
        }
        field(50006;"SCAC Code";Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'Added on 9/29/17 for Canada ASN';
        }
        field(50007;"Mode of Transport";Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'Added on 9/29/17 for Canada ASN';
        }
        field(50008;"Japanese=A, Non Japanese=B";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50009;"Customs Clearance by";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50010;"EDI ID";Code[30])
        {
            DataClassification = ToBeClassified;
            Description = 'VP EDI use';
        }
        field(50011;"CISCO Code";Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'CISCO Code';
        }
        field(50100;"Master Customer No.";Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
            NotBlank = true;
        }
        field(50101;"No. of Relations";Integer)
        {
            Description = 'NIF';
            Editable = false;
        }
        field(50102;"Master Customer Name";Text[50])
        {
            Description = 'NIF';
            Editable = false;
        }
        field(50500;"Original No.";Code[20])
        {
            Description = 'NIF';
            Editable = false;
        }
        field(60000;"Port of Discharge";Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF Puerto de Desembarque';
        }
        field(60005;"Pitex/Maquila No.";Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
    }
}
