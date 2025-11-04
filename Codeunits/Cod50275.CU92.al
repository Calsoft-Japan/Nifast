codeunit 50275 CU_92
{
    SingleInstance = true;

    [EventSubscriber(ObjectType::Codeunit, 92, 'OnBeforeConfirmPost', '', True, false)]
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
            PurchRcptHeader."No." := PurchaseHeader."Last Receiving No.";
            PurchRcptHeader.SETRECFILTER;
            // PurchaseHeader.PrintRecords();
            PurchRcptHeader.PrintRecords(false);
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
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        //  ">>NF_TC"@1102622003 : TextConst;
        Text50000: Label 'Do you want to receive and print the %1?';
        PurchPost: Codeunit 90;


}
