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
        IF SalesSetup."LAX Enable Shipping" AND NOT RunFromEship THEN
            NameAndAddressMgt.CheckNameAddressSalesHeader(SalesHeader, SalesHeader."Shipping Agent Code");
        // << Shipping

    end;

    [EventSubscriber(ObjectType::Codeunit, 414, 'OnAfterReleaseSalesDoc', '', True, false)]
    local procedure OnAfterReleaseSalesDoc(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var LinesWereModified: Boolean; SkipWhseRequestOperations: Boolean)
    begin
        // >> Shipping
        SalesSetup.Get();
        IF (SalesSetup."LAX Enable E-Mail") and (NOT RunFromEship) THEN
            EMailMgt.SendSalesConfirmation(SalesHeader, FALSE, FALSE);
        // << Shipping

        // >> EDI
        IF (SalesHeader."LAX EDI Order") and (SalesHeader."LAX EDI Cancellation Request") and (NOT RunFromEship) THEN
            ERROR(Text14000351);
        // << EDI
    end;


    PROCEDURE SetCalledFromSalesOrder();
    BEGIN
        CalledFromSalesOrder := TRUE
    END;

    PROCEDURE CheckInspection(SalesHeader: Record 36);
    VAR
        SalesLotEntry: Record 50002;
        LotCount: Integer;
        PromptText: Text[100];
    BEGIN
        SalesLotEntry.GetSalesLines(SalesHeader."Document Type", SalesHeader."No.");
        COMMIT;
        SalesLotEntry.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLotEntry.SETRANGE("Document No.", SalesHeader."No.");
        SalesLotEntry.SETFILTER("Lot No.", '<>%1', '');
        SalesLotEntry.SETRANGE("Inspected Parts", FALSE);

        IF SalesLotEntry.ISEMPTY THEN
            EXIT;

        LotCount := SalesLotEntry.COUNT;

        IF LotCount = 1 THEN
            PromptText := STRSUBSTNO('There is %1 lot for this order that has not been inspected.', LotCount)
        ELSE
            PromptText := STRSUBSTNO('There are %1 lots for this order that have not been inspected.', LotCount);

        IF NOT CONFIRM(PromptText + '\' + 'Do you want to continue?') THEN
            ERROR('Operation Canceled.');
    END;

    PROCEDURE UpdateCrossReferences(SalesHeader: Record 36);
    VAR
        SalesLine: Record 37;
        ItemCrossRef: Record "Item Reference";
        PackingRule: Record 14000715;
    BEGIN
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        SalesLine.SETFILTER("No.", '<>%1', '');

        IF SalesLine.FIND('-') THEN
            REPEAT
                ItemCrossRef.SETRANGE("Item No.", SalesLine."No.");
                ItemCrossRef.SETRANGE("Variant Code", SalesLine."Variant Code");
                ItemCrossRef.SETRANGE("Unit of Measure", SalesLine."Unit of Measure Code");
                ItemCrossRef.SETRANGE("Reference Type", ItemCrossRef."Reference Type"::Customer);
                ItemCrossRef.SETRANGE("Reference Type No.", SalesLine."Sell-to Customer No.");
                IF NOT ItemCrossRef.FIND('-') THEN
                    ItemCrossRef.SETRANGE("Unit of Measure");
                IF ItemCrossRef.FIND('-') THEN BEGIN
                    // SalesLine."Cross-Reference No." := ItemCrossRef."Reference No.";
                    // SalesLine."Cross-Reference Type" := SalesLine."Cross-Reference Type"::Customer;
                    // SalesLine."Cross-Reference Type No." := ItemCrossRef."Cross-Reference Type No.";
                    // SalesLine.MODIFY;//TODO
                    //>> RTT 07-22-05 if ASN customer, use customer part number
                    //END;
                END ELSE BEGIN
                    PackingRule.GetPackingRule(0, SalesHeader."Sell-to Customer No.", SalesHeader."Ship-to Code");  //0=customer
                    IF (PackingRule."ASN Summary Type" <> PackingRule."ASN Summary Type"::" ") THEN BEGIN
                        // SalesLine."Cross-Reference No." := SalesLine."No.";//TODO
                        SalesLine.MODIFY;
                    END;
                END;
            //<< RTT 07-22-05 if ASN customer, use customer part number
            UNTIL SalesLine.NEXT = 0;
    END;

    PROCEDURE CheckDuplItems(SalesHeader: Record 36);
    VAR
        SalesLine: Record 37;
        SalesLine2: Record 37;
        PackingRule: Record 14000715;
    BEGIN
        //exit if non-ASN customer
        PackingRule.GetPackingRule(0, SalesHeader."Sell-to Customer No.", SalesHeader."Ship-to Code");  //0=customer
        IF (PackingRule."ASN Summary Type" = PackingRule."ASN Summary Type"::" ") THEN
            EXIT;

        IF SalesHeader."Document Type" <> SalesHeader."Document Type"::"Credit Memo" THEN BEGIN //019-CIS.Ram Added this one line
            SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
            SalesLine.SETRANGE("Document No.", SalesHeader."No.");
            SalesLine.SETRANGE(Type, SalesLine.Type::Item);
            SalesLine.SETFILTER("Outstanding Quantity", '<>%1', 0);
            IF SalesLine.FIND('-') THEN
                REPEAT
                    SalesLine2.RESET;
                    SalesLine2.COPYFILTERS(SalesLine);
                    SalesLine2.SETRANGE("No.", SalesLine."No.");
                    SalesLine2.SETFILTER("Line No.", '<>%1', SalesLine."Line No.");
                    IF SalesLine2.FIND('-') THEN
                        ERROR('Duplicate Item %1 found for Sales Order %2.', SalesLine2."No.", SalesLine2."Document No.");
                UNTIL SalesLine.NEXT = 0;
        END; //019-CIS.Ram Added this one line
    END;

    // LOCAL PROCEDURE "---NFS1.01---"();
    // BEGIN
    // END;

    PROCEDURE CheckForMissingUOM(SalesHeader: Record 36);
    VAR
        SalesLineRecLcl: Record 37;
    BEGIN
        WITH SalesHeader DO BEGIN
            SalesLineRecLcl.RESET;
            SalesLineRecLcl.SETRANGE("Document Type", "Document Type");
            SalesLineRecLcl.SETRANGE("Document No.", "No.");
            SalesLineRecLcl.SETRANGE(Type, SalesLineRecLcl.Type::Item);
            SalesLineRecLcl.SETFILTER("No.", '<>%1', '');
            IF SalesLineRecLcl.FINDSET THEN
                REPEAT
                    SalesLineRecLcl.TESTFIELD("Unit of Measure Code");
                UNTIL SalesLineRecLcl.NEXT = 0;
        END;
    END;



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

        CalledFromSalesOrder: Boolean;

}