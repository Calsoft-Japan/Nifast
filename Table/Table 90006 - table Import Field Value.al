table 90006 "table Import Field Value"
{
    DataCaptionFields = "Table Import Code", "File Field No.";
    DataPerCompany = false;
    //TODO
    // DrillDownPageID = 90009;
    // LookupPageID = 90009;
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
        field(3; "IF File Field No."; Integer)
        {
            InitValue = 1;
            MinValue = 1;
            TableRelation = "Table Import Definition"."File Field No." WHERE("Table Import Code" = FIELD("Table Import Code"));
        }
        field(4; "="; Text[220])
        {
            // cleaned
        }
        field(5; Value; Text[250])
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; "Table Import Code", "File Field No.", "IF File Field No.", "=")
        {
        }
    }

    fieldgroups
    {
    }
}
