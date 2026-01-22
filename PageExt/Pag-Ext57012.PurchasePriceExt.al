namespace Nifast.Nifast;

using Microsoft.Purchases.Pricing;

pageextension 57012 "Purchase Price Ext" extends "Purchase Prices"
{
    layout
    {
        addafter("Starting Date")
        {
            field("Alt. Price"; Rec."Alt. Price")
            {
                ApplicationArea = All;
            }
            field("Alt. Price UOM"; Rec."Alt. Price UOM")
            {
                ApplicationArea = All;
            }
        }
    }
}
