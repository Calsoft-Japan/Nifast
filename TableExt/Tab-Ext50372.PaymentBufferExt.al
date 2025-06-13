tableextension 50372 "Payment Buffer Ext" extends "Payment Buffer"
{
    fields
    {
        field(50000;"Contract Note No.";Code[20])
        {
            // cleaned
        }
        field(50001;"Exchange Contract No.";Code[20])
        {
            // cleaned
        }
        field(50002;"USD Value";Decimal)
        {
            Description = 'Forex';
        }
    }
}
