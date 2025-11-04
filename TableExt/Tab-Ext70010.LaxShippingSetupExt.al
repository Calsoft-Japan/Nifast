tableextension 70110 LAXShippingSetup_NF extends "LAX Shipping Setup"
{
    fields
    {
        field(50000; "Serial No. Nos."; Code[10])
        {
            TableRelation = "No. Series";
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