page 50004 "Vessel Names"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    PageType = List;
    SourceTable = "Shipping Vessels";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Vessel Name"; Rec."Vessel Name")
                {
                    ToolTip = 'Specifies the value of the Vessel Name field.';
                }
            }
        }
    }

    actions
    {
    }
}

