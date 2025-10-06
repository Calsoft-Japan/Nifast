page 50115 "Bin Movements Subform"
{
    // NF2.00:CIS.RAM 02/22/17 Created Subform to show on the Bin Movement page

    Editable = false;
    PageType = ListPart;
    SourceTable = Table50041;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Bins;Bins)
                {
                    Width = 300;
                }
                field(Quantity;Quantity)
                {
                    Width = 300;
                }
                field(UOM;UOM)
                {
                    Width = 300;
                }
                field("Location Code";"Location Code")
                {
                    Width = 300;
                }
            }
        }
    }

    actions
    {
    }
}

