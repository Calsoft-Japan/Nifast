namespace Nifast.Nifast;

codeunit 70109 CU_14000702
{
    LOCAL PROCEDURE "<<NIF fcn>>"();
    BEGIN
    END;

    LOCAL PROCEDURE PrintSalesShipmentPackingList(SalesHeader: Record 36);
    VAR
        PackingRule: Record 14000715;
        SalesShptHdr: Record 110;
        ShippingSetup: Record 14000707;
        SalesSetup: Record 311;
    BEGIN

        //>>>>>>
        SalesShptHdr.SETCURRENTKEY("Order No.");
        SalesShptHdr.SETRANGE("Order No.", SalesHeader."No.");
        IF NOT SalesShptHdr.FIND('+') THEN
            EXIT;
        //<<<<<<


        //>>>>>>>>>>>>>>>>
        //GetShippingSetup;
        ShippingSetup.GET;
        //<<<<<<<<<<<<<<<<

        PackingRule.GetPackingRule(0, SalesHeader."Sell-to Customer No.", SalesHeader."Ship-to Code");

        //>>>>>>>>>>>>>>>>
        //IF GiveError AND (PackingRule."Close Order Report ID" = 0) THEN
        //  ShippingSetup.TESTFIELD("Close Order Report ID");
        //>>IST 081208 CCL $12797 #12797
        //IF (PackingRule."Close Order Report ID" = 0) AND (ShippingSetup."Close Order Report ID"=0) THEN
        IF (PackingRule."Close Sales Report ID" = 0) AND (ShippingSetup."Close Sales Report ID" = 0) THEN
            //<<IST 081208 CCL $12797 #12797
            EXIT;
        //<<<<<<<<<<<<<<<<<

        //>>IST 081208 CCL $12797 #12797
        //IF ShippingSetup."Close Order Report ID" <> 0 THEN BEGIN
        IF ShippingSetup."Close Sales Report ID" <> 0 THEN BEGIN
            //<<IST 081208 CCL $12797 #12797
            //>>>>>>>>>>>>>>>>>>>>>>>>
            //SalesHeader.RESET;
            //SalesHeader.SETRECFILTER;
            //REPORT.RUNMODAL(ShippingSetup."Close Order Report ID",FALSE,TRUE,SalesHeader);

            //>>10-21-05 RTT
            //SalesShptHdr.SETRANGE("No.",SalesShptHdr."No.");
            //REPORT.RUNMODAL(ShippingSetup."Close Order Report ID",FALSE,TRUE,SalesShptHdr);
            SalesSetup.GET;
            IF SalesSetup."Enable Shipping - Picks" THEN BEGIN
                SalesShptHdr.SETRANGE("No.", SalesShptHdr."No.");
                REPORT.RUNMODAL(REPORT::"Sales Shpt. Packing List - CNF", FALSE, TRUE, SalesShptHdr);
            END ELSE BEGIN
                SalesShptHdr.SETRANGE("No.", SalesShptHdr."No.");
                //>>IST 081208 CCL $12797 #12797
                //    REPORT.RUNMODAL(ShippingSetup."Close Order Report ID",FALSE,TRUE,SalesShptHdr);
                REPORT.RUNMODAL(ShippingSetup."Close Sales Report ID", FALSE, TRUE, SalesShptHdr);
                //<<IST 081208 CCL $12797 #12797
            END;
            //<<<<<<<<<<<<<<<<<<<<<<<<
        END;

        //>>IST 081208 CCL $12797 #12797
        //IF PackingRule."Close Order Report ID" <> 0 THEN BEGIN
        IF PackingRule."Close Sales Report ID" <> 0 THEN BEGIN
            //<<IST 081208 CCL $12797 #12797
            //>>>>>>>>>>>>>>>>>>>>>>>>>>
            //SalesHeader.SETRECFILTER;
            //REPORT.RUNMODAL(PackingRule."Close Order Report ID",FALSE,TRUE,SalesHeader);
            SalesShptHdr.SETRANGE("No.", SalesShptHdr."No.");
            //>>IST 081208 CCL $12797 #12797
            //  REPORT.RUNMODAL(PackingRule."Close Order Report ID",FALSE,TRUE,SalesShptHdr);
            REPORT.RUNMODAL(PackingRule."Close Sales Report ID", FALSE, TRUE, SalesShptHdr);
            //<<IST 081208 CCL $12797 #12797
            //<<<<<<<<<<<<<<<<<<<<<<<<<<
        END;
    END;

    LOCAL PROCEDURE ValidateLotInfo(VAR PackingControl: Record 14000717; qty: Decimal): Boolean;
    VAR
        LotNoInfo: Record 6505;
        i: Integer;
        NumBins: Integer;
        Selection: Integer;
        BinContentBuffer: Record 7330;
        LocationBin: ARRAY[100, 100] OF Code[20];
        PackageLine: Record 14000702;
        QtyPacked: Decimal;
        UseLoc: Code[20];
        UseBin: Code[20];
        Bin: Record 7354;
        BinCOntrolForm: Page 50017;
        SelectionNo: Integer;
    BEGIN

        //exit if no lot entered
        IF PackingControl."Input Lot Number" = '' THEN
            EXIT(TRUE);

        //get lot no. info
        LotNoInfo.GET(PackingControl."Input No.", PackingControl."Input Variant Code", PackingControl."Input Lot Number");
        //>>10-25-05
        //LotNoInfo.GetBinContentArray(LocationBin);
        //LotNoInfo.GetBinContentBuffer(BinContentBuffer);

        LotNoInfo.GetBinContentBuffer(BinContentBuffer);
        i := 0;
        CLEAR(LocationBin);
        IF BinContentBuffer.FIND('-') THEN
            REPEAT
                IF (PackingControl."Location Code" = BinContentBuffer."Location Code") THEN BEGIN      // NF2.00:CIS.RAM <<<
                    i := i + 1;
                    LocationBin[i, 1] := BinContentBuffer."Location Code";
                    LocationBin[i, 2] := BinContentBuffer."Bin Code";
                END;                                                                                   // NF2.00:CIS.RAM <<<
            UNTIL BinContentBuffer.NEXT = 0;
        //<<10-25-05
        //
        // BinContentBuffer.CALCFIELDS("QC Bin");
        //BinContentBuffer.SETRANGE("QC Bin", FALSE);

        //error of no bin contents found
        //this also set pointer on buffer
        IF NOT BinContentBuffer.FIND('-') THEN BEGIN
            PackingControl."Error Message" := STRSUBSTNO('No Bin found for Lot No. %1, Item No. %2.',
                          LotNoInfo."Lot No.", LotNoInfo."Item No.");
            EXIT(FALSE);
        END;

        NumBins := (BinContentBuffer.COUNT);
        //if numbins=1 then exist with first location and bin found
        IF NumBins = 1 THEN BEGIN
            PackingControl."Location Code" := BinContentBuffer."Location Code";
            PackingControl."Bin Code" := BinContentBuffer."Bin Code";
        END
        ELSE
         //if more than one bin,build selection string from menu
         BEGIN
            //   {10-25-05
            //  CLEAR(MenuString);
            //     REPEAT
            //         i := i + 1;
            //         LocationBin[i, 1] := BinContentBuffer."Location Code";
            //         LocationBin[i, 2] := BinContentBuffer."Bin Code";

            //         IF i = 1 THEN
            //             MenuString := MenuString + LocationBin[i, 1] + '-' + LocationBin[i, 2]
            //         ELSE
            //             MenuString := MenuString + ', ' + LocationBin[i, 1] + '-' + LocationBin[i, 2];
            //     UNTIL BinContentBuffer.NEXT = 0;
            //   10-25-05}
            COMMIT;
            CLEAR(BinCOntrolForm);
            BinCOntrolForm.LOOKUPMODE(TRUE);
            BinCOntrolForm.SetCaptions(LocationBin);
            IF BinCOntrolForm.RUNMODAL = ACTION::LookupOK THEN BEGIN
                BinCOntrolForm.ReturnSelection(SelectionNo);
                UseLoc := LocationBin[SelectionNo, 1];
                UseBin := LocationBin[SelectionNo, 2];
            END;

            IF NOT Bin.GET(UseLoc, UseBin) THEN BEGIN
                PackingControl."Error Message" := 'Invalid Location-Bin ' + UseLoc + '-' + UseBin;
                EXIT(FALSE);
            END;

            IF Bin."QC Bin" THEN
                ERROR('You cannot ship from a QC Bin');

            BinContentBuffer.SETRANGE("Location Code", UseLoc);
            BinContentBuffer.SETRANGE("Bin Code", UseBin);
            BinContentBuffer.SETRANGE("Item No.", PackingControl."Input No.");
            BinContentBuffer.FIND('-');
            PackingControl."Location Code" := BinContentBuffer."Location Code";
            PackingControl."Bin Code" := BinContentBuffer."Bin Code";
        END;


        //check quantity
        //IF Qty > BinContentBuffer."Qty. to Handle" THEN
        IF qty > BinContentBuffer."Qty. to Handle (Base)" THEN BEGIN
            PackingControl."Error Message" :=
              STRSUBSTNO('Entered Qty of %1 exceeds Bin Qty of %2 for Lot %3.',
                   //Qty,BinContentBuffer."Qty. to Handle",PackingControl."Input Lot Number");
                   qty, BinContentBuffer."Qty. to Handle (Base)", PackingControl."Input Lot Number");
            EXIT(FALSE);
        END;

        //get qty already packed
        CLEAR(QtyPacked);
        PackageLine.SETCURRENTKEY(Type, "No.");
        PackageLine.SETRANGE(Type, PackageLine.Type::Item);
        PackageLine.SETRANGE("No.", PackingControl."Input No.");
        PackageLine.SETRANGE("Lot No.", PackingControl."Input Lot Number");
        PackageLine.SETRANGE("Bin Code", PackingControl."Bin Code");
        IF PackageLine.FIND('-') THEN
            REPEAT
                QtyPacked := QtyPacked + PackageLine."Quantity (Base)";
            UNTIL PackageLine.NEXT = 0;

        //IF Qty > BinContentBuffer."Qty. to Handle" - QtyPacked THEN
        IF qty > BinContentBuffer."Qty. to Handle (Base)" - QtyPacked THEN BEGIN
            PackingControl."Error Message" :=
              STRSUBSTNO('Entered Qty of %1 will exceed Bin %2 Qty of %3 for Lot No. %4.\' +
                         'A quantity of %5 has already been packed.',
                   qty, BinContentBuffer."Bin Code",
                      //BinContentBuffer."Qty. to Handle",PackingControl."Input Lot Number",QtyPacked);
                      BinContentBuffer."Qty. to Handle (Base)", PackingControl."Input Lot Number", QtyPacked);
            EXIT(FALSE);
        END;
        EXIT(TRUE);
    END;

    LOCAL PROCEDURE UpdatePkgLineFromOrderLine(VAR PkgLine: Record 14000702; PkgControl: Record 14000717);
    VAR
        SalesLine: Record 37;
        SalesHdr: Record 36;
    BEGIN

        //>>IST 081208 CCL $12797 #12797
        //IF NOT SalesLine.GET(SalesLine."Document Type"::Order,PkgLine."Sales Order No.",PkgLine."Order Line No.") THEN
        IF NOT SalesLine.GET(SalesLine."Document Type"::Order, PkgLine."Source ID", PkgLine."Order Line No.") THEN
            //<<IST 081208 CCL $12797 #12797
            EXIT;

        WITH SalesLine DO BEGIN
            PkgLine."Certificate No." := SalesLine."Certificate No.";
            PkgLine."Drawing No." := SalesLine."Drawing No.";
            PkgLine."Revision No." := SalesLine."Revision No.";
            PkgLine."Revision Date" := SalesLine."Revision Date";
            PkgLine."Location Code" := "Location Code";
            //  PkgLine."Cross Reference No." := "Cross-Reference No.";
            PkgLine."Storage Location" := "Storage Location";
            PkgLine."Line Supply Location" := "Line Supply Location";
            PkgLine."Deliver To" := "Deliver To";
            PkgLine."Receiving Area" := "Receiving Area";
            PkgLine."Ran No." := "Ran No.";
            PkgLine."Container No." := "Container No.";
            PkgLine."Kanban No." := "Kanban No.";
            PkgLine."Res. Mfg." := "Res. Mfg.";
            PkgLine."Release No." := "Release No.";
            PkgLine."Mfg. Date" := "Mfg. Date";
            PkgLine."Man No." := "Man No.";
            PkgLine."Delivery Order No." := "Delivery Order No.";
            PkgLine."Dock Code" := "Dock Code";
            PkgLine."Box Weight" := "Box Weight";
            PkgLine."Store Address" := "Store Address";
            PkgLine."FRS No." := "FRS No.";
            PkgLine."Main Route" := "Main Route";
            PkgLine."Line Side Address" := "Line Side Address";
            PkgLine."Sub Route Number" := "Sub Route Number";
            PkgLine."Special Markings" := "Special Markings";
            PkgLine."Eng. Change No." := "Eng. Change No.";
            //>> NIF 06-22-05
            IF "External Document No." <> '' THEN
                PkgLine."External Document No." := "External Document No."
            //>>IST 081208 CCL $12797 #12797
            //  ELSE IF SalesHdr.GET(SalesHdr."Document Type"::Order,PkgLine."Sales Order No.") THEN
            ELSE IF SalesHdr.GET(SalesHdr."Document Type"::Order, PkgLine."Source ID") THEN
                //<<IST 081208 CCL $12797 #12797
                PkgLine."External Document No." := SalesHdr."External Document No."
            //<<
        END;
    END;

    LOCAL PROCEDURE SetDefaultQuantity(PackingControl: Record 14000717; VAR WareHouseActLineNo_vInt: Integer; PackageNo_iCod: Code[20]): Decimal;
    VAR
        WhseActvLine: Record 5767;
        PackageLine_lRec: Record 14000702;
    BEGIN

        IF PackingControl."Input Type" <> PackingControl."Input Type"::Item THEN
            EXIT(0);
        WhseActvLine.SETCURRENTKEY("Source No.", "Source Line No.", "Source Subline No.", "Serial No.", "Lot No.");
        //>>IST 081208 CCL $12797 #12797
        //WhseActvLine.SETRANGE("Source No.",PackingControl."Multi Sales Order No.");
        //>>IST 012609 CCL $12797 #12797
        //WhseActvLine.SETRANGE("Source No.",PackingControl."Multi Document No.");
        IF PackingControl."Multi Document Package" THEN
            WhseActvLine.SETFILTER("Source No.", PackingControl."Multi Document No.")
        ELSE
            WhseActvLine.SETRANGE("Source No.", PackingControl."Source ID");
        //<<IST 012609 CCL $12797 #12797
        //<<IST 081208 CCL $12797 #12797
        WhseActvLine.SETRANGE("Lot No.", PackingControl."Input Lot Number");
        WhseActvLine.SETRANGE("Item No.", PackingControl."Input No.");
        WhseActvLine.SETRANGE("Activity Type", WhseActvLine."Activity Type"::"Invt. Pick");
        WhseActvLine.SETFILTER("Qty. Outstanding (Base)", '<>%1', 0);
        IF NOT WhseActvLine.FIND('-') THEN
            EXIT(0);

        //NileshGajjar-NS
        IF WhseActvLine.COUNT > 1 THEN BEGIN
            PackageLine_lRec.RESET;
            PackageLine_lRec.SETRANGE("Package No.", PackageNo_iCod);
            PackageLine_lRec.SETRANGE("No.", PackingControl."Input No.");
            PackageLine_lRec.SETRANGE("Lot No.", PackingControl."Input Lot Number");
            PackageLine_lRec.SETFILTER("Warehouse Act Line No.", '<>%1', 0);
            IF PackageLine_lRec.FINDLAST THEN BEGIN
                WhseActvLine.SETFILTER("Line No.", '>%1', PackageLine_lRec."Warehouse Act Line No.");
                IF NOT WhseActvLine.FIND('-') THEN
                    EXIT(0);
            END;
        END;
        WareHouseActLineNo_vInt := WhseActvLine."Line No.";
        //NileshGajjar-NE

        EXIT(WhseActvLine."Qty. Outstanding");
    END;

    LOCAL PROCEDURE FindSalesLineNumber(VAR PackingControl: Record 14000717; QtyToAdd: Decimal);
    VAR
        SalesLine: Record 37;
        PackageLine: Record 14000702;
        QtyOutStanding: Decimal;
        QtyPacked: Decimal;
    BEGIN

        IF PackingControl."Input Type" <> PackingControl."Input Type"::Item THEN
            EXIT;

        SalesLine.SETCURRENTKEY("Document Type", "Document No.", Type, "No.", "Variant Code", "Drop Shipment", "LAX Pack");
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
        //>>IST 081208 CCL $12797 #12797
        //IF PackingControl."Multi Sales Order" THEN
        //  SalesLine.SETFILTER("Document No.",PackingControl."Multi Sales Order No.")
        //ELSE
        //  SalesLine.SETRANGE("Document No.",PackingControl."Multi Sales Order No.");
        IF PackingControl."Multi Document Package" THEN
            SalesLine.SETFILTER("Document No.", PackingControl."Multi Document No.")
        ELSE
            SalesLine.SETRANGE("Document No.", PackingControl."Source ID");
        //<<IST 081208 CCL $12797 #12797
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        SalesLine.SETRANGE("No.", PackingControl."Input No.");
        SalesLine.SETRANGE("Drop Shipment", FALSE);
        SalesLine.SETRANGE("LAX Pack", TRUE);

        //if not more than one line, then exit
        IF SalesLine.COUNT <= 1 THEN
            EXIT;

        //if can't find sales line, then exit
        //>>IST 081208 CCL $12797 #12797
        //IF NOT SalesLine.GET(SalesLine."Document Type"::Order,PackingControl."Multi Sales Order No.",PackingControl."Order Line No.") THEN
        IF NOT SalesLine.GET(SalesLine."Document Type"::Order, PackingControl."Source ID", PackingControl."Order Line No.") THEN
            //<<IST 081208 CCL $12797 #12797
            EXIT;

        SalesLine.CALCFIELDS("LAX E-Ship Whse. Outst. Qty.", "LAX E-Ship Inventory Outst Qty");
        QtyOutStanding := SalesLine."LAX E-Ship Whse. Outst. Qty." + SalesLine."LAX E-Ship Inventory Outst Qty" +
                                  SalesLine."Qty. to Ship";

        //>>IST 081208 CCL $12797 #12797
        //PackageLine.SETCURRENTKEY("Sales Order No.","Order Line No.");
        PackageLine.SETCURRENTKEY("Source ID", "Order Line No.");
        //PackageLine.SETRANGE("Sales Order No.",SalesLine."Document No.");
        PackageLine.SETRANGE("Source ID", SalesLine."Document No.");
        //<<IST 081208 CCL $12797 #12797
        PackageLine.SETRANGE("Order Line No.", SalesLine."Line No.");
        PackageLine.CALCSUMS(Quantity);
        QtyPacked := PackageLine.Quantity + QtyToAdd;

        IF QtyPacked >= QtyOutStanding THEN BEGIN
            SalesLine.SETFILTER("Line No.", '<>%1', PackingControl."Order Line No.");
            SalesLine.FIND('-');
            REPEAT
                SalesLine.CALCFIELDS("LAX E-Ship Whse. Outst. Qty.", "LAX E-Ship Inventory Outst Qty");

                QtyOutStanding := SalesLine."LAX E-Ship Whse. Outst. Qty." + SalesLine."LAX E-Ship Inventory Outst Qty" +
                                   SalesLine."Qty. to Ship";

                //>>IST 081208 CCL $12797 #12797
                //       PackageLine.SETCURRENTKEY("Sales Order No.","Order Line No.");
                PackageLine.SETCURRENTKEY("Source ID", "Order Line No.");
                //       PackageLine.SETRANGE("Sales Order No.",SalesLine."Document No.");
                PackageLine.SETRANGE("Source ID", SalesLine."Document No.");
                //<<IST 081208 CCL $12797 #12797
                PackageLine.SETRANGE("Order Line No.", SalesLine."Line No.");
                PackageLine.CALCSUMS(Quantity);
                QtyPacked := PackageLine.Quantity + QtyToAdd;

                IF QtyPacked < QtyOutStanding THEN BEGIN
                    PackingControl."Order Line No." := SalesLine."Line No.";
                    EXIT;
                END;

            UNTIL SalesLine.NEXT = 0;
        END;
    END;

    LOCAL PROCEDURE LoadTempSalesLine(PackingControl: Record 14000717; QuantityToAdd: Decimal);
    VAR
        SalesLine: Record 37;
        packageline: Record 14000702;
        QtyOutstanding: Decimal;
        QtyPacked: Decimal;
        QtyRem: Decimal;
    BEGIN

        // 1 - set filter on Sales Line
        SalesLine.SETCURRENTKEY("Document Type", "Document No.", Type, "No.", "Variant Code", "Drop Shipment", "LAX Pack");
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
        //>>IST 081208 CCL $12797 #12797
        //IF PackingControl."Multi Sales Order" THEN
        IF PackingControl."Multi Document Package" THEN
            //  SalesLine.SETFILTER("Document No.",PackingControl."Multi Sales Order No.")
            SalesLine.SETFILTER("Document No.", PackingControl."Multi Document No.")
        ELSE
            //  SalesLine.SETRANGE("Document No.",PackingControl."Multi Sales Order No.");
            SalesLine.SETRANGE("Document No.", PackingControl."Source ID");
        //<<IST 081208 CCL $12797 #12797
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        SalesLine.SETRANGE("No.", PackingControl."Input No.");
        SalesLine.SETRANGE("Drop Shipment", FALSE);
        SalesLine.SETRANGE("LAX Pack", true);

        // 2 - Load Temp table with unpacked quantity=Quantity
        IF SalesLine.FIND('-') THEN
            REPEAT
                SalesLine.CALCFIELDS("LAX E-Ship Whse. Outst. Qty.", "LAX E-Ship Inventory Outst Qty");
                QtyOutstanding := SalesLine."LAX E-Ship Whse. Outst. Qty." + SalesLine."LAX E-Ship Inventory Outst Qty";

                packageline.RESET;
                //>>IST 081208 CCL $12797 #12797
                //  PackageLine.SETCURRENTKEY("Sales Order No.","Order Line No.");
                //  PackageLine.SETRANGE("Sales Order No.",SalesLine."Document No.");
                packageline.SETCURRENTKEY("Source ID", "Order Line No.");
                packageline.SETRANGE("Source ID", SalesLine."Document No.");
                //<<IST 081208 CCL $12797 #12797
                packageline.SETRANGE("Order Line No.", SalesLine."Line No.");
                packageline.CALCSUMS(Quantity);
                QtyPacked := packageline.Quantity;


                IF QtyOutstanding > QtyPacked THEN BEGIN
                    TempSalesLine.INIT;
                    TempSalesLine.TRANSFERFIELDS(SalesLine);
                    TempSalesLine.Quantity := QtyOutstanding - QtyPacked;
                    TempSalesLine."Qty. to Ship" := 0;
                    TempSalesLine.INSERT;
                END;

            UNTIL SalesLine.NEXT = 0;

        //now allocate quantity to "Qty. to Ship"
        QtyRem := QuantityToAdd;
        IF TempSalesLine.FIND('-') THEN
            REPEAT
                IF QtyRem >= TempSalesLine.Quantity THEN
                    TempSalesLine."Qty. to Ship" := TempSalesLine.Quantity
                ELSE
                    TempSalesLine."Qty. to Ship" := QtyRem;
                QtyRem := QtyRem - TempSalesLine."Qty. to Ship";
                TempSalesLine.MODIFY;
            UNTIL (TempSalesLine.NEXT = 0) OR (QtyRem <= 0)
    END;

    PROCEDURE CreatePackageNIF(VAR Package: Record 14000701; VAR PackingControl: Record 14000717): Boolean;
    VAR
        Package2: Record 14000701;
        PackageLine: Record 14000702;
        SalesHeader: Record 36;
    BEGIN

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
    END;

    PROCEDURE CreatePackageLineNIF(VAR Package: Record 14000701; VAR PackingControl: Record 14000717; QuantityToAdd: Decimal; Summary: Boolean): Boolean;
    VAR
        PackageLine: Record 14000702;
        PackageLine2: Record 14000702;
        QuantityEntered: Decimal;
        QuantityInPackage: Decimal;
        ">>NIF_LV": Integer;
        QtyRemToAdd: Decimal;
        UseLineNo: Integer;
    BEGIN
        PackageLine.RESET;
        PackageLine.SETRANGE("Package No.", Package."No.");
        // PackageLine.SETRANGE(Type, FORMAT(PackingControl."Input Type"));
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
            // {
            // IF PackageLine.OverPackError THEN BEGIN
            //         PackingControl."Error Message" := 'Over Pack';
            //         EXIT(FALSE);
            //     END;
            // }
            // PackageLine.SetCreatedFromPick;  //NIF
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
    END;


    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"LAX Package Management", pubOnAfterCreatePackageLine, '', false, false)]
    // local procedure pubOnAfterCreatePackageLine(var Package: Record "LAX Package"; var PackingControl: Record "LAX Packing Control"; var LineUOM: Code[10]; var LineQuantity: Decimal; var FixedQuantity: Decimal; var ReturnValue: Boolean)
    // begin
    //     //>> #9865 RTT 03-28-05        //jrr
    //     LabelMgt.PrintPackageLineLabel(
    //       PackageLine, QuantityToAdd, QuantityToAdd * PackageLine."Qty. per Unit of Measure", FALSE);
    //     //<< #9865

    // end;


    var

        "<<NIF>>": Integer;
        LabelMgt: Codeunit 14000841;
        WhseActivityLine: Record 5767;
        WhseActivityLine2: Record 5767;
        TempSalesLine: Record 37 TEMPORARY;
        UserSetup: Record 91;

}


