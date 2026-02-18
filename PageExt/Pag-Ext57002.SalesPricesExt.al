namespace Nifast.Nifast;

using Microsoft.Sales.Pricing;

pageextension 57002 SalesPricesExt extends "Sales Prices"
{
    layout
    {
        addafter("Ending Date")
        {

            field("Alt. Price"; Rec."Alt. Price")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Alt. Price field.';
            }
            field("Alt. Price UOM"; Rec."Alt. Price UOM")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Alt. Price UOM field.';
            }
            field("Contract Customer No."; Rec."Contract Customer No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Contract Customer No. field.';
            }
            field("Contract Location Code"; Rec."Contract Location Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Contract Location Code field.';
            }
            field("Contract No."; Rec."Contract No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Contract No. field.';
            }
            field("Contract Ship-to Code"; Rec."Contract Ship-to Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Contract Ship-to Code field.';
            }
            field("Customer Bin"; Rec."Customer Bin")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Customer Bin field.';
            }
            field("Customer Cross Ref No."; Rec."Customer Cross Ref No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Customer Cross Ref No. field.';
            }
            field("Customer Cross Ref. Desc."; Rec."Customer Cross Ref. Desc.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Customer Cross Ref. Desc. field.';
            }
        }
    }
}
