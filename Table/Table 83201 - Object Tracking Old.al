table 83201 "Object Tracking Old"
{
    fields
    {
        field(1; "Object Type"; Option)
        {
            OptionMembers = "Table",Form,"Report",Dataport,"Codeunit";
        }
        field(2; "Object ID"; Integer)
        {
            // cleaned
            TableRelation = AllObj."Object ID" WHERE("Object Type" = FIELD("Object Type"));
        }
        field(3; "Object Name"; Text[30])
        {
            // cleaned
        }
        field(4; "Current Version List"; Text[50])
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; "Object Type", "Object ID")
        {
        }
    }

    fieldgroups
    {
    }

    var
    //  TRObject: Record 2000000001;
}
