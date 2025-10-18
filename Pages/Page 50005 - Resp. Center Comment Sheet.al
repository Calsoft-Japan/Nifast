page 50005 "Resp. Center Comment Sheet"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    AutoSplitKey = true;
    Caption = 'Comment Sheet';
    DataCaptionFields = "No.";
    DelayedInsert = true;
    MultipleNewLines = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Comment Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the value of the Date field.';
                    Caption = 'Date';
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.';
                    Caption = 'Comment';
                }
                field(Code; Rec.Code)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Code field.';
                    Caption = 'Code';
                }
                field("Print On Purch. Order"; Rec."Print On Purch. Order")
                {
                    ToolTip = 'Specifies the value of the Print On Purch. Order field.';
                    Caption = 'Print On Purch. Order';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.';
                    Caption = 'User ID';
                }
                field("Time Stamp"; Rec."Time Stamp")
                {
                    ToolTip = 'Specifies the value of the Time Stamp field.';
                    Caption = 'Time Stamp';
                }
                field("Include in E-Mail"; Rec."Include in E-Mail")
                {
                    ToolTip = 'Specifies the value of the Include in E-Mail field.';
                    Caption = 'Include in E-Mail';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.SetUpNewLine();
    end;
}

