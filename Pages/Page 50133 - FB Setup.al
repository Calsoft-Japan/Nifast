page 50133 "FB Setup"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)

    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "FB Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Order Nos."; Rec."Order Nos.")
                {
                    ToolTip = 'Specifies the value of the Order Nos. field.';
                }
                field("Tag Nos."; Rec."Tag Nos.")
                {
                    ToolTip = 'Specifies the value of the Tag Nos. field.';
                }
                field("Import Data Log Nos."; Rec."Import Data Log Nos.")
                {
                    ToolTip = 'Specifies the value of the Import Data Log Nos. field.';
                }
                field("Req. Worksheet Template"; Rec."Req. Worksheet Template")
                {
                    ToolTip = 'Specifies the value of the Req. Worksheet Template field.';
                }
                field("Req. Worksheet Name"; Rec."Req. Worksheet Name")
                {
                    ToolTip = 'Specifies the value of the Req. Worksheet Name field.';
                }
            }
        }
    }

    actions
    {
    }
}

