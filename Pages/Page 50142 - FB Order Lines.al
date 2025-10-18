page 50142 "FB Order Lines"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)

    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "FB Line";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Order Date"; Rec."Order Date")
                {
                    ToolTip = 'Specifies the value of the Order Date field.';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Specifies the value of the Sell-to Customer No. field.';
                }
                field("Ship-To Code"; Rec."Ship-To Code")
                {
                    ToolTip = 'Specifies the value of the Ship-To Code field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ToolTip = 'Specifies the value of the Variant Code field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                }
                field("Tag No."; Rec."Tag No.")
                {
                    ToolTip = 'Specifies the value of the Tag No. field.';
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ToolTip = 'Specifies the value of the Lot No. field.';
                }
                field("Customer Bin"; Rec."Customer Bin")
                {
                    ToolTip = 'Specifies the value of the Customer Bin field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("FB Order Type"; Rec."FB Order Type")
                {
                    ToolTip = 'Specifies the value of the FB Order Type field.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'Specifies the value of the External Document No. field.';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ToolTip = 'Specifies the value of the Salesperson Code field.';
                }
                field("Inside Salesperson Code"; Rec."Inside Salesperson Code")
                {
                    ToolTip = 'Specifies the value of the Inside Salesperson Code field.';
                }
                field("Contract No."; Rec."Contract No.")
                {
                    ToolTip = 'Specifies the value of the Contract No. field.';
                }
                field("Cross-Reference No."; Rec."Cross-Reference No.")
                {
                    ToolTip = 'Specifies the value of the Cross-Reference No. field.';
                }
                field("Unit of Measure (Cross Ref.)"; Rec."Unit of Measure (Cross Ref.)")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure (Cross Ref.) field.';
                }
                field("Cross-Reference Type"; Rec."Cross-Reference Type")
                {
                    ToolTip = 'Specifies the value of the Cross-Reference Type field.';
                }
                field("Cross-Reference Type No."; Rec."Cross-Reference Type No.")
                {
                    ToolTip = 'Specifies the value of the Cross-Reference Type No. field.';
                }
            }
        }
    }

    actions
    {
    }
}

