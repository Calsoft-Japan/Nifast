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
}
