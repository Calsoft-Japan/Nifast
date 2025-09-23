codeunit 50050 CU22Subscriber
{
    // Version NAVW18.00,NAVNA8.00,NV4.35,NIF1.062,NMX1.000,NIF.N15.C9IN.001,AKK1606.01;
    var
        // InvtSetup: Record "Inventory Setup";
        GLSetup: Record "General Ledger Setup";
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        MfgCostCalcMgt: Codeunit "Mfg. Cost Calculation Mgt.";

        SingleInstanceCu: Codeunit SingleInstance;
        // UOMMgt: Codeunit "Unit of Measure Management";
        /*  NVM: Codeunit 50021;
          ">>NIF": Integer;
          PostItemJnlLineBoo: Boolean;
          "//AKK1606.01--": Integer;
          wEntryDate: Date;
          wEntryDateApp: Date;
          wEntryText: Text[50];
          rItemLedEntry: Record 32; */
        wEntryNo: Code[20];
        wEntryDate2: Date;
        // wEntryNo2: Code[20];
        wEntryCode: Code[20];
    // "//AKK1606.01++": Integer;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnCheckPostingCostToGL, '', false, false)]
    local procedure OnCheckPostingCostToGL(var PostCostToGL: Boolean)
    begin
        //>> NF1.00:CIS.CM 09-29-15
        //>>NV
        //IF ("Entry Type"="Entry Type"::Sale) AND ("Serial No."<>'') AND
        //   (Item."Manufacturer Code"<>'') THEN BEGIN
        //   IF NOT Tool.GET(Item."Manufacturer Code","Serial No.") THEN BEGIN
        //    Tool.INIT;
        //    Tool."Manufacturer Code" := Item."Manufacturer Code";
        //    Tool."Serial No." := "Serial No.";
        //    Tool."Customer No." := "Source No.";
        //    Tool."Tool Model No." := Item."Vendor Item No.";
        //    Tool."Tool Item No." := "Item No.";
        //    Tool.Description := Item.Description;
        //    Tool."Orig. Sale Date" := "Posting Date";
        //    Tool."Vendor No." := Item."Vendor No.";
        //    Tool.INSERT;
        //   END;
        //END;
        //<<NV
        //<< NF1.00:CIS.CM 09-29-15
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnPostItemOnAfterGetSKU, '', false, false)]
    local procedure OnPostItemOnAfterGetSKU(var ItemJnlLine: Record "Item Journal Line"; var SKUExists: Boolean; var IsHandled: Boolean)
    begin
        //TODO
        /*  if InvtSetup.Get() then
             //>>NV
             IF (NOT SKUExists) AND (InvtSetup."Auto Create SKU") THEN
                 SKUExists := NVM.CreateSKU(ItemJnlLine."Item No.", ItemJnlLine."Location Code", ItemJnlLine."Variant Code");
         //<<NV */
        //TODO
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnPostItemOnBeforeCheckInventoryPostingGroup, '', false, false)]
    local procedure OnPostItemOnBeforeCheckInventoryPostingGroup(var ItemJnlLine: Record "Item Journal Line"; var CalledFromAdjustment: Boolean; var Item: Record Item; var ItemTrackingCode: Record "Item Tracking Code")
    begin
        //TODO
        /*   //>> NIF 07-10-05
          IF Item.GET(ItemJnlLine."Item No.") THEN
              IF NOT CalledFromAdjustment THEN
                  IF (Item."Require Revision No.") AND (ItemJnlLine."Revision No." = '') AND (ItemJnlLine."Item Charge No." = '') THEN
                      ERROR('%1 is required for %2.', ItemJnlLine.FIELDNAME("Revision No."), Item."No.");
          //<< NIF 07-10-05 */
        //TODO
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnPostFlushedConsumpOnAfterCalcQtyToPost, '', false, false)]
    local procedure OnPostFlushedConsumpOnAfterCalcQtyToPost(ProductionOrder: Record "Production Order"; ProdOrderLine: Record "Prod. Order Line"; ProdOrderComponent: Record "Prod. Order Component"; ActOutputQtyBase: Decimal; var QtyToPost: Decimal; var OldItemJournalLine: Record "Item Journal Line"; var ProdOrderRoutingLine: Record "Prod. Order Routing Line"; var CompItem: Record Item)
    var
        ProdOrderRtngLine: Record 5409;
        CalcBasedOn: Option "Actual Output","Expected Output";
    begin
        if ProdOrderComponent."Flushing Method" in
                  [ProdOrderComponent."Flushing Method"::Backward, ProdOrderComponent."Flushing Method"::"Pick + Backward"]
               then begin
            QtyToPost :=
               ROUND(MfgCostCalcMgt.CalcActNeededQtyBase(ProdOrderLine, ProdOrderComponent, ActOutputQtyBase) /
            ProdOrderComponent."Qty. per Unit of Measure", CompItem."Rounding Precision", '>');
            ProdOrderRtngLine.SETRANGE(Status, ProdOrderComponent.Status);
            ProdOrderRtngLine.SETRANGE("Prod. Order No.", ProdOrderComponent."Prod. Order No.");
            ProdOrderRtngLine.SETRANGE("Routing Reference No.", ProdOrderLine."Routing Reference No.");
            ProdOrderRtngLine.SETRANGE("Routing Link Code", ProdOrderComponent."Routing Link Code");
            IF ProdOrderRtngLine.FINDFIRST() THEN
                IF ProdOrderRtngLine."Flushing Method" <> ProdOrderRtngLine."Flushing Method"::Manual THEN
                    QtyToPost :=
                      ROUND(QtyToPost * (1 + ProdOrderRtngLine."Scrap Factor % (Accumulated)") +
                        ProdOrderRtngLine."Fixed Scrap Qty. (Accum.)", CompItem."Rounding Precision", '>')
        END ELSE
            QtyToPost := ROUND(ProdOrderComponent.GetNeededQty(CalcBasedOn::"Expected Output", TRUE), CompItem."Rounding Precision", '>');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnTestFirstApplyItemLedgEntryOnBeforeReservationPreventsApplication, '', false, false)]
    local procedure OnTestFirstApplyItemLedgEntryOnBeforeReservationPreventsApplication(OldItemLedgerEntry: Record "Item Ledger Entry"; ItemLedgerEntry: Record "Item Ledger Entry"; var IsHandled: Boolean);
    begin
        //TODO
        /*   //>>> NV
          ItemLedgerEntry."QC Hold" := OldItemLedgerEntry."QC Hold";
          //<<< NV */
        //TODO
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnAfterApplyItemLedgEntrySetFilters, '', false, false)]
    local procedure OnAfterApplyItemLedgEntrySetFilters(var ItemLedgerEntry2: Record "Item Ledger Entry"; ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line")
    begin
        //TODO
        /*  //>>> NV
         IF (ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::Sale) OR
            (ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::Transfer) OR
            (ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::"Negative Adjmt.") THEN
             ItemLedgerEntry2.SETRANGE("QC Hold", FALSE);
         //<<< NV */
        //TODO
        //SingleInstanceCu.SetItemLedgerEntry(ItemLedgerEntry2);//Balu
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnApplyItemLedgEntryOnBeforeOldItemLedgEntryModify, '', false, false)]
    local procedure OnApplyItemLedgEntryOnBeforeOldItemLedgEntryModify(var ItemLedgerEntry: Record "Item Ledger Entry"; var OldItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; var AverageTransfer: Boolean)
    var
        ItemLedgEntry2: Record "Item Ledger Entry";
    begin
        //SingleInstanceCu.GetItemLedgerEntry(ItemLedgEntry2);//Balu

        //-AKK1606.01--
        IF ItemLedgerEntry."Entry Type" = ItemLedgerEntry."Entry Type"::Transfer THEN BEGIN
            wEntryDate2 := OldItemLedgerEntry."Entry/Exit Date";
            wEntryNo := OldItemLedgerEntry."Entry/Exit No.";
            wEntryCode := OldItemLedgerEntry."Entry/Exit Point";
        END ELSE BEGIN
            wEntryDate2 := ItemLedgEntry2."Entry/Exit Date";
            wEntryNo := ItemLedgEntry2."Entry/Exit No.";
            wEntryCode := ItemLedgEntry2."Entry/Exit Point";
        END;
        //+AKK1606.01++

        Clear(SingleInstanceCu);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnInsertTransferEntryOnTransferValues, '', false, false)]
    local procedure OnInsertTransferEntryOnTransferValues(var NewItemLedgerEntry: Record "Item Ledger Entry"; OldItemLedgerEntry: Record "Item Ledger Entry"; ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; var TempItemEntryRelation: Record "Item Entry Relation"; var IsHandled: Boolean)
    begin
        //-AKK1606.01--
        IF NewItemLedgerEntry."Entry Type" = NewItemLedgerEntry."Entry Type"::Transfer THEN BEGIN
            NewItemLedgerEntry."Entry/Exit No." := OldItemLedgerEntry."Entry/Exit No.";
            NewItemLedgerEntry."Entry/Exit Date" := OldItemLedgerEntry."Entry/Exit Date";
            NewItemLedgerEntry."Entry/Exit Point" := OldItemLedgerEntry."Entry/Exit Point";
        END ELSE BEGIN
            NewItemLedgerEntry."Entry/Exit No." := ItemJournalLine."Entry/Exit No.";
            NewItemLedgerEntry."Entry/Exit Date" := ItemJournalLine."Entry/Exit Date";
        END;
        //+AKK1606.01++

        //TODO
        /*   //>>> NV
          NewItemLedgerEntry."QC Hold" := ItemJournalLine."QC Hold";
          NewItemLedgerEntry."QC Hold Reason Code" := ItemJournalLine."QC Hold Reason Code";
          //<<< NV */
        //TODO

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnBeforeInsertItemLedgEntry, '', false, false)]
    local procedure OnBeforeInsertItemLedgEntry(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; TransferItem: Boolean; OldItemLedgEntry: Record "Item Ledger Entry"; ItemJournalLineOrigin: Record "Item Journal Line")
    begin
        //-AKK1606.01--
        ItemLedgerEntry."Entry/Exit Point" := ItemJournalLine."Entry/Exit Point";
        ItemLedgerEntry."Entry/Exit Date" := ItemJournalLine."Entry/Exit Date";
        ItemLedgerEntry."Entry/Exit No." := ItemJournalLine."Entry/Exit No.";
        IF ItemLedgerEntry."Entry/Exit Date" = 0D THEN BEGIN
            ItemLedgerEntry."Entry/Exit Date" := wEntryDate2;
            ItemLedgerEntry."Entry/Exit No." := wEntryNo;
            ItemLedgerEntry."Entry/Exit Point" := wEntryCode;
        END;
        //+AKK1606.01++
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnAfterInsertTransferEntry, '', false, false)]
    local procedure OnAfterInsertTransferEntry(var ItemJournalLine: Record "Item Journal Line"; NewItemLedgerEntry: Record "Item Ledger Entry"; OldItemLedgerEntry: Record "Item Ledger Entry"; NewValueEntry: Record "Value Entry"; var ValueEntryNo: Integer)
    begin
        //>> NF1.00:CIS.CM 09-29-15
        //>>> NV
        //IF ItemJnlLine."QC Hold" THEN
        //  QCMgmt.ItemLedgEntryToQCDocument(ItemLedgEntry,ItemJnlLine."QC Reference No.",ItemJnlLine."QC Ref. Line No.");
        //<<< NV
        //<< NF1.00:CIS.CM 09-29-15
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnBeforeInsertApplEntry, '', false, false)]
    local procedure OnBeforeInsertApplEntry(var ItemLedgEntryNo: Integer; var InboundItemEntry: Integer; var OutboundItemEntry: Integer; var TransferedFromEntryNo: Integer; var PostingDate: Date; var Quantity: Decimal; var CostToApply: Boolean; var IsHandled: Boolean)
    begin
        //SingleInstanceCu.SetInboundandOutboundItemEntry(InboundItemEntry, OutboundItemEntry);//balu
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnBeforeItemApplnEntryInsert, '', false, false)]
    local procedure OnBeforeItemApplnEntryInsert(var ItemApplicationEntry: Record "Item Application Entry"; GlobalItemLedgerEntry: Record "Item Ledger Entry"; OldItemLedgerEntry: Record "Item Ledger Entry"; var ItemApplnEntryNo: Integer)
    var
        InboundItemEntry, OutboundItemEntry : Integer;
    begin
        //SingleInstanceCu.GetInboundandOutboundItemEntry(InboundItemEntry, OutboundItemEntry);//Balu
        /*    //-AKK1606.01--
         {
         IF TransferedFromEntryNo <> 0 THEN
             rInboundItemEntry.GET(TransferedFromEntryNo)
         ELSE IF rInboundItemEntry.GET(InboundItemEntry) THEN;
         ItemApplnEntry."Entry/Exit Point" := rInboundItemEntry."Entry/Exit Point";
         ItemApplnEntry."Entry/Exit No." := rInboundItemEntry."Entry/Exit No.";
         ItemApplnEntry."Entry/Exit Date" := rInboundItemEntry."Entry/Exit Date";
         } */
        //Se toma de la tabla OldItemLedgerEntry que en teor¡a es el mov producto de entrada.
        //Si es una entrada por "Deshacer env¡os" los datos se toman de la tabla GlobalItemLedgEntry
        IF GlobalItemLedgerEntry."Entry No." = InboundItemEntry THEN BEGIN
            ItemApplicationEntry."Entry/Exit Point" := GlobalItemLedgerEntry."Entry/Exit Point";
            ItemApplicationEntry."Entry/Exit No." := GlobalItemLedgerEntry."Entry/Exit No.";
            ItemApplicationEntry."Entry/Exit Date" := GlobalItemLedgerEntry."Entry/Exit Date";
        END ELSE BEGIN
            ItemApplicationEntry."Entry/Exit Point" := OldItemLedgerEntry."Entry/Exit Point";
            ItemApplicationEntry."Entry/Exit No." := OldItemLedgerEntry."Entry/Exit No.";
            ItemApplicationEntry."Entry/Exit Date" := OldItemLedgerEntry."Entry/Exit Date";
        END;
        //+AKK1606.01++
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnInitValueEntryOnAfterAssignFields, '', false, false)]
    local procedure OnInitValueEntryOnAfterAssignFields(var ValueEntry: Record "Value Entry"; ItemLedgEntry: Record "Item Ledger Entry"; ItemJnlLine: Record "Item Journal Line")
    begin
        //TODO
        /*   //>> NV #9752
          ValueEntry."Contract No." := ItemJnlLine."Contract No.";
          //<< NV #9752 */
        //TODO
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnAfterCalcPosShares, '', false, false)]
    local procedure OnAfterCalcPosShares(var ItemJournalLine: Record "Item Journal Line"; var DirCost: Decimal; var OvhdCost: Decimal; var PurchVar: Decimal; var DirCostACY: Decimal; var OvhdCostACY: Decimal; var PurchVarACY: Decimal; var CalcUnitCost: Boolean; CalcPurchVar: Boolean; Expected: Boolean; GlobalItemLedgerEntry: Record "Item Ledger Entry")
    begin
        if GLSetup.Get() then
            if GLSetup."Additional Reporting Currency" <> '' then
                //>>NIF 05-08-06 RTT
                IF ItemJournalLine."Source Currency Code" = GLSetup."Additional Reporting Currency" THEN
                    ItemJournalLine."Unit Cost (ACY)" := ItemJournalLine."Unit Cost"
                ELSE
                    IF ItemJournalLine."Tipo Cambio (ACY)" <> 0 THEN
                        if Currency.Get(GLSetup."Additional Reporting Currency") then
                            ItemJournalLine."Unit Cost (ACY)" := ROUND(ItemJournalLine."Unit Cost" / ItemJournalLine."Tipo Cambio (ACY)", Currency."Unit-Amount Rounding Precision")
                        else
                            ItemJournalLine."Unit Cost (ACY)" := Round(
                   CurrExchRate.ExchangeAmtLCYToFCY(
                     ItemJournalLine."Posting Date", GLSetup."Additional Reporting Currency", ItemJournalLine."Unit Cost",
                     CurrExchRate.ExchangeRate(
                       ItemJournalLine."Posting Date", GLSetup."Additional Reporting Currency")),
                   Currency."Unit-Amount Rounding Precision");
    end;
}