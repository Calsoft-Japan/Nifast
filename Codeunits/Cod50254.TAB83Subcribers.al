codeunit 50254 Tab83
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


    procedure TestItemSoftBlock(ItemJournalLine: Record "Item Journal Line")
    var
        SoftBlockError: Text[250];
    begin
        case ItemJournalLine."Entry Type" of
            ItemJournalLine."Entry Type"::Sale:
                begin
                    if NVM.CheckSoftBlock(2, ItemJournalLine."Item No.", ItemJournalLine."Location Code", ItemJournalLine."Variant Code", 0, SoftBlockError) then
                        Error(SoftBlockError);
                end;

            ItemJournalLine."Entry Type"::Purchase:
                begin
                    if NVM.CheckSoftBlock(2, ItemJournalLine."Item No.", ItemJournalLine."Location Code", ItemJournalLine."Variant Code", 1, SoftBlockError) then
                        Error(SoftBlockError);
                end;

            ItemJournalLine."Entry Type"::Transfer:
                begin
                    if NVM.CheckSoftBlock(2, ItemJournalLine."Item No.", ItemJournalLine."Location Code", ItemJournalLine."Variant Code", 2, SoftBlockError) then
                        Error(SoftBlockError);
                end;
        end;
    end;


    var
        NVM: Codeunit 50021;
        SoftBlockError: Text[80];



}