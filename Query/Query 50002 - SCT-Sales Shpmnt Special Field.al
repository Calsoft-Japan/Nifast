query 50002 "SCT-Sales Shpmnt Special Field"
{

    elements
    {
        dataitem(Sales_Shipment_Line;"Sales Shipment Line")
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

