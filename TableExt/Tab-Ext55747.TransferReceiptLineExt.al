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

        field(70000; "Container No."; Code[20])
        {
            Editable = false;
        }

        field(70001; "Final Destination"; Code[10])
        {
            TableRelation = Location.Code WHERE("Use As In-Transit" = CONST(false));
        }

        field(70002; "Rework No."; Code[20])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
        }

        field(70003; "Rework Line No."; Integer)
        {
        }

        field(70004; "License Plate No."; Code[20])
        {
            Description = 'NF1.00:CIS.NG 10-10-15';
            Editable = false;
        }

        field(70005; "FB Order No."; Code[20])
        {
            Description = 'NV-FB';
        }
        field(70006; "FB Line No."; Integer)
        {
            Description = 'NV-FB';
        }
        field(70007; "FB Tag No."; Code[20])
        {
            Description = 'NV-FB';
        }
        field(70008; "FB Customer Bin"; Code[20])
        {
            Description = 'NV-FB';
        }
    }
}
