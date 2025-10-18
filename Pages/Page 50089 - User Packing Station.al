page 50089 "User Packing Station"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "User Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.';
                    Caption = 'User ID';
                }
                field("Packing Station"; Rec."Packing Station")
                {
                    ToolTip = 'Specifies the value of the Packing Station field.';
                    Caption = 'Packing Station';
                }
            }
        }
    }

    actions
    {
    }
}

