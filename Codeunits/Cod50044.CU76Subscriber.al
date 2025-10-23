codeunit 50044 CU76Subscriber
{
    //Version NAVW17.00,NV4.31;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Get Drop Shpt.", OnCodeOnBeforeSelectSalesHeader, '', false, false)]
    local procedure OnCodeOnBeforeSelectSalesHeader(var PurchaseHeader: Record "Purchase Header"; var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
        IsHandled := true;

        SalesHeader.SetCurrentKey("Document Type", "Sell-to Customer No.");
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetRange("Sell-to Customer No.", PurchaseHeader."Sell-to Customer No.");
        //>> NV4.30
        SalesHeader.FINDFIRST();
        //<< NV4.30
        if (PAGE.RunModal(PAGE::"Sales List", SalesHeader) <> ACTION::LookupOK) or
           (SalesHeader."No." = '')
        then
            exit;
    end;
}