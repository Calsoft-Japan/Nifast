codeunit 50040 Table09
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Table, 25, 'OnAfterCopyVendLedgerEntryFromGenJnlLine', '', True, false)]
    local procedure OnAfterCopyVendLedgerEntryFromGenJnlLine(var VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        //>> NF1.00:CIS.NG    10/05/16
        //>> IST 052305 DPC #9806
        VendorLedgerEntry."Contract Note No." := GenJournalLine."Contract Note No.";
        VendorLedgerEntry."Exchange Contract No." := GenJournalLine."Exchange Contract No.";
        //<< IST 052305 DPC #9806
        //<< NF1.00:CIS.NG    10/05/16
    end;


}
