pageextension 50055 "Purch. Invoice Subform Ext" extends "Purch. Invoice Subform"
{
    //Version NAVW18.00,NAVNA8.00,NV4.30,4x,NIF1.062,NIF.N15.C9IN.001,FOREX,AKK1607.01;
    layout
    {
        addafter(Nonstock)
        {
            field(National; Rec.National)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the National field.';
            }
        }
        addafter(Description)
        {
            field("Contract Note No."; Rec."Contract Note No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Contract Note No. field.';
            }
        }
        addafter("Invoice Disc. Pct.")
        {
            field("USD Value"; Rec."USD Value")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the USD Value field.';
            }
        }
        moveafter(ShortcutDimCode8; "Description 2")
        addafter("IRS 1099 Liable")
        {
            field("Entry/Exit Date"; Rec."Entry/Exit Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Entry/Exit Date field.';
            }
            field("Entry/Exit No."; Rec."Entry/Exit No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Entry/Exit No. field.';
            }
        }
    }
    actions
    {
        addfirst("F&unctions")
        {
            action("Calc. Tax Withholding")
            {
                CaptionML = ENU = 'Calc Tax WithHolding';
                Image = Calculate;
                ToolTip = 'Executes the Calc. Tax Withholding action.';
                ApplicationArea = All;
                trigger OnAction()
                BEGIN
                    //AKK1607.01---
                    WithHoldings.CheckWithHold(Rec."Document No.");
                    //AKK1607.01+++
                END;
            }
        }
    }
    var
        WithHoldings: Codeunit 50024;

    /*   LOCAL PROCEDURE LineCommentOnPush();
      BEGIN
          rec.ShowLineComments();
      END; */

}
