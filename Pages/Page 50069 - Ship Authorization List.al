page 50069 "Ship Authorization List"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    CardPageID = "Ship Authorization";
    Editable = false;
    ApplicationArea = All;
    UsageCategory = Lists;
    PageType = List;
    SourceTable = "Ship Authorization";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Specifies the value of the Sell-to Customer No. field.';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ToolTip = 'Specifies the value of the Sales Order No. field.';
                }
                field("Reference No."; Rec."Reference No.")
                {
                    ToolTip = 'Specifies the value of the Reference No. field.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the value of the Document Date field.';
                }
            }
        }
    }

    actions
    {
    }
}

