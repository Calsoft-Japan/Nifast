tableextension 55740 "Transfer Header Ext" extends "Transfer Header"
{
    fields
    {
        field(50000;"Vessel Name";Code[50])
        {
            Editable = false;
        }
        field(50009;"Posted Assembly Order No.";Code[20])
        {
            Description = 'NF1.00:CIS.NG  10/06/15';
        }
        field(50010;"Sail-On Date";Date)
        {
            Editable = false;
        }
    }
}
