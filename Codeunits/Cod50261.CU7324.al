codeunit 50261 CU_7324
{
    [EventSubscriber(ObjectType::Codeunit, 7324, 'OnBeforeInsertTempWhseActivLine', '', True, false)]
    local procedure OnBeforeInsertTempWhseActivLine(var WhseActivLine: Record "Warehouse Activity Line"; ItemTrackingRequired: Boolean)
    begin
        //>>NIF MAK 091705
        IF LotInfo.GET(WhseActivLine."Item No.", WhseActivLine."Variant Code", WhseActivLine."Lot No.") THEN BEGIN
            IF WhseActivLine."Source Document" <> WhseActivLine."Source Document"::"Outbound Transfer" THEN
                IF NOT LotInfo."Passed Inspection" THEN
                    ERROR(NIFText001, WhseActivLine."Item No.", WhseActivLine."Lot No.");
            IF LotInfo.Blocked THEN
                ERROR(NIFText002, WhseActivLine."Item No.", WhseActivLine."Lot No.");
        END;
        //NOTE:Chkng the "Source Doc" is so you can transfer a "TEMP" lot even if not "Inspected"
        //<<NIF MAK 091705
    end;

    [EventSubscriber(ObjectType::Codeunit, 7324, 'OnAfterCreateWhseJnlLine', '', True, false)]

    local procedure OnAfterCreateWhseJnlLine(var WarehouseJournalLine: Record "Warehouse Journal Line"; WarehouseActivityLine: Record "Warehouse Activity Line"; SourceCodeSetup: Record "Source Code Setup")
    begin
        // >> JDC
        IF WarehouseActivityLine."License Plate No." <> '' THEN BEGIN
            WarehouseJournalLine."License Plate Operation Type" := WarehouseJournalLine."License Plate Operation Type"::"License Plate Movement";
            WarehouseJournalLine.VALIDATE("From License Plate No.", WarehouseActivityLine."License Plate No.");
            WarehouseJournalLine.VALIDATE("To License Plate No.", WarehouseActivityLine."License Plate No.");
        END;
        // <<

    end;

    [EventSubscriber(ObjectType::Codeunit, 7324, 'OnPostSourceDocumentOnBeforeSalesPostRun', '', True, false)]

    local procedure OnPostSourceDocumentOnBeforeSalesPostRun(WarehouseActivityHeader: Record "Warehouse Activity Header"; var SalesHeader: Record "Sales Header")
    begin
        //NG-NS
        IF SalesHeader."Posting Date" <> TODAY THEN BEGIN
            SalesHeader.VALIDATE("Posting Date", TODAY);
            SalesHeader.MODIFY();
        END;
        //NG-NE

    end;





    var
        LotInfo: Record 6505;
        NIFText001: Label 'ENU=Item %1, Lot %2 MUST have passed inspection before you can post this pick!', Comment = '%1 = WhseActivLine Item no  %2 = WhseActivline lot no';
        NIFText002: Label 'ENU=Item %1, Lot %2 CANNOT be blocked if you want to post this pick!', Comment = '%1= WhseActivLine Lot no %2 = Lot no';


}
