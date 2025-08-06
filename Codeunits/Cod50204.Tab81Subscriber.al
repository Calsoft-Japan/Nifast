codeunit 50204 Tab81Subscriber
{
    Var
        NVM: Codeunit 50021;
        SoftBlockError: Text[80];


    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", OnValidateAccountNoOnBeforeAssignValue, '', false, false)]
    local procedure OnValidateAccountNoOnBeforeAssignValue(var GenJournalLine: Record "Gen. Journal Line"; var xGenJournalLine: Record "Gen. Journal Line")
    begin
        case GenJournalLine."Account Type" of
            GenJournalLine."Account Type"::Customer:
                begin
                    //>>NV
                    IF GenJournalLine."Document Type" = GenJournalLine."Document Type"::Payment THEN
                        IF NVM.CheckSoftBlock(0, GenJournalLine."Account No.", '', '', 8, SoftBlockError) THEN
                            ERROR(SoftBlockError);
                    //<<NV
                end;
            GenJournalLine."Account Type"::Vendor:
                begin
                    //>>NV
                    IF GenJournalLine."Document Type" = GenJournalLine."Document Type"::Payment THEN
                        IF NVM.CheckSoftBlock(1, GenJournalLine."Account No.", '', '', 8, SoftBlockError) THEN
                            ERROR(SoftBlockError);
                    //<<NV
                end;
        End;
    end;

}