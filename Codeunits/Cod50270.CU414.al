codeunit 50270 CU_414
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, 414, 'OnAfterReleaseATOs', '', True, false)]

    local procedure OnAfterReleaseATOs(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; PreviewMode: Boolean)
    begin
        // >> Shipping
        SalesSetup.get();
        IF SalesSetup."Enable Shipping" AND NOT RunFromEship THEN
            NameAndAddressMgt.CheckNameAddressSalesHeader(SalesHeader, "Shipping Agent Code");
        // << Shipping

    end;

    [EventSubscriber(ObjectType::Codeunit, 414, 'OnAfterReleaseSalesDoc', '', True, false)]
    local procedure OnAfterReleaseSalesDoc(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var LinesWereModified: Boolean; SkipWhseRequestOperations: Boolean)
    begin
        // >> Shipping
        SalesSetup.Get();
        IF (SalesSetup."Enable E-Mail") and (NOT RunFromEship) THEN
            EMailMgt.SendSalesConfirmation(SalesHeader, FALSE, FALSE);
        // << Shipping

        // >> EDI
        IF (SalesHeader."EDI Order") and (SalesHeader."EDI Cancellation Request") and (NOT RunFromEship) THEN
            ERROR(Text14000351);
        // << EDI
    end;


    PROCEDURE SetRunFromEShip();
    BEGIN
        RunFromEship := TRUE;
    END;



    var
        RunFromEship: Boolean;
        NameAndAddressMgt: Codeunit 14000709;
        SalesSetup: Record "Sales & Receivables Setup";
        Text14000351: Label 'ENU=A P.O. change cancellation request has been received for this order.';
        EMailMgt: Codeunit 14000903;

}