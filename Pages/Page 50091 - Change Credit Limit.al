page 50091 "Change Credit Limit"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Customer;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the customer. The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
                    Caption = 'No.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the name of the customer.';
                    Caption = 'Name';
                }
                field("Credit Limit (LCY)"; Rec."Credit Limit (LCY)")
                {
                    ToolTip = 'Specifies the maximum credit (in LCY) that can be extended to the customer.';
                    Caption = 'Credit Limit (LCY)';
                }
                field("Master Customer No."; Rec."Master Customer No.")
                {
                    ToolTip = 'Specifies the value of the Master Customer No. field.';
                    Caption = 'Master Customer No.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Division Code field.';
                    Caption = 'Global Dimension 1 Code';
                }
            }
        }
    }

    actions
    {
    }
}

