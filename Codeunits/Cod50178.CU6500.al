codeunit 50178 CU_6500
{
    // [EventSubscriber(ObjectType::Codeunit, 6500, 'OnBeforeTempHandlingSpecificationInsert', '', True, false)]
    // local procedure OnBeforeTempHandlingSpecificationInsert(var TempTrackingSpecification: Record "Tracking Specification" temporary; ReservationEntry: Record "Reservation Entry"; var ItemTrackingCode: Record "Item Tracking Code"; var EntriesExist: Boolean)
    // begin
    //     //WC1.01.Begin
    //     IF TempTrackingSpecification."Qty. to Handle (Base)" <> 0 THEN;
    //     //WWC1.01.End 
    // end;


    PROCEDURE AssistEditLotSerialNo2(VAR LotEntry: Record 50002 TEMPORARY; SearchForSupply: Boolean; CurrentSignFactor: Integer; LookupMode: Option "Serial No.","Lot No."; MaxQuantity: Decimal): Boolean;
    VAR
        ItemLedgEntry: Record 32;
        ReservEntry: Record 337;
        TempReservEntry: Record 337 TEMPORARY;
        TempEntrySummary: Record 338 TEMPORARY;
        //">>NIF_LV": Integer;
        LotNoInfo: Record 6505;
        InsertRec: Boolean;
        //AvailabilityDate: Date;
        Window: Dialog;
        LastEntryNo: Integer;
        ItemTrackingSummaryForm: Page 50022;
    BEGIN
        //NV code was commented
        SearchForSupply := TRUE;
        CurrentSignFactor := -1;
        LookupMode := LookupMode::"Lot No.";

        Window.OPEN(Text004);
        TempReservEntry.RESET();
        TempReservEntry.DELETEALL();
        ReservEntry.RESET();
        ReservEntry.SETCURRENTKEY("Item No.", "Variant Code", "Location Code",
          "Source Type", "Source Subtype", "Reservation Status", "Expected Receipt Date");
        ReservEntry.SETRANGE("Reservation Status",
          ReservEntry."Reservation Status"::Reservation, ReservEntry."Reservation Status"::Surplus);
        ReservEntry.SETRANGE("Item No.", LotEntry."Item No.");
        ReservEntry.SETRANGE("Variant Code", LotEntry."Variant Code");
        ReservEntry.SETRANGE("Location Code", LotEntry."Location Code");

        ItemLedgEntry.RESET();
        ItemLedgEntry.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date");
        ItemLedgEntry.SETRANGE("Item No.", LotEntry."Item No.");
        ItemLedgEntry.SETRANGE("Variant Code", LotEntry."Variant Code");
        ItemLedgEntry.SETRANGE(Open, TRUE);
        ItemLedgEntry.SETRANGE("Location Code", LotEntry."Location Code");

        CASE LookupMode OF
            LookupMode::"Serial No.":
                BEGIN
                    IF MaxQuantity <> 0 THEN
                        MaxQuantity := MaxQuantity / ABS(MaxQuantity); // Set to a signed value of 1.
                    ItemLedgEntry.SETFILTER("Serial No.", '<>%1', '');
                    ReservEntry.SETFILTER("Serial No.", '<>%1', '');
                END;
            LookupMode::"Lot No.":
                BEGIN
                    ItemLedgEntry.SETFILTER("Lot No.", '<>%1', '');
                    ReservEntry.SETFILTER("Lot No.", '<>%1', '');
                END;
        END;

        IF ItemLedgEntry.FIND('-') THEN
            REPEAT
                // {//x
                // IF SalesLotEntry."Bin Code" <> '' THEN BEGIN
                //             InsertRec := FALSE;
                //             WarehouseEntry.RESET;
                //             WarehouseEntry.SETCURRENTKEY(
                //               "Item No.", "Bin Code", "Location Code", "Variant Code",
                //               "Unit of Measure Code", "Lot No.", "Serial No.");
                //             WarehouseEntry.SETRANGE("Item No.", SalesLotEntry."Item No.");
                //             WarehouseEntry.SETRANGE("Bin Code", SalesLotEntry."Bin Code");
                //             WarehouseEntry.SETRANGE("Location Code", SalesLotEntry."Location Code");
                //             WarehouseEntry.SETRANGE("Variant Code", SalesLotEntry."Variant Code");
                //             CASE LookupMode OF
                //                 LookupMode::"Serial No.":
                //                     WarehouseEntry.SETRANGE("Serial No.", ItemLedgEntry."Serial No.");
                //                 LookupMode::"Lot No.":
                //                     WarehouseEntry.SETRANGE("Lot No.", ItemLedgEntry."Lot No.");
                //             END;
                //             WarehouseEntry.CALCSUMS("Qty. (Base)");
                //             IF WarehouseEntry."Qty. (Base)" > 0 THEN
                //                 InsertRec := TRUE;
                //         END ELSE
                //             //x}
                InsertRec := TRUE;
                TempReservEntry.INIT();
                TempReservEntry."Entry No." := -ItemLedgEntry."Entry No.";
                TempReservEntry."Reservation Status" := ReservEntry."Reservation Status"::Surplus;
                TempReservEntry.Positive := ItemLedgEntry.Positive;
                TempReservEntry."Item No." := ItemLedgEntry."Item No.";
                TempReservEntry."Location Code" := ItemLedgEntry."Location Code";
                TempReservEntry."Quantity (Base)" := ItemLedgEntry."Remaining Quantity";
                TempReservEntry."Source Type" := DATABASE::"Item Ledger Entry";
                TempReservEntry."Source Ref. No." := ItemLedgEntry."Entry No.";
                TempReservEntry."Serial No." := ItemLedgEntry."Serial No.";
                TempReservEntry."Lot No." := ItemLedgEntry."Lot No.";
                TempReservEntry."Variant Code" := ItemLedgEntry."Variant Code";
                // TempReservEntry."Mfg. Lot No." := ItemLedgEntry."External Lot No.";
                IF TempReservEntry.Positive THEN BEGIN
                    TempReservEntry."Warranty Date" := ItemLedgEntry."Warranty Date";
                    TempReservEntry."Expiration Date" := ItemLedgEntry."Expiration Date";
                    TempReservEntry."Expected Receipt Date" := 0D
                END ELSE
                    TempReservEntry."Shipment Date" := 99991231D;
                IF InsertRec THEN
                    TempReservEntry.INSERT();
            UNTIL ItemLedgEntry.NEXT() = 0;

        IF ReservEntry.FIND('-') THEN
            REPEAT
                TempReservEntry := ReservEntry;
                TempReservEntry.INSERT();
            UNTIL ReservEntry.NEXT() = 0;

        IF TempReservEntry.FIND('-') THEN
            REPEAT
                CASE LookupMode OF
                    LookupMode::"Serial No.":
                        TempEntrySummary.SETRANGE("Serial No.", TempReservEntry."Serial No.");
                    LookupMode::"Lot No.":
                        TempEntrySummary.SETRANGE("Lot No.", TempReservEntry."Lot No.");
                END;
                IF NOT TempEntrySummary.FIND('-') THEN BEGIN
                    TempEntrySummary.INIT();
                    TempEntrySummary."Entry No." := LastEntryNo + 1;
                    LastEntryNo := TempEntrySummary."Entry No.";
                    TempEntrySummary."Table ID" := TempReservEntry."Source Type";
                    TempEntrySummary."Summary Type" := '';
                    TempEntrySummary."Lot No." := TempReservEntry."Lot No.";
                    IF LookupMode = LookupMode::"Serial No." THEN
                        TempEntrySummary."Serial No." := TempReservEntry."Serial No.";
                    //>> NIF 07-10-05 RTT
                    //get lot info fields
                    IF LotNoInfo.GET(LotEntry."Item No.", LotEntry."Variant Code", TempReservEntry."Lot No.") THEN BEGIN
                        TempEntrySummary."Mfg. Lot No." := LotNoInfo."Mfg. Lot No.";
                        TempEntrySummary."Revision No." := LotNoInfo."Revision No.";
                    END;
                    //<< NIF 07-10-05 RTT

                    TempEntrySummary.INSERT();
                END;

                IF TempReservEntry.Positive THEN BEGIN
                    TempEntrySummary."Warranty Date" := TempReservEntry."Warranty Date";
                    TempEntrySummary."Expiration Date" := TempReservEntry."Expiration Date";
                    IF TempReservEntry."Entry No." < 0 THEN
                        TempEntrySummary."Total Quantity" += TempReservEntry."Quantity (Base)";
                    IF TempReservEntry."Reservation Status" = TempReservEntry."Reservation Status"::Reservation THEN
                        TempEntrySummary."Total Reserved Quantity" += TempReservEntry."Quantity (Base)";
                END ELSE BEGIN
                    TempEntrySummary."Total Requested Quantity" -= TempReservEntry."Quantity (Base)";
                    IF (TempReservEntry."Reservation Status" = TempReservEntry."Reservation Status"::Reservation) AND
                       (
                       ((LotEntry."Document Type" <> LotEntry."Document Type"::"Transfer Order") AND
                       (TempReservEntry."Source Type" = DATABASE::"Sales Line") AND
                       (TempReservEntry."Source Subtype" = LotEntry."Document Type") AND
                       (TempReservEntry."Source ID" = LotEntry."Document No.") AND
                       (TempReservEntry."Source Ref. No." = LotEntry."Order Line No."))
                       OR
                       ((LotEntry."Document Type" = LotEntry."Document Type"::"Transfer Order") AND
                       (TempReservEntry."Source Type" = DATABASE::"Transfer Line") AND
                       (TempReservEntry."Source Subtype" = 0) AND
                       (TempReservEntry."Source ID" = LotEntry."Document No.") AND
                       (TempReservEntry."Source Ref. No." = LotEntry."Order Line No."))
                       )
                     THEN
                        TempEntrySummary."Current Reserved Quantity" -= TempReservEntry."Quantity (Base)";
                END;

                TempEntrySummary."Total Available Quantity" :=
                  TempEntrySummary."Total Quantity" -
                  TempEntrySummary."Total Requested Quantity" +
                  TempEntrySummary."Current Reserved Quantity";
                TempEntrySummary.MODIFY();
            UNTIL TempReservEntry.NEXT() = 0;

        TempEntrySummary.RESET();

        // ItemTrackingSummaryForm.SetSource(TempReservEntry, TempEntrySummary);//TODO
        ItemTrackingSummaryForm.LOOKUPMODE(SearchForSupply);
        //xTempEntrySummary.SETRANGE("Serial No.",LotEntry."Serial No.");
        TempEntrySummary.SETRANGE("Lot No.", LotEntry."Lot No.");
        IF TempEntrySummary.FIND('-') THEN
            ItemTrackingSummaryForm.SETRECORD(TempEntrySummary);
        TempEntrySummary.RESET();
        Window.CLOSE();
        IF ItemTrackingSummaryForm.RUNMODAL = ACTION::LookupOK THEN BEGIN
            ItemTrackingSummaryForm.GETRECORD(TempEntrySummary);
            //xSalesLotEntry."Serial No." := TempEntrySummary."Serial No.";
            LotEntry.VALIDATE("Lot No.", TempEntrySummary."Lot No.");
            //>> istrtt 01-11-05 9488
            LotEntry."External Lot No." := TempEntrySummary."Mfg. Lot No.";
            LotEntry."Expiration Date" := TempEntrySummary."Expiration Date";
            //<< istrtt 01-11-05 9488

            IF ((CurrentSignFactor < 0) AND SearchForSupply) THEN
                LotEntry.VALIDATE(Quantity,
                  MinValueAbs(TempEntrySummary."Total Available Quantity", MaxQuantity))
            ELSE
                LotEntry.VALIDATE(Quantity,
                  MinValueAbs(-TempEntrySummary."Total Available Quantity", MaxQuantity));
        END;
    END;

    PROCEDURE AssistEditLotSerialNoWMS(VAR LotEntry: Record 50002; MaxQuantity: Decimal);
    VAR
        Item: Record 27;
        TempLotBinContent: Record 50001 TEMPORARY;
        LotEntry2: Record 50002;
        NVM: Codeunit 50021;
        ItemTrackingSummaryForm: Page 50022;
    BEGIN
        Item.GET(LotEntry."Item No.");
        Item.SETRANGE("Location Filter", LotEntry."Location Code");
        Item.GetLotBinContents(TempLotBinContent);
        //>> 07-10-05
        IF LotEntry."Use Revision No." <> '' THEN
            TempLotBinContent.SETRANGE("Revision No.", LotEntry."Use Revision No.");
        //<< 07-10-05
        TempLotBinContent.SETFILTER("Bin Type Code", NVM.GetBinTypeFilter(3));

        ItemTrackingSummaryForm.SetSources(TempLotBinContent);
        ItemTrackingSummaryForm.LOOKUPMODE(TRUE);
        IF TempLotBinContent.FIND('-') THEN
            ItemTrackingSummaryForm.SETRECORD(TempLotBinContent);
        TempLotBinContent.RESET();

        IF ItemTrackingSummaryForm.RUNMODAL() = ACTION::LookupOK THEN BEGIN
            ItemTrackingSummaryForm.GETRECORD(TempLotBinContent);

            //>> ISTRTT 9638 02-04-05
            IF (TempLotBinContent."Block Movement" = TempLotBinContent."Block Movement"::Outbound) OR
                 (TempLotBinContent."Block Movement" = TempLotBinContent."Block Movement"::All) THEN
                ERROR('You cannot pick from Bin %1 for Item %2.\' +
                        'Block Movement = %3', TempLotBinContent."Bin Code",
                          TempLotBinContent."Item No.", TempLotBinContent."Block Movement");
            //<< ISTRTT 9638 02-04-05

            //make sure it isn't already on another line
            LotEntry2.SETRANGE("Document Type", LotEntry."Document Type");
            LotEntry2.SETRANGE("Document No.", LotEntry."Document No.");
            LotEntry2.SETRANGE("Order Line No.", LotEntry."Order Line No.");
            LotEntry2.SETFILTER("Line No.", '<>%1', LotEntry."Line No.");
            LotEntry2.SETRANGE("Lot No.", TempLotBinContent."Lot No.");
            IF LotEntry2.FIND('-') THEN
                ERROR('This lot has already been selected.');

            LotEntry.VALIDATE("Lot No.", TempLotBinContent."Lot No.");
            LotEntry."Expiration Date" := TempLotBinContent."Expiration Date";
            LotEntry.VALIDATE(Quantity,
                 MinValueAbs(TempLotBinContent.CalcQtyAvailable(0), MaxQuantity));
        END;
    END;

    PROCEDURE AssistEditLotSerialWhsActvLn(VAR WhseActivityLine: Record 5767; MaxQuantity: Decimal);
    VAR
        Item: Record 27;
        TempLotBinContent: Record 50001 TEMPORARY;
        NVM: Codeunit 50021;
        ItemTrackingSummaryForm: Page 50022;
    BEGIN
        Item.GET(WhseActivityLine."Item No.");
        Item.SETRANGE("Location Filter", WhseActivityLine."Location Code");
        Item.GetLotBinContents(TempLotBinContent);
        TempLotBinContent.SETFILTER("Bin Type Code", NVM.GetBinTypeFilter(3));

        IF WhseActivityLine."Bin Code" <> '' THEN
            TempLotBinContent.SETRANGE("Bin Code", WhseActivityLine."Bin Code");

        IF WhseActivityLine."Lot No." <> '' THEN
            TempLotBinContent.SETRANGE("Lot No.", WhseActivityLine."Lot No.");

        ItemTrackingSummaryForm.SetSources(TempLotBinContent);
        ItemTrackingSummaryForm.LOOKUPMODE(TRUE);
        IF TempLotBinContent.FIND('-') THEN
            ItemTrackingSummaryForm.SETRECORD(TempLotBinContent);
        TempLotBinContent.RESET();

        IF ItemTrackingSummaryForm.RUNMODAL() = ACTION::LookupOK THEN BEGIN
            ItemTrackingSummaryForm.GETRECORD(TempLotBinContent);

            //>> ISTRTT 9638 02-04-05
            IF (TempLotBinContent."Block Movement" = TempLotBinContent."Block Movement"::Outbound) OR
                 (TempLotBinContent."Block Movement" = TempLotBinContent."Block Movement"::All) THEN
                ERROR('You cannot pick from Bin %1 for Item %2.\' +
                        'Block Movement = %3', TempLotBinContent."Bin Code",
                          TempLotBinContent."Item No.", TempLotBinContent."Block Movement");
            //<< ISTRTT 9638 02-04-05


            WhseActivityLine.VALIDATE("Lot No.", '');
            WhseActivityLine.VALIDATE("Bin Code", '');

            WhseActivityLine.VALIDATE("Lot No.", TempLotBinContent."Lot No.");
            WhseActivityLine.VALIDATE("Bin Code", TempLotBinContent."Bin Code");
            WhseActivityLine.VALIDATE("Expiration Date", TempLotBinContent."Expiration Date");
            WhseActivityLine.VALIDATE("Qty. to Handle",
                 MinValueAbs(TempLotBinContent.CalcQtyAvailable(0), MaxQuantity));
        END;
    END;

    PROCEDURE LotBinContentLookup(VAR Item: Record 27);
    VAR
        TempLotBinContent: Record 50001 TEMPORARY;
        ItemTrackingSummaryForm: Page 50022;
    BEGIN
        Item.GetLotBinContents(TempLotBinContent);

        ItemTrackingSummaryForm.SetSources(TempLotBinContent);
        ItemTrackingSummaryForm.LOOKUPMODE(TRUE);
        IF TempLotBinContent.FIND('-') THEN
            ItemTrackingSummaryForm.SETRECORD(TempLotBinContent);
        TempLotBinContent.RESET();

        ItemTrackingSummaryForm.RUN();
    END;

    PROCEDURE LotBinContentLookupBin(VAR Bin: Record 7354);
    VAR
        TempLotBinContent: Record 50001 TEMPORARY;
        ItemTrackingSummaryForm: Page 50022;
    BEGIN
        Bin.GetLotBinContents(TempLotBinContent);

        ItemTrackingSummaryForm.SetSources(TempLotBinContent);
        ItemTrackingSummaryForm.LOOKUPMODE(TRUE);
        IF TempLotBinContent.FIND('-') THEN
            ItemTrackingSummaryForm.SETRECORD(TempLotBinContent);
        TempLotBinContent.RESET();

        ItemTrackingSummaryForm.RUN();
    END;

    PROCEDURE LotBinContentLookupBin2(VAR Bin: Record 7354; VAR ItemNo: Code[20]; VAR LotNo: Code[20]; VAR UseQty: Decimal): Boolean;
    VAR
        TempLotBinContent: Record 50001 TEMPORARY;
        ItemTrackingSummaryForm: Page 50022;
    BEGIN
        Bin.GetLotBinContents(TempLotBinContent);

        ItemTrackingSummaryForm.SetSources(TempLotBinContent);
        ItemTrackingSummaryForm.LOOKUPMODE(TRUE);
        IF TempLotBinContent.FIND('-') THEN
            ItemTrackingSummaryForm.SETRECORD(TempLotBinContent);
        TempLotBinContent.RESET();

        IF ItemTrackingSummaryForm.RUNMODAL() = ACTION::LookupOK THEN BEGIN
            ItemTrackingSummaryForm.GETRECORD(TempLotBinContent);
            ItemNo := TempLotBinContent."Item No.";
            LotNo := TempLotBinContent."Lot No.";
            TempLotBinContent.CALCFIELDS(Quantity, "Pick Qty.", "Neg. Adjmt. Qty.");
            UseQty := TempLotBinContent.Quantity - TempLotBinContent."Pick Qty." - TempLotBinContent."Neg. Adjmt. Qty.";
            IF UseQty < 0 THEN
                UseQty := 0;

            EXIT(TRUE);
        END
        ELSE
            EXIT(FALSE);
    END;

    PROCEDURE LotBinContentLookupBin3(VAR TempLotBinContent: Record 50001 TEMPORARY; VAR BinCode: Code[10]; VAR ItemNo: Code[20]; VAR LotNo: Code[20]; VAR UseQty: Decimal): Boolean;
    VAR
        ItemTrackingSummaryForm: Page 50022;

    BEGIN
        //used for reclass
        ItemTrackingSummaryForm.SetSources(TempLotBinContent);
        ItemTrackingSummaryForm.LOOKUPMODE(TRUE);
        IF TempLotBinContent.FIND('-') THEN
            ItemTrackingSummaryForm.SETRECORD(TempLotBinContent);
        TempLotBinContent.RESET();

        IF ItemTrackingSummaryForm.RUNMODAL() = ACTION::LookupOK THEN BEGIN
            ItemTrackingSummaryForm.GETRECORD(TempLotBinContent);
            ItemNo := TempLotBinContent."Item No.";
            LotNo := TempLotBinContent."Lot No.";
            BinCode := TempLotBinContent."Bin Code";
            TempLotBinContent.CALCFIELDS(Quantity, "Pick Qty.", "Neg. Adjmt. Qty.");
            UseQty := TempLotBinContent.Quantity - TempLotBinContent."Pick Qty." - TempLotBinContent."Neg. Adjmt. Qty.";
            IF UseQty < 0 THEN
                UseQty := 0;

            EXIT(TRUE);
        END
        ELSE
            EXIT(FALSE);
    END;

    LOCAL PROCEDURE MinValueAbs(Value1: Decimal; Value2: Decimal): Decimal;
    BEGIN
        IF ABS(Value1) < ABS(Value2) THEN
            EXIT(Value1)
        ELSE
            EXIT(Value2);
    END;

    PROCEDURE CallPostedItemTrackingForm_gFnc(Type: Integer; Subtype: Integer; ID: Code[20]; BatchName: Code[10]; ProdOrderLine: Integer; RefNo: Integer; VAR TempItemLedgEntry_vRecTmp: Record 32 TEMPORARY): Boolean;
    VAR
        TempItemLedgEntry: Record 32 TEMPORARY;
        TrackingSpecification: Codeunit 6500;
    BEGIN
        //>> NF1.00:CIS.NG    09/12/16
        // Used when calling Item Tracking from Posted Shipments/Receipts:

        TempItemLedgEntry_vRecTmp.RESET;
        TempItemLedgEntry_vRecTmp.DELETEALL;

        //TrackingSpecification.RetrieveILEFromShptRcpt(TempItemLedgEntry, Type, Subtype, ID, BatchName, ProdOrderLine, RefNo);//LOCALFUNCTION IN BASE
        IF NOT TempItemLedgEntry.ISEMPTY THEN BEGIN
            TempItemLedgEntry_vRecTmp.COPY(TempItemLedgEntry, TRUE);
            EXIT(TRUE);
        END;
        EXIT(FALSE);
        //<< NF1.00:CIS.NG    09/12/16
    END;
    

    var
        Text004: Label 'ENU=Counting records...';

}
