tableextension 55747 "Transfer Receipt Line Ext" extends "Transfer Receipt Line"
{
    // version NAVW18.00,SE0.55.08,NV4.35,NIF1.050,NIF.N15.C9IN.001
    fields
    {
        field(50000; "Total Parcels"; Decimal)
        {
            DecimalPlaces = 0 : 2;
            Description = '#10069';
        }
        field(51000; "Source PO No."; Code[20])
        {
            // cleaned
        }
        field(51010; "Contract Note No."; Code[20])
        {
            // cleaned
        }
    }
}
