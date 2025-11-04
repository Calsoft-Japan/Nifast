table 90007 "Table Import Filter"
{
    DataPerCompany = false;
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
            TableRelation = "Table Import Definition"."File Field No." WHERE("Table Import Code"=FIELD("Table Import Code"));
        }
        field(3; "Filter"; Text[250])
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; "Table Import Code", "File Field No.")
        {
        }
    }

    fieldgroups
    {
    }
}
