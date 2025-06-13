tableextension 50023 "Vendor Ext" extends "Vendor"
{
    fields
    {
        field(50000;"Vessel Info Mandatory";Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '#10044';
        }
        field(50001;"3 Way Currency Adjmt.";Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Forex';
        }
    }
}
