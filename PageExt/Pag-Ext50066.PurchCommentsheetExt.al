namespace Nifast.Nifast;

using Microsoft.Purchases.Comment;

pageextension 50066 "Purch. Comment sheet Ext" extends "Purch. comment Sheet"
{
    layout
    {
        addbefore("LAX Include in E-Mail")
        {
            field("Print On Quote"; Rec."Print On Quote")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Print On Quote field.';
            }
            field("Print On Put Away"; Rec."Print On Put Away")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Print On Put Away field.';
            }
            field("Print On Order"; Rec."Print On Order")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Print On Order field.';
            }

            field("Print On Receipt"; Rec."Print On Receipt")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Print On Receipt field.';
            }
            field("Print On Invoice"; Rec."Print On Invoice")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Print On Invoice field.';
            }
            field("Print On Credit Memo"; Rec."Print On Credit Memo")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Print On Credit Memo field.';
            }
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the User ID field.';
            }
            field("Time Stamp"; Rec."Time Stamp")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Time Stamp field.';
            }

        }
    }
}
