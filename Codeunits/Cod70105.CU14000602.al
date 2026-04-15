namespace Nifast.Nifast;

codeunit 70105 CU_14000602
{
    LOCAL PROCEDURE GetInputValues(InputDesc: Text[250]; InputPrompt: Text[250]; VAR ReceiveControl: Record 14000611) QuantityEntered: Decimal;
    VAR
        Window: Dialog;
        ReceiveForm: Page 50015;
        NewMfgLotNo: Code[30];
        NewQuantityEntered: Decimal;
    BEGIN
        COMMIT;
        CLEAR(ReceiveForm);
        ReceiveForm.SetCaption(InputPrompt, InputDesc);
        ReceiveForm.LOOKUPMODE(TRUE);
        IF ReceiveForm.RUNMODAL = ACTION::LookupOK THEN BEGIN
            ReceiveForm.ReturnValues(NewMfgLotNo, NewQuantityEntered);
            // ReceiveControl."Mfg. Lot No." := NewMfgLotNo;//ESG
            EXIT(NewQuantityEntered);
        END;
    END;

    LOCAL PROCEDURE PrintPurchRcptPackingList(PurchHeader: Record 38);
    VAR
        PurchRcptHdr: Record 120;
        REceiveSetup: Record 14000607;
    BEGIN
        //find last purchase receipt header done
        PurchRcptHdr.SETCURRENTKEY("Order No.");
        PurchRcptHdr.SETRANGE("Order No.", PurchHeader."No.");
        IF NOT PurchRcptHdr.FIND('+') THEN
            EXIT;


        //get receive setup record, exit if no order
        REceiveSetup.GET;
        IF (REceiveSetup."Close Receive Report ID" = 0) THEN
            EXIT;

        //run report
        PurchRcptHdr.SETRANGE("No.", PurchRcptHdr."No.");
        REPORT.RUNMODAL(REceiveSetup."Close Receive Report ID", FALSE, TRUE, PurchRcptHdr);
    END;

}
