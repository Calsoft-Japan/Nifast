tableextension 50910 "Posted Assembly Header Ext" extends "Posted Assembly Header"
{
    fields
    {
        field(50000;"Purchase Order No.";Code[20])
        {
            Description = 'NF1.00:CIS.NG  10/06/15';
        }
        field(50001;"Transfer Order No.";Code[20])
        {
            Description = 'NF1.00:CIS.NG  10/26/15';
            Editable = false;
        }
    }
}
