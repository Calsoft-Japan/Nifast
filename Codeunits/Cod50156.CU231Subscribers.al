codeunit 50156 CU231Subscribers
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post", OnBeforeCode, '', false, false)]
    local procedure "Gen. Jnl.-Post_OnBeforeCode"(var GenJournalLine: Record "Gen. Journal Line"; var HideDialog: Boolean)
    var
        Err_PymtMethod: Label 'Payment must be set payment method';
        Err_RefundMethod: Label 'Refund must be set a payment method';
        Err_Banks: Label 'Must be set bank source and target';
        Err_BankSAT: Label 'Set up Bank Accound Code to source and target';
        Err_BanlSAT2: Label 'Set up SAT Bank Code  to source and target';
    begin
        //>> CE 1.2  ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund
        if (GenJournalLine."Document Type" = GenJournalLine."Document Type"::Payment) and (STRLEN(GenJournalLine."Payment Method Code") = 0) then ERROR(Err_PymtMethod);
        if (GenJournalLine."Document Type" = GenJournalLine."Document Type"::Refund) and (STRLEN(GenJournalLine."Payment Method Code") = 0) then ERROR(Err_RefundMethod);

        if (GenJournalLine."Document Type" = GenJournalLine."Document Type"::Payment) or (GenJournalLine."Document Type" = GenJournalLine."Document Type"::Refund) then
            if (GenJournalLine."Pymt - Payment Method" = '02') or (GenJournalLine."Pymt - Payment Method" = '03') then begin
                if (GenJournalLine."Account No." = '') or (GenJournalLine."Bal. Account No." = '') or (GenJournalLine."Recipient Bank Account" = '') then ERROR(Err_Banks);
                if (GenJournalLine."Pymt - Bank Source Code" = '') or (GenJournalLine."Pymt - Bank Target Code" = '') then ERROR(Err_BankSAT);
                if (GenJournalLine."Pymt - Bank Source Account" = '') or (GenJournalLine."Pymt - Bank Target Account" = '') then ERROR(Err_BanlSAT2);
            end;
        //<< CE 1.2
    end;

}
