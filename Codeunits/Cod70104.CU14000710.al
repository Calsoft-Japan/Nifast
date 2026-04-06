codeunit 70104 CU_14000710
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LAX Pack Line Scanning Mgt.", pubOnShippingSetupCustomPriority, '', false, false)]
    local procedure "LAX Pack Line Scanning Mgt._pubOnShippingSetupCustomPriority"(var PackingControl: Record "LAX Packing Control"; var Item: Record Item; var Resource: Record Resource; var Handled: Boolean)
    var
        LotNoInfo: Record "Lot No. Information";
    begin

        IF GetLotNoInfo(LotNoInfo, PackingControl) THEN BEGIN
            PackingControl."Input Type" := PackingControl."Input Type"::Item;
            PackingControl."Input No." := LotNoInfo."Item No.";
            PackingControl."Input Variant Code" := LotNoInfo."Variant Code";
            PackingControl."Input Unit of Measure Code" := Item."Base Unit of Measure";
            PackingControl."Input Lot Number" := LotNoInfo."Lot No.";
            PackingControl."Mfg. Lot No." := LotNoInfo."Mfg. Lot No.";
            IF Item.GET(PackingControl."Input No.") THEN
                LAXPackLineScanningMgt.GetItemInputFields(
            Item, PackingControl."Input Variant Code",
                                  PackingControl."Input Unit of Measure Code", PackingControl);
        END;
    end;

    local procedure GetLotNoInfo(var LotNoInfo: Record "Lot No. Information"; var PackingControl: Record "LAX Packing Control"): Boolean
    var
        LotSalesLine: Record "Sales Line";
        ItemFound: Boolean;
    begin

        LotSalesLine.SETRANGE("Document Type", LotSalesLine."Document Type"::Order);
        LotSalesLine.SETFILTER("Document No.", PackingControl."Multi Document No.");
        LotSalesLine.SETRANGE(Type, LotSalesLine.Type::Item);
        LotSalesLine.SETFILTER("No.", '<>%1', '');
        LotSalesLine.SETFILTER(Quantity, '<>%1', 0);
        IF NOT LotSalesLine.FIND('-') THEN
            EXIT(FALSE);

        REPEAT
            LotNoInfo.RESET;
            LotNoInfo.SETRANGE("Item No.", LotSalesLine."No.");
            LotNoInfo.SETRANGE("Lot No.", PackingControl."Input No.");
            ItemFound := LotNoInfo.FIND('-');
        UNTIL (LotSalesLine.NEXT = 0) OR (ItemFound);

        EXIT(ItemFound);
    end;


    var
        LAXPackLineScanningMgt: Codeunit "LAX Pack Line Scanning Mgt.";
}
