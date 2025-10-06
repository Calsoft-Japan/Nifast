page 50046 "Exchange Contract Subform"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    DelayedInsert = true;
    PageType = List;
    SourceTable = Table50014;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Document No.";"Document No.")
                {
                }
                field("Item No.";"Item No.")
                {
                }
                field(Description;Description)
                {
                }
                field("Unit of Measure";"Unit of Measure")
                {
                }
                field(Quantity;Quantity)
                {
                }
                field(Amount;Amount)
                {
                }
                field("Amount Including VAT";"Amount Including VAT")
                {
                }
                field("Unit Price (LCY)";"Unit Price (LCY)")
                {
                }
                field("Shortcut Dimension 1 Code";"Shortcut Dimension 1 Code")
                {
                }
                field("Requested Reciept Date";"Requested Reciept Date")
                {
                }
                field("Line No.";"Line No.")
                {
                }
                field("Exchange Contract No.";"Exchange Contract No.")
                {
                }
            }
        }
    }

    actions
    {
    }
}

