codeunit 50158 CU5760Subscribers
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", OnBeforeInsertTempWhseJnlLine, '', false, false)]
    local procedure "Whse.-Post Receipt_OnBeforeInsertTempWhseJnlLine"(var TempWarehouseJournalLine: Record "Warehouse Journal Line" temporary; PostedWhseReceiptLine: Record "Posted Whse. Receipt Line")
    begin
        // >> JDC //TODO addon changes
        // if PostedWhseReceiptLine."License Plate No." <> '' then begin
        //     TempWarehouseJournalLine."License Plate Operation Type" := TempWarehouseJournalLine."License Plate Operation Type"::"License Plate Movement";
        //     TempWarehouseJournalLine."From License Plate No." := '';
        //     TempWarehouseJournalLine."To License Plate No." := PostedWhseReceiptLine."License Plate No.";
        // end;
        // <<
    end;

}
