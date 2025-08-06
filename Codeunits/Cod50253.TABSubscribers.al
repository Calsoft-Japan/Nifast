codeunit 50253 Tabe38
{
    trigger OnRun()
    begin

    end;


    [EventSubscriber(ObjectType::Table, 38, 'OnAfterCheckBuyFromVendor', '', True, false)]
    local procedure OnAfterCheckBuyFromVendor(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header"; Vendor: Record Vendor)
    begin
        // //>>NV
        // IF NVM.CheckSoftBlock(1, PurchaseHeader."Buy-from Vendor No.", '', '', PurchaseHeader."Document Type", SoftBlockError) THEN
        //     ERROR(SoftBlockError);
        // //<<NV
        //>> NIF 09-21-05
        InsertVendorComments(Vendor, PurchaseHeader);
        //<< NIF 09-21-05
    end;



    [EventSubscriber(ObjectType::Table, 38, 'OnAfterCopyBuyFromVendorFieldsFromVendor', '', True, false)]

    local procedure OnAfterCopyBuyFromVendorFieldsFromVendor(var PurchaseHeader: Record "Purchase Header"; Vendor: Record Vendor; xPurchaseHeader: Record "Purchase Header")
    begin
        // PurchaseHeader."Broker/Agent Code" := Vendor."Broker/Agent Code";
        // IF Vendor."Order Address Code" <> '' THEN
        //     PurchaseHeader.VALIDATE("Order Address Code", Vendor."Order Address Code")
        // ELSE
        //     //<<NV
        //     PurchaseHeader."Order Address Code" := '';

        // // >> EDI
        // PurchaseHeader."EDI Order" := Vendor."EDI Order";
        // // << EDI
        PurchaseHeader."Shipping Agent Code" := Vendor."Shipping Agent Code";  //NF1.00:CIS.NG    23/08/16

    end;

    // [EventSubscriber(ObjectType::Table, 38, 'OnUpdatePurchLinesByChangedFieldName', '', True, false)]
    // local procedure OnUpdatePurchLinesByChangedFieldName(PurchHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line"; ChangedFieldName: Text[100]; ChangedFieldNo: Integer; xPurchaseHeader: Record "Purchase Header")
    // begin
    //     //-AKK1606.01--
    //     CASE ChangedFieldName OF
    //         FIELDCAPTION("Entry/Exit No."):
    //             UpdateConfirmed :=
    //             CONFIRM(
    //             STRSUBSTNO(
    //             Text032 +
    //             Text033, ChangedFieldName));
    //         FIELDCAPTION("Entry/Exit Date"):
    //             UpdateConfirmed :=
    //             CONFIRM(
    //             STRSUBSTNO(
    //             Text032 +
    //             Text033, ChangedFieldName));
    //     //+AKK1606.01++

    //     end;
    // end;




    [EventSubscriber(ObjectType::Table, 38, 'OnBeforeCheckBlockedVendOnDocs', '', True, false)]

    local procedure OnBeforeCheckBlockedVendOnDocs(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header"; var Vend: Record Vendor; CurrFieldNo: Integer; var IsHandled: Boolean)
    begin
        //>>NV
        IF NVM.CheckSoftBlock(1, PurchaseHeader."Pay-to Vendor No.", '', '', PurchaseHeader."Document Type", SoftBlockError) THEN
            ERROR(SoftBlockError);
        //<<NV
    end;

    PROCEDURE InsertVendorComments(Vend2: Record 23; Purchaseheader: Record 38);
    VAR
        POComments: Record 43;
        VendComments: Record 97;
        LineNo: Integer;
        NIFText001: Label 'ENU=Existing Comment Lines have been deleted and\';
        NIFText002: Label 'ENU=replaced with comments from the current Buy-from Vendor. \\';
        NIFText003: Label 'ENU=Please review any new comment lines.';
    BEGIN
        VendComments.SETRANGE("Table Name", VendComments."Table Name"::Vendor);
        VendComments.SETRANGE("No.", Vend2."No.");
        //VendComments.SETRANGE("Include in Purchase Orders", TRUE);
        LineNo := 100;


        //delete existing comments
        IF VendComments.FIND('-') THEN BEGIN
            POComments.SETRANGE("Document Type", Purchaseheader."Document Type");
            POComments.SETRANGE("No.", Purchaseheader."No.");
            IF POComments.FIND('-') THEN BEGIN
                POComments.DELETEALL;
                MESSAGE(NIFText001 + NIFText002 + NIFText003);
            END;
        END;

        IF VendComments.FIND('-') THEN
            REPEAT
                POComments.INIT;
                POComments."Document Type" := Purchaseheader."Document Type";
                POComments."No." := Purchaseheader."No.";
                POComments."Line No." := LineNo;
                POComments.Date := WORKDATE;
                POComments.Code := VendComments.Code;
                POComments.Comment := VendComments.Comment;
                // POComments."Print On Quote" := VendComments."Print On Purch. Quote";
                // POComments."Print On Order" := VendComments."Print On Purch. Order";
                // POComments."Print On Receipt" := VendComments."Print On Receipt";
                // POComments."Print On Invoice" := VendComments."Print On Purch. Invoice";
                // POComments."Print On Put Away" := FALSE;
                POComments.INSERT(TRUE);
                LineNo := LineNo + 100;
            UNTIL VendComments.NEXT = 0;
    END;


    // [EventSubscriber(ObjectType::Table, 38, 'OnAfterCopyShipToVendorAddressFieldsFromVendor', '', True, false)]

    // local procedure OnAfterCopyShipToVendorAddressFieldsFromVendor(var PurchaseHeader: Record "Purchase Header"; BuyFromVendor: Record Vendor)
    // begin
    //     // >> Shipping
    //     PurchaseHeader."E-Ship Agent Code" := BuyFromVendor."E-Ship Agent Code";
    //     IF BuyFromVendor."E-Ship Agent Code" <> '' THEN BEGIN
    //         PurchaseHeader.VALIDATE("E-Ship Agent Code", BuyFromVendor."E-Ship Agent Code");
    //         IF OrderAddr."E-Ship Agent Service" <> '' THEN
    //             VALIDATE("E-Ship Agent Service", BuyFromVendor."E-Ship Agent Service");
    //     END;
    //     PurchaseHeader."Residential Delivery" := BuyFromVendor."Residential Delivery";
    //     PurchaseHeader."Shipping Payment Type" := BuyFromVendor."Shipping Payment Type";
    //     PurchaseHeader."Shipping Insurance" := BuyFromVendor."Shipping Insurance";
    //     IF PurchaseHeader."Shipping Payment Type" = "Shipping Payment Type"::Prepaid THEN
    //         PurchaseHeader.VALIDATE("Third Party Ship. Account No.", '')
    //     ELSE
    //         IF ShippingAccount.GetPrimaryShippingAccountNo(
    //              "E-Ship Agent Code", ShippingAccount."Ship-to Type"::Vendor,
    //              "Sell-to Customer No.", "Ship-to Code")
    //         THEN
    //             PurchaseHeader.VALIDATE("Third Party Ship. Account No.", ShippingAccount."Account No.");
    //     // << Shipping
    // end;
    [EventSubscriber(ObjectType::Table, 38, 'OnBeforeUpdateShipToAddress', '', True, false)]
    local procedure OnBeforeUpdateShipToAddress(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean; CurrentFieldNo: Integer)
    begin
        //NF1.00:CIS.NG    23/08/16
        CLEAR(RespCenter);
        IF (PurchaseHeader."Responsibility Center" <> '') THEN BEGIN
            IF (RespCenter.GET(PurchaseHeader."Responsibility Center")) AND
              (PurchaseHeader."Sell-to Customer No." = '') THEN BEGIN
                PurchaseHeader."Ship-to Name" := RespCenter.Name;
                PurchaseHeader."Ship-to Name 2" := RespCenter."Name 2";
                PurchaseHeader."Ship-to Address" := RespCenter.Address;
                PurchaseHeader."Ship-to Address 2" := RespCenter."Address 2";
                PurchaseHeader."Ship-to City" := RespCenter.City;
                PurchaseHeader."Ship-to Post Code" := RespCenter."Post Code";
                PurchaseHeader."Ship-to County" := RespCenter.County;
                PurchaseHeader."Ship-to Country/Region Code" := RespCenter."Country/Region Code";
                PurchaseHeader."Ship-to Contact" := RespCenter.Contact;
            END;

        end;

    end;


    var

        RespCenter: Record 5714;

        NVM: Codeunit 50021;
        SoftBlockError: Text[80];

}