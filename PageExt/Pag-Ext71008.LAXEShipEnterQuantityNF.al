namespace Nifast.Nifast;

pageextension 71008 LAXEShipEnterQuantity_NF extends "LAX EShip Enter Quantity"
{
    layout
    {
        addlast(General)
        {
            field("SNP"; Rec."SNP")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SNP field.';
            }
        }
    }
}
