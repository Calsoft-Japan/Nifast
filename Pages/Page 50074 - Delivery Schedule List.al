page 50074 "Delivery Schedule List"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    CardPageID = "Delivery Schedule";
    Editable = false;
    PageType = List;
    SourceTable = Table50012;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Delivery Schedule Batch No.";"Delivery Schedule Batch No.")
                {
                }
                field("Customer No.";"Customer No.")
                {
                }
                field("No.";"No.")
                {
                }
                field("Item No.";"Item No.")
                {
                }
                field("Cross-Reference No.";"Cross-Reference No.")
                {
                }
                field(Description;Description)
                {
                }
            }
        }
    }

    actions
    {
    }
}

