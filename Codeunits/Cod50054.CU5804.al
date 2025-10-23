codeunit 50054 CU_5804
{
    PROCEDURE CalculateAverageInclExpCost(VAR Item: Record 27; VAR AverageCost: Decimal; VAR AverageCostACY: Decimal): Boolean;
    VAR
        ItemLedgEntry: Record 32;
        ValueEntry: Record 5802;
        AverageQty: Decimal;
    BEGIN
        //>>NV
        ValueEntry.SETCURRENTKEY(
  "Item No.", "Expected Cost", "Valuation Date", "Location Code", "Variant Code", "Drop Shipment");
        ValueEntry.SETRANGE("Item No.", Item."No.");
        ValueEntry.SETRANGE("Expected Cost", FALSE);
        ValueEntry.SETRANGE("Drop Shipment", FALSE);
        ValueEntry.SETFILTER("Valuation Date", Item.GETFILTER("Date Filter"));
        ValueEntry.SETFILTER("Location Code", Item.GETFILTER("Location Filter"));
        ValueEntry.SETFILTER("Variant Code", Item.GETFILTER("Variant Filter"));
        ValueEntry.CALCSUMS("Invoiced Quantity", "Cost Amount (Actual)", "Cost Amount (Actual) (ACY)");
        AverageQty := ValueEntry."Invoiced Quantity";
        AverageCost := ValueEntry."Cost Amount (Actual)";
        AverageCostACY := ValueEntry."Cost Amount (Actual) (ACY)";

        ItemLedgEntry.SETCURRENTKEY(
  "Item No.", "Completely Invoiced", "Location Code", "Variant Code", "Drop Shipment");
        ItemLedgEntry.SETRANGE("Item No.", Item."No.");
        ItemLedgEntry.SETRANGE("Completely Invoiced", FALSE);
        ItemLedgEntry.SETRANGE("Drop Shipment", FALSE);
        ItemLedgEntry.SETFILTER("Location Code", Item.GETFILTER("Location Filter"));
        ItemLedgEntry.SETFILTER("Variant Code", Item.GETFILTER("Variant Filter"));
        IF ItemLedgEntry.FIND('-') THEN BEGIN
            ValueEntry.RESET;
            ValueEntry.SETCURRENTKEY("Item Ledger Entry No.", "Expected Cost", "Valuation Date");
            REPEAT
                IF ItemLedgEntry.Quantity <> ItemLedgEntry."Invoiced Quantity" THEN BEGIN
                    ValueEntry.SETRANGE("Item Ledger Entry No.", ItemLedgEntry."Entry No.");
                    ValueEntry.SETRANGE("Expected Cost", TRUE);
                    ValueEntry.SETFILTER("Valuation Date", Item.GETFILTER("Date Filter"));
                    IF ValueEntry.FIND('-') THEN BEGIN
                        IF NOT Revaluated(ValueEntry) THEN BEGIN
                            ValueEntry.CALCSUMS("Cost Amount (Expected)", "Cost Amount (Expected) (ACY)");

                            AverageQty := AverageQty + ItemLedgEntry.Quantity - ItemLedgEntry."Invoiced Quantity";
                            AverageCost :=
                              AverageCost +
                              (ValueEntry."Cost Amount (Expected)" * (ItemLedgEntry.Quantity - ItemLedgEntry."Invoiced Quantity") / ItemLedgEntry.Quantity);

                            AverageCostACY :=
                              AverageCostACY +
                              (ValueEntry."Cost Amount (Expected) (ACY)" * (ItemLedgEntry.Quantity - ItemLedgEntry."Invoiced Quantity") / ItemLedgEntry.Quantity);
                        END;
                    END;
                END;
            UNTIL ItemLedgEntry.NEXT = 0;
        END;
        IF AverageQty <> 0 THEN BEGIN
            AverageCost := AverageCost / AverageQty;
            AverageCostACY := AverageCostACY / AverageQty;

            IF AverageCost < 0 THEN
                AverageCost := 0;
            GLSetup.GET;
            IF (GLSetup."Additional Reporting Currency" = '') OR (AverageCostACY < 0) THEN
                AverageCostACY := 0;
        END ELSE BEGIN
            AverageCost := 0;
            AverageCostACY := 0;
        END;
        IF AverageQty <= 0 THEN
            EXIT(FALSE);

        EXIT(TRUE);
        //<<NV
    END;

    LOCAL PROCEDURE Revaluated(ValueEntry: Record 5802): Boolean;
    VAR
        PartRevValueEntry: Record 5802;
    BEGIN
        //>>NV
        PartRevValueEntry.SETCURRENTKEY(
  "Item No.", "Expected Cost", "Valuation Date", "Location Code", "Variant Code");
        PartRevValueEntry.SETRANGE("Item No.", ValueEntry."Item No.");
        PartRevValueEntry.SETRANGE("Expected Cost", FALSE);
        PartRevValueEntry.SETFILTER("Valuation Date", '>= %1', ValueEntry."Valuation Date");
        PartRevValueEntry.SETRANGE("Location Code", ValueEntry."Location Code");
        PartRevValueEntry.SETRANGE("Variant Code", ValueEntry."Variant Code");
        PartRevValueEntry.SETRANGE("Partial Revaluation", TRUE);
        IF NOT PartRevValueEntry.FIND('-') THEN
            EXIT(FALSE);

        EXIT(PartRevValueEntry."Entry No." > ValueEntry."Entry No.");
        //<<NV
    END;

    var
        GLSetup: record "General Ledger Setup";


}
