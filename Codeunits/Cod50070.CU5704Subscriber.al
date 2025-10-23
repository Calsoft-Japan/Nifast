codeunit 50070 CU5704Subscriber
{
    ///Version NAVW17.10,SE0.60,NV4.35,NIF1.057,NIF.N15.C9IN.001;

    Permissions = TableData 910 = rm,
                TableData 6507 = i;

    var
        InvtSetup: Record "Inventory Setup";
        Shipping: Codeunit 14000701;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", OnAfterCheckInvtPostingSetup, '', false, false)]
    local procedure OnAfterCheckInvtPostingSetup(var TransferHeader: Record "Transfer Header"; var TempWhseShipmentHeader: Record "Warehouse Shipment Header" temporary; var SourceCode: Code[10])
    begin
        InvtSetup.Get();

        // >> Shipping
        /*  IF InvtSetup."Enable Shipping" AND
            (InvtSetup."E-Ship Locking Optimization" =
             InvtSetup."E-Ship Locking Optimization"::Base)
         THEN
             Shipping.CheckTransferHeader(TransferHeader); */

        IF InvtSetup."LAX Enable Shipping" AND (InvtSetup."LAX EShip Locking Optimization" = InvtSetup."LAX E-Rec Locking Optimization"::Base) THEN
            Shipping.CheckTransferHeader(TransferHeader);
        // << Shipping
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", OnBeforeInsertTransShptHeader, '', false, false)]
    local procedure OnBeforeInsertTransShptHeader(var TransShptHeader: Record "Transfer Shipment Header"; TransHeader: Record "Transfer Header"; CommitIsSuppressed: Boolean)
    var
        PostedAssemblyHeader: Record 910;
    begin
        // >> Shipping
        TransShptHeader."LAX E-Ship Agent Service" := TransHeader."LAX E-Ship Agent Service";
        TransShptHeader."LAX World Wide Service" := TransHeader."LAX World Wide Service";
        TransShptHeader."LAX Residential Delivery" := TransHeader."LAX Residential Delivery";
        TransShptHeader."LAX Shipping Payment Type" := TransHeader."LAX Shipping Payment Type";
        TransShptHeader."LAX Third Party Ship. Acct No." := TransHeader."LAX Third Party Ship. Acct No.";
        TransShptHeader."LAX Shipping Insurance" := TransHeader."LAX Shipping Insurance";
        // << Shipping
        // >> EDI
        TransShptHeader."LAX EDI Order" := TransHeader."LAX EDI Order";
        TransShptHeader."LAX EDI Internal Doc. No." := TransHeader."LAX EDI Internal Doc. No.";
        TransShptHeader."LAX EDI Trade Partner" := TransHeader."LAX EDI Trade Partner";
        TransShptHeader."LAX EDI Transfer Order Gen." := TransHeader."LAX EDI Transfer Order Gen.";
        TransShptHeader."LAX EDI Trans. Order Gen. Date" := TransHeader."LAX EDI Trans. Order Gen. Date";
        TransShptHeader."LAX EDI Transfer-from Code" := TransHeader."LAX EDI Transfer-from Code";
        TransShptHeader."LAX EDI Transfer-to Code" := TransHeader."LAX EDI Transfer-to Code";
        TransShptHeader."LAX EDI In-Transit Code" := TransHeader."LAX EDI In-Transit Code";
        // << EDI 

        // >>NIF MAK 061305
        TransShptHeader."Vessel Name" := TransHeader."Vessel Name";
        TransShptHeader."Sail-On Date" := TransHeader."Sail-On Date";
        // <<NIF MAK 061305
        //TODO
        // >> 7813 NV DRS 09-09-03
        TransShptHeader."Container No." := TransHeader."Container No.";
        // << 7813 NV DRS 09-09-03 
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

        InvtSetup.Get();

        // >> Shipping
        IF InvtSetup."LAX Enable Shipping" AND
           (InvtSetup."LAX EShip Locking Optimization" =
            InvtSetup."LAX EShip Locking Optimization"::Base)
        THEN
            Shipping.PostPackageTransferShipment(TransferHeader, TransferShipmentHeader);
        // << Shipping 
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", OnAfterInvtAdjmt, '', false, false)]
    local procedure OnAfterInvtAdjmt(var TransferHeader: Record "Transfer Header"; var TransferShipmentHeader: Record "Transfer Shipment Header")
    begin
        InvtSetup.Get();

        // >> Shipping
        IF InvtSetup."LAX Enable Shipping" AND
           (InvtSetup."LAX EShip Locking Optimization" =
            InvtSetup."LAX EShip Locking Optimization"::Packing)
        THEN BEGIN
            Shipping.CheckTransferHeader(TransferHeader);

            Shipping.PostPackageTransferShipment(TransferHeader, TransferShipmentHeader);
        END;
        // << Shipping 
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", OnBeforeCopyTransLines, '', false, false)]
    local procedure OnBeforeCopyTransLines(TransferHeader: Record "Transfer Header")
    begin
        InvtSetup.Get();
        // >> Shipping
        IF InvtSetup."LAX Enable Shipping" THEN
            Shipping.BlankBillOFLadingNoTransHeader(TransferHeader, FALSE);
        // << Shipping 
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", OnRunOnBeforeCommit, '', false, false)]
    local procedure OnRunOnBeforeCommit(var TransferHeader: Record "Transfer Header"; var TransferShipmentHeader: Record "Transfer Shipment Header"; PostedWhseShptHeader: Record "Posted Whse. Shipment Header"; var SuppressCommit: Boolean)
    begin
        InvtSetup.Get();

        // >> Shipping
        IF InvtSetup."LAX Enable Shipping" THEN
            Shipping.CreateBOLPostTransferShipment(TransferShipmentHeader);
        // << Shipping 
    end;

    [EventSubscriber(ObjectType::Table, database::"Transfer Shipment Line", OnAfterCopyFromTransferLine, '', false, false)]
    local procedure OnAfterCopyFromTransferLine(var TransferShipmentLine: Record "Transfer Shipment Line"; TransferLine: Record "Transfer Line")
    begin
        //TODO
        // >> 7813 NV DRS 09-09-03
        TransferShipmentLine."Final Destination" := TransferLine."Final Destination";
        TransferShipmentLine."Container No." := TransferLine."Container No.";
        // << 7813 NV DRS 09-09-03

        // >> NV 09-15-04
        TransferShipmentLine."License Plate No." := TransferLine."License Plate No.";
        // << NV 09-15-04 
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

        // >> EDI
        TransferShipmentLine."LAX EDI Segment Group" := TransferLine."LAX EDI Segment Group";
        // << EDI
    end;
}