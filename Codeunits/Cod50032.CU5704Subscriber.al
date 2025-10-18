codeunit 50032 CU5704Subscriber
{
    ///Version NAVW17.10,SE0.60,NV4.35,NIF1.057,NIF.N15.C9IN.001;

    Permissions = TableData 910 = rm,
                TableData 6507 = i;

    var
        InvtSetup: Record "Inventory Setup";
    //Shipping: Codeunit 14000701;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", OnAfterCheckInvtPostingSetup, '', false, false)]
    local procedure OnAfterCheckInvtPostingSetup(var TransferHeader: Record "Transfer Header"; var TempWhseShipmentHeader: Record "Warehouse Shipment Header" temporary; var SourceCode: Code[10])
    begin
        InvtSetup.Get();

        //TODO
        /*  // >> Shipping
         IF InvtSetup."Enable Shipping" AND
            (InvtSetup."E-Ship Locking Optimization" =
             InvtSetup."E-Ship Locking Optimization"::Base)
         THEN
             Shipping.CheckTransferHeader(TransHeader); */
        // << Shipping
        //TODO
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", OnBeforeInsertTransShptHeader, '', false, false)]
    local procedure OnBeforeInsertTransShptHeader(var TransShptHeader: Record "Transfer Shipment Header"; TransHeader: Record "Transfer Header"; CommitIsSuppressed: Boolean)
    var
        PostedAssemblyHeader: Record 910;
    begin
        //TODO
        /*  // >> Shipping
         TransShptHeader."E-Ship Agent Service" := "E-Ship Agent Service";
         TransShptHeader."World Wide Service" := "World Wide Service";
         TransShptHeader."Residential Delivery" := "Residential Delivery";
         TransShptHeader."Shipping Payment Type" := "Shipping Payment Type";
         TransShptHeader."Third Party Ship. Account No." := "Third Party Ship. Account No.";
         TransShptHeader."Shipping Insurance" := "Shipping Insurance";
         // << Shipping
         // >> EDI
         TransShptHeader."EDI Order" := "EDI Order";
         TransShptHeader."EDI Internal Doc. No." := "EDI Internal Doc. No.";
         TransShptHeader."EDI Trade Partner" := "EDI Trade Partner";
         TransShptHeader."EDI Transfer Order Generated" := "EDI Transfer Order Generated";
         TransShptHeader."EDI Transfer Order Gen. Date" := "EDI Transfer Order Gen. Date";
         TransShptHeader."EDI Transfer-from Code" := "EDI Transfer-from Code";
         TransShptHeader."EDI Transfer-to Code" := "EDI Transfer-to Code";
         TransShptHeader."EDI In-Transit Code" := "EDI In-Transit Code";
         // << EDI */
        //TODO

        // >>NIF MAK 061305
        TransShptHeader."Vessel Name" := TransHeader."Vessel Name";
        TransShptHeader."Sail-On Date" := TransHeader."Sail-On Date";
        // <<NIF MAK 061305
        //TODO
        /*  // >> 7813 NV DRS 09-09-03
         TransShptHeader."Container No." := TransHeader."Container No.";
         // << 7813 NV DRS 09-09-03 */
        //TODO
        //>>NV 03.31.04 JWW:
        //>>NV 122805 DRS  $99999 #99999
        //  TransShptHeader."Rework No." := "Rework No.";
        //  TransShptHeader."Rework Line No." := "Rework Line No.";
        //<<NV 122805 DRS  $99999 #99999
        //<<NV 03.31.04 JWW:

        TransShptHeader."Posted Assembly Order No." := TransHeader."Posted Assembly Order No.";  //NF1.00:CIS.NG  10/26/15
                                                                                                 //>> NF1.00:CIS.NG  10/30/15
        IF TransHeader."Posted Assembly Order No." <> '' THEN BEGIN
            PostedAssemblyHeader.GET(TransHeader."Posted Assembly Order No.");
            PostedAssemblyHeader."Transfer Order No." := TransHeader."No.";
            PostedAssemblyHeader.MODIFY();
        END;
        //<< NF1.00:CIS.NG  10/30/15
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", OnAfterInsertTransShptHeader, '', false, false)]
    local procedure OnAfterInsertTransShptHeader(var TransferHeader: Record "Transfer Header"; var TransferShipmentHeader: Record "Transfer Shipment Header")
    begin
        //>>NV 03.31.04 JWW:
        //>>NV 122805 DRS  $99999 #99999
        //       {
        //       IF NVM.TestPermission(14017931) THEN BEGIN
        //     ReworkRouting.RESET;
        //     ReworkRouting.SETRANGE("Rework No.", "Rework No.");
        //     ReworkRouting.SETRANGE("Line No.", "Rework Line No.");
        //     IF "Transfer-to Code" = InvtSetup."Rework Location Code" THEN
        //         ReworkRouting.SETRANGE(Process, ReworkRouting.Process::"Transfer Out")
        //     ELSE
        //         ReworkRouting.SETRANGE(Process, ReworkRouting.Process::"Transfer In");
        //     IF ReworkRouting.FIND('-') THEN BEGIN
        //         ReworkRouting."Posted Document No." := TransShptHeader."No.";
        //         ReworkRouting.MODIFY;
        //     END;

        //     ProdKitHeader.RESET;
        //     IF ProdKitHeader.GET("Rework No.") THEN BEGIN
        //         IF "Transfer-to Code" = InvtSetup."Rework Location Code" THEN
        //             ProdKitHeader."Rework - Transfer Out" := ProdKitHeader."Rework - Transfer Out"::Shipped
        //         ELSE
        //             ProdKitHeader."Rework - Transfer In" := ProdKitHeader."Rework - Transfer In"::Shipped;
        //         ProdKitHeader.MODIFY;
        //     END;
        // END;
        //       }
        //<<NV 122805 DRS  $99999 #99999
        //<<NV 03.31.04 JWW:
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", OnRunOnBeforeInsertShipmentLines, '', false, false)]
    local procedure OnRunOnBeforeInsertShipmentLines(var WhseShptHeader: Record "Warehouse Shipment Header"; var WarehouseShipmentLine: Record "Warehouse Shipment Line")
    begin
        InvtSetup.Get();

        //TODO
        /*   // >> Shipping
          IF InvtSetup."Enable Shipping" AND
             (InvtSetup."E-Ship Locking Optimization" =
              InvtSetup."E-Ship Locking Optimization"::Base)
          THEN
              Shipping.PostPackageTransferShipment(TransHeader, TransShptHeader);
          // << Shipping */
        //TODO
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", OnBeforeCopyTransLines, '', false, false)]
    local procedure OnBeforeCopyTransLines(TransferHeader: Record "Transfer Header")
    begin
        InvtSetup.Get();

        //T
        /*   // >> Shipping
          IF InvtSetup."Enable Shipping" AND
             (InvtSetup."E-Ship Locking Optimization" =
              InvtSetup."E-Ship Locking Optimization"::Packing)
          THEN BEGIN
              Shipping.CheckTransferHeader(TransHeader);

              Shipping.PostPackageTransferShipment(TransHeader, TransShptHeader);
          END;
          // << Shipping */
        //TODO

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", OnRunOnBeforeLockTables, '', false, false)]
    local procedure OnRunOnBeforeLockTables(var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line")
    begin
        InvtSetup.Get();

        //TODO
        /*  // >> Shipping
         IF InvtSetup."Enable Shipping" THEN
             Shipping.BlankBillOFLadingNoTransHeader(TransHeader, FALSE);
         // << Shipping */
        //TODO
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", OnRunOnBeforeCommit, '', false, false)]
    local procedure OnRunOnBeforeCommit(var TransferHeader: Record "Transfer Header"; var TransferShipmentHeader: Record "Transfer Shipment Header"; PostedWhseShptHeader: Record "Posted Whse. Shipment Header"; var SuppressCommit: Boolean)
    begin
        InvtSetup.Get();

        //TODO
        /*  // >> Shipping
         IF InvtSetup."Enable Shipping" THEN
             Shipping.CreateBOLPostTransferShipment(TransShptHeader);
         // << Shipping */
        //TODO
    end;

    [EventSubscriber(ObjectType::Table, database::"Transfer Shipment Line", OnAfterCopyFromTransferLine, '', false, false)]
    local procedure OnAfterCopyFromTransferLine(var TransferShipmentLine: Record "Transfer Shipment Line"; TransferLine: Record "Transfer Line")
    begin
        //TODO
        /*  // >> 7813 NV DRS 09-09-03
         TransferShipmentLine."Final Destination" := TransferLine."Final Destination";
         TransferShipmentLine."Container No." := TransferLine."Container No.";
         // << 7813 NV DRS 09-09-03

         // >> NV 09-15-04
         TransferShipmentLine."License Plate No." := TransferLine."License Plate No.";
         // << NV 09-15-04 */
        //TODO

        //>>NV4.32 05.05.04 JWW:
        //>>NV 122805 DRS  $99999 #99999
        //      TransferShipmentLine."Rework No." := TransShptHeader."Rework No.";
        //      TransferShipmentLine."Rework Line No." := TransShptHeader."Rework Line No.";
        //<<NV 122805 DRS  $99999 #99999
        //<<NV4.32 05.05.04 JWW:
        //>> RTT 09-20-05 RTT
        TransferShipmentLine."Source PO No." := TransferLine."Source PO No.";
        TransferShipmentLine."Contract Note No." := TransferLine."Contract Note No.";
        //<< RTT 09-20-05 RTT

        //TODO
        /* // >> EDI
        TransferShipmentLine."EDI Segment Group" := TransferLine."EDI Segment Group";
        // << EDI */
        //TODO
    end;
}