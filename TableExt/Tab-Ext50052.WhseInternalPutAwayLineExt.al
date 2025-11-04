tableextension 50052 "Whse. Internal Put-awayLineExt" extends "Whse. Internal Put-away Line"
{
    // version NAVW17.10,NV4.35,NIF.N15.C9IN.001

    fields
    {
         
        field(14017999; "License Plate No."; Code[20])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
        }
         
    }
    keys
    {
         
        key(Key8; "License Plate No.")
        {
        }
         
    }
}