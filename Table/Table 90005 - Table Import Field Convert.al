table 90005 "Table Import Field Convert"
{
    DataCaptionFields = "Table Import Code", "File Field No.";
    DataPerCompany = false;
    //TODO
    /*  DrillDownPageID = 90007;
     LookupPageID = 90007; */
    //TODO
    fields
    {
        field(1; "Table Import Code"; Code[10])
        {
            // cleaned
            TableRelation = "Table Import";
        }
        field(2; "File Field No."; Integer)
        {
            // cleaned
            TableRelation = "Table Import Definition"."File Field No." WHERE("Table Import Code" = FIELD("Table Import Code"));
        }
        field(3; "From Value"; Text[200])
        {
            // cleaned
        }
        field(4; "To Value"; Text[250])
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; "Table Import Code", "File Field No.", "From Value")
        {
        }
    }

    fieldgroups
    {
    }
}
