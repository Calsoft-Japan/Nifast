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

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Activity-Post", OnAfterPostWhseActivityLine, '', false, false)]
    local procedure "Whse.-Activity-Post_OnAfterPostWhseActivityLine"(WhseActivHeader: Record "Warehouse Activity Header"; var WhseActivLine: Record "Warehouse Activity Line"; PostedSourceNo: Code[20]; PostedSourceType: Integer; PostedSourceSubType: Integer)
    var

        LabelMgtNIF: Codeunit "Label Mgmt NIF";
        SalesSetup: Record "Sales & Receivables Setup";
        gSlShipHdrRec: Record "Sales Shipment Header";
        gPackagelineRec: Record "LAX Package Line";
        gPostedPackageLine: Record "LAX Posted Package Line";
        gPackageRec: Record "LAX Package";
        gShippingCu: Codeunit "LAX Shipping";
        PostedInvtPickHdr: Record "Posted Invt. Pick Header";
    begin
        PostedInvtPickHdr.Reset();
        PostedInvtPickHdr.SetRange("Source No.", PostedSourceNo);
        if not PostedInvtPickHdr.FindFirst() then
            exit;
        //>> NIF 06-29-05 RTT
        IF (WhseActivHeader.Type = WhseActivHeader.Type::"Invt. Pick") THEN
            //>>NIF 10-25-07
            //only applies to sales orders
            IF WhseActivHeader."Source Type" = DATABASE::"Sales Line" THEN BEGIN
                SalesSetup.GET;
                IF (SalesSetup."Enable Shipping - Picks") THEN
                    LabelMgtNIF.CreatePackageFromRegPick(PostedInvtPickHdr);
            END;
        //<< NIF 06-29-05 RTT
        //NF2.00:CIS.RAM 09-29-2017
        SalesSetup.GET;
        IF SalesSetup."Create Pack & Enable Ship" THEN BEGIN
            gSlShipHdrRec.RESET;
            gSlShipHdrRec.SETRANGE(gSlShipHdrRec."No.", PostedInvtPickHdr."Source No.");
            IF gSlShipHdrRec.FINDFIRST THEN BEGIN
                gPackagelineRec.RESET;
                gPackagelineRec.SETRANGE(gPackagelineRec."Package No.", WhseActivLine."No.");
                gPackagelineRec.SETRANGE(gPackagelineRec."Source ID", gSlShipHdrRec."Order No.");
                IF gPackagelineRec.FINDFIRST THEN BEGIN
                    REPEAT
                        gPostedPackageLine.RESET;
                        gPostedPackageLine.SETRANGE(gPostedPackageLine."No.", gPackagelineRec."No.");
                        gPostedPackageLine.SETRANGE(gPostedPackageLine."Source ID", gPackagelineRec."Source ID");
                        gPostedPackageLine.SETRANGE(gPostedPackageLine."No.", gPackagelineRec."No.");
                        gPostedPackageLine.SETRANGE(gPostedPackageLine.Quantity, gPackagelineRec.Quantity);
                        IF gPostedPackageLine.FINDFIRST THEN BEGIN
                            gPostedPackageLine."Carton First SrNo." := gPackagelineRec."Carton First SrNo.";
                            gPostedPackageLine."Carton Last SrNo." := gPackagelineRec."Carton Last SrNo.";
                            gPostedPackageLine.MODIFY(TRUE);

                        END;
                    UNTIL gPackagelineRec.NEXT = 0;
                END;
            END;
        END;
        //NF2.00:CIS.RAM 10-10-2017
        gPackageRec.RESET;
        gPackageRec.SETRANGE(gPackageRec."No.", PostedInvtPickHdr."Invt Pick No.");
        IF gPackageRec.FINDFIRST THEN BEGIN
            REPEAT
                IF gPackageRec.Closed THEN
                    gShippingCu.OpenPackage(gPackageRec);
                gPackageRec.DELETE(TRUE);
            UNTIL gPackageRec.NEXT = 0;
        END;
        //NF2.00:CIS.RAM 10-10-2017

        //NF2.00:CIS.RAM 09-29-2017
    end;





    var
        LotInfo: Record 6505;
        NIFText001: Label 'ENU=Item %1, Lot %2 MUST have passed inspection before you can post this pick!', Comment = '%1 = WhseActivLine Item no  %2 = WhseActivline lot no';
        NIFText002: Label 'ENU=Item %1, Lot %2 CANNOT be blocked if you want to post this pick!', Comment = '%1= WhseActivLine Lot no %2 = Lot no';


}
