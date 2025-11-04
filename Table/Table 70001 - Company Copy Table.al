table 70001 "Company Copy Table"
{
    DataPerCompany = false;
    fields
    {
        field(1; "Template Name"; Code[10])
        {
            NotBlank = true;
            TableRelation = "Company Copy Template";
        }
        field(2; "Table No."; Integer)
        {
            // cleaned
            TableRelation = AllObj."Object ID" WHERE("Object Type" = CONST(Table));
        }
        field(3; Name; Text[30])
        {
            CalcFormula = Lookup(AllObj."Object Name" WHERE("Object Type" = CONST(Table),
                                                    "Object ID" = FIELD("Table No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Fields"; Integer)
        {
            CalcFormula = Count("Company Copy Field" WHERE("Template Name" = FIELD("Template Name"),
                                                            "Table No." = FIELD("Table No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Order"; Integer)
        {
            // cleaned
        }
        field(6; "Exist Action"; Option)
        {
            OptionMembers = Skip,Modify;
        }
        field(7; "Validate OnModify Trigger"; Boolean)
        {
            // cleaned
        }
        field(8; "Validate OnInsert Trigger"; Boolean)
        {
            // cleaned
        }
        field(9; "Skip if Equal Num. of Records"; Boolean)
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; "Template Name", "Table No.")
        {
        }
        key(Key2; "Order")
        {
        }
    }

    fieldgroups
    {
    }

    var
    //  Text000: Label 'Are you sure you want to add all fields from all tables?';

    procedure InsertAllFieldsAllTables()
    begin
    end;

    procedure InsertAllFields(TableNo: Integer)
    begin
    end;

    procedure InitNewRecord()
    begin
    end;
}
