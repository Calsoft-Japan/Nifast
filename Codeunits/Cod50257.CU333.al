codeunit 50257 CU333
{
    [EventSubscriber(ObjectType::Codeunit, 333, 'OnAfterInitPurchOrderLine', '', True, false)]
    local procedure OnAfterInitPurchOrderLine(var PurchaseLine: Record "Purchase Line"; RequisitionLine: Record "Requisition Line")
    begin
        //>>NV
        PurchaseLine."Prod. Kit Order No." := RequisitionLine."Prod. Kit Order No.";
        PurchaseLine."Prod. Kit Order Line No." := RequisitionLine."Prod. Kit Order Line No.";
        //<<NV

    end;

    [EventSubscriber(ObjectType::Codeunit, 333, 'OnInsertPurchOrderLineOnBeforeSalesOrderLineModify', '', True, false)]
    local procedure OnInsertPurchOrderLineOnBeforeSalesOrderLineModify(var SalesOrderLine: Record "Sales Line"; var RequisitionLine: Record "Requisition Line"; var PurchOrderLine: Record "Purchase Line")
    begin
        //>>NV
        SalesOrderLine."Vendor No." := PurchOrderLine."Buy-from Vendor No.";
        SalesOrderLine."Vendor Item No." := PurchOrderLine."Vendor Item No.";
        //<<NV
    end;


}
