

codeunit 50179 CU_80
{
    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeValidatePostingAndDocumentDate', '', false, false)]
    local procedure OnBeforeValidatePostingAndDocumentDate(var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean)
    var
        SalesReceivableSetup_lRec: Record 311;
        CurrExchRate: Record 330;
    begin
        // //>>NV
        // SalesHeader.CheckPayment(SalesHeader);
        // //<<NV

        // >> WCI.SN
        IF SalesHeader."Document Type" IN [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Invoice] THEN
            IF SalesHeader."Currency Code" <> '' THEN
                SalesHeader."Currency Factor" := CurrExchRate.ExchangeRate(SalesHeader."Posting Date", SalesHeader."Currency Code");
        // << WCI.SN
        //AKK1612.01-NS
        SalesReceivableSetup_lRec.GET;
        SalesReceivableSetup_lRec.TESTFIELD(SalesReceivableSetup_lRec."Export Sales Inv/Cr/Memo Path");
        //AKK1612.01-NE
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeCheckCustBlockage', '', false, false)]
    local procedure OnBeforeCheckCustBlockage(SalesHeader: Record "Sales Header"; CustCode: Code[20]; var ExecuteDocCheck: Boolean; var IsHandled: Boolean; var TempSalesLine: Record "Sales Line" temporary)
    begin
        //>> NF1.00:CIS.NG    08/04/16
        IF (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) AND SalesHeader.Receive AND (STRPOS(COMPANYNAME, 'Mexi') <> 0) THEN BEGIN
            IF SalesHeader."Posting Date" <> TODAY THEN
                SalesHeader.FIELDERROR("Posting Date", 'of order must be equal to system date')
        END;
        //<< NF1.00:CIS.NG    08/04/16

        //>>NV
        IF SalesHeader.Ship THEN
            IF NVM.CheckSoftBlock(0, SalesHeader."Sell-to Customer No.", SalesHeader."Ship-to Code", '', 7, SoftBlockError) THEN
                ERROR(SoftBlockError);
        IF SalesHeader.Invoice THEN
            IF NVM.CheckSoftBlock(0, SalesHeader."Sell-to Customer No.", SalesHeader."Ship-to Code", '', 2, SoftBlockError) THEN
                ERROR(SoftBlockError);
        IF SalesHeader.Receive THEN
            IF NVM.CheckSoftBlock(0, SalesHeader."Sell-to Customer No.", SalesHeader."Ship-to Code", '', 5, SoftBlockError) THEN
                ERROR(SoftBlockError);
        //<<NV
    end;


    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeInsertPostedHeaders', '', false, false)]
    local procedure OnBeforeInsertPostedHeaders(var SalesHeader: Record "Sales Header"; var TempWarehouseShipmentHeader: Record "Warehouse Shipment Header" temporary; var TempWarehouseReceiptHeader: Record "Warehouse Receipt Header" temporary)

    begin
        // >> Receiving
        SalesSetup.get();
        IF SalesSetup."LAX Enable Receive" THEN
            Receiving.CheckSalesHeader(SalesHeader);
        // << Receiving - end

        // >> Shipping
        IF SalesHeader.Ship AND SalesSetup."LAX Enable Shipping" AND
           (SalesSetup."LAX EShip Locking Optimization" =
            SalesSetup."LAX EShip Locking Optimization"::Base)
        THEN
            IF NOT SalesSetup."Enable Shipping - Picks" THEN //Re-engineered
                Shipping.CheckSalesHeader(SalesHeader);

        // IF (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) AND SalesHeader.Invoice AND SalesSetup."LAX Enable Shipping" THEN
        //   Shipping.CheckShipmentInvoicing(SalesHeader, SalesShptHeader, SalesInvHeader, FALSE);
        // << Shipping
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeSalesShptHeaderInsert', '', false, false)]
    local procedure OnBeforeSalesShptHeaderInsert(var SalesShptHeader: Record "Sales Shipment Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; var IsHandled: Boolean; var TempWhseRcptHeader: Record "Warehouse Receipt Header" temporary; WhseReceive: Boolean; var TempWhseShptHeader: Record "Warehouse Shipment Header" temporary; WhseShip: Boolean; InvtPickPutaway: Boolean)
    begin
        //>> NIF 07-12-05 RTT
        IF SalesShptHeader."EDI Control No." = '' THEN
            SalesShptHeader."EDI Control No." := SalesShptHeader."Order No.";
        //<< NIF 07-12-05 RTT
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterSalesShptHeaderInsert', '', false, false)]
    local procedure OnAfterSalesShptHeaderInsert(var SalesShipmentHeader: Record "Sales Shipment Header"; SalesHeader: Record "Sales Header"; SuppressCommit: Boolean; WhseShip: Boolean; WhseReceive: Boolean; var TempWhseShptHeader: Record "Warehouse Shipment Header"; var TempWhseRcptHeader: Record "Warehouse Receipt Header"; PreviewMode: Boolean)
    begin
        // >> Shipping
        IF (SalesHeader."Document Type" IN [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Invoice]) AND
           SalesSetup."LAX Enable Shipping" AND
           (SalesSetup."LAX EShip Locking Optimization" =
            SalesSetup."LAX EShip Locking Optimization"::Base)
        THEN
            IF NOT SalesSetup."Enable Shipping - Picks" THEN //Re-engineered
                Shipping.PostPackageSalesShipment(SalesHeader, SalesShipmentHeader);
        // << Shipping
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterInsertReturnReceiptHeader', '', false, false)]
    local procedure OnAfterInsertReturnReceiptHeader(var SalesHeader: Record "Sales Header"; var ReturnReceiptHeader: Record "Return Receipt Header")
    begin
        // >> Receiving
        IF SalesSetup."LAX Enable Receive" THEN
            Receiving.PostReceiveSalesReturnOrder(SalesHeader, ReturnReceiptHeader);
        // << Receiving

        // // >> Shipping
        // IF (SalesHeader."Document Type" IN [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Invoice]) AND
        //    SalesHeader.Invoice AND SalesSetup."LAX Enable Shipping" AND ("Invoice for Shipment No." <> '')
        // THEN
        //     SalesShptHeader.LOCKTABLE;
        // // << Shipping

    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnPostResJnlLineOnAfterInit', '', false, false)]
    local procedure OnPostResJnlLineOnAfterInit(var ResJnlLine: Record "Res. Journal Line"; var SalesLine: Record "Sales Line")
    begin
        //>>NV
        ResJnlLine."Resource Group No." := SalesLine."Resource Group No.";
        //TODO
        // ResJnlLine."Vendor No." := SalesLine."Vendor No.";
        // ResJnlLine."Vendor Item No." := SalesLine."Vendor Item No.";
        // ResJnlLine."Sell-to Customer No." := SalesLine."Sell-to Customer No.";
        // ResJnlLine."Salesperson Code" := SalesLine."Salesperson Code";
        //TODO
        //<<NV

    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeSalesShptLineInsert', '', false, false)]
    //local procedure OnBeforeInsertShipmentLine(var SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    local procedure OnBeforeSalesShptLineInsert(var SalesShptLine: Record "Sales Shipment Line"; SalesShptHeader: Record "Sales Shipment Header"; SalesLine: Record "Sales Line"; CommitIsSuppressed: Boolean; PostedWhseShipmentLine: Record "Posted Whse. Shipment Line"; SalesHeader: Record "Sales Header"; WhseShip: Boolean; WhseReceive: Boolean; ItemLedgShptEntryNo: Integer; xSalesLine: record "Sales Line"; var TempSalesLineGlobal: record "Sales Line" temporary; var IsHandled: Boolean)

    begin
        //>>NV
        SalesShptLine."Line Gross Weight" := SalesShptLine."Gross Weight" * SalesShptLine.Quantity;
        SalesShptLine."Line Net Weight" := SalesShptLine."Net Weight" * SalesShptLine.Quantity;
        SalesShptLine."Order Outstanding Qty. (Base)" := SalesLine."Outstanding Qty. (Base)";
        SalesShptLine."Order Quantity (Base)" := SalesLine."Quantity (Base)";
        SalesShptLine."Order Date" := SalesLine."Order Date";
        //<<NV

    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeSalesInvLineInsert', '', false, false)]
    local procedure OnBeforeSalesInvLineInsert(var SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; SalesLine: Record "Sales Line"; CommitIsSuppressed: Boolean; var IsHandled: Boolean; PostingSalesLine: Record "Sales Line"; SalesShipmentHeader: Record "Sales Shipment Header"; SalesHeader: Record "Sales Header"; var ReturnReceiptHeader: Record "Return Receipt Header")
    begin
        //>>NV
        SalesInvLine."Line Gross Weight" := SalesInvLine."Gross Weight" * SalesInvLine.Quantity;
        SalesInvLine."Line Net Weight" := SalesInvLine."Net Weight" * SalesInvLine.Quantity;
        SalesInvLine."Order Outstanding Qty. (Base)" := SalesLine."Outstanding Qty. (Base)";
        SalesInvLine."Order Quantity (Base)" := SalesLine."Quantity (Base)";
        SalesInvLine."Order Date" := SalesLine."Order Date";
        //<<NV
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeSalesCrMemoLineInsert', '', false, false)]
    local procedure OnBeforeSalesCrMemoLineInsert(var SalesCrMemoLine: Record "Sales Cr.Memo Line"; SalesCrMemoHeader: Record "Sales Cr.Memo Header"; SalesLine: Record "Sales Line"; CommitIsSuppressed: Boolean; var IsHandled: Boolean; var SalesHeader: Record "Sales Header"; var SalesShptHeader: Record "Sales Shipment Header"; var ReturnRcptHeader: Record "Return Receipt Header"; var PostingSalesLine: Record "Sales Line")
    begin
        //>>NV
        SalesCrMemoLine."Line Gross Weight" := SalesCrMemoLine."Gross Weight" * SalesCrMemoLine.Quantity;
        SalesCrMemoLine."Line Net Weight" := SalesCrMemoLine."Net Weight" * SalesCrMemoLine.Quantity;
        SalesCrMemoLine."Order Outstanding Qty. (Base)" := SalesLine."Outstanding Qty. (Base)";
        SalesCrMemoLine."Order Quantity (Base)" := SalesLine."Quantity (Base)";
        SalesCrMemoLine."Order Date" := SalesLine."Order Date";
        //<<NV
    end;




    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforePurchRcptLineInsert', '', false, false)]
    local procedure OnBeforePurchRcptLineInsert(var PurchRcptLine: Record "Purch. Rcpt. Line"; PurchRcptHeader: Record "Purch. Rcpt. Header"; PurchOrderLine: Record "Purchase Line"; DropShptPostBuffer: Record "Drop Shpt. Post. Buffer"; CommitIsSuppressed: Boolean; var TempSalesLineGlobal: Record "Sales Line" temporary; var IsHandled: Boolean)
    begin
        //>>NV
        PurchRcptLine."Posting Date" := PurchRcptHeader."Posting Date";
        PurchRcptLine."Vendor Shipment No." := PurchRcptHeader."Vendor Shipment No.";
        //<<NV

    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnRunOnBeforeMakeInventoryAdjustment', '', false, false)]
    local procedure OnRunOnBeforeMakeInventoryAdjustment(var SalesHeader: Record "Sales Header"; SalesInvHeader: Record "Sales Invoice Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line"; PreviewMode: Boolean; var SkipInventoryAdjustment: Boolean)
    begin
        // >> Shipping
        IF SalesHeader.Ship AND SalesSetup."LAX Enable Shipping" AND
           (SalesSetup."LAX EShip Locking Optimization" =
            SalesSetup."LAX EShip Locking Optimization"::Packing)
        THEN BEGIN
            IF NOT SalesSetup."Enable Shipping - Picks" THEN //Re-engineered
                Shipping.CheckSalesHeader(SalesHeader);
            //TODO
            // IF (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) OR
            //    ((SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice) AND SalesSetup."Shipment on Invoice")
            // THEN
            //     IF NOT SalesSetup."Enable Shipping - Picks" THEN //Re-engineered
            //         Shipping.PostPackageSalesShipment(SalesHeader, SalesShptHeader);//TODO
        END;
        // << Shipping

    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterFinalizePostingOnBeforeCommit', '', false, false)]
    local procedure OnAfterFinalizePostingOnBeforeCommit(var SalesHeader: Record "Sales Header"; var SalesShipmentHeader: Record "Sales Shipment Header"; var SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var ReturnReceiptHeader: Record "Return Receipt Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; var CommitIsSuppressed: Boolean; var PreviewMode: Boolean; WhseShip: Boolean; WhseReceive: Boolean; var EverythingInvoiced: Boolean)
    begin
        // >> Shipping
        //>> NIF 07-10-05
        //IF Ship AND SalesSetup."Enable Shipping" THEN
        //IF Ship AND SalesSetup."Enable Shipping" AND ("Bill of Lading No." = '') THEN
        IF SalesHeader.Ship AND (SalesSetup."LAX Enable Shipping" OR SalesSetup."Enable Shipping - Picks")
        THEN
            //<< NIF 07-10-05
            IF SalesHeader."Document Type" IN [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Invoice] THEN
                Shipping.CreateBOLPostSalesShipment(SalesShipmentHeader);

        IF SalesHeader.Ship AND SalesSetup."LAX Enable E-Mail" THEN
            EMailMgt.SendSalesShipmentNotice(SalesShipmentHeader, FALSE, FALSE);

        IF SalesHeader.Invoice AND SalesSetup."LAX Enable E-Mail" THEN
            EMailMgt.SendSalesInvoiceNotice(SalesInvoiceHeader, FALSE, FALSE);
        // << Shipping
        IF COMPANYNAME = 'NIFAST Mexicana' THEN BEGIN      //jrr
                                                           //TODO                                              //AKK1612.01-NS
                                                           //  IF SalesInvHeader_gRec.GET(SalesInvoiceHeader."No.") AND (SalesHeader.Invoice) THEN BEGIN
                                                           //    SalesInvHeader_gRec.ExportSIInvtoTxt2_gFnc(SalesInvHeader_gRec);
                                                           //END;//TODO
            IF SalesCrMemoHeader_gRec.GET(SalesCrMemoHeader."No.") THEN BEGIN
                SalesCrMemoHeader_gRec.ExportSICrMemotoTxt2_gFnc(SalesCrMemoHeader_gRec);
            END;
            //AKK1612.01-NE
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnPostItemJnlLineOnBeforeCopyTrackingFromSpec', '', false, false)]
    local procedure OnPostItemJnlLineOnBeforeCopyTrackingFromSpec(TrackingSpecification: Record "Tracking Specification"; var ItemJnlLine: Record "Item Journal Line"; SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; SalesInvHeader: Record "Sales Invoice Header"; SalesCrMemoHeader: Record "Sales Cr.Memo Header"; IsATO: Boolean)
    begin
        //-AKK1606.01--
        ItemJnlLine."Entry/Exit No." := SalesLine."Entry/Exit No.";
        ItemJnlLine."Entry/Exit Date" := SalesLine."Entry/Exit Date";
        ItemJnlLine.National := SalesLine.National;
        //+AKK1606.01++

        //>> NIF 07-10-05
        ItemJnlLine."Revision No." := SalesLine."Revision No.";
        ItemJnlLine."Revision Date" := SalesLine."Revision Date";
        ItemJnlLine."Drawing No." := SalesLine."Drawing No.";
        //<< NIF 07-10-05
        //>>NV
        ItemJnlLine."Tag No." := SalesLine."Tag No.";
        ItemJnlLine."Customer Bin" := SalesLine."Customer Bin";
        ItemJnlLine."FB Order No." := SalesLine."FB Order No.";
        ItemJnlLine."FB Line No." := SalesLine."FB Line No.";
        ItemJnlLine."Contract No." := SalesLine."Contract No.";

        //>> NF1.00:CIS.CM 09-29-15
        //IF NVM.TestPermission(14018070) THEN BEGIN
        //  InvtSetup.GET;
        //  IF ("Document Type"="Document Type"::"Return Order") AND (InvtSetup."QC Hold On Sales Return") THEN BEGIN
        //    ItemJnlLine."QC Reference No." := QCMgmt.SalesFindQCReference(SalesLine,ReturnRcptHeader."No.");
        //    ItemJnlLine."QC Hold" := TRUE;
        //  END;
        //END;
        //<<NV
        //>> NF1.00:CIS.CM 09-29-15

    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforePostAssocItemJnlLine', '', false, false)]
    local procedure OnBeforePostAssocItemJnlLine(var ItemJournalLine: Record "Item Journal Line"; var PurchaseLine: Record "Purchase Line"; CommitIsSuppressed: Boolean; var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    begin
        //>>NV
        ItemJournalLine."Order Date" := PurchaseLine."Order Date";
        //<<NV

    end;



    PROCEDURE CheckPayment(SalesPaymentHeader: Record 36);
    BEGIN
        // newvision
        IF (SalesPaymentHeader."Bal. Account No." <> '') AND
           (SalesPaymentHeader."External Document No." = '') THEN
            ERROR('External Document No. Required');
    END;

    PROCEDURE CheckProdKit(SalesLine2: Record 37; Ship2: Boolean);
    VAR
        IST001: Label 'ENU=Not enough Reserved Qty for Production Kit %1', Comment = '%1';
    BEGIN
        // newvision
        SalesLine2.CALCFIELDS("Reserved Quantity");
        IF Ship2 AND (SalesLine2."Qty. to Ship" > SalesLine2."Reserved Quantity") THEN
            ERROR(IST001, SalesLine2."Prod. Kit Order No.");
    END;

    //  PROCEDURE CopyLineCommentLines@80010(FromDocumentType@80000 : Integer; ToDocumentType@80001 : Integer; FromNumber@80002 : Code[20];ToNumber@80003 : Code[20];FromLine@80004 : Integer;ToLine@80005 : Integer);
    //BEGIN
    // newvision
    //>> NF1.00:CIS.CM 09-29-15
    //SalesLineCommentLine.SETRANGE("Document Type",FromDocumentType);
    //SalesLineCommentLine.SETRANGE("No.",FromNumber);
    //SalesLineCommentLine.SETRANGE("Doc. Line No.",FromLine);
    //IF SalesLineCommentLine.FIND('-') THEN
    //  REPEAT
    //    SalesLineCommentLine2 := SalesLineCommentLine;
    //    SalesLineCommentLine2."Document Type" := ToDocumentType;
    //    SalesLineCommentLine2."No." := ToNumber;
    //    SalesLineCommentLine2."Doc. Line No." := ToLine;
    //    SalesLineCommentLine2.INSERT;
    //  UNTIL SalesLineCommentLine.NEXT = 0;
    //<< NF1.00:CIS.CM 09-29-15
    // END;

    // PROCEDURE DeferredPayments();
    // VAR
    //   AmountDP : ARRAY [12] OF Decimal;
    //   AmountDPTotal : Decimal;
    //   DefPayment : ARRAY [12] OF Decimal;
    //   DefPaymentTotal : Decimal;
    //   DueDate2 : Date;
    //   I : Integer;
    //   InvDiscUSDDP : ARRAY [12] OF Decimal;
    //   InvDiscUSDDPTotal : Decimal;
    //   ProfitUSDDP : ARRAY [12] OF Decimal;
    //   ProfitUSDDPTotal : Decimal;
    //   RepeatNo : Integer;
    //   SalesPurchUSDDP : ARRAY [12] OF Decimal;
    //   SalesPurchUSDDPTotal : Decimal;
    // BEGIN
    //   // newvision
    //   CLEAR(DefPayment);
    //       IF SalesHeader."Bal. Account No." <> '' THEN
    //         ERROR('There can be NO Bal. Account No. if using Deferred Payments');

    //       Terms.GET(SalesHeader."Payment Terms Code");
    //       RepeatNo := 0;

    //   FOR I := 1 TO Terms."No. of Payments" DO
    //    BEGIN
    //     DefPayment[I] := ROUND(-TotalSalesLineLCY."Amount Including VAT" / Terms."No. of Payments",0.01,'<');
    //     DefPaymentTotal := DefPaymentTotal + DefPayment[I];
    //      IF I = Terms."No. of Payments" THEN
    //       IF DefPaymentTotal < -TotalSalesLineLCY."Amount Including VAT" THEN
    //         DefPayment[I] := DefPayment[I] + ( -TotalSalesLineLCY."Amount Including VAT" - DefPaymentTotal);
    //     AmountDP[I] := ROUND(-TotalSalesLine."Amount Including VAT" / Terms."No. of Payments",0.01,'<');
    //     AmountDPTotal := AmountDPTotal + AmountDP[I];
    //      IF I = Terms."No. of Payments" THEN
    //       IF AmountDPTotal < -TotalSalesLine."Amount Including VAT" THEN
    //         AmountDP[I] := AmountDP[I] + ( -TotalSalesLine."Amount Including VAT" - AmountDPTotal);
    //     SalesPurchUSDDP[I] := ROUND(-TotalSalesLineLCY.Amount / Terms."No. of Payments",0.01,'<');
    //     SalesPurchUSDDPTotal := SalesPurchUSDDPTotal + SalesPurchUSDDP[I];
    //      IF I = Terms."No. of Payments" THEN
    //       IF SalesPurchUSDDPTotal < -TotalSalesLineLCY.Amount THEN
    //         SalesPurchUSDDP[I] := SalesPurchUSDDP[I] + ( -TotalSalesLineLCY.Amount - SalesPurchUSDDPTotal);
    //     ProfitUSDDP[I] :=
    //        ROUND(-(TotalSalesLineLCY.Amount - TotalSalesLineLCY."Unit Cost (LCY)") / Terms."No. of Payments",0.01,'<');
    //     ProfitUSDDPTotal := ProfitUSDDPTotal + ProfitUSDDP[I];
    //      IF I = Terms."No. of Payments" THEN
    //       IF ProfitUSDDPTotal < -(TotalSalesLineLCY.Amount - TotalSalesLineLCY."Unit Cost (LCY)") THEN
    //         ProfitUSDDP[I] := ProfitUSDDP[I] + (-(TotalSalesLineLCY.Amount - TotalSalesLineLCY."Unit Cost (LCY)") - ProfitUSDDPTotal);
    //     InvDiscUSDDP[I] := ROUND(-TotalSalesLineLCY."Inv. Discount Amount" / Terms."No. of Payments",0.01,'<');
    //     InvDiscUSDDPTotal := InvDiscUSDDPTotal + InvDiscUSDDP[I];
    //      IF I = Terms."No. of Payments" THEN
    //       IF InvDiscUSDDPTotal < -TotalSalesLineLCY."Inv. Discount Amount" THEN
    //         InvDiscUSDDP[I] := InvDiscUSDDP[I] + ( -TotalSalesLineLCY."Inv. Discount Amount" - InvDiscUSDDPTotal);
    //    END;

    //      REPEAT
    //       RepeatNo := RepeatNo + 1;
    //       Window.UPDATE(4,1);
    //       GenJnlLine.INIT;
    //       GenJnlLine."Posting Date" := SalesHeader."Posting Date";
    //       GenJnlLine."Document Date" := SalesHeader."Document Date";
    //       GenJnlLine.Description := SalesHeader."Posting Description";
    //       GenJnlLine."Shortcut Dimension 1 Code" := SalesHeader."Shortcut Dimension 1 Code";
    //       GenJnlLine."Shortcut Dimension 2 Code" := SalesHeader."Shortcut Dimension 2 Code";
    //       GenJnlLine."Reason Code" := SalesHeader."Reason Code";
    //       GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
    //       GenJnlLine."Account No." := SalesHeader."Bill-to Customer No.";
    //       GenJnlLine."Document Type" := GenJnlLineDocType;
    //       GenJnlLine."Document No." := GenJnlLineDocNo;
    //       GenJnlLine."External Document No." := GenJnlLineExtDocNo;
    //       GenJnlLine."Currency Code" := SalesHeader."Currency Code";
    //       IF RepeatNo = 1 THEN
    //         BEGIN
    //          GenJnlLine."Due Date" := SalesHeader."Due Date";
    //          DueDate2 := CALCDATE(Terms."Due Date Calculation",SalesHeader."Due Date")
    //         END
    //       ELSE
    //         BEGIN
    //          GenJnlLine."Due Date" := DueDate2;
    //          DueDate2 := CALCDATE(Terms."Due Date Calculation",GenJnlLine."Due Date")
    //         END;
    //       GenJnlLine.Amount := AmountDP[RepeatNo];
    //       GenJnlLine."Source Currency Code" := SalesHeader."Currency Code";
    //       GenJnlLine."Source Currency Amount" := AmountDP[RepeatNo];
    //       GenJnlLine."Amount (LCY)" := DefPayment[RepeatNo];
    //       IF SalesHeader."Currency Code" = '' THEN
    //         GenJnlLine."Currency Factor" := 1
    //       ELSE
    //         GenJnlLine."Currency Factor" :=  SalesHeader."Currency Factor";
    //       GenJnlLine.Correction := SalesHeader.Correction;
    //       GenJnlLine."Sales/Purch. (LCY)" := SalesPurchUSDDP[RepeatNo];
    //       GenJnlLine."Profit (LCY)" := ProfitUSDDP[RepeatNo];
    //       GenJnlLine."Inv. Discount (LCY)" := InvDiscUSDDP[RepeatNo];
    //       GenJnlLine."Bill-to/Pay-to No." := SalesHeader."Sell-to Customer No.";
    //       GenJnlLine."Salespers./Purch. Code" := SalesHeader."Salesperson Code";
    //       GenJnlLine."System-Created Entry" := TRUE;
    //       GenJnlLine."On Hold" := SalesHeader."On Hold";
    //       GenJnlLine."Applies-to Doc. Type" := SalesHeader."Applies-to Doc. Type";
    //       GenJnlLine."Applies-to Doc. No." := SalesHeader."Applies-to Doc. No.";
    //       GenJnlLine."Applies-to ID" := SalesHeader."Applies-to ID";
    //       GenJnlLine."Allow Application" := SalesHeader."Bal. Account No." = '';
    //       GenJnlLine."Payment Terms Code" := SalesHeader."Payment Terms Code";
    //       GenJnlLine."Source Type" := GenJnlLine."Source Type"::Customer;
    //       GenJnlLine."Source No." := SalesHeader."Bill-to Customer No.";
    //       GenJnlLine."Source Code" := SrcCode;
    //       GenJnlLine."Posting No. Series" := SalesHeader."Posting No. Series";

    //       //During merge added following line and commented the earlier code
    //       GenJnlLine."Dimension Set ID" := SalesHeader."Dimension Set ID";
    //       //TempJnlLineDim.DELETEALL;
    //       //TempDocDim.RESET;
    //       //TempDocDim.SETRANGE("Table ID",DATABASE::"Sales Header");
    //       //DimMgt.CopyDocDimToJnlLineDim(TempDocDim,TempJnlLineDim);
    //       //GenJnlPostLine.RunWithCheck(GenJnlLine,TempJnlLineDim);
    //       GenJnlPostLine.RunWithCheck(GenJnlLine);                  //Added during merge to suit to NAV2015

    //      UNTIL RepeatNo = Terms."No. of Payments";
    // END;









    var
        Terms: Record 3;


        SalesSetup: record "Sales & Receivables Setup";
        NVM: Codeunit 50021;
        SoftBlockError: Text[80];
        ">> pfc jm": Integer;
        GenJnlLineOrderType: Option;
        ">> NIF": Integer;
        LotEntry: Record 50002;
        SalesInvHeader_gRec: Record 112;
        SalesCrMemoHeader_gRec: Record 114;

        Shipping: Codeunit 14000701;
        EMailMgt: Codeunit 14000903;
        Receiving: Codeunit 14000601;

}
