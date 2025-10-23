codeunit 50155 CU13Subscribers
{
    var
        ToolEA: Codeunit 50020;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Batch", OnBeforePostGenJnlLine, '', false, false)]
    local procedure "Gen. Jnl.-Post Batch_OnBeforePostGenJnlLine"(var Sender: Codeunit "Gen. Jnl.-Post Batch"; var GenJournalLine: Record "Gen. Journal Line"; CommitIsSuppressed: Boolean; var Posted: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; var PostingGenJournalLine: Record "Gen. Journal Line")
    begin
        //>> CE 1.2
        ToolEA.TransGenJnlLineToGenJnlLine(PostingGenJournalLine, GenJournalLine);
        //<< CE 1.2
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Batch", OnPostReversingLinesOnBeforeGenJnlPostLine, '', false, false)]
    local procedure "Gen. Jnl.-Post Batch_OnPostReversingLinesOnBeforeGenJnlPostLine"(var GenJournalLine: Record "Gen. Journal Line"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; var IsHandled: Boolean)
    begin
        //>> CE 1.2
        ToolEA.TransGenJnlLineToGenJnlLine(GenJournalLine, GenJournalLine);
        //<< CE 1.2
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Batch", OnPostAllocationsOnBeforePostNotReversingLine, '', false, false)]
    local procedure "Gen. Jnl.-Post Batch_OnPostAllocationsOnBeforePostNotReversingLine"(var GenJournalLine: Record "Gen. Journal Line"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; AllocateGenJournalLine: Record "Gen. Journal Line"; var GenJnlAllocation: Record "Gen. Jnl. Allocation")
    begin
        //>> CE 1.2
        ToolEA.TransGenJnlLineToGenJnlLine(AllocateGenJournalLine, GenJournalLine);
        //<< CE 1.2
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Batch", OnPostAllocationsOnBeforePostReversingLine, '', false, false)]
    local procedure "Gen. Jnl.-Post Batch_OnPostAllocationsOnBeforePostReversingLine"(var GenJournalLine: Record "Gen. Journal Line"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; AllocateGenJournalLine: Record "Gen. Journal Line"; var GenJnlAllocation: Record "Gen. Jnl. Allocation")
    begin
        //>> CE 1.2
        ToolEA.TransGenJnlLineToGenJnlLine(AllocateGenJournalLine, GenJournalLine);
        //<< CE 1.2
    end;


}
