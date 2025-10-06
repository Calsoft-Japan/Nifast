page 50056 "TEMP Shipment Method"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    PageType = List;
    SourceTable = Table23;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("No.";"No.")
                {
                    Editable = false;
                }
                field(Name;Name)
                {
                    Editable = false;
                    Enabled = true;
                }
                field("Shipping Agent Code";"Shipping Agent Code")
                {
                }
            }
        }
    }

    actions
    {
    }
}

