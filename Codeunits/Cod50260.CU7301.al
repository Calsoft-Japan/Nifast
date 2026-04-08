codeunit 50260 CU_7301
{
    [EventSubscriber(ObjectType::Codeunit, 7301, 'OnBeforeBinContentInsert', '', True, false)]
    local procedure OnBeforeBinContentInsert(var BinContent: Record "Bin Content"; WarehouseEntry: Record "Warehouse Entry"; Bin: Record Bin);
    begin
        //>>> NV
        BinContent."QC Bin" := Bin."QC Bin";
        //<< NV
    end;

    [EventSubscriber(ObjectType::Codeunit, 7301, 'OnBeforeInsertWhseEntry', '', True, false)]
    local procedure OnBeforeInsertWhseEntry(var WarehouseEntry: Record "Warehouse Entry"; var WarehouseJournalLine: Record "Warehouse Journal Line")
    begin
        // >> NV - 09/11/03 MV
        //>> NIF 05-25-05 RTT
        //WhseApplMngt.ApplyWhseEntry(WhseEntry);
        NVM.ApplyWhseEntry(WarehouseEntry);
        //>> NIF 05-25-05 RTT
        // << NV - 09/11/03 MV

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse. Jnl.-Register Line", OnInitWhseEntryCopyFromWhseJnlLine, '', false, false)]
    local procedure "Whse. Jnl.-Register Line_OnInitWhseEntryCopyFromWhseJnlLine"(var WarehouseEntry: Record "Warehouse Entry"; var WarehouseJournalLine: Record "Warehouse Journal Line"; OnMovement: Boolean; Sign: Integer; Location: Record Location; BinCode: Code[20]; var IsHandled: Boolean)
    begin

        // >> NV - 09/11/03 MV
        WarehouseEntry."Remaining Qty. (Base)" := WarehouseJournalLine."Qty. (Absolute, Base)" * Sign;
        WarehouseEntry.Open := WarehouseEntry."Remaining Qty. (Base)" <> 0;
        WarehouseEntry.Positive := WarehouseEntry."Remaining Qty. (Base)" > 0;
        IF NOT ((WarehouseJournalLine."Entry Type" = WarehouseJournalLine."Entry Type"::Movement) AND (Sign = 1)) THEN // Apply only one side of movement
            WarehouseEntry."Applies-to Entry No." := WarehouseJournalLine."Applies-to Entry No.";
        // << NV - 09/11/03 MV

        // >> NV - 09/30/03 JDC
        if Sign > 0 then
            WarehouseEntry."License Plate No." := WarehouseJournalLine."To License Plate No."
        else
            WarehouseEntry."License Plate No." := WarehouseJournalLine."From License Plate No.";

        IF WarehouseJournalLine."From License Bin" THEN
            WarehouseEntry."License Bin" := WarehouseJournalLine."From License Bin"
        ELSE BEGIN
            IF WarehouseJournalLine."To License Bin" THEN
                WarehouseEntry."License Bin" := WarehouseJournalLine."To License Bin"
            ELSE
                WarehouseEntry."License Bin" := WarehouseJournalLine."License Bin";
        END;
        // << NV - 09/30/03 JDC
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse. Jnl.-Register Line", OnCodeBeforeInitWhseEntryFromBinCode, '', false, false)]
    local procedure "Whse. Jnl.-Register Line_OnCodeBeforeInitWhseEntryFromBinCode"(WarehouseJournalLine: Record "Warehouse Journal Line"; WarehouseEntry: Record "Warehouse Entry")
    begin

    end;


    var
        NVM: Codeunit "NewVision Management_New";


}
