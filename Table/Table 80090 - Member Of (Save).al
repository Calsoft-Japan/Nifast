table 80090 "Member Of (Save)"
{
    // NF1.00:CIS.NG    10/10/15 Fix the Table Relation Property for fields (Remove the relationship for non exists table)

    Caption = 'Member Of (Save)';
    DataPerCompany = false;

    fields
    {
        field(1; "User ID"; Code[20])
        {
            Caption = 'User ID';
        }
        field(2; "User Name"; Text[30])
        {
            Caption = 'User Name';
            Enabled = false;
            FieldClass = FlowField;
        }
        field(3; "Role ID"; Code[20])
        {
            Caption = 'Role ID';
            TableRelation = "Permission Set"."Role ID";
        }
        field(4; "Role Name"; Text[30])
        {
            CalcFormula = Lookup("Permission Set".Name WHERE("Role ID" = FIELD("Role ID")));
            Caption = 'Role Name';
            FieldClass = FlowField;
        }
        field(5; Company; Text[30])
        {
            Caption = 'Company';
            TableRelation = Company.Name;
        }
    }
    keys
    {
        key(Key1; "User ID", "Role ID", Company)
        {
        }
    }

    fieldgroups
    {
    }
}
