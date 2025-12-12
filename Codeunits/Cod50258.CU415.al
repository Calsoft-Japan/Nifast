codeunit 50258 "CU 415"
{

    [EventSubscriber(ObjectType::Codeunit, 415, 'OnCodeOnAfterCheckPurchaseReleaseRestrictions', '', True, false)]
    local procedure OnCodeOnAfterCheckPurchaseReleaseRestrictions(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        NVM: Codeunit 50021;
        SoftBlockError: Text[80];
        WCText001: Label 'You must Shipment Method Code for Order %1.', Comment = '%1 = Order No';

    begin
        //>>NV
        IF NVM.CheckSoftBlock(1, PurchaseHeader."Buy-from Vendor No.", PurchaseHeader."Order Address Code", '', PurchaseHeader."Document Type", SoftBlockError) THEN
            ERROR(SoftBlockError);
        IF NVM.CheckSoftBlock(1, PurchaseHeader."Pay-to Vendor No.", '', '', PurchaseHeader."Document Type", SoftBlockError) THEN
            ERROR(SoftBlockError);
        //<<NV

        //WC1.01.Begin
        IF (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order) THEN
            IF (PurchaseHeader."Shipment Method Code" = '') THEN
                ERROR(WCText001, PurchaseHeader."No.");
        //WC1.01.End

        CheckForMissingUOM(PurchaseHeader); //NFS1.01

    end;

    [EventSubscriber(ObjectType::Codeunit, 415, 'OnReopenOnBeforePurchaseHeaderModify', '', True, false)]
    local procedure OnReopenOnBeforePurchaseHeaderModify(var PurchaseHeader: Record "Purchase Header")
    begin
        // >> NV
        PurchaseHeader.VALIDATE(Status);       //to update Status field on lines
                                               // << NV

    end;



    PROCEDURE CheckForMissingUOM(PurchaseHeader: Record 38);
    VAR
        PurchaseLineRecLcl: Record 39;
    BEGIN
        //WITH PurchaseHeader DO BEGIN
        PurchaseLineRecLcl.RESET();
        PurchaseLineRecLcl.SETRANGE("Document Type", PurchaseHeader."Document Type");
        PurchaseLineRecLcl.SETRANGE("Document No.", PurchaseHeader."No.");
        PurchaseLineRecLcl.SETRANGE(Type, PurchaseLineRecLcl.Type::Item);
        PurchaseLineRecLcl.SETFILTER("No.", '<>%1', '');
        IF PurchaseLineRecLcl.FINDSET() THEN
            REPEAT
                PurchaseLineRecLcl.TESTFIELD("Unit of Measure Code");
            UNTIL PurchaseLineRecLcl.NEXT() = 0;
        //  END;
    END;



}
