table 50140 "FB Tag Journal Batch"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)

    Caption = 'FB Tag Journal Batch';
    DataCaptionFields = Name, Description;
    LookupPageID = 50139;
    fields
    {
        field(1; Name; Code[10])
        {
            Caption = 'Name';
            NotBlank = true;
        }
        field(10; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(20; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
        }
    }
    keys
    {
        key(Key1; Name)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        FBTagJnlLine.SETRANGE("Journal Batch Name", Name);
        FBTagJnlLine.DELETEALL(TRUE);
    end;

    trigger OnRename()
    begin
        FBTagJnlLine.SETRANGE("Journal Batch Name", xRec.Name);
        IF FBTagJnlLine.FIND('-') THEN
            REPEAT
                FBTagJnlLine.RENAME(Name, FBTagJnlLine."Line No.");
            UNTIL FBTagJnlLine.NEXT() = 0;
    end;

    var
        FBTagJnlLine: Record 50141;
    //  FBSetup: Record 50133;
}
