codeunit 50268 CU_5773
{
    [EventSubscriber(ObjectType::Codeunit, 5773, 'OnAfterCreateInboundWhseRequest', '', True, false)]

    local procedure OnAfterCreateInboundWhseRequest(var WarehouseRequest: Record "Warehouse Request"; var TransferHeader: Record "Transfer Header")
    begin
        //>>NV
        WarehouseRequest."Destination No." := TransferHeader."Transfer-from Code";
        //>> NF1.00:CIS.CM 10-24-15
        //CALCFIELDS("Outstanding Gross Weight","Outstanding Net Weight");
        //WhseRqst."Outstanding Gross Weight" := "Outstanding Gross Weight";
        //WhseRqst."Outstanding Net Weight" := "Outstanding Net Weight";
        //<< NF1.00:CIS.CM 10-24-15
        WarehouseRequest."Destination Name" := TransferHeader."Transfer-from Name";
        WarehouseRequest."Container No." := TransferHeader."Container No.";
        //<<NV
    end;

    [EventSubscriber(ObjectType::Codeunit, 5773, 'OnAfterCreateOutboundWhseRequest', '', True, false)]
    local procedure OnAfterCreateOutboundWhseRequest(var WarehouseRequest: Record "Warehouse Request"; var TransferHeader: Record "Transfer Header")
    begin
        //>>NV
        WarehouseRequest."Destination No." := TransferHeader."Transfer-to Code";
        //>> NF1.00:CIS.CM 10-24-15
        //CALCFIELDS("Outstanding Gross Weight","Outstanding Net Weight");
        //WhseRqst."Outstanding Gross Weight" := "Outstanding Gross Weight";
        //WhseRqst."Outstanding Net Weight" := "Outstanding Net Weight";
        //<< NF1.00:CIS.CM 10-24-15
        WarehouseRequest."Destination Name" := TransferHeader."Transfer-to Name";
        WarehouseRequest."Container No." := TransferHeader."Container No.";
        //<<NV
    end;




}
