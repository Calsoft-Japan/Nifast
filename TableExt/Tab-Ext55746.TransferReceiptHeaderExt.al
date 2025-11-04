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
        field(70000; "Reason Code"; code[10])
        {
        }
        field(70001; "Inbound Bill of Lading"; code[20])
        {
        }
        field(70002; "Carrier Vendor No."; code[20])
        {
            TableRelation = Vendor."No.";
        }
        field(70003; "Carrier Trailer ID"; code[20])
        {
        }
        field(70004; "Container No."; code[20])
        {
            Editable = false;
        }
        field(70005; "Rework No."; code[20])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
        }
        field(70006; "Rework Line No."; Integer)
        {
        }
        field(70007; "FB Order No."; code[20])
        {
            Description = 'NV-FB';
        }
    }
}
