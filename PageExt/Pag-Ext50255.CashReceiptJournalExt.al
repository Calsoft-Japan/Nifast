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
                ToolTip = 'Specifies the bank account that the amount will be transferred to after it has been exported from the payment journal.';
            }
            field("Pymt - Bank Source Code"; Rec."Pymt - Bank Source Code")
            {
                ApplicationArea = All;
                Enabled = false;
                Editable = false;
                ToolTip = 'Specifies the value of the Pymt - Bank Source Code field.';
            }
            field("Pymt - Bank Source Account"; Rec."Pymt - Bank Source Account")
            {
                ApplicationArea = All;
                Enabled = false;
                Editable = false;
                ToolTip = 'Specifies the value of the Pymt - Bank Source Account field.';
            }
            field("Pymt - Bank Target Code"; Rec."Pymt - Bank Target Code")
            {
                ApplicationArea = All;
                Enabled = false;
                Editable = false;
                ToolTip = 'Specifies the value of the Pymt - Bank Target Code field.';
            }
            field("Pymt - Bank Target Account"; Rec."Pymt - Bank Target Account")
            {
                ApplicationArea = All;
                Enabled = false;
                Editable = false;
                ToolTip = 'Specifies the value of the Pymt - Bank Target Account field.';
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
                ToolTip = 'Specifies the value of the Pymt - Payment Method field.';
            }
            field("Pymt - Currency Code"; Rec."Pymt - Currency Code")
            {
                ApplicationArea = All;
                Enabled = false;
                Editable = false;
                ToolTip = 'Specifies the value of the Pymt - Currency Code field.';
            }
            field("Pymt - Currency Factor"; Rec."Pymt - Currency Factor")
            {
                ApplicationArea = All;
                Enabled = false;
                Editable = false;
                ToolTip = 'Specifies the value of the Pymt - Currency Factor field.';
            }
        }
        addafter("Applies-to Doc. No.")
        {
            field("XML - UUID"; Rec."XML - UUID")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the XML - UUID field.';
            }
            field("Pymt - VAT Beneficiary"; Rec."Pymt - VAT Beneficiary")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Pymt - VAT Beneficiary field.';
            }
        }
    }
}