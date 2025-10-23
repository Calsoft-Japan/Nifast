codeunit 50055 CU_7320
{
    PROCEDURE CreateWhseJnlLine2(ItemJnlLine: Record 83; SourceType: Integer; SourceSubType: Integer; SourceNo: Code[20]; SourceLineNo: Integer; RefDocNo: Code[20]; VAR TempWhseJnlLine: Record 7311 TEMPORARY; VAR NextLineNo: Integer);
    VAR
        WhseMgt: Codeunit 5775;
        PostedPackage: Record 14000704;
        PostedPackageLine: Record 14000705;
    BEGIN

        // WC0001.begin
        //PostedPackage.SETCURRENTKEY("Sales Shipment No.");
        PostedPackage.SETCURRENTKEY("Source Type", "Source Subtype", "Posted Source ID", "Bill of Lading No.");
        //PostedPackage.SETRANGE("Sales Shipment No.",RefDocNo);
        PostedPackage.SETRANGE("Source Type", 36);
        PostedPackage.SETRANGE("Posted Source ID", RefDocNo);
        // WC0001.end

        IF PostedPackage.FIND('-') THEN
            REPEAT
                PostedPackageLine.SETRANGE("Package No.", PostedPackage."No.");
                // WC0001.begin
                PostedPackageLine.SETRANGE("Source Type", 36);
                PostedPackageLine.SETRANGE("Source ID", SourceNo);
                PostedPackageLine.SETRANGE("Posted Source ID", RefDocNo);
                //PostedPackageLine.SETRANGE("Sales Order No.",SourceNo);
                //PostedPackageLine.SETRANGE("Sales Shipment No.",RefDocNo);
                // WC0001.end
                //PostedPackageLine.SETRANGE("Order Line No.", SourceLineNo);
                PostedPackageLine.SETFILTER(Quantity, '<>%1', 0);
                IF PostedPackageLine.FIND('-') THEN
                    REPEAT
                        TempWhseJnlLine.INIT;
                        IF PostedPackageLine.Quantity > 0 THEN
                            ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::"Positive Adjmt."
                        ELSE
                            ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::"Negative Adjmt.";
                        ItemJnlLine.Quantity := ABS(PostedPackageLine.Quantity);
                        ItemJnlLine."Quantity (Base)" := ABS(PostedPackageLine."Quantity (Base)");
                        // WMSMgmt.CreateWhseJnlLine(ItemJnlLine,0,TempWhseJnlLine,FALSE);
                        TempWhseJnlLine."Source Type" := SourceType;
                        TempWhseJnlLine."Source Subtype" := SourceSubType;
                        TempWhseJnlLine."Source No." := SourceNo;
                        TempWhseJnlLine."Source Line No." := SourceLineNo;
                        TempWhseJnlLine."Reference Document" := TempWhseJnlLine."Reference Document"::"Posted Shipment";
                        TempWhseJnlLine."Reference No." := ItemJnlLine."Document No.";
                        TempWhseJnlLine."Location Code" := ItemJnlLine."Location Code";
                        TempWhseJnlLine."Bin Code" := ItemJnlLine."Bin Code";
                        TempWhseJnlLine."Whse. Document Type" := TempWhseJnlLine."Whse. Document Type"::Shipment;
                        TempWhseJnlLine."Whse. Document No." := RefDocNo;
                        TempWhseJnlLine."Unit of Measure Code" := PostedPackageLine."Unit of Measure Code";
                        TempWhseJnlLine."Line No." := NextLineNo;
                        TempWhseJnlLine."Serial No." := PostedPackageLine."Serial No.";
                        TempWhseJnlLine."Lot No." := PostedPackageLine."Lot No.";
                        // IF ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::"Negative Adjmt." THEN BEGIN
                        //     TempWhseJnlLine."From Zone Code" := '';
                        //     TempWhseJnlLine."From Bin Code" := PostedPackageLine."Bin Code";
                        // END ELSE BEGIN
                        //     TempWhseJnlLine."To Zone Code" := '';
                        //     TempWhseJnlLine."To Bin Code" := PostedPackageLine."Bin Code";
                        // END;
                        TempWhseJnlLine.INSERT;
                        NextLineNo := TempWhseJnlLine."Line No." + 10000;
                    UNTIL PostedPackageLine.NEXT = 0;
            UNTIL PostedPackage.NEXT = 0;
    END;

    PROCEDURE InsertTempWhseJnlLine_gFNc(ItemJnlLine: Record 83; SourceType: Integer; SourceSubType: Integer; SourceNo: Code[20]; SourceLineNo: Integer; RefDoc: Integer; VAR TempWhseJnlLine: Record 7311 TEMPORARY; VAR NextLineNo: Integer; SalesShipLine_iRec: Record 111);
    VAR
        WhseEntry: Record 7312;
        WhseMgt: Codeunit 5775;
        TempILE_lRecTmp: Record 32 TEMPORARY;
        SaleShipHdr_lRec: Record 110;
        Location_lRec: Record 14;
    BEGIN
        //>> NF1.00:CIS.NG    09/12/16
        WhseEntry.RESET;
        WhseEntry.SETCURRENTKEY("Source Type", "Source Subtype", "Source No.");
        WhseEntry.SETRANGE("Source Type", SourceType);
        WhseEntry.SETRANGE("Source Subtype", SourceSubType);
        WhseEntry.SETRANGE("Source No.", SourceNo);
        WhseEntry.SETRANGE("Source Line No.", SourceLineNo);
        WhseEntry.SETRANGE("Reference No.", ItemJnlLine."Document No.");
        WhseEntry.SETRANGE("Item No.", ItemJnlLine."Item No.");
        IF WhseEntry.FIND('+') THEN
            EXIT;

        //>> NF1.00:CIS.NG    10/04/16
        //IF Location_lRec.GET(SalesShipLine_iRec."Location Code") THEN BEGIN
        //  IF Location_lRec."Bin Mandatory" THEN BEGIN
        //    WhseEntry.RESET;
        //    WhseEntry.SETRANGE("Reference No.",SalesShipLine_iRec."Document No.");
        //    WhseEntry.SETRANGE("Registering Date",SaleShipHdr_lRec."Posting Date");
        //    IF NOT WhseEntry.FINDFIRST THEN
        //      ERROR('Warehouse entry not found for Shipment Document No. = %1 and Posting Date = %2',SalesShipLine_iRec."Document No.",SaleShipHdr_lRec."Posting Date");
        //  END;
        //END;
        //<< NF1.00:CIS.NG    10/04/16

        SaleShipHdr_lRec.GET(SalesShipLine_iRec."Document No.");
        TempILE_lRecTmp.RESET;
        SalesShipLine_iRec.ShowItemTrackingLines_gFnc(TempILE_lRecTmp);
        IF TempILE_lRecTmp.FINDSET THEN BEGIN
            REPEAT
                WhseEntry.RESET;
                WhseEntry.SETCURRENTKEY("Source Type", "Source Subtype", "Source No.");
                WhseEntry.SETRANGE("Reference No.", SalesShipLine_iRec."Document No.");
                //WhseEntry.SETRANGE("Registering Date",SaleShipHdr_lRec."Posting Date");
                WhseEntry.SETRANGE("Item No.", ItemJnlLine."Item No.");
                WhseEntry.SETRANGE("Lot No.", TempILE_lRecTmp."Lot No.");
                WhseEntry.SETRANGE("Entry Type", WhseEntry."Entry Type"::"Negative Adjmt.");
                //WhseEntry.SETRANGE("Qty. (Base)",(-1) * ABS(TempILE_lRecTmp.Quantity));
                IF WhseEntry.FIND('+') THEN
                    REPEAT
                        TempWhseJnlLine.INIT;
                        IF WhseEntry."Entry Type" = WhseEntry."Entry Type"::"Positive Adjmt." THEN
                            ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::"Negative Adjmt."
                        ELSE
                            ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::"Positive Adjmt.";
                        ItemJnlLine.Quantity := ABS(WhseEntry.Quantity);
                        ItemJnlLine."Quantity (Base)" := ABS(WhseEntry."Qty. (Base)");
                        // WMSMgmt.CreateWhseJnlLine(ItemJnlLine,0,TempWhseJnlLine,FALSE);
                        TempWhseJnlLine."Source Type" := SourceType;
                        TempWhseJnlLine."Source Subtype" := SourceSubType;
                        TempWhseJnlLine."Source No." := SourceNo;
                        TempWhseJnlLine."Source Line No." := SourceLineNo;
                        TempWhseJnlLine."Source Document" :=
                          WhseMgt.GetSourceDocument(TempWhseJnlLine."Source Type", TempWhseJnlLine."Source Subtype");
                        TempWhseJnlLine."Reference Document" := RefDoc;
                        TempWhseJnlLine."Reference No." := ItemJnlLine."Document No.";
                        TempWhseJnlLine."Location Code" := ItemJnlLine."Location Code";
                        TempWhseJnlLine."Zone Code" := WhseEntry."Zone Code";
                        TempWhseJnlLine."Bin Code" := WhseEntry."Bin Code";
                        TempWhseJnlLine."Whse. Document Type" := WhseEntry."Whse. Document Type";
                        TempWhseJnlLine."Whse. Document No." := WhseEntry."Whse. Document No.";
                        TempWhseJnlLine."Unit of Measure Code" := WhseEntry."Unit of Measure Code";
                        TempWhseJnlLine."Line No." := NextLineNo;
                        TempWhseJnlLine."Serial No." := WhseEntry."Serial No.";
                        TempWhseJnlLine."Lot No." := WhseEntry."Lot No.";
                        TempWhseJnlLine."Expiration Date" := WhseEntry."Expiration Date";
                        IF ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::"Negative Adjmt." THEN BEGIN
                            TempWhseJnlLine."From Zone Code" := TempWhseJnlLine."Zone Code";
                            TempWhseJnlLine."From Bin Code" := TempWhseJnlLine."Bin Code";
                        END ELSE BEGIN
                            TempWhseJnlLine."To Zone Code" := TempWhseJnlLine."Zone Code";
                            TempWhseJnlLine."To Bin Code" := TempWhseJnlLine."Bin Code";
                        END;
                        TempWhseJnlLine.INSERT;
                        NextLineNo := TempWhseJnlLine."Line No." + 10000;
                    UNTIL WhseEntry.NEXT(-1) = 0;

            UNTIL TempILE_lRecTmp.NEXT = 0;
        END;
        //<< NF1.00:CIS.NG    09/12/16
    END;

}
