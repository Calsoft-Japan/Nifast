page 50047 "Commercial Invoice Mex Form"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    PageType = Card;
    SourceTable = Table50021;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Virtural Operation No.";"Virtural Operation No.")
                {
                }
                field("Country of Origin";"Country of Origin")
                {
                }
                field("Customer No.";"Customer No.")
                {
                }
                field("Item No.";"Item No.")
                {
                }
                field("Custom Agent License No.";"Custom Agent License No.")
                {
                }
                field("Customer Agent E/S";"Customer Agent E/S")
                {
                }
                field("Date of Entry";"Date of Entry")
                {
                }
                field("Summary Entry No.";"Summary Entry No.")
                {
                }
                field("Summary Entry Code";"Summary Entry Code")
                {
                }
                field(Quantity;Quantity)
                {
                    DecimalPlaces = 0:0;
                }
                field(Weight;Weight)
                {
                }
                field("Line Amount";"Line Amount")
                {
                }
                field("Tax Amount";"Tax Amount")
                {
                }
                field("Amount Incl Tax";"Amount Incl Tax")
                {
                }
                field("Doc No";"Doc No")
                {
                }
                field("Doc Line No";"Doc Line No")
                {
                }
                field("Invoice No";"Invoice No")
                {
                }
            }
        }
    }

    actions
    {
    }
}

