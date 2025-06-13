tableextension 50287 "Customer Bank Account Ext" extends "Customer Bank Account"
{
    fields
    {
        field(50000;"Bank Code SAT";Code[20])
        {
            Caption = 'Bank Code';
            Numeric = true;
        }
    }
}
