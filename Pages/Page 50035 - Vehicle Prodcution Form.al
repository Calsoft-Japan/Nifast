page 50035 "Vehicle Prodcution Form"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Vehicle Production";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field(Model; Rec.Model)
                {
                    ToolTip = 'Specifies the value of the Model field.';
                }
                field("EC Level"; Rec."EC Level")
                {
                    ToolTip = 'Specifies the value of the EC Level field.';
                }
                field("Applicable Std"; Rec."Applicable Std")
                {
                    ToolTip = 'Specifies the value of the Applicable Std field.';
                }
                field(EMU; Rec.EMU)
                {
                    Caption = 'Date';
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(OEM; Rec.OEM)
                {
                    Caption = 'EWU';
                    ToolTip = 'Specifies the value of the EWU field.';
                }
                field("Final Customer"; Rec."Final Customer")
                {
                    Caption = 'PPV';
                    ToolTip = 'Specifies the value of the PPV field.';
                }
                field(Per; Rec.Per)
                {
                    ToolTip = 'Specifies the value of the Per field.';
                }
            }
        }
    }

    actions
    {
    }
}

