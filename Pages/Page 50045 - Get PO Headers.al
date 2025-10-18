page 50045 "Get PO Headers"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Currency Code" = CONST(JPY));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ToolTip = 'Specifies the number of the vendor who delivers the products.';
                }
                field("Order Date"; Rec."Order Date")
                {
                    ToolTip = 'Specifies the date when the order was created.';
                }
            }
        }
    }

    actions
    {
    }

    procedure GetSeleted(var PurchHeader: Record "Purchase Header")
    begin
        CurrPage.SETSELECTIONFILTER(PurchHeader);
    end;
}

