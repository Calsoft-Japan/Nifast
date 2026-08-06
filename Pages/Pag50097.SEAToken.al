namespace Nifast.Nifast;

page 50097 "SEA Token "
{
    ApplicationArea = All;
    Caption = 'SEA Token ';
    PageType = Card;
    SourceTable = "SEA Token";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Subscription Expires On"; Rec."Subscription Expires On")
                {
                    ToolTip = 'Specifies the value of the Subscription Expires On field.', Comment = '%';
                }
                field(Token; Rec.Token)
                {
                    ToolTip = 'Specifies the value of the Token field.', Comment = '%';
                }
                field("Token Expires On"; Rec."Token Expires On")
                {
                    ToolTip = 'Specifies the value of the Token Expires On field.', Comment = '%';
                }
                field("Token Retrieved On"; Rec."Token Retrieved On")
                {
                    ToolTip = 'Specifies the value of the Token Retrieved On field.', Comment = '%';
                }
            }
        }
    }
}
