tableextension 50288 "Vendor Bank Account Ext" extends "Vendor Bank Account"
{
    fields
    {
        field(50000;"Bank Code SAT";Code[20])
        {
            Caption = 'Bank Code';
            Numeric = true;
        }
        field(50001;"Bank Routing No.";Text[30])
        {
            // cleaned
        }
    }
}
