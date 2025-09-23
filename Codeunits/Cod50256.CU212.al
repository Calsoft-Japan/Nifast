codeunit 50256 CU212
{
    [EventSubscriber(ObjectType::Codeunit, 212, 'OnBeforeResLedgEntryInsert', '', True, false)]
    local procedure OnBeforeResLedgEntryInsert(var ResLedgerEntry: Record "Res. Ledger Entry"; ResJournalLine: Record "Res. Journal Line")
    begin
        // //>>NV
        // ResLedgerEntry."Vendor No." := ResJournalLine."Vendor No.";
        // ResLedgerEntry."Vendor Item No." := ResJournalLine."Vendor Item No.";
        // ResLedgerEntry."Sell-to Customer No." := ResJournalLine."Sell-to Customer No.";
        // ResLedgerEntry."Salesperson Code" := ResJournalLine."Salesperson Code";
        // ResLedgerEntry."Purchasing Code" := ResJournalLine."Purchasing Code";
        // ResLedgerEntry."Special Order Sales No." := ResJournalLine."Special Order Sales No.";
        // ResLedgerEntry."Special Order Sales Line No." := ResJournalLine."Special Order Sales Line No.";
        // ResLedgerEntry."Prod. Kit Order No." := ResJournalLine."Prod. Kit Order No.";
        // ResLedgerEntry."Prod. Kit Order Line No." := ResJournalLine."Prod. Kit Order Line No.";
        // //<<NV //TODO
    end;

    [EventSubscriber(ObjectType::Codeunit, 212, 'OnAfterResLedgEntryInsert', '', True, false)]
    local procedure OnAfterResLedgEntryInsert(var ResLedgerEntry: Record "Res. Ledger Entry"; ResJournalLine: Record "Res. Journal Line")
    var
        Res: Record 156;
    begin
        Res.GET(ResLedgerEntry."Resource No.");
        //>>NV
        IF Res."Reallocate Cost" THEN
            PostReallocationToGL(ResLedgerEntry, ResJournalLine);
        //<<NV

    end;

    LOCAL PROCEDURE PostReallocationToGL(VAR RLE: Record 203; ResJournalLine: record "Res. Journal Line");
    VAR
        GenJnlLine: Record 81;
        GenPostingSetup2: Record 252;
        GenPostingSetup: Record "General Posting Setup";
        //GLSetup: Record 98;
        GenJnlPostLine: Codeunit 12;
    BEGIN
        //>>NV
        // WITH RLE DO BEGIN
        GenPostingSetup.get(ResJournalLine."Gen. Bus. Posting Group", ResJournalLine."Gen. Prod. Posting Group");
        GenJnlLine.INIT();
        GenJnlLine."Posting Date" := ResJournalLine."Posting Date";
        GenJnlLine."Document Date" := ResJournalLine."Document Date";
        GenJnlLine."Document No." := ResJournalLine."Document No.";
        GenJnlLine."External Document No." := ResJournalLine."External Document No.";
        GenJnlLine."Source Code" := ResJournalLine."Source Code";
        GenJnlLine."System-Created Entry" := TRUE;
        IF (GenPostingSetup."Gen. Bus. Posting Group" = RLE."Gen. Bus. Posting Group") AND
           (GenPostingSetup."Gen. Prod. Posting Group" = RLE."Gen. Prod. Posting Group")
        THEN
            GenPostingSetup2 := GenPostingSetup
        ELSE
            GenPostingSetup2.GET(
              RLE."Gen. Bus. Posting Group", RLE."Gen. Prod. Posting Group");
        GenPostingSetup2.TESTFIELD("Inventory Adjmt. Account");
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
        GenJnlLine."Account No." := GenPostingSetup2."Inventory Adjmt. Account";
        GenJnlLine.Description := ResJournalLine.Description;
        GenJnlLine."Shortcut Dimension 1 Code" := RLE."Global Dimension 1 Code";
        GenJnlLine."Shortcut Dimension 2 Code" := RLE."Global Dimension 2 Code";
        GenJnlLine.VALIDATE(Amount, RLE."Total Cost");
        GenPostingSetup2.TESTFIELD("Resource Allocation");
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine.VALIDATE("Bal. Account No.", GenPostingSetup2."Resource Allocation");
        GenJnlPostLine.RUN(GenJnlLine);
        //END;
        //<<NV
    END;




}
