codeunit 50277 "Event Subscribers"
{
    trigger OnRun()
    begin
    end;

    [EventSubscriber(ObjectType::Report, Report::"Suggest Vendor Payments", OnAfterSaveAmount, '', false, false)]
    local procedure OnAfterSaveAmount(var GenJournalLine: Record "Gen. Journal Line"; var TempPayableVendorLedgerEntry: Record "Payable Vendor Ledger Entry" temporary; VendorLedgerEntry: Record "Vendor Ledger Entry")
    begin
        TempPayableVendorLedgerEntry."USD Value" := GenJournalLine."USD Value"; //FOREX
    end;

    [EventSubscriber(ObjectType::Report, Report::"Suggest Vendor Payments", OnUpdateVendorPaymentBufferFromVendorLedgerEntry, '', false, false)]
    local procedure OnUpdateVendorPaymentBufferFromVendorLedgerEntry(var TempVendorPaymentBuffer: Record "Vendor Payment Buffer" temporary; VendorLedgerEntry: Record "Vendor Ledger Entry")
    var
        Vendor: Record Vendor;
    begin
        //FOREX
        IF Vendor."3 Way Currency Adjmt." THEN
            TempVendorPaymentBuffer."Currency Code" := 'USD'
        ELSE
            //<<FOREX
            TempVendorPaymentBuffer."Currency Code" := VendorLedgerEntry."Currency Code";
        //>>IST 052305 DPC #9806
        //TODO
        //TempVendorPaymentBuffer."Contract Note No." := VendorLedgerEntry."Contract Note No.";
        //TempVendorPaymentBuffer."Exchange Contract No." := VendorLedgerEntry."Exchange Contract No.";
        //TODO
        //<<IST 052305 DPC #9806
    end;

    [EventSubscriber(ObjectType::Report, Report::"Suggest Vendor Payments", OnMakeGenJnlLinesOnBeforeVendorPaymentBufferModify, '', false, false)]
    local procedure OnMakeGenJnlLinesOnBeforeVendorPaymentBufferModify(var TempVendorPaymentBuffer: Record "Vendor Payment Buffer" temporary; VendorLederEntry: Record "Vendor Ledger Entry"; var TempPayableVendorLedgerEntry: Record "Payable Vendor Ledger Entry" temporary)
    begin
        //>>FOREX
        //TempPaymentBuffer."USD Value" := TempPaymentBuffer.Amount + PayableVendLedgEntry."USD Value";
        //TODO
        // TempVendorPaymentBuffer."USD Value" := TempVendorPaymentBuffer."USD Value" + GetUSDValue(TempPayableVendorLedgerEntry.Amount, TempPayableVendorLedgerEntry."Currency Code",
        //    VendorLederEntry."Document No.");
        //<<FOREX
    end;

    [EventSubscriber(ObjectType::Report, Report::"Suggest Vendor Payments", OnMakeGenJnlLinesOnBeforeVendorPaymentBufferInsert, '', false, false)]
    local procedure OnMakeGenJnlLinesOnBeforeVendorPaymentBufferInsert(var TempVendorPaymentBuffer: Record "Vendor Payment Buffer" temporary; VendorLederEntry: Record "Vendor Ledger Entry"; TempPayableVendorLedgerEntry: Record "Payable Vendor Ledger Entry" temporary)
    begin
        //>>FOREX
        //TempPaymentBuffer."USD Value" := PayableVendLedgEntry."USD Value";
        //TODO
        //TempVendorPaymentBuffer."USD Value" := GetUSDValue(TempPayableVendorLedgerEntry.Amount, TempPayableVendorLedgerEntry."Currency Code", VendorLederEntry."Document No.");
        //<<FOREX
    end;

    [EventSubscriber(ObjectType::Report, Report::"Suggest Vendor Payments", OnMakeGenJnlLinesOnBeforeVendorPaymentBufferInsertNonSummarize, '', false, false)]
    local procedure OnMakeGenJnlLinesOnBeforeVendorPaymentBufferInsertNonSummarize(var TempVendorPaymentBuffer: Record "Vendor Payment Buffer" temporary; VendorLederEntry: Record "Vendor Ledger Entry"; var SummarizePerVend: Boolean; var NextDocNo: Code[20]; var TempPayableVendorLedgerEntry: Record "Payable Vendor Ledger Entry" temporary)
    begin
        //>>FOREX
        //TempPaymentBuffer."USD Value" := VendLedgEntry."USD Value";
        //TODO
        //TempVendorPaymentBuffer."USD Value" := GetUSDValue(TempPayableVendorLedgerEntry.Amount, TempPayableVendorLedgerEntry."Currency Code", VendorLederEntry."Document No.");
        //<<FOREX
    end;

    var
        myInt: Integer;
}