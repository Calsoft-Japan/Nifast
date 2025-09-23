codeunit 50046 CU5063Subscriber
{
    //Version NAVW18.00,NAVNA8.00,SE0.55;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ArchiveManagement, OnBeforeCheckIfDocumentIsPartiallyPosted, '', false, false)]
    local procedure OnBeforeCheckIfDocumentIsPartiallyPosted(var SalesHeaderArchive: Record "Sales Header Archive"; var DoCheck: Boolean)
    var
    // SalesHeader: Record "Sales Header";
    begin
        //TODO
        /*   if SalesHeader.Get(SalesHeaderArchive."Document Type", SalesHeaderArchive."No.") then begin
              // >> EDI
              SalesHeader.TESTFIELD("EDI Order", FALSE);
              SalesHeader.TESTFIELD("EDI Internal Doc. No.", '');
              // << EDI
          end; */
        //TODO
    end;
}