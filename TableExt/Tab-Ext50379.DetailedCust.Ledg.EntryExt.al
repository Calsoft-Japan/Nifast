tableextension 50379 "Detailed Cust. Ledg. Entry Ext" extends "Detailed Cust. Ledg. Entry"
{
    fields
    {
        field(50001; "Applied to Doc No."; Code[20])
        {
            // cleaned
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Cust. Ledger Entry"."Applies-to Doc. No." where("Entry No." = field("Cust. Ledger Entry No.")));
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
        field(55091; "Customer Posting Group"; Code[20])
        {
            // cleaned
            Editable = false;
            CalcFormula = lookup("Cust. Ledger Entry"."Customer Posting Group" where("Entry No." = field("Cust. Ledger Entry No.")));
            FieldClass = FlowField;

        }

    }
    keys
    {
        key(Key50000; "Initial Document Type", "Customer No.", "Posting Date", "Currency Code", "Entry Type")
        {
            SumIndexFields = Amount, "Amount (LCY)";
        }
        key(Key50001; "Initial Entry Global Dim. 1", "Customer No.", "Posting Date")
        {
            SumIndexFields = "Amount (LCY)";
        }
        key(Key50002; "Initial Entry Global Dim. 1", "Customer No.", "Entry Type", "Posting Date")
        {
            SumIndexFields = "Amount (LCY)";
        }
    }
}
