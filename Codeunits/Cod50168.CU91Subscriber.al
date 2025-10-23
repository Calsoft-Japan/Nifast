codeunit 50168 CU91Subscriber
{
    var
        PurchPost: Codeunit 90;
        // ">>NF_GV": Integer;
        ReceiveOnly: Boolean;
        // ">>NF_TC": TextConst;
        Text50000: Label 'Do you want to receive the %1?', Comment = '%1=PurchaseHeader."Document Type"';


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", OnBeforeConfirmPostProcedure, '', false, false)]
    local procedure OnBeforeConfirmPostProcedure(var PurchaseHeader: Record "Purchase Header"; var DefaultOption: Integer; var Result: Boolean; var IsHandled: Boolean)
    begin
        //>> NIF 06-11-05
        if (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order) AND (ReceiveOnly) then begin
            if NOT CONFIRM(Text50000, FALSE, PurchaseHeader."Document Type") then begin
                PurchaseHeader."Receiving No." := '-1';
                EXIT;
            END;
            PurchaseHeader.Receive := TRUE;
            PurchaseHeader.Invoice := FALSE;
            PurchPost.RUN(PurchaseHeader);
            EXIT;
        END;
        //<< NIF 06-11-05
    end;

    PROCEDURE ">>NIF_GV"();
    BEGIN
    END;

    PROCEDURE SetReceiveOnly();
    BEGIN
        ReceiveOnly := TRUE;
    END;
}