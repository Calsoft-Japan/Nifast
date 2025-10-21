tableextension 57316 "Warehouse Recepit Header Ext" extends "Warehouse Receipt Header"
{
    fields
    {
        modify("Assigned User ID")
        {
            trigger OnAfterValidate()
            begin
                UpdateWhseRecLines(FieldCaption("Assigned User ID"));
            end;
        }
        field(14017610; "Priority Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(14017630; "Inbound Bill of Lading No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14017631; "Carrier Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14017632; "Carrier Trailer ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14017991; "Placed In Whse. Queue"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF NOT "Placed In Whse. Queue" THEN
                    VALIDATE("Assigned User ID", '');
            end;
        }
    }


    PROCEDURE UpdateWhseRecLines(ChangedFieldName: Text[100]);
    VAR
        WhseRecLine: Record 7317;
    // LinesExist: Boolean;
    BEGIN
        //PFC
        WhseRecLine.RESET();
        WhseRecLine.SETRANGE("No.", "No.");

        IF WhseRecLine.FIND('-') THEN
            REPEAT
                CASE ChangedFieldName OF
                    FIELDCAPTION("Assigned User ID"):
                        BEGIN
                            WhseRecLine."Assigned User ID" := "Assigned User ID";
                            WhseRecLine."Assignment Date" := "Assignment Date";
                            WhseRecLine."Assignment Time" := "Assignment Time";
                        END;
                END;
                WhseRecLine.MODIFY();
            UNTIL WhseRecLine.NEXT() = 0;
    END;
}
