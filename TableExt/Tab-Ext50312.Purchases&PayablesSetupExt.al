tableextension 50312 "Purchases & Payables Setup Ext" extends "Purchases & Payables Setup"
{
    fields
    {
        field(50000;"On the Water Lot Nos.";Code[10])
        {
            Caption = 'On the Water Lot Nos.';
        }
        field(50001;"Bal G/L Acc to Reverse JPY Inv";Code[20])
        {
            Description = 'Forex';
        }
        field(50002;"Bal G/L Acc to Create USD Inv";Code[20])
        {
            Description = 'Forex';
        }
        field(50003;"FC Gain Account";Code[20])
        {
            Description = 'Forex';
        }
        field(50004;"FC Loss Account";Code[20])
        {
            Description = 'Forex';
        }
        field(50005;"FC Gain Bal. Account";Code[20])
        {
            Description = 'Forex';
        }
        field(50006;"FC Loss Bal. Account";Code[20])
        {
            Description = 'Forex';
        }
        field(50007;"LCY Gain Account";Code[20])
        {
            Description = 'Forex';
        }
        field(50008;"LCY Loss Account";Code[20])
        {
            Description = 'Forex';
        }
        field(50009;"LCY Gain Bal. Account";Code[20])
        {
            Description = 'Forex';
        }
        field(50010;"LCY Loss Bal. Account";Code[20])
        {
            Description = 'Forex';
        }
        field(50013;"3-way Balance Sheet solution";Boolean)
        {
            Description = 'Forex';
        }
        field(50014;"AP Trade Account";Code[20])
        {
            Description = 'Consolidation';
        }
        field(50015;"AP Payment Account";Code[20])
        {
            Description = 'Consolidation';
        }
    }
}
