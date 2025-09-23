codeunit 50173 CU_12
{
    [EventSubscriber(ObjectType::Codeunit, 12, 'OnPostGLAccOnBeforeInsertGLEntry', '', True, false)]

    local procedure OnPostGLAccOnBeforeInsertGLEntry(var GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry"; var IsHandled: Boolean; Balancing: Boolean)
    begin
        //>> FOREX
        GLEntry."USD Value" := GenJournalLine."USD Value";
        //<< FOREX

        //>>IST 053105 DPC #9806
        GLEntry."Contract Note No." := GenJournalLine."Contract Note No.";
        GLEntry."Exchange Contract No." := GenJournalLine."Exchange Contract No.";
        GLEntry."4X Currency Rate" := GenJournalLine."Currency Factor";
        GLEntry."4X Amount JPY" := ABS(GenJournalLine.Amount);
        //<<IST 053105 DPC #9806

        //>>CIS.RAM 04/28/18
        GenJournalLine."Original Entry No." := GLEntry."Original Entry No.";
        GenJournalLine."Original Transaction No." := GLEntry."Original Transaction No.";
        //<<CIS.RAM 04/28/18
    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforeInitCustLedgEntry', '', True, false)]

    local procedure OnBeforeInitCustLedgEntry(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        //>> CE 1.2
        ToolEA.TransferGenJnlLineToCustLedgEntry(GenJournalLine, CustLedgerEntry);
        //<< CE 1.2
        //>> NIF 10-04-05 RTT #10381
        CustLedgerEntry."EDI Control No." := GenJournalLine."EDI Control No.";
        //<< NIF 10-04-05 RTT #10381
    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnPostVendOnAfterInitVendLedgEntry', '', True, false)]
    local procedure OnPostVendOnAfterInitVendLedgEntry(var GenJnlLine: Record "Gen. Journal Line"; var VendLedgEntry: Record "Vendor Ledger Entry"; Vendor: Record Vendor)
    begin
        //>> CE 1.2
        ToolEA.TransferGenJnlLineToVendLedgEntry(GenJnlLine, VendLedgEntry);
        //<< CE 1.2
    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforeCheckPurchExtDocNo', '', True, false)]
    local procedure OnBeforeCheckPurchExtDocNo(GenJournalLine: Record "Gen. Journal Line"; VendorLedgerEntry: Record "Vendor Ledger Entry"; CVLedgerEntryBuffer: Record "CV Ledger Entry Buffer"; var Handled: Boolean)
    begin
        GenJournalLine.SetCVNo(CVLedgerEntryBuffer."CV No.");  //Added during merge
    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforeVendLedgEntryInsert', '', True, false)]
    local procedure OnBeforeVendLedgEntryInsert(var VendorLedgerEntry: Record "Vendor Ledger Entry"; var GenJournalLine: Record "Gen. Journal Line"; GLRegister: Record "G/L Register")
    begin
        VendorLedgerEntry."USD Value" := GenJournalLine."USD Value"; //FOREX
    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforeInitGLEntry', '', True, false)]
    local procedure OnBeforeInitGLEntry(var GenJournalLine: Record "Gen. Journal Line"; var GLAccNo: Code[20]; SystemCreatedEntry: Boolean; Amount: Decimal; AmountAddCurr: Decimal; FADimAlreadyChecked: Boolean; var IsHandled: Boolean; var GLEntry: Record "G/L Entry"; UseAmountAddCurr: Boolean; NextEntryNo: Integer; NextTransactionNo: Integer)
    begin
        //jrr for debug temporary
        IF GLAccNo = '133' THEN
            MESSAGE(GenJournalLine.Description);

    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnAfterInitGLEntry', '', True, false)]
    local procedure OnAfterInitGLEntry(var GLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line"; Amount: Decimal; AddCurrAmount: Decimal; UseAddCurrAmount: Boolean; var CurrencyFactor: Decimal; var GLRegister: Record "G/L Register")
    begin
        //>> CE 1.2
        ToolEA.TransferGenJnlLineToGLEntry(GenJournalLine, GLEntry);
        //<< CE 1.2
    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnInsertGLEntryOnBeforeAssignTempGLEntryBuf', '', True, false)]
    local procedure OnInsertGLEntryOnBeforeAssignTempGLEntryBuf(var GLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line"; GLRegister: Record "G/L Register")
    begin
        //Temp
        IF STRPOS(GenJournalLine.Description, 'RESTATE') > 0 THEN BEGIN
            MESSAGE('');
            MESSAGE('');
            MESSAGE('');
            MESSAGE('');
        END;
        //Temp

    end;

    var

        ToolEA: Codeunit 50020;


}
