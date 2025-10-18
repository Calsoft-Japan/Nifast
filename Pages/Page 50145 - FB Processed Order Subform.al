page 50145 "FB Processed Order Subform"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)
    // NIF 01-12-06 added "Replenishment Method" to the lines

    Editable = false;
    PageType = ListPart;
    UsageCategory = None;
    SourceTable = "FB Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Tag No."; Rec."Tag No.")
                {
                    ToolTip = 'Specifies the value of the Tag No. field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    Visible = false;
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
                field("Lot No."; Rec."Lot No.")
                {
                    ToolTip = 'Specifies the value of the Lot No. field.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'Specifies the value of the External Document No. field.';
                }
                field("Customer Bin"; Rec."Customer Bin")
                {
                    ToolTip = 'Specifies the value of the Customer Bin field.';
                }
                field("Replenishment Method"; Rec."Replenishment Method")
                {
                    ToolTip = 'Specifies the value of the Replenishment Method field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Cross-Reference No."; Rec."Cross-Reference No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Cross-Reference No. field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
        }
    }
}

