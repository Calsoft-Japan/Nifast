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


}
