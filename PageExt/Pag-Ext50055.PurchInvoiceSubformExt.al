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
            }
        }
        addafter(Description)
        {
            field("Contract Note No."; Rec."Contract Note No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Invoice Disc. Pct.")
        {
            field("USD Value"; Rec."USD Value")
            {
                ApplicationArea = All;
            }
        }
        moveafter(ShortcutDimCode8; "Description 2")
        addafter("IRS 1099 Liable")
        {
            field("Entry/Exit Date"; Rec."Entry/Exit Date")
            {
                ApplicationArea = All;
            }
            field("Entry/Exit No."; Rec."Entry/Exit No.")
            {
                ApplicationArea = All;
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

    LOCAL PROCEDURE LineCommentOnPush();
    BEGIN
        rec.ShowLineComments;
    END;

}
