tableextension 50043 "Purch. Comment Line Ext" extends "Purch. Comment Line"
{
    fields
    {
        field(50000; "Print On Blanket"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'NF1.00:CIS.NG  10-28-15';
        }
        field(70000; "Print On Quote"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70001; "Print On Put Away"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70002; "Print On Order"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70003; "Print On Receipt"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70004; "Print On Invoice"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70005; "Print On Credit Memo"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70006; "User ID"; code[50])
        {
            DataClassification = ToBeClassified;
            Description = '20-->50 NF1.00:CIS.NG  10-10-15';
            TableRelation = User."User Name" where(State = const(Enabled));
            ValidateTableRelation = false;
        }
        field(70007; "Time Stamp"; Time)
        {
            DataClassification = ToBeClassified;
        }
    }
    trigger OnInsert()
    begin
        //>>NV
        VALIDATE("User ID", USERID);
        "Time Stamp" := TIME;
        //<<NV
    end;

    trigger OnModify()
    begin
        //>>NV
        VALIDATE("User ID", USERID);
        "Time Stamp" := TIME;
        //<<NV
    end;

    trigger OnRename()
    begin
        //>>NV
        VALIDATE("User ID", USERID);
        "Time Stamp" := TIME;
        //<<NV
    end;
}
