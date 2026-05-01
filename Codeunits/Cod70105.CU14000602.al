codeunit 70105 CU_14000602
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LAX Receive Management", pubOnBeforeReceiveLineInsert, '', false, false)]
    local procedure "LAX Receive Management_pubOnBeforeReceiveLineInsert"(var ReceiveLine: Record "LAX Receive Line"; var ReceiveControl: Record "LAX Receive Control"; var ReceiveInput: Record "LAX Receive Input")
    begin

        //>> NIF #9851
        ReceiveLine."Mfg. Lot No." := ReceiveControl."Mfg. Lot No.";
        //<< NIF #9851
        //>> NIF #9865
        ReceiveLine."Country of Origin Code" := ReceiveControl."Country of Origin Code";
        ReceiveLine."QC Hold" := ReceiveControl."QC Hold";
        ReceiveLine."QC Print Code" := ReceiveControl."QC Print Code";
        ReceiveLine."Next Ship Date" := ReceiveControl."Next Ship Date";
        //<< NIF #9865
    end;

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
