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
        field(50002; "E-Signature"; Blob) //Move from User to here. BC Upgrade 2025-06-23
        {
            Caption = 'E-Signature';
        }
        field(50003; "PO Authority"; Boolean)//Move from User to here. BC Upgrade 2025-06-23
        {
            Caption = 'PO Authority';
        }
        //TODO
    }
}
