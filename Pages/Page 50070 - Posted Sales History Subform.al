page 50070 "Posted Sales History Subform"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    AutoSplitKey = true;
    Caption = 'Posted Sales History Subform';
    Editable = false;
    PageType = ListPart;
    SourceTable = Table50018;

    layout
    {
        area(content)
        {
            repeater()
            {
                field(Type;Type)
                {
                }
                field("Posting Date";"Posting Date")
                {
                }
                field("Sell-to Customer No.";"Sell-to Customer No.")
                {
                }
                field("No.";"No.")
                {
                }
                field(Cust.Name;Cust.Name)
                {
                    Caption = 'Sell-to Customer Name';
                    Editable = false;
                }
                field("Cross-Reference No.";"Cross-Reference No.")
                {
                    Visible = false;
                }
                field("Variant Code";"Variant Code")
                {
                    Visible = false;
                }
                field(Description;Description)
                {
                }
                field("Package Tracking No.";"Package Tracking No.")
                {
                    Visible = false;
                }
                field(Quantity;Quantity)
                {
                    BlankZero = true;
                }
                field("Unit of Measure Code";"Unit of Measure Code")
                {
                }
                field("Unit of Measure";"Unit of Measure")
                {
                    Visible = false;
                }
                field("Unit Cost (LCY)";"Unit Cost (LCY)")
                {
                    Visible = false;
                }
                field("Tax Area Code";"Tax Area Code")
                {
                    Visible = false;
                }
                field("Unit Price";"Unit Price")
                {
                    BlankZero = true;
                }
                field(Amount;Amount)
                {
                }
                field("Line Amount";"Line Amount")
                {
                    BlankZero = true;
                    Visible = false;
                }
                field("Amount Including VAT";"Amount Including VAT")
                {
                }
                field("Line Discount %";"Line Discount %")
                {
                    BlankZero = true;
                }
                field("Line Discount Amount";"Line Discount Amount")
                {
                    Visible = false;
                }
                field("Allow Invoice Disc.";"Allow Invoice Disc.")
                {
                    Visible = false;
                }
                field("Job No.";"Job No.")
                {
                    Visible = false;
                }
                field("Appl.-to Job Entry";"Appl.-to Job Entry")
                {
                    Visible = false;
                }
                field("Apply and Close (Job)";"Apply and Close (Job)")
                {
                    Visible = false;
                }
                field("Appl.-to Item Entry";"Appl.-to Item Entry")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code";"Shortcut Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code";"Shortcut Dimension 2 Code")
                {
                    Visible = false;
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
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SalesInvoice: Record "112";
                    SalesInvoiceForm: Page "132";
                begin
                    SalesInvoice.SETRANGE("No.","Document No.");
                    SalesInvoiceForm.SETTABLEVIEW(SalesInvoice);
                    SalesInvoiceForm.RUN;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF NOT Cust.GET("Sell-to Customer No.") THEN
          CLEAR(Cust);
    end;

    var
        Cust: Record "18";
}

