namespace Nifast.Nifast;

using Microsoft.Sales.Comment;

pageextension 50067 "Sales Comment List Ext" extends "Sales comment List"
{
    layout
    {
        addafter("LAX Include in E-Mail")
        {
            field("Print On Invoice"; Rec."Print On Invoice")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies that this comment is printed on the sales invoice document.';

            }
            field("Print On Order Confirmation"; Rec."Print On Order Confirmation")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies that this comment line is printed on the sales order document.';
            }
            field("Print On Pick Ticket"; Rec."Print On Pick Ticket")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies that this comment line is printed on the pick ticket document.';
            }
        }
    }
}
