pageextension 57015 SalesPriceListsExt extends "Sales Price Lists"
{
    layout
    {
        addafter("Ending Date")
        {

            field("Price Includes VAT"; Rec."Price Includes VAT")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the if prices include VAT.';
            }
            field("Allow Line Disc."; Rec."Allow Line Disc.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether line discounts are allowed. You can change this value on the lines.';
            }
            field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether invoice discount is allowed. You can change this value on the lines.';
            }
            field("VAT Bus. Posting Gr. (Price)"; Rec."VAT Bus. Posting Gr. (Price)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the default VAT business posting group code.';
            }

        }
    }
}
