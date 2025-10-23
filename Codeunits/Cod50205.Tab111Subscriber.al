codeunit 50205 Tab111Subscriber
{
    [EventSubscriber(ObjectType::Table, database::"Sales Shipment Line", OnInsertInvLineFromShptLineOnBeforeSalesHeaderGet, '', false, false)]
    local procedure OnInsertInvLineFromShptLineOnBeforeSalesHeaderGet(var SalesHeader: Record "Sales Header"; SalesShipmentLine: Record "Sales Shipment Line"; var TempSalesLine: Record "Sales Line" temporary; var IsHandled: Boolean)
    begin
        IsHandled := true;

        IF (SalesShipmentLine.Type <> SalesShipmentLine.Type::" ") AND TempSalesLine.GET(TempSalesLine."Document Type"::Order, SalesShipmentLine."Order No.", SalesShipmentLine."Order Line No.")
      THEN
            IF (SalesHeader."Document Type" <> TempSalesLine."Document Type"::Order) OR
               (SalesHeader."No." <> TempSalesLine."Document No.")
            THEN
                SalesHeader.GET(TempSalesLine."Document Type"::Order, SalesShipmentLine."Order No.");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Shipment Line", OnInsertInvLineFromShptLineOnBeforeAssigneSalesLine, '', false, false)]
    local procedure OnInsertInvLineFromShptLineOnBeforeAssigneSalesLine(var SalesShipmentLine: Record "Sales Shipment Line"; SalesHeaderInv: Record "Sales Header"; SalesHeaderOrder: Record "Sales Header"; var SalesLine: Record "Sales Line"; var SalesOrderLine: Record "Sales Line"; Currency: Record Currency)
    begin
        SalesLine := SalesOrderLine;
        //>>NF1.00:CIS.NG    09/05/16
        //>>NIF 071307 RTT
        SalesLine."Tax Area Code" := SalesHeaderInv."Tax Area Code";
        SalesLine."Tax Liable" := SalesHeaderInv."Tax Liable";
        //<<NIF 071307 RTT
        //<<NF1.00:CIS.NG    09/05/16
    end;
}