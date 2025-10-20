tableextension 55747 "Transfer Receipt Line Ext" extends "Transfer Receipt Line"
{
    // version NAVW18.00,SE0.55.08,NV4.35,NIF1.050,NIF.N15.C9IN.001
    fields
    {
        field(50000; "Total Parcels"; Decimal)
        {
            DecimalPlaces = 0 : 2;
            Description = '#10069';
        }
        field(51000; "Source PO No."; Code[20])
        {
            // cleaned
        }
        field(51010; "Contract Note No."; Code[20])
        {
            // cleaned
        }
        //TODO
        /* 
        field(14000351; "EDI Segment Group"; Integer)
        {
            CaptionML = ENU = 'EDI Segment Group';
            Editable = false;
        } */
        //TODO

        field(14017790; "Container No."; Code[20])
        {
            Editable = false;
        }

        field(14017791; "Final Destination"; Code[10])
        {
            TableRelation = Location.Code WHERE("Use As In-Transit" = CONST(false));
        }

        field(14017930; "Rework No."; Code[20])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
        }

        field(14017931; "Rework Line No."; Integer)
        {
        }

        field(14017999; "License Plate No."; Code[20])
        {
            Description = 'NF1.00:CIS.NG 10-10-15';
            Editable = false;
        }

        field(37015330; "FB Order No."; Code[20])
        {
            Description = 'NV-FB';
        }
        field(37015331; "FB Line No."; Integer)
        {
            Description = 'NV-FB';
        }
        field(37015332; "FB Tag No."; Code[20])
        {
            Description = 'NV-FB';
        }
        field(37015333; "FB Customer Bin"; Code[20])
        {
            Description = 'NV-FB';
        }
    }
}
