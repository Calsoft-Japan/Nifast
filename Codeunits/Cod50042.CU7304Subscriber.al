codeunit 50042 CU7304Subscriber
{
    //  Version NAVW17.00,NV4.35;
    var
        NV001: Label 'License required for Bin %1', Comment = '%1=Field value';

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse. Jnl.-Register Batch", OnCheckLinesOnBeforeCheckWhseJnlLine, '', false, false)]
    local procedure OnCheckLinesOnBeforeCheckWhseJnlLine(WarehouseJournalLine: Record "Warehouse Journal Line"; var IsHandled: Boolean)
    begin
        //TODO
        //>>NV
        IF (WarehouseJournalLine."To License Bin") AND (WarehouseJournalLine."To License Plate No." = '') THEN
            ERROR(STRSUBSTNO(NV001, WarehouseJournalLine."To Bin Code"));
        IF (WarehouseJournalLine."From License Bin") AND (WarehouseJournalLine."From License Plate No." = '') THEN
            ERROR(STRSUBSTNO(NV001, WarehouseJournalLine."From Bin Code"));
        //<<NV 
        //TODO
    end;
}