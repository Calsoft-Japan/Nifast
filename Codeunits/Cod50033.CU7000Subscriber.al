codeunit 50033 CU7000Subscriber
{
    //Version NAVW18.00,NV4.35,NIF1.050,NIF.N15.C9IN.001;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Price Calc. Mgt.", OnFindSalesLinePriceOnItemTypeOnAfterSetUnitPrice, '', false, false)]
    local procedure OnFindSalesLinePriceOnItemTypeOnAfterSetUnitPrice(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var TempSalesPrice: Record "Sales Price" temporary; CalledByFieldNo: Integer; FoundSalesPrice: Boolean)
    begin
        //TODO
        SalesLine."Customer Bin" := TempSalesPrice."Default Customer Bin Code"; //07/30/15 by CIS.RAM Added Default Bin code field
        //TODO
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Price Calc. Mgt.", OnBeforeFindSalesPrice, '', false, false)]
    local procedure OnBeforeFindSalesPrice(var ToSalesPrice: Record "Sales Price"; var FromSalesPrice: Record "Sales Price"; var QtyPerUOM: Decimal; var Qty: Decimal; var CustNo: Code[20]; var ContNo: Code[20]; var CustPriceGrCode: Code[10]; var CampaignNo: Code[20]; var ItemNo: Code[20]; var VariantCode: Code[10]; var UOM: Code[10]; var CurrencyCode: Code[10]; var StartingDate: Date; var ShowAll: Boolean)
    begin
        //>> NV #9752
        FromSalesPrice.SETRANGE("Contract No.", '');
        //<< NV #9752
    end;

    var
        Item: Record Item;
        TempSalesPrice: Record "Sales Price" temporary;
        SalesPriceCalcMgmtCu: Codeunit "Sales Price Calc. Mgt.";
        // FoundSalesPrice: Boolean;
        DateCaption: Text[30];

    PROCEDURE "<<NV>>"();
    BEGIN
    END;

    PROCEDURE SalesLineContractPriceExists(SalesHeader: Record 36; VAR SalesLine: Record 37; ShowAll: Boolean): Boolean;
    BEGIN
        //TODO
        //WITH SalesLine DO
        IF (SalesLine.Type = SalesLine.Type::Item) AND Item.GET(SalesLine."No.") THEN BEGIN
            FindContractSalesPrice(
              TempSalesPrice, SalesLine."Sell-to Customer No.", SalesLine."Contract No.",
              SalesLine."Customer Price Group", '', SalesLine."No.", SalesLine."Variant Code", SalesLine."Unit of Measure Code",
              SalesHeader."Currency Code", SalesPriceCalcMgmtCu.SalesHeaderStartDate(SalesHeader, DateCaption), ShowAll);
            EXIT(TempSalesPrice.FIND('-'));
        END;
        EXIT(FALSE);
        //TODO
    END;

    PROCEDURE FindContractSalesPrice(VAR ToSalesPrice: Record 7002; CustNo: Code[20]; ContractNo: Code[20]; CustPriceGrCode: Code[10]; CampaignNo: Code[20]; ItemNo: Code[20]; VariantCode: Code[10]; UOM: Code[10]; CurrencyCode: Code[10]; StartingDate: Date; ShowAll: Boolean);
    VAR
        FromSalesPrice: Record 7002;
    //  TempTargetCampaignGr: Record 7030 TEMPORARY;
    BEGIN
        //  WITH FromSalesPrice DO BEGIN
        FromSalesPrice.SETRANGE("Item No.", ItemNo);
        FromSalesPrice.SETFILTER("Variant Code", '%1|%2', VariantCode, '');
        FromSalesPrice.SETFILTER("Ending Date", '%1|>=%2', 0D, StartingDate);
        IF NOT ShowAll THEN BEGIN
            FromSalesPrice.SETFILTER("Currency Code", '%1|%2', CurrencyCode, '');
            FromSalesPrice.SETFILTER("Unit of Measure Code", '%1|%2', UOM, '');
            FromSalesPrice.SETRANGE("Starting Date", 0D, StartingDate);
        END;

        ToSalesPrice.RESET();
        ToSalesPrice.DELETEALL();

        FromSalesPrice.SETRANGE("Sales Type", FromSalesPrice."Sales Type"::Customer);
        FromSalesPrice.SETRANGE("Sales Code", CustNo);
        FromSalesPrice.SETRANGE("Contract No.", ContractNo);
        CopySalesPriceToSalesPrice(FromSalesPrice, ToSalesPrice);
        //  END;
    END;

    //The local method 'CalcContractUnitPrice' is declared but never used so commented it

    // LOCAL PROCEDURE CalcContractUnitPrice(VAR SalesPrice: Record 7002; VAR SalesLine: Record 37);
    // VAR
    //     BestSalesPrice: Record 7002;
    //     ">>NIF_LV": Integer;
    //     SalesHeader: Record 36;
    // BEGIN
    //     WITH SalesPrice DO BEGIN
    //         FoundSalesPrice := FIND('-');
    //         IF FoundSalesPrice THEN
    //             REPEAT
    //                 IF IsInMinQty("Unit of Measure Code", "Minimum Quantity") THEN BEGIN
    //                     SalesPriceCalcMgmtCu.ConvertPriceToVAT(
    //                       "Price Includes VAT", Item."VAT Prod. Posting Group",
    //                       "VAT Bus. Posting Gr. (Price)", "Unit Price");
    //                     ConvertPriceToUoM("Unit of Measure Code", "Unit Price");
    //                     SalesPriceCalcMgmtCu.ConvertPriceLCYToFCY("Currency Code", "Unit Price");

    //                     CASE TRUE OF
    //                         ((BestSalesPrice."Currency Code" = '') AND ("Currency Code" <> '')) OR
    //                       ((BestSalesPrice."Variant Code" = '') AND ("Variant Code" <> '')):
    //                             BestSalesPrice := SalesPrice;
    //                         ((BestSalesPrice."Currency Code" = '') OR ("Currency Code" <> '')) AND
    //                       ((BestSalesPrice."Variant Code" = '') OR ("Variant Code" <> '')):
    //                             IF (BestSalesPrice."Unit Price" = 0) OR
    //                                (CalcLineAmount(BestSalesPrice) > CalcLineAmount(SalesPrice))
    //                             THEN
    //                                 BestSalesPrice := SalesPrice;
    //                     END;
    //                 END;
    //             UNTIL NEXT() = 0;
    //     END;

    //    
    //     /*   //if not found price, then blank out contract
    //       IF NOT FoundSalesPrice THEN BEGIN
    //           //>> NIF 07-26-05 RTT
    //           //  SalesLine."Contract No." := '';

    //           SalesLine."Contract No." := '';
    //           SalesHeader.GET(SalesLine."Document Type", SalesLine."Document No.");
    //           IF SalesHeader."Contract No." <> '' THEN
    //               MESSAGE('Warning: No contract price was found for Item %1, Contract %2',
    //                         SalesLine."No.", SalesHeader."Contract No.");
    //       END;
    //       //<< NIF 07-26-05 RTT */

    //     // No price found in agreement
    //     IF BestSalesPrice."Unit Price" = 0 THEN BEGIN
    //         SalesPriceCalcMgmtCu.ConvertPriceToVAT(
    //           Item."Price Includes VAT", Item."VAT Prod. Posting Group",
    //           Item."VAT Bus. Posting Gr. (Price)", Item."Unit Price");
    //         ConvertPriceToUoM('', Item."Unit Price");
    //         SalesPriceCalcMgmtCu.ConvertPriceLCYToFCY('', Item."Unit Price");

    //         CLEAR(BestSalesPrice);
    //         BestSalesPrice."Unit Price" := Item."Unit Price";
    //         BestSalesPrice."Allow Line Disc." := AllowLineDisc;
    //         BestSalesPrice."Allow Invoice Disc." := AllowInvDisc;
    //     END;

    //     SalesPrice := BestSalesPrice;
    // END;

    // local procedure IsInMinQty(UnitofMeasureCode: Code[10]; MinQty: Decimal): Boolean
    // begin
    //     if UnitofMeasureCode = '' then
    //         exit(MinQty <= QtyPerUOM * Qty);
    //     exit(MinQty <= Qty);
    // end;

    // local procedure ConvertPriceToUoM(UnitOfMeasureCode: Code[10]; var UnitPrice: Decimal)
    // begin
    //     if UnitOfMeasureCode = '' then
    //         UnitPrice := UnitPrice * QtyPerUOM;
    // end;

    // local procedure CalcLineAmount(SalesPrice: Record "Sales Price") LineAmount: Decimal
    // begin
    //     if SalesPrice."Allow Line Disc." then
    //         LineAmount := SalesPrice."Unit Price" * (1 - LineDiscPerCent / 100)
    //     else
    //         LineAmount := SalesPrice."Unit Price";
    // end;

    local procedure CopySalesPriceToSalesPrice(var FromSalesPrice: Record "Sales Price"; var ToSalesPrice: Record "Sales Price")
    begin
        if FromSalesPrice.FindSet() then
            repeat
                ToSalesPrice := FromSalesPrice;
                ToSalesPrice.Insert();
            until FromSalesPrice.Next() = 0;
    end;

}