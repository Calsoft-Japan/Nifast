tableextension 70112 Receiverule extends "LAX Receive Rule"
{
    fields
    {
        field(50900; "Production Label Code"; Code[10])
        {
            TableRelation = "Label Header" WHERE("Label Usage" = CONST(Production));
        }
        field(70000; "QC Label Code"; Code[10])
        {
            TableRelation = "Label Header" WHERE("Label Usage" = CONST("Receive Line"));
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