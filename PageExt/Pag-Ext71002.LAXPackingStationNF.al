namespace Nifast.Nifast;

pageextension 71002 LAXPackingStation_NF extends "LAX Packing Station"
{
    layout
    {
        addlast(Content)
        {
            group("Non-FedEx Shipping")
            {
                Caption = 'Non-FedEx Shipping';
                field("Std. Pack. Label Printer Port"; Rec."Std. Pack. Label Printer Port")
                {
                }
                field("UCC/UPC Label Printer Port"; Rec."UCC/UPC Label Printer Port")
                {
                }
                field("Label Buffer File"; Rec."Label Buffer File")
                {
                }
                field("RF-ID Label Printer Port"; Rec."RF-ID Label Printer Port")
                {
                }
                field("Label Printing"; Rec."Label Printing")
                {
                }
            }
        }
    }
}
