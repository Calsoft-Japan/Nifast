tableextension 50091 "User Setup Ext" extends "User Setup"
{
    // version NAVW17.00,SE0.52.16,NV4.35,4X,NIF0.015,NIF.N15.C9IN.001
    fields
    {
        field(50000; "Approve BankContract"; Boolean)
        {
            // cleaned
        }
        field(50001; "Approve Contract Notes"; Boolean)
        {
            // cleaned
        }
        field(50005; "Sales Override Password"; Text[30])
        {
            // cleaned
        }
        field(50010; "Print Pack List"; Boolean)
        {
            // cleaned
        }
        field(50020; "Print Shipment List"; Boolean)
        {
            // cleaned
        }
        field(51000; "Default Resp. Ctr."; Code[10])
        {
            // cleaned
            TableRelation = "Responsibility Center";
        }
        field(70000; "Default Location Code"; Code[10])
        {
            TableRelation = Location;
            Description = 'NV-Lot';
        }

        field(70001; "Edit Customer"; Boolean)
        {
        }

        field(70002; "Edit Vendor"; Boolean)
        {
        }

        field(70003; "Edit Item"; Boolean)
        {
        }

        field(70004; "Gross Profit Override"; Boolean)
        {
        }

        field(70005; "Edit Resource"; Boolean)
        {
        }

        field(70006; "View Cr. Mgmt. Comments"; Boolean)
        {
        }

        field(70007; "Edit Cr. Mgmt. Comments"; Boolean)
        {
        }

        field(70008; "Edit QC Hold - On"; Boolean)
        {
            Description = 'NV-Lot';
        }

        field(70009; "Edit QC Hold - Off"; Boolean)
        {
            Description = 'NV-Lot';
        }

    }
}
