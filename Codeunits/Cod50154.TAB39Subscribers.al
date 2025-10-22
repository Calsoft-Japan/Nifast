codeunit 50154 TAB39Subscribers
{
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnAfterInsertEvent, '', false, false)]
    local procedure "Purchase Line_OnAfterInsertEvent"(var Rec: Record "Purchase Line")
    var
        PurchHeader: Record "Purchase Header";
    begin
        PurchHeader.Get(Rec."Document No.");
        //>>NIF MAK 060905
        Rec."Vessel Name" := PurchHeader."Vessel Name";
        Rec."Sail-on Date" := PurchHeader."Sail-on Date";
        //<<NIF
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnAfterInitHeaderDefaults, '', false, false)]
    local procedure "Purchase Line_OnAfterInitHeaderDefaults"(var PurchLine: Record "Purchase Line"; PurchHeader: Record "Purchase Header"; var TempPurchLine: Record "Purchase Line" temporary)
    begin
        //-AKK1606-- PEDIMENTOS
        PurchLine."Entry/Exit No." := PurchHeader."Entry/Exit No.";
        PurchLine."Entry/Exit Date" := PurchHeader."Entry/Exit Date";
        //+AKK1606++ PEDIMENTOS
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnAfterAssignItemValues, '', false, false)]
    local procedure "Purchase Line_OnAfterAssignItemValues"(var PurchLine: Record "Purchase Line"; Item: Record Item; CurrentFieldNo: Integer; PurchHeader: Record "Purchase Header")
    var
    //NVM: Codeunit 50021;
    begin
        //>> NF1.00:CIS.CM 09-29-15
        //PurchLine."QC Hold" := CheckQCHoldReceive(PurchLine."Buy-from Vendor No.", PurchLine."No.", ''); //TODO
        //<< NF1.00:CIS.CM 09-29-15

        //-AKK1606-- PEDIMENTOS
        PurchLine.National := Item.National;
        //+AKK1606++ PEDIMENTOS
        //>>NIF MAK 050606
        PurchLine.VALIDATE("Country of Origin Code", Item."Country/Region of Origin Code");
        PurchLine.VALIDATE(Manufacturer, Item."Manufacturer Code");
        //<<NIF MAK 050606
        // //>> NIF 06-29-05 RTT
        // NVM.GetActiveDrawingRevision(Item."No.", "Revision No.", "Drawing No.", "Revision Date"); //TODO
        // //<< NIF 06-29-05 RTT
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnValidateQuantityOnAfterCalcBaseQty, '', false, false)]
    local procedure "Purchase Line_OnValidateQuantityOnAfterCalcBaseQty"(var PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line")
    begin
        //>> NIF #10069 RTT 06-09-05
        if ((PurchaseLine."Document Type" = PurchaseLine."Document Type"::Quote) or (PurchaseLine."Document Type" = PurchaseLine."Document Type"::Order)) and
               (PurchaseLine.Type = PurchaseLine.Type::Item) and (PurchaseLine.Quantity <> xPurchaseLine.Quantity) and (PurchaseLine."Units per Parcel" <> 0) then begin
            PurchaseLine.CheckParcelQty(PurchaseLine."Quantity (Base)");
            PurchaseLine.Quantity := PurchaseLine."Quantity (Base)" * PurchaseLine."Qty. per Unit of Measure";
        end;
        //<< NIF #10069 RTT 06-09-05
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnAfterInitQtyToReceive, '', false, false)]
    local procedure "Purchase Line_OnAfterInitQtyToReceive"(var PurchLine: Record "Purchase Line"; CurrFieldNo: Integer)
    begin
        //>>NV4.33.01 08-20-04 RTT
        // set Qty. to Invoice on Item Tracking
        PurchLine.UpdateItemTrackingLines(PurchLine);
        //<<NV4.33.01 08-20-04 RTT
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnAfterUpdateAmountsDone, '', false, false)]
    local procedure "Purchase Line_OnAfterUpdateAmountsDone"(var PurchLine: Record "Purchase Line"; var xPurchLine: Record "Purchase Line"; CurrFieldNo: Integer)
    begin
        //>>NF1.00:CIS.RAM FOREX
        //IF "Document Type" = "Document Type"::Invoice THEN
        PurchLine.UpdateUSDValue();
        //<<NF1.00:CIS.RAM FOREX
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnAfterGetDefaultBin, '', false, false)]
    local procedure "Purchase Line_OnAfterGetDefaultBin"(var PurchaseLine: Record "Purchase Line")
    var
        Location: Record Location;
    begin
        //>> NIF #9850
        Location.Get(PurchaseLine."Location Code");
        if Location."Receipt Bin Code" <> '' then
            PurchaseLine."Bin Code" := Location."Receipt Bin Code";
        //<< NIF #9850
    end;

    // [EventSubscriber(ObjectType::Page, Page::"Purchase Order Subform", OnBeforeInsertExtendedText, '', false, false)]
    // local procedure "Purchase Order Subform_OnBeforeInsertExtendedText"(var PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    // begin
    //     //>> NIF #10088 RTT 06-07-05
    //     PurchaseLine.HandleCommentLines();
    //     //>> NIF #10088 RTT 06-07-05
    // end;

}
