codeunit 50047 CU5752Subscriber
{
    //Version NAVW17.10,NV4.17,NIF.N15.C9IN.001;
    var
        GetSourceDocuments: Report "Get Source Documents";
        Text001: Label 'If %1 is %2 in %3 no. %4, then all associated lines where type is %5 must use the same location.', Comment = '%1,%2,%3,%4,%5=Field value';
        Text002: Label 'The warehouse shipment was not created because the Shipping Advice field is set to Complete, and item no. %1 is not available in location code %2.\\You can create the warehouse shipment by either changing the Shipping Advice field to Partial in %3 no. %4 or by manually filling in the warehouse shipment document.', Comment = '%1,%2,%3,%4=values';

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Get Source Doc. Outbound", OnBeforeGetSourceDocForHeader, '', false, false)]
    local procedure OnBeforeGetSourceDocForHeader(var WarehouseShipmentHeader: Record "Warehouse Shipment Header"; var WarehouseRequest: Record "Warehouse Request"; var IsHandled: Boolean)
    begin
        IsHandled := true;

        //>> NF1.00:CIS.CM 09-29-15
        //SourceDocSelection.LOOKUPMODE(TRUE);
        //SourceDocSelection.SETTABLEVIEW(WhseRqst);
        //IF SourceDocSelection.RUNMODAL <> ACTION::LookupOK THEN
        //  EXIT;
        //SourceDocSelection.GetResult(WhseRqst);
        //<< NF1.00:CIS.CM 09-29-15

        GetSourceDocuments.SetOneCreatedShptHeader(WarehouseShipmentHeader);
        GetSourceDocuments.SetSkipBlocked(true);
        GetSourceDocuments.UseRequestPage(false);
        WarehouseRequest.SetRange("Location Code", WarehouseShipmentHeader."Location Code");
        GetSourceDocuments.SetTableView(WarehouseRequest);
        GetSourceDocuments.RunModal();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Get Source Doc. Outbound", OnBeforeCheckSalesLines, '', false, false)]
    local procedure OnBeforeCheckSalesLines(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; ShowError: Boolean; var Result: Boolean; var IsHandled: Boolean)
    var
        SalesOrder: Page "Sales Order";
        CurrItemNo: Code[20];
        QtyOutstandingBase: Decimal;
        RecordNo: Integer;
        TotalNoOfRecords: Integer;
        LocationCode: Code[10];
    begin
        IsHandled := true;

        if SalesLine.FindSet() then begin
            LocationCode := SalesLine."Location Code";
            CurrItemNo := SalesLine."No.";
            TotalNoOfRecords := SalesLine.Count();
            repeat
                RecordNo += 1;

                if SalesLine."Location Code" <> LocationCode then begin
                    if ShowError then
                        Error(Text001, SalesHeader.FieldCaption(SalesHeader."Shipping Advice"), SalesHeader."Shipping Advice",
                          SalesOrder.Caption, SalesHeader."No.", SalesLine.Type);
                    Result := true;
                end;

                IF SalesLine."No." = CurrItemNo THEN
                    QtyOutstandingBase += SalesLine."Outstanding Qty. (Base)"
                else begin
                    if CheckAvailability(
                         CurrItemNo, QtyOutstandingBase, SalesLine."Location Code",
                         SalesOrder.Caption(), Database::"Sales Line", SalesHeader."Document Type".AsInteger(), SalesHeader."No.", ShowError)
                    then
                        Result := true;
                    CurrItemNo := SalesLine."No.";
                    QtyOutstandingBase := SalesLine."Outstanding Qty. (Base)";
                end;
                if RecordNo = TotalNoOfRecords then
                    // last record
                    if CheckAvailability(
                         CurrItemNo, QtyOutstandingBase, SalesLine."Location Code",
                         SalesOrder.Caption(), Database::"Sales Line", SalesHeader."Document Type".AsInteger(), SalesHeader."No.", ShowError)
                    then
                        Result := true;
            until SalesLine.Next() = 0;
            // sorted by item
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Get Source Doc. Outbound", OnBeforeCheckTransferHeader, '', false, false)]
    local procedure OnBeforeCheckTransferHeader(var TransferHeader: Record "Transfer Header"; var ShowError: Boolean; var IsHandled: Boolean)
    var
    /*   TransferLine: Record "Transfer Line";
      CurrItemVariant: Record "Item Variant";
      TransferOrder: Page "Transfer Order";
      QtyOutstandingBase: Decimal;
      RecordNo: Integer;
      TotalNoOfRecords: Integer; */
    begin
        IsHandled := true;

        CheckTransferHeader(TransferHeader, ShowError)
    end;

    procedure CheckTransferHeader(TransferHeader: Record "Transfer Header"; ShowError: Boolean): Boolean
    var
        TransferLine: Record "Transfer Line";
        // CurrItemVariant: Record "Item Variant";
        TransferOrder: Page "Transfer Order";
        CurrItemNo: Code[20];
        QtyOutstandingBase: Decimal;
        RecordNo: Integer;
        TotalNoOfRecords: Integer;
    begin
        if TransferHeader."Shipping Advice" = TransferHeader."Shipping Advice"::Partial then
            exit(false);

        TransferLine.SetCurrentKey("Item No.");
        TransferLine.SetRange("Document No.", TransferHeader."No.");
        if TransferLine.FindSet() then begin
            CurrItemNo := TransferLine."Item No.";
            TotalNoOfRecords := TransferLine.Count();
            repeat
                RecordNo += 1;
                IF TransferLine."Item No." = CurrItemNo THEN
                    QtyOutstandingBase += TransferLine."Outstanding Qty. (Base)"
                else begin
                    IF CheckAvailability(
                    CurrItemNo, QtyOutstandingBase, TransferLine."Transfer-from Code", TransferOrder.CAPTION, DATABASE::"Transfer Line", 0,
                    TransferHeader."No.", ShowError)
                     then
                        // outbound
                        exit(true);
                    CurrItemNo := TransferLine."Item No.";
                    QtyOutstandingBase := TransferLine."Outstanding Qty. (Base)";
                end;
                if RecordNo = TotalNoOfRecords then
                    // last record
                    if CheckAvailability(
                         CurrItemNo, QtyOutstandingBase, TransferLine."Transfer-from Code",
                         TransferOrder.Caption(), Database::"Transfer Line", 0, TransferHeader."No.", ShowError)
                    then
                        // outbound
                        exit(true);
            until TransferLine.Next() = 0;
            // sorted by item
        end;
    end;

    procedure CheckAvailability(ItemNo: Code[20]; QtyBaseNeeded: Decimal; LocationCode: Code[10]; FormCaption: Text[1024]; SourceType: Integer; SourceSubType: Integer; SourceID: Code[20]; ShowError: Boolean): Boolean
    var
        Item: Record Item;
        ReservEntry: Record "Reservation Entry";
        ReservEntry2: Record "Reservation Entry";
        QtyReservedForOrder: Decimal;
        Result: Boolean;
        NotAvailable: Boolean;
        ErrorMessage: Text;
    begin
        Item.Get(ItemNo);
        Item.SetRange("Location Filter", LocationCode);
        Item.CalcFields(Inventory, "Reserved Qty. on Inventory");
        // find qty reserved for this order
        ReservEntry.SetSourceFilter(SourceType, SourceSubType, SourceID, -1, true);
        ReservEntry.SetRange("Item No.", ItemNo);
        ReservEntry.SetRange("Location Code", LocationCode);
        ReservEntry.SetRange("Reservation Status", ReservEntry."Reservation Status"::Reservation);
        if ReservEntry.FindSet() then
            repeat
                ReservEntry2.Get(ReservEntry."Entry No.", not ReservEntry.Positive);
                QtyReservedForOrder += ReservEntry2."Quantity (Base)";
            until ReservEntry.Next() = 0;

        NotAvailable := Item.Inventory - (Item."Reserved Qty. on Inventory" - QtyReservedForOrder) < QtyBaseNeeded;
        ErrorMessage := StrSubstNo(Text002, ItemNo, LocationCode, FormCaption, SourceID);
        if AfterCheckAvailability(NotAvailable, ShowError, ErrorMessage, Result) then
            exit(Result);
    end;

    local procedure AfterCheckAvailability(NotAvailable: Boolean; ShowError: Boolean; ErrorMessage: Text; var Result: Boolean): Boolean;
    begin
        if NotAvailable then begin
            if ShowError then
                Error(ErrorMessage);
            Result := true;
            exit(true);
        end;
    end;

}