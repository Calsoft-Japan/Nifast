page 50051 "Label Field Content"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade
    // CIF.RAM 06/29/22 Added field <No. Series> to the page

    DataCaptionFields = "Label Code";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Label Field Content";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Field Code"; Rec."Field Code")
                {
                    ToolTip = 'Specifies the value of the Field Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Test Print Value"; Rec."Test Print Value")
                {
                    ToolTip = 'Specifies the value of the Test Print Value field.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field.';
                }
                field("Print Value"; Rec."Print Value")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Print Value field.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Label Field")
            {
                Caption = '&Label Field';
                action("&Properties")
                {
                    Caption = '&Properties';
                    Image = Properties;
                    RunObject = Page "Label Field Content Properties";
                    RunPageLink = "Label Code" = FIELD("Label Code"),
                                  "Field Code" = FIELD("Field Code");
                    ToolTip = 'Executes the &Properties action.';
                }
            }
        }
    }
}

