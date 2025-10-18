page 50055 "Label Field Content Properties"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Label Field Content";

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = false;
                field("Label Code"; Rec."Label Code")
                {
                    ToolTip = 'Specifies the value of the Label Code field.';
                }
                field("Field Code"; Rec."Field Code")
                {
                    ToolTip = 'Specifies the value of the Field Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
            field("No. Series"; Rec."No. Series")
            {
                ToolTip = 'Specifies the value of the No. Series field.';
            }
        }
    }

    actions
    {
    }
}

