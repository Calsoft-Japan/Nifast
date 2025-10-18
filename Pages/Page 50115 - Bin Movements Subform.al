page 50115 "Bin Movements Subform"
{
    // NF2.00:CIS.RAM 02/22/17 Created Subform to show on the Bin Movement page

    Editable = false;
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Bin Movement Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Bins; Rec.Bins)
                {
                    Width = 300;
                    ToolTip = 'Specifies the value of the Bins field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    Width = 300;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field(UOM; Rec.UOM)
                {
                    Width = 300;
                    ToolTip = 'Specifies the value of the UOM field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    Width = 300;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
            }
        }
    }

    actions
    {
    }
}

