tableextension 50288 "Vendor Bank Account Ext" extends "Vendor Bank Account"
{
    // version NAVW18.00,NAVNA8.00,MEI,CE 1.2
    fields
    {
        field(50000; "Bank Code SAT"; Code[20])
        {
            Caption = 'Bank Code';
            Numeric = true;
            TableRelation = "SAT Bank Code".Code;
        }
        field(50001; "Bank Routing No."; Text[30])
        {
            // cleaned
        }
    }
}
