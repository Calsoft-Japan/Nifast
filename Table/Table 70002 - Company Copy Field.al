table 70002 "Company Copy Field"
{
    // CC1.0, Company Copy, Emiel Romein eromein@home.nl

    DataPerCompany = false;
    //TODO
    //DrillDownPageID = 70002;
    fields
    {
        field(1; "Template Name"; Code[10])
        {
            NotBlank = true;
            TableRelation = "Company Copy Template";
        }
        field(2; "Table No."; Integer)
        {
            NotBlank = true;
            TableRelation = "Company Copy Table"."Table No.";
        }
        field(3; "Field No."; Integer)
        {
            NotBlank = true;
            TableRelation = Field."No." WHERE(TableNo = FIELD("Table No."),
                                             Class = CONST(Normal),
                                             Type = FILTER(<> BLOB),
                                             Enabled = CONST(true));

            trigger OnValidate()
            begin
                CALCFIELDS(Name);

                IF Field.GET("Table No.", "Field No.") THEN
                    //VALIDATE("Table Relation",Field.RelationTableNo);
                    "Table Relation" := Field.RelationTableNo;
            end;
        }
        field(4; Name; Text[30])
        {
            CalcFormula = Lookup(Field.FieldName WHERE(TableNo = FIELD("Table No."),
                                                        "No." = FIELD("Field No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Validate Field"; Boolean)
        {
            // cleaned
        }
        field(6; "Table Relation"; Integer)
        {
            Editable = false;
            TableRelation = AllObj."Object ID" WHERE("Object Type" = CONST(Table));

            trigger OnValidate()
            begin
                CALCFIELDS("Table Relation Name");
            end;

        }
        field(7; "Table Relation Name"; Text[30])
        {
            CalcFormula = Lookup(AllObj."Object Name" WHERE("Object Type" = CONST(Table),
                                                    "Object ID" = FIELD("Table Relation")));
            Editable = false;
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key1; "Template Name", "Table No.", "Field No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        "Field": Record 2000000041;
}
