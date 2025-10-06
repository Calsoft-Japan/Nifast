codeunit 50006 "IoT Process Data"
{
    // CIS.IoT 07/22/22 RAM Created new Object
    // CIS.IoT 11/14/23 RAM Made some functions to global from local


    trigger OnRun()
    var
        InventorySetup: Record "313";
        TransferHeader: Record "5740";
        IoTDataStagingM: Record "50042";
        IoTDataStagingMR: Record "50042";
        TempWhseActivHdr: Record "5766" temporary;
        SalesHeader: Record "36";
        SalesLine: Record "37";
        Sline: Record "37";
        TransLine: Record "5741";
        IoTRFIDs: Record "50043";
        SalesHeader1: Record "36";
        Item: Record "27";
        CreateInvtPickMovement: Codeunit "7322";
        CreateInvtPutAway: Codeunit "7321";
        SORelease: Codeunit "414";
        Skip: Boolean;
        LotEntry: Record "50002";
        LotEntryM: Record "50002";
        ReservationEntry: Record "337";
    begin
        //SalesHeaderTemp.RESET;
        //SalesHeaderTemp.DELETEALL;
        CreatePick := FALSE;
        SortPick := SortPick::"Shelf/Bin";
        IoTDataStaging.RESET;
        IoTDataStaging.SETRANGE("Record Status",IoTDataStaging."Record Status"::Pending,IoTDataStaging."Record Status"::Error);
        IF IoTDataStaging.FINDSET THEN
          REPEAT
            Skip := FALSE;
            CASE TRUE OF
              IoTDataStaging."Document Type" IN [IoTDataStaging."Document Type"::"Invt. Pick"]:
                BEGIN
                  CreatePick := TRUE;
                  IF NOT TransferHeader.GET(IoTDataStaging."Document No.") THEN BEGIN
                    IoTDataStagingM.RESET;
                    IoTDataStagingM.GET(IoTDataStaging."Entry No.");
                    IoTDataStagingM."Record Status" := IoTDataStaging."Record Status"::Error;
                    IoTDataStagingM."Error Message" := 'Transfer order does not exist';
                    IF IoTDataStagingM."Date Processed On" = 0D THEN
                      IoTDataStagingM."Date Processed On" := TODAY;
                    IoTDataStagingM.MODIFY;
                    COMMIT;
                    Skip := TRUE;
                  END;
                  IF NOT Skip THEN
                    IF TransferHeader.Status <> TransferHeader.Status::Released THEN BEGIN
                      IoTDataStagingM.RESET;
                      IoTDataStagingM.GET(IoTDataStaging."Entry No.");
                      IoTDataStagingM."Record Status" := IoTDataStaging."Record Status"::Error;
                      IoTDataStagingM."Error Message" := 'Transfer order is not released';
                      IF IoTDataStagingM."Date Processed On" = 0D THEN
                        IoTDataStagingM."Date Processed On" := TODAY;
                      IoTDataStagingM.MODIFY;
                      COMMIT;
                      Skip := TRUE;
                    END;
                  IF NOT Skip THEN BEGIN
                    WhseRequest.RESET;
                    WhseRequest.SETRANGE(Type,WhseRequest.Type::Outbound);
                    WhseRequest.SETCURRENTKEY("Source Document","Source No.");
                    WhseRequest.SETFILTER(
                      "Source Document",'%1|%2',
                      WhseRequest."Source Document"::"Inbound Transfer",
                      WhseRequest."Source Document"::"Outbound Transfer");
                    WhseRequest.SETRANGE("Source No.",IoTDataStaging."Document No.");
                    IF WhseRequest.FINDSET THEN REPEAT
        
                      IF ((WhseRequest.Type = WhseRequest.Type::Inbound) AND (WhseActivHeader.Type <> WhseActivHeader.Type::"Invt. Put-away")) OR
                         ((WhseRequest.Type = WhseRequest.Type::Outbound) AND ((WhseActivHeader.Type <> WhseActivHeader.Type::"Invt. Pick") AND
                                                       (WhseActivHeader.Type <> WhseActivHeader.Type::"Invt. Movement"))) OR
                         (WhseRequest."Source Type" <> WhseActivHeader."Source Type") OR
                         (WhseRequest."Source Subtype" <> WhseActivHeader."Source Subtype") OR
                         (WhseRequest."Source No." <> WhseActivHeader."Source No.") OR
                         (WhseRequest."Location Code" <> WhseActivHeader."Location Code")
                      THEN BEGIN
                        CASE WhseRequest.Type OF
                          WhseRequest.Type::Inbound:
                            IF NOT CreateInvtPutAway.CheckSourceDoc(WhseRequest) THEN BEGIN
                              //Update IoT Log Table
                              IoTDataStagingM.RESET;
                              IoTDataStagingM.GET(IoTDataStaging."Entry No.");
                              IoTDataStagingM."Record Status" := IoTDataStaging."Record Status"::Error;
                              IoTDataStagingM."Error Message" := 'Inbound:Failed to check Source Document';
                              IF IoTDataStagingM."Date Processed On" = 0D THEN
                                IoTDataStagingM."Date Processed On" := TODAY;
                              IoTDataStagingM.MODIFY;
                              COMMIT;
                            END;
                          WhseRequest.Type::Outbound:
                            IF NOT CreateInvtPickMovement.CheckSourceDoc(WhseRequest) THEN BEGIN
                              //Update IoT Log Table
                              IoTDataStagingM.RESET;
                              IoTDataStagingM.GET(IoTDataStaging."Entry No.");
                              IoTDataStagingM."Record Status" := IoTDataStaging."Record Status"::Error;
                              IoTDataStagingM."Error Message" := 'Outbound:Failed to check Source Document';
                              IF IoTDataStagingM."Date Processed On" = 0D THEN
                                IoTDataStagingM."Date Processed On" := TODAY;
                              IoTDataStagingM.MODIFY;
                              COMMIT;
                            END;
                        END;
                        InitWhseActivHeader;
                      END;
        
                      CASE WhseRequest.Type OF
                        WhseRequest.Type::Inbound:
                          BEGIN
                            CreateInvtPutAway.SetWhseRequest(WhseRequest,TRUE);
                            CreateInvtPutAway.AutoCreatePutAway(WhseActivHeader);
                            //Trap error if any!
                            //Update IoT Log Table
                            //Added 08/11
                            IoTDataStagingM.RESET;
                            IoTDataStagingM.GET(IoTDataStaging."Entry No.");
                            IF IoTDataStagingM."Date Processed On" = 0D THEN
                              IoTDataStagingM."Date Processed On" := TODAY;
                            IoTDataStagingM."Record Status" := IoTDataStaging."Record Status"::Processed;
                            IoTDataStagingM."Output Invt. Pick Type" := IoTDataStagingM."Output Invt. Pick Type"::"Invt. Pick";
                            IoTDataStagingM."Output Pick No." := CreateInvtPickMovement.GetIoTDocumentNo;
                            IoTDataStaging.MODIFY;
                            COMMIT;
                          END;
                        WhseRequest.Type::Outbound:
                          BEGIN
                            IoTDataStagingMR.RESET;
                            IoTDataStagingMR.SETRANGE(IoTDataStagingMR."Document Type",IoTDataStagingMR."Document Type"::"Invt. Pick");
                            IoTDataStagingMR.SETRANGE("Document No.",IoTDataStaging."Document No.");
                            IoTDataStagingMR.FINDSET;
                            REPEAT
                              TransLine.RESET;
                              TransLine.GET(IoTDataStagingMR."Document No.",IoTDataStagingMR."Line No.");
                              Item.GET(TransLine."Item No.");
                              IF TransLine.Quantity <> (TransLine."Units per Parcel" * IoTDataStagingMR.Quantity) THEN BEGIN
                                IF Item."Units per Parcel" <> 0 THEN
                                  TransLine.VALIDATE(Quantity,IoTDataStagingMR.Quantity * Item."Units per Parcel")
                                ELSE
                                  TransLine.VALIDATE(Quantity,IoTDataStagingMR.Quantity);
                              END;
                              TransLine."IoT Lot No." := IoTDataStagingMR."Lot No.";
                              TransLine.MODIFY;
                            UNTIL IoTDataStagingMR.NEXT = 0;
                            COMMIT;
        
                            CreateInvtPickMovement.SetWhseRequest(WhseRequest,TRUE);
                            CreateInvtPickMovement.AutoCreatePickOrMove(WhseActivHeader);
                            //Trap error if any!
                            //Update IoT Log Table
                            /*
                            IoTDataStagingM.RESET;
                            IoTDataStagingM.GET(IoTDataStaging."Entry No.");
                            IF IoTDataStagingM."Record Status" = IoTDataStaging."Record Status"::Processed THEN BEGIN
                              IoTDataStagingMR.RESET;
                              IoTDataStagingMR.SETRANGE("Document Type",IoTDataStaging."Document Type"::"Trans. Rcpt.");
                              IoTDataStagingMR.SETRANGE("Document No.",IoTDataStaging."Document No.");
                              IoTDataStagingMR.SETRANGE("Line No.",IoTDataStagingM."Line No.");
                              IoTDataStagingMR.SETFILTER("Record Status",'<>%1',IoTDataStaging."Record Status"::Processed);
                              IF IoTDataStagingMR.FINDSET THEN BEGIN
                                IF IoTDataStagingMR."Date Processed On" = 0D THEN
                                  IoTDataStagingMR."Date Processed On" := TODAY;
                                IoTDataStagingMR."Record Status" := IoTDataStaging."Record Status"::Processed;
                                IoTDataStagingMR."Output Document Type" := IoTDataStagingM."Output Document Type";
                                IoTDataStagingMR."Output Document No." := IoTDataStagingM."Output Document No.";
                                IoTDataStagingMR.MODIFY;
                                COMMIT;
                              END;
                            END;
                            */
                          END;
                      END;
                    UNTIL WhseRequest.NEXT = 0;
                END;
              END;
              IoTDataStaging."Document Type" IN [IoTDataStaging."Document Type"::"Sales Ship"]:
                BEGIN
                  IoTRFIDs.RESET;
                  IoTRFIDs.GET(IoTDataStaging."RFID Gate No.");
                  IoTDataStagingM.RESET;
                  IoTDataStagingM.SETRANGE(IoTDataStagingM."File Name",IoTDataStaging."File Name");
                  IoTDataStagingM.SETRANGE(IoTDataStagingM."Date Imported",IoTDataStaging."Date Imported");
                  IoTDataStagingM.SETRANGE(IoTDataStagingM."Document No.",IoTDataStaging."Document No.");
                  IoTDataStagingM.FINDFIRST;
                  //MESSAGE('Entry No.: %1\Output Document No.: %2',IoTDataStagingM."Entry No.",IoTDataStagingM."Output Document No.");
                  IF IoTDataStagingM."Output Document No." = '' THEN BEGIN
                    //Create Sales Header and line
                    CLEAR(SalesHeader);
                    SalesHeader.RESET;
                    SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
                    SalesHeader."Posting Date" := TODAY;
                    SalesHeader.INSERT(TRUE);
        
                    //Check and update other fields that are required to be updated!
                    SalesHeader.VALIDATE("Sell-to Customer No.",IoTRFIDs."Customer Code");
                    SalesHeader.VALIDATE("Location Code",IoTRFIDs."Location Code");
                    SalesHeader.VALIDATE("Shipment Method Code",'PU');
                    SalesHeader.MODIFY;
                    COMMIT;
                    //Update IoT Log Table
                    IoTDataStagingM.RESET;
                    IoTDataStagingM.GET(IoTDataStaging."Entry No.");
                    IoTDataStagingM."Record Status" := IoTDataStaging."Record Status"::Processed;
                    IoTDataStagingM."Error Message" := '';
                    IF IoTDataStagingM."Date Processed On" = 0D THEN
                      IoTDataStagingM."Date Processed On" := TODAY;
                    IoTDataStagingM."Output Document Type" := IoTDataStagingM."Output Document Type"::"Sales Order";
                    IoTDataStagingM."Output Document No." := SalesHeader."No.";
                    IoTDataStagingM.MODIFY;
                    //COMMIT;
                  END ELSE BEGIN
                    SalesHeader.RESET;
                    SalesHeader.GET(SalesHeader."Document Type"::Order,IoTDataStagingM."Output Document No.");
                    SalesHeader.SetHideValidationDialog(TRUE);
                    //Update IoT Log Table
                    IoTDataStagingM.RESET;
                    IoTDataStagingM.GET(IoTDataStaging."Entry No.");
                    IoTDataStagingM."Record Status" := IoTDataStaging."Record Status"::Processed;
                    IoTDataStagingM."Error Message" := '';
                    IF IoTDataStagingM."Date Processed On" = 0D THEN
                      IoTDataStagingM."Date Processed On" := TODAY;
                    IoTDataStagingM."Output Document Type" := IoTDataStagingM."Output Document Type"::"Sales Order";
                    IoTDataStagingM."Output Document No." := SalesHeader."No.";
                    IoTDataStagingM.MODIFY;
                    //COMMIT;
                  END;
        
                  //Create Sales Lines
                  //>>CIS.IoT 11/14/23
                  Item.GET(IoTDataStaging."Item No.");
                  SalesLine.RESET;
                  SalesLine.SETRANGE("Document Type",SalesHeader."Document Type");
                  SalesLine.SETRANGE("Document No.",SalesHeader."No.");
                  SalesLine.SETRANGE(Type,SalesLine.Type::Item);
                  SalesLine.SETRANGE("No.",IoTDataStaging."Item No.");
                  SalesLine.SETRANGE("Location Code",IoTRFIDs."Location Code");
                  IF SalesLine.FINDFIRST THEN BEGIN
                    //Update Quantity
                    IF Item."Units per Parcel" <> 0 THEN BEGIN
                      SalesLine.Quantity := SalesLine.Quantity + (IoTDataStaging.Quantity * Item."Units per Parcel");
                    END ELSE BEGIN
                      SalesLine.Quantity := SalesLine.Quantity + IoTDataStaging.Quantity;
                    END;
                    SalesLine."Quantity (Base)" := SalesLine.CalcBaseQty(SalesLine.Quantity);
                    SalesLine."Total Parcels" := SalesLine."Quantity (Base)"/SalesLine."Units per Parcel";
                    SalesLine."Std. Pack Quantity" := SalesLine.CalcStdPackQty(SalesLine."Quantity (Base)");
                    SalesLine."Package Quantity" := SalesLine.CalcPackageQty(SalesLine."Std. Pack Quantity");
                    SalesLine."Outstanding Quantity" := SalesLine.Quantity;
                    SalesLine."Qty. to Invoice" := SalesLine.Quantity;
                    SalesLine."Qty. to Ship" := SalesLine.Quantity;
                    SalesLine."Outstanding Qty. (Base)" := SalesLine."Quantity (Base)";
                    SalesLine."Qty. to Invoice (Base)" := SalesLine."Quantity (Base)";
                    SalesLine."Qty. to Ship (Base)" := SalesLine."Quantity (Base)";
                    SalesLine."Alt. Quantity" := SalesLine.Quantity;
                    SalesLine."Outstanding Gross Weight" := SalesLine."Outstanding Quantity" * SalesLine."Gross Weight";
                    SalesLine."Outstanding Net Weight" := SalesLine."Outstanding Quantity" * SalesLine."Net Weight";
                    SalesLine."Line Gross Weight" := SalesLine.Quantity * SalesLine."Gross Weight";
                    SalesLine."Line Net Weight" := SalesLine.Quantity * SalesLine."Net Weight";
                    SalesLine.UpdateAmounts;
                    SalesLine.UpdatePrePaymentAmounts;
                    SalesLine.InitOutstandingAmount;
                    SalesLine.MODIFY;
                    COMMIT;
                  END ELSE BEGIN
                  //<<CIS.IoT 11/14/23
                    SalesLine.RESET;
                    SalesLine."Document Type" := SalesHeader."Document Type";
                    SalesLine."Document No." := SalesHeader."No.";
                    SalesLine."Line No." := NextLineNo(SalesHeader."No.");
                    SalesLine.Type := SalesLine.Type::Item;
                    SalesLine.VALIDATE("No.",IoTDataStaging."Item No.");
                    //SalesLine.VALIDATE("Unit of Measure Code",'BOX');
                    //Item.GET(IoTDataStaging."Item No.");
                    IF Item."Units per Parcel" <> 0 THEN
                      SalesLine.VALIDATE(Quantity,IoTDataStaging.Quantity * Item."Units per Parcel")
                    ELSE
                      SalesLine.VALIDATE(Quantity,IoTDataStaging.Quantity);
                    //SalesLine.VALIDATE("Location Code",IoTRFIDs."Location Code");
                    SalesLine."Location Code" := IoTRFIDs."Location Code";
                    SalesLine."IoT Lot No." := IoTDataStaging."Lot No.";
                    //IoTDataStaging."Lot No."  ?????
                    SalesLine.INSERT;
                  END;  //CIS.IoT 11/14/23
                  ReservationEntry.RESET;
                  ReservationEntry."Entry No." := NextEntryNo;
                  ReservationEntry."Item No." := SalesLine."No.";
                  ReservationEntry."Location Code" := SalesLine."Location Code";
                  ReservationEntry."Reservation Status" := ReservationEntry."Reservation Status"::Surplus;
                  ReservationEntry.Description := SalesLine.Description;
                  ReservationEntry."Source Type" := 37;
                  ReservationEntry."Source Subtype" := 1;
                  ReservationEntry."Source ID" := SalesLine."Document No.";
                  ReservationEntry."Source Ref. No." := SalesLine."Line No.";
                  ReservationEntry."Shipment Date" := SalesLine."Shipment Date";
                  ReservationEntry."Created By" := USERID;
                  ReservationEntry."Creation Date" := TODAY;
                  ReservationEntry.Positive := FALSE;
                  ReservationEntry."Qty. per Unit of Measure" := SalesLine."Qty. per Unit of Measure";
                  //>>CIS.IoT 11/14/23
                  IF Item."Units per Parcel" <> 0 THEN BEGIN
                    //ReservationEntry.Quantity := -1 * SalesLine.Quantity;
                    ReservationEntry.Quantity := -1 * (IoTDataStaging.Quantity * Item."Units per Parcel");
                    ReservationEntry."Quantity (Base)" := ReservationEntry.Quantity * ReservationEntry."Qty. per Unit of Measure";
                    //ReservationEntry."Qty. to Handle (Base)" := -1 * SalesLine."Quantity (Base)";
                    //ReservationEntry."Qty. to Invoice (Base)" := -1 * SalesLine."Quantity (Base)";
                    ReservationEntry."Qty. to Handle (Base)" := -1 * (IoTDataStaging.Quantity * ReservationEntry."Qty. per Unit of Measure" * Item."Units per Parcel");
                    ReservationEntry."Qty. to Invoice (Base)" := -1 * (IoTDataStaging.Quantity * ReservationEntry."Qty. per Unit of Measure" * Item."Units per Parcel");
                  END ELSE BEGIN
                    //ReservationEntry.Quantity := -1 * SalesLine.Quantity;
                    ReservationEntry.Quantity := -1 * (IoTDataStaging.Quantity);
                    ReservationEntry."Quantity (Base)" := ReservationEntry.Quantity * ReservationEntry."Qty. per Unit of Measure";
                    //ReservationEntry."Qty. to Handle (Base)" := -1 * SalesLine."Quantity (Base)";
                    //ReservationEntry."Qty. to Invoice (Base)" := -1 * SalesLine."Quantity (Base)";
                    ReservationEntry."Qty. to Handle (Base)" := -1 * (IoTDataStaging.Quantity * ReservationEntry."Qty. per Unit of Measure");
                    ReservationEntry."Qty. to Invoice (Base)" := -1 * (IoTDataStaging.Quantity * ReservationEntry."Qty. per Unit of Measure");
                  END;
                  //ReservationEntry."Lot No." := SalesLine."IoT Lot No.";
                  ReservationEntry."Lot No." := IoTDataStaging."Lot No.";
                  //<<CIS.IoT 11/14/23
                  ReservationEntry."Suppressed Action Msg." := FALSE;
                  ReservationEntry."Item Tracking" := ReservationEntry."Item Tracking"::"Lot No.";
                  ReservationEntry.INSERT(TRUE);
        
                  //COMMIT;
                  //Release Sales Order
                  COMMIT;
                  IF NoLinesLeft(IoTDataStaging."RFID Gate No.") THEN
                    IF NOT CODEUNIT.RUN(CODEUNIT::"Release Sales Document",SalesHeader) THEN BEGIN
                      //Update IoT Log Table
                      IoTDataStagingM.RESET;
                      IoTDataStagingM.GET(IoTDataStaging."Entry No.");
                      IoTDataStagingM."Record Status" := IoTDataStaging."Record Status"::Error;
                      IoTDataStagingM."Error Message" := 'Could not release the order';
                      IF IoTDataStagingM."Date Processed On" = 0D THEN
                        IoTDataStagingM."Date Processed On" := TODAY;
                      IoTDataStagingM.MODIFY;
                      //COMMIT;
                    END;
                  //Create Inventory Pick
                  //COMMIT;
                  InventorySetup.GET;
                  IF InventorySetup."IoT Create Invt. Pick" THEN BEGIN
                    //This is by passed on request from Shimpei on a conference call on 07/05/23
                    SalesHeader1.GET(SalesHeader."Document Type",SalesHeader."No.");
                    IF SalesHeader1.Status = SalesHeader1.Status::Released THEN BEGIN
                      WhseRequest.RESET;
                      WhseRequest.SETRANGE(Type,WhseRequest.Type::Outbound);
                      WhseRequest.SETCURRENTKEY("Source Document","Source No.");
                      WhseRequest.SETRANGE("Source Document",WhseRequest."Source Document"::"Sales Order",
                        WhseRequest."Source Document"::"Outbound Transfer");
                      WhseRequest.SETRANGE("Source No.",SalesHeader1."No.");
                      IF WhseRequest.FINDSET THEN REPEAT
                        //MESSAGE('Found Warehouse Request');
                        IF ((WhseRequest.Type = WhseRequest.Type::Inbound) AND (WhseActivHeader.Type <> WhseActivHeader.Type::"Invt. Put-away")) OR
                           ((WhseRequest.Type = WhseRequest.Type::Outbound) AND ((WhseActivHeader.Type <> WhseActivHeader.Type::"Invt. Pick") AND
                                                         (WhseActivHeader.Type <> WhseActivHeader.Type::"Invt. Movement"))) OR
                           (WhseRequest."Source Type" <> WhseActivHeader."Source Type") OR
                           (WhseRequest."Source Subtype" <> WhseActivHeader."Source Subtype") OR
                           (WhseRequest."Source No." <> WhseActivHeader."Source No.") OR
                           (WhseRequest."Location Code" <> WhseActivHeader."Location Code")
                        THEN BEGIN
                          CASE WhseRequest.Type OF
                            WhseRequest.Type::Outbound:
                              IF NOT CreateInvtPickMovement.CheckSourceDoc(WhseRequest) THEN BEGIN
                                //Update IoT Log Table
                                IoTDataStagingM.RESET;
                                IoTDataStagingM.GET(IoTDataStaging."Entry No.");
                                IoTDataStagingM."Record Status" := IoTDataStaging."Record Status"::Error;
                                IoTDataStagingM."Error Message" := 'Outbound:Failed to check Source Document';
                                IF IoTDataStagingM."Date Processed On" = 0D THEN
                                  IoTDataStagingM."Date Processed On" := TODAY;
                                IoTDataStagingM.MODIFY;
                                COMMIT;
                              END;
                          END;
                          InitWhseActivHeader;
                        END;
        
                        CASE WhseRequest.Type OF
                          WhseRequest.Type::Outbound:
                            BEGIN
                              CreateInvtPickMovement.SetWhseRequest(WhseRequest,TRUE);
                              CreateInvtPickMovement.AutoCreatePickOrMove(WhseActivHeader);
                              //Update IoT Log Table
                              IoTDataStagingM.RESET;
                              IoTDataStagingM.GET(IoTDataStaging."Entry No.");
                              IF IoTDataStagingM."Record Status" = IoTDataStaging."Record Status"::Processed THEN BEGIN
                                IoTDataStagingM."Output Document Type" := IoTDataStagingM."Output Document Type";
                                IoTDataStagingM."Output Document No." := IoTDataStagingM."Output Document No.";
                                IoTDataStagingM.MODIFY;
                                //COMMIT;
                              END;
                            END;
                        END;
        
                        IF WhseActivHeader."No." <> '' THEN
                        BEGIN
                          IF WhseRequest."Source Document" = WhseRequest."Source Document"::"Sales Order" THEN
                          BEGIN
                            SalesHeader.GET(SalesHeader."Document Type"::Order, WhseRequest."Source No.");
                            WhseActivHeader."Blanket Order No." := SalesHeader."Blanket Order No.";
                            WhseActivHeader.MODIFY();
                          END;
                        END;
                      UNTIL WhseRequest.NEXT = 0;
                    END;
                  END;
                END;
            END;
          UNTIL IoTDataStaging.NEXT = 0;

    end;

    var
        CreatePick: Boolean;
        DocumentCreated: Boolean;
        SortPick: Option " ",Item,Document,"Shelf/Bin","Due Date",Destination,"Bin Ranking","Action Type";
        WhseActivHeader: Record "5766";
        TempWhseActivHdr: Record "5766" temporary;
        WhseRequest: Record "5765";
        IoTDataStaging: Record "50042";
        SalesHeaderTemp: Record "36" temporary;

    local procedure InitWhseActivHeader()
    begin
        WITH WhseActivHeader DO BEGIN
          INIT;
          CASE WhseRequest.Type OF
            WhseRequest.Type::Inbound:
              Type := Type::"Invt. Put-away";
            WhseRequest.Type::Outbound:
              IF CreatePick THEN
                Type := Type::"Invt. Pick"
              ELSE
                Type := Type::"Invt. Movement";
          END;
          "No." := '';
          "Location Code" := WhseRequest."Location Code";
          "Sorting Method" := SortPick;
        END;
    end;

    local procedure InsertTempWhseActivHdr()
    begin
        TempWhseActivHdr.INIT;
        TempWhseActivHdr := WhseActivHeader;
        TempWhseActivHdr.INSERT;
    end;

    local procedure NextLineNo(DocNo: Code[20]): Integer
    var
        SalesLine: Record "37";
    begin
        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type",SalesLine."Document Type"::Order);
        SalesLine.SETRANGE("Document No.",DocNo);
        IF SalesLine.FINDLAST THEN
          EXIT(SalesLine."Line No." + 10000)
        ELSE
          EXIT(10000);
    end;

    local procedure NoLinesLeft(DocNo: Code[20]): Boolean
    var
        IoTDataStagingL: Record "50042";
    begin
        IoTDataStagingL.RESET;
        IoTDataStagingL.SETRANGE("Record Status",IoTDataStagingL."Record Status"::Pending);
        IoTDataStagingL.SETRANGE("RFID Gate No.",DocNo);
        IF IoTDataStagingL.FINDSET THEN
          EXIT(FALSE);

        EXIT(TRUE);
    end;

    local procedure NextEntryNo(): Integer
    var
        ReservationEntry: Record "337";
    begin
        ReservationEntry.RESET;
        IF ReservationEntry.FINDLAST THEN
          EXIT(ReservationEntry."Entry No." + 1);
    end;
}

