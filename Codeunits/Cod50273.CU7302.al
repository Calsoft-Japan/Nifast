codeunit 50273 CU_7302
{
    PROCEDURE CalcLineReservedQtyonInvt(SourceType: Integer; SourceSubType: Option; SourceNo: Code[20]; SourceLineNo: Integer; SourceSubLineNo: Integer; SerialNo: Code[20]; LotNo: Code[20]): Decimal;

    VAR

        ReservEntry: Record 337;

        ReservEntry2: Record 337;

        ReservQtyonInvt: Decimal;

    BEGIN

        ReservEntry.SETCURRENTKEY(

          "Source Type", "Source Subtype", "Source ID", "Source Batch Name",

          "Source Prod. Order Line", "Source Ref. No.", "Reservation Status");

        ReservEntry.SETRANGE(

          "Reservation Status", ReservEntry."Reservation Status"::Reservation);

        ReservEntry.SETRANGE("Source Type", SourceType);

        ReservEntry.SETRANGE("Source Subtype", SourceSubType);

        ReservEntry.SETRANGE("Source ID", SourceNo);

        ReservEntry.SETRANGE("Source Batch Name", '');

        IF SourceType = DATABASE::"Prod. Order Component" THEN BEGIN

            ReservEntry.SETRANGE("Source Prod. Order Line", SourceLineNo);

            ReservEntry.SETRANGE("Source Ref. No.", SourceSubLineNo);

        END ELSE BEGIN

            ReservEntry.SETRANGE("Source Prod. Order Line", 0);

            ReservEntry.SETRANGE("Source Ref. No.", SourceLineNo);

        END;

        IF SerialNo <> '' THEN
            ReservEntry.SETRANGE("Serial No.", SerialNo);

        IF LotNo <> '' THEN
            ReservEntry.SETRANGE("Lot No.", LotNo);

        IF ReservEntry.FIND('-') THEN
            REPEAT

                ReservEntry2.SETRANGE("Entry No.", ReservEntry."Entry No.");

                ReservEntry2.SETRANGE(Positive, TRUE);

                ReservEntry2.SETRANGE("Source Type", DATABASE::"Item Ledger Entry");

                ReservEntry2.SETRANGE(

                  "Reservation Status", ReservEntry2."Reservation Status"::Reservation);

                IF ReservEntry2.FIND('-') THEN
                    REPEAT

                        ReservQtyonInvt := ReservQtyonInvt + ReservEntry2."Quantity (Base)";

                    UNTIL ReservEntry2.NEXT = 0;

            UNTIL ReservEntry.NEXT = 0;

        EXIT(ReservQtyonInvt);

    END;

    // PROCEDURE CreateQCWhseJnlLine(ItemJnlLine: Record 83; ItemJnlTemplateType: Option; VAR WhseJnlLine: Record 7311; ToTransfer: Boolean; BOMPosting: Boolean): Boolean;

    // BEGIN

    //     //>>NV
    //     IF (NOT ItemJnlLine."Phys. Inventory") AND (ItemJnlLine.Quantity = 0) AND (ItemJnlLine."Invoiced Quantity" = 0) THEN
    //         EXIT(FALSE);

    //     IF ToTransfer THEN
    //         ItemJnlLine."Location Code" := ItemJnlLine."New Location Code";

    //     GetLocation(ItemJnlLine."Location Code");

    //     WhseJnlLine.INIT;

    //     WhseJnlLine."Journal Template Name" := ItemJnlLine."Journal Template Name";

    //     WhseJnlLine."Journal Batch Name" := ItemJnlLine."Journal Batch Name";

    //     WhseJnlLine."Location Code" := ItemJnlLine."Location Code";

    //     WhseJnlLine."Item No." := ItemJnlLine."Item No.";

    //     WhseJnlLine."Registering Date" := ItemJnlLine."Posting Date";

    //     WhseJnlLine."User ID" := USERID;

    //     WhseJnlLine."Variant Code" := ItemJnlLine."Variant Code";

    //     IF ((ItemJnlLine."Entry Type" IN

    //          [ItemJnlLine."Entry Type"::Purchase, ItemJnlLine."Entry Type"::"Positive Adjmt."]) AND

    //         (ItemJnlLine.Quantity > 0)) OR

    //        ((ItemJnlLine."Entry Type" IN

    //          [ItemJnlLine."Entry Type"::Sale, ItemJnlLine."Entry Type"::"Negative Adjmt."]) AND

    //         (ItemJnlLine.Quantity < 0)) OR

    //        ToTransfer

    //     THEN BEGIN

    //         IF ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::Transfer THEN
    //             WhseJnlLine."Entry Type" := WhseJnlLine."Entry Type"::Movement

    //         ELSE
    //             WhseJnlLine."Entry Type" := WhseJnlLine."Entry Type"::"Positive Adjmt.";

    //         IF Location."Directed Put-away and Pick" THEN
    //             IF BOMPosting THEN
    //                 WhseJnlLine."To Bin Code" := Location."Outbound BOM Bin Code"

    //             ELSE
    //                 WhseJnlLine."To Bin Code" := Location."Adjustment Bin Code"

    //         ELSE

    //             IF ToTransfer THEN
    //                 WhseJnlLine."To Bin Code" := ItemJnlLine."New Bin Code"

    //             ELSE
    //                 WhseJnlLine."To Bin Code" := ItemJnlLine."Bin Code";

    //         //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

    //         WhseJnlLine."To Bin Code" := ItemJnlLine."Bin Code";

    //         //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

    //         GetBin(ItemJnlLine."Location Code", WhseJnlLine."To Bin Code");

    //         WhseJnlLine."To Zone Code" := Bin."Zone Code";

    //     END ELSE BEGIN

    //         IF ((ItemJnlLine."Entry Type" IN

    //              [ItemJnlLine."Entry Type"::Purchase, ItemJnlLine."Entry Type"::"Positive Adjmt."]) AND

    //             (ItemJnlLine.Quantity < 0)) OR

    //            ((ItemJnlLine."Entry Type" IN

    //              [ItemJnlLine."Entry Type"::Sale, ItemJnlLine."Entry Type"::"Negative Adjmt."]) AND

    //             (ItemJnlLine.Quantity > 0)) OR

    //            ((ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::Transfer) AND (NOT ToTransfer))

    //         THEN BEGIN

    //             IF ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::Transfer THEN
    //                 WhseJnlLine."Entry Type" := WhseJnlLine."Entry Type"::Movement

    //             ELSE
    //                 WhseJnlLine."Entry Type" := WhseJnlLine."Entry Type"::"Negative Adjmt.";

    //             IF Location."Directed Put-away and Pick" THEN
    //                 IF BOMPosting THEN
    //                     WhseJnlLine."From Bin Code" := Location."Inbound BOM Bin Code"

    //                 ELSE
    //                     WhseJnlLine."From Bin Code" := Location."Adjustment Bin Code"

    //             ELSE BEGIN

    //                 IF Location."Bin Mandatory" AND BOMPosting THEN
    //                     GetDefaultBin(ItemJnlLine."Item No.", ItemJnlLine."Variant Code", ItemJnlLine."Location Code", ItemJnlLine."Bin Code");

    //                 WhseJnlLine."From Bin Code" := ItemJnlLine."Bin Code";

    //             END;

    //             //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

    //             WhseJnlLine."From Bin Code" := ItemJnlLine."Bin Code";

    //             //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

    //             IF Location."Directed Put-away and Pick" THEN BEGIN

    //                 GetBin(ItemJnlLine."Location Code", WhseJnlLine."From Bin Code");

    //                 WhseJnlLine."From Zone Code" := Bin."Zone Code";

    //                 WhseJnlLine."From Bin Type Code" := Bin."Bin Type Code";

    //             END;

    //         END ELSE BEGIN

    //             IF ItemJnlLine."Phys. Inventory" AND (ItemJnlLine.Quantity = 0) AND (ItemJnlLine."Invoiced Quantity" = 0) THEN BEGIN

    //                 WhseJnlLine."Entry Type" := WhseJnlLine."Entry Type"::"Positive Adjmt.";

    //                 IF Location."Directed Put-away and Pick" THEN
    //                     WhseJnlLine."To Bin Code" := Location."Adjustment Bin Code"

    //                 ELSE
    //                     WhseJnlLine."To Bin Code" := ItemJnlLine."Bin Code";

    //                 GetBin(ItemJnlLine."Location Code", WhseJnlLine."To Bin Code");

    //                 WhseJnlLine."To Zone Code" := Bin."Zone Code";

    //             END;

    //         END;

    //     END;

    //     IF Location."Directed Put-away and Pick" THEN BEGIN

    //         WhseJnlLine.Quantity := ItemJnlLine.Quantity;

    //         WhseJnlLine."Unit of Measure Code" := ItemJnlLine."Unit of Measure Code";

    //         WhseJnlLine."Qty. per Unit of Measure" := ItemJnlLine."Qty. per Unit of Measure";

    //     END ELSE BEGIN

    //         WhseJnlLine.Quantity := ItemJnlLine."Quantity (Base)";

    //         WhseJnlLine."Unit of Measure Code" := GetBaseUOM(ItemJnlLine."Item No.");

    //         WhseJnlLine."Qty. per Unit of Measure" := 1;

    //     END;

    //     WhseJnlLine."Qty. (Base)" := ItemJnlLine."Quantity (Base)";

    //     WhseJnlLine."Qty. (Absolute)" := ABS(WhseJnlLine.Quantity);

    //     WhseJnlLine."Qty. (Absolute, Base)" := ABS(ItemJnlLine."Quantity (Base)");

    //     IF (ItemJnlLine."Journal Template Name" <> '') AND (ItemJnlLine."Journal Batch Name" <> '') THEN BEGIN

    //         WhseJnlLine."Source Type" := DATABASE::"Item Journal Line";

    //         WhseJnlLine."Source Subtype" := ItemJnlTemplateType;

    //         WhseMgt.GetSourceDocument(

    //           //WhseJnlLine."Source Document",

    //           WhseJnlLine."Source Type", WhseJnlLine."Source Subtype");

    //         WhseJnlLine."Source No." := ItemJnlLine."Document No.";

    //         WhseJnlLine."Source Line No." := ItemJnlLine."Line No.";

    //     END;

    //     WhseJnlLine."Source Code" := ItemJnlLine."Source Code";

    //     WhseJnlLine."Reason Code" := ItemJnlLine."Reason Code";

    //     WhseJnlLine."Registering No. Series" := ItemJnlLine."Posting No. Series";

    //     WhseJnlLine."Whse. Document Type" := WhseJnlLine."Whse. Document Type"::" ";

    //     WhseJnlLine."Reference Document" := WhseJnlLine."Reference Document"::"Item Journal";

    //     WhseJnlLine."Reference No." := ItemJnlLine."Document No.";

    //     IF Location."Directed Put-away and Pick" THEN
    //         CalcCubageAndWeight(

    //           ItemJnlLine."Item No.", ItemJnlLine."Unit of Measure Code", WhseJnlLine."Qty. (Absolute)",

    //           WhseJnlLine.Cubage, WhseJnlLine.Weight);

    //     WhseJnlLine."Registering No. Series" := ItemJnlLine."Posting No. Series";

    //     TransferWhseItemTrkg(WhseJnlLine, ItemJnlLine);

    //     EXIT(TRUE);

    //     //<<NV

    // END;

    


}
