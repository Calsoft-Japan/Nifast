tableextension 70016 LAXReceiveControl_NF extends "LAX Receive Control"
{
    fields
    {
        field(50000; "Mfg. Lot No."; Code[30])
        {
        }
        field(50010; "Country of Origin Code"; Code[10])
        {
            Caption = 'Country of Origin Code';
            TableRelation = "Country/Region";
        }
        field(50025; "Next Ship Date"; Date)
        {
        }
        field(50020; "QC Hold"; Boolean)
        {
            Caption = 'QC Hold';
        }
        field(50030; "QC Print Code"; Code[10])
        {
            Caption = 'QC Print Code';
        }
    }
}
