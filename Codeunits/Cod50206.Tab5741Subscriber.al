codeunit 50206 Tab5741Subscriber
{
    [EventSubscriber(ObjectType::Table, Database::"Transfer Line", OnValidateQuantityOnAfterCalcQuantityBase, '', false, false)]

    local procedure OnValidateQuantityOnAfterCalcQuantityBase(var TransferLine: Record "Transfer Line"; xTransferLine: Record "Transfer Line")
    begin
        //>> RTT 08-29-05 #10069
        IF TransferLine."Units per Parcel" <> 0 THEN
            TransferLine."Total Parcels" := TransferLine."Quantity (Base)" / TransferLine."Units per Parcel";
        //<< RTT 08-29-05 #10069
    end;

    [EventSubscriber(ObjectType::Table, Database::"Transfer Line", OnAfterFilterLinesWithItemToPlan, '', false, false)]
    local procedure OnAfterFilterLinesWithItemToPlan(var Item: Record Item; IsReceipt: Boolean; IsSupplyForPlanning: Boolean; var TransferLine: Record "Transfer Line")
    begin
        TransferLine.SETFILTER("Outstanding Qty. (Base)", '<>0');
    end;
}