page 50134 "FB Tag Card"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)

    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "FB Tag";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ToolTip = 'Specifies the value of the Ship-to Code field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ToolTip = 'Specifies the value of the Variant Code field.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                }
                field("Customer Bin"; Rec."Customer Bin")
                {
                    ToolTip = 'Specifies the value of the Customer Bin field.';
                }
                field("Cross-Reference No."; Rec."Cross-Reference No.")
                {
                    ToolTip = 'Specifies the value of the Cross-Reference No. field.';
                }
                field("Contract No."; Rec."Contract No.")
                {
                    ToolTip = 'Specifies the value of the Contract No. field.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'Specifies the value of the External Document No. field.';
                }
                field("Selling Location"; Rec."Selling Location")
                {
                    ToolTip = 'Specifies the value of the Selling Location field.';
                }
                field("Shipping Location"; Rec."Shipping Location")
                {
                    ToolTip = 'Specifies the value of the Shipping Location field.';
                }
                field("Reorder Quantity"; Rec."Reorder Quantity")
                {
                    ToolTip = 'Specifies the value of the Reorder Quantity field.';
                }
                field("Min. Quantity"; Rec."Min. Quantity")
                {
                    ToolTip = 'Specifies the value of the Min. Quantity field.';
                }
                field("Max. Quantity"; Rec."Max. Quantity")
                {
                    ToolTip = 'Specifies the value of the Max. Quantity field.';
                }
                field("FB Order Type"; Rec."FB Order Type")
                {
                    ToolTip = 'Specifies the value of the FB Order Type field.';
                }
                field("Replenishment Method"; Rec."Replenishment Method")
                {
                    ToolTip = 'Specifies the value of the Replenishment Method field.';
                }
                field("Quantity Type"; Rec."Quantity Type")
                {
                    ToolTip = 'Specifies the value of the Quantity Type field.';
                }
            }
        }
    }

    actions
    {
    }
}

