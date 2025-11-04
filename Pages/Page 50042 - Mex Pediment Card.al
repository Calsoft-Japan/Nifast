page 50042 "Mex Pediment Card"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Mex Export Pediment";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Pedimento Virtual No."; Rec."Pedimento Virtual No.")
                {
                    ToolTip = 'Specifies the value of the Pedimento Virtual No. field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;
}

