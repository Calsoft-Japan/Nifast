page 50090 "Forecast Log"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Forecast Log File";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                    Caption = 'Item No.';
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Generation Date"; Rec."Generation Date")
                {
                    Caption = 'Generation Date';
                    ToolTip = 'Specifies the value of the Generation Date field.';
                }
                field("Forecast Month"; Rec."Forecast Month")
                {
                    Caption = 'Forecast Month';
                    ToolTip = 'Specifies the value of the Forecast Month field.';
                }
                field("Div Code"; Rec."Div Code")
                {
                    Caption = 'Div Code';
                    ToolTip = 'Specifies the value of the Div Code field.';
                }
            }
        }
    }

    actions
    {
    }
}

