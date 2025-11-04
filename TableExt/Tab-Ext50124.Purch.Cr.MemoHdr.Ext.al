tableextension 50124 "Purch. Cr. Memo Hdr. Ext" extends "Purch. Cr. Memo Hdr."
{
    fields
    {
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
        field(70000; "Entered User ID"; code[50])
        {
            TableRelation = User."User Name";
            ValidateTableRelation = false;
            TestTableRelation = false;
            Description = '20--> 50 NF1.00:CIS.NG  10-10-15';
            trigger OnValidate()
            var
                LoginMgt: Codeunit "User Management";
            begin
            end;

            trigger OnLookup()
            var
                LoginMgt: Codeunit "User Management";
            begin
            end;
        }
        field(70001; "Entered Date"; date)
        {
        }
        field(70002; "Entered Time"; Time)
        {
        }
        field(70003; "Ship-to PO No."; code[20])
        {
        }
        field(70004; "Broker/Agent Code"; code[10])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
        }
    }
}
