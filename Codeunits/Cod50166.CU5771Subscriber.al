codeunit 50166 CU5771Subscriber
{
    // Version List=NAVW17.00,NV4.35,NIF.N15.C9IN.001;
    var
        NVM: Codeunit 50021;
        SoftBlockError: Text[80];

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Sales Release", OnBeforeReleaseSetWhseRequestSourceDocument, '', false, false)]
    local procedure OnBeforeReleaseSetWhseRequestSourceDocument(var SalesHeader: Record "Sales Header"; var WarehouseRequest: Record "Warehouse Request"; var IsHandled: Boolean)
    begin
        //>>NV
        IF NVM.CheckSoftBlock(0, SalesHeader."Sell-to Customer No.", SalesHeader."Ship-to Code", '', 7, SoftBlockError) THEN
            ERROR(SoftBlockError);
        IF NVM.CheckSoftBlock(0, SalesHeader."Bill-to Customer No.", '', '', 7, SoftBlockError) THEN
            ERROR(SoftBlockError);
        //<<NV 
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Sales Release", OnBeforeCreateWhseRequest, '', false, false)]
    local procedure OnBeforeCreateWhseRequest(var WhseRqst: Record "Warehouse Request"; var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; WhseType: Option Inbound,Outbound)
    begin
        //TODO
        //>>NV
        SalesHeader.CALCFIELDS("Outstanding Gross Weight", "Outstanding Net Weight");
        WhseRqst."Outstanding Gross Weight" := SalesHeader."Outstanding Gross Weight";
        WhseRqst."Outstanding Net Weight" := SalesHeader."Outstanding Net Weight";
        WhseRqst."Destination Name" := SalesHeader."Ship-to Name";
        WhseRqst."Destination Code" := SalesHeader."Ship-to Code";
        //<<NV 
        //TODO
    end;
}