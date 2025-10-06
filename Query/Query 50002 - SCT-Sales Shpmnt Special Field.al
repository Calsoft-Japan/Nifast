query 50002 "SCT-Sales Shpmnt Special Field"
{

    elements
    {
        dataitem(QueryElement1000000000;Table111)
        {
            column(Sell_to_Customer_No;"Sell-to Customer No.")
            {
            }
            column(Document_No;"Document No.")
            {
            }
            column(Line_No;"Line No.")
            {
            }
            column(Type;Type)
            {
            }
            column(No;"No.")
            {
            }
            column(Location_Code;"Location Code")
            {
            }
            column(Description;Description)
            {
            }
            column(Unit_of_Measure;"Unit of Measure")
            {
            }
            column(Quantity;Quantity)
            {
            }
            column(FRS_No;"FRS No.")
            {
                ColumnFilter = FRS_No=FILTER(<>'');
            }
        }
    }
}

