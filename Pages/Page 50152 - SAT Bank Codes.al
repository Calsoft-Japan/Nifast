page 50152 "SAT Bank Codes"
{
    Caption = 'SAT Bank Codes';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "SAT Bank Code";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ToolTip = 'Specifies the value of the Bank Name field.';
                }
            }
        }
    }

    actions
    {
    }
}

