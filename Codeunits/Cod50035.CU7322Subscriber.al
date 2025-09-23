codeunit 50035 CU7322Subscriber
{
    var
        IoTError: Boolean;
        IoTDocumentNo: Code[20];
        IoTDocumentLineNo: Integer;
        IoTEntryNo: Integer;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Inventory Pick/Movement", OnBeforeNewWhseActivLineInsertFromSales, '', false, false)]

    local procedure OnBeforeNewWhseActivLineInsertFromSales(var WarehouseActivityLine: Record "Warehouse Activity Line"; var SalesLine: Record "Sales Line"; var WarehouseActivityHeader: Record "Warehouse Activity Header"; var RemQtyToPickBase: Decimal)
    begin
        //>>CIS.IoT Ram
        IF SalesLine."IoT Lot No." <> '' THEN
            WarehouseActivityHeader.Type := WarehouseActivityHeader.Type::"Invt. Pick";
        //<<CIS.IoT Ram

        //>>CIS.IoT Ram
        //IF "IoT Lot No." <> '' THEN
        //  WarehouseActivityLine."Lot No." := "IoT Lot No.";
        //<<CIS.IoT Ram

        //>> NIF #10069 RTT 06-01-05
        WarehouseActivityLine."Units per Parcel" := SalesLine."Units per Parcel";
        //<< NIF #10069 RTT 06-01-05
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Inventory Pick/Movement", OnBeforeNewWhseActivLineInsertFromTransfer, '', false, false)]
    local procedure OnBeforeNewWhseActivLineInsertFromTransfer(var WarehouseActivityLine: Record "Warehouse Activity Line"; var TransferLine: Record "Transfer Line"; var WarehouseActivityHeader: Record "Warehouse Activity Header"; var RemQtyToPickBase: Decimal)
    begin
        //>>CIS.IoT Ram
        //IF TransferLine."IoT Lot No." <> '' THEN
        //  WarehouseActivityLine."Lot No." := TransferLine."IoT Lot No.";
        //<<CIS.IoT Ram

        //>> NIF #10069 RTT 08-29-05
        WarehouseActivityLine."Units per Parcel" := TransferLine."Units per Parcel";
        //<< NIF #10069 RTT 08-29-05
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Inventory Pick/Movement", OnCreatePickOrMoveLineOnAfterCalcQtyAvailToPickBase, '', false, false)]
    local procedure OnCreatePickOrMoveLineOnAfterCalcQtyAvailToPickBase(var WarehouseActivityLine: Record "Warehouse Activity Line"; SNRequired: Boolean; LNRequired: Boolean; ReservationExists: Boolean; var RemQtyToPickBase: Decimal; var QtyAvailToPickBase: Decimal; var IsHandled: Boolean)
    var
        IoTDataStage: Record 50042;
        IoTDataStageM: Record 50042;
        WhseActivHeader: Record "Warehouse Activity Header";
        Text001: Label 'Only %1 quantity available to pick', Comment = '%1 - QtyAvailToPickBase';
        Text002: Label 'Invt. Pick created for Parital Qty.';
    begin
        IoTError := FALSE;


        //>>CIS.IoT Ram
        IF (QtyAvailToPickBase = 0) AND
           (WarehouseActivityLine."Lot No." <> '')
        THEN BEGIN
            IoTDataStage.RESET();
            IF WarehouseActivityLine."Activity Type" = WarehouseActivityLine."Activity Type"::"Invt. Pick" THEN
                IoTDataStage.SETRANGE(IoTDataStage."Document Type", IoTDataStage."Document Type"::"Invt. Pick");
            IoTDataStage.SETRANGE("Document No.", WarehouseActivityLine."Source No.");
            IoTDataStage.SETRANGE("Line No.", WarehouseActivityLine."Source Line No.");
            IoTDataStage.SETRANGE("Record Status", 0, 1);
            IF IoTDataStage.FINDSET() THEN BEGIN
                IoTDocumentLineNo := 0;
                IoTDocumentLineNo := IoTDataStage."Line No.";
                IoTEntryNo := 0;
                IoTEntryNo := IoTDataStage."Entry No.";
                IoTDataStageM.GET(IoTDataStage."Entry No.");
                IoTDataStageM."Record Status" := IoTDataStageM."Record Status"::Error;
                IoTDataStageM."Error Message" := STRSUBSTNO(Text001, QtyAvailToPickBase);
                IoTDataStageM.MODIFY();
                IoTError := TRUE;
                COMMIT();
            END;
        END ELSE
            if (WarehouseActivityLine."Lot No." <> '') AND (RemQtyToPickBase <= QtyAvailToPickBase) THEN BEGIN
                IoTDataStage.RESET();
                IF WarehouseActivityLine."Activity Type" = WarehouseActivityLine."Activity Type"::"Invt. Pick" THEN
                    IoTDataStage.SETRANGE(IoTDataStage."Document Type", IoTDataStage."Document Type"::"Invt. Pick");
                IoTDataStage.SETRANGE("Document No.", WarehouseActivityLine."Source No.");
                IoTDataStage.SETRANGE("Line No.", WarehouseActivityLine."Source Line No.");
                IoTDataStage.SETRANGE("Record Status", 0, 1);
                IF IoTDataStage.FINDSET() THEN BEGIN
                    IoTDocumentLineNo := 0;
                    IoTDocumentLineNo := IoTDataStage."Line No.";
                    IoTEntryNo := 0;
                    IoTEntryNo := IoTDataStage."Entry No.";
                    IoTDataStageM.GET(IoTDataStage."Entry No.");
                    IoTDataStageM."Record Status" := IoTDataStageM."Record Status"::Processed;
                    IoTDataStageM."Error Message" := '';
                    IoTDataStageM."Output Invt. Pick Type" := IoTDataStageM."Output Invt. Pick Type"::"Invt. Pick";
                    if WhseActivHeader.Get(WarehouseActivityLine."Activity Type", WarehouseActivityLine."No.") then
                        IoTDataStageM."Output Pick No." := WhseActivHeader."No.";
                    IoTDataStageM.MODIFY();
                    IoTError := TRUE;
                    COMMIT();
                END;
            END ELSE
                IF (WarehouseActivityLine."Lot No." <> '') AND (QtyAvailToPickBase <> 0) AND (RemQtyToPickBase > QtyAvailToPickBase) THEN BEGIN
                    IoTDataStage.RESET();
                    IF WarehouseActivityLine."Activity Type" = WarehouseActivityLine."Activity Type"::"Invt. Pick" THEN
                        IoTDataStage.SETRANGE(IoTDataStage."Document Type", IoTDataStage."Document Type"::"Invt. Pick");
                    IoTDataStage.SETRANGE("Document No.", WarehouseActivityLine."Source No.");
                    IoTDataStage.SETRANGE("Line No.", WarehouseActivityLine."Source Line No.");
                    IoTDataStage.SETRANGE("Record Status", 0, 1);
                    IF IoTDataStage.FindSet() THEN BEGIN
                        IoTDocumentLineNo := 0;
                        IoTDocumentLineNo := IoTDataStage."Line No.";
                        IoTEntryNo := 0;
                        IoTEntryNo := IoTDataStage."Entry No.";
                        IoTDataStageM.GET(IoTDataStage."Entry No.");
                        IoTDataStageM."Record Status" := IoTDataStageM."Record Status"::Error;
                        IoTDataStageM."Error Message" := Text002 + FORMAT(RemQtyToPickBase - QtyAvailToPickBase);
                        IoTDataStageM."Output Invt. Pick Type" := IoTDataStageM."Output Invt. Pick Type"::"Invt. Pick";
                        if WhseActivHeader.Get(WarehouseActivityLine."Activity Type", WarehouseActivityLine."No.") then
                            IoTDataStageM."Output Pick No." := WhseActivHeader."No.";
                        IoTDataStageM.MODIFY();
                        IoTError := TRUE;
                        COMMIT();
                    END;
                END;
        //<<CIS.IoT Ram
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Inventory Pick/Movement", OnBeforeFindFromBinContent, '', false, false)]
    local procedure OnBeforeFindFromBinContent(var FromBinContent: Record "Bin Content"; var WarehouseActivityLine: Record "Warehouse Activity Line"; FromBinCode: Code[20]; BinCode: Code[20]; IsInvtMovement: Boolean; IsBlankInvtMovement: Boolean; DefaultBin: Boolean; WhseItemTrackingSetup: Record "Item Tracking Setup"; var WarehouseActivityHeader: Record "Warehouse Activity Header"; var WarehouseRequest: Record "Warehouse Request")
    begin
        //>> NIF 07-29-05 RTT
        FromBinContent.SETFILTER("Block Movement", '%1|%2', FromBinContent."Block Movement"::" ", FromBinContent."Block Movement"::Inbound);
        //<< NIF 07-29-05 RTT
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Inventory Pick/Movement", OnBeforeNewWhseActivLineInsert, '', false, false)]
    local procedure OnBeforeNewWhseActivLineInsert(var WarehouseActivityLine: Record "Warehouse Activity Line"; WarehouseActivityHeader: Record "Warehouse Activity Header")
    begin
        WarehouseActivityLine."Qty. to Handle" := WarehouseActivityLine."Qty. Outstanding";
        WarehouseActivityLine."Qty. to Handle (Base)" := WarehouseActivityLine."Qty. Outstanding (Base)";

        //<< NIF #9876
        //>> NIF #10069 RTT 06-01-05
        IF WarehouseActivityLine."Units per Parcel" <> 0 THEN
            WarehouseActivityLine."Total Parcels" := WarehouseActivityLine."Qty. (Base)" / WarehouseActivityLine."Units per Parcel";
        //<< NIF #10069 RTT 06-01-05
    end;

    PROCEDURE GetIoTErrorStatus(): Boolean;
    BEGIN
        //>>CIS.IoT 07/22/22 RAM
        EXIT(IoTError);
        //<<CIS.IoT 07/22/22 RAM
    END;

    PROCEDURE GetIoTDocumentNo(): Code[20];
    BEGIN
        EXIT(IoTDocumentNo);   //CIS.IoT 07/22/22 RAM
    END;
}