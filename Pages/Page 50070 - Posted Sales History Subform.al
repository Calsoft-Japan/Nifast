page 50070 "Posted Sales History Subform"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    AutoSplitKey = true;
    Caption = 'Posted Sales History Subform';
    Editable = false;
    PageType = ListPart;
    SourceTable = "Sales Invoice History Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                    Caption = 'Type';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                    Caption = 'Posting Date';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Specifies the value of the Sell-to Customer No. field.';
                    Caption = 'Sell-to Customer No.';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    Caption = 'No.';
                }
                field(Name; Cust.Name)
                {
                    Caption = 'Sell-to Customer Name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Sell-to Customer Name field.';
                }
                field("Cross-Reference No."; Rec."Cross-Reference No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Cross-Reference No. field.';
                    Caption = 'Cross-Reference No.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Variant Code field.';
                    Caption = 'Variant Code';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    Caption = 'Description';
                }
                field("Package Tracking No."; Rec."Package Tracking No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Package Tracking No. field.';
                    Caption = 'Package Tracking No.';
                }
                field(Quantity; Rec.Quantity)
                {
                    BlankZero = true;
                    ToolTip = 'Specifies the value of the Quantity field.';
                    Caption = 'Quantity';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                    Caption = 'Unit of Measure Code';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Unit of Measure field.';
                    Caption = 'Unit of Measure';
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Unit Cost ($) field.';
                    Caption = 'Unit Cost ($)';
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Tax Area Code field.';
                    Caption = 'Tax Area Code';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    BlankZero = true;
                    ToolTip = 'Specifies the value of the Unit Price field.';
                    Caption = 'Unit Price';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                    Caption = 'Amount';
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    BlankZero = true;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Line Amount field.';
                    Caption = 'Line Amount';
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ToolTip = 'Specifies the value of the Amount Including Tax field.';
                    Caption = 'Amount Including Tax';
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    BlankZero = true;
                    ToolTip = 'Specifies the value of the Line Discount % field.';
                    Caption = 'Line Discount %';
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Line Discount Amount field.';
                    Caption = 'Line Discount Amount';
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Allow Invoice Disc. field.';
                    Caption = 'Allow Invoice Disc.';
                }
                field("Job No."; Rec."Job No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Job No. field.';
                    Caption = 'Job No.';
                }
                field("Appl.-to Job Entry"; Rec."Appl.-to Job Entry")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Appl.-to Job Entry field.';
                    Caption = 'Appl.-to Job Entry';
                }
                field("Apply and Close (Job)"; Rec."Apply and Close (Job)")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Apply and Close (Job) field.';
                    Caption = 'Apply and Close (Job)';
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Appl.-to Item Entry field.';
                    Caption = 'Appl.-to Item Entry';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                    Caption = 'Shortcut Dimension 1 Code';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                    Caption = 'Shortcut Dimension 2 Code';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Invoice")
            {
                Caption = '&Invoice';
                Promoted = true;
                Image = Invoice;
                PromotedOnly = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the &Invoice action.';

                trigger OnAction()
                var
                    SalesInvoice: Record "Sales Invoice Header";
                    SalesInvoiceForm: Page "Posted Sales Invoice";
                begin
                    SalesInvoice.SETRANGE("No.", Rec."Document No.");
                    SalesInvoiceForm.SETTABLEVIEW(SalesInvoice);
                    SalesInvoiceForm.RUN();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF NOT Cust.GET(Rec."Sell-to Customer No.") THEN
            CLEAR(Cust);
    end;

    var
        Cust: Record Customer;
}

