pageextension 56510 "Item Tracking EXT" extends "item tracking lines"
{
    layout
    {
        
    }
    actions
    {
        addafter(Line_LotNoInfoCard)
        {
            action("Assign Lot")
            {
                CaptionML = ENU = 'Assign Lot #';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Assign lot';
                Image = Lot;
                trigger OnAction()
                BEGIN
                    //>>NIF MAK 071205
                    IF InsertIsBlocked THEN
                        EXIT;
                    AssignLotNo();
                    //<<NIF MAK 071205
                END;

            }
            action("Lot Info")
            {
                CaptionML = ENU = 'Lot Info';
                ToolTip = 'Lot Info';
                RunObject = Page 6505;
                RunPageLink = "Item No." = FIELD("Item No."),
                                  "Variant Code" = FIELD("Variant Code"),
                                  "Lot No." = FIELD("Lot No.");
                Promoted = true;
                Visible = FALSE;
                Image = Lot;
                PromotedCategory = Process;
                trigger OnAction()
                BEGIN
                    //>>NIF MAK 071205
                    rec.TESTFIELD("Lot No.");
                    //<<NIF MAK 071205
                END;
            }
        }
    }

    PROCEDURE EShipOpenForm();
    BEGIN
        UpdateUndefinedQty();
    END;

    PROCEDURE EShipCloseForm();
    BEGIN
        IF UpdateUndefinedQty() THEN
            WriteToDatabase();
        IF FormRunMode = FormRunMode::Transfer THEN
            SynchronizeLinkedSources('');
    END;

    PROCEDURE EShipGetRecords(VAR EShipTrackingSpecification: TEMPORARY Record 336);
    BEGIN
        IF FIND THEN
            REPEAT
                EShipTrackingSpecification := Rec;
                EShipTrackingSpecification.INSERT;
            UNTIL NEXT = 0;
    END;

    PROCEDURE EShipInsertRecord(VAR EShipTrackingSpecification: TEMPORARY Record 336): Boolean;
    BEGIN
        Rec := EShipTrackingSpecification;
        rec."Entry No." := NextEntryNo;
        rec."Qty. per Unit of Measure" := QtyPerUOM;
        IF (NOT InsertIsBlocked) AND (NOT ZeroLineExists) THEN
            IF NOT TestTempSpecificationExists THEN BEGIN
                TempItemTrackLineInsert.TRANSFERFIELDS(Rec);
                TempItemTrackLineInsert.INSERT;
                INSERT();
                ItemTrackingDataCollection.UpdateLotSNDataSetWithChange(
                  TempItemTrackLineInsert, CurrentSignFactor * SourceQuantityArray[1] < 0, CurrentSignFactor, 0);
            END;
        CalculateSums();

        EXIT(FALSE);
    END;

    PROCEDURE EShipModifyRecord(VAR EShipTrackingSpecification: TEMPORARY Record 336): Boolean;
    VAR
        xTempTrackingSpec: TEMPORARY Record 336;
    BEGIN
        Rec := EShipTrackingSpecification;

        IF NOT TestTempSpecificationExists THEN
            MODIFY;

        IF (xRec."Lot No." <> "Lot No.") OR (xRec."Serial No." <> "Serial No.") THEN BEGIN
            xTempTrackingSpec := xRec;
            ItemTrackingDataCollection.UpdateLotSNDataSetWithChange(
              xTempTrackingSpec, CurrentSignFactor * SourceQuantityArray[1] < 0, CurrentSignFactor, 2);
        END;

        IF TempItemTrackLineModify.GET("Entry No.") THEN
            TempItemTrackLineModify.DELETE;
        IF TempItemTrackLineInsert.GET("Entry No.") THEN BEGIN
            TempItemTrackLineInsert.TRANSFERFIELDS(Rec);
            TempItemTrackLineInsert.MODIFY;
            ItemTrackingDataCollection.UpdateLotSNDataSetWithChange(
              TempItemTrackLineInsert, CurrentSignFactor * SourceQuantityArray[1] < 0, CurrentSignFactor, 1);
        END ELSE BEGIN
            TempItemTrackLineModify.TRANSFERFIELDS(Rec);
            TempItemTrackLineModify.INSERT;
            ItemTrackingDataCollection.UpdateLotSNDataSetWithChange(
              TempItemTrackLineModify, CurrentSignFactor * SourceQuantityArray[1] < 0, CurrentSignFactor, 1);
        END;
        CalculateSums;

        EXIT(FALSE);
    END;

    PROCEDURE EShipDeleteRecord(VAR EShipTrackingSpecification: TEMPORARY Record 336): Boolean;
    VAR
        TrackingSpec: Record 336;
        WMSManagement: Codeunit 7302;
        AlreadyDeleted: Boolean;
    BEGIN
        Rec := EShipTrackingSpecification;
        TrackingSpec."Item No." := "Item No.";
        TrackingSpec."Location Code" := "Location Code";
        TrackingSpec."Source Type" := "Source Type";
        TrackingSpec."Source Subtype" := "Source Subtype";
        WMSManagement.CheckItemTrackingChange(TrackingSpec, Rec);

        IF NOT DeleteIsBlocked THEN BEGIN
            AlreadyDeleted := TempItemTrackLineDelete.GET("Entry No.");
            TempItemTrackLineDelete.TRANSFERFIELDS(Rec);
            IF NOT AlreadyDeleted THEN
                TempItemTrackLineDelete.INSERT;
            ItemTrackingDataCollection.UpdateLotSNDataSetWithChange(
              TempItemTrackLineDelete, CurrentSignFactor * SourceQuantityArray[1] < 0, CurrentSignFactor, 2);
            IF TempItemTrackLineInsert.GET("Entry No.") THEN
                TempItemTrackLineInsert.DELETE;
            IF TempItemTrackLineModify.GET("Entry No.") THEN
                TempItemTrackLineModify.DELETE;
            DELETE(TRUE);
        END;
        CalculateSums;

        EXIT(FALSE);
    END;


}
