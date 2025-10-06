page 50069 "Ship Authorization List"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    CardPageID = "Ship Authorization";
    Editable = false;
    PageType = List;
    SourceTable = Table50015;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Sell-to Customer No.";"Sell-to Customer No.")
                {
                }
                field("No.";"No.")
                {
                }
                field("Sales Order No.";"Sales Order No.")
                {
                }
                field("Reference No.";"Reference No.")
                {
                }
                field("Document Date";"Document Date")
                {
                }
            }
        }
    }

    actions
    {
    }
}

