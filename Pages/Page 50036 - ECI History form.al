page 50036 "ECI History form"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Vendor Forecast Ledger Entry";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Div Code"; Rec."Div Code")
                {
                    ToolTip = 'Specifies the value of the Div Code field.';
                }
                field("Forecast Qty for Vendor"; Rec."Forecast Qty for Vendor")
                {
                    ToolTip = 'Specifies the value of the Forecast Qty for Vendor field.';
                }
                field("Order Date"; Rec."Order Date")
                {
                    ToolTip = 'Specifies the value of the Order Date field.';
                }
            }
        }
    }

    actions
    {
    }
}

