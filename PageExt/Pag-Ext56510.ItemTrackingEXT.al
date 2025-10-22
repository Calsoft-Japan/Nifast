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
    var
        FormRunMode: Option ,Reclass,"Combined Ship/Rcpt","Drop Shipment",Transfer;

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

    PROCEDURE EShipGetRecords(VAR EShipTrackingSpecification: Record 336 temporary);
    BEGIN
        IF rec.FindFirst() THEN
            REPEAT
                EShipTrackingSpecification := Rec;
                EShipTrackingSpecification.INSERT();
            UNTIL rec.NEXT() = 0;
    END;



    PROCEDURE EShipInsertRecord(VAR EShipTrackingSpecification: Record 336 TEMPORARY): Boolean;
    BEGIN
        Rec := EShipTrackingSpecification;
        rec."Entry No." := NextEntryNo();
        rec."Qty. per Unit of Measure" := QtyPerUOM;
        IF (NOT InsertIsBlocked) AND (NOT ZeroLineExists) THEN
            IF NOT TestTempSpecificationExists() THEN BEGIN
                TempItemTrackLineInsert.TRANSFERFIELDS(Rec);
                TempItemTrackLineInsert.INSERT();
                rec.INSERT();
                ItemTrackingDataCollection.UpdateTrackingDataSetWithChange(
                  TempItemTrackLineInsert, CurrentSignFactor * SourceQuantityArray[1] < 0, CurrentSignFactor, 0);
            END;
        CalculateSums();

        EXIT(FALSE);
    END;

    LOCAL PROCEDURE NextEntryNo(): Integer;
    BEGIN
        LastEntryNo += 1;
        EXIT(LastEntryNo);
    END;


    PROCEDURE EShipModifyRecord(VAR EShipTrackingSpecification: Record 336 TEMPORARY): Boolean;
    VAR
        xTempTrackingSpec: Record 336 TEMPORARY;
    BEGIN
        Rec := EShipTrackingSpecification;

        IF NOT TestTempSpecificationExists() THEN
            Rec.MODIFY();

        IF (xRec."Lot No." <> Rec."Lot No.") OR (xRec."Serial No." <> REc."Serial No.") THEN BEGIN
            xTempTrackingSpec := xRec;
            ItemTrackingDataCollection.UpdateTrackingDataSetWithChange(
              xTempTrackingSpec, CurrentSignFactor * SourceQuantityArray[1] < 0, CurrentSignFactor, 2);
        END;

        IF TempItemTrackLineModify.GET(Rec."Entry No.") THEN
            TempItemTrackLineModify.DELETE();
        IF TempItemTrackLineInsert.GET(Rec."Entry No.") THEN BEGIN
            TempItemTrackLineInsert.TRANSFERFIELDS(Rec);
            TempItemTrackLineInsert.MODIFY();
            ItemTrackingDataCollection.UpdateTrackingDataSetWithChange(
              TempItemTrackLineInsert, CurrentSignFactor * SourceQuantityArray[1] < 0, CurrentSignFactor, 1);
        END ELSE BEGIN
            TempItemTrackLineModify.TRANSFERFIELDS(Rec);
            TempItemTrackLineModify.INSERT();
            ItemTrackingDataCollection.UpdateLotSNDataSetWithChange(
              TempItemTrackLineModify, CurrentSignFactor * SourceQuantityArray[1] < 0, CurrentSignFactor, 1);
        END;
        CalculateSums();

        EXIT(FALSE);
    END;

    PROCEDURE EShipDeleteRecord(VAR EShipTrackingSpecification: Record 336 TEMPORARY): Boolean;
    VAR
        TrackingSpec: Record 336;
        WMSManagement: Codeunit 7302;
        AlreadyDeleted: Boolean;
    BEGIN
        Rec := EShipTrackingSpecification;
        TrackingSpec."Item No." := Rec."Item No.";
        TrackingSpec."Location Code" := REc."Location Code";
        TrackingSpec."Source Type" := Rec."Source Type";
        TrackingSpec."Source Subtype" := Rec."Source Subtype";
        WMSManagement.CheckItemTrackingChange(TrackingSpec, Rec);

        IF NOT DeleteIsBlocked THEN BEGIN
            AlreadyDeleted := TempItemTrackLineDelete.GET(Rec."Entry No.");
            TempItemTrackLineDelete.TRANSFERFIELDS(Rec);
            IF NOT AlreadyDeleted THEN
                TempItemTrackLineDelete.INSERT();
            ItemTrackingDataCollection.UpdateTrackingDataSetWithChange(
              TempItemTrackLineDelete, CurrentSignFactor * SourceQuantityArray[1] < 0, CurrentSignFactor, 2);
            IF TempItemTrackLineInsert.GET(Rec."Entry No.") THEN
                TempItemTrackLineInsert.DELETE();
            IF TempItemTrackLineModify.GET(rec."Entry No.") THEN
                TempItemTrackLineModify.DELETE();
            Rec.DELETE(TRUE);
        END;
        CalculateSums();

        EXIT(FALSE);
    END;




    PROCEDURE NVOpenForm();
    BEGIN
        UpdateUndefinedQty();
    END;

    PROCEDURE NVCloseForm();
    BEGIN
        IF UpdateUndefinedQty() THEN
            WriteToDatabase();
        IF FormRunMode = FormRunMode::Transfer THEN
            SynchronizeLinkedSources('');
    END;

    PROCEDURE NVGetRecords(VAR EShipTrackingSpecification: Record 336 TEMPORARY);
    BEGIN
        IF Rec.FindFirst() THEN
            REPEAT
                EShipTrackingSpecification := Rec;
                EShipTrackingSpecification.INSERT();
            UNTIL rec.NEXT() = 0;
    END;

    PROCEDURE NVInsertRecord(VAR EShipTrackingSpecification: Record 336 TEMPORARY): Boolean;
    BEGIN
        Rec := EShipTrackingSpecification;
        Rec."Entry No." := NextEntryNo;
        rec."Qty. per Unit of Measure" := QtyPerUOM;
        IF (NOT InsertIsBlocked) AND (NOT ZeroLineExists) THEN
            IF NOT TestTempSpecificationExists THEN BEGIN
                TempItemTrackLineInsert.TRANSFERFIELDS(Rec);
                TempItemTrackLineInsert.INSERT;
                rec.INSERT();
                ItemTrackingDataCollection.UpdateTrackingDataSetWithChange(
                  TempItemTrackLineInsert, CurrentSignFactor * SourceQuantityArray[1] < 0, CurrentSignFactor, 0);
            END;
        CalculateSums();

        EXIT(FALSE);
    END;

    PROCEDURE NVModifyRecord(VAR EShipTrackingSpecification: Record 336 TEMPORARY): Boolean;
    VAR
        xTempTrackingSpec: Record 336 TEMPORARY;
    BEGIN
        Rec := EShipTrackingSpecification;

        IF NOT TestTempSpecificationExists() THEN
            Rec.MODIFY();

        IF (xRec."Lot No." <> rec."Lot No.") OR (xRec."Serial No." <> rec."Serial No.") THEN BEGIN
            xTempTrackingSpec := xRec;
            ItemTrackingDataCollection.UpdateTrackingDataSetWithChange(
              xTempTrackingSpec, CurrentSignFactor * SourceQuantityArray[1] < 0, CurrentSignFactor, 2);
        END;

        IF TempItemTrackLineModify.GET(rec."Entry No.") THEN
            TempItemTrackLineModify.DELETE();
        IF TempItemTrackLineInsert.GET(rec."Entry No.") THEN BEGIN
            TempItemTrackLineInsert.TRANSFERFIELDS(Rec);
            TempItemTrackLineInsert.MODIFY();
            ItemTrackingDataCollection.UpdateTrackingDataSetWithChange(
              TempItemTrackLineInsert, CurrentSignFactor * SourceQuantityArray[1] < 0, CurrentSignFactor, 1);
        END ELSE BEGIN
            TempItemTrackLineModify.TRANSFERFIELDS(Rec);
            TempItemTrackLineModify.INSERT();
            ItemTrackingDataCollection.UpdateTrackingDataSetWithChange(
              TempItemTrackLineModify, CurrentSignFactor * SourceQuantityArray[1] < 0, CurrentSignFactor, 1);
        END;
        CalculateSums();

        EXIT(FALSE);
    END;

    PROCEDURE NVDeleteRecord(VAR EShipTrackingSpecification: Record 336 temporary): Boolean;
    VAR
        TrackingSpec: Record 336;
        WMSManagement: Codeunit 7302;
        AlreadyDeleted: Boolean;
    BEGIN
        Rec := EShipTrackingSpecification;
        TrackingSpec."Item No." := rec."Item No.";
        TrackingSpec."Location Code" := rec."Location Code";
        TrackingSpec."Source Type" := rec."Source Type";
        TrackingSpec."Source Subtype" := rec."Source Subtype";
        WMSManagement.CheckItemTrackingChange(TrackingSpec, Rec);

        IF NOT DeleteIsBlocked THEN BEGIN
            AlreadyDeleted := TempItemTrackLineDelete.GET(rec."Entry No.");
            TempItemTrackLineDelete.TRANSFERFIELDS(Rec);
            IF NOT AlreadyDeleted THEN
                TempItemTrackLineDelete.INSERT();
            ItemTrackingDataCollection.UpdateTrackingDataSetWithChange(
              TempItemTrackLineDelete, CurrentSignFactor * SourceQuantityArray[1] < 0, CurrentSignFactor, 2);
            IF TempItemTrackLineInsert.GET(rec."Entry No.") THEN
                TempItemTrackLineInsert.DELETE();
            IF TempItemTrackLineModify.GET(rec."Entry No.") THEN
                TempItemTrackLineModify.DELETE();
            rec.DELETE(TRUE);
        END;
        CalculateSums();

        EXIT(FALSE);
    END;


}
