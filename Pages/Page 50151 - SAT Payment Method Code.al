page 50151 "SAT Payment Method Code"
{
    Caption = 'SAT Payment Method Codes';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "SAT Payment Method Codes";

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
            }
        }
    }

    actions
    {
    }
}

