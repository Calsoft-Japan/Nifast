tableextension 55746 "Transfer Receipt Header Ext" extends "Transfer Receipt Header"
{
    fields
    {
        field(50000; "Vessel Name"; Code[50])
        {
            Editable = false;
            TableRelation = "Shipping Vessels";
        }
        field(50009; "Posted Assembly Order No."; Code[20])
        {
            Description = 'NF1.00:CIS.NG  10/06/15';
            Editable = false;
            TableRelation = "Posted Assembly Header"."No.";
        }
        field(50010; "Sail-On Date"; Date)
        {
            Editable = false;
        }
    }
}
