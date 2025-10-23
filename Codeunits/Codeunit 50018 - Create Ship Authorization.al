codeunit 50018 "Create Ship Authorization"
{
    TableNo = 14002358;

    trigger OnRun()
    var
        LaxEDIreceive: record "LAX EDI Receive Document Hdr.";
    begin
        IF LaxEDIreceive."Document" <> 'I_DELJIT' THEN
            ERROR('EDI Navision Document %1 does not match this function.', LaxEDIreceive."Document");

        EDITemplate.GET(LaxEDIreceive."EDI Template Code");

        EDIRecDocHdr2.GET(
          LaxEDIreceive."Trade Partner No.", LaxEDIreceive."Document", LaxEDIreceive."EDI Document No.", LaxEDIreceive."EDI Version", LaxEDIreceive."Internal Doc. No.");
        IF EDIRecDocHdr2."Company Name" <> COMPANYNAME THEN
            ERROR(
              'The receive document %1 is for company %2. You are currently in company %3.',
              EDIRecDocHdr2."Internal Doc. No.", EDIRecDocHdr2."Company Name", COMPANYNAME);
        IF LaxEDIreceive."Document Created" = LaxEDIreceive."Document Created"::"Ship Auth." THEN
            IF NOT CONFIRM(
              'Shipment Authorization has already been created.\' +
              'Do you wish to re-create it?') THEN
                ERROR('Message not created.');

        ProgressWindow.OPEN(
          'Creating Message......\' +
          'Trading Partner      #1##################\' +
          'Reference No.        #2##################\' +
          'Internal Doc No.     #3########\' +
          'Customer No.         #4##################\' +
          'Creating Lines       #5########');

        EDIRecDocHdr2."Data Error" := TRUE;

        ProgressWindow.UPDATE(1, LaxEDIreceive."Trade Partner No.");
        ProgressWindow.UPDATE(3, LaxEDIreceive."Internal Doc. No.");
        ProgressWindow.UPDATE(4, LaxEDIreceive."Customer No.");

        EDITradePartner.GET(EDIRecDocHdr2."Trade Partner No.");

        EDIRecDocFields.RESET;
        EDIRecDocFields.SETCURRENTKEY("Internal Doc. No.", "Field Name");
        EDIRecDocFields.SETRANGE("Internal Doc. No.", EDIRecDocHdr2."Internal Doc. No.");
        IF EDIRecDocFields.FIND('-') THEN
            IF EDITradePartner."Customer No." <> '' THEN
                LastCustomerNo := EDITradePartner."Customer No."
            ELSE BEGIN
                EDIRecDocFields.RESET;
                EDIRecDocFields.SETCURRENTKEY("Internal Doc. No.", "Table No.", "Field No.");
                EDIRecDocFields.SETRANGE("Internal Doc. No.", EDIRecDocHdr2."Internal Doc. No.");
                EDIRecDocFields.SETRANGE("Table No.", 50015);
                EDIRecDocFields.SETRANGE("Field No.", ShipAuthorization.FIELDNO("Sell-to Customer No."));
                IF EDIRecDocFields.FIND('-') THEN BEGIN
                    EDICustCrossRef.RESET;
                    EDICustCrossRef.SETRANGE("Trade Partner No.", EDIRecDocFields."Trade Partner No.");
                    EDICustCrossRef.SETRANGE("EDI Sell To Code", COPYSTR(EDIRecDocFields."Field Text Value", 1, 20));
                    EDICustCrossRef.FIND('-');
                    LastCustomerNo := COPYSTR(EDIRecDocFields."Field Text Value", 1, 20);
                END;
            END;

        ProgressWindow.UPDATE(4, LastCustomerNo);


        EDIRecDocFields.RESET;
        EDIRecDocFields.SETCURRENTKEY(
          EDIRecDocFields."Internal Doc. No.", "Table No.", "Field No.");
        EDIRecDocFields.SETRANGE(
          EDIRecDocFields."Internal Doc. No.", LaxEDIreceive."Internal Doc. No.");
        EDIRecDocFields.SETRANGE(EDIRecDocFields."Table No.", 50015);
        IF EDIRecDocFields.FIND('-') THEN BEGIN
            // Locking to prevent Deadlocking
            EDIRecDocHdr.LOCKTABLE;
            EDIRecDocFields.LOCKTABLE;
            ShipAuthorization.LOCKTABLE();
            ShipAuthorizationLine.LOCKTABLE();

            ShipAuthorization.INIT();
            CLEAR(ShipAuthorization);
            ShipAuthorization."EDI Trade Partner" := LaxEDIreceive."Trade Partner No.";
            ShipAuthorization."EDI Internal Doc. No." := LaxEDIreceive."Internal Doc. No.";

            EDITradePartner.GET(LaxEDIreceive."Trade Partner No.");
            ShipAuthorization.VALIDATE("Sell-to Customer No.", LastCustomerNo);

            MapShipAuthHdrFields();
            ShipAuthorization.INSERT(TRUE);

            ProgressWindow.UPDATE(2, ShipAuthorization."No.");
        END ELSE
            ERROR('There are not field mapped to the Ship Authorization Header.');

        // Create Lines
        EDIRecDocFields.RESET();
        EDIRecDocFields.SETCURRENTKEY("Internal Doc. No.", "Line No.");
        EDIRecDocFields.SETRANGE("Internal Doc. No.", LaxEDIreceive."Internal Doc. No.");
        InitShipAuthLineValues();
        BeginLineNo := 0;
        IF EDIRecDocFields.FIND('-') THEN
            REPEAT
                IF (EDIRecDocFields."Field No." = ShipAuthorizationLine.FIELDNO(ShipAuthorizationLine."Item No.")) AND
                  (EDIRecDocFields."Table No." = 50016) THEN BEGIN
                    LastItemNo := EDIRecDocFields."Field Text Value";
                    LastItemCrossRefNo := '';
                END;
                IF (EDIRecDocFields."Field No." = ShipAuthorizationLine.FIELDNO(ShipAuthorizationLine."Cross-Reference No.")) AND
                  (EDIRecDocFields."Table No." = 50016) THEN BEGIN
                    LastItemCrossRefNo := EDIRecDocFields."Field Text Value";
                    LastItemNo := '';
                END;
                IF (EDIRecDocFields."Field No." = ShipAuthorizationLine.FIELDNO(ShipAuthorizationLine."EDI Unit of Measure")) AND
                  (EDIRecDocFields."Table No." = 50016) THEN BEGIN
                    LastEDIUOM := EDIRecDocFields."Field Text Value";
                    LastUOM := '';
                END;
                IF ((EDIRecDocFields."Field No." = ShipAuthorizationLine.FIELDNO(ShipAuthorizationLine."Unit of Measure")) AND
                    (EDIRecDocFields."Table No." = 50016)) THEN
                    LastUOM := EDIRecDocFields."Field Text Value";
                IF ((EDIRecDocFields."Field No." = ShipAuthorizationLine.FIELDNO(ShipAuthorizationLine.Quantity)) AND
                    (EDIRecDocFields."Table No." = 50016)) THEN BEGIN
                    IF EDIRecDocFields."Field Integer Value" <> 0 THEN
                        LastQty := EDIRecDocFields."Field Integer Value";
                    IF EDIRecDocFields."Field Dec. Value" <> 0 THEN
                        LastQty := EDIRecDocFields."Field Dec. Value";
                END;
                IF ((EDIRecDocFields."Field No." = ShipAuthorizationLine.FIELDNO(ShipAuthorizationLine."Quantity Per Pack")) AND
                    (EDIRecDocFields."Table No." = 50016)) THEN
                    LastQtyPerPack := EDIRecDocFields."Field Integer Value";
                IF ((EDIRecDocFields."Field No." = ShipAuthorizationLine.FIELDNO(ShipAuthorizationLine."Delivery Order Number")) AND
                    (EDIRecDocFields."Table No." = 50016)) THEN
                    LastDeliveryOrderNo := EDIRecDocFields."Field Text Value";
                IF ((EDIRecDocFields."Field No." = ShipAuthorizationLine.FIELDNO(ShipAuthorizationLine."Transport route")) AND
                    (EDIRecDocFields."Table No." = 50016)) THEN
                    LastTransportRoute := EDIRecDocFields."Field Text Value";
                IF ((EDIRecDocFields."Field No." = ShipAuthorizationLine.FIELDNO(ShipAuthorizationLine."Purchase Order Number")) AND
                    (EDIRecDocFields."Table No." = 50016)) THEN
                    LastPONo := EDIRecDocFields."Field Text Value";
                IF ((EDIRecDocFields."Field No." = ShipAuthorizationLine.FIELDNO(ShipAuthorizationLine."Purchase Order Line No.")) AND
                    (EDIRecDocFields."Table No." = 50016)) THEN
                    LastPOLineNo := EDIRecDocFields."Field Text Value";
                IF ((EDIRecDocFields."Field No." = ShipAuthorizationLine.FIELDNO(ShipAuthorizationLine."Delivery Plan")) AND
                    (EDIRecDocFields."Table No." = 50016)) THEN
                    LastDeliveryPlan := EDIRecDocFields."Field Integer Value";
                IF ((EDIRecDocFields."Field No." = ShipAuthorizationLine.FIELDNO(ShipAuthorizationLine."Place ID")) AND
                    (EDIRecDocFields."Table No." = 50016)) THEN
                    LastPlaceID := EDIRecDocFields."Field Text Value";
                IF ((EDIRecDocFields."Field No." = ShipAuthorizationLine.FIELDNO(ShipAuthorizationLine."Place Description")) AND
                    (EDIRecDocFields."Table No." = 50016)) THEN
                    LastPlaceDescription := EDIRecDocFields."Field Text Value";
                IF ((EDIRecDocFields."Field No." = ShipAuthorizationLine.FIELDNO(ShipAuthorizationLine."Requested Delivery Date")) AND
                    (EDIRecDocFields."Table No." = 50016)) THEN
                    LastReqDeliveryDate := EDIRecDocFields."Field Date Value";
                IF ((EDIRecDocFields."Field No." = ShipAuthorizationLine.FIELDNO(ShipAuthorizationLine."Requested Shipment Date")) AND
                    (EDIRecDocFields."Table No." = 50016)) THEN
                    LastReqShipmentDate := EDIRecDocFields."Field Date Value";
                IF ((EDIRecDocFields."Field No." = ShipAuthorizationLine.FIELDNO(ShipAuthorizationLine."Kanban Plan Code")) AND
                    (EDIRecDocFields."Table No." = 50016)) THEN
                    LastKanbanPlanCode := EDIRecDocFields."Field Text Value";
                IF ((EDIRecDocFields."Field No." = ShipAuthorizationLine.FIELDNO(ShipAuthorizationLine."Label 11z")) AND
                    (EDIRecDocFields."Table No." = 50016)) THEN
                    LastLable11z := EDIRecDocFields."Field Text Value";
                IF ((EDIRecDocFields."Field No." = ShipAuthorizationLine.FIELDNO(ShipAuthorizationLine."Label 12z")) AND
                    (EDIRecDocFields."Table No." = 50016)) THEN
                    LastLable12z := EDIRecDocFields."Field Text Value";
                IF ((EDIRecDocFields."Field No." = ShipAuthorizationLine.FIELDNO(ShipAuthorizationLine."Label 13z")) AND
                    (EDIRecDocFields."Table No." = 50016)) THEN
                    LastLable13z := EDIRecDocFields."Field Text Value";
                IF ((EDIRecDocFields."Field No." = ShipAuthorizationLine.FIELDNO(ShipAuthorizationLine."Label 14z")) AND
                    (EDIRecDocFields."Table No." = 50016)) THEN
                    LastLable14z := EDIRecDocFields."Field Text Value";
                IF ((EDIRecDocFields."Field No." = ShipAuthorizationLine.FIELDNO(ShipAuthorizationLine."Label 15z")) AND
                    (EDIRecDocFields."Table No." = 50016)) THEN
                    LastLable15z := EDIRecDocFields."Field Text Value";
                IF ((EDIRecDocFields."Field No." = ShipAuthorizationLine.FIELDNO(ShipAuthorizationLine."Label 16z")) AND
                    (EDIRecDocFields."Table No." = 50016)) THEN
                    LastLable16z := EDIRecDocFields."Field Text Value";
                IF ((EDIRecDocFields."Field No." = ShipAuthorizationLine.FIELDNO(ShipAuthorizationLine."Label 17z")) AND
                    (EDIRecDocFields."Table No." = 50016)) THEN
                    LastLable17z := EDIRecDocFields."Field Text Value";
                IF ((EDIRecDocFields."Field No." = ShipAuthorizationLine.FIELDNO(ShipAuthorizationLine."Kanban Serial Number Start")) AND
                    (EDIRecDocFields."Table No." = 50016)) THEN
                    LastKanbanStart := EDIRecDocFields."Field Text Value";
                IF ((EDIRecDocFields."Field No." = ShipAuthorizationLine.FIELDNO(ShipAuthorizationLine."Kanban Serial Number End")) AND
                    (EDIRecDocFields."Table No." = 50016)) THEN
                    LastKanbanEnd := EDIRecDocFields."Field Text Value";
                //>>NIF
                IF ((EDIRecDocFields."Field No." = ShipAuthorizationLine.FIELDNO(ShipAuthorizationLine."Ship Authorization No.")) AND
                    (EDIRecDocFields."Table No." = 50016)) THEN
                    LastShipAuthorizationNo := EDIRecDocFields."Field Text Value";
                IF ((EDIRecDocFields."Field No." = ShipAuthorizationLine.FIELDNO(ShipAuthorizationLine."Quantity Qualifier")) AND
                    (EDIRecDocFields."Table No." = 50016)) THEN
                    LastQuantityQualifier := EDIRecDocFields."Field Integer Value";
                //<<NIF
                IF BeginLineNo = 0 THEN
                    BeginLineNo := EDIRecDocFields."Line No.";
                IF EDIRecDocFields."EDI Trigger" = TRUE THEN BEGIN
                    EndLineNo := EDIRecDocFields."Line No.";
                    CreLine();
                    //>>NIF
                    //        InitShipAuthLineValues();
                    InitShipAuthLineValues2();
                    //<<NIF
                    BeginLineNo := 0;
                    EndLineNo := 0;
                END;

            UNTIL EDIRecDocFields.NEXT() = 0;

        // EDIRecDocHdr2."Document Created" := EDIRecDocHdr2."Document Created"::"Ship Auth.";
        EDIRecDocHdr2."Created Date" := WORKDATE();
        EDIRecDocHdr2."Created Time" := TIME;
        EDIRecDocHdr2."Data Error" := FALSE;

        EDIRecDocHdr2.MODIFY;

        COMMIT();

        ProgressWindow.CLOSE();
    end;

    var
        ProgressWindow: Dialog;
        LastCustomerNo: Code[20];
        LastItemNo: Code[20];
        ShipAuthorization: Record 50015;
        ShipAuthorizationLine: Record 50016;
        EDIRecDocHdr: Record 14002358;
        EDIRecDocHdr2: Record 14002358;
        EDITemplate: Record 14002350;
        EDITradePartner: Record 14002360;
        EDIRecDocFields: Record 14002359;
        EDICustCrossRef: Record 14002362;
        LastItemCrossRefNo: Code[20];
        LastUOM: Code[10];
        LastEDIUOM: Code[10];
        LastQty: Integer;
        BeginLineNo: Integer;
        EndLineNo: Integer;
        LastQtyPerPack: Integer;
        LastDeliveryOrderNo: Text[35];
        LastTransportRoute: Text[35];
        LastRefNo: Text[35];
        LastPONo: Text[35];
        LastPOLineNo: Code[10];
        LastDeliveryPlan: Integer;
        LastPlaceID: Code[25];
        LastPlaceDescription: Text[30];
        LastReqDeliveryDate: Date;
        LastReqShipmentDate: Date;
        LastKanbanPlanCode: Text[35];
        LastLable11z: Text[35];
        LastLable12z: Text[35];
        LastLable13z: Text[35];
        LastLable14z: Text[35];
        LastLable15z: Text[35];
        LastLable16z: Text[35];
        LastLable17z: Text[35];
        ShipAuthLineNo: Integer;
        LastKanbanStart: Text[35];
        LastKanbanEnd: Text[35];
        ">>GV_NIF": Integer;
        LastShipAuthorizationNo: Text[30];
        LastQuantityQualifier: Integer;

    procedure MapShipAuthHdrFields()
    begin
        EDIRecDocFields.RESET;
        EDIRecDocFields.SETCURRENTKEY("Internal Doc. No.", "Table No.", "Field No.");
        EDIRecDocFields.SETRANGE("Internal Doc. No.", EDIRecDocHdr2."Internal Doc. No.");
        EDIRecDocFields.SETRANGE(EDIRecDocFields."Table No.", 50015);
        IF EDIRecDocFields.FIND('-') THEN
            REPEAT
                CASE EDIRecDocFields."Field No." OF
                    ShipAuthorization.FIELDNO(ShipAuthorization."Reference No."):
                        ShipAuthorization."Reference No." := EDIRecDocFields."Field Text Value";
                    ShipAuthorization.FIELDNO(ShipAuthorization."Document Date"):
                        ShipAuthorization."Document Date" := EDIRecDocFields."Field Date Value";
                    ShipAuthorization.FIELDNO(ShipAuthorization."Horizon Start Date"):
                        ShipAuthorization."Horizon Start Date" := EDIRecDocFields."Field Date Value";
                    ShipAuthorization.FIELDNO(ShipAuthorization."Horizon End Date"):
                        ShipAuthorization."Horizon End Date" := EDIRecDocFields."Field Date Value";
                    ShipAuthorization.FIELDNO(ShipAuthorization."Planning Schedule Party ID"):
                        ShipAuthorization."Planning Schedule Party ID" := EDIRecDocFields."Field Text Value";
                    ShipAuthorization.FIELDNO(ShipAuthorization."Ship From Party ID"):
                        ShipAuthorization."Ship From Party ID" := EDIRecDocFields."Field Text Value";
                    ShipAuthorization.FIELDNO(ShipAuthorization."Ship To Party ID"):
                        ShipAuthorization."Ship To Party ID" := EDIRecDocFields."Field Text Value";
                    ShipAuthorization.FIELDNO(ShipAuthorization."Supplier Party ID"):
                        ShipAuthorization."Supplier Party ID" := EDIRecDocFields."Field Text Value";
                    ShipAuthorization.FIELDNO(ShipAuthorization."Planning Schedule No."):
                        ShipAuthorization."Planning Schedule No." := EDIRecDocFields."Field Text Value";
                END;
            UNTIL EDIRecDocFields.NEXT = 0;
    end;

    procedure InitShipAuthLineValues()
    begin
        LastItemNo := '';
        LastItemCrossRefNo := '';
        LastUOM := '';
        LastEDIUOM := '';
        LastQty := 0;
        LastQtyPerPack := 0;
        LastDeliveryOrderNo := '';
        LastTransportRoute := '';
        LastPONo := '';
        LastPOLineNo := '';
        LastDeliveryPlan := 0;
        LastPlaceID := '';
        LastPlaceDescription := '';
        LastReqDeliveryDate := 0D;
        LastReqShipmentDate := 0D;
        LastKanbanPlanCode := '';
        LastLable11z := '';
        LastLable12z := '';
        LastLable13z := '';
        LastLable14z := '';
        LastLable15z := '';
        LastLable16z := '';
        LastLable17z := '';
        //>> NIF
        LastShipAuthorizationNo := '';
        LastQuantityQualifier := 0;
        //<< NIF
    end;

    procedure CreLine()
    begin
        ShipAuthorizationLine.SETRANGE(ShipAuthorizationLine."Document No.", ShipAuthorization."No.");
        IF ShipAuthorizationLine.FIND('+') THEN
            ShipAuthLineNo := ShipAuthorizationLine."Line No." + 10000
        ELSE
            ShipAuthLineNo := 10000;

        ShipAuthorizationLine.INIT;
        ProgressWindow.UPDATE(5, ShipAuthorizationLine."Line No.");

        ShipAuthorizationLine.VALIDATE("Sell-to Customer No.", LastCustomerNo);
        ShipAuthorizationLine."Document No." := ShipAuthorization."No.";
        ShipAuthorizationLine."Line No." := ShipAuthLineNo;
        ShipAuthorizationLine.VALIDATE("Item No.", LastItemNo);
        IF LastItemCrossRefNo <> '' THEN BEGIN
            ShipAuthorizationLine."Cross-Reference Type" := ShipAuthorizationLine."Cross-Reference Type"::Customer;
            ShipAuthorizationLine.VALIDATE("Cross-Reference No.", LastItemCrossRefNo);
            ShipAuthorizationLine.VALIDATE("Cross-Reference Type No.", LastCustomerNo);
        END;
        ShipAuthorizationLine.VALIDATE(Quantity, LastQty);
        ShipAuthorizationLine."Quantity Per Pack" := LastQtyPerPack;

        //ShipAuthorizationLine."Unit of Measure" := LastUOM;
        //ShipAuthorizationLine."Unit of Measure Code"

        ShipAuthorizationLine."Delivery Order Number" := LastDeliveryOrderNo;
        ShipAuthorizationLine."Transport route" := LastTransportRoute;
        ShipAuthorizationLine."Purchase Order Number" := LastPONo;
        ShipAuthorizationLine."Purchase Order Line No." := LastPOLineNo;
        ShipAuthorizationLine."Delivery Plan" := LastDeliveryPlan;
        ShipAuthorizationLine."Place ID" := LastPlaceID;
        ShipAuthorizationLine."Place Description" := LastPlaceDescription;
        ShipAuthorizationLine."Requested Delivery Date" := LastReqDeliveryDate;
        ShipAuthorizationLine."Requested Shipment Date" := LastReqShipmentDate;
        ShipAuthorizationLine."Kanban Plan Code" := LastKanbanPlanCode;
        ShipAuthorizationLine."Label 11z" := LastLable11z;
        ShipAuthorizationLine."Label 12z" := LastLable12z;
        ShipAuthorizationLine."Label 13z" := LastLable13z;
        ShipAuthorizationLine."Label 14z" := LastLable14z;
        ShipAuthorizationLine."Label 15z" := LastLable15z;
        ShipAuthorizationLine."Label 16z" := LastLable16z;
        ShipAuthorizationLine."Label 17z" := LastLable17z;
        ShipAuthorizationLine."Kanban Serial Number Start" := LastKanbanStart;
        ShipAuthorizationLine."Kanban Serial Number End" := LastKanbanEnd;
        //>>NIF
        ShipAuthorizationLine."Ship Authorization No." := LastShipAuthorizationNo;
        ShipAuthorizationLine."Quantity Qualifier" := LastQuantityQualifier;
        CASE LastQuantityQualifier OF
            3:
                ShipAuthorizationLine."Qty. Type" := ShipAuthorizationLine."Qty. Type"::"Cum. Qty. Shipped";
            79:
                ShipAuthorizationLine."Qty. Type" := ShipAuthorizationLine."Qty. Type"::"Cum. Qty. Scheduled";
            1:
                ShipAuthorizationLine."Qty. Type" := ShipAuthorizationLine."Qty. Type"::"Qty. to Ship";
            135:
                ShipAuthorizationLine."Qty. Type" := ShipAuthorizationLine."Qty. Type"::"Period Qty. Planned";
        END;
        //<<NIF
        ShipAuthorizationLine.INSERT(TRUE);

        EDIRecDocFields."Document No." := ShipAuthorizationLine."Document No.";
        EDIRecDocFields."Document Line No." := ShipAuthorizationLine."Line No.";
        EDIRecDocFields.MODIFY;
    end;

    procedure ">>GF_NIF"()
    begin
    end;

    procedure InitShipAuthLineValues2()
    begin
        LastQty := 0;
        LastQtyPerPack := 0;
        LastDeliveryOrderNo := '';
        LastTransportRoute := '';
        LastPOLineNo := '';
        LastDeliveryPlan := 0;
        LastPlaceID := '';
        LastPlaceDescription := '';
        LastReqDeliveryDate := 0D;
        LastReqShipmentDate := 0D;
        LastKanbanPlanCode := '';
        LastLable11z := '';
        LastLable12z := '';
        LastLable13z := '';
        LastLable14z := '';
        LastLable15z := '';
        LastLable16z := '';
        LastLable17z := '';
        LastShipAuthorizationNo := '';
        LastQuantityQualifier := 0;
    end;
}

