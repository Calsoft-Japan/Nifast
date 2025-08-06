tableextension 50115 "Sales Cr.Memo Line Ext" extends "Sales Cr.Memo Line"
{
    // version NAVW18.00,NAVNA8.00,SE0.55.08,NV4.29,NIF1.050,NIF.N15.C9IN.001,AKK1606.01
    fields
    {
        field(50800; "Entry/Exit Date"; Date)
        {
            Caption = 'Entry/Exit Date';
            Description = 'AKK1606.01';
        }
        field(50801; "Entry/Exit No."; Code[20])
        {
            Caption = 'Entry/Exit No.';
            Description = 'AKK1606.01';
        }
        field(50802; National; Boolean)
        {
            Caption = 'National';
            Description = 'AKK1606.01';
        }
    }
    keys
    {
        key(Key9; "Shipment Date")
        {
        }
    }
}
