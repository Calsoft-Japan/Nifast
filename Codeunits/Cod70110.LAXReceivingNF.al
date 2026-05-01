codeunit 70110 "LAXReceiving_NF"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LAX Receiving", pubOnBeforeInsertItemTrackingLinePurchHdr, '', false, false)]
    local procedure "LAX Receiving_pubOnBeforeInsertItemTrackingLinePurchHdr"(var ReceiveLine: Record "LAX Receive Line"; var TrackingSpecificationTmp: Record "Tracking Specification" temporary; var PurchLineTmp: Record "Purchase Line" temporary; UsageCase: Integer; var Handled: Boolean)
    begin

        //>> NIF #9851 RTT 03-22-05
        TrackingSpecificationTmp.VALIDATE("Mfg. Lot No.", ReceiveLine."Mfg. Lot No.");
        //<< NIF #9851 RTT 03-22-05
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LAX Receiving", pubOnBeforeClosePurchHeader, '', false, false)]
    local procedure "LAX Receiving_pubOnBeforeClosePurchHeader"(var PurchHeader: Record "Purchase Header"; var PrintLabel: Boolean; var Handled: Boolean)
    begin
        //>> NIF #9851 RTT 03-22-05
        PrintLabel := FALSE;
        //<< NIF #9851 RTT 03-22-05
    end;

}
