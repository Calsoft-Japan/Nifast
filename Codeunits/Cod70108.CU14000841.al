namespace Nifast.Nifast;

codeunit 70108 CU_14000841
{
    PROCEDURE "<<NIF fcns>>"();
    BEGIN
    END;

    PROCEDURE PrintPackageLineLabel(PackageLine: Record 14000702; QuantityAdded: Decimal; QuantityBaseAdded: Decimal; ManualPrinting: Boolean);
    VAR
        PackingRule: Record 14000715;
        PackageLineLabel: Report 50041;
        Package: Record 14000701;
        Item: Record 27;
        NumLabels: Decimal;
        PackageLineRequest: Page 50038;
    BEGIN

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
    END;

    PROCEDURE PrintPostedPackageLineLabel(PostedPackageLine: Record 14000705; QuantityAdded: Decimal; QuantityBaseAdded: Decimal; ManualPrinting: Boolean);
    VAR
        PostedPackage: Record 14000704;
        PackingRule: Record 14000715;
        PackageLineLabel: Report 50041;
        PostedPackageLineRequest: Page 50041;
    BEGIN

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
    END;

}
