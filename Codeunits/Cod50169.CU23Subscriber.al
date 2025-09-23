codeunit 50169 CU23Subscriber
{
    //Version List=NAVW18.00,NIF1.095;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Batch", OnHandleNonRecurringLineOnAfterCopyItemJnlLine3, '', false, false)]
    local procedure OnHandleNonRecurringLineOnAfterCopyItemJnlLine3(var ItemJournalLine: Record "Item Journal Line"; var ItemJournalLine3: Record "Item Journal Line")
    var
        ItemJnlTemplate: Record "Item Journal Template";
        ReservEntry: Record 337;
    //">>LV_NIF": Integer;
    begin
        ItemJnlTemplate.Get(ItemJournalLine."Journal Template Name");
        //>>ISTRTT 072007
        IF ItemJournalLine3.FIND('-') THEN
            REPEAT
                IF ItemJnlTemplate.Type = ItemJnlTemplate.Type::"Phys. Inventory" THEN BEGIN
                    ReservEntry.SETCURRENTKEY(
                          "Source Type", "Source Subtype", "Source ID", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.");
                    ReservEntry.SETRANGE("Source Type", DATABASE::"Item Journal Line");
                    ReservEntry.SETFILTER("Source Subtype", '2|3');
                    ReservEntry.SETRANGE("Source ID", ItemJournalLine3."Journal Template Name");
                    ReservEntry.SETRANGE("Source Batch Name", ItemJournalLine3."Journal Batch Name");
                    ReservEntry.SETRANGE("Source Ref. No.", ItemJournalLine3."Line No.");
                    ReservEntry.SETRANGE(Quantity, 0);
                    ReservEntry.SETRANGE("Qty. to Handle (Base)", 0);
                    ReservEntry.SETRANGE("Quantity Invoiced (Base)", 0);
                    ReservEntry.SETRANGE("Quantity (Base)", 0);
                    IF NOT ReservEntry.ISEMPTY THEN
                        ReservEntry.DELETEALL(TRUE);
                END;
            UNTIL ItemJournalLine3.NEXT() = 0;
        //<<ISTRTT 072007

    end;
}