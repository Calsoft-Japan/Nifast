pageextension 50001 LAXShippingSetup_NF extends "LAX Shipping Setup"
{
    layout
    {
        addafter("Manifest Nos.")
        {
            field("Serial No. Nos."; Rec."Serial No. Nos.")
            {
            }
        }
    }
}
