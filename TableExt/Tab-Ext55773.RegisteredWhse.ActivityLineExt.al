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
    }
}
