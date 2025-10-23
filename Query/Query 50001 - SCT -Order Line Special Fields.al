query 50001 "SCT -Order Line Special Fields"
{

    elements
    {
        dataitem(Sales_Line;"Sales Line")
        {
            column(Document_Type;"Document Type")
            {
            }
            column(Sell_to_Customer_No;"Sell-to Customer No.")
            {
            }
            column(Document_No;"Document No.")
            {
            }
            column(Line_No;"Line No.")
            {
            }
            column(Ran_No;"Ran No.")
            {
            }
            column(Type;Type)
            {
            }
            column(No;"No.")
            {
                ColumnFilter = No=FILTER('TEST');
            }
        }
    }
}

