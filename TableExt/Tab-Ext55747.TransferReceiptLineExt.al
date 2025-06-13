tableextension 55747 "Transfer Receipt Line Ext" extends "Transfer Receipt Line"
{
    fields
    {
        field(50000;"Total Parcels";Decimal)
        {
            DecimalPlaces = 0:2;
            Description = '#10069';
        }
        field(51000;"Source PO No.";Code[20])
        {
            // cleaned
        }
        field(51010;"Contract Note No.";Code[20])
        {
            // cleaned
        }
    }
}
