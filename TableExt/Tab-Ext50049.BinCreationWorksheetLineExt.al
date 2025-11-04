tableextension 50049 "Bin Creation Worksheet LineExt" extends "Bin Creation Worksheet Line"
{
    //Version NAVW17.00,NV4.35,NIF.N15.C9IN.001;
    fields
    {
        field(70000; "Bin Size Code"; Code[20])
        {
            Description = 'NV - NF1.00:CIS.CM 09-29-15';
            trigger OnValidate()
            BEGIN
                // Placeholder for original OnValidate logic
                // >> NF1.00:CIS.CM 09-29-15
                // >> NV - 08/13/03
                // IF "Bin Size Code" <> xRec."Bin Size Code" THEN BEGIN
                //     IF "Bin Size Code" <> '' THEN
                //         "Bin Size".GET("Bin Size Code")
                //     ELSE
                //         CLEAR("Bin Size"); // Zero values
                //     VALIDATE("Maximum Cubage","Bin Size".Cubage);
                // END;
                // << NV - 08/13/03
                // << NF1.00:CIS.CM 09-29-15
            END;
        }

        field(70001; "Pick Bin Ranking"; Integer)
        {
        }

        field(70002; "Staging Bin"; Boolean)
        {
        }

    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }
}