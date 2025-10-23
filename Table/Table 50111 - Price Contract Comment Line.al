table 50111 "Price Contract Comment Line"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)
    // NF1.00:CIS.NG    10/10/15 Fix the Table Relation Property for fields (Remove the relationship for non exists table)

    fields
    {
        field(1; "Price Contract No."; Code[20])
        {
            // cleaned
        }
        field(2; "Line No."; Integer)
        {
            // cleaned
        }
        field(3; Date; Date)
        {
            // cleaned
        }
        field(4; "Code"; Code[10])
        {
            trigger OnValidate()
            begin
                IF StandardText.GET(Code) THEN
                    Comment := StandardText.Description;
            end;
        }
        field(5; Comment; Text[80])
        {
            // cleaned
        }
        field(50117; "User ID"; Code[20])
        {

            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            var
                LoginMgt: Codeunit 418;
            begin
                //LoginMgt.LookupUserID("User ID");
                LoginMgt.DisplayUserInformation("User ID");
            end;

            trigger OnValidate()
            var
                LoginMgt: Codeunit 418;
            begin
                //LoginMgt.ValidateUserID("User ID");
                LoginMgt.DisplayUserInformation("User ID");
            end;
        }
        field(50118; "Time Stamp"; Time)
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; "Price Contract No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        VALIDATE("User ID", USERID);
        "Time Stamp" := TIME;
    end;

    trigger OnModify()
    begin
        VALIDATE("User ID", USERID);
        "Time Stamp" := TIME;
    end;

    trigger OnRename()
    begin
        VALIDATE("User ID", USERID);
        "Time Stamp" := TIME;
    end;

    var
        StandardText: Record 7;

    procedure SetUpNewLine()
    var
        LineCommentLine: Record 50111;
    begin
        LineCommentLine.SETRANGE("Price Contract No.", "Price Contract No.");
        LineCommentLine.SETRANGE("Line No.", "Line No.");
        IF LineCommentLine.ISEMPTY() THEN
            Date := WORKDATE();
    end;
}
