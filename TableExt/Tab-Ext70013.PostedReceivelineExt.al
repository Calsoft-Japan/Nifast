tableextension 70113 PostedReceivelineExt extends "LAX Posted Receive Line"
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
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}