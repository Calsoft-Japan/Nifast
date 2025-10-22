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
        field(14017621; "Reason Code"; code[10])
        {
        }
        field(14017630; "Inbound Bill of Lading"; code[20])
        {
        }
        field(14017631; "Carrier Vendor No."; code[20])
        {
            TableRelation = Vendor."No.";
        }
        field(14017632; "Carrier Trailer ID"; code[20])
        {
        }
        field(14017790; "Container No."; code[20])
        {
            Editable = false;
        }
        field(14017930; "Rework No."; code[20])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
        }
        field(14017931; "Rework Line No."; Integer)
        {
        }
        field(37015330; "FB Order No."; code[20])
        {
            Description = 'NV-FB';
        }
    }
}
