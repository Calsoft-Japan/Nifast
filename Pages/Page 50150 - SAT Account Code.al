page 50150 "SAT Account Code"
{
    Caption = 'SAT Account Codes';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "SAT Account Codes";

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
                field(Level; Rec.Level)
                {
                    ToolTip = 'Specifies the value of the Level field.';
                }
            }
        }
    }

    actions
    {
    }
}

