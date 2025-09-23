codeunit 50053 CU5313Subscriber
{
    // Version NAVW17.10,NV4.35,NIF.N15.C9IN.001;
    var

        /*  ">> NV": Integer;
         WhseSetup: Record 5769; */
        TempNewActivHeader: Record 5766 TEMPORARY;
        TempNewActivLine: Record 5767 TEMPORARY;
        //TempNewBinContent: Record 7302 TEMPORARY;
        // CurrLocation: Record Location;
        CurrBin: Record Bin;
        SingleInstanceCU: Codeunit SingleInstance;
        /* NextTempActivNo: Code[10];
        UseMaxQty: Decimal; */
        CreateTempTablesOnly: Boolean;
        UsePutawayGroup: Boolean;
    /*  ok: Boolean;
     "<<NV>>": Integer;
     UseMinQty: Decimal; */


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Put-away", OnAfterWhseActivHeaderInsert, '', false, false)]
    local procedure OnAfterWhseActivHeaderInsert(var WarehouseActivityHeader: Record "Warehouse Activity Header")
    begin
        //SingleInstanceCU.SetWarehouseActivityHeader(WarehouseActivityHeader);//Balu
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Put-away", OnBeforeWhseActivLineInsert, '', false, false)]
    local procedure OnBeforeWhseActivLineInsert(var WarehouseActivityLine: Record "Warehouse Activity Line"; PostedWhseRcptLine: Record "Posted Whse. Receipt Line")
    var
        WarehouseActivityHeader: Record "Warehouse Activity Header";
    begin
        //SingleInstanceCU.GetWarehouseActivityHeader(WarehouseActivityHeader);//Balu

        //TODO
        /*  //>>PFC
         WarehouseActivityLine."Assigned User ID" := WarehouseActivityHeader."Assigned User ID";
         WarehouseActivityLine."Assignment Date" := WarehouseActivityHeader."Assignment Date";
         WarehouseActivityLine."Assignment Time" := WarehouseActivityHeader."Assignment Time";
         //<<PFC */
        //TODO

        Clear(SingleInstanceCU);

        //TODO
        /*   //NV 4.33
          IF PostedWhseRcptLine."QC Hold" THEN BEGIN
              GetLocation(PostedWhseRcptLine."Location Code");
              CurrLocation.TESTFIELD("Inbound QC Bin Code");
              CurrBin.GET(PostedWhseRcptLine."Location Code", CurrLocation."Inbound QC Bin Code");
          END;
          //NV 4.33 */
        //TODO

        if WarehouseActivityLine."Bin Code" <> '' then begin
            GetBin(WarehouseActivityLine."Location Code", WarehouseActivityLine."Bin Code");
            WarehouseActivityLine.Dedicated := CurrBin.Dedicated;
            WarehouseActivityLine."Bin Ranking" := CurrBin."Bin Ranking";
            //TODO
            /*  //>>NV
             WarehouseActivityLine."Pick Bin Ranking" := CurrBin."Pick Bin Ranking";
             //<<NV */
            //TODO
            WarehouseActivityLine."Bin Type Code" := CurrBin."Bin Type Code";
        end;

        //TODO
        /*   WarehouseActivityLine."To Put-away Group Code" := PostedWhseRcptLine."To Put-away Group Code";
          WarehouseActivityLine."To Put-away Template Code" := PostedWhseRcptLine."To Put-away Template Code"; */
        //TODO

        /*  // >> NV 10/02/03 JDC
         IF (WarehouseActivityLine."Bin Code" <> '') AND CurrBin."License Plate Enabled" THEN
             WarehouseActivityLine."License Plate No." := PostedWhseRcptLine."License Plate No.";
         // << NV 10/02/03 JDC
         IF CreateTempTablesOnly THEN BEGIN // Do not create documents
             TempNewActivLine := WarehouseActivityLine;
             TempNewActivLine.INSERT;
         END ELSE
             WarehouseActivityLine.INSERT;
         // << NV - 09/09/03 MV */
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Put-away", OnFindBinContent, '', false, false)]
    local procedure OnFindBinContent(PostedWhseReceiptLine: Record "Posted Whse. Receipt Line"; PutAwayTemplateLine: Record "Put-away Template Line"; var BinContent: Record "Bin Content"; var BinContentFound: Boolean; var IsHandled: Boolean)
    begin
        //TODO
        /*  //>>PFC
         BinContent.SETRANGE("Staging Bin", FALSE);
         //<<PFC  */
        //TODO

        // >> NV - 08/27/03 MV
        //>> NF1.00:CIS.CM 09-29-15
        //  IF UsePutawayGroup THEN BEGIN
        //    IF PutawayGroupLine."Zone Filter" <> '' THEN
        //      SETFILTER("Zone Code",PutawayGroupLine."Zone Filter")
        //    ELSE
        //      SETRANGE("Zone Code");
        //    IF PutawayGroupLine."Bin Ranking Filter" <> '' THEN
        //      SETFILTER("Bin Ranking",PutawayGroupLine."Bin Ranking Filter")
        //    ELSE
        //      SETRANGE("Bin Ranking");
        //  END;
        //<< NF1.00:CIS.CM 09-29-15
        // << NV - 08/27/03 MV
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Put-away", OnFindBin, '', false, false)]
    local procedure OnFindBin(PostedWhseReceiptLine: Record "Posted Whse. Receipt Line"; PutAwayTemplateLine: Record "Put-away Template Line"; var Bin: Record Bin; var BinFound: Boolean; var IsHandled: Boolean)
    begin
        //TODO
        /*  //>>PFC
         Bin.SETRANGE("Staging Bin", FALSE);
         //<<PFC */
        //TODO

        // >> NV - 08/27/03 MV
        //>> NF1.00:CIS.CM 09-29-15
        //  IF UsePutawayGroup THEN BEGIN
        //    IF PutawayGroupLine."Zone Filter" <> '' THEN
        //      SETFILTER("Zone Code",PutawayGroupLine."Zone Filter")
        //    ELSE
        //      SETRANGE("Zone Code");
        //    IF PutawayGroupLine."Bin Ranking Filter" <> '' THEN
        //      SETFILTER("Bin Ranking",PutawayGroupLine."Bin Ranking Filter")
        //    ELSE
        //      SETRANGE("Bin Ranking");
        //  END;
        //<< NF1.00:CIS.CM 09-29-15
        // << NV - 08/27/03 MV
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Put-away", OnBeforeAssignQtyToPutAwayForBinMandatory, '', false, false)]
    local procedure OnBeforeAssignQtyToPutAwayForBinMandatory(Item: Record Item; Location: Record Location; var QtyToPutAwayBase: Decimal; var RemQtyToPutAwayBase: Decimal)
    begin
        // >> NV - 09/16/03 MV
        //>> NF1.00:CIS.CM 09-29-15
        //IF UsePutawayGroup AND PutawayGroupLine."Put-away Qty. Must Fit One Bin" THEN
        IF UsePutawayGroup THEN
            //<< NF1.00:CIS.CM 09-29-15
            IF QtyToPutAwayBase <> RemQtyToPutAwayBase THEN // Not everything fits in the same one bin
                QtyToPutAwayBase := 0;

        IF QtyToPutAwayBase < 0 THEN // More than max. qty. in bin already
            QtyToPutAwayBase := 0;
        // << NV - 09/16/03 MV
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Put-away", OnCreateBinContentOnBeforeNewBinContentInsert, '', false, false)]
    local procedure OnCreateBinContentOnBeforeNewBinContentInsert(var BinContent: Record "Bin Content"; PostedWhseReceiptLine: Record "Posted Whse. Receipt Line"; var Bin: Record Bin; var OldBinContent: Record "Bin Content")
    begin
        //TODO
        /*    //>>PFC
           BinContent."Staging Bin" := Bin."Staging Bin";
           //<<PFC */
        //TODO
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Put-away", OnBeforeCode, '', false, false)]
    local procedure OnBeforeCode(var PostedWhseReceiptLine: Record "Posted Whse. Receipt Line")
    begin
        //SingleInstanceCU.SetPostedWhseReceiptLine(PostedWhseReceiptLine);//Balu
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Put-away", OnBeforeGetPutAwayTemplate, '', false, false)]
    local procedure OnBeforeGetPutAwayTemplate(SKU: Record "Stockkeeping Unit"; Item: Record Item; Location: Record Location; var PutAwayTemplHeader: Record "Put-away Template Header"; var IsHandled: Boolean)
    var
        PostedWhseReceiptLine: Record "Posted Whse. Receipt Line";
    begin
        //SingleInstanceCU.GetPostedWhseReceiptLine(PostedWhseReceiptLine);//Balu

        //TODO
        /*    // >> NV - 09/09/03 MV
           IF PostedWhseReceiptLine."To Put-away Template Code" <> '' THEN BEGIN
               // Force use of template code from receipt line/worksheet line
               PutAwayTemplHeader.GET(PostedWhseReceiptLine."To Put-away Template Code");
               EXIT;
           END; */
        //TODO

        Clear(SingleInstanceCU);
    end;

    PROCEDURE "> NV"();
    BEGIN
    END;

    /*  local procedure GetLocation(LocationCode: Code[10])
     begin
         if LocationCode <> CurrLocation.Code then
             CurrLocation.Get(LocationCode);
     end; */

    local procedure GetBin(LocationCode: Code[10]; BinCode: Code[20])
    begin
        if (CurrBin."Location Code" <> LocationCode) or
           (CurrBin.Code <> BinCode)
        then begin
            CurrBin.SetLoadFields(Code, "Location Code", "Zone Code", "Dedicated", "Bin Ranking", "Bin Type Code", "Empty", "Maximum Cubage", "Maximum Weight",
                              "Warehouse Class Code", "Block Movement", "Cross-Dock Bin", "Special Equipment Code");
            CurrBin.Get(LocationCode, BinCode);
        end;
    end;

    PROCEDURE GetPutAwayGroup(Location: Record 14; SKU: Record 5700; PutAwayItemUOM: Record 5404; PostedWhseRcptLine: Record 7319): Boolean;
    VAR
    // UsePutawayGroupCode: Code[10];
    BEGIN
        //TODO
        /* // >> NV - 08/27/03 MV
        UsePutawayGroupCode := PostedWhseRcptLine."To Put-away Group Code";
        IF (UsePutawayGroupCode = '') AND (PostedWhseRcptLine."To Put-away Template Code" = '') THEN
            UsePutawayGroupCode := SKU."Put-away Group Code";

        UsePutawayGroup := UsePutawayGroupCode <> '';

        IF UsePutawayGroup THEN BEGIN

            // Test SKU setup
            IF (SKU."Location Code" <> '') AND (SKU."Put-away Group Code" <> '') THEN BEGIN // ... SKU exists
                IF SKU."Put-away Template Code" <> '' THEN
                    SKU.FIELDERROR(
                      "Put-away Template Code",
                      STRSUBSTNO('when %1."%2" is filled in.', SKU.TABLECAPTION, SKU.FIELDCAPTION("Put-away Group Code")));
                IF NOT Location."Directed Put-away and Pick" THEN
                    SKU.FIELDERROR(
                      "Put-away Group Code",
                      STRSUBSTNO('when %1."%2" is "No".', Location.TABLECAPTION, Location.FIELDCAPTION("Directed Put-away and Pick")));
            END;

            // Test PostedWhseRcptLine setup (values transferred from e.g. receipt line or whse. worksheet line)
            IF PostedWhseRcptLine."To Put-away Group Code" <> '' THEN BEGIN
                IF PostedWhseRcptLine."To Put-away Template Code" <> '' THEN
                    PostedWhseRcptLine.FIELDERROR(
                      "To Put-away Template Code",
                      STRSUBSTNO('when %1."%2" is filled in.',
                      PostedWhseRcptLine.TABLECAPTION,
                      PostedWhseRcptLine.FIELDCAPTION("To Put-away Group Code")));
                IF NOT Location."Directed Put-away and Pick" THEN
                    PostedWhseRcptLine.FIELDERROR(
                      "To Put-away Group Code",
                      STRSUBSTNO('when %1."%2" is "No".', Location.TABLECAPTION, Location.FIELDCAPTION("Directed Put-away and Pick")));
            END;

            //PutawayGroupHeader.GET(PostedWhseRcptLine."Location Code",UsePutawayGroupCode); // Use PostedWhseRcptLine (SKU could be empty)  //NF1.00:CIS.CM 09-29-15

            // NOTE: Put-away Unit Of Measure must be 3.rd field in primary key for the code below to work
            //>> NF1.00:CIS.CM 09-29-15
            //  PutawayGroupLine.RESET;
            //  PutawayGroupLine.SETRANGE("Location Code",PutawayGroupHeader."Location Code");
            //  PutawayGroupLine.SETRANGE("Put-away Group Code",PutawayGroupHeader.Code);
            //  PutawayGroupLine.SETFILTER("Put-away Unit of Measure Code",'%1|%2','',PutAwayItemUOM.Code);
            //  PutawayGroupLine.FIND('+'); // Must exist
            //  PutawayGroupLine.SETFILTER("Put-away Unit of Measure Code",PutawayGroupLine."Put-away Unit of Measure Code");
            //// Blank or specific
            //  PutawayGroupLine.FIND('-'); // Start processing at first line...
            //<< NF1.00:CIS.CM 09-29-15
        END;

        EXIT(UsePutawayGroup);
        // << NV - 08/27/03 MV */
        //TODO
    END;


    PROCEDURE SetCreateTempTablesOnly(NewCreateTempTablesOnly: Boolean);
    BEGIN
        // >> NV - 09/09/03 MV
        CreateTempTablesOnly := NewCreateTempTablesOnly;
        // << NV - 09/09/03 MV
    END;

    PROCEDURE GetTempActivHeader(VAR GetTempNewActivHeader: Record 5766 TEMPORARY);
    BEGIN
        // >> NV - 09/09/03 MV
        IF TempNewActivHeader.FIND('-') THEN
            REPEAT
                GetTempNewActivHeader := TempNewActivHeader;
                GetTempNewActivHeader.INSERT();
            UNTIL TempNewActivHeader.NEXT() = 0;
        // << NV - 09/09/03 MV
    END;

    PROCEDURE GetTempActivLine(VAR GetTempNewActivLine: Record 5767 TEMPORARY);
    BEGIN
        // >> NV - 09/09/03 MV
        IF TempNewActivLine.FIND('-') THEN
            REPEAT
                GetTempNewActivLine := TempNewActivLine;
                GetTempNewActivLine.INSERT();
            UNTIL TempNewActivLine.NEXT() = 0;
        // << NV - 09/09/03 MV
    END;

    PROCEDURE "BinContent.InitRecord"(VAR BinContent: Record 7302; Bin: Record 7354; ItemUnitOfMeasure: Record 5404; VariantCode_: Code[10]);
    BEGIN
        //>> NF1.00:CIS.CM 09-29-15
        //
        // Initiate a new BinContent record (code extracted from codeunit "Create Put-away", except for Max. Qty.)
        //
        BinContent.INIT();
        BinContent."Location Code" := Bin."Location Code";
        BinContent."Bin Code" := Bin.Code;
        BinContent."Item No." := ItemUnitOfMeasure."Item No.";
        BinContent."Variant Code" := VariantCode_;
        BinContent."Unit of Measure Code" := ItemUnitOfMeasure.Code;
        BinContent."Zone Code" := Bin."Zone Code";
        BinContent."Bin Type Code" := Bin."Bin Type Code";
        BinContent."Warehouse Class Code" := Bin."Warehouse Class Code";
        BinContent."Block Movement" := Bin."Block Movement";
        BinContent."Qty. per Unit of Measure" := ItemUnitOfMeasure."Qty. per Unit of Measure";
        BinContent."Bin Ranking" := Bin."Bin Ranking";
        BinContent."Cross-Dock Bin" := Bin."Cross-Dock Bin";
        //BinContent."Max. Qty." := "BinContent.CalculateMaxQty"(BinContent);
        //TODO
        /* BinContent."Pick Bin Ranking" := Bin."Pick Bin Ranking";
        BinContent."Staging Bin" := Bin."Staging Bin"; */
        //TODO
        //<< NF1.00:CIS.CM 09-29-15
    END;

}