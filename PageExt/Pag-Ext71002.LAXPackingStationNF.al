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
                    ApplicationArea = All;
                }
                field("UCC/UPC Label Printer Port"; Rec."UCC/UPC Label Printer Port")
                {
                    ApplicationArea = All;
                }
                field("Label Buffer File"; Rec."Label Buffer File")
                {
                    ApplicationArea = All;
                }
                field("RF-ID Label Printer Port"; Rec."RF-ID Label Printer Port")
                {
                    ApplicationArea = All;
                }
                field("Label Printing"; Rec."Label Printing")
                {
                    ApplicationArea = All;
                }
            }
        }
        addfirst("Label and Posting")
        {
            field("Bar Tender Printer"; Rec."Bar Tender Printer")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Bar Tender Printer field.', Comment = '%';
            }
        }
    }
}
