codeunit 50034 CU7308Subscriber
{
    var
        Bin: Record Bin;
        // Location: Record Location;
        ReplenishmentCu: Codeunit Replenishment;
        BreakAtRemainQtyToReplenish: Decimal;
        MustNotBeErr: Label 'must not be %1.', Comment = '%1 - field value';
    /*  ">> NV": Integer;
     UseBreakWhenQtyOnHand: Option " ",">= Min. Qty.","= Max. Qty."; */

    [EventSubscriber(ObjectType::Codeunit, Codeunit::Replenishment, OnBeforeReplenishBin, '', false, false)]
    local procedure OnBeforeReplenishBin(ToBinContent: Record "Bin Content"; var IsHandled: Boolean; RemainQtyToReplenishBase: Decimal; AllowBreakBulk: Boolean)
    var
        ExcludedQtyBase: Decimal;
    begin
        IsHandled := true;

        if not ToBinContent.Fixed then
            ToBinContent.FieldError(Fixed, StrSubstNo(MustNotBeErr, ToBinContent.FieldCaption(Fixed)));

        if BinBlockedInbound(ToBinContent."Location Code", ToBinContent."Bin Code") then
            Bin.FieldError("Block Movement", StrSubstNo(MustNotBeErr, Bin."Block Movement"));

        ExcludedQtyBase := 0;
        if not ToBinContent.NeedToReplenish(ExcludedQtyBase) then
            exit;

        RemainQtyToReplenishBase := ToBinContent.CalcQtyToReplenish(ExcludedQtyBase);
        if RemainQtyToReplenishBase <= 0 then
            exit;

        //TODO
        /*  // >> NV - 09/19/03 MV
         // Determine break criteria
         Location.GET(ToBinContent."Location Code");
         IF ToBinContent."Break Pick when Qty. on Hand" <> ToBinContent."Break Pick when Qty. on Hand"::" " THEN
             UseBreakWhenQtyOnHand := ToBinContent."Break Pick when Qty. on Hand"
         ELSE
             UseBreakWhenQtyOnHand := Location."Break Pick when Qty. on Hand";
         IF UseBreakWhenQtyOnHand = UseBreakWhenQtyOnHand::" " THEN
             Location.TESTFIELD("Break Pick when Qty. on Hand", UseBreakWhenQtyOnHand::" "); // Error message
         IF UseBreakWhenQtyOnHand = UseBreakWhenQtyOnHand::">= Min. Qty." THEN BEGIN
             ToBinContent.TESTFIELD("Min. Qty.");
             BreakAtRemainQtyToReplenish :=
               RemainQtyToReplenishBase - (ToBinContent."Min. Qty." - CalcQtyAvailable(0)); // New function -- must be consistent w/ "CalcQtyToReplenish"
         END ELSE
             BreakAtRemainQtyToReplenish := 0;
         // << NV - 09/19/03 MV */
        //TODO

        ReplenishmentCu.FindReplenishmtBin(ToBinContent, AllowBreakBulk);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::Replenishment, OnBeforeFindReplenishmtBin, '', false, false)]
    local procedure OnBeforeFindReplenishmtBin(var TempWhseWkshLine: Record "Whse. Worksheet Line" temporary; ToBinContent: Record "Bin Content"; AllowBreakBulk: Boolean; var NextLineNo: Integer; WhseWkshTemplateName: Code[10]; WhseWkshName: Code[10]; LocationCode: Code[10]; DoNotFillQtytoHandle: Boolean; RemainQtyToReplenishBase: Decimal; var IsHandled: Boolean)
    var
        FromBinContent: Record "Bin Content";
        WhseWkshLine2: Record "Whse. Worksheet Line";
        QtyAvailToTakeBase: Decimal;
        MovementQtyBase: Decimal;
    begin
        IsHandled := true;

        FromBinContent.Reset();
        FromBinContent.SetCurrentKey(
            "Location Code", "Item No.", "Variant Code", "Cross-Dock Bin",
            "Qty. per Unit of Measure", "Bin Ranking");
        FromBinContent.Ascending(false);
        FromBinContent.SetRange("Location Code", ToBinContent."Location Code");
        FromBinContent.SetRange("Item No.", ToBinContent."Item No.");
        FromBinContent.SetRange("Variant Code", ToBinContent."Variant Code");
        FromBinContent.SetRange("Cross-Dock Bin", false);
        FromBinContent.SetRange("Qty. per Unit of Measure", ToBinContent."Qty. per Unit of Measure");
        FromBinContent.SetFilter("Bin Ranking", '<%1', ToBinContent."Bin Ranking");
        if FromBinContent.Find('-') then begin
            WhseWkshLine2.Copy(TempWhseWkshLine);
            TempWhseWkshLine.SetCurrentKey(
                "Item No.", "From Bin Code", "Location Code", "Variant Code", "From Unit of Measure Code");
            TempWhseWkshLine.SetRange("Item No.", FromBinContent."Item No.");
            TempWhseWkshLine.SetRange("Location Code", FromBinContent."Location Code");
            TempWhseWkshLine.SetRange("Variant Code", FromBinContent."Variant Code");
            repeat
                if ReplenishmentCu.UseForReplenishment(FromBinContent) then begin
                    QtyAvailToTakeBase := FromBinContent.CalcQtyAvailToTake(0);
                    TempWhseWkshLine.SetRange("From Bin Code", FromBinContent."Bin Code");
                    TempWhseWkshLine.SetRange("From Unit of Measure Code", FromBinContent."Unit of Measure Code");
                    TempWhseWkshLine.CalcSums("Qty. (Base)");
                    QtyAvailToTakeBase := QtyAvailToTakeBase - TempWhseWkshLine."Qty. (Base)";

                    if QtyAvailToTakeBase > 0 then begin
                        if QtyAvailToTakeBase < RemainQtyToReplenishBase then
                            MovementQtyBase := QtyAvailToTakeBase
                        else
                            MovementQtyBase := RemainQtyToReplenishBase;
                        ReplenishmentCu.CreateWhseWkshLine(ToBinContent, FromBinContent, MovementQtyBase);
                        RemainQtyToReplenishBase := RemainQtyToReplenishBase - MovementQtyBase;
                    end;
                end;
            // >> NV - 09/19/03 MV
            //   {
            //   UNTIL (FromBinContent.NEXT = 0) OR (RemainQtyToReplenishBase = 0);
            //   }
            UNTIL (FromBinContent.NEXT() = 0) OR (RemainQtyToReplenishBase = 0) OR (RemainQtyToReplenishBase <= BreakAtRemainQtyToReplenish);
            // << NV - 09/19/03 MV
            TempWhseWkshLine.Copy(WhseWkshLine2);
        end;

        if AllowBreakBulk then
            // >> NV - 09/19/03 MV
            // {
            // IF RemainQtyToReplenishBase > 0 THEN
            // }
            IF (RemainQtyToReplenishBase > 0) AND (RemainQtyToReplenishBase > BreakAtRemainQtyToReplenish) THEN
                // << MV - 09/19/03 MV
                ReplenishmentCu.FindBreakbulkBin(ToBinContent);
    end;


    local procedure BinBlockedInbound(LocationCode2: Code[10]; BinCode2: Code[20]) Blocked: Boolean
    begin
        GetBin(LocationCode2, BinCode2);
        Blocked := Bin."Block Movement" in
          [Bin."Block Movement"::Inbound, Bin."Block Movement"::All];
        exit(Blocked);
    end;

    local procedure GetBin(LocationCode2: Code[10]; BinCode2: Code[20])
    begin
        if (Bin."Location Code" <> LocationCode2) or
           (Bin.Code <> BinCode2)
        then
            Bin.Get(LocationCode2, BinCode2);
    end;

}