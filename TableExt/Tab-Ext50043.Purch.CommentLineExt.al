tableextension 50043 "Purch. Comment Line Ext" extends "Purch. Comment Line"
{
    fields
    {
        field(50000; "Print On Blanket"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'NF1.00:CIS.NG  10-28-15';
        }
        field(14017636; "Print On Quote"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14017637; "Print On Put Away"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14017638; "Print On Order"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14017639; "Print On Receipt"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14017640; "Print On Invoice"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14017641; "Print On Credit Memo"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14017650; "User ID"; code[50])
        {
            DataClassification = ToBeClassified;
            Description = '20-->50 NF1.00:CIS.NG  10-10-15';
            TableRelation = User."User Name";
            ValidateTableRelation = false;
            TestTableRelation = false;
            trigger OnValidate()
            var
                LoginMgt: Codeunit "User Management";
            begin
                LoginMgt.ValidateUserID("User ID");
            end;

            trigger OnLookup()
            var
                LoginMgt: Codeunit "User Management";
            begin
                LoginMgt.LookupUserID("User ID");
            end;
        }
        field(14017651; "Time Stamp"; Time)
        {
            DataClassification = ToBeClassified;
        }
    }
}
