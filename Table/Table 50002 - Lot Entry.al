table 50002 "Lot Entry"
{
    // NF1.00:CIS.RAM   06/10/15 Merged during upgrade
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Lot Entry Functionality Renumber)
    //  # Item Tracking Form Vs. Page conflict

    DrillDownPageID = "Lot Entry";
    LookupPageID = "Lot Entry";
    Permissions = TableData "Whse. Item Tracking Line" = rimd;
    fields
    {
        field(1; "Document Type"; Option)
        {
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Purchase Order",,,"Transfer Order","Whse. Shipment";
        }
        field(2; "Document No."; Code[20])
        {
            // cleaned
        }
        field(3; "Order Line No."; Integer)
        {
            // cleaned
        }
        field(4; "Line No."; Integer)
        {
            // cleaned
        }
        field(5; "Item No."; Code[20])
        {
            // cleaned
            TableRelation = Item;
        }
        field(6; Description; Text[50])
        {
            // cleaned
        }
        field(7; "Unit of Measure Code"; Code[10])
        {
            // cleaned
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(8; Quantity; Decimal)
        {
            // cleaned
        }
        field(9; "Lot No."; Code[20])
        {
            trigger OnValidate()
            begin
                GetLotInfo("Item No.", "Variant Code", "Lot No.", LotNoInfo);
                "Creation Date" := LotNoInfo."Lot Creation Date";
                "External Lot No." := LotNoInfo."Mfg. Lot No.";
            end;
        }
        field(10; "External Lot No."; Code[30])
        {
            Editable = false;
            trigger OnValidate()
            var
            // ItemLedgEntry: Record 32;
            begin
            end;
        }
        field(13; "Location Code"; Code[10])
        {
            // cleaned
            TableRelation = Location;
        }
        field(15; "Variant Code"; Code[10])
        {
            // cleaned
            TableRelation = "Item Variant"."Item No." WHERE("Item No." = FIELD("Item No."));
        }
        field(17; "Expiration Date"; Date)
        {
            // cleaned
        }
        field(18; "Creation Date"; Date)
        {
            // cleaned
        }
        field(50000; "Inspected Parts"; Boolean)
        {
            CalcFormula = Lookup("Lot No. Information"."Passed Inspection" WHERE("Item No." = FIELD("Item No."),
                                                                                  "Lot No." = FIELD("Lot No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50010; "Revision No."; Code[20])
        {
            CalcFormula = Lookup("Lot No. Information"."Revision No." WHERE("Item No." = FIELD("Item No."),
                                                                             "Lot No." = FIELD("Lot No.")));
            Description = 'flowfield based on lot chosen';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50011; "Use Revision No."; Code[20])
        {
            Description = 'used internal for filters and info';
        }
        field(50080; "Country of Origin"; Code[10])
        {
            CalcFormula = Lookup("Lot No. Information"."Country of Origin" WHERE("Item No." = FIELD("Item No."),
                                                                                  "Lot No." = FIELD("Lot No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60000; "CVE Pediment No."; Code[10])
        {
            CalcFormula = Lookup("Lot No. Information"."CVE Pedimento" WHERE("Item No." = FIELD("Item No."),
                                                                              "Variant Code" = FIELD("Variant Code"),
                                                                              "Lot No." = FIELD("Lot No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "CVE Pedimento";
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Order Line No.", "Line No.")
        {
            SumIndexFields = Quantity;
        }
        key(Key2; "Document Type", "Document No.", "Order Line No.", "Lot No.")
        {
            SumIndexFields = Quantity;
        }
    }

    fieldgroups
    {
    }

    var
        LotNoInfo: Record "Lot No. Information";

    procedure "<<Lot Entry Screen>>"()
    begin
    end;

    procedure GetSalesLines(DocType: Integer; DocNo: Code[20])
    var
        SalesLine: Record "Sales Line";
        LotEntry: Record 50002;
        TempSalesLine: Record 37 temporary;
        TrackingSpecificationTmp: Record 336 temporary;
        TrackingSpecification: Record 336 temporary;
        LotEntry2: Record 50002;
        ReserveSalesLine: Codeunit 99000832;
        ItemTrackingForm: Page "Item Tracking Lines";
        UseLineNo: Integer;
    begin
        //set filter
        SalesLine.SETRANGE("Document Type", DocType);
        SalesLine.SETRANGE("Document No.", DocNo);
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        //SETFILTER("Outstanding Quantity",'<>0');
        SalesLine.SETFILTER("Qty. to Ship", '<>0');
        IF NOT SalesLine.FIND('-') THEN
            //ERROR('No Outstanding Lines found.');
            EXIT;

        //delete existing lines
        LotEntry.LOCKTABLE();
        LotEntry.SETRANGE("Document Type", DocType);
        LotEntry.SETRANGE("Document No.", DocNo);
        LotEntry.DELETEALL();

        //init
        TempSalesLine.DELETEALL();
        UseLineNo := 10000;

        REPEAT
            IF IsLotTracking(SalesLine."No.") THEN BEGIN

                //get initial lots
                CLEAR(ReserveSalesLine);
                CLEAR(ItemTrackingForm);
                ReserveSalesLine.InitTrackingSpecification(SalesLine, TrackingSpecification);
                ItemTrackingForm.SetSource(TrackingSpecification, SalesLine."Shipment Date");
                ItemTrackingForm.EShipOpenForm();
                TrackingSpecificationTmp.RESET();
                TrackingSpecificationTmp.DELETEALL();

                ItemTrackingForm.EShipGetRecords(TrackingSpecificationTmp);
                IF TrackingSpecificationTmp.FIND('-') THEN BEGIN
                    REPEAT
                        //insert these lots
                        IF (TrackingSpecificationTmp."Quantity (Base)" - TrackingSpecificationTmp."Quantity Handled (Base)") <> 0 THEN BEGIN
                            LotEntry.INIT();
                            LotEntry."Document Type" := SalesLine."Document Type".AsInteger();
                            LotEntry."Document No." := SalesLine."Document No.";
                            LotEntry."Order Line No." := SalesLine."Line No.";
                            LotEntry."Line No." := UseLineNo;
                            LotEntry."Item No." := SalesLine."No.";
                            LotEntry.Description := SalesLine.Description;
                            LotEntry."Location Code" := SalesLine."Location Code";
                            LotEntry."Variant Code" := SalesLine."Variant Code";
                            LotEntry."Unit of Measure Code" := SalesLine."Unit of Measure Code";
                            LotEntry.Quantity := TrackingSpecificationTmp."Quantity (Base)" -
                                                   TrackingSpecificationTmp."Quantity Handled (Base)";
                            LotEntry."Lot No." := TrackingSpecificationTmp."Lot No.";
                            GetLotInfo(SalesLine."No.", SalesLine."Variant Code", TrackingSpecificationTmp."Lot No.", LotNoInfo);
                            LotEntry."External Lot No." := LotNoInfo."Mfg. Lot No.";
                            LotEntry."Creation Date" := LotNoInfo."Lot Creation Date";
                            LotEntry."Expiration Date" := TrackingSpecificationTmp."Expiration Date";
                            LotEntry."Use Revision No." := SalesLine."Revision No.";
                            LotEntry.INSERT();
                            UseLineNo := UseLineNo + 10000;
                        END;
                    UNTIL TrackingSpecificationTmp.NEXT() = 0;

                    ItemTrackingForm.EShipCloseForm();
                END;  //end for if find lots

                //now get remaining quantity
                LotEntry2.SETRANGE("Document Type", SalesLine."Document Type");
                LotEntry2.SETRANGE("Document No.", SalesLine."Document No.");
                LotEntry2.SETRANGE("Order Line No.", SalesLine."Line No.");
                LotEntry2.CALCSUMS(Quantity);

                //IF (LotEntry2.Quantity<"Outstanding Quantity") THEN
                IF (LotEntry2.Quantity < SalesLine."Qty. to Ship") THEN BEGIN
                    LotEntry.INIT();
                    LotEntry."Document Type" := SalesLine."Document Type".AsInteger();
                    LotEntry."Document No." := SalesLine."Document No.";
                    LotEntry."Order Line No." := SalesLine."Line No.";
                    LotEntry."Line No." := UseLineNo;
                    LotEntry."Item No." := SalesLine."No.";
                    LotEntry.Description := SalesLine.Description;
                    LotEntry."Location Code" := SalesLine."Location Code";
                    LotEntry."Variant Code" := SalesLine."Variant Code";
                    LotEntry."Unit of Measure Code" := SalesLine."Unit of Measure Code";
                    //LotEntry.Quantity := "Outstanding Quantity" - LotEntry2.Quantity;
                    LotEntry.Quantity := SalesLine."Qty. to Ship" - LotEntry2.Quantity;
                    LotEntry."Use Revision No." := SalesLine."Revision No.";
                    LotEntry.INSERT();
                END;
            END;
        UNTIL SalesLine.NEXT() = 0;

        IF LotEntry.ISEMPTY THEN
            ERROR('No Items are lot tracked on this order.');
    end;

    procedure GetPurchLines(DocType: Integer; DocNo: Code[20])
    var
        PurchLine: Record 39;
        LotEntry: Record 50002;
        Item: Record 27;
        ItemTrackingCode: Record 6502;
        TempPurchLine: Record 39 temporary;
        TrackingSpecificationTmp: Record 336 temporary;
        TrackingSpecification: Record 336 temporary;
        LotEntry2: Record 50002;
        ReservePurchLine: Codeunit 99000834;
        ItemTrackingForm: Page 6510;
        UseLineNo: Integer;
    begin
        //set filter
        // WITH PurchLine DO BEGIN
        PurchLine.SETRANGE("Document Type", "Document Type"::Order);
        PurchLine.SETRANGE("Document No.", DocNo);
        PurchLine.SETRANGE(Type, PurchLine.Type::Item);
        PurchLine.SETFILTER("Outstanding Quantity", '<>0');
        IF PurchLine.IsEmpty() THEN
            //ERROR('No Outstanding Lines found.');
            ERROR('No Lines found to receive.');
        //  END;

        //delete existing lines
        LotEntry.LOCKTABLE();
        LotEntry.SETRANGE("Document Type", DocType);
        LotEntry.SETRANGE("Document No.", DocNo);
        LotEntry.DELETEALL();

        //init
        TempPurchLine.DELETEALL();
        UseLineNo := 10000;


        //WITH PurchLine DO
        REPEAT
            IF IsLotTracking(PurchLine."No.") THEN BEGIN

                //get initial lots
                CLEAR(ReservePurchLine);
                CLEAR(ItemTrackingForm);
                ReservePurchLine.InitTrackingSpecification(PurchLine, TrackingSpecification);
                ItemTrackingForm.SetSource(TrackingSpecification, PurchLine."Expected Receipt Date");
                ItemTrackingForm.EShipOpenForm();
                TrackingSpecificationTmp.RESET();
                TrackingSpecificationTmp.DELETEALL();

                ItemTrackingForm.EShipGetRecords(TrackingSpecificationTmp);
                IF TrackingSpecificationTmp.FIND('-') THEN BEGIN
                    REPEAT
                        //insert these lots
                        IF (TrackingSpecificationTmp."Quantity (Base)" - TrackingSpecificationTmp."Quantity Handled (Base)") <> 0 THEN BEGIN
                            LotEntry.INIT();
                            LotEntry."Document Type" := LotEntry."Document Type"::"Purchase Order";
                            LotEntry."Document No." := PurchLine."Document No.";
                            LotEntry."Order Line No." := PurchLine."Line No.";
                            LotEntry."Line No." := UseLineNo;
                            LotEntry."Item No." := PurchLine."No.";
                            LotEntry.Description := PurchLine.Description;
                            LotEntry."Location Code" := PurchLine."Location Code";
                            LotEntry."Variant Code" := PurchLine."Variant Code";
                            LotEntry."Unit of Measure Code" := PurchLine."Unit of Measure Code";
                            LotEntry.Quantity := TrackingSpecificationTmp."Quantity (Base)" -
                                                   TrackingSpecificationTmp."Quantity Handled (Base)";
                            LotEntry."Lot No." := TrackingSpecificationTmp."Lot No.";
                            GetLotInfo(PurchLine."No.", PurchLine."Variant Code", TrackingSpecificationTmp."Lot No.", LotNoInfo);
                            LotEntry."External Lot No." := LotNoInfo."Mfg. Lot No.";
                            LotEntry."Creation Date" := LotNoInfo."Lot Creation Date";
                            LotEntry."Expiration Date" := TrackingSpecificationTmp."Expiration Date";
                            LotEntry.INSERT();
                            UseLineNo := UseLineNo + 10000;
                        END;
                    UNTIL TrackingSpecificationTmp.NEXT() = 0;

                    ItemTrackingForm.EShipCloseForm();
                END;  //end for if find lots

                //now get remaining quantity
                LotEntry2.SETRANGE("Document Type", LotEntry."Document Type"::"Purchase Order");
                LotEntry2.SETRANGE("Document No.", "Document No.");
                LotEntry2.SETRANGE("Order Line No.", "Line No.");
                LotEntry2.CALCSUMS(Quantity);

                IF (LotEntry2.Quantity < PurchLine."Outstanding Quantity") THEN BEGIN
                    LotEntry.INIT();
                    LotEntry."Document Type" := LotEntry."Document Type"::"Purchase Order";
                    LotEntry."Document No." := PurchLine."Document No.";
                    LotEntry."Order Line No." := PurchLine."Line No.";
                    LotEntry."Line No." := UseLineNo;
                    LotEntry."Item No." := PurchLine."No.";
                    LotEntry.Description := PurchLine.Description;
                    LotEntry."Location Code" := PurchLine."Location Code";
                    LotEntry."Variant Code" := PurchLine."Variant Code";
                    LotEntry."Unit of Measure Code" := PurchLine."Unit of Measure Code";
                    LotEntry.Quantity := PurchLine."Outstanding Quantity" - LotEntry2.Quantity;
                    LotEntry.INSERT();
                END;
            END;
        UNTIL PurchLine.NEXT() = 0;

        IF LotEntry.ISEMPTY() THEN
            ERROR('No Items are lot tracked on this order.');
    end;

    procedure GetTransferLines(DocNo: Code[20])
    var
        TransferLine: Record 5741;
        LotEntry: Record 50002;
        Item: Record 27;
        ItemTrackingCode: Record 6502;
        TempTransferLine: Record 5741 temporary;
        TrackingSpecificationTmp: Record 336 temporary;
        TrackingSpecification: Record 336 temporary;
        LotEntry2: Record 50002;
        ReserveTransferLine: Codeunit 99000836;
        ItemTrackingForm: Page 6510;
        UseLineNo: Integer;
    begin
        //set filter
        // WITH TransferLine DO BEGIN
        TransferLine.SETRANGE("Document No.", DocNo);
        TransferLine.SETRANGE("Derived From Line No.", 0);
        TransferLine.SETFILTER("Outstanding Quantity", '<>0');
        IF NOT TransferLine.FIND('-') THEN
            ERROR('No Outstanding Lines found.');
        //END;

        //delete existing lines
        LotEntry.LOCKTABLE();
        LotEntry.SETRANGE("Document Type", LotEntry."Document Type"::"Transfer Order");
        LotEntry.SETRANGE("Document No.", DocNo);
        LotEntry.DELETEALL();

        //init
        TempTransferLine.DELETEALL();
        UseLineNo := 10000;


        //WITH TransferLine DO
        REPEAT
            IF IsLotTracking("Item No.") THEN BEGIN

                //get initial lots
                CLEAR(ReserveTransferLine);
                CLEAR(ItemTrackingForm);
                ReserveTransferLine.InitTrackingSpecification(TransferLine, TrackingSpecification, TransferLine."Shipment Date", 0);
                ItemTrackingForm.SetSource(TrackingSpecification, TransferLine."Shipment Date");
                ItemTrackingForm.EShipOpenForm();
                TrackingSpecificationTmp.RESET();
                TrackingSpecificationTmp.DELETEALL();

                ItemTrackingForm.EShipGetRecords(TrackingSpecificationTmp);
                IF TrackingSpecificationTmp.FIND('-') THEN BEGIN
                    REPEAT
                        //insert these lots
                        IF (TrackingSpecificationTmp."Quantity (Base)" - TrackingSpecificationTmp."Quantity Handled (Base)") <> 0 THEN BEGIN
                            LotEntry.INIT();
                            LotEntry."Document Type" := LotEntry."Document Type"::"Transfer Order";
                            LotEntry."Document No." := "Document No.";
                            LotEntry."Order Line No." := "Line No.";
                            LotEntry."Line No." := UseLineNo;
                            LotEntry."Item No." := "Item No.";
                            LotEntry.Description := Description;
                            LotEntry."Location Code" := TransferLine."Transfer-from Code";
                            LotEntry."Variant Code" := "Variant Code";
                            LotEntry."Unit of Measure Code" := "Unit of Measure Code";
                            LotEntry.Quantity := TrackingSpecificationTmp."Quantity (Base)" -
                                                   TrackingSpecificationTmp."Quantity Handled (Base)";
                            LotEntry."Lot No." := TrackingSpecificationTmp."Lot No.";
                            GetLotInfo("Item No.", "Variant Code", TrackingSpecificationTmp."Lot No.", LotNoInfo);
                            LotEntry."External Lot No." := LotNoInfo."Mfg. Lot No.";
                            LotEntry."Creation Date" := LotNoInfo."Lot Creation Date";
                            LotEntry."Expiration Date" := TrackingSpecificationTmp."Expiration Date";
                            LotEntry.INSERT();
                            UseLineNo := UseLineNo + 10000;
                        END;
                    UNTIL TrackingSpecificationTmp.NEXT() = 0;

                    ItemTrackingForm.EShipCloseForm();
                END;  //end for if find lots

                //now get remaining quantity
                LotEntry2.SETRANGE("Document Type", LotEntry2."Document Type"::"Transfer Order");
                LotEntry2.SETRANGE("Document No.", "Document No.");
                LotEntry2.SETRANGE("Order Line No.", "Line No.");
                LotEntry2.CALCSUMS(Quantity);

                IF (LotEntry2.Quantity < TransferLine."Outstanding Quantity") THEN BEGIN
                    LotEntry.INIT();
                    LotEntry."Document Type" := LotEntry."Document Type"::"Transfer Order";
                    LotEntry."Document No." := "Document No.";
                    LotEntry."Order Line No." := "Line No.";
                    LotEntry."Line No." := UseLineNo;
                    LotEntry."Item No." := "Item No.";
                    LotEntry.Description := Description;
                    LotEntry."Location Code" := TransferLine."Transfer-from Code";
                    LotEntry."Variant Code" := "Variant Code";
                    LotEntry."Unit of Measure Code" := "Unit of Measure Code";
                    LotEntry.Quantity := TransferLine."Outstanding Quantity" - LotEntry2.Quantity;
                    LotEntry.INSERT();
                END;
            END;
        UNTIL TransferLine.NEXT() = 0;

        IF LotEntry.ISEMPTY THEN
            ERROR('No Items are lot tracked on this order.');
    end;

    procedure GetShipmentLines(DocNo: Code[20])
    var
        WhseShptLine: Record 7321;
        LotEntry: Record 50002;
        /*  Item: Record 27;
         ItemTrackingCode: Record 6502;
         TempWhseShptLine: Record 7321 temporary; */
        WhseItemTrkgLines: Record 6550;
        LotEntry2: Record 50002;
        UseLineNo: Integer;
        LineQtyToPick: Decimal;
    begin
        //set filter
        WhseShptLine.SETRANGE("No.", DocNo);
        WhseShptLine.SETFILTER("Qty. Outstanding", '<>0');
        IF NOT WhseShptLine.FIND('-') THEN
            ERROR('No Outstanding Lines found.');

        //delete existing lines
        LotEntry.LOCKTABLE();
        LotEntry.SETRANGE("Document Type", LotEntry."Document Type"::"Whse. Shipment");
        LotEntry.SETRANGE("Document No.", DocNo);
        LotEntry.DELETEALL();

        //init
        UseLineNo := 10000;


        // WITH WhseShptLine DO
        REPEAT
            IF IsLotTracking("Item No.") THEN BEGIN
                //get existing lines
                WhseItemTrkgLines.RESET();
                WhseItemTrkgLines.SETRANGE("Source ID", WhseShptLine."No.");
                WhseItemTrkgLines.SETRANGE("Source Type", DATABASE::"Warehouse Shipment Line");
                WhseItemTrkgLines.SETRANGE("Source Ref. No.", WhseShptLine."Line No.");
                WhseItemTrkgLines.SETRANGE("Location Code", WhseShptLine."Location Code");
                WhseItemTrkgLines.SETRANGE("Pick Qty. (Base)", 0);
                WhseItemTrkgLines.SETRANGE("Qty. Registered (Base)", 0);
                IF WhseItemTrkgLines.FIND('-') THEN
                    REPEAT
                        LotEntry.INIT();
                        LotEntry."Document Type" := LotEntry."Document Type"::"Whse. Shipment";
                        LotEntry."Document No." := WhseItemTrkgLines."Source ID";
                        LotEntry."Order Line No." := WhseItemTrkgLines."Source Ref. No.";
                        LotEntry."Line No." := UseLineNo;
                        LotEntry."Item No." := WhseItemTrkgLines."Item No.";
                        LotEntry.Description := WhseItemTrkgLines.Description;
                        LotEntry."Location Code" := WhseItemTrkgLines."Location Code";
                        LotEntry."Variant Code" := WhseItemTrkgLines."Variant Code";
                        LotEntry."Unit of Measure Code" := "Unit of Measure Code";
                        LotEntry.Quantity := WhseItemTrkgLines."Quantity (Base)";
                        LotEntry."Lot No." := WhseItemTrkgLines."Lot No.";
                        GetLotInfo(WhseShptLine."No.", WhseShptLine."Variant Code", WhseItemTrkgLines."Lot No.", LotNoInfo);
                        //LotEntry."External Lot No." := LotNoInfo."Mfg. Lot No.";
                        LotEntry."Creation Date" := LotNoInfo."Lot Creation Date";
                        LotEntry."Expiration Date" := WhseItemTrkgLines."Expiration Date";
                        LotEntry.INSERT();
                        UseLineNo := UseLineNo + 10000;
                    UNTIL WhseItemTrkgLines.NEXT() = 0;


                //now get remaining quantity
                LotEntry2.SETRANGE("Document Type", LotEntry2."Document Type"::"Whse. Shipment");
                LotEntry2.SETRANGE("Document No.", WhseShptLine."No.");
                LotEntry2.SETRANGE("Order Line No.", WhseShptLine."Line No.");
                LotEntry2.CALCSUMS(Quantity);

                WhseShptLine.CALCFIELDS("Pick Qty. (Base)");
                LineQtyToPick :=
                  ROUND((WhseShptLine."Qty. (Base)" - (WhseShptLine."Qty. Picked (Base)" + WhseShptLine."Pick Qty. (Base)")) /
                                 WhseShptLine."Qty. per Unit of Measure", 0.00001);


                IF (LotEntry2.Quantity < LineQtyToPick) THEN BEGIN
                    LotEntry.INIT();
                    LotEntry."Document Type" := LotEntry."Document Type"::"Whse. Shipment";
                    LotEntry."Document No." := WhseShptLine."No.";
                    LotEntry."Order Line No." := WhseShptLine."Line No.";
                    LotEntry."Line No." := UseLineNo;
                    LotEntry."Item No." := WhseShptLine."Item No.";
                    LotEntry.Description := WhseShptLine.Description;
                    LotEntry."Location Code" := WhseShptLine."Location Code";
                    LotEntry."Variant Code" := WhseShptLine."Variant Code";
                    LotEntry."Unit of Measure Code" := WhseShptLine."Unit of Measure Code";
                    LotEntry.Quantity := LineQtyToPick - LotEntry2.Quantity;
                    LotEntry.INSERT();
                END;

            END;
        UNTIL WhseShptLine.NEXT() = 0;

        IF LotEntry.ISEMPTY() THEN
            ERROR('No Line found for this shipment.');
    end;


    procedure IsLotTracking(ItemNo: Code[20]): Boolean
    var
        Item: Record 27;
        ItemTrackingCode: Record 6502;
    begin
        IF NOT Item.GET(ItemNo) THEN
            EXIT(FALSE);

        IF Item."Item Tracking Code" = '' THEN
            EXIT(FALSE);

        ItemTrackingCode.GET(Item."Item Tracking Code");
        EXIT(ItemTrackingCode."Lot Sales Outbound Tracking");
    end;

    procedure SplitLine(var LotEntry: Record 50002)
    var
        NewLotEntry: Record 50002;
        LineSpacing: Integer;
        QtyAssigned: Decimal;
        QtyOutstanding: Decimal;
    begin
        LotEntry.TESTFIELD("Lot No.");

        NewLotEntry := LotEntry;
        NewLotEntry.SETRANGE("Document No.", LotEntry."Document No.");
        NewLotEntry.SETRANGE("Order Line No.", LotEntry."Order Line No.");
        IF NewLotEntry.FIND('>') THEN
            LineSpacing :=
              (NewLotEntry."Line No." - LotEntry."Line No.") DIV 2
        ELSE
            LineSpacing := 10000;

        NewLotEntry.RESET();
        NewLotEntry.INIT();
        NewLotEntry := LotEntry;
        NewLotEntry."Lot No." := '';
        NewLotEntry."External Lot No." := '';
        NewLotEntry."Creation Date" := 0D;
        NewLotEntry."Expiration Date" := 0D;
        NewLotEntry."Line No." := NewLotEntry."Line No." + LineSpacing;

        //base qty on outstanding - what is currently there
        QtyAssigned := CalcQtyAssigned();
        QtyOutstanding := CalcQtyOutstanding();


        NewLotEntry.Quantity := QtyOutstanding - QtyAssigned;
        NewLotEntry.INSERT();
    end;

    procedure CalcQtyOutstanding(): Decimal
    var
        SalesLine: Record 37;
        TransferLine: Record 5741;
        WhseShptLine: Record 7321;
        PurchLine: Record 39;
    begin

        CASE "Document Type" OF
            "Document Type"::"Transfer Order":
                BEGIN
                    TransferLine.GET("Document No.", "Order Line No.");
                    EXIT(TransferLine."Outstanding Quantity");
                END;
            "Document Type"::"Purchase Order":
                BEGIN
                    PurchLine.GET(PurchLine."Document Type"::Order, "Document No.", "Order Line No.");
                    EXIT(PurchLine."Outstanding Quantity");
                END;

            "Document Type"::"Whse. Shipment":
                BEGIN
                    WhseShptLine.GET("Document No.", "Order Line No.");
                    WhseShptLine.CALCFIELDS("Pick Qty. (Base)");
                    EXIT(
                      ROUND((WhseShptLine."Qty. (Base)" - (WhseShptLine."Qty. Picked (Base)" + WhseShptLine."Pick Qty. (Base)")) /
                                      WhseShptLine."Qty. per Unit of Measure", 0.00001));
                END;
            ELSE BEGIN
                SalesLine.GET("Document Type", "Document No.", "Order Line No.");
                EXIT(SalesLine."Outstanding Quantity");
            END;
        END;
    end;

    procedure CalcQtyToShip(): Decimal
    var
        SalesLine: Record 37;
        TransferLine: Record 5741;
        WhseShptLine: Record 7321;
        PurchLine: Record 39;
    begin

        CASE "Document Type" OF
            "Document Type"::"Transfer Order":
                BEGIN
                    TransferLine.GET("Document No.", "Order Line No.");
                    EXIT(TransferLine."Outstanding Quantity");
                END;
            "Document Type"::"Purchase Order":
                BEGIN
                    PurchLine.GET(PurchLine."Document Type"::Order, "Document No.", "Order Line No.");
                    EXIT(PurchLine."Outstanding Quantity");
                END;

            "Document Type"::"Whse. Shipment":
                BEGIN
                    WhseShptLine.GET("Document No.", "Order Line No.");
                    WhseShptLine.CALCFIELDS("Pick Qty. (Base)");
                    EXIT(
                      ROUND((WhseShptLine."Qty. (Base)" - (WhseShptLine."Qty. Picked (Base)" + WhseShptLine."Pick Qty. (Base)")) /
                                      WhseShptLine."Qty. per Unit of Measure", 0.00001));
                END;
            ELSE BEGIN
                SalesLine.GET("Document Type", "Document No.", "Order Line No.");
                EXIT(SalesLine."Qty. to Ship");
            END;
        END;
    end;

    procedure CalcQtyAssigned(): Decimal
    var
        LotEntry: Record 50002;
    begin

        LotEntry.SETRANGE("Document Type", "Document Type");
        LotEntry.SETRANGE("Document No.", "Document No.");
        LotEntry.SETRANGE("Order Line No.", "Order Line No.");
        LotEntry.CALCSUMS(Quantity);

        EXIT(LotEntry.Quantity);
    end;

    procedure AssignLots(DocType: Integer; DocNo: Code[20])
    var
        LotEntry: Record 50002;
        TempSalesLine: Record 37 temporary;
        SalesLine: Record 37;
        TrackingSpecificationTmp: Record 336 temporary;
        TrackingSpecification: Record 336 temporary;
        ReserveSalesLine: Codeunit 99000832;
        ItemTrackingForm: Page 6510;
        LotNoToSet: Code[20];
        WarrantyDateToSet: Date;
        ExpirationDateToSet: Date;
        LastEntryNo: Integer;
        LineQty: Decimal;
        LinesInserted: Boolean;
    begin
        LotEntry.SETRANGE("Document Type", DocType);
        LotEntry.SETRANGE("Document No.", DocNo);
        IF NOT LotEntry.FIND('-') THEN
            ERROR('No Lines Found');

        //read lines into temp table and remove
        TempSalesLine.DELETEALL();

        REPEAT
            IF NOT TempSalesLine.GET(LotEntry."Document Type", LotEntry."Document No.", LotEntry."Order Line No.") THEN BEGIN
                TempSalesLine.INIT();
                SalesLine.GET(LotEntry."Document Type", LotEntry."Document No.", LotEntry."Order Line No.");
                TempSalesLine.TRANSFERFIELDS(SalesLine);
                TempSalesLine.INSERT();
            END;
        UNTIL LotEntry.NEXT() = 0;

        //now remove existing lot tracking lines
        TempSalesLine.FIND('-');
        REPEAT
            ClearTrackingLines(DATABASE::"Sales Line",
                TempSalesLine."Document Type".AsInteger(), TempSalesLine."Document No.", TempSalesLine."Line No.");
        UNTIL TempSalesLine.NEXT() = 0;

        //assign lot numbers
        LotEntry.FIND('-');
        REPEAT
            //clear vars
            CLEAR(ReserveSalesLine);
            CLEAR(ItemTrackingForm);
            TrackingSpecificationTmp.RESET();
            TrackingSpecificationTmp.DELETEALL();

            //get the qty to process
            SalesLine.GET(LotEntry."Document Type", LotEntry."Document No.", LotEntry."Order Line No.");
            ReserveSalesLine.InitTrackingSpecification(SalesLine, TrackingSpecification);
            ItemTrackingForm.SetSource(TrackingSpecification, SalesLine."Shipment Date");
            LotNoToSet := LotEntry."Lot No.";
            ExpirationDateToSet := LotEntry."Expiration Date";
            LineQty := LotEntry.Quantity;

            ItemTrackingForm.EShipOpenForm();
            ItemTrackingForm.EShipGetRecords(TrackingSpecificationTmp);
            IF TrackingSpecificationTmp.FIND('+') THEN
                LastEntryNo := TrackingSpecificationTmp."Entry No."
            ELSE
                LastEntryNo := 0;

            IF LastEntryNo <> 0 THEN BEGIN
                TrackingSpecificationTmp.SETRANGE("Serial No.", '');
                TrackingSpecificationTmp.SETRANGE("Lot No.", LotNoToSet);
                TrackingSpecificationTmp.SETRANGE("Warranty Date", WarrantyDateToSet);
                TrackingSpecificationTmp.SETRANGE("Expiration Date", ExpirationDateToSet);
                IF TrackingSpecificationTmp.FIND('-') THEN BEGIN
                    TrackingSpecificationTmp.VALIDATE("Quantity (Base)", TrackingSpecificationTmp."Quantity (Base)" + LineQty);
                    IF TrackingSpecificationTmp."Qty. per Unit of Measure" IN [1, 0] THEN
                        TrackingSpecificationTmp.VALIDATE("Qty. to Handle", TrackingSpecificationTmp."Qty. to Handle" + LineQty)
                    ELSE
                        TrackingSpecificationTmp.VALIDATE("Qty. to Handle",
                              ROUND(
                                TrackingSpecificationTmp."Qty. to Handle" +
                                    LineQty / TrackingSpecificationTmp."Qty. per Unit of Measure", 0.00001));
                    ItemTrackingForm.EShipModifyRecord(TrackingSpecificationTmp);
                END
                ELSE BEGIN
                    TrackingSpecificationTmp := TrackingSpecification;
                    TrackingSpecificationTmp."Quantity (Base)" := 0;
                    TrackingSpecificationTmp."Qty. to Handle (Base)" := 0;
                    TrackingSpecificationTmp."Qty. to Invoice (Base)" := 0;
                    TrackingSpecificationTmp."Quantity Handled (Base)" := 0;
                    TrackingSpecificationTmp."Quantity Invoiced (Base)" := 0;
                    TrackingSpecificationTmp."Qty. to Handle" := 0;
                    TrackingSpecificationTmp."Qty. to Invoice" := 0;
                    LastEntryNo := LastEntryNo + 1;
                    TrackingSpecificationTmp."Entry No." := LastEntryNo;
                    TrackingSpecificationTmp.VALIDATE("Quantity (Base)", LineQty);
                    IF TrackingSpecificationTmp."Qty. per Unit of Measure" IN [1, 0] THEN
                        TrackingSpecificationTmp.VALIDATE("Qty. to Handle", LineQty)
                    ELSE
                        TrackingSpecificationTmp.VALIDATE("Qty. to Handle",
                              ROUND(LineQty / TrackingSpecificationTmp."Qty. per Unit of Measure", 0.00001));
                    IF LotNoToSet <> '' THEN
                        TrackingSpecificationTmp.VALIDATE("Lot No.", LotNoToSet);
                    IF WarrantyDateToSet <> 0D THEN
                        TrackingSpecificationTmp.VALIDATE("Warranty Date", WarrantyDateToSet);
                    IF ExpirationDateToSet <> 0D THEN
                        TrackingSpecificationTmp.VALIDATE("Expiration Date", ExpirationDateToSet);
                    //XMESSAGE('%1',TrackingSpecificationTmp);
                    ItemTrackingForm.EShipInsertRecord(TrackingSpecificationTmp);
                END;
            END
            ELSE BEGIN
                TrackingSpecificationTmp := TrackingSpecification;
                LastEntryNo := LastEntryNo + 1;
                TrackingSpecificationTmp."Entry No." := LastEntryNo;
                TrackingSpecificationTmp.VALIDATE("Quantity (Base)", LineQty);
                IF TrackingSpecificationTmp."Qty. per Unit of Measure" IN [1, 0] THEN
                    TrackingSpecificationTmp.VALIDATE("Qty. to Handle", LineQty)
                ELSE
                    TrackingSpecificationTmp.VALIDATE("Qty. to Handle",
                            ROUND(LineQty / TrackingSpecificationTmp."Qty. per Unit of Measure", 0.00001));
                IF LotNoToSet <> '' THEN
                    TrackingSpecificationTmp.VALIDATE("Lot No.", LotNoToSet);
                IF WarrantyDateToSet <> 0D THEN
                    TrackingSpecificationTmp.VALIDATE("Warranty Date", WarrantyDateToSet);
                IF ExpirationDateToSet <> 0D THEN
                    TrackingSpecificationTmp.VALIDATE("Expiration Date", ExpirationDateToSet);

                ItemTrackingForm.EShipInsertRecord(TrackingSpecificationTmp);
            END;

            LinesInserted := TRUE;
            ItemTrackingForm.EShipCloseForm();
        UNTIL LotEntry.NEXT() = 0;


        IF LinesInserted THEN
            COMMIT();
    end;

    procedure AssignPurchaseLots(DocType: Integer; DocNo: Code[20])
    var
        LotEntry: Record 50002;
        TempPurchLine: Record 39 temporary;
        PurchLine: Record 39;
        TrackingSpecificationTmp: Record 336 temporary;
        TrackingSpecification: Record 336 temporary;
        ReservePurchLine: Codeunit 99000834;
        ItemTrackingForm: Page "Item Tracking Lines";
        LotNoToSet: Code[20];
        WarrantyDateToSet: Date;
        ExpirationDateToSet: Date;
        LastEntryNo: Integer;
        LineQty: Decimal;
        LinesInserted: Boolean;
    begin
        LotEntry.SETRANGE("Document Type", DocType);
        LotEntry.SETRANGE("Document No.", DocNo);
        IF NOT LotEntry.FIND('-') THEN
            ERROR('No Lines Found');

        //read lines into temp table and remove
        TempPurchLine.DELETEALL();

        REPEAT
            IF NOT TempPurchLine.GET(LotEntry."Document Type", LotEntry."Document No.", LotEntry."Order Line No.") THEN BEGIN
                TempPurchLine.INIT();
                PurchLine.GET(LotEntry."Document Type", LotEntry."Document No.", LotEntry."Order Line No.");
                TempPurchLine.TRANSFERFIELDS(PurchLine);
                TempPurchLine.INSERT();
            END;
        UNTIL LotEntry.NEXT() = 0;

        //now remove existing lot tracking lines
        TempPurchLine.FIND('-');
        REPEAT
            ClearTrackingLines(DATABASE::"Purchase Line",
                TempPurchLine."Document Type".AsInteger(), TempPurchLine."Document No.", TempPurchLine."Line No.");
        UNTIL TempPurchLine.NEXT() = 0;

        //assign lot numbers
        LotEntry.FIND('-');
        REPEAT
            //clear vars
            CLEAR(ReservePurchLine);
            CLEAR(ItemTrackingForm);
            TrackingSpecificationTmp.RESET();
            TrackingSpecificationTmp.DELETEALL();

            //get the qty to process
            PurchLine.GET(LotEntry."Document Type", LotEntry."Document No.", LotEntry."Order Line No.");
            ReservePurchLine.InitTrackingSpecification(PurchLine, TrackingSpecification);
            ItemTrackingForm.SetSource(TrackingSpecification, PurchLine."Expected Receipt Date");
            LotNoToSet := LotEntry."Lot No.";
            ExpirationDateToSet := LotEntry."Expiration Date";
            LineQty := LotEntry.Quantity;

            ItemTrackingForm.EShipOpenForm();
            ItemTrackingForm.EShipGetRecords(TrackingSpecificationTmp);
            IF TrackingSpecificationTmp.FIND('+') THEN
                LastEntryNo := TrackingSpecificationTmp."Entry No."
            ELSE
                LastEntryNo := 0;

            IF LastEntryNo <> 0 THEN BEGIN
                TrackingSpecificationTmp.SETRANGE("Serial No.", '');
                TrackingSpecificationTmp.SETRANGE("Lot No.", LotNoToSet);
                TrackingSpecificationTmp.SETRANGE("Warranty Date", WarrantyDateToSet);
                TrackingSpecificationTmp.SETRANGE("Expiration Date", ExpirationDateToSet);
                IF TrackingSpecificationTmp.FIND('-') THEN BEGIN
                    TrackingSpecificationTmp.VALIDATE("Quantity (Base)", TrackingSpecificationTmp."Quantity (Base)" + LineQty);
                    IF TrackingSpecificationTmp."Qty. per Unit of Measure" IN [1, 0] THEN
                        TrackingSpecificationTmp.VALIDATE("Qty. to Handle", TrackingSpecificationTmp."Qty. to Handle" + LineQty)
                    ELSE
                        TrackingSpecificationTmp.VALIDATE("Qty. to Handle",
                              ROUND(
                                TrackingSpecificationTmp."Qty. to Handle" +
                                    LineQty / TrackingSpecificationTmp."Qty. per Unit of Measure", 0.00001));
                    ItemTrackingForm.EShipModifyRecord(TrackingSpecificationTmp);
                END
                ELSE BEGIN
                    TrackingSpecificationTmp := TrackingSpecification;
                    TrackingSpecificationTmp."Quantity (Base)" := 0;
                    TrackingSpecificationTmp."Qty. to Handle (Base)" := 0;
                    TrackingSpecificationTmp."Qty. to Invoice (Base)" := 0;
                    TrackingSpecificationTmp."Quantity Handled (Base)" := 0;
                    TrackingSpecificationTmp."Quantity Invoiced (Base)" := 0;
                    TrackingSpecificationTmp."Qty. to Handle" := 0;
                    TrackingSpecificationTmp."Qty. to Invoice" := 0;
                    LastEntryNo := LastEntryNo + 1;
                    TrackingSpecificationTmp."Entry No." := LastEntryNo;
                    TrackingSpecificationTmp.VALIDATE("Quantity (Base)", LineQty);
                    IF TrackingSpecificationTmp."Qty. per Unit of Measure" IN [1, 0] THEN
                        TrackingSpecificationTmp.VALIDATE("Qty. to Handle", LineQty)
                    ELSE
                        TrackingSpecificationTmp.VALIDATE("Qty. to Handle",
                              ROUND(LineQty / TrackingSpecificationTmp."Qty. per Unit of Measure", 0.00001));
                    IF LotNoToSet <> '' THEN
                        TrackingSpecificationTmp.VALIDATE("Lot No.", LotNoToSet);
                    IF WarrantyDateToSet <> 0D THEN
                        TrackingSpecificationTmp.VALIDATE("Warranty Date", WarrantyDateToSet);
                    IF ExpirationDateToSet <> 0D THEN
                        TrackingSpecificationTmp.VALIDATE("Expiration Date", ExpirationDateToSet);
                    //XMESSAGE('%1',TrackingSpecificationTmp);
                    ItemTrackingForm.EShipInsertRecord(TrackingSpecificationTmp);
                END;
            END
            ELSE BEGIN
                TrackingSpecificationTmp := TrackingSpecification;
                LastEntryNo := LastEntryNo + 1;
                TrackingSpecificationTmp."Entry No." := LastEntryNo;
                TrackingSpecificationTmp.VALIDATE("Quantity (Base)", LineQty);
                IF TrackingSpecificationTmp."Qty. per Unit of Measure" IN [1, 0] THEN
                    TrackingSpecificationTmp.VALIDATE("Qty. to Handle", LineQty)
                ELSE
                    TrackingSpecificationTmp.VALIDATE("Qty. to Handle",
                            ROUND(LineQty / TrackingSpecificationTmp."Qty. per Unit of Measure", 0.00001));
                IF LotNoToSet <> '' THEN
                    TrackingSpecificationTmp.VALIDATE("Lot No.", LotNoToSet);
                IF WarrantyDateToSet <> 0D THEN
                    TrackingSpecificationTmp.VALIDATE("Warranty Date", WarrantyDateToSet);
                IF ExpirationDateToSet <> 0D THEN
                    TrackingSpecificationTmp.VALIDATE("Expiration Date", ExpirationDateToSet);

                ItemTrackingForm.EShipInsertRecord(TrackingSpecificationTmp);
            END;

            LinesInserted := TRUE;
            ItemTrackingForm.EShipCloseForm();
        UNTIL LotEntry.NEXT() = 0;


        IF LinesInserted THEN
            COMMIT();
    end;

    procedure AssignTransferLots(DocNo: Code[20])
    var
        LotEntry: Record 50002;
        TempTransferLine: Record 5741 temporary;
        TransferLine: Record 5741;
        TrackingSpecificationTmp: Record 336 temporary;
        TrackingSpecification: Record 336 temporary;
        ReserveTransferLine: Codeunit 99000836;
        ItemTrackingForm: Page 6510;
        LotNoToSet: Code[20];
        WarrantyDateToSet: Date;
        ExpirationDateToSet: Date;
        LastEntryNo: Integer;
        LineQty: Decimal;
        LinesInserted: Boolean;
    begin
        LotEntry.SETRANGE("Document Type", LotEntry."Document Type"::"Transfer Order");
        LotEntry.SETRANGE("Document No.", DocNo);
        IF NOT LotEntry.FIND('-') THEN
            ERROR('No Lines Found');

        //read lines into temp table and remove
        TempTransferLine.DELETEALL();

        REPEAT
            IF NOT TempTransferLine.GET(LotEntry."Document No.", LotEntry."Order Line No.") THEN BEGIN
                TempTransferLine.INIT();
                TransferLine.GET(LotEntry."Document No.", LotEntry."Order Line No.");
                TempTransferLine.TRANSFERFIELDS(TransferLine);
                TempTransferLine.INSERT();
            END;
        UNTIL LotEntry.NEXT() = 0;

        //now remove existing lot tracking lines
        TempTransferLine.FIND('-');
        REPEAT
            ClearTrackingLines(DATABASE::"Transfer Line", 0, TempTransferLine."Document No.", TempTransferLine."Line No.");
        UNTIL TempTransferLine.NEXT() = 0;

        //assign lot numbers
        LotEntry.FIND('-');
        REPEAT
            //clear vars
            CLEAR(ReserveTransferLine);
            CLEAR(ItemTrackingForm);
            TrackingSpecificationTmp.RESET();
            TrackingSpecificationTmp.DELETEALL();

            //get the qty to process
            TransferLine.GET(LotEntry."Document No.", LotEntry."Order Line No.");
            ReserveTransferLine.InitTrackingSpecification(TransferLine, TrackingSpecification, TransferLine."Shipment Date", 0);
            ItemTrackingForm.SetSource(TrackingSpecification, TransferLine."Shipment Date");
            LotNoToSet := LotEntry."Lot No.";
            ExpirationDateToSet := LotEntry."Expiration Date";
            LineQty := LotEntry.Quantity;

            ItemTrackingForm.EShipOpenForm();
            ItemTrackingForm.EShipGetRecords(TrackingSpecificationTmp);
            IF TrackingSpecificationTmp.FIND('+') THEN
                LastEntryNo := TrackingSpecificationTmp."Entry No."
            ELSE
                LastEntryNo := 0;

            IF LastEntryNo <> 0 THEN BEGIN
                TrackingSpecificationTmp.SETRANGE("Serial No.", '');
                TrackingSpecificationTmp.SETRANGE("Lot No.", LotNoToSet);
                TrackingSpecificationTmp.SETRANGE("Warranty Date", WarrantyDateToSet);
                TrackingSpecificationTmp.SETRANGE("Expiration Date", ExpirationDateToSet);
                IF TrackingSpecificationTmp.FIND('-') THEN BEGIN
                    TrackingSpecificationTmp.VALIDATE("Quantity (Base)", TrackingSpecificationTmp."Quantity (Base)" + LineQty);
                    IF TrackingSpecificationTmp."Qty. per Unit of Measure" IN [1, 0] THEN
                        TrackingSpecificationTmp.VALIDATE("Qty. to Handle", TrackingSpecificationTmp."Qty. to Handle" + LineQty)
                    ELSE
                        TrackingSpecificationTmp.VALIDATE("Qty. to Handle",
                              ROUND(
                                TrackingSpecificationTmp."Qty. to Handle" +
                                    LineQty / TrackingSpecificationTmp."Qty. per Unit of Measure", 0.00001));
                    ItemTrackingForm.EShipModifyRecord(TrackingSpecificationTmp);
                END
                ELSE BEGIN
                    TrackingSpecificationTmp := TrackingSpecification;
                    TrackingSpecificationTmp."Quantity (Base)" := 0;
                    TrackingSpecificationTmp."Qty. to Handle (Base)" := 0;
                    TrackingSpecificationTmp."Qty. to Invoice (Base)" := 0;
                    TrackingSpecificationTmp."Quantity Handled (Base)" := 0;
                    TrackingSpecificationTmp."Quantity Invoiced (Base)" := 0;
                    TrackingSpecificationTmp."Qty. to Handle" := 0;
                    TrackingSpecificationTmp."Qty. to Invoice" := 0;
                    LastEntryNo := LastEntryNo + 1;
                    TrackingSpecificationTmp."Entry No." := LastEntryNo;
                    TrackingSpecificationTmp.VALIDATE("Quantity (Base)", LineQty);
                    IF TrackingSpecificationTmp."Qty. per Unit of Measure" IN [1, 0] THEN
                        TrackingSpecificationTmp.VALIDATE("Qty. to Handle", LineQty)
                    ELSE
                        TrackingSpecificationTmp.VALIDATE("Qty. to Handle",
                              ROUND(LineQty / TrackingSpecificationTmp."Qty. per Unit of Measure", 0.00001));
                    IF LotNoToSet <> '' THEN
                        TrackingSpecificationTmp.VALIDATE("Lot No.", LotNoToSet);
                    IF WarrantyDateToSet <> 0D THEN
                        TrackingSpecificationTmp.VALIDATE("Warranty Date", WarrantyDateToSet);
                    IF ExpirationDateToSet <> 0D THEN
                        TrackingSpecificationTmp.VALIDATE("Expiration Date", ExpirationDateToSet);
                    //XMESSAGE('%1',TrackingSpecificationTmp);
                    ItemTrackingForm.EShipInsertRecord(TrackingSpecificationTmp);
                END;
            END
            ELSE BEGIN
                TrackingSpecificationTmp := TrackingSpecification;
                LastEntryNo := LastEntryNo + 1;
                TrackingSpecificationTmp."Entry No." := LastEntryNo;
                TrackingSpecificationTmp.VALIDATE("Quantity (Base)", LineQty);
                IF TrackingSpecificationTmp."Qty. per Unit of Measure" IN [1, 0] THEN
                    TrackingSpecificationTmp.VALIDATE("Qty. to Handle", LineQty)
                ELSE
                    TrackingSpecificationTmp.VALIDATE("Qty. to Handle",
                            ROUND(LineQty / TrackingSpecificationTmp."Qty. per Unit of Measure", 0.00001));
                IF LotNoToSet <> '' THEN
                    TrackingSpecificationTmp.VALIDATE("Lot No.", LotNoToSet);
                IF WarrantyDateToSet <> 0D THEN
                    TrackingSpecificationTmp.VALIDATE("Warranty Date", WarrantyDateToSet);
                IF ExpirationDateToSet <> 0D THEN
                    TrackingSpecificationTmp.VALIDATE("Expiration Date", ExpirationDateToSet);

                ItemTrackingForm.EShipInsertRecord(TrackingSpecificationTmp);
            END;

            LinesInserted := TRUE;
            ItemTrackingForm.EShipCloseForm();
        UNTIL LotEntry.NEXT() = 0;


        IF LinesInserted THEN
            COMMIT();
    end;

    procedure AssignShipmentLots(DocNo: Code[20])
    var
        LotEntry: Record 50002;
        TempWhseShptLine: Record 7321 temporary;
        WhseShptLine: Record 7321;
        WhseItemTrkgLines: Record 6550;
        NVM: Codeunit "NewVision Management_New";
        LotNoToSet: Code[20];
        WarrantyDateToSet: Date;
        ExpirationDateToSet: Date;
        LineQty: Decimal;
        LinesInserted: Boolean;
        UseEntryNo: Integer;
    begin
        LotEntry.SETRANGE("Document Type", LotEntry."Document Type"::"Whse. Shipment");
        LotEntry.SETRANGE("Document No.", DocNo);
        IF NOT LotEntry.FIND('-') THEN
            ERROR('No Lines Found');

        //read lines into temp table and remove
        TempWhseShptLine.DELETEALL();

        REPEAT
            IF NOT TempWhseShptLine.GET(LotEntry."Document No.", LotEntry."Order Line No.") THEN BEGIN
                TempWhseShptLine.INIT();
                WhseShptLine.GET(LotEntry."Document No.", LotEntry."Order Line No.");
                TempWhseShptLine.TRANSFERFIELDS(WhseShptLine);
                TempWhseShptLine.INSERT();
            END;
        UNTIL LotEntry.NEXT() = 0;

        //now remove existing lot tracking lines
        TempWhseShptLine.FIND('-');
        REPEAT
            NVM.ClearWhseItemTrackingLines(DATABASE::"Warehouse Shipment Line", TempWhseShptLine."No.", TempWhseShptLine."Line No.");
        UNTIL TempWhseShptLine.NEXT() = 0;

        //assign lot numbers
        LotEntry.FIND('-');
        REPEAT
            //clear vars
            LotNoToSet := LotEntry."Lot No.";
            ExpirationDateToSet := LotEntry."Expiration Date";
            LineQty := LotEntry.Quantity;

            //search for Lot in whse. item tracking
            WhseItemTrkgLines.SETCURRENTKEY(
                           "Source ID", "Source Type", "Source Subtype", "Source Batch Name",
                                  "Source Prod. Order Line", "Source Ref. No.", "Location Code");

            WhseItemTrkgLines.SETRANGE("Source ID", LotEntry."Document No.");
            WhseItemTrkgLines.SETRANGE("Source Type", DATABASE::"Warehouse Shipment Line");
            WhseItemTrkgLines.SETRANGE("Source Ref. No.", LotEntry."Order Line No.");
            WhseItemTrkgLines.SETRANGE("Location Code", LotEntry."Location Code");
            WhseItemTrkgLines.SETRANGE("Lot No.", LotNoToSet);
            //if already present, lot has been handled
            //increment qty by qty. to pick
            IF WhseItemTrkgLines.FIND('-') THEN BEGIN
                WhseItemTrkgLines.VALIDATE("Quantity (Base)", WhseItemTrkgLines."Quantity (Base)" + LineQty);
                WhseItemTrkgLines.MODIFY();
            END
            ELSE BEGIN
                WhseItemTrkgLines.RESET();
                WhseItemTrkgLines.LOCKTABLE();
                IF WhseItemTrkgLines.FIND('+') THEN
                    UseEntryNo := WhseItemTrkgLines."Entry No." + 1
                ELSE
                    UseEntryNo := 1;

                WhseItemTrkgLines.INIT();
                WhseItemTrkgLines."Entry No." := UseEntryNo;
                WhseItemTrkgLines."Item No." := LotEntry."Item No.";
                WhseItemTrkgLines."Location Code" := LotEntry."Location Code";
                WhseItemTrkgLines.VALIDATE("Quantity (Base)", LineQty);
                WhseItemTrkgLines.Description := LotEntry.Description;
                WhseItemTrkgLines."Source Type" := DATABASE::"Warehouse Shipment Line";
                WhseItemTrkgLines."Source ID" := LotEntry."Document No.";
                WhseItemTrkgLines."Source Ref. No." := LotEntry."Order Line No.";
                WhseItemTrkgLines."Qty. per Unit of Measure" := 1;
                WhseItemTrkgLines."Warranty Date" := WarrantyDateToSet;
                WhseItemTrkgLines."Expiration Date" := ExpirationDateToSet;
                WhseItemTrkgLines."Lot No." := LotEntry."Lot No.";
                IF LineQty <> 0 THEN
                    WhseItemTrkgLines.INSERT();
            END;

            LinesInserted := TRUE;
        UNTIL LotEntry.NEXT() = 0;


        IF LinesInserted THEN
            COMMIT();
    end;

    procedure ClearTrackingLines(SourceType: Integer; SourceSubType: Integer; SourceNo: Code[20]; SourceLineNo: Integer)
    var
        SalesLine: Record "Sales Line";
        TrackingSpecificationTmp: Record "Tracking Specification" temporary;
        TrackingSpecification: Record "Tracking Specification" temporary;
        TransferLine: Record "Transfer Line";
        PurchLine: Record "Purchase Line";
        ReserveSalesLine: Codeunit "Sales Line-Reserve";
        ReservePurchLine: Codeunit "Purch. Line-Reserve";
        ReserveTransferLine: Codeunit "Transfer Line-Reserve";
        ItemTrackingForm: Page 6510;
        ModifyRecord: Boolean;
    begin
        CLEAR(ReserveSalesLine);
        CLEAR(ReserveTransferLine);
        CLEAR(ItemTrackingForm);
        CLEAR(ReservePurchLine);
        CLEAR(PurchLine);

        //init tracking specification
        CASE SourceType OF
            DATABASE::"Sales Line":
                BEGIN
                    SalesLine.GET(SourceSubType, SourceNo, SourceLineNo);
                    ReserveSalesLine.InitTrackingSpecification(SalesLine, TrackingSpecification);
                    ItemTrackingForm.SetSource(TrackingSpecification, SalesLine."Shipment Date");
                END;

            DATABASE::"Purchase Line":
                BEGIN
                    PurchLine.GET(SourceSubType, SourceNo, SourceLineNo);
                    ReservePurchLine.InitTrackingSpecification(PurchLine, TrackingSpecification);
                    ItemTrackingForm.SetSource(TrackingSpecification, PurchLine."Expected Receipt Date");
                END;

            DATABASE::"Transfer Line":
                BEGIN
                    TransferLine.GET(SourceNo, SourceLineNo);
                    ReserveTransferLine.InitTrackingSpecification(TransferLine, TrackingSpecification, TransferLine."Shipment Date", 0);
                    ItemTrackingForm.SetSource(TrackingSpecification, TransferLine."Shipment Date");
                END;
            ELSE
                ERROR('Source Type %1 not supported.', SourceType);
        END;


        //clear out existing lots in item tracking
        ItemTrackingForm.EShipOpenForm();
        TrackingSpecificationTmp.RESET();
        TrackingSpecificationTmp.DELETEALL();

        ItemTrackingForm.EShipGetRecords(TrackingSpecificationTmp);
        IF TrackingSpecificationTmp.FIND('-') THEN BEGIN
            REPEAT
                IF TrackingSpecificationTmp."Quantity Handled (Base)" = 0 THEN
                    ItemTrackingForm.EShipDeleteRecord(TrackingSpecificationTmp)
                ELSE BEGIN
                    ModifyRecord := FALSE;
                    IF TrackingSpecificationTmp."Quantity (Base)" > TrackingSpecificationTmp."Quantity Handled (Base)" THEN BEGIN
                        TrackingSpecificationTmp.VALIDATE("Quantity (Base)", TrackingSpecificationTmp."Quantity Handled (Base)");
                        ModifyRecord := TRUE;
                    END;

                    IF TrackingSpecificationTmp."Qty. to Handle" <> 0 THEN BEGIN
                        TrackingSpecificationTmp.VALIDATE("Qty. to Handle", 0);
                        ModifyRecord := TRUE;
                    END;

                    IF ModifyRecord THEN
                        ItemTrackingForm.EShipModifyRecord(TrackingSpecificationTmp);
                END;
            UNTIL TrackingSpecificationTmp.NEXT() = 0;
            ItemTrackingForm.EShipCloseForm();
        END;
        //end if TrackingSpecificationTmp.FIND then begin
    end;

    procedure "<<internal>>"()
    begin
    end;

    procedure GetLotInfo(ItemNo: Code[20]; VariantCode: Code[10]; LotNo: Code[20]; var LotNoInfo_: Record 6505)
    begin
        IF NOT LotNoInfo_.GET(ItemNo, VariantCode, LotNo) THEN
            CLEAR(LotNoInfo_);
    end;

}
