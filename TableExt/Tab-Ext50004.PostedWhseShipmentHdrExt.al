tableextension 50004 "Posted Whse. Shipment Hdr Ext" extends "Posted Whse. Shipment Header"
{
    fields
    {
        field(14017632; "Carrier Trailer ID"; Code[20])
        {
        }

        field(37015680; "Delivery Load No."; Code[20])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
        }
        field(37015681; "Delivery Load Seq."; Code[20])
        {
        }

    }
}
