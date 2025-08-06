tableextension 57355 "Warehouse Recepit Header Ext" extends "Warehouse Receipt Header"
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
    }
    PROCEDURE UpdateWhseRecLines(ChangedFieldName: Text[100]);
    VAR
        LinesExist: Boolean;
        WhseRecLine: Record 7317;
    BEGIN
        //PFC
        WhseRecLine.RESET;
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
                WhseRecLine.MODIFY;
            UNTIL WhseRecLine.NEXT = 0;
    END;
}
