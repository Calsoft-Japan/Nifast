page 50010 "Certification Results"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    AutoSplitKey = true;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Certifcation Results";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Certification No."; Rec."Certification No.")
                {
                    ToolTip = 'Specifies the value of the Certification No. field.';
                }
                field("Certification Type"; Rec."Certification Type")
                {
                    ToolTip = 'Specifies the value of the Certification Type field.';
                }
                field("Passed Certification"; Rec."Passed Certification")
                {
                    ToolTip = 'Specifies the value of the Passed Certification field.';
                }
                field("Certification Comments"; Rec."Certification Comments")
                {
                    ToolTip = 'Specifies the value of the Certification Comments field.';
                }
                field("Quantity Tested"; Rec."Quantity Tested")
                {
                    ToolTip = 'Specifies the value of the Quantity Tested field.';
                }
                field("Tested By"; Rec."Tested By")
                {
                    ToolTip = 'Specifies the value of the Tested By field.';
                }
                field("Tested Date"; Rec."Tested Date")
                {
                    ToolTip = 'Specifies the value of the Tested Date field.';
                }
                field("Tested Time"; Rec."Tested Time")
                {
                    ToolTip = 'Specifies the value of the Tested Time field.';
                }
            }
        }
    }

    actions
    {
    }
}

