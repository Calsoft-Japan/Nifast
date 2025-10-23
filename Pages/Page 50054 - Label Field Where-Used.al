page 50054 "Label Field Where-Used"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    Editable = false;
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
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Label")
            {
                Caption = '&Label';
                action("&Card")
                {
                    Caption = '&Card';
                    Image = EditLines;
                    RunObject = Page "Label Card NIF";
                    RunPageLink = Code = FIELD("Label Code");
                    ToolTip = 'Executes the &Card action.';
                }
            }
        }
    }
}

