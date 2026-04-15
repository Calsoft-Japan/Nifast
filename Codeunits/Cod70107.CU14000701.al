namespace Nifast.Nifast;

codeunit 70107 CU_14000701
{
    LOCAL PROCEDURE UpdateEshipBuffer(PkgLine: Record 14000702; DocNo: Code[20]; LineNO: Integer; LotNo: Code[20]; ItemNo: Code[20]; Qty: Decimal);
    BEGIN
        EshipLotBuffer."Document No." := DocNo;
        EshipLotBuffer."Line No." := LineNO;
        EshipLotBuffer."Lot No." := LotNo;
        EshipLotBuffer."Location Code" := PkgLine."Location Code";
        EshipLotBuffer."Bin Code" := PkgLine."Bin Code";
        EshipLotBuffer."Item No." := ItemNo;
        IF EshipLotBuffer.FIND THEN BEGIN
            EshipLotBuffer.Quantity := EshipLotBuffer.Quantity + Qty;
            EshipLotBuffer.MODIFY;
        END
        ELSE BEGIN
            EshipLotBuffer.Quantity := Qty;
            EshipLotBuffer.INSERT;
        END;
    END;

    LOCAL PROCEDURE UpdatePick(CurrentSalesHeader: Record 36);
    VAR
        FromWhseActivityLine: Record 5767;
        WhseItemTrkgLine: Record 6550;
        TempLineNo: Integer;
        SalesLine: Record 37;
        TempWhseActivLine: Record 5767;
        TempNo: Code[20];
        UseLineNo: Integer;
        FromWhseActivityHeader: Record 5767;
        RegisteredActvLine: Record 5773;
    BEGIN
        IF NOT EshipLotBuffer.FIND('-') THEN
            EXIT;

        //find current pick
        FromWhseActivityLine.RESET;
        FromWhseActivityLine.SETCURRENTKEY(
                   "Source Type", "Source Subtype", "Source No.", "Source Line No.", "Source Subline No.", "Unit of Measure Code", "Action Type"
        );
        FromWhseActivityLine.SETRANGE("Source Subtype", CurrentSalesHeader."Document Type");
        // FromWhseActivityLine.SETRANGE("Source Type", FromWhseActivityLine."Source Type"::"Sales Line");
        // FromWhseActivityLine.SETRANGE("Source Type", DATABASE::"Sales Line");//ESG
        FromWhseActivityLine.SETRANGE("Source No.", CurrentSalesHeader."No.");
        FromWhseActivityLine.SETRANGE("Activity Type", FromWhseActivityLine."Activity Type"::"Invt. Pick");
        FromWhseActivityLine.SETRANGE(
          "Source Document", FromWhseActivityLine."Source Document"::"Sales Order");
        FromWhseActivityLine.SETFILTER(Quantity, '<>%1', 0);

        //if do not find, then exit
        IF NOT FromWhseActivityLine.FIND('-') THEN
            EXIT;

        TempNo := FromWhseActivityLine."No.";
        FromWhseActivityLine.SETRANGE(Quantity);
        FromWhseActivityLine.DELETEALL;

        //find the pick line for each and update the pick
        REPEAT
            IF NOT SalesLine.GET(SalesLine."Document Type"::Order, CurrentSalesHeader."No.", EshipLotBuffer."Line No.") THEN
                ERROR('Sales Order Line %1 does not exist.', EshipLotBuffer."Line No.");

            TempLineNo := TempLineNo + 10000;
            WITH SalesLine DO BEGIN
                TempWhseActivLine.RESET;
                TempWhseActivLine.INIT;
                TempWhseActivLine."Activity Type" := TempWhseActivLine."Activity Type"::"Invt. Pick";
                TempWhseActivLine."No." := TempNo;
                TempWhseActivLine."Source Document" := TempWhseActivLine."Source Document"::"Sales Order";
                //  TempWhseActivLine."Source Type" := DATABASE::"Sales Line";//ESG
                TempWhseActivLine."Source Subtype" := SalesLine."Document Type";
                TempWhseActivLine."Source No." := SalesLine."Document No.";
                TempWhseActivLine."Source Line No." := SalesLine."Line No."; //EshipLotBuffer."Line No.";
                TempWhseActivLine."Item No." := EshipLotBuffer."Item No.";
                TempWhseActivLine."Variant Code" := "Variant Code";
                TempWhseActivLine."Unit of Measure Code" := "Unit of Measure Code";
                TempWhseActivLine."Qty. per Unit of Measure" := "Qty. per Unit of Measure";
                TempWhseActivLine.Description := Description;
                TempWhseActivLine."Description 2" := "Description 2";
                TempWhseActivLine."Due Date" := "Shipment Date";
                TempWhseActivLine."Starting Date" := "Shipment Date";
                TempWhseActivLine."Shipping Agent Code" := CurrentSalesHeader."Shipping Agent Code";
                TempWhseActivLine."Shipping Agent Service Code" := CurrentSalesHeader."Shipping Agent Service Code";
                TempWhseActivLine."Shipment Method Code" := CurrentSalesHeader."Shipment Method Code";
                TempWhseActivLine."Shipping Advice" := CurrentSalesHeader."Shipping Advice";
                TempWhseActivLine."Lot No." := EshipLotBuffer."Lot No.";
                TempWhseActivLine.VALIDATE(Quantity, EshipLotBuffer.Quantity);
                TempWhseActivLine.VALIDATE("Qty. to Handle", EshipLotBuffer.Quantity);
                TempWhseActivLine."Line No." := TempLineNo;
                TempWhseActivLine."Location Code" := EshipLotBuffer."Location Code";
                TempWhseActivLine."Bin Code" := EshipLotBuffer."Bin Code";
                IF TempWhseActivLine."Bin Code" <> '' THEN  //re-engineered
                    GetPickTakeInfo(TempWhseActivLine);
                TempWhseActivLine.INSERT;
                //xxxDEBUG
                //  COMMIT;
                //  MESSAGE('pick line %1, Line %2,Qty to Handle%3.',TempWhseActivLine."No.",TempLineNo,TempWhseActivLine."Qty. to Handle (Base)");
                //  ;
                //xxx
                TempLineNo := TempLineNo + 10000;
            END;
        UNTIL EshipLotBuffer.NEXT = 0;

        //XX possibly permanent
        //COMMIT;  //comment out for now
        //XX
        EshipLotBuffer.DELETEALL;
    END;

    LOCAL PROCEDURE GetPickTakeInfo(WhseActivityLine: Record 5767);
    VAR
        LotNoInfo: Record 6505;
        LocDelim: Integer;
        LocBinString: Code[20];
        Bin: Record 7354;
    BEGIN
        WITH WhseActivityLine DO BEGIN
            Bin.GET("Location Code", "Bin Code");
            "Zone Code" := Bin."Zone Code";
            "Bin Ranking" := Bin."Bin Ranking";
            "Bin Type Code" := Bin."Bin Type Code";
            "Action Type" := WhseActivityLine."Action Type"::Take;
        END;
    END;

    var
        "<<NIF>>": Integer;
        EshipLotBuffer: Record 50009;



}
