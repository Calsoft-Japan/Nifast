pageextension 50255 "Cash Receipt Journal Ext" extends "Cash Receipt Journal"
{
    //Version NAVW18.00,NAVNA8.00,MEI,CE 1.2;

    layout
    {
        addafter("Account No.")
        {
            field("Recipient Bank Account"; Rec."Recipient Bank Account")
            {
                ApplicationArea = All;
            }
            field("Pymt - Bank Source Code"; Rec."Pymt - Bank Source Code")
            {
                ApplicationArea = All;
                Enabled = false;
                Editable = false;
            }
            field("Pymt - Bank Source Account"; Rec."Pymt - Bank Source Account")
            {
                ApplicationArea = All;
                Enabled = false;
                Editable = false;
            }
            field("Pymt - Bank Target Code"; Rec."Pymt - Bank Target Code")
            {
                ApplicationArea = All;
                Enabled = false;
                Editable = false;
            }
            field("Pymt - Bank Target Account"; Rec."Pymt - Bank Target Account")
            {
                ApplicationArea = All;
                Enabled = false;
                Editable = false;
            }
        }
        moveafter("VAT Prod. Posting Group"; "Payment Method Code")
        addafter("Payment Method Code")
        {
            field("Pymt - Payment Method"; Rec."Pymt - Payment Method")
            {
                ApplicationArea = All;
                Enabled = false;
                Editable = false;
            }
            field("Pymt - Currency Code"; Rec."Pymt - Currency Code")
            {
                ApplicationArea = All;
                Enabled = false;
                Editable = false;
            }
            field("Pymt - Currency Factor"; Rec."Pymt - Currency Factor")
            {
                ApplicationArea = All;
                Enabled = false;
                Editable = false;
            }
        }
        addafter("Applies-to Doc. No.")
        {
            field("XML - UUID"; Rec."XML - UUID")
            {
                ApplicationArea = All;
            }
            field("Pymt - VAT Beneficiary"; Rec."Pymt - VAT Beneficiary")
            {
                ApplicationArea = All;
            }
        }
    }
}