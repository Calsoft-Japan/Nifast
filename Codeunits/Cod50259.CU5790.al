codeunit 50259 CU_5790
{
    [EventSubscriber(ObjectType::Codeunit, 5790, 'OnAfterCalcScheduledReceipt', '', True, false)]
    local procedure OnAfterCalcScheduledReceipt(var Item: Record Item; var ScheduledReceipt: Decimal)
    var
        INSetup: Record "Inventory Setup";
        QtyOnSalesReturn: Decimal;
    begin
        INSetup.RESET();
        IF NOT (INSetup.FindFirst()) THEN
            EXIT;

        IF INSetup."Incl ReservQty on Prod Order" THEN
            ScheduledReceipt := ScheduledReceipt - Item."Reserved Qty. on Prod. Order";
        IF INSetup."Incl PurchReq Receipt (Qty.)" THEN
            ScheduledReceipt := ScheduledReceipt + Item."Purch. Req. Receipt (Qty.)";
        IF INSetup."Incl Res. Qty on Req. Line" THEN
            ScheduledReceipt := ScheduledReceipt - Item."Res. Qty. on Req. Line";
        IF INSetup."Incl Qty. on Purch. Order" THEN
            ScheduledReceipt := ScheduledReceipt + Item."Qty. on Purch. Order";
        IF INSetup."Incl ReservQty on PurchOrders" THEN
            ScheduledReceipt := ScheduledReceipt - Item."Reserved Qty. on Purch. Orders";
        IF INSetup."Incl TransOrd Receipt (Qty.)" THEN
            ScheduledReceipt := ScheduledReceipt + Item."Trans. Ord. Receipt (Qty.)";
        IF INSetup."Incl Res.Qty Inbound Transfer" THEN
            ScheduledReceipt := ScheduledReceipt - Item."Reserved Qty. on Purch. Orders";
        IF INSetup."Incl Qty. in Transit" THEN
            ScheduledReceipt := ScheduledReceipt + Item."Qty. in Transit";
        IF INSetup."Incl Qty on Sales Return" THEN
            ScheduledReceipt := ScheduledReceipt + QtyOnSalesReturn;


    end;

}
