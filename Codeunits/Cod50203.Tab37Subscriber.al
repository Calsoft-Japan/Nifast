codeunit 50203 Tab37Subscriber
{
    var
        //  SalesSetup: Record "Sales & Receivables Setup";
        NIFItemCrossRef: Record "Item Reference";
        SingleInstanceCu: Codeunit SingleInstance;
        //TODO
        // NVM: Codeunit 50021;
        //TODO
        //SalesSetupRead: Boolean;
        EDITemp: Boolean;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnAfterInitHeaderDefaults, '', false, false)]
    local procedure OnAfterInitHeaderDefaults(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header"; xSalesLine: Record "Sales Line")
    var
        Item: Record Item;
    begin
        Item := SalesLine.GetItem();
        //SM 001 3/13/17 Canada request. Kanban No. and Country of Origin auto fill start
        SalesLine."Store Address" := SalesHeader."EDI Control No.";
        SalesLine."Storage Location" := Item."Country/Region of Origin Code";
        //SM 001 3/13/17 Canada request. Kanban No. and Country of Origin auto fill end


        //-AKK1606-- PEDIMENTOS
        SalesLine."Entry/Exit No." := SalesHeader."Entry/Exit No.";
        SalesLine."Entry/Exit Date" := SalesHeader."Entry/Exit Date";
        //+AKK1606++ PEDIMENTOS

        //TODO
        /*   //>>NIF GOLIVE 082905 MAK
          SalesLine."External Document No." := SalesHeader."External Document No.";
          //<<NIF GOLIVE 082905 MAK
   */
        //TODO

        //>>NIF #10076 07-06-05 RTT
        SalesLine."Model Year" := SalesHeader."Model Year";
        //<<NIF #10076 07-06-05 RTT

        //TODO
        /*   //>>NV
          SalesLine."Order Date" := SalesHeader."Order Date";
          SalesLine."Salesperson Code" := SalesHeader."Salesperson Code";
          //<<NV
          //>> NV #9752 get Contract No. if Item
          IF (SalesLine.Type = SalesLine.Type::Item) AND (SalesLine."No." <> '') THEN
              SalesLine."Contract No." := SalesHeader."Contract No."
          ELSE
              SalesLine."Contract No." := '';
          //<< NV #9752 */
        //TODO
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Line", OnAfterAssignItemValues, '', false, false)]
    local procedure OnAfterAssignItemValues(var SalesLine: Record "Sales Line"; Item: Record Item; SalesHeader: Record "Sales Header"; var xSalesLine: Record "Sales Line"; CurrentFieldNo: Integer)
    begin
        //-AKK1606-- PEDIMENTOS
        SalesLine.National := Item.National;
        //+AKK1606++ PEDIMENTOS

        //TODO
        /*  //>> NIF 06-29-05 RTT
         NVM.GetActiveDrawingRevision(Item."No.", SalesLine."Revision No.", SalesLine."Drawing No.", SalesLine."Revision Date");
         //<< NIF 06-29-05 RTT  */
        //TODO

        //>> NIF 12-13-05 MAK
        IF Item."Net Weight" = 0 THEN
            MESSAGE('Item %1 does not have a net weight!', SalesLine."No.");
        //<< NIF 12-13-05 MAK

        //>>CIS.RAM 10/23/20
        SalesLine."Box Weight" := Item."Carton Weight";
        //                                                               {
        //                                                               IF Quantity > 0 THEN BEGIN
        //     IF Item."Carton Weight" = 0 THEN
        //         MESSAGE('Item %1 does not have a Carton Weight!\You will need to manually update the Box Weight', "No.")
        //     ELSE BEGIN
        //         IF "Quantity (Base)" MOD Item."Units per Parcel" <> 0 THEN
        //             MESSAGE('Line Qty. does not match Carton Qty.\You will need to manually update the Box Weight')
        //         ELSE
        //             "Box Weight" := Item."Carton Weight" * ("Quantity (Base)" / Item."Units per Parcel");
        //     END;
        // END;
        //                                                               }
        //<<CIS.RAM 10/23/20
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnValidateNoOnAfterUpdateUnitPrice, '', false, false)]
    local procedure OnValidateNoOnAfterUpdateUnitPrice(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; var TempSalesLine: Record "Sales Line" temporary)
    begin
        //>> NIF 05-05-06 MAK
        IF STRPOS(COMPANYNAME, 'Mexi') <> 0 THEN BEGIN
            IF SalesLine.Type = SalesLine.Type::Item THEN BEGIN
                CLEAR(NIFItemCrossRef);
                NIFItemCrossRef.SETRANGE("Reference Type", NIFItemCrossRef."Reference Type"::Customer);
                NIFItemCrossRef.SETRANGE("Reference Type No.", SalesLine."Sell-to Customer No.");
                NIFItemCrossRef.SETRANGE("Item No.", SalesLine."No.");
                NIFItemCrossRef.SETRANGE("Unit of Measure", SalesLine."Unit of Measure Code");
                IF NIFItemCrossRef.FIND('-') THEN BEGIN
                    //SalesLine."Cross-Reference Type" := "Cross-Reference Type"::Customer;
                    SalesLine."Item Reference Type" := SalesLine."Item Reference Type"::Customer;
                    //"Cross-Reference Type No." := "Sell-to Customer No.";
                    SalesLine."Item Reference Type No." := SalesLine."Sell-to Customer No.";
                    // "Cross-Reference No." := NIFItemCrossRef."Cross-Reference No.";
                    SalesLine."Item Reference No." := NIFItemCrossRef."Reference No.";
                END;
            END;
        END ELSE
            //<< NIF 05-05-06 MAK
            UpdateItemReference(SalesLine);

        // >> EDI
        //SalesHeader.GET("Document Type","Document No.");
        SalesLine.GetSalesHeader();
        // << EDI
    end;

    local procedure UpdateItemReference(SalesLine: Record "Sales Line")
    var
        ItemReferenceMgt: Codeunit "Item Reference Management";
    begin
        ItemReferenceMgt.EnterSalesItemReference(SalesLine);
        SalesLine.UpdateICPartner();
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Line", OnValidateShipmentDateOnAfterSalesLineVerifyChange, '', false, false)]
    local procedure OnValidateShipmentDateOnAfterSalesLineVerifyChange(var SalesLine: Record "Sales Line"; CurrentFieldNo: Integer; var DoCheckReceiptOrderStatus: Boolean)
    begin
        SingleInstanceCu.SetSalesLineCurrentFieldNo(CurrentFieldNo);
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Line", OnBeforeCheckShipmentDateBeforeWorkDate, '', false, false)]
    local procedure OnBeforeCheckShipmentDateBeforeWorkDate(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; var HasBeenShown: Boolean; var IsHandled: Boolean)
    var
        CurrFieldNo: Integer;
        Text014: Label '%1 %2 is before work date %3', Comment = '%1=SalesLine.FieldCaption("Shipment Date"),%2=SalesLine."Shipment Date",%3=WorkDate()';
    begin
        IsHandled := true;

        SingleInstanceCu.GetSalesLineCurrentFieldNo(CurrFieldNo);
        if (SalesLine."Shipment Date" < WorkDate()) and SalesLine.HasTypeToFillMandatoryFields() and (CurrFieldNo <> 0) then
            if not (SalesLine.GetHideValidationDialog() or HasBeenShown) and GuiAllowed then begin
                Message(
                  Text014,
                  SalesLine.FieldCaption("Shipment Date"), SalesLine."Shipment Date", WorkDate());
                HasBeenShown := true;
            end;

        Clear(SingleInstanceCu);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnValidateQuantityOnAfterCalcBaseQty, '', false, false)]
    local procedure OnValidateQuantityOnAfterCalcBaseQty(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line")
    var
    // NoOfCartons: Integer;
    begin
        //>> NIF #10069 RTT 06-01-05
        IF ((SalesLine."Document Type" = SalesLine."Document Type"::Quote) OR (SalesLine."Document Type" = SalesLine."Document Type"::Order)) AND
          //>> NIF 12-07-05 RTT
          (COPYSTR(SalesLine."Shortcut Dimension 1 Code", 1, 3) <> 'HOA') AND
               //<< NIF 12-07-05 RTT
               (SalesLine.Type = SalesLine.Type::Item) AND (SalesLine.Quantity <> xSalesLine.Quantity) AND (SalesLine."Units per Parcel" <> 0) THEN BEGIN
            SalesLine.CheckParcelQty(SalesLine."Quantity (Base)");
            SalesLine.Quantity := SalesLine."Quantity (Base)" * SalesLine."Qty. per Unit of Measure";
            SalesLine."Total Parcels" := SalesLine."Quantity (Base)" / SalesLine."Units per Parcel";
        END;
        //<< NIF #10069 RTT 06-01-05

    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnValidateQuantityOnAfterInitQty, '', false, false)]
    local procedure OnValidateQuantityOnAfterInitQty(var SalesLine: Record "Sales Line"; var xSalesLine: Record "Sales Line"; CurrentFieldNo: Integer; var IsHandled: Boolean)
    begin
        SingleInstanceCu.SetSalesLineCurrentFieldNo(CurrentFieldNo);
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnValidateQuantityOnBeforeValidateQtyToAssembleToOrder, '', false, false)]
    local procedure OnValidateQuantityOnBeforeValidateQtyToAssembleToOrder(var SalesLine: Record "Sales Line"; StatusCheckSuspended: Boolean; var IsHandled: Boolean)
    var
        Item: Record Item;
        CurrentFieldNo: Integer;
    begin
        SingleInstanceCu.GetSalesLineCurrentFieldNo(CurrentFieldNo);

        //>>PFC
        SalesLine.GetAltUOM();
        SalesLine.GetAltPrice(CurrentFieldNo);
        //<<PFC

        Clear(SingleInstanceCu);

        //>>CIS.RAM 10/23/20
        Item := SalesLine.GetItem();
        IF Item."Carton Weight" = 0 THEN
            MESSAGE('Item %1 does not have a Carton Weight!\You will need to manually update the Box Weight', SalesLine."No.")
        ELSE
            //IF "Quantity (Base)" MOD Item."Units per Parcel" <> 0 THEN
            //  MESSAGE('Line Qty. does not match Carton Qty.\You will need to manually update the Box Weight')
            //ELSE
            //  "Box Weight" := Item."Carton Weight" * ("Quantity (Base)"/Item."Units per Parcel");
            SalesLine."Box Weight" := Item."Carton Weight";
        //<<CIS.RAM 10/23/20
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnAfterInitOutstanding, '', false, false)]
    local procedure OnAfterInitOutstanding(var SalesLine: Record "Sales Line")
    begin
        //>>NV
        SalesLine.UpdateWeight();
        //<<NV
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnBeforeInitQtyToShip, '', false, false)]
    local procedure OnBeforeInitQtyToShip(var SalesLine: Record "Sales Line"; FieldNo: Integer; var IsHandled: Boolean)
    begin
        //TODO
        /*  IsHandled := true;
         // >> Shipping
         // Qty. to Ship has been set to zero for not accidentially shipping the line when posting.
         // This is not a Shipping Specific problem but and general "Feature" in Navision
         // "Qty. to Ship" := "Outstanding Quantity";
         // "Qty. to Ship (Base)" := "Outstanding Qty. (Base)";
         IF SalesLine."Drop Shipment" THEN BEGIN
             SalesSetup.GET();
             IF SalesSetup."Blank Drop Shipm. Qty. to Ship" AND (FieldNo <> SalesLine.FIELDNO("Qty. to Ship"))
             THEN BEGIN
                 SalesLine."Qty. to Ship" := 0;
                 SalesLine."Qty. to Ship (Base)" := 0;
             END ELSE BEGIN
                 SalesLine."Qty. to Ship" := SalesLine."Outstanding Quantity";
                 SalesLine."Qty. to Ship (Base)" := SalesLine."Outstanding Qty. (Base)";
             END;
         END ELSE BEGIN
             SalesLine."Qty. to Ship" := SalesLine."Outstanding Quantity";
             SalesLine."Qty. to Ship (Base)" := SalesLine."Outstanding Qty. (Base)";
         END;

         SalesLine."Std. Pack Qty. to Ship" := CalcStdPackQty("Qty. to Ship (Base)");
         SalesLine."Package Qty. to Ship" := CalcPackageQty("Std. Pack Qty. to Ship");
         // << Shipping

         SalesLine.CheckServItemCreation();

         SalesLine.InitQtyToInvoice(); */
        //TODO
    end;

    /*  local procedure GetSalesSetup()
     begin
         if not SalesSetupRead then
             SalesSetup.Get();
         SalesSetupRead := true;
     end; */

    [EventSubscriber(ObjectType::Table, database::"Sales Line", OnAfterUpdateAmountsDone, '', false, false)]
    local procedure OnAfterUpdateAmountsDone(var SalesLine: Record "Sales Line"; var xSalesLine: Record "Sales Line"; CurrentFieldNo: Integer)
    begin
        //TODO
        /*  // >> NV
         SalesLine."Net Unit Price" := 0;
         IF SalesLine.Quantity <> 0 THEN
             SalesLine."Net Unit Price" := SalesLineSalesLine.."Line Amount" / Quantity;
         SalesLine."Line Cost" := "Unit Cost (LCY)" * Quantity;

         SalesLine.GetAltPrice(CurrentFieldNo);
         // << PFC JAM

         //<<NV */
        //TODO
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Line", OnBeforeCheckItemAvailable, '', false, false)]
    local procedure OnBeforeCheckItemAvailable(var SalesLine: Record "Sales Line"; CalledByFieldNo: Integer; var IsHandled: Boolean; CurrentFieldNo: Integer; xSalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header")
    var
    /*  ItemCheckAvail: Codeunit "Item-Check Avail.";
     CalledByDateField: Boolean; */
    begin
        //TODO
        /*   IsHandled := true;

          if SalesLine."Shipment Date" = 0D then begin
              SalesLine.GetSalesHeader();
              if SalesHeader."Shipment Date" <> 0D then
                  SalesLine.Validate("Shipment Date", SalesHeader."Shipment Date")
              else
                  SalesLine.Validate("Shipment Date", WorkDate());
          end;

          if ((CalledByFieldNo = CurrentFieldNo) or (CalledByFieldNo = SalesLine.FieldNo("Shipment Date"))) and GuiAllowed and
             (SalesLine."Document Type" in [SalesLine."Document Type"::Order, SalesLine."Document Type"::Invoice]) and
             (SalesLine.Type = SalesLine.Type::Item) and (SalesLine."No." <> '') and
             (SalesLine."Outstanding Quantity" > 0) and
             (SalesLine."Job Contract Entry No." = 0) and
             not SalesLine."Special Order" then BEGIN
              CalledByDateField :=
                CalledByFieldNo IN [SalesLine.FIELDNO("Shipment Date"), SalesLine.FIELDNO("Requested Delivery Date"), SalesLine.FIELDNO("Promised Delivery Date"),
                                    SalesLine.FIELDNO("Planned Shipment Date"), SalesLine.FIELDNO("Planned Delivery Date")];
              IF ItemCheckAvail.SalesLineCheck(SalesLine, CalledByDateField) THEN
                  ItemCheckAvail.RaiseUpdateInterruptedError();
          end; */
        //TODO
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Line", OnBeforeCreateDim, '', false, false)]
    local procedure OnBeforeCreateDim(var IsHandled: Boolean; var SalesLine: Record "Sales Line"; FieldNo: Integer; DefaultDimSource: List of [Dictionary of [Integer, Code[20]]])
    begin
        // >> EDI
        IF EDITemp THEN
            IsHandled := true;
        // << EDI
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Line", OnBeforeValidateShortcutDimCode, '', false, false)]
    local procedure OnBeforeValidateShortcutDimCode(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; FieldNumber: Integer; var ShortcutDimCode: Code[20]; var IsHandled: Boolean)
    begin
        // >> EDI
        IF EDITemp THEN
            IsHandled := true;
        // << EDI
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Line", OnBeforeLookupShortcutDimCode, '', false, false)]
    local procedure OnBeforeLookupShortcutDimCode(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; FieldNumber: Integer; var ShortcutDimCode: Code[20]; var IsHandled: Boolean)
    begin
        // >> EDI
        IF EDITemp THEN
            IsHandled := true;
        // << EDI
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Line", OnAfterGetUnitCost, '', false, false)]
    local procedure OnAfterGetUnitCost(var SalesLine: Record "Sales Line"; Item: Record Item)
    begin
        //CIS.RAM 09/10/2017 Reopened following four lines of code
        //>> WC AVG COST FIX
        // {
        //       IF (Item."Costing Method" <> Item."Costing Method"::Average) AND
        //         (Item."Costing Method" <> Item."Costing Method"::FIFO) AND
        //         (Item."Costing Method" <> Item."Costing Method"::LIFO)
        //       THEN BEGIN
        //             IF GetSKU THEN
        //                 VALIDATE("Unit Cost (LCY)", SKU."Unit Cost" * "Qty. per Unit of Measure")
        //             ELSE
        //                 VALIDATE("Unit Cost (LCY)", Item."Unit Cost" * "Qty. per Unit of Measure");
        //         END ELSE BEGIN
        //             IF GetSKU THEN BEGIN
        //                 InvtSetup.GET('');
        //                 IF InvtSetup."Average Cost Calc. Type" = InvtSetup."Average Cost Calc. Type"::"Item & Location & Variant" THEN BEGIN
        //                     Item.SETRANGE("Location Filter", "Location Code");
        //                     Item.SETRANGE("Variant Filter", "Variant Code");
        //                 END;
        //                 ItemCostMgt.CalculateAverageInclExpCost(Item, AverageCostLCY, AverageCostACY);
        //                 IF AverageCostLCY = 0 THEN
        //                     VALIDATE("Unit Cost (LCY)", SKU."Unit Cost" * "Qty. per Unit of Measure")
        //                 ELSE
        //                     VALIDATE("Unit Cost (LCY)", AverageCostLCY * "Qty. per Unit of Measure");
        //             END ELSE BEGIN
        //                 ItemCostMgt.CalculateAverageInclExpCost(Item, AverageCostLCY, AverageCostACY);
        //                 IF AverageCostLCY = 0 THEN
        //                     VALIDATE("Unit Cost (LCY)", Item."Unit Cost" * "Qty. per Unit of Measure")
        //                 ELSE
        //                     VALIDATE("Unit Cost (LCY)", AverageCostLCY * "Qty. per Unit of Measure");
        //             END;
        //         END;
        //       // << AVG COST FIX
        //                     }
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnBeforeGetLineAmountToHandle, '', false, false)]
    local procedure OnBeforeGetLineAmountToHandle(var QtyToHandle: Decimal; var SalesLine: Record "Sales Line"; Currency: Record Currency; var IsHandled: Boolean)
    begin
        IF SalesLine."Line Discount %" = 100 THEN
            QtyToHandle := 0;
    end;
}