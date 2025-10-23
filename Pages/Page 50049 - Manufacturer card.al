page 50049 "Manufacturer card"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = Manufacturer;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
            }
        }
    }

    actions
    {
    }
}

