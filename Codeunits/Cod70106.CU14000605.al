
codeunit 70106 CU_14000605
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LAX Receive Line Scanning Mgt.", pubOnAfterClearInputFields, '', false, false)]
    local procedure pubOnAfterClearInputFields(var ReceiveControl: Record "LAX Receive Control")
    begin
        //>> #9851 RTT 03-22-05
        //   ReceiveControl."Mfg. Lot No." := '';
        //<< #9851 RTT 03-22-05

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LAX Receive Line Scanning Mgt.", pubOnAfterEReceiveEnterLotNo, '', false, false)]
    local procedure "LAX Receive Line Scanning Mgt._pubOnAfterEReceiveEnterLotNo"(var EReceiveEnterLotNo: Page "LAX ERec Enter Lot No."; var ReceiveInput: Record "LAX Receive Input"; var ReceiveControl: Record "LAX Receive Control"; var ReceiveStation: Record "LAX Receive Station"; var Handled: Boolean; var ReturnValue: Boolean)
    begin
        ReceiveControl."Input Lot Number" := GetLotNo;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LAX Receive Line Scanning Mgt.", pubOnAfterGetItemInputFields, '', false, false)]
    local procedure pubOnAfterGetItemInputFields(var Receive: Record "LAX Receive"; var ReceiveControl: Record "LAX Receive Control"; var Item: Record Item; var VariantCode: Code[10]; var UnitOfMeasureCode: Code[10])
    begin
        ReceiveControl."Country of Origin Code" := Item."Country/Region of Origin Code";
        ReceiveControl."Next Ship Date" := GetNextShipDate(Item."No.");
    end;


    PROCEDURE GetLotNo(): Code[20];
    VAR
        Item: Record 27;
        NoSeriesMgt: Codeunit "No. Series";
    BEGIN

        //>>IST 081208 CCL $12797 #12797
        //Item.GET(PurchLine."No.");
        Item.GET(ReceiveControl."Input No.");
        //<<IST 081208 CCL $12797 #12797
        Item.TESTFIELD("Lot Nos.");
        EXIT(NoSeriesMgt.GetNextNo(Item."Lot Nos.", WORKDATE, TRUE));
    END;

    PROCEDURE CheckQCHold();
    VAR
        PurchHeader: Record 38;
    BEGIN
        //>>IST 081208 CCL $12797 #12797
        //PurchHeader.GET(PurchHeader."Document Type"::Order,ReceiveControl."Multi Purchase Order No.");
        PurchHeader.GET(PurchHeader."Document Type"::Order, ReceiveControl."Multi Document No.");
        //<<IST 081208 CCL $12797 #12797
        //>> NF1.00:CIS.CM 09-29-15
        //ReceiveControl."QC Hold" :=
        //           QCMgmt.CheckQCHoldReceive(PurchHeader."Buy-from Vendor No.",
        //                                       ReceiveControl."Input No.",ReceiveControl."Input Lot Number");


        ReceiveControl."QC Hold" :=
                            CheckQCHoldReceive(PurchHeader."Buy-from Vendor No.",
                                               ReceiveControl."Input No.", ReceiveControl."Input Lot Number");
        //<< NF1.00:CIS.CM 09-29-15
        IF ReceiveControl."QC Hold" THEN
            ReceiveControl."QC Print Code" := 'QC'
        ELSE
            ReceiveControl."QC Print Code" := '';

    END;

    PROCEDURE GetNextShipDate(ItemNo: Code[20]): Date;
    VAR
        Item: Record 27;
        SalesLine: Record 37;
    BEGIN
        //>> NF1.00:CIS.CM 09-29-15
        IF NOT Item.GET(ItemNo) THEN
            EXIT(0D);

        SalesLine.SETCURRENTKEY("Document Type", Type, "No.", "Variant Code", "Drop Shipment", "Shipment Date");
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        SalesLine.SETRANGE("No.", Item."No.");
        SalesLine.SETRANGE("Drop Shipment", FALSE);
        SalesLine.SETFILTER("Shipment Date", '<>%1', 0D);
        SalesLine.SETFILTER("Outstanding Qty. (Base)", '<>%1', 0);

        IF NOT SalesLine.FIND('-') THEN
            CLEAR(SalesLine);

        EXIT(SalesLine."Shipment Date");
        //<< NF1.00:CIS.CM 09-29-15
    END;

    PROCEDURE CheckQCHoldReceive(VendorNo: Code[20]; ItemNo: Code[20]; LotNo: Code[20]): Boolean;
    VAR
        Item: Record 27;
        ItemVend: Record 99;
    BEGIN
        //>> NF1.00:CIS.CM 09-29-15
        //returns whether item is on incoming qc hold
        Item.GET(ItemNo);

        //if not on hold, then waive
        IF NOT Item."QC Hold" THEN
            EXIT(FALSE);

        //if is on qc hold, verify no waivers
        ItemVend.SETRANGE("Vendor No.", VendorNo);
        ItemVend.SETRANGE("Item No.", Item."No.");
        ItemVend.SETRANGE("Waive QC Hold", TRUE);
        IF ItemVend.FIND('-') THEN
            EXIT(FALSE);

        //only way reach this point is if item is on qc hold and a waiver was not found ,so exit with qc code
        EXIT(TRUE);
        //<< NF1.00:CIS.CM 09-29-15
    END;

    var
        ReceiveControl: Record 14000611;
}
