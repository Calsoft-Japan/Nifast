table 50135 "FB Message"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)

    DrillDownPageID = 50146;
    LookupPageID = 50146;
    fields
    {
        field(10; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(20; "Current Date"; Date)
        {
            // cleaned
        }
        field(30; "Current Time"; Time)
        {
            // cleaned
        }
        field(34; "Import Data Log No."; Code[20])
        {
            // cleaned
        }
        field(35; "File Name"; Code[200])
        {
            // cleaned
        }
        field(36; "Line No."; Integer)
        {
            // cleaned
        }
        field(40; "FB Order No."; Code[20])
        {
            // cleaned
        }
        field(50; "Sales Order No."; Code[20])
        {
            // cleaned
        }
        field(60; Message; Text[250])
        {
            // cleaned
        }
        field(80; Status; Option)
        {
            OptionCaption = 'New,Errors,Processed';
            OptionMembers = New,Errors,Processed;
        }
        field(90; Source; Code[10])
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; Source, Status)
        {
        }
        key(Key3; "Import Data Log No.", "Line No.", Source, Status)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Current Date" := WORKDATE();
        "Current Time" := TIME;
    end;

    var
      /*   LineNo: Integer;
        FBMessages: Record "50135"; */
}
