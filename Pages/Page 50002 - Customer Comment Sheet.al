page 50002 "Customer Comment Sheet"
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
                field("Include in Sales Orders"; Rec."Include in Sales Orders")
                {
                    ToolTip = 'Specifies the value of the Include in Sales Orders field.';
                    Caption = 'Include in Sales Orders';
                }
                field("Print On Sales Quote"; Rec."Print On Sales Quote")
                {
                    ToolTip = 'Specifies the value of the Print On Sales Quote field.';
                    Caption = 'Print On Sales Quote';
                }
                field("Print On Pick Ticket"; Rec."Print On Pick Ticket")
                {
                    ToolTip = 'Specifies the value of the Print On Pick Ticket field.';
                    Caption = 'Print On Pick Ticket';
                }
                field("Print On Order Confirmation"; Rec."Print On Order Confirmation")
                {
                    ToolTip = 'Specifies the value of the Print On Order Confirmation field.';
                    Caption = 'Print On Order Confirmation';
                }
                field("Print On Shipment"; Rec."Print On Shipment")
                {
                    ToolTip = 'Specifies the value of the Print On Shipment field.';
                    Caption = 'Print On Shipment';
                }
                field("Print On Sales Invoice"; Rec."Print On Sales Invoice")
                {
                    ToolTip = 'Specifies the value of the Print On Sales Invoice field.';
                    Caption = 'Print On Sales Invoice';
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
                field("Include in E-Mail"; Rec."lax Include in E-Mail")
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

