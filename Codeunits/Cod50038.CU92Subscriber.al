// codeunit 50038 CU92Subscriber
// {
//     var
//         PurchRcptHeader: Record 120;
//         PurchPost: Codeunit 90;
//         PurchPostPrint: Codeunit 92;
//         // ">>NF_GV": Integer;
//         ReceiveOnly: Boolean;
//         //">>NF_TC": TextConst;
//         Text50000: Label 'Do you want to receive and print the %1?', Comment = '%1=Field Value';


//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post + Print", OnBeforeConfirmPostProcedure, '', false, false)]
//     local procedure OnBeforeConfirmPostProcedure(var PurchHeader: Record "Purchase Header"; var DefaultOption: Integer; var Result: Boolean; var IsHandled: Boolean)
//     begin
//         //>> NIF 06-11-05
//         IF (PurchHeader."Document Type" = PurchHeader."Document Type"::Order) AND (ReceiveOnly) THEN BEGIN
//             IF NOT CONFIRM(Text50000, FALSE, PurchHeader."Document Type") THEN BEGIN
//                 PurchHeader."Receiving No." := '-1';
//                 EXIT;
//             END;
//             PurchHeader.Receive := TRUE;
//             PurchHeader.Invoice := FALSE;
//             PurchPost.RUN(PurchHeader);
//             PurchRcptHeader."No." := PurchHeader."Last Receiving No.";
//             PurchRcptHeader.SETRECFILTER();
//             //PrintReport(ReportSelection.Usage::"P.Receipt");
//             PurchPostPrint.PrintReceive(PurchHeader);
//             EXIT;
//         END;
//         //<< NIF 06-11-05
//     end;

//     PROCEDURE ">>NIF_GV"();
//     BEGIN
//     END;

//     PROCEDURE SetReceiveOnly();
//     BEGIN
//         ReceiveOnly := TRUE;
//     END;
// }