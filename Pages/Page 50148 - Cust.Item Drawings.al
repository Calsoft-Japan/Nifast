page 50148 "Cust./Item Drawings"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Lot Entry Functionality Renumber)
    // NF1.00:CIS.CM    10/26/15 Update for New Vision Removal Task (Update the link)
    // >> NIF
    // Fields Modified:
    //   Revision No. (HorzGlue=Both)
    //   Drawing No. (HorzGlue=Left)
    // << NIF

    DataCaptionFields = "Item No.", "Customer No.";
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Cust./Item Drawing2";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Revision No."; Rec."Revision No.")
                {
                    ToolTip = 'Specifies the value of the Revision No. field.';
                }
                field("Drawing No."; Rec."Drawing No.")
                {
                    ToolTip = 'Specifies the value of the Drawing No. field.';
                }
                field("Revision Date"; Rec."Revision Date")
                {
                    ToolTip = 'Specifies the value of the Revision Date field.';
                }
                field(Active; Rec.Active)
                {
                    ToolTip = 'Specifies the value of the Active field.';
                }
                field("Drawing Type"; Rec."Drawing Type")
                {
                    ToolTip = 'Specifies the value of the Drawing Type field.';
                }
                field("First Article Approval"; Rec."First Article Approval")
                {
                    ToolTip = 'Specifies the value of the First Article Approval field.';
                }
                field("First Article Waiver"; Rec."First Article Waiver")
                {
                    ToolTip = 'Specifies the value of the First Article Waiver field.';
                }
                field("PPAP Approval"; Rec."PPAP Approval")
                {
                    ToolTip = 'Specifies the value of the PPAP Approval field.';
                }
                field(Components; Rec.Components)
                {
                    ToolTip = 'Specifies the value of the Components field.';
                }
            }
        }
    }

    actions
    {
    }
}

