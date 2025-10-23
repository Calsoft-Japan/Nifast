page 50147 "Lot Bin Content Buffer"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Lot Entry Functionality Renumber)

    Editable = false;
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Bin Content Buffer";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                    Caption = 'Location Code';
                }
                field("Zone Code"; Rec."Zone Code")
                {
                    ToolTip = 'Specifies the value of the Zone Code field.';
                    Caption = 'Zone Code';
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ToolTip = 'Specifies the value of the Bin Code field.';
                    Caption = 'Bin Code';
                }
                // field("QC Bin"; Rec."QC Bin")
                // {
                //     ToolTip = 'Specifies the value of the QC Bin field.';
                //     Caption = 'QC Bin';
                // }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                    Caption = 'Item No.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ToolTip = 'Specifies the value of the Variant Code field.';
                    Caption = 'Variant Code';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                    Caption = 'Unit of Measure Code';
                }
                field("Qty. to Handle (Base)"; Rec."Qty. to Handle (Base)")
                {
                    ToolTip = 'Specifies the value of the Qty. to Handle (Base) field.';
                    Caption = 'Qty. to Handle (Base)';
                }
                field(Cubage; Rec.Cubage)
                {
                    ToolTip = 'Specifies the value of the Cubage field.';
                    Caption = 'Cubage';
                }
                field(Weight; Rec.Weight)
                {
                    ToolTip = 'Specifies the value of the Weight field.';
                    Caption = 'Weight';
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ToolTip = 'Specifies the value of the Lot No. field.';
                    Caption = 'Lot No.';
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ToolTip = 'Specifies the value of the Serial No. field.';
                    Caption = 'Serial No.';
                }
            }
        }
    }

    actions
    {
    }
}

