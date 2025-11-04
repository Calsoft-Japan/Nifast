tableextension 55744 "Transfer Shipment Header Ext" extends "Transfer Shipment Header"
{
    // version NAVW18.00,SE0.60,NV4.32,NIF1.050,NIF.N15.C9IN.001
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
        field(70000; "Reason Code"; Code[10])
        {
        }

        field(70001; "Container No."; Code[20])
        {
            Editable = false;
        }

        field(70002; "Rework No."; Code[20])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
        }

        field(70003; "Rework Line No."; Integer)
        {
        }

        field(70004; "FB Order No."; Code[20])
        {
            Description = 'NV-FB';
        }

    }

}
