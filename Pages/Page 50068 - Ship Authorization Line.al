page 50068 "Ship Authorization Line"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    PageType = ListPart;
    SourceTable = Table50016;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Qty. Type";"Qty. Type")
                {
                }
                field("Item No.";"Item No.")
                {
                }
                field("Cross-Reference No.";"Cross-Reference No.")
                {
                }
                field("Cross-Reference Type";"Cross-Reference Type")
                {
                }
                field("Cross-Reference Type No.";"Cross-Reference Type No.")
                {
                }
                field(Description;Description)
                {
                }
                field(Quantity;Quantity)
                {
                }
                field("Unit of Measure";"Unit of Measure")
                {
                    Visible = false;
                }
                field("Ship Authorization No.";"Ship Authorization No.")
                {
                }
                field("Requested Delivery Date";"Requested Delivery Date")
                {
                }
                field("Purchase Order Number";"Purchase Order Number")
                {
                }
                field("Purchase Order Line No.";"Purchase Order Line No.")
                {
                }
                field("Delivery Plan";"Delivery Plan")
                {
                }
                field("Place ID";"Place ID")
                {
                }
                field("Place Description";"Place Description")
                {
                }
            }
        }
    }

    actions
    {
    }

    procedure UpdateForm()
    begin
        CurrPage.UPDATE();
    end;
}

