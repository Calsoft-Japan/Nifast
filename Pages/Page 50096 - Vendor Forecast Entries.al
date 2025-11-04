page 50096 "Vendor Forecast Entries"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Vendor Forecast Ledger Entry";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                    Caption = 'Item No.';
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    Caption = 'Vendor No.';
                    ToolTip = 'Specifies the value of the Vendor No. field.';
                }
                field("Div Code"; Rec."Div Code")
                {
                    Caption = 'Div Code';
                    ToolTip = 'Specifies the value of the Div Code field.';
                }
                field("Forecast Qty for Vendor"; Rec."Forecast Qty for Vendor")
                {
                    Caption = 'Forecast Qty for Vendor';
                    ToolTip = 'Specifies the value of the Forecast Qty for Vendor field.';
                }
                field("Receive Date"; Rec."Receive Date")
                {
                    Caption = 'Receive Date';
                    ToolTip = 'Specifies the value of the Receive Date field.';
                }
                field("Order Date"; Rec."Order Date")
                {
                    Caption = 'Order Date';
                    ToolTip = 'Specifies the value of the Order Date field.';
                }
            }
        }
    }

    actions
    {
    }
}

