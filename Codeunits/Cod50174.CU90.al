codeunit 50174 CU_90
{
    [EventSubscriber(ObjectType::Codeunit, 90, 'OnAfterCheckMandatoryFields', '', True, false)]
    local procedure OnAfterCheckMandatoryFields(var PurchaseHeader: Record "Purchase Header"; CommitIsSupressed: Boolean)
    begin
        //>> IST 030308 JWW  #12701 Added Function CheckReceiptDate()
        CheckReceiptDate(PurchaseHeader);
        //<< IST 030308 JWW  #12701 Added Function CheckReceiptDate()
    end;


    [EventSubscriber(ObjectType::Codeunit, 90, 'OnAfterCheckPurchDoc', '', True, false)]
    local procedure OnAfterCheckPurchDoc(var PurchHeader: Record "Purchase Header"; CommitIsSupressed: Boolean; WhseShip: Boolean; WhseReceive: Boolean; PreviewMode: Boolean; var ErrorMessageMgt: Codeunit "Error Message Management")
    var
        PurchLine: record "Purchase Line";
        Vend: Record Vendor;
    begin
        //>> NIF #10044 05-18-05 RTT
        //check vessel info for Items being received
        IF (PurchHeader.Receive) AND (PurchHeader."Document Type" = PurchHeader."Document Type"::Order) THEN BEGIN
            Vend.GET(PurchHeader."Buy-from Vendor No.");
            IF Vend."Vessel Info Mandatory" THEN BEGIN
                PurchLine.RESET();
                PurchLine.SETRANGE("Document Type", PurchHeader."Document Type");
                PurchLine.SETRANGE("Document No.", PurchHeader."No.");
                PurchLine.SETRANGE(Type, PurchLine.Type::Item);
                PurchLine.SETFILTER(Quantity, '<>0');
                PurchLine.SETFILTER("Qty. to Receive", '<>0');
                IF PurchLine.FIND('-') THEN
                    REPEAT
                        PurchLine.TESTFIELD("Sail-on Date");
                        PurchLine.TESTFIELD("Vessel Name");
                    UNTIL PurchLine.NEXT() = 0;
            END;
        END;
        //>> NIF #10044 05-18-05 RTT

    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnCheckAndUpdateOnAfterSetSourceCode', '', True, false)]
    local procedure OnCheckAndUpdateOnAfterSetSourceCode(var PurchHeader: Record "Purchase Header"; SourceCodeSetup: Record "Source Code Setup"; var SrcCode: Code[10]);

    begin
        // >> Receiving
        PurchSetup.get();
        IF PurchSetup."Enable Receive" AND
           (PurchSetup."LAX E-Rec Locking Optimization" =
            PurchSetup."LAX E-Rec Locking Optimization"::Base)
        THEN
            Receiving.CheckPurchHeader(PurchHeader);
        // << Receiving

        // >> Shipping
        IF PurchHeader.Receive AND PurchSetup."LAX Enable Shipping" THEN
            Shipping.CheckPurchHeader(PurchHeader);
        // << Shipping

    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnBeforeInsertReceiptHeader', '', True, false)]
    local procedure OnBeforeInsertReceiptHeader(var PurchHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var IsHandled: Boolean; CommitIsSuppressed: Boolean)
    begin
        // >> pfc
        PurchRcptHeader."Bill of Lading No." := BOL;
        PurchRcptHeader."Carrier Vendor No." := CarrierNo;
        PurchRcptHeader."Carrier Trailer ID" := CarrierTrailer;
        // << pfc

    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnAfterInsertReceiptHeader', '', True, false)]
    local procedure OnAfterInsertReceiptHeader(var PurchHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var TempWhseRcptHeader: Record "Warehouse Receipt Header" temporary; WhseReceive: Boolean; CommitIsSuppressed: Boolean)
    begin
        PurchSetup.get();
        // >> Receiving
        IF (PurchHeader."Document Type" IN [PurchHeader."Document Type"::Order, PurchHeader."Document Type"::Invoice]) AND
           PurchSetup."LAX Enable Receive" AND
           (PurchSetup."LAX E-Rec Locking Optimization" =
            PurchSetup."LAX E-Rec Locking Optimization"::Base)
        THEN
            Receiving.PostReceivePurchHeader(PurchHeader, PurchRcptHeader);
        // << Receiving

    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnAfterReturnShptHeaderInsert', '', True, false)]
    local procedure OnAfterReturnShptHeaderInsert(var ReturnShptHeader: Record "Return Shipment Header"; var PurchHeader: Record "Purchase Header"; CommitIsSupressed: Boolean)
    begin
        PurchSetup.get();
        // >> Shipping
        IF (PurchHeader."Document Type" IN [PurchHeader."Document Type"::"Return Order"]) AND
           PurchSetup."LAX Enable Shipping"
        THEN
            Shipping.PostPackagePurchReturnOrder(PurchHeader, ReturnShptHeader);
        // << Shipping

    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnBeforePurchInvHeaderInsert', '', True, false)]

    local procedure OnBeforePurchInvHeaderInsert(var PurchInvHeader: Record "Purch. Inv. Header"; var PurchHeader: Record "Purchase Header"; CommitIsSupressed: Boolean)
    begin
        //>>IST 052405 DPC #9806
        PurchInvHeader."Contract Note No." := PurchHeader."Contract Note No.";
        PurchInvHeader."Exchange Contract No." := PurchHeader."Exchange Contract No.";
        PurchInvHeader."MOSP Reference No." := PurchHeader."MOSP Reference No.";

        "4XContractNote".SETRANGE("Contract Note No.", PurchHeader."Contract Note No.");
        IF "4XContractNote".FIND('-') THEN BEGIN
            "4XContractNote".Closed := TRUE;
            "4XContractNote".MODIFY();
        END;
        //>>IST 052405 DPC #9806

    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnBeforeInserCrMemoHeader', '', True, false)]

    local procedure OnBeforeInserCrMemoHeader(var PurchHeader: Record "Purchase Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var HideProgressWindow: Boolean; var Window: Dialog; var IsHandled: Boolean; SrcCode: Code[10]; PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr."; var PurchCommentLine: Record "Purch. Comment Line")
    begin
        // >> Shipping
        PurchSetup.Get();
        IF (PurchHeader."Document Type" IN [PurchHeader."Document Type"::"Credit Memo"]) AND
           PurchSetup."LAX Enable Shipping"
        THEN
            Shipping.PostPackagePurchCrMemo(PurchHeader, PurchCrMemoHeader);
        // << Shipping

    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnBeforePurchRcptLineInsert', '', True, false)]
    local procedure OnBeforePurchRcptLineInsert(var PurchRcptLine: Record "Purch. Rcpt. Line"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchLine: Record "Purchase Line"; CommitIsSupressed: Boolean; PostedWhseRcptLine: Record "Posted Whse. Receipt Line"; var IsHandled: Boolean; ItemLedgShptEntryNo: Integer)
    begin
        //>>NV
        PurchRcptLine."Line Gross Weight" := PurchRcptLine."Gross Weight" * PurchRcptLine.Quantity;
        PurchRcptLine."Line Net Weight" := PurchRcptLine."Net Weight" * PurchRcptLine.Quantity;
        //<<NV

    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnAfterPurchRcptLineInsert', '', True, false)]
    //local procedure OnAfterPurchRcptLineInsert(var PurchRcptLine: Record "Purch. Rcpt. Line"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchLine: Record "Purchase Line"; CommitIsSupressed: Boolean; PostedWhseRcptLine: Record "Posted Whse. Receipt Line"; var IsHandled: Boolean; ItemLedgShptEntryNo: Integer)
    local procedure OnAfterPurchRcptLineInsert(PurchaseLine: Record "Purchase Line"; var PurchRcptLine: Record "Purch. Rcpt. Line"; ItemLedgShptEntryNo: Integer; WhseShip: Boolean; WhseReceive: Boolean; CommitIsSupressed: Boolean; PurchInvHeader: Record "Purch. Inv. Header"; var TempTrackingSpecification: Record "Tracking Specification" temporary; PurchRcptHeader: Record "Purch. Rcpt. Header"; TempWhseRcptHeader: Record "Warehouse Receipt Header"; xPurchLine: Record "Purchase Line"; var TempPurchLineGlobal: Record "Purchase Line" temporary)
    begin
        //>>NV
        IF PurchSetup."Copy Comments Order to Receipt" THEN
            CopyLineCommentLines(
              PurchaseLine."Document Type",
              PurchLineCommentLine."Document Type"::Receipt,
              PurchaseLine."Document No.",
              PurchRcptLine."Document No.",
              PurchaseLine."Line No.",
              PurchRcptLine."Line No.");
        //<<NV
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnRunOnBeforeMakeInventoryAdjustment', '', True, false)]
    local procedure OnRunOnBeforeMakeInventoryAdjustment(var PurchaseHeader: Record "Purchase Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line"; PreviewMode: Boolean; PurchRcptHeader: Record "Purch. Rcpt. Header"; PurchInvHeader: Record "Purch. Inv. Header"; var IsHandled: Boolean)
    begin
        // >> Receiving
        PurchSetup.Get();
        IF PurchSetup."LAX Enable Receive" AND
           (PurchSetup."LAX E-Rec Locking Optimization" =
            PurchSetup."LAX E-Rec Locking Optimization"::Receiving)
        THEN BEGIN
            Receiving.CheckPurchHeader(PurchaseHeader);

            IF PurchaseHeader.Receive THEN
                IF (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order) OR
                   ((PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice) AND PurchSetup."Receipt on Invoice")
                THEN
                    Receiving.PostReceivePurchHeader(PurchaseHeader, PurchRcptHeader);
        END;
        // << Receiving

    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnPostItemJnlLineOnBeforeCopyDocumentFields', '', True, false)]
    local procedure OnPostItemJnlLineOnBeforeCopyDocumentFields(var ItemJournalLine: Record "Item Journal Line"; PurchaseHeader: Record "Purchase Header"; PurchaseLine: Record "Purchase Line"; WhseReceive: Boolean; WhseShip: Boolean; InvtPickPutaway: Boolean)

    begin
        //>>NV 03.31.04 JWW:
        //IF NVM.TestPermission(14017931) THEN BEGIN
        ItemJournalLine."Rework No." := PurchaseHeader."Rework No.";
        ItemJournalLine."Rework Line No." := PurchaseHeader."Rework Line No.";
        // END;
        //<<NV 03.31.04 JWW:
        //-AKK1606.01--
        ItemJournalLine."Entry/Exit No." := PurchaseLine."Entry/Exit No.";
        ItemJournalLine."Entry/Exit Date" := PurchaseLine."Entry/Exit Date";
        ItemJournalLine.National := PurchaseLine.National;
        //+AKK1606.01++

    end;


    [EventSubscriber(ObjectType::Codeunit, 90, 'OnPostItemJnlLineOnBeforeCopyDocumentFields', '', True, false)]
    // local procedure OnPostItemJnlLineOnAfterPrepareItemJnlLine(var ItemJournalLine: Record "Item Journal Line"; PurchaseLine: Record "Purchase Line"; PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; var GenJnlLineDocNo: code[20]; TrackingSpecification: Record "Tracking Specification"; QtyToBeReceived: Decimal; QtyToBeInvoiced: Decimal)
    local procedure OnPostItemJnlLineOnAfterPrepareItemJnlLine(var ItemJournalLine: Record "Item Journal Line"; PurchaseLine: Record "Purchase Line"; PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; var GenJnlLineDocNo: code[20]; TrackingSpecification: Record "Tracking Specification"; QtyToBeReceived: Decimal; QtyToBeInvoiced: Decimal)
    var
        InvtSetup: record "Inventory Setup";
    begin
        //>> NIF 06-29-05
        ItemJournalLine."Revision No." := PurchaseLine."Revision No.";
        ItemJournalLine."Revision Date" := PurchaseLine."Revision Date";
        ItemJournalLine."Drawing No." := PurchaseLine."Drawing No.";
        //<< NIF 06-29-05
        //>> NIF 05-06-06
        //>> NIF 032906 RTT
        //IF (STRPOS(COMPANYNAME,'Mexi')<>0) AND (QtyToBeReceived<>0) AND
        IF (STRPOS(COMPANYNAME, 'Mexi') <> 0) AND ((QtyToBeReceived <> 0) OR (PurchaseLine."Document Type" = PurchaseLine."Document Type"::Order)) AND
        //<< NIF 032906 RTT
              (PurchaseHeader."Tipo Cambio (USD)" <> 0) AND (PurchaseHeader."Tipo Cambio (JPY)" <> 0) THEN
            ItemJournalLine."Tipo Cambio (ACY)" := 1 / PurchaseHeader."Tipo Cambio (USD)";
        //<< NIF 05-06-06
        //>>NIF 050806 MAK
        ItemJournalLine."Country of Origin Code" := PurchaseLine."Country of Origin Code";
        ItemJournalLine.Manufacturer := PurchaseLine.Manufacturer;
        //<<NIF 050806 MAK

        //>>> NV
        // IF NVM.TestPermission(14018070) THEN BEGIN
        InvtSetup.GET();

        IF (PurchaseLine."Document Type" <> PurchaseLine."Document Type"::"Return Order") AND
           (PurchaseLine."Document Type" <> PurchaseLine."Document Type"::"Credit Memo") AND
           (InvtSetup."QC Hold On Purch. Receipts") AND
           (PurchaseLine."Qty. to Receive" <> 0) AND (PurchaseLine.Type = PurchaseLine.Type::Item) THEN
            //>> NF1.00:CIS.NG 12-18-15
            //IF (PurchLine."QC Hold") OR (QCMgmt.CheckPeriodicInspection("No.",TODAY)) THEN
            IF PurchaseLine."QC Hold" THEN
                  //<< NF1.00:CIS.NG 12-18-15
                  begin
                //only way reach this point, is if either qc hold or per insp
                //so if not qc hold, must be periodic inspection
                //give message
                IF (NOT PurchaseLine."QC Hold") AND (GUIALLOWED) THEN
                    MESSAGE('ALERT: Item %1 has been put on QC Hold for Periodic Inspection.\' +
                            '       Please take this item to the QC lab.', PurchaseLine."No.");

                //ItemJnlLine."QC Reference No." := QCMgmt.PurchFindQCReference(PurchLine,PurchRcptHeader."No.");  //NF1.00:CIS.NG 12-18-15
                ItemJournalLine."QC Hold" := TRUE;
            END;
        // END;
        //<<< NV
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnAfterInitAssocItemJnlLine', '', True, false)]
    local procedure OnAfterInitAssocItemJnlLine(var ItemJournalLine: Record "Item Journal Line"; SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; PurchaseHeader: Record "Purchase Header"; QtyToBeShipped: Decimal)
    begin
        //>>NV
        ItemJournalLine."Order Date" := SalesHeader."Order Date";
        //<<NV
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnSaveInvoiceSpecificationOnBeforeTempTrackingSpecificationModify', '', True, false)]

    local procedure OnSaveInvoiceSpecificationOnBeforeTempTrackingSpecificationModify(var TempTrackingSpecification: Record "Tracking Specification" temporary; var TempInvoicingSpecification: Record "Tracking Specification" temporary)
    begin
        //>> NIF 03/13/06 RTT
        //TempTrackingSpecification.MODIFY;
        IF UPPERCASE(USERID) <> 'IST' THEN
            TempTrackingSpecification.INSERT()
        ELSE
            if NOT CONFIRM('Item ' + TempTrackingSpecification."Item No." + ' found with dup. CONTINUE?') THEN
                ERROR('STOPPED')
            ELSE
                TempTrackingSpecification.MODIFY();
        //>> NIF 03/13/06 RTT
    end;


    PROCEDURE CopyLineCommentLines(FromDocumentType: Integer; ToDocumentType: Integer; FromNumber: Code[20]; ToNumber: Code[20]; FromLine: Integer; ToLine: Integer);
    BEGIN
        //>> NF1.00:CIS.CM 09-29-15
        //PurchLineCommentLine.SETRANGE("Document Type",FromDocumentType);
        //PurchLineCommentLine.SETRANGE("No.",FromNumber);
        //PurchLineCommentLine.SETRANGE("Doc. Line No.",FromLine);
        //IF PurchLineCommentLine.FIND('-') THEN
        //  REPEAT
        //    PurchLineCommentLine2 := PurchLineCommentLine;
        //    PurchLineCommentLine2."Document Type" := ToDocumentType;
        //    PurchLineCommentLine2."No." := ToNumber;
        //    PurchLineCommentLine2."Doc. Line No." := ToLine;
        //    PurchLineCommentLine2.INSERT;
        //  UNTIL PurchLineCommentLine.NEXT = 0;
        //<< NF1.00:CIS.CM 09-29-15
    END;

    // PROCEDURE SetProdKitLineApplyTo();
    // BEGIN
    // END;

    PROCEDURE SetBOL(WhseRcptHeader: Record 7316);
    BEGIN
        // >> pfc
        BOL := WhseRcptHeader."Inbound Bill of Lading No.";
        CarrierNo := WhseRcptHeader."Carrier Vendor No.";
        CarrierTrailer := WhseRcptHeader."Carrier Trailer ID";
        // << pfc
    END;

    PROCEDURE CheckReceiptDate(PurchHeader: Record 38);
    VAR
        PurchLine: Record 39;
        PurchRcptLine: Record 121;
        CheckDate: Date;
    BEGIN
        //>> IST 030308 JWW  #12701 Added Function CheckReceiptDate()

        IF PurchHeader."Document Type" = PurchHeader."Document Type"::Invoice THEN BEGIN
            CheckDate := CALCDATE('1M', PurchHeader."Posting Date");
            //CheckDate := CALCDATE('CM',PurchHeader."Posting Date");
            PurchLine.SETRANGE("Document Type", PurchHeader."Document Type");
            PurchLine.SETRANGE("Document No.", PurchHeader."No.");
            PurchLine.SETFILTER("Receipt No.", '<>%1', '');
            IF PurchLine.FIND('-') THEN
                REPEAT
                    PurchRcptLine.GET(PurchLine."Receipt No.", PurchLine."Receipt Line No.");
                    IF PurchRcptLine."Posting Date" > CheckDate THEN
                        ERROR(Text50000, PurchLine."Receipt No.", PurchLine."Receipt Line No.");
                UNTIL PurchLine.NEXT() = 0;
        END;
        //<< IST 030308 JWW  #12701 Added Function CheckReceiptDate()
    END;



    var
        //">>IST": Integer;
        "4XContractNote": Record 50011;
       PurchLineCommentLine: Record 14017611;
        PurchSetup: Record "Purchases & Payables Setup";

        NVM: Codeunit 50021;

        Receiving: Codeunit 14000601;
        Shipping: Codeunit 14000701;
        BOL: Code[20];
        CarrierNo: Code[20];
        CarrierTrailer: Code[20];
        // "4xPO": Record 50008;
        Text50000: Label 'ENU=Purchase Receipt %1 Line %2 has Posting Date in month later than Posting Date of Invoice.', Comment = '%1 Recepit No %2 Line no';


}
