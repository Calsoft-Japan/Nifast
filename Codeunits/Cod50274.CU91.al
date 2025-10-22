codeunit 50274 CU_91
{
    SingleInstance = true;
    [EventSubscriber(ObjectType::Codeunit, 91, 'OnBeforeConfirmPost', '', True, false)]

    local procedure OnBeforeConfirmPost(var PurchaseHeader: Record "Purchase Header"; var HideDialog: Boolean; var IsHandled: Boolean; var DefaultOption: Integer)
    begin
        //>> NIF 06-11-05
        IF (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order) AND (ReceiveOnly) THEN BEGIN
            IF NOT CONFIRM(Text50000, FALSE, PurchaseHeader."Document Type") THEN BEGIN
                PurchaseHeader."Receiving No." := '-1';
                IsHandled := true;
            END;
            PurchaseHeader.Receive := TRUE;
            PurchaseHeader.Invoice := FALSE;
            PurchPost.RUN(PurchaseHeader);
            IsHandled := true;
        END;
        //<< NIF 06-11-05

    end;

    PROCEDURE SetReceiveOnly();
    BEGIN
        ReceiveOnly := TRUE;
    END;

    var
        // ">>NF_GV"@1102622001 : Integer;
        ReceiveOnly: Boolean;
        //  ">>NF_TC"@1102622003 : TextConst;
        Text50000: Label 'Do you want to receive the %1?';
        PurchPost: Codeunit 90;


}
