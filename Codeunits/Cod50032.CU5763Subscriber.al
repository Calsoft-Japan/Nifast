codeunit 50032 CU5763Subscriber
{
    //Version NAVW17.10,SE0.52.04,NV4.35,NIF.N15.C9IN.001;
    var
        WhseShptLine2: Record 7321;
        Location: Record Location;
        WMSMgt: Codeunit "WMS Management";
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        WhseJnlRegisterLine: Codeunit "Whse. Jnl.-Register Line";

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment", OnAfterSetCurrentKeyForWhseShptLine, '', false, false)]
    local procedure OnAfterSetCurrentKeyForWhseShptLine(var WarehouseShipmentLine: Record "Warehouse Shipment Line");
    begin
        // >> Shipping Solve filter problem posting single document
        WhseShptLine2.COPYFILTERS(WarehouseShipmentLine);
        // << Shipping
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment", OnAfterReleaseSourceForFilterWhseShptLine, '', false, false)]
    local procedure OnAfterReleaseSourceForFilterWhseShptLine(var WarehouseShipmentLine: Record "Warehouse Shipment Line");
    begin
        // >> Shipping
        WarehouseShipmentLine.COPYFILTERS(WhseShptLine2);
        // << Shipping
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment", OnBeforePostWhseJnlLine, '', false, false)]
    local procedure OnBeforePostWhseJnlLine(var PostedWhseShipmentLine: Record "Posted Whse. Shipment Line"; var TempTrackingSpecification: Record "Tracking Specification" temporary; var IsHandled: Boolean)
    var
        TempWhseJnlLine: Record "Warehouse Journal Line" temporary;
        TempWhseJnlLine2: Record "Warehouse Journal Line" temporary;
        TempWhseJnlLineLPN: Record 7311 temporary;
        WhsePostShipmentCu: Codeunit "Whse.-Post Shipment";
    // ">> NV": Integer;
    begin
        IsHandled := true;

        GetLocation(PostedWhseShipmentLine."Location Code");
        if Location."Bin Mandatory" then begin
            WhsePostShipmentCu.CreateWhseJnlLine(TempWhseJnlLine, PostedWhseShipmentLine);
            CheckWhseJnlLine(TempWhseJnlLine);
            // >> NV

            //>> NF1.00:CIS.CM 09-29-15
            //IF LicensePlate.READPERMISSION THEN
            //  BEGIN
            //    CLEAR(LicensePlateMgt);
            //    LicensePlateMgt.ShipTransferSplitWhseJnlLine(TempWhseJnlLine,TempWhseJnlLineLPN);
            //  END;
            //<< NF1.00:CIS.CM 09-29-15

            IF TempWhseJnlLineLPN.FIND('-') THEN
                REPEAT
                    ItemTrackingMgt.SplitWhseJnlLine(TempWhseJnlLineLPN, TempWhseJnlLine2, TempTrackingSpecification, FALSE);
                    IF TempWhseJnlLine2.FIND('-') THEN
                        REPEAT
                            WhseJnlRegisterLine.RUN(TempWhseJnlLine2);
                        UNTIL TempWhseJnlLine2.NEXT() = 0;
                UNTIL TempWhseJnlLineLPN.NEXT() = 0
            ELSE BEGIN
                // << NV
                ItemTrackingMgt.SplitWhseJnlLine(TempWhseJnlLine, TempWhseJnlLine2, TempTrackingSpecification, false);
                if TempWhseJnlLine2.Find('-') then
                    repeat
                        WhseJnlRegisterLine.Run(TempWhseJnlLine2);
                    until TempWhseJnlLine2.Next() = 0;
                // >> NV
            END;
            // << NV
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment", OnAfterCreateWhseJnlLine, '', false, false)]
    local procedure OnAfterCreateWhseJnlLine(var WarehouseJournalLine: Record "Warehouse Journal Line"; PostedWhseShipmentLine: Record "Posted Whse. Shipment Line")
    begin
        //TODO
        // >> NV
        IF PostedWhseShipmentLine."License Plate No." <> '' THEN BEGIN
            WarehouseJournalLine."License Plate Operation Type" := WarehouseJournalLine."License Plate Operation Type"::"License Plate Movement";
            WarehouseJournalLine."From License Plate No." := PostedWhseShipmentLine."License Plate No.";
            WarehouseJournalLine."To License Plate No." := '';
        END;
        // << NV 
        //TODO
    end;

    local procedure CheckWhseJnlLine(var TempWhseJnlLine: Record "Warehouse Journal Line" temporary)
    begin
        WMSMgt.CheckWhseJnlLine(TempWhseJnlLine, 0, 0, false);
    end;

    local procedure GetLocation(LocationCode: Code[10])
    begin
        if LocationCode = '' then
            Location.Init()
        else
            if LocationCode <> Location.Code then
                Location.Get(LocationCode);
    end;


}