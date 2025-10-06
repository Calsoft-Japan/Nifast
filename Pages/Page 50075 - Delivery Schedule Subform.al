page 50075 "Delivery Schedule Subform"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = Table50013;

    layout
    {
        area(content)
        {
            repeater()
            {
                field(Type;Type)
                {
                }
                field(Frequency;Frequency)
                {
                }
                field("Forecast Quantity";"Forecast Quantity")
                {
                }
                field("Expected Delivery Date";"Expected Delivery Date")
                {
                }
                field("Start Date";"Start Date")
                {
                }
                field("End Date";"End Date")
                {
                }
                field("Type Code";"Type Code")
                {
                }
                field("Frequency Code";"Frequency Code")
                {
                }
                field("Forecast Unit of Measure";"Forecast Unit of Measure")
                {
                }
            }
        }
    }

    actions
    {
    }
}

