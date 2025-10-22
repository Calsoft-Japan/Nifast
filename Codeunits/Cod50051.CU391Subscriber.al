codeunit 50051 CU391Subscriber
{
    //Version NAVW17.00,SE0.60,NIF1.017,NMX1.002;
    Permissions = TableData 21 = rm,
                TableData 110 = m,
                TableData 112 = m,
                TableData 114 = rm,
                TableData 120 = m,
                TableData 122 = m,
                TableData 124 = m,
                TableData 5744 = m,
                TableData 6650 = m;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Shipment Header - Edit", OnBeforeSalesShptHeaderModify, '', false, false)]
    local procedure OnBeforeSalesShptHeaderModify(var SalesShptHeader: Record "Sales Shipment Header"; FromSalesShptHeader: Record "Sales Shipment Header")
    begin
        // << Shipping
        SalesShptHeader."LAX E-Mail Ship Notice Handled" := FromSalesShptHeader."LAX E-Mail Ship Notice Handled";
        SalesShptHeader."LAX EDI Order" := FromSalesShptHeader."LAX EDI Order";
        SalesShptHeader."LAX Shipment Invoice No." := FromSalesShptHeader."LAX Shipment Invoice No.";
        SalesShptHeader."LAX EDI Shipment Release" := FromSalesShptHeader."LAX EDI Shipment Release";
        SalesShptHeader."LAX EDI Trade Partner" := FromSalesShptHeader."LAX EDI Trade Partner";
        // >> Shipping 

        // >> NIF
        SalesShptHeader."Model Year" := FromSalesShptHeader."Model Year";
        SalesShptHeader."EDI Control No." := FromSalesShptHeader."EDI Control No.";
        // << NIF
    end;

    PROCEDURE SalesInvoiceHeaderEdit(SalesInvoiceHeader: Record 112);
    VAR
        SalesInvoiceHeader2: Record 112;
        CLE: Record 21;
    BEGIN
        // >> Shipping
        SalesInvoiceHeader2 := SalesInvoiceHeader;
        SalesInvoiceHeader2.LOCKTABLE();
        SalesInvoiceHeader2.FIND();

        SalesInvoiceHeader2."LAX E-Mail Inv. Notice Handled" := SalesInvoiceHeader."LAX E-Mail Inv. Notice Handled";
        SalesInvoiceHeader2."LAX EDI Order" := SalesInvoiceHeader."LAX EDI Order";
        SalesInvoiceHeader2."LAX EDI Trade Partner" := SalesInvoiceHeader."LAX EDI Trade Partner";
        SalesInvoiceHeader2."LAX Invoice for BOL No." := SalesInvoiceHeader."LAX Invoice for BOL No.";
        SalesInvoiceHeader2."LAX Invoice for Shipment No." := SalesInvoiceHeader."LAX Invoice for Shipment No.";

        //>>NIF MAK 050806
        SalesInvoiceHeader2."Exclude from Virtual Inv." := SalesInvoiceHeader."Exclude from Virtual Inv.";
        SalesInvoiceHeader2."Mex. Factura No." := SalesInvoiceHeader."Mex. Factura No.";
        CLE.SETRANGE("Customer No.", SalesInvoiceHeader."Bill-to Customer No.");
        CLE.SETRANGE("Document Type", CLE."Document Type"::Invoice);
        CLE.SETRANGE("Document No.", SalesInvoiceHeader."No.");
        IF CLE.FIND('-') THEN BEGIN
            CLE."Mex. Factura No." := SalesInvoiceHeader."Mex. Factura No.";
            CLE.MODIFY();
        END;
        //<<NIF MAK 050806

        SalesInvoiceHeader2."LAX EDI Invoice" := SalesInvoiceHeader."LAX EDI Invoice";

        SalesInvoiceHeader2.MODIFY();
        SalesInvoiceHeader := SalesInvoiceHeader2;
        // << Shipping
    END;

    PROCEDURE BillOfLadingSalesShipmentHdr(CurrentSalesShipmentHeader: Record 110; BillOfLadingNo: Code[20]);
    VAR
        PostedPackage: Record 14000704;
        BillOfLadingLine: Record 14000823;
        SalesShptHeader: Record "Sales Shipment Header";
    BEGIN
        SalesShptHeader.GET(CurrentSalesShipmentHeader."No.");
        SalesShptHeader.VALIDATE("LAX Bill of Lading No.", BillOfLadingNo);
        SalesShptHeader.MODIFY();

        BillOfLadingLine.LOCKTABLE();

        PostedPackage.RESET;
        PostedPackage.SETCURRENTKEY("Source Type", "Source Subtype", "Posted Source ID");
        PostedPackage.SETRANGE("Source Type", DATABASE::"Sales Header");
        PostedPackage.SETRANGE("Posted Source ID", CurrentSalesShipmentHeader."No.");
        PostedPackage.MODIFYALL(
          "Used on Bill of Lading No.", BillOfLadingNo, TRUE);
    END;

    PROCEDURE PurchaseReceiptHeaderEdit(PurchReceiptHeader: Record 120);
    VAR
        PurchReceiptHeader2: Record 120;
    BEGIN
        // >> Shipping
        PurchReceiptHeader2 := PurchReceiptHeader;
        PurchReceiptHeader2.LOCKTABLE();
        PurchReceiptHeader2.FIND();

        PurchReceiptHeader2."LAX EMail Recpt Notice Handled" := PurchReceiptHeader."LAX EMail Recpt Notice Handled";

        PurchReceiptHeader2.MODIFY();
        PurchReceiptHeader := PurchReceiptHeader2;
        // << Shipping 
    END;

    PROCEDURE PurchaseInvoiceHeaderEdit(PurchInvoiceHeader: Record 122);
    VAR
        PurchInvoiceHeader2: Record 122;
    BEGIN
        //TODO
        // >> Shipping
        PurchInvoiceHeader2 := PurchInvoiceHeader;
        PurchInvoiceHeader2.LOCKTABLE();
        PurchInvoiceHeader2.FIND();

       // PurchInvoiceHeader2."LAX E-Mail Invoice Notice Handled" := PurchInvoiceHeader."LAX E-Mail Invoice Notice Handled";
        PurchInvoiceHeader2."LAX EDI Order" := PurchInvoiceHeader."LAX EDI Order";

        PurchInvoiceHeader2.MODIFY();
        PurchInvoiceHeader := PurchInvoiceHeader2;
        // << Shipping
        //TODO
    END;

    PROCEDURE TransferShipmentHeaderEdit(TransferShipmentHeader: Record 5744);
    VAR
        TransferShipmentHeader2: Record 5744;
    BEGIN
        // >> EDI
        TransferShipmentHeader2 := TransferShipmentHeader;
        TransferShipmentHeader2.LOCKTABLE();
        TransferShipmentHeader2.FIND();

        TransferShipmentHeader2."LAX EDI Trade Partner" := TransferShipmentHeader."LAX EDI Trade Partner";
        TransferShipmentHeader2."LAX EDI Order" := TransferShipmentHeader."LAX EDI Order";

        TransferShipmentHeader2.MODIFY();
        TransferShipmentHeader := TransferShipmentHeader2;
        // << EDI 
    END;

    PROCEDURE BillOfLadingPurchCrMemo(CurrentPurchCrMemoHeader: Record 124; BillOfLadingNo: Code[20]);
    VAR
        PurchCrMemoHeader: Record 124;
        PostedPackage: Record 14000704;
        BillOfLadingLine: Record 14000823;
    BEGIN
        PurchCrMemoHeader.GET(CurrentPurchCrMemoHeader."No.");
        PurchCrMemoHeader.VALIDATE("LAX Bill of Lading No.", BillOfLadingNo);
        PurchCrMemoHeader.MODIFY();

        BillOfLadingLine.LOCKTABLE();

        PostedPackage.RESET();
        PostedPackage.SETCURRENTKEY("Source Type", "Source Subtype", "Posted Source ID");
        PostedPackage.SETRANGE("Source Type", DATABASE::"Purchase Header");
        PostedPackage.SETRANGE("Posted Source ID", CurrentPurchCrMemoHeader."No.");
        PostedPackage.MODIFYALL("Used on Bill of Lading No.", BillOfLadingNo, TRUE);
    END;

    PROCEDURE BillOfLadingReturnShipment(CurrentReturnShipmentHeader: Record 6650; BillOfLadingNo: Code[20]);
    VAR
        ReturnShipmentHeader: Record 6650;
        PostedPackage: Record 14000704;
        BillOfLadingLine: Record 14000823;
    BEGIN
        ReturnShipmentHeader.GET(CurrentReturnShipmentHeader."No.");
        ReturnShipmentHeader.VALIDATE("LAX Bill of Lading No.", BillOfLadingNo);
        ReturnShipmentHeader.MODIFY();

        BillOfLadingLine.LOCKTABLE();

        PostedPackage.RESET;
        PostedPackage.SETCURRENTKEY("Source Type", "Source Subtype", "Posted Source ID");
        PostedPackage.SETRANGE("Source Type", DATABASE::"Purchase Header");
        PostedPackage.SETRANGE("Posted Source ID", CurrentReturnShipmentHeader."No.");
        PostedPackage.MODIFYALL("Used on Bill of Lading No.", BillOfLadingNo, TRUE);
    END;

    PROCEDURE BillOfLadingTransferShipment(CurrentTransferShipmentHeader: Record 5744; BillOfLadingNo: Code[20]);
    VAR
        TransferShipmentHeader: Record 5744;
        PostedPackage: Record 14000704;
        BillOfLadingLine: Record 14000823;
    BEGIN
        TransferShipmentHeader.GET(CurrentTransferShipmentHeader."No.");
        TransferShipmentHeader.VALIDATE("LAX Bill of Lading No.", BillOfLadingNo);
        TransferShipmentHeader.MODIFY();

        BillOfLadingLine.LOCKTABLE();

        PostedPackage.RESET;
        PostedPackage.SETCURRENTKEY("Source Type", "Source Subtype", "Posted Source ID");
        PostedPackage.SETRANGE("Source Type", DATABASE::"Transfer Header");
        PostedPackage.SETRANGE("Posted Source ID", CurrentTransferShipmentHeader."No.");
        PostedPackage.MODIFYALL("Used on Bill of Lading No.", BillOfLadingNo, TRUE);
    END;

    PROCEDURE SalesCrMemoHeaderEdit(SalesCrMemoHeader: Record 114);
    VAR
        SalesCrMemoHeader2: Record 114;
        CLE: Record 21;
    BEGIN
        // >> EDI
        SalesCrMemoHeader2 := SalesCrMemoHeader;
        SalesCrMemoHeader2.LOCKTABLE();
        SalesCrMemoHeader2.FIND();

        SalesCrMemoHeader2."LAX EDI Order" := SalesCrMemoHeader."LAX EDI Order";
        SalesCrMemoHeader2."LAX EDI Trade Partner" := SalesCrMemoHeader."LAX EDI Trade Partner";

        //>>WC1.01.Begin
        SalesCrMemoHeader2."Exclude from Virtual Inv." := SalesCrMemoHeader."Exclude from Virtual Inv.";
        SalesCrMemoHeader2."Mex. Factura No." := SalesCrMemoHeader."Mex. Factura No.";
        CLE.SETRANGE("Customer No.", SalesCrMemoHeader."Bill-to Customer No.");
        CLE.SETRANGE("Document Type", CLE."Document Type"::Invoice);
        CLE.SETRANGE("Document No.", SalesCrMemoHeader."No.");
        IF CLE.FIND('-') THEN BEGIN
            CLE."Mex. Factura No." := SalesCrMemoHeader."Mex. Factura No.";
            CLE.MODIFY();
        END;
        //<<WC1.01.Begin
        SalesCrMemoHeader2.MODIFY();
        SalesCrMemoHeader := SalesCrMemoHeader2;
        // << EDI
    END;

    PROCEDURE SalesReturnReceiptHeaderEdit(ReturnReceiptHeader: Record 6660);
    VAR
        ReturnReceiptHeader2: Record 6660;
    BEGIN
        // >> EDI
        ReturnReceiptHeader2 := ReturnReceiptHeader;
        ReturnReceiptHeader2.LOCKTABLE();
        ReturnReceiptHeader2.FIND();

        ReturnReceiptHeader2."LAX EDI Order" := ReturnReceiptHeader."LAX EDI Order";
        ReturnReceiptHeader2."LAX EDI Trade Partner" := ReturnReceiptHeader."LAX EDI Trade Partner";

        ReturnReceiptHeader2.MODIFY();
        ReturnReceiptHeader := ReturnReceiptHeader2;
        // << EDI
    END;

}