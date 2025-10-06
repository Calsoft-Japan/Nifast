page 50003 "Item Comment Sheet"
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
                field("Include in Sales Orders";"Include in Sales Orders")
                {
                }
                field("Print On Sales Quote";"Print On Sales Quote")
                {
                }
                field("Print On Pick Ticket";"Print On Pick Ticket")
                {
                }
                field("Print On Order Confirmation";"Print On Order Confirmation")
                {
                }
                field("Print On Shipment";"Print On Shipment")
                {
                }
                field("Print On Sales Invoice";"Print On Sales Invoice")
                {
                }
                field("Include in Purchase Orders";"Include in Purchase Orders")
                {
                }
                field("Print On Purch. Quote";"Print On Purch. Quote")
                {
                }
                field("Print On Purch. Order";"Print On Purch. Order")
                {
                }
                field("Print On Receipt";"Print On Receipt")
                {
                }
                field("Print On Purch. Invoice";"Print On Purch. Invoice")
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

