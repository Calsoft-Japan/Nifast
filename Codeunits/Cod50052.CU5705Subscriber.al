codeunit 50052 CU5705Subscriber
{
    //Version NAVW17.00,SE0.53.14,NV4.35,NIF1.057,NIF.N15.C9IN.001;

    var
        InvtSetup: Record "Inventory Setup";
    /*  Receiving: Codeunit 14000601;
   ReservMgt: Codeunit 99000845;
   BOL: Code[20];
   CarrierNo: Code[20];
   CarrierTrailer: Code[20]; */


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", OnAfterCheckInvtPostingSetup, '', false, false)]
    local procedure OnAfterCheckInvtPostingSetup(var TransferHeader: Record "Transfer Header"; var WarehouseReceiptHeader: Record "Warehouse Receipt Header"; var SourceCode: Code[10])
    var
    /*  ">> WC Locals": Integer;
     rTransLine: Record 5741;
     NVM: Codeunit 50021; */
    begin
        //NV Code commented out
        /*    {
           //>> NV4.32 05.21.04 JWW: Rework
           IF GUIALLOWED THEN BEGIN
         IF (NVM.TestPermission(14017931)) AND ("Rework No." <> '') THEN BEGIN
             Window.OPEN(
               '#1#################################\\' +
               Text003 + '\\' +
               '#3#############################');
         END ELSE BEGIN
             Window.OPEN(
               '#1#################################\\' +
                Text003);
         END;
     END;
           } */
        //<< NV4.32 05.21.04 JWW: Rework

        //>> NV4.35 ISTRTT
        //IF GUIALLOWED THEN
        //<< NV4.35 ISTRTT

        InvtSetup.Get();

        //TODO
        /*    // >> Receiving
           IF InvtSetup."Enable Receive" AND
              (InvtSetup."E-Receive Locking Optimization" =
               InvtSetup."E-Receive Locking Optimization"::Base)
           THEN
               Receiving.CheckTransferHeader(TransHeader);
           // << Receiving */
        //TODO
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", OnBeforeTransRcptHeaderInsert, '', false, false)]
    local procedure OnBeforeTransRcptHeaderInsert(var TransferReceiptHeader: Record "Transfer Receipt Header"; TransferHeader: Record "Transfer Header")
    begin
        //NV COde commented
        /*  {
         // >>NIF MAK 061305
         TransRcptHeader."Vessel Name" := "Vessel Name";
   TransRcptHeader."Sail-On Date" := "Sail-On Date";
   // <<NIF MAK 061305

   // >> 7813 NV DRS 09-09-03
   TransRcptHeader."Container No." := "Container No.";
         // << 7813 NV DRS 09-09-03
         //>>NV 03.31.04 JWW:
         //>>NV 122805 DRS  $99999 #99999
         //  TransRcptHeader."Rework No." := "Rework No.";
         //  TransRcptHeader."Rework Line No." := "Rework Line No.";
         //<<NV 122805 DRS  $99999 #99999
         //<<NV 03.31.04 JWW:
} */

        //NV COde commented
        /*    {
           // >> pfc
           TransRcptHeader."Inbound Bill of Lading" := BOL;
     TransRcptHeader."Carrier Vendor No." := CarrierNo;
     TransRcptHeader."Carrier Trailer ID" := CarrierTrailer;
           // << pfc
           } */

        //TODO
        // TransferReceiptHeader."Posted Assembly Order No." := TransferHeader."Posted Assembly Order No.";  //NF1.00:CIS.NG  10/26/15
        //TODO
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", OnAfterInsertTransRcptHeader, '', false, false)]
    local procedure OnAfterInsertTransRcptHeader(var TransRcptHeader: Record "Transfer Receipt Header"; var TransHeader: Record "Transfer Header")
    var
    /*   InvtCommentLine: Record "Inventory Comment Line";
      RecordLinkManagement: Codeunit "Record Link Management"; */
    begin
        //NV Code commented out below
        //>>NV 03.31.04 JWW:
        //>>NV 122805 DRS  $99999 #99999
        /*       {
              IF NVM.TestPermission(14017931) THEN BEGIN
            ReworkRouting.RESET;
            ReworkRouting.SETRANGE("Rework No.", "Rework No.");
            ReworkRouting.SETRANGE("Line No.", "Rework Line No.");
            IF "Transfer-to Code" = InvtSetup."Rework Location Code" THEN
                ReworkRouting.SETRANGE(Process, ReworkRouting.Process::"Transfer Out")
            ELSE
                ReworkRouting.SETRANGE(Process, ReworkRouting.Process::"Transfer In");
            IF ReworkRouting.FIND('-') THEN BEGIN
                ReworkRouting."Posted Document No." := TransRcptHeader."No.";
                ReworkRouting.MODIFY;
            END;

            ProdKitHeader.RESET;
            IF ProdKitHeader.GET("Rework No.") THEN BEGIN
                IF "Transfer-to Code" = InvtSetup."Rework Location Code" THEN
                    ProdKitHeader."Rework - Transfer Out" := ProdKitHeader."Rework - Transfer Out"::Received
                ELSE
                    ProdKitHeader."Rework - Transfer In" := ProdKitHeader."Rework - Transfer In"::Received;
                ProdKitHeader.MODIFY;
            END;
        END;
              } */
        //<<NV 122805 DRS  $99999 #99999
        //<<NV 03.31.04 JWW:

        InvtSetup.Get();
        //TODO
        /*   // >> Receiving
          IF InvtSetup."Enable Receive" AND
             (InvtSetup."E-Receive Locking Optimization" =
              InvtSetup."E-Receive Locking Optimization"::Base)
          THEN
              Receiving.PostReceiveTransferHeader(TransHeader, TransRcptHeader);
          // << Receiving */
        //TODO
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", OnRunOnAfterTransLineSetFiltersForRcptLines, '', false, false)]
    local procedure OnRunOnAfterTransLineSetFiltersForRcptLines(var TransferLine: Record "Transfer Line"; TransferHeader: Record "Transfer Header"; Location: Record Location; WhseReceive: Boolean)
    begin
        //NV COde commented
        /*  {
         // >> 7813 NV DRS 09-09-03
         CLEAR(rTransLine);
   rTransLine.COPY(TransLine);
   CreateFinalDestTransfers(rTransLine);
         // << 7813 NV DRS 09-09-03
         } */
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", OnBeforeInsertTransRcptLine, '', false, false)]
    local procedure OnBeforeInsertTransRcptLine(var TransRcptLine: Record "Transfer Receipt Line"; TransLine: Record "Transfer Line"; CommitIsSuppressed: Boolean; var IsHandled: Boolean; TransferReceiptHeader: Record "Transfer Receipt Header")
    begin
        //NV COde commented
        /*  {
         // >> 7813 NV DRS 09-09-03
         TransRcptLine."Final Destination" := TransLine."Final Destination";
TransRcptLine."Container No." := TransLine."Container No.";
// << 7813 NV DRS 09-09-03

// >> NV
TransRcptLine."License Plate No." := TransLine."License Plate No.";
// << NV

//>>NV4.32 05.05.04 JWW:
//>>NV 122805 DRS  $99999 #99999
//      TransRcptLine."Rework No." := TransRcptHeader."Rework No.";
//      TransRcptLine."Rework Line No." := TransRcptHeader."Rework Line No.";
//<<NV 122805 DRS  $99999 #99999
//<<NV4.32 05.05.04 JWW:
//>> RTT 09-20-05 RTT
TransRcptLine."Source PO No." := TransLine."Source PO No.";
TransRcptLine."Contract Note No." := TransLine."Contract Note No.";
         //<< RTT 09-20-05 RTT
         } */
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", OnInsertTransRcptLineOnBeforePostWhseJnlLine, '', false, false)]
    local procedure OnInsertTransRcptLineOnBeforePostWhseJnlLine(var TransRcptLine: Record "Transfer Receipt Line"; var TransLine: Record "Transfer Line"; SuppressCommit: Boolean; var WhsePosting: Boolean; var ShouldRunPosting: Boolean)
    begin
        //NV COde commented
        /*    {
           // >> NV LPN
           IF (WhseReceive) AND
                 ((WhseRcptLine."License Plate No." <> '') OR (WhseRcptLine."Transfer License Plate No." <> '')) THEN BEGIN
   WhseRcptLine.SETCURRENTKEY(
     "No.", "Source Type", "Source Subtype", "Source No.", "Source Line No.");
   WhseRcptLine.SETRANGE("No.", WhseRcptHeader."No.");
   WhseRcptLine.SETRANGE("Source Type", DATABASE::"Transfer Line");
   WhseRcptLine.SETRANGE("Source No.", TransLine."Document No.");
   WhseRcptLine.SETRANGE("Source Line No.", TransLine."Line No.");
   IF WhseRcptLine.FIND('-') THEN
       REPEAT
           CLEAR(LicensePlateMgt);
           LicensePlateMgt.UpdateLicensePlates(
             WhseRcptLine."License Plate No.",
             WhseRcptLine."License Plate No.",
             WhseRcptLine."Location Code",
             WhseRcptLine."Zone Code",
             WhseRcptLine."Bin Code");
           LicensePlateMgt.UpdateLicensePlates(
             WhseRcptLine."Transfer License Plate No.",
             WhseRcptLine."Transfer License Plate No.",
             WhseRcptLine."Location Code",
             WhseRcptLine."Zone Code",
             WhseRcptLine."Bin Code");
       UNTIL WhseRcptLine.NEXT = 0;
END;
           // << NV LPN
           } */
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", OnRunOnAfterInsertTransRcptLines, '', false, false)]
    local procedure OnRunOnAfterInsertTransRcptLines(TransRcptHeader: Record "Transfer Receipt Header"; TransferLine: Record "Transfer Line"; TransferHeader: Record "Transfer Header"; Location: Record Location; WhseReceive: Boolean)
    begin
        InvtSetup.Get();

        //TODO
        /*     // >> Receiving
            IF InvtSetup."Enable Receive" AND
               (InvtSetup."E-Receive Locking Optimization" =
                InvtSetup."E-Receive Locking Optimization"::Receiving)
            THEN BEGIN
                Receiving.CheckTransferHeader(TransferHeader);

                Receiving.PostReceiveTransferHeader(TransferHeader, TransRcptHeader);
            END;
            // << Receiving */
        //TODO
    end;

    PROCEDURE "NV>>"();
    BEGIN
    END;

    PROCEDURE ReworkSalesLineReservation();
    VAR
    /*    SalesLine: Record 37;
       ItemLedgEntry: Record 32;
       ILE: Record 32;
       QtyToReserve: Decimal;
       QtyReserved: Decimal;
       ReservEntry: Record 337;
       CallTrackingSpecification: Record 336; */
    BEGIN
        //NV COde commented
        /* {
        // ReworkSalesLineReservation()
        //-> Sales Line Reservation
        ProdHeader.RESET;
          ProdHeader.SETRANGE("Production Kit No.", TransHeader."Rework No.");
          IF NOT ProdHeader.FIND('+') THEN
              EXIT;
          IF NOT ProdHeader.Rework THEN
              EXIT;
          IF ProdHeader."Completion In Progress" THEN
              EXIT;

          IF SalesLine.GET(SalesLine."Document Type"::Order, ProdHeader."Sales Order No.", ProdHeader."Sales Order Line No.") THEN BEGIN
              IF ItemLedgEntry.FIND('+') THEN
                  ILE := ItemLedgEntry;

              //  Window.UPDATE(3,'Posting Reservation');
              SalesLine.CALCFIELDS("Reserved Qty. (Base)");
              QtyReserved := SalesLine."Reserved Qty. (Base)";
              QtyToReserve := SalesLine."Outstanding Qty. (Base)";
              ReservEntry."Source Type" := DATABASE::"Sales Line";
              ReservEntry."Source Subtype" := SalesLine."Document Type";
              ReservEntry."Source ID" := SalesLine."Document No.";
              ReservEntry."Source Ref. No." := SalesLine."Line No.";
              ReservEntry."Item No." := SalesLine."No.";
              ReservEntry."Variant Code" := SalesLine."Variant Code";
              ReservEntry."Location Code" := SalesLine."Location Code";
              ReservEntry."Shipment Date" := SalesLine."Shipment Date";
              CLEAR(ReservMgt);
              ReservMgt.SetSalesLine(SalesLine);
              //>>CIS.001 Updated during merge
              //ReservMgt.CreateReservation(
              //           SalesLine.Description,0D,ILE."Remaining Quantity",
              //           DATABASE::"Item Ledger Entry",0,'','',0,
              //           ILE."Entry No.",ILE."Variant Code",
              //           ILE."Location Code",
              //           '','',ILE."Qty. per Unit of Measure");
              ReservMgt.CreateTrackingSpecification(CallTrackingSpecification,
                DATABASE::"Item Ledger Entry", 0, '', '', 0, ILE."Entry No.",
                ILE."Variant Code", ILE."Location Code",
                ILE."Serial No.", ILE."Lot No.",
                ILE."Qty. per Unit of Measure");
              //ReservationCreated := ReservMgt.CallCreateReservation(RemainingQtyToReserve,RemainingQtyToReserveBase,ReservQty,Description,ExpectedDate,QtyThisLine,QtyThisLineBase,TrackingSpecification)

              IF ReservMgt.CallCreateReservation(ILE."Remaining Quantity", ILE."Remaining Quantity" * ILE."Qty. per Unit of Measure", 0,
                   SalesLine.Description, 0D, ILE."Remaining Quantity",
                   ROUND(ILE."Remaining Quantity" * ILE."Qty. per Unit of Measure", 0.00001), CallTrackingSpecification)
              THEN
                  IF Location."Bin Mandatory" OR Location."Require Pick" THEN
                      TotalAvailQty := TotalAvailQty - QtyThisLineBase;
              //<<CIS.001
          END;
        //<- Sales Line Reservation
        } */
    END;

    PROCEDURE SetBOL(WhseRcptHeader: Record 7316);
    BEGIN
        /*   {
          // >> pfc
          BOL := WhseRcptHeader."Inbound Bill of Lading No.";
            CarrierNo := WhseRcptHeader."Carrier Vendor No.";
            CarrierTrailer := WhseRcptHeader."Carrier Trailer ID";
          // << pfc
          } */
    END;

    PROCEDURE CreateFinalDestTransfers(VAR rTransLine: Record 5741);
    VAR
    /*     rNewTransLine: Record 5741;
        LastLocationCode: Code[10];
        LastTransferNo: Code[20];
        NextLineNo: Integer; */
    BEGIN
        /* {
        LastTransferNo := '';
          NextLineNo := 10000;

          rTransLine.SETCURRENTKEY("Final Destination");
          rTransLine.SETFILTER("Final Destination", '<>%1', '');
          rTransLine.SETFILTER(Quantity, '<>0');
          rTransLine.SETFILTER("Qty. to Receive", '<>0');
          IF rTransLine.FIND('-') THEN BEGIN
              LastLocationCode := rTransLine."Final Destination";
              LastTransferNo := CreateFinalDestTransferHeader(rTransLine."Transfer-to Code", LastLocationCode);
              REPEAT
                  IF LastLocationCode <> rTransLine."Final Destination" THEN BEGIN
                      LastLocationCode := rTransLine."Final Destination";
                      LastTransferNo := CreateFinalDestTransferHeader(rTransLine."Transfer-to Code", LastLocationCode);
                  END;

                  CLEAR(rNewTransLine);
                  rNewTransLine.VALIDATE("Document No.", LastTransferNo);
                  rNewTransLine.VALIDATE("Line No.", NextLineNo);
                  NextLineNo += 10000;
                  rNewTransLine.VALIDATE("Item No.", rTransLine."Item No.");
                  rNewTransLine.VALIDATE(Quantity, rTransLine."Qty. to Receive");
                  rNewTransLine.VALIDATE("Unit of Measure Code", rTransLine."Unit of Measure Code");
                  rNewTransLine.VALIDATE("Variant Code", rTransLine."Variant Code");
                  rNewTransLine.INSERT(TRUE);
              UNTIL rTransLine.NEXT = 0;
          END;
        } */
    END;

    PROCEDURE CreateFinalDestTransferHeader(TransferFrom: Code[10]; TransferTo: Code[10]): Code[20];
    VAR
    //  rTransferHeader: Record 5740;
    BEGIN
        /*   {
          CLEAR(rTransferHeader);
            rTransferHeader."No." := '';
            rTransferHeader.INSERT(TRUE);
            rTransferHeader.VALIDATE("Transfer-from Code", TransferFrom);
            rTransferHeader.VALIDATE("Transfer-to Code", TransferTo);
            rTransferHeader.MODIFY(TRUE);

            EXIT(rTransferHeader."No.");
          } */
    END;
}