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
        //TODO
        /*    // << Shipping
           SalesShptHeader."E-Mail Shipment Notice Handled" := FromSalesShptHeader."E-Mail Shipment Notice Handled";
           SalesShptHeader."EDI Order" := FromSalesShptHeader."EDI Order";
           SalesShptHeader."Shipment Invoice No." := FromSalesShptHeader."Shipment Invoice No.";
           SalesShptHeader."Shipment Release" := FromSalesShptHeader."Shipment Release";
           SalesShptHeader."EDI Trade Partner" := FromSalesShptHeader."EDI Trade Partner";
           // >> Shipping */
        //TODO
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

        //TODO
        /*  SalesInvoiceHeader2."E-Mail Invoice Notice Handled" := SalesInvoiceHeader."E-Mail Invoice Notice Handled";
         SalesInvoiceHeader2."EDI Order" := SalesInvoiceHeader."EDI Order";
         SalesInvoiceHeader2."EDI Trade Partner" := SalesInvoiceHeader."EDI Trade Partner";
         SalesInvoiceHeader2."Invoice for Bill of Lading No." := SalesInvoiceHeader."Invoice for Bill of Lading No.";
         SalesInvoiceHeader2."Invoice for Shipment No." := SalesInvoiceHeader."Invoice for Shipment No."; */
        //TODO

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

        //TODO
        //SalesInvoiceHeader2."EDI Invoice" := SalesInvoiceHeader."EDI Invoice";
        //TODO

        SalesInvoiceHeader2.MODIFY();
        SalesInvoiceHeader := SalesInvoiceHeader2;
        // << Shipping
    END;

    PROCEDURE BillOfLadingSalesShipmentHdr(CurrentSalesShipmentHeader: Record 110; BillOfLadingNo: Code[20]);
    VAR
    /*  PostedPackage: Record 14000704;
     BillOfLadingLine: Record 14000823; 
    SalesShptHeader: Record "Sales Shipment Header";*/
    BEGIN
        //TODO
        /*  SalesShptHeader.GET(CurrentSalesShipmentHeader."No.");
         SalesShptHeader.VALIDATE("Bill of Lading No.", BillOfLadingNo);
         SalesShptHeader.MODIFY();

         BillOfLadingLine.LOCKTABLE;

         PostedPackage.RESET;
         PostedPackage.SETCURRENTKEY("Source Type", "Source Subtype", "Posted Source ID");
         PostedPackage.SETRANGE("Source Type", DATABASE::"Sales Header");
         PostedPackage.SETRANGE("Posted Source ID", CurrentSalesShipmentHeader."No.");
         PostedPackage.MODIFYALL(
           "Used on Bill of Lading No.", BillOfLadingNo, TRUE); */
        //TODO
    END;

    PROCEDURE PurchaseReceiptHeaderEdit(PurchReceiptHeader: Record 120);
    VAR
    //PurchReceiptHeader2: Record 120;
    BEGIN
        //TODO
        /*  // >> Shipping
         PurchReceiptHeader2 := PurchReceiptHeader;
         PurchReceiptHeader2.LOCKTABLE();
         PurchReceiptHeader2.FIND();

         PurchReceiptHeader2."E-Mail Receipt Notice Handled" := PurchReceiptHeader."E-Mail Receipt Notice Handled";

         PurchReceiptHeader2.MODIFY();
         PurchReceiptHeader := PurchReceiptHeader2;
         // << Shipping */
        //TODO
    END;

    PROCEDURE PurchaseInvoiceHeaderEdit(PurchInvoiceHeader: Record 122);
    VAR
    // PurchInvoiceHeader2: Record 122;
    BEGIN
        //TODO
        /* // >> Shipping
        PurchInvoiceHeader2 := PurchInvoiceHeader;
        PurchInvoiceHeader2.LOCKTABLE();
        PurchInvoiceHeader2.FIND();

        PurchInvoiceHeader2."E-Mail Invoice Notice Handled" := PurchInvoiceHeader."E-Mail Invoice Notice Handled";
        PurchInvoiceHeader2."EDI Order" := PurchInvoiceHeader."EDI Order";

        PurchInvoiceHeader2.MODIFY();
        PurchInvoiceHeader := PurchInvoiceHeader2;
        // << Shipping */
        //TODO
    END;

    PROCEDURE TransferShipmentHeaderEdit(TransferShipmentHeader: Record 5744);
    VAR
    // TransferShipmentHeader2: Record 5744;
    BEGIN
        //TODO
        /* // >> EDI
        TransferShipmentHeader2 := TransferShipmentHeader;
        TransferShipmentHeader2.LOCKTABLE();
        TransferShipmentHeader2.FIND();

        TransferShipmentHeader2."EDI Trade Partner" := TransferShipmentHeader."EDI Trade Partner";
        TransferShipmentHeader2."EDI Order" := TransferShipmentHeader."EDI Order";

        TransferShipmentHeader2.MODIFY();
        TransferShipmentHeader := TransferShipmentHeader2;
        // << EDI */
        //TODO
    END;

    PROCEDURE BillOfLadingPurchCrMemo(CurrentPurchCrMemoHeader: Record 124; BillOfLadingNo: Code[20]);
    VAR
    /*  PurchCrMemoHeader: Record 124;
     PostedPackage: Record 14000704;
     BillOfLadingLine: Record 14000823; */
    BEGIN
        //TODO
        /*   PurchCrMemoHeader.GET(CurrentPurchCrMemoHeader."No.");
          PurchCrMemoHeader.VALIDATE("Bill of Lading No.", BillOfLadingNo);
          PurchCrMemoHeader.MODIFY();

          BillOfLadingLine.LOCKTABLE();

          PostedPackage.RESET;
          PostedPackage.SETCURRENTKEY("Source Type", "Source Subtype", "Posted Source ID");
          PostedPackage.SETRANGE("Source Type", DATABASE::"Purchase Header");
          PostedPackage.SETRANGE("Posted Source ID", CurrentPurchCrMemoHeader."No.");
          PostedPackage.MODIFYALL("Used on Bill of Lading No.", BillOfLadingNo, TRUE); */
        //TODO
    END;

    PROCEDURE BillOfLadingReturnShipment(CurrentReturnShipmentHeader: Record 6650; BillOfLadingNo: Code[20]);
    VAR
    /*  ReturnShipmentHeader: Record 6650;
     PostedPackage: Record 14000704;
     BillOfLadingLine: Record 14000823; */
    BEGIN
        //TODO
        /*  ReturnShipmentHeader.GET(CurrentReturnShipmentHeader."No.");
         ReturnShipmentHeader.VALIDATE("Bill of Lading No.", BillOfLadingNo);
         ReturnShipmentHeader.MODIFY();

         BillOfLadingLine.LOCKTABLE();

         PostedPackage.RESET;
         PostedPackage.SETCURRENTKEY("Source Type", "Source Subtype", "Posted Source ID");
         PostedPackage.SETRANGE("Source Type", DATABASE::"Purchase Header");
         PostedPackage.SETRANGE("Posted Source ID", CurrentReturnShipmentHeader."No.");
         PostedPackage.MODIFYALL("Used on Bill of Lading No.", BillOfLadingNo, TRUE); */
        //TODO
    END;

    PROCEDURE BillOfLadingTransferShipment(CurrentTransferShipmentHeader: Record 5744; BillOfLadingNo: Code[20]);
    VAR
    /* TransferShipmentHeader: Record 5744;
PostedPackage: Record 14000704;
 BillOfLadingLine: Record 14000823; */
    BEGIN
        //TODO
        /*    TransferShipmentHeader.GET(CurrentTransferShipmentHeader."No.");
           TransferShipmentHeader.VALIDATE("Bill of Lading No.", BillOfLadingNo);
           TransferShipmentHeader.MODIFY();

           BillOfLadingLine.LOCKTABLE();

           PostedPackage.RESET;
           PostedPackage.SETCURRENTKEY("Source Type", "Source Subtype", "Posted Source ID");
           PostedPackage.SETRANGE("Source Type", DATABASE::"Transfer Header");
           PostedPackage.SETRANGE("Posted Source ID", CurrentTransferShipmentHeader."No.");
           PostedPackage.MODIFYALL("Used on Bill of Lading No.", BillOfLadingNo, TRUE); */
        //TODO
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

        //TODO
        /*  SalesCrMemoHeader2."EDI Order" := SalesCrMemoHeader."EDI Order";
         SalesCrMemoHeader2."EDI Trade Partner" := SalesCrMemoHeader."EDI Trade Partner"; */
        //TODO

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

        //TODO
        /*  ReturnReceiptHeader2."EDI Order" := ReturnReceiptHeader."EDI Order";
         ReturnReceiptHeader2."EDI Trade Partner" := ReturnReceiptHeader."EDI Trade Partner"; */
        //TODO

        ReturnReceiptHeader2.MODIFY();
        ReturnReceiptHeader := ReturnReceiptHeader2;
        // << EDI
    END;

}