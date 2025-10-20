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
        //TODO
        /*  field(14000601; "Receive Station"; Code[10])
         {
             TableRelation = "Receive Station";
             CaptionML = ENU = 'Receive Station';
         }

         field(14000701; "Packing Station"; Code[10])
         {
             TableRelation = "Packing Station".Code;
             CaptionML = ENU = 'Packing Station';
         }

         field(14000901; "E-Mail User Rule"; Code[10])
         {
             TableRelation = "E-Mail User Rule";
             CaptionML = ENU = 'E-Mail User Rule';
         }

         field(14000902; "E-Mail Sender Name"; Text[100])
         {
             CaptionML = ENU = 'E-Mail Sender Name';
         }

         field(14000903; "E-Mail Sender Address"; Text[50])
         {
             CaptionML = ENU = 'E-Mail Sender Address';
         } */
        //TODO

        field(14017621; "Default Location Code"; Code[10])
        {
            TableRelation = Location;
            Description = 'NV-Lot';
        }

        field(14017622; "Edit Customer"; Boolean)
        {
        }

        field(14017623; "Edit Vendor"; Boolean)
        {
        }

        field(14017624; "Edit Item"; Boolean)
        {
        }

        field(14017625; "Gross Profit Override"; Boolean)
        {
        }

        field(14017755; "Edit Resource"; Boolean)
        {
        }

        field(14018050; "View Cr. Mgmt. Comments"; Boolean)
        {
        }

        field(14018051; "Edit Cr. Mgmt. Comments"; Boolean)
        {
        }

        field(14018070; "Edit QC Hold - On"; Boolean)
        {
            Description = 'NV-Lot';
        }

        field(14018071; "Edit QC Hold - Off"; Boolean)
        {
            Description = 'NV-Lot';
        }

    }
}
