page 50155 "WithHolding Setup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Withholding Groups";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Withholding Group"; Rec."Withholding Group")
                {
                    ToolTip = 'Specifies the value of the Withholding Group field.';
                }
                field("Withholding Percentage"; Rec."Withholding Percentage")
                {
                    ToolTip = 'Specifies the value of the Withholding Percentage field.';
                }
                field("Purch Withholding Account"; Rec."Purch Withholding Account")
                {
                    ToolTip = 'Specifies the value of the Purch Withholding Account field.';
                }
                field("Income Tax"; Rec."Income Tax")
                {
                    ToolTip = 'Specifies the value of the Income Tax field.';
                }
                field("VAT Tax"; Rec."VAT Tax")
                {
                    ToolTip = 'Specifies the value of the VAT Tax field.';
                }
            }
        }
    }

    actions
    {
    }
}

