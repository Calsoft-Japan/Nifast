page 50103 "SPS Customer"
{
    ApplicationArea = All;
    Caption = 'SPS Customer';
    PageType = List;
    SourceTable = "SPS Customer";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.', Comment = '%';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.', Comment = '%';
                }
            }
        }
    }
}
