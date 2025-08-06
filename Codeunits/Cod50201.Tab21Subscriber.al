codeunit 50201 Tab21Subscriber
{
    [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", 'OnAfterCopyCustLedgerEntryFromGenJnlLine', '', false, false)]
    local procedure OnAfterCopyCustLedgerEntryFromGenJnlLine(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        //>> NF1.00:CIS.NG    10/06/16
        //>> NIF 10-04-05 RTT #10381
        CustLedgerEntry."EDI Control No." := GenJournalLine."EDI Control No.";
        //<< NIF 10-04-05 RTT #10381
        //<< NF1.00:CIS.NG    10/06/16
    end;
}