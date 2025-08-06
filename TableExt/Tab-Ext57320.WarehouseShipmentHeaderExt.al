tableextension 57320 "Warehouse Shipment Header Ext" extends "Warehouse Shipment Header"
{
    fields
    {
        modify("Assigned User ID")
        {
            trigger OnAfterValidate()
            begin
                //>>PFC
                UpdateWhseShipLines(FIELDCAPTION("Assigned User ID"));
                //<<PFC
            end;
        }
    }
    PROCEDURE UpdateWhseShipLines(ChangedFieldName : Text[100]);
    VAR
        LinesExist : Boolean;
        WhseShipLine : Record 7321;
    BEGIN
        //PFC
        WhseShipLine.RESET;
        WhseShipLine.SETRANGE("No.", "No.");

        IF WhseShipLine.FIND('-') THEN
            REPEAT
                CASE ChangedFieldName OF
                    FIELDCAPTION("Assigned User ID"):
                        BEGIN
                            WhseShipLine."Assigned User ID" := "Assigned User ID";
                            WhseShipLine."Assignment Date" := "Assignment Date";
                            WhseShipLine."Assignment Time" := "Assignment Time";
                        END;
                END;
                WhseShipLine.MODIFY;
            UNTIL WhseShipLine.NEXT = 0;
    END;
}