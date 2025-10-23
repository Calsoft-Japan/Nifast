table 50225 "Renumber Permission"
{
    Caption = 'Permission';
    DataPerCompany = false;
    fields
    {
        field(3; "Object Type"; Option)
        {
            Caption = '"Object Type"';
            OptionCaption = 'Table Data,Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,System';
            OptionMembers = "Table Data","Table",,"Report",,"Codeunit","XMLport",MenuSuite,"Page","Query",System;
        }
        field(4; "Object ID"; Integer)
        {
            Caption = 'Object ID';
        }
        field(50001; "New Object ID"; Integer)
        {
            Caption = 'New Object ID';
            TableRelation = IF ("Object Type" = CONST("Table Data")) AllObj."Object ID" WHERE("Object Type" = CONST(Table))
            ELSE IF ("Object Type" = CONST(Table)) AllObj."Object ID" WHERE("Object Type" = CONST(Table))
            ELSE IF ("Object Type" = CONST(Report)) AllObj."Object ID" WHERE("Object Type" = CONST(Report))
            ELSE IF ("Object Type" = CONST(Codeunit)) AllObj."Object ID" WHERE("Object Type" = CONST(Codeunit))
            ELSE IF ("Object Type" = CONST(XMLport)) AllObj."Object ID" WHERE("Object Type" = CONST(XMLport))
            ELSE IF ("Object Type" = CONST(MenuSuite)) AllObj."Object ID" WHERE("Object Type" = CONST(MenuSuite))
            ELSE IF ("Object Type" = CONST(Page)) AllObj."Object ID" WHERE("Object Type" = CONST(Page))
            ELSE IF ("Object Type" = CONST(Query)) AllObj."Object ID" WHERE("Object Type" = CONST(Query))
            ELSE IF ("Object Type" = CONST(System)) AllObj."Object ID" WHERE("Object Type" = CONST(System));
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
}
