page 50005 "Resp. Center Comment Sheet"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    AutoSplitKey = true;
    Caption = 'Comment Sheet';
    DataCaptionFields = "No.";
    DelayedInsert = true;
    MultipleNewLines = false;
    PageType = List;
    SourceTable = Table97;

    layout
    {
        area(content)
        {
            repeater()
            {
                field(Date;Date)
                {
                }
                field(Comment;Comment)
                {
                }
                field(Code;Code)
                {
                    Visible = false;
                }
                field("Print On Purch. Order";"Print On Purch. Order")
                {
                }
                field("User ID";"User ID")
                {
                }
                field("Time Stamp";"Time Stamp")
                {
                }
                field("Include in E-Mail";"Include in E-Mail")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SetUpNewLine;
    end;
}

