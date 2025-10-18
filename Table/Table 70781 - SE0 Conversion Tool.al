table 70781 "SE0 Conversion Tool"
{
    Caption = 'SE0 Conversion Tool';
    DataPerCompany = false;
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Tool Name"; Code[30])
        {
            Caption = 'Tool Name';
        }
        field(3; "Action"; Option)
        {
            Caption = 'Action';
            OptionCaption = 'Start,Finish';
            OptionMembers = Start,Finish;
        }
        field(4; "Modified By"; Text[30])
        {
            Caption = 'Modified By';
        }
        field(5; "Date Modified"; Date)
        {
            Caption = 'Date Modified';
        }
        field(6; "Time Modified"; Time)
        {
            Caption = 'Time Modified';
        }
        field(7; "Company Name"; Text[100])
        {
            Caption = 'Company Name';
        }
        field(8; Nav2013; Boolean)
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Company Name", "Tool Name")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Modified By" := USERID;
        "Date Modified" := TODAY;
        "Time Modified" := TIME;
        "Company Name" := COMPANYNAME;
    end;

    procedure InsertSEDataTool(ToolName: Code[20]; ActionTaken: Integer; Nav2013Flag: Boolean)
    var
        SEDataTool: Record 70781;
    begin
        LOCKTABLE();
        IF SEDataTool.FindLast() THEN
            "Entry No." := SEDataTool."Entry No." + 1
        ELSE
            "Entry No." := 1;
        "Tool Name" := ToolName;
        Action := ActionTaken;
        Nav2013 := Nav2013Flag;
        INSERT(TRUE);
    end;
}
