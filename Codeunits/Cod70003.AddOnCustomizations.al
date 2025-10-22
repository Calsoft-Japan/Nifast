codeunit 70003 AddOnCustomizations
{
    procedure PrintPackageLineLabel(PackageLine: Record "LAX Package Line"; QuantityAdded: Decimal; QuantityBaseAdded: Decimal; ManualPrinting: Boolean)
    var
        PackingRule: Record "Packing Rule";
        PackageLineLabel: Report "Package Line Label";
        Package: Record "LAX Package";
        Item: Record Item;
        NumLabels: Decimal;
        PackageLineRequest: Page "Package Line Label Request";
    begin
        IF PackageLine.Type <> PackageLine.Type::Item THEN
            EXIT;

        Package.GET(PackageLine."Package No.");
        PackingRule.GetPackingRule(
          Package."Ship-to Type", Package."Ship-to No.", Package."Ship-to Code");


        IF NOT PackingRule."Automatic Print Label" AND NOT ManualPrinting THEN
            EXIT;

        IF PackingRule."Package Line Label Code" <> '' THEN BEGIN
            CLEAR(PackageLineLabel);
            PackageLine.SETRECFILTER;
            PackageLineLabel.SETTABLEVIEW(PackageLine);
            CASE PackingRule."No. of Labels" OF
                PackingRule."No. of Labels"::Quantity:
                    PackageLineLabel.InitializeRequest(PackingRule."Package Line Label Code", QuantityAdded);
                PackingRule."No. of Labels"::"Quantity (Base)":
                    PackageLineLabel.InitializeRequest(PackingRule."Package Line Label Code", QuantityBaseAdded);
                ELSE
                    PackageLineLabel.InitializeRequest(PackingRule."Package Line Label Code", 1);
            END;

            //>>istrtt 7741 08/27/03
            //PackageLineLabel.USEREQUESTFORM(FALSE);
            //PackageLineLabel.RUNMODAL;
            COMMIT;
            PackageLineRequest.SETTABLEVIEW(PackageLine);
            PackageLineRequest.RUNMODAL;
            CLEAR(PackageLineRequest);
            //<<
        END;
    end;

    procedure PrintPostedPackageLineLabel(PostedPackageLine: Record "LAX Posted Package Line"; QuantityAdded: Decimal; QuantityBaseAdded: Decimal; ManualPrinting: Boolean)
    var
        PostedPackage: Record "LAX Posted Package";
        PackingRule: Record "Packing Rule";
        PackageLineLabel: Report "Package Line Label";
        PostedPackageLineRequest: Page "Posted Package Line Label Req.";
    begin
        IF PostedPackageLine.Type <> PostedPackageLine.Type::Item THEN
            EXIT;

        PostedPackage.GET(PostedPackageLine."Package No.");
        PackingRule.GetPackingRule(
          PostedPackage."Ship-to Type", PostedPackage."Ship-to No.", PostedPackage."Ship-to Code");

        IF NOT PackingRule."Automatic Print Label" AND NOT ManualPrinting THEN
            EXIT;

        IF PackingRule."Package Line Label Code" <> '' THEN BEGIN
            CLEAR(PackageLineLabel);
            PostedPackageLine.SETRECFILTER;
            PackageLineLabel.SETTABLEVIEW(PostedPackageLine);
            CASE PackingRule."No. of Labels" OF
                PackingRule."No. of Labels"::Quantity:
                    PackageLineLabel.InitializeRequest(PackingRule."Package Line Label Code", QuantityAdded);
                PackingRule."No. of Labels"::"Quantity (Base)":
                    PackageLineLabel.InitializeRequest(PackingRule."Package Line Label Code", QuantityBaseAdded);
                ELSE
                    PackageLineLabel.InitializeRequest(PackingRule."Package Line Label Code", 1);
            END;
            //>>istrtt 7741 08/27/03
            //PackageLineLabel.USEREQUESTFORM(FALSE);
            //PackageLineLabel.RUNMODAL;
            COMMIT;
            PostedPackageLineRequest.SETTABLEVIEW(PostedPackageLine);
            PostedPackageLineRequest.RUNMODAL;
            CLEAR(PostedPackageLineRequest);
            //<<
        END;
    end;

    procedure CreatePackageNIF(var Package: Record "LAX Package"; var PackingControl: Record "LAX Packing Control"): Boolean
    var
        Package2: Record "LAX Package";
        PackageLine: Record "LAX Package Line";
        SalesHeader: Record "Sales Header";
    begin

        Package.RESET;
        Package.INIT;
        //Package.VALIDATE(Package."No.",PackingControl."Warehouse Package No.");
        Package.VALIDATE(Package."No.", PackingControl."Tote No.");
        //>>IST 012609 CCL $12797 #12797
        //>>IST 081208 CCL $12797 #12797
        //Package."Sales Order No." := PackingControl."Multi Sales Order No.";
        //Package."Source ID" := PackingControl."Multi Document No.";
        //<<IST 081208 CCL $12797 #12797
        Package."Source Type" := PackingControl."Source Type";
        Package."Source Subtype" := PackingControl."Source Subtype";
        Package."Source ID" := PackingControl."Source ID";
        IF PackingControl."Multi Document Package" THEN BEGIN
            Package."Multi Document Package" := TRUE;
            Package."Multi Document No." := PackingControl."Multi Document No.";
        END;
        //<<IST 012609 CCL $12797 #12797
        Package."Package No." := 1;
        Package."Total Packages" := 1;
        Package.INSERT(TRUE);
        Package.ClearTotalValueFields;
        Package.TotalNetWeight;

        //>>IST 081208 CCL $12797 #12797
        //SalesHeader.GET(SalesHeader."Document Type"::Order,Package."Sales Order No.");
        SalesHeader.GET(SalesHeader."Document Type"::Order, Package."Source ID");
        //Package.TransferFromSalesHeader(SalesHeader);
        PackingControl.TransferFromSalesHeader(SalesHeader);
        //<<IST 081208 CCL $12797 #12797
        Package.MODIFY(TRUE);

        EXIT(TRUE);
    end;

    procedure CreatePackageLineNIF(var Package: Record "LAX Package"; var PackingControl: Record "LAX Packing Control"; QuantityToAdd: Decimal; Summary: Boolean): Boolean
    var
        PackageLine: Record "Package Line";
        PackageLine2: Record "LAX Package Line";
        QuantityEntered: Decimal;
        QuantityInPackage: Decimal;
        ">>NIF_LV": Integer;
        QtyRemToAdd: Decimal;
        UseLineNo: Integer;
    begin
        PackageLine.RESET;
        PackageLine.SETRANGE("Package No.", Package."No.");
        PackageLine.SETRANGE(Type, PackingControl."Input Type");
        PackageLine.SETRANGE("No.", PackingControl."Input No.");
        PackageLine.SETRANGE("Variant Code", PackingControl."Input Variant Code");
        PackageLine.SETRANGE("Unit of Measure Code", PackingControl."Input Unit of Measure Code");
        //>>10-21-05
        IF (NOT Summary) THEN BEGIN
            //<<10-21-05
            PackageLine.SETRANGE("Serial No.", '');
            PackageLine.SETRANGE("Lot No.", '');
            //>>10-21-05
        END;
        //<<10-21-05
        PackageLine.SETRANGE("Warranty Date", 0D);
        PackageLine.SETRANGE("Expiration Date", 0D);
        PackageLine.SETRANGE("Order Line No.", PackingControl."Order Line No.");

        IF PackageLine.FIND('-') THEN BEGIN
            PackageLine.VALIDATE(Quantity, PackageLine.Quantity + QuantityToAdd);
            PackageLine.MODIFY(TRUE);
        END ELSE BEGIN
            PackageLine.RESET;
            PackageLine.SETRANGE("Package No.", Package."No.");
            IF PackageLine.FIND('+') THEN
                PackageLine."Line No." := PackageLine."Line No." + 10000
            ELSE
                PackageLine."Line No." := 10000;
            PackageLine."Package No." := Package."No.";
            PackageLine.INIT;
            //>>IST 012609 CCL $12797 #12797
            PackageLine."Source Type" := Package."Source Type";
            PackageLine."Source Subtype" := Package."Source Subtype";
            //<<IST 012609 CCL $12797 #12797
            //>>IST 081208 CCL $12797 #12797
            //  PackageLine."Sales Order No." := Package."Sales Order No.";
            PackageLine."Source ID" := Package."Source ID";
            //<<IST 081208 CCL $12797 #12797
            PackageLine.VALIDATE(Type, PackageLine.Type::Item);
            PackageLine.VALIDATE("No.", PackingControl."Input No.");
            IF PackingControl."Input Variant Code" <> '' THEN
                PackageLine.VALIDATE("Variant Code", PackingControl."Input Variant Code");
            IF PackingControl."Input No." <> '' THEN
                PackageLine.VALIDATE(Quantity, QuantityToAdd)
            ELSE
                PackageLine.VALIDATE(Quantity, 0);
            PackageLine.VALIDATE("Unit of Measure Code", PackingControl."Input Unit of Measure Code");
            /*
            IF PackageLine.OverPackError THEN BEGIN
              PackingControl."Error Message" := 'Over Pack';
              EXIT(FALSE);
            END;
            */
            PackageLine.SetCreatedFromPick;  //NIF
                                             //>>10-21-05
            IF (NOT Summary) THEN BEGIN
                //<<10-21-05
                IF PackingControl."Pack Lot Number" AND (PackingControl."Input Lot Number" <> '') THEN
                    PackageLine.VALIDATE("Lot No.", PackingControl."Input Lot Number");
                PackageLine."Mfg. Lot No." := PackingControl."Mfg. Lot No.";
                PackageLine."Location Code" := PackingControl."Location Code";
                PackageLine."Bin Code" := PackingControl."Bin Code";
                //>>10-21-05
            END;
            //<<10-21-05
            PackageLine."Order Line No." := PackingControl."Order Line No.";
            UpdatePkgLineFromOrderLine(PackageLine, PackingControl);

            IF PackingControl."Pack Warranty Date" AND (PackingControl."Input Warranty Date" <> 0D) THEN
                PackageLine.VALIDATE("Warranty Date", PackingControl."Input Warranty Date");

            IF PackingControl."Pack Expiration Date" AND (PackingControl."Input Expiration Date" <> 0D) THEN
                PackageLine.VALIDATE("Expiration Date", PackingControl."Input Expiration Date");

            PackageLine.VALIDATE("Scanned No.", PackingControl."Scanned No.");

            IF PackingControl."Pack Serial Number" AND (PackingControl."Input Serial Number" = '')
            THEN BEGIN
                QuantityEntered := 0;
                WHILE QuantityEntered < QuantityToAdd DO BEGIN
                    QuantityEntered := QuantityEntered + 1;
                    PackageLine.VALIDATE(Quantity, 1);
                    IF QuantityEntered > 1 THEN
                        PackageLine."Line No." := PackageLine."Line No." + 10000;
                    IF PackageLine.OverPackError THEN BEGIN
                        PackingControl."Error Message" := 'Over Pack';
                        EXIT(FALSE);
                    END;
                    PackageLine.INSERT(TRUE);
                END;
            END ELSE BEGIN
                IF PackingControl."Input Serial Number" <> '' THEN BEGIN
                    PackageLine2.RESET;
                    PackageLine2.SETCURRENTKEY("No.", "Serial No.");
                    PackageLine2.SETRANGE("No.", PackingControl."Input No.");
                    PackageLine2.SETRANGE("Serial No.", PackingControl."Input Serial Number");
                    IF PackageLine2.FIND('-') THEN BEGIN
                        PackingControl."Error Message" :=
                          STRSUBSTNO(
                            'Duplicate Serial Number on sales order %1 package %2 is packed but not shipped.',
                            //>>IST 081208 CCL $12797 #12797
                            //            PackageLine2."Sales Order No.",PackageLine2."Package No.");
                            PackageLine2."Source ID", PackageLine2."Package No.");
                        //<<IST 081208 CCL $12797 #12797
                        EXIT(FALSE);
                    END;

                    PackageLine.VALIDATE("Serial No.", PackingControl."Input Serial Number");
                END;
                PackageLine.INSERT(TRUE);
            END;
        END;

        EXIT(TRUE);

    end;

    PROCEDURE InitTrackingSpecificationSalesLine(VAR SalesLine: Record 37; VAR TrackingSpecification: Record 336);
    BEGIN
        TrackingSpecification.INIT;
        TrackingSpecification."Source Type" := DATABASE::"Sales Line";
        TrackingSpecification."Item No." := SalesLine."No.";
        TrackingSpecification."Location Code" := SalesLine."Location Code";
        TrackingSpecification.Description := SalesLine.Description;
        TrackingSpecification."Variant Code" := SalesLine."Variant Code";
        TrackingSpecification."Source Subtype" := SalesLine."Document Type".AsInteger();
        TrackingSpecification."Source ID" := SalesLine."Document No.";
        TrackingSpecification."Source Batch Name" := '';
        TrackingSpecification."Source Prod. Order Line" := 0;
        TrackingSpecification."Source Ref. No." := SalesLine."Line No.";
        TrackingSpecification."Quantity (Base)" := SalesLine."Quantity (Base)";
        TrackingSpecification."Qty. to Invoice (Base)" := SalesLine."Qty. to Invoice (Base)";
        TrackingSpecification."Qty. to Invoice" := SalesLine."Qty. to Invoice";
        TrackingSpecification."Quantity Invoiced (Base)" := SalesLine."Qty. Invoiced (Base)";
        TrackingSpecification."Qty. per Unit of Measure" := SalesLine."Qty. per Unit of Measure";
        TrackingSpecification."Bin Code" := SalesLine."Bin Code";

        IF SalesLine."Document Type" IN [SalesLine."Document Type"::"Return Order", SalesLine."Document Type"::"Credit Memo"] THEN BEGIN
            TrackingSpecification."Qty. to Handle (Base)" := SalesLine."Return Qty. to Receive (Base)";
            TrackingSpecification."Quantity Handled (Base)" := SalesLine."Return Qty. Received (Base)";
            TrackingSpecification."Qty. to Handle" := SalesLine."Return Qty. to Receive";
        END ELSE BEGIN
            TrackingSpecification."Qty. to Handle (Base)" := SalesLine."Qty. to Ship (Base)";
            TrackingSpecification."Quantity Handled (Base)" := SalesLine."Qty. Shipped (Base)";
            TrackingSpecification."Qty. to Handle" := SalesLine."Qty. to Ship";
        END;
    END;

    PROCEDURE InitTrackingSpecificationReqLine(VAR ReqLine: Record 246; VAR TrackingSpecification: Record 336);
    BEGIN
        TrackingSpecification.INIT;
        TrackingSpecification."Source Type" := DATABASE::"Requisition Line";
        TrackingSpecification."Item No." := ReqLine."No.";
        TrackingSpecification."Location Code" := ReqLine."Location Code";
        TrackingSpecification.Description := ReqLine.Description;
        TrackingSpecification."Variant Code" := ReqLine."Variant Code";
        TrackingSpecification."Source Subtype" := 0;
        TrackingSpecification."Source ID" := ReqLine."Worksheet Template Name";
        TrackingSpecification."Source Batch Name" := ReqLine."Journal Batch Name";
        TrackingSpecification."Source Prod. Order Line" := 0;
        TrackingSpecification."Source Ref. No." := ReqLine."Line No.";
        TrackingSpecification."Quantity (Base)" := ReqLine."Quantity (Base)";
        TrackingSpecification."Qty. to Handle" := ReqLine.Quantity;
        TrackingSpecification."Qty. to Handle (Base)" := ReqLine."Quantity (Base)";
        TrackingSpecification."Qty. to Invoice" := ReqLine.Quantity;
        TrackingSpecification."Qty. to Invoice (Base)" := ReqLine."Quantity (Base)";
        TrackingSpecification."Quantity Handled (Base)" := 0;
        TrackingSpecification."Quantity Invoiced (Base)" := 0;
        TrackingSpecification."Qty. per Unit of Measure" := ReqLine."Qty. per Unit of Measure";
    END;

    PROCEDURE InitTrackingSpecificationPurchLine(VAR PurchLine: Record 39; VAR TrackingSpecification: Record 336);
    BEGIN
        TrackingSpecification.INIT;
        TrackingSpecification."Source Type" := DATABASE::"Purchase Line";
        TrackingSpecification."Item No." := PurchLine."No.";
        TrackingSpecification."Location Code" := PurchLine."Location Code";
        TrackingSpecification.Description := PurchLine.Description;
        TrackingSpecification."Variant Code" := PurchLine."Variant Code";
        TrackingSpecification."Source Subtype" := PurchLine."Document Type".AsInteger();
        TrackingSpecification."Source ID" := PurchLine."Document No.";
        TrackingSpecification."Source Batch Name" := '';
        TrackingSpecification."Source Prod. Order Line" := 0;
        TrackingSpecification."Source Ref. No." := PurchLine."Line No.";
        TrackingSpecification."Quantity (Base)" := PurchLine."Quantity (Base)";
        TrackingSpecification."Qty. to Invoice (Base)" := PurchLine."Qty. to Invoice (Base)";
        TrackingSpecification."Qty. to Invoice" := PurchLine."Qty. to Invoice";
        TrackingSpecification."Quantity Invoiced (Base)" := PurchLine."Qty. Invoiced (Base)";
        TrackingSpecification."Qty. per Unit of Measure" := PurchLine."Qty. per Unit of Measure";
        TrackingSpecification."Bin Code" := PurchLine."Bin Code";

        IF PurchLine."Document Type" IN [PurchLine."Document Type"::"Return Order", PurchLine."Document Type"::"Credit Memo"] THEN BEGIN
            TrackingSpecification."Qty. to Handle (Base)" := PurchLine."Return Qty. to Ship (Base)";
            TrackingSpecification."Quantity Handled (Base)" := PurchLine."Return Qty. Shipped (Base)";
            TrackingSpecification."Qty. to Handle" := PurchLine."Return Qty. to Ship";
        END ELSE BEGIN
            TrackingSpecification."Qty. to Handle (Base)" := PurchLine."Qty. to Receive (Base)";
            TrackingSpecification."Quantity Handled (Base)" := PurchLine."Qty. Received (Base)";
            TrackingSpecification."Qty. to Handle" := PurchLine."Qty. to Receive";
        END;
    END;

    PROCEDURE InitTrackingSpecificationItemJnlLine(VAR ItemJnlLine: Record 83; VAR TrackingSpecification: Record 336);
    BEGIN
        TrackingSpecification.INIT;
        TrackingSpecification."Source Type" := DATABASE::"Item Journal Line";
        TrackingSpecification."Item No." := ItemJnlLine."Item No.";
        TrackingSpecification."Location Code" := ItemJnlLine."Location Code";
        TrackingSpecification.Description := ItemJnlLine.Description;
        TrackingSpecification."Variant Code" := ItemJnlLine."Variant Code";
        TrackingSpecification."Source Subtype" := ItemJnlLine."Entry Type".AsInteger();
        TrackingSpecification."Source ID" := ItemJnlLine."Journal Template Name";
        TrackingSpecification."Source Batch Name" := ItemJnlLine."Journal Batch Name";
        TrackingSpecification."Source Prod. Order Line" := 0;
        TrackingSpecification."Source Ref. No." := ItemJnlLine."Line No.";
        TrackingSpecification."Quantity (Base)" := ItemJnlLine."Quantity (Base)";
        TrackingSpecification."Qty. to Handle" := ItemJnlLine.Quantity;
        TrackingSpecification."Qty. to Handle (Base)" := ItemJnlLine."Quantity (Base)";
        TrackingSpecification."Qty. to Invoice" := ItemJnlLine.Quantity;
        TrackingSpecification."Qty. to Invoice (Base)" := ItemJnlLine."Quantity (Base)";
        TrackingSpecification."Quantity Handled (Base)" := 0;
        TrackingSpecification."Quantity Invoiced (Base)" := 0;
        TrackingSpecification."Qty. per Unit of Measure" := ItemJnlLine."Qty. per Unit of Measure";
        TrackingSpecification."Bin Code" := ItemJnlLine."Bin Code";
    END;

    PROCEDURE InitTrackingSpecificationTransLine(VAR TransLine: Record 5741; VAR TrackingSpecification: Record 336; VAR AvalabilityDate: Date; Direction: option Outbound,Inbound);
    BEGIN
        TrackingSpecification."Source Type" := DATABASE::"Transfer Line";
        TrackingSpecification."Item No." := TransLine."Item No.";
        TrackingSpecification.Description := TransLine.Description;
        TrackingSpecification."Variant Code" := TransLine."Variant Code";
        TrackingSpecification."Source Subtype" := Direction;
        TrackingSpecification."Source ID" := TransLine."Document No.";
        TrackingSpecification."Source Batch Name" := '';
        TrackingSpecification."Source Prod. Order Line" := TransLine."Derived From Line No.";
        TrackingSpecification."Source Ref. No." := TransLine."Line No.";
        TrackingSpecification."Quantity (Base)" := TransLine."Quantity (Base)";
        TrackingSpecification."Qty. to Invoice (Base)" := TransLine."Quantity (Base)";
        TrackingSpecification."Qty. to Invoice" := TransLine.Quantity;
        TrackingSpecification."Quantity Invoiced (Base)" := 0;
        TrackingSpecification."Qty. per Unit of Measure" := TransLine."Qty. per Unit of Measure";
        TrackingSpecification."Location Code" := '';
        CASE Direction OF
            Direction::Outbound:
                BEGIN
                    TrackingSpecification."Location Code" := TransLine."Transfer-from Code";
                    TrackingSpecification."Bin Code" := TransLine."Transfer-from Bin Code";
                    TrackingSpecification."Qty. to Handle (Base)" := TransLine."Qty. to Ship (Base)";
                    TrackingSpecification."Qty. to Handle" := TransLine."Qty. to Ship";
                    TrackingSpecification."Quantity Handled (Base)" := TransLine."Qty. Shipped (Base)";
                    AvalabilityDate := TransLine."Shipment Date";
                END;
            Direction::Inbound:
                BEGIN
                    TrackingSpecification."Location Code" := TransLine."Transfer-to Code";
                    TrackingSpecification."Bin Code" := TransLine."Transfer-To Bin Code";
                    TrackingSpecification."Qty. to Handle (Base)" := TransLine."Qty. to Receive (Base)";
                    TrackingSpecification."Qty. to Handle" := TransLine."Qty. to Receive";
                    TrackingSpecification."Quantity Handled (Base)" := TransLine."Qty. Received (Base)";
                    AvalabilityDate := TransLine."Receipt Date";
                END;
        END;
    END;

    PROCEDURE InitTrackingSpecificationProdOrderLine(VAR ProdOrderLine: Record 5406; VAR TrackingSpecification: Record 336);
    BEGIN
        TrackingSpecification.INIT;
        TrackingSpecification."Source Type" := DATABASE::"Prod. Order Line";
        TrackingSpecification."Item No." := ProdOrderLine."Item No.";
        TrackingSpecification."Location Code" := ProdOrderLine."Location Code";
        TrackingSpecification.Description := ProdOrderLine.Description;
        TrackingSpecification."Variant Code" := ProdOrderLine."Variant Code";
        TrackingSpecification."Source Subtype" := ProdOrderLine.Status.AsInteger();
        TrackingSpecification."Source ID" := ProdOrderLine."Prod. Order No.";
        TrackingSpecification."Source Batch Name" := '';
        TrackingSpecification."Source Prod. Order Line" := ProdOrderLine."Line No.";
        TrackingSpecification."Source Ref. No." := 0;
        TrackingSpecification."Quantity (Base)" := ProdOrderLine."Quantity (Base)";
        TrackingSpecification."Qty. to Handle" := ProdOrderLine."Remaining Quantity";
        TrackingSpecification."Qty. to Handle (Base)" := ProdOrderLine."Remaining Qty. (Base)";
        TrackingSpecification."Qty. to Invoice" := ProdOrderLine."Remaining Quantity";
        TrackingSpecification."Qty. to Invoice (Base)" := ProdOrderLine."Remaining Qty. (Base)";
        TrackingSpecification."Quantity Handled (Base)" := ProdOrderLine."Finished Qty. (Base)";
        TrackingSpecification."Quantity Invoiced (Base)" := ProdOrderLine."Finished Qty. (Base)";
        TrackingSpecification."Qty. per Unit of Measure" := ProdOrderLine."Qty. per Unit of Measure";
    END;

    PROCEDURE InitTrackingSpecificationProdOrderComp(VAR ProdOrderComp: Record 5407; VAR TrackingSpecification: Record 336);
    BEGIN
        TrackingSpecification.INIT;
        TrackingSpecification."Source Type" := DATABASE::"Prod. Order Component";
        TrackingSpecification."Item No." := ProdOrderComp."Item No.";
        TrackingSpecification."Location Code" := ProdOrderComp."Location Code";
        TrackingSpecification."Bin Code" := ProdOrderComp."Bin Code";
        TrackingSpecification.Description := ProdOrderComp.Description;
        TrackingSpecification."Variant Code" := ProdOrderComp."Variant Code";
        TrackingSpecification."Source Subtype" := ProdOrderComp.Status.AsInteger();
        TrackingSpecification."Source ID" := ProdOrderComp."Prod. Order No.";
        TrackingSpecification."Source Batch Name" := '';
        TrackingSpecification."Source Prod. Order Line" := ProdOrderComp."Prod. Order Line No.";
        TrackingSpecification."Source Ref. No." := ProdOrderComp."Line No.";
        TrackingSpecification."Quantity (Base)" := ProdOrderComp."Remaining Qty. (Base)";
        TrackingSpecification."Qty. to Handle" := ProdOrderComp."Remaining Quantity";
        TrackingSpecification."Qty. to Handle (Base)" := ProdOrderComp."Remaining Qty. (Base)";
        TrackingSpecification."Qty. to Invoice" := ProdOrderComp."Remaining Quantity";
        TrackingSpecification."Qty. to Invoice (Base)" := ProdOrderComp."Remaining Qty. (Base)";
        TrackingSpecification."Quantity Handled (Base)" := ProdOrderComp."Expected Qty. (Base)" - ProdOrderComp."Remaining Qty. (Base)";
        TrackingSpecification."Quantity Invoiced (Base)" := ProdOrderComp."Expected Qty. (Base)" - ProdOrderComp."Remaining Qty. (Base)";
        TrackingSpecification."Qty. per Unit of Measure" := ProdOrderComp."Qty. per Unit of Measure";
    END;

}
