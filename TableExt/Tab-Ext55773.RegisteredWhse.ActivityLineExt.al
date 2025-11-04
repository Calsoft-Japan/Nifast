tableextension 55773 "Registered Whse. Activ Line Ex" extends "Registered Whse. Activity Line"
{
    // version NAVW17.00,NV4.35,NIF0.007,NIF.N15.C9IN.001
    fields
    {
        field(50030; "Units per Parcel"; Decimal)
        {
            DecimalPlaces = 0 : 2;
            Description = '#10069';
        }
        field(50031; "Total Parcels"; Decimal)
        {
            DecimalPlaces = 0 : 2;
            Description = '#10069';
        }
        field(70000; "License Plate No."; Code[20])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
        }
        field(70001; "Delivery Load No."; Code[20])
        {
        }

        field(70002; "Delivery Load Seq."; Code[20])
        {
        }

    }
}
