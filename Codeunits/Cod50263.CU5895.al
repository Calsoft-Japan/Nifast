codeunit 50263 CU_5895
{
    [EventSubscriber(ObjectType::Codeunit, 5895, 'OnPostItemJnlLineCopyFromValueEntry', '', True, false)]
    local procedure OnPostItemJnlLineCopyFromValueEntry(var ItemJournalLine: Record "Item Journal Line"; ValueEntry: Record "Value Entry")
    begin
        //>> NF1.00:CIS.NG    07/21/16
        IF ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::Transfer THEN
            ItemJournalLine."Adjustment Batch Entry" := TRUE;
        //<< NF1.00:CIS.NG    07/21/16

    end;



}
