codeunit 70104 CU_14000710
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LAX Pack Line Scanning Mgt.", pubOnShippingSetupCustomPriority, '', false, false)]
    local procedure "LAX Pack Line Scanning Mgt._pubOnShippingSetupCustomPriority"(var PackingControl: Record "LAX Packing Control"; var Item: Record Item; var Resource: Record Resource; var Handled: Boolean)
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
        Handled := true;
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

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LAX Pack Line Scanning Mgt.", pubOnBeforeCreateLines, '', false, false)]
    local procedure "LAX Pack Line Scanning Mgt._pubOnBeforeCreateLines"(var PackingControl: Record "LAX Packing Control"; var CurrentInputLine: Text[250])
    var
        PackingStation: Record "LAX Packing Station";
    begin
        PackingStation.GetPackingStation();

        //>> NIF #9865 RTT 03-28-05
        IF NOT CheckQCItem(PackingControl) THEN BEGIN
            SetMessage(STRSUBSTNO('Item %1 is on QC Hold', PackingControl."Input No."), 76, PackingControl, PackingStation);
            CurrentInputLine := '';

            ClearInputFields(PackingControl);
            PackingControl.CalculateOrderQtyToShip;
            EXIT;
        END;

        IF NOT CheckQCLot(PackingControl) THEN BEGIN
            SetMessage(STRSUBSTNO('Lot No. %1 is on QC Hold', PackingControl."Input Lot Number"), 77, PackingControl, PackingStation);
            CurrentInputLine := '';

            ClearInputFields(PackingControl);
            PackingControl.CalculateOrderQtyToShip;
            EXIT;
        END;
        //<< NIF #9865 RTT 03-28-05
        //>> NIF #10045 RTT 03-28-05
        IF CheckLotBlocked(PackingControl) THEN BEGIN
            SetMessage(STRSUBSTNO('Lot %1 has been blocked.', PackingControl."Input Lot Number"), 78, PackingControl, PackingStation);
            CurrentInputLine := '';

            ClearInputFields(PackingControl);
            PackingControl.CalculateOrderQtyToShip;
            EXIT;
        END;

        IF NOT CheckQCInspected(PackingControl) THEN BEGIN
            SetMessage(STRSUBSTNO('Lot %1 has not been inspected.', PackingControl."Input Lot Number"), 79, PackingControl, PackingStation);
            CurrentInputLine := '';

            ClearInputFields(PackingControl);
            PackingControl.CalculateOrderQtyToShip;
            EXIT;
        END;
        //<< NIF #10045 RTT 03-28-05
    end;

    procedure CheckQCItem(PackingControl: Record 14000717): Boolean
    var
        Item: Record 27;
    begin
        EXIT(TRUE);
        IF PackingControl."Input Type" <> PackingControl."Input Type"::Item THEN
            EXIT(TRUE);

        Item.GET(PackingControl."Input No.");

        EXIT(NOT Item."QC Hold");
    end;

    procedure CheckQCLot(PackingControl: Record 14000717): Boolean
    var
        LotNotInfo: Record 6505;
    begin
        EXIT(TRUE);
        IF PackingControl."Input Type" <> PackingControl."Input Type"::Item THEN
            EXIT(TRUE);

        IF PackingControl."Input Lot Number" = '' THEN
            EXIT(TRUE);

        LotNoInfo.RESET;
        LotNoInfo.SETRANGE("Item No.", PackingControl."Input No.");
        LotNoInfo.SETRANGE("Lot No.", PackingControl."Input Lot Number");
        LotNoInfo.FIND('-');

        EXIT(NOT LotNotInfo."QC Hold");
    end;

    procedure CheckQCInspected(PackingControl: Record 14000717): Boolean
    begin
        IF PackingControl."Input Type" <> PackingControl."Input Type"::Item THEN
            EXIT(TRUE);

        IF PackingControl."Input Lot Number" = '' THEN
            EXIT(TRUE);

        LotNoInfo.RESET;
        LotNoInfo.SETRANGE("Item No.", PackingControl."Input No.");
        LotNoInfo.SETRANGE("Lot No.", PackingControl."Input Lot Number");
        LotNoInfo.FIND('-');

        EXIT(LotNoInfo."Passed Inspection");
    end;

    procedure CheckLotBlocked(PackingControl: Record 14000717): Boolean
    begin
        IF PackingControl."Input Type" <> PackingControl."Input Type"::Item THEN
            EXIT(TRUE);

        IF PackingControl."Input Lot Number" = '' THEN
            EXIT(TRUE);

        LotNoInfo.RESET;
        LotNoInfo.SETRANGE("Item No.", PackingControl."Input No.");
        LotNoInfo.SETRANGE("Lot No.", PackingControl."Input Lot Number");
        LotNoInfo.FIND('-');

        EXIT(LotNoInfo.Blocked);
    end;

    local procedure ClearInputFields(var PackingControl: Record "LAX Packing Control")
    begin
        PackingControl."Input Type" := PackingControl."Input Type"::" ";
        PackingControl."Input No." := '';
        PackingControl."Input Serial Number" := '';
        PackingControl."Pack Serial Number" := false;
        PackingControl."Pack Serial Number Late" := false;
        PackingControl."Input Lot Number" := '';
        PackingControl."Pack Lot Number" := false;
        PackingControl."Pack Lot Number Late" := false;
        PackingControl."Input Warranty Date" := 0D;
        PackingControl."Pack Warranty Date" := false;
        PackingControl."Pack Warranty Date Late" := false;
        PackingControl."Input Expiration Date" := 0D;
        PackingControl."Pack Expiration Date" := false;
        PackingControl."Pack Expiration Date Late" := false;
        PackingControl."Input Description" := '';
        PackingControl."Input Variant Code" := '';
        PackingControl."Input Unit of Measure Code" := '';
        PackingControl."Input Qty. Per Unit of Measure" := 1;
        PackingControl."Input Always Enter Quantity" := false;
        PackingControl."Line Description" := '';
        PackingControl."Input Base Unit of Meas. Code" := '';
        PackingControl."Scanned No." := '';
        PackingControl."Required Shipping Agent Code" := '';
        PackingControl."Required E-Ship Agent Service" := '';
        PackingControl."Allow Other Ship. Agent/Serv." := false;
    end;

    local procedure SetMessage(NewMessageLine: Text[250]; UsageCaseNo: Integer; var PackingControl: Record "LAX Packing Control"; var PackingStation: Record "LAX Packing Station")
    var

    begin
        // UsageCaseNo is unique to each place this local function is called.  This allows for external modification of any case via the below published extension.                                                                                                                                                                          
        PackingControl."Error Message" := NewMessageLine;
        if PackingStation."Confirm on Errors" then
            Message(NewMessageLine);

        PackingControl."Message Line" := NewMessageLine;
    end;

    var
        LotNoInfo: Record "Lot No. Information";
        LAXPackLineScanningMgt: Codeunit "LAX Pack Line Scanning Mgt.";
}
