codeunit 50071 CU5772Subscriber
{
    //Version NAVW17.00,NV4.20,NIF.N15.C9IN.001;
    var
        NVM: Codeunit 50021;
        SoftBlockError: Text[80];

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Purch. Release", OnBeforeRelease, '', false, false)]
    local procedure OnBeforeRelease(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    begin
        //>>NV
        IF NVM.CheckSoftBlock(1, PurchaseHeader."Buy-from Vendor No.", PurchaseHeader."Order Address Code", '', 7, SoftBlockError) THEN
            ERROR(SoftBlockError);
        IF NVM.CheckSoftBlock(1, PurchaseHeader."Pay-to Vendor No.", '', '', 7, SoftBlockError) THEN
            ERROR(SoftBlockError);
        //<<NV
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Purch. Release", OnAfterFilterWarehouseRequest, '', false, false)]
    local procedure OnAfterFilterWarehouseRequest(var WarehouseRequest: Record "Warehouse Request"; PurchaseHeader: Record "Purchase Header"; DocumentStatus: Option)
    begin
        WarehouseRequest.DELETEALL(TRUE);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Purch. Release", OnBeforeCreateWhseRequest, '', false, false)]
    local procedure OnBeforeCreateWhseRequest(var WhseRqst: Record "Warehouse Request"; var PurchHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line"; WhseType: Option Inbound,Outbound)
    begin
        //TODO
        //>>NV
        PurchHeader.CALCFIELDS("Outstanding Gross Weight", "Outstanding Net Weight");
        WhseRqst."Outstanding Gross Weight" := PurchHeader."Outstanding Gross Weight";
        WhseRqst."Outstanding Net Weight" := PurchHeader."Outstanding Net Weight";
        WhseRqst."Destination Name" := PurchHeader."Buy-from Vendor Name";
        //<<NV 
        //TODO
    end;
}
