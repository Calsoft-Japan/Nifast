page 50045 "Get PO Headers"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    Editable = false;
    PageType = List;
    SourceTable = Table38;
    SourceTableView = WHERE(Currency Code=CONST(JPY));

    layout
    {
        area(content)
        {
            repeater()
            {
                field("No.";"No.")
                {
                }
                field("Buy-from Vendor No.";"Buy-from Vendor No.")
                {
                }
                field("Order Date";"Order Date")
                {
                }
            }
        }
    }

    actions
    {
    }

    procedure GetSeleted(var PurchHeader: Record "38")
    begin
        CurrPage.SETSELECTIONFILTER(PurchHeader);
    end;
}

