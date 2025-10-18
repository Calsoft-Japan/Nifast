table 50031 "EDI Sales Order Import Log"
{
    // NF1.00:CIS.NG    10/14/15 XMLport Development - EDI Sales Order Import

    Caption = 'EDI Sales Order Import Log';
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Editable = false;
        }
        field(21; "File Name"; Text[250])
        {
            Editable = false;
        }
        field(22; "Import Date"; Date)
        {
            Editable = false;
        }
        field(23; "Import Time"; Time)
        {
            Editable = false;
        }
        field(24; "Import By"; Code[50])
        {
            Editable = false;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                //TODO
                // UserMgt.LookupUserID("Import By");
                //TODO
            end;

            trigger OnValidate()
            begin
                //TODO
                //UserMgt.ValidateUserID("Import By");
                //TODO
            end;
        }
        field(25; "Sales Orders"; Code[250])
        {
            Editable = false;
        }
        field(32; Status; Option)
        {
            Editable = false;
            OptionCaption = ' ,Success,Error';
            OptionMembers = " ",Success,Error;
        }
        field(33; "Error Detail"; Text[250])
        {
            Editable = false;
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
    var
        //UserMgt: Codeunit 418;

    trigger OnInsert()
    var
        EDISalesLog_lRec: Record 50031;
    begin
        EDISalesLog_lRec.RESET();
        IF EDISalesLog_lRec.FINDLAST() THEN
            "Entry No." := EDISalesLog_lRec."Entry No." + 1
        ELSE
            "Entry No." := 1;
    end;
}
