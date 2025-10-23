codeunit 50036 CU11Subscriber
{
    //Version NAVW18.00,NAVNA8.00,NIF1.025;

    var
        CVNo: Code[20];

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Check Line", OnBeforeCheckPurchDocNoIsNotUsed, '', false, false)]
    local procedure OnBeforeCheckPurchDocNoIsNotUsed(DocType: Option; DocNo: Code[20]; var IsHandled: Boolean; GenJournalLine: Record "Gen. Journal Line")
    var
        OldVendLedgEntry: Record "Vendor Ledger Entry";
        PurchDocAlreadyExistsErr: Label 'Purchase %1 %2 already exists.', Comment = '%1 = Document Type; %2 = Document No.';
    begin
        IsHandled := true;

        OldVendLedgEntry.SetRange("Document No.", GenJournalLine."Document No.");
        OldVendLedgEntry.SetRange("Document Type", GenJournalLine."Document Type");
        //Moved the following code from VendPosting
        //>> NIF 03-03-05 NIF
        //add this code for data conversion
        OldVendLedgEntry.SETRANGE("Vendor No.", CVNo);
        //<< NIF 03-03-05 NIF
        if not OldVendLedgEntry.IsEmpty() then
            Error(
                ErrorInfo.Create(
                    StrSubstNo(PurchDocAlreadyExistsErr, GenJournalLine."Document Type", GenJournalLine."Document No."),
                    true,
                    GenJournalLine));
    end;

    PROCEDURE SetCVNo(Input: Code[20]);
    BEGIN
        //>>Added during merge
        CVNo := '';
        CVNo := Input;
        //<<Added during Merge
    END;

}