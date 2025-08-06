codeunit 50043 Tab83
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Table, 83, 'OnValidateItemNoOnAfterGetItem', '', True, false)]
    local procedure OnValidateItemNoOnAfterGetItem(var ItemJournalLine: Record "Item Journal Line"; Item: Record Item)
    begin
        // //>>NV
        // TestItemSoftBlock(ItemJournalLine);
        // //<<NV
        ItemJournalLine.National := Item.National;
    end;

    [EventSubscriber(ObjectType::Table, 83, 'OnBeforeVerifyReservedQty', '', True, false)]
    local procedure OnBeforeVerifyReservedQty(var ItemJournalLine: Record "Item Journal Line"; xItemJournalLine: Record "Item Journal Line"; CalledByFieldNo: Integer)
    begin
        //>> NIF 06-29-05 RTT
        NVM.GetActiveDrawingRevision(ItemJournalLine."Item No.", ItemJournalLine."Revision No.", ItemJournalLine."Drawing No.", ItemJournalLine."Revision Date");
        //<< NIF 06-29-05 RTT

    end;


    PROCEDURE TestItemSoftBlock(ItemJournalLine: record "Item Journal Line");
    BEGIN
        CASE ItemJournalLine."Entry Type" OF
            ItemJournalLine."Entry Type"::Sale:
                BEGIN
                    IF NVM.CheckSoftBlock(2, ItemJournalLine."Item No.", ItemJournalLine."Location Code", ItemJournalLine."Variant Code", 0, SoftBlockError) THEN
                        ERROR(SoftBlockError);
                END;
            ItemJournalLine."Entry Type"::Purchase:
                BEGIN
                    IF NVM.CheckSoftBlock(2, ItemJournalLine."Item No.", ItemJournalLine."Location Code", ItemJournalLine."Variant Code", 1, SoftBlockError) THEN
                        ERROR(SoftBlockError);
                END;
            ItemJournalLine."Entry Type"::Transfer:
                BEGIN
                    IF NVM.CheckSoftBlock(2, ItemJournalLine."Item No.", ItemJournalLine."Location Code", ItemJournalLine."Variant Code", 2, SoftBlockError) THEN
                        ERROR(SoftBlockError);
                END;
        END;
    END;

    var
        NVM: Codeunit 50021;
        SoftBlockError: Text[80];



}