tableextension 50037 "Sales Line Ext" extends "Sales Line"
{
    // version NAVW18.00,NAVNA8.00,SE0.60,NV4.35,NIF1.104,NMX1.000,NIF.N15.C9IN.001,AP6.01.001,AKK1606.01, SM 001,CIS.IoT

    fields
    {
        modify("No.")
        {
            Description = 'AKK1606';
        }
        modify("Drop Shipment")
        {
            trigger OnAfterValidate()
            var
                SalesSetup: Record "Sales & Receivables Setup";
            begin
                // Shipping
                // Qty. to Ship has been set to zero for not accidentially shipping the line when posting.
                // This is not a Shipping Specific problem but and general "Feature" in Navision
                IF "Drop Shipment" THEN BEGIN
                    SalesSetup.GET();
                    IF SalesSetup."LAX Blank Drop Ship Qty.toShip" THEN
                        VALIDATE("Qty. to Ship", 0);
                END;
                // Shipping
            end;
        }
        modify("Blanket Order Line No.")
        {
            trigger OnAfterValidate()
            var
                SalesLine2: Record "Sales Line";
            begin
                SalesLine2.GET("Document Type"::"Blanket Order", "Blanket Order No.", "Blanket Order Line No.");
                VALIDATE("Location Code", SalesLine2."Location Code");
                VALIDATE("Unit of Measure Code", SalesLine2."Unit of Measure Code");
                VALIDATE("Unit Price", SalesLine2."Unit Price");
                VALIDATE("Line Discount %", SalesLine2."Line Discount %");
            end;
        }
        modify("Unit of Measure Code")
        {
            trigger OnAfterValidate()
            var
                Res: Record Resource;
                Item: Record Item;
            begin
                // << Shipping
                CASE Type OF
                    Type::Item:
                        begin
                            Item.Get("No.");
                            Rec."LAX Dimmed Weight" := Item."LAX Dimmed Weight" * "Qty. per Unit of Measure";
                        End;
                    Type::Resource:
                        BEGIN
                            Res.GET("No.");
                            "Gross Weight" := Res."LAX Gross Weight";
                            "Net Weight" := Res."LAX Net Weight";
                            "LAX Dimmed Weight" := Res."LAX Dimmed Weight";
                            "Unit Volume" := Res."LAX Unit Volume";
                        END;
                END;
                // >> Shipping 
            end;
        }
        field(50000; "EDI Line No."; Integer)
        {
            Editable = false;
        }
        field(50005; "Certificate No."; Code[30])
        {
        }
        field(50010; "Drawing No."; Code[30])
        {
        }
        field(50020; "Revision No."; Code[20])
        {
            TableRelation = IF (Type = CONST(Item)) "Cust./Item Drawing2"."Revision No." WHERE("Item No." = FIELD("No."),
                                                                                            "Customer No." = FILTER(''));
        }
        field(50025; "Revision Date"; Date)
        {
        }
        field(50027; "Revision No. (Label Only)"; Code[20])
        {
        }
        field(50030; "Total Parcels"; Decimal)
        {
            DecimalPlaces = 0 : 2;
            Description = '#10069';
        }
        field(50100; "Storage Location"; Code[10])
        {
        }
        field(50105; "Line Supply Location"; Code[10])
        {
        }
        field(50110; "Deliver To"; Code[10])
        {
        }
        field(50115; "Receiving Area"; Code[10])
        {
        }
        field(50120; "Ran No."; Code[20])
        {
        }
        field(50125; "Container No."; Code[20])
        {
        }
        field(50130; "Kanban No."; Code[20])
        {
        }
        field(50135; "Res. Mfg."; Code[20])
        {
        }
        field(50140; "Release No."; Code[20])
        {
        }
        field(50145; "Mfg. Date"; Date)
        {
        }
        field(50150; "Man No."; Code[20])
        {
        }
        field(50155; "Delivery Order No."; Code[20])
        {
        }
        field(50157; "Plant Code"; Code[10])
        {
        }
        field(50160; "Dock Code"; Code[10])
        {
        }
        field(50165; "Box Weight"; Decimal)
        {
        }
        field(50170; "Store Address"; Text[50])
        {
        }
        field(50175; "FRS No."; Code[10])
        {
        }
        field(50180; "Main Route"; Code[10])
        {
        }
        field(50185; "Line Side Address"; Text[50])
        {
        }
        field(50190; "Sub Route Number"; Code[10])
        {
        }
        field(50195; "Special Markings"; Text[30])
        {
        }
        field(50200; "Eng. Change No."; Code[20])
        {
        }
        field(50205; "Group Code"; Code[20])
        {
        }
        field(50500; "Model Year"; Code[10])
        {
        }
        field(50800; "Entry/Exit Date"; Date)
        {
            Caption = 'Entry/Exit Date';
            Description = 'AKK1606.01';
        }
        field(50801; "Entry/Exit No."; Code[20])
        {
            Caption = 'Entry/Exit No.';
            Description = 'AKK1606.01';
        }
        field(50802; National; Boolean)
        {
            Caption = 'National';
            Description = 'AKK1606.01';
        }
        field(50803; "IoT Lot No."; Code[20])
        {
            Description = 'CIS.Ram IoT';
        }
        //TODO
        /* field(14017611; "Order Date"; Date)
        {
            Description = 'NV - FB';
        }
        field(14017615; "Salesperson Code"; Code[10])
        {
            Description = 'NV - FB';
            TableRelation = "Salesperson/Purchaser".Code WHERE(Sales = CONST(Yes));
        }
        field(14017616; "Inside Salesperson Code"; Code[10])
        {
            Description = 'NV - FB';
            TableRelation = "Salesperson/Purchaser".Code WHERE("Inside Sales" = CONST(Yes));
        }
        field(14017618; "External Document No."; Code[20])
        {
            Description = 'NV - FB';
        }
        field(14017633; "Line Comment"; Boolean)
        {
            Description = 'NF1.00:CIS.NG 10-10-15';
            Editable = false;
            Enabled = false;
            FieldClass = FlowField;
            InitValue = false;
        }
        field(14017645; "Contract No."; Code[20])
        {
            Description = 'NV - FB';
            TableRelation = "Price Contract" WHERE("Customer No." = FIELD("Sell-to Customer No."));

            trigger OnValidate();
            var
                SalesHeadr: Record "Sales Header";
            begin

                IF ("Contract No." <> xRec."Contract No.") THEN BEGIN
                    //contract must either be blank, or match that of header
                    IF "Contract No." <> '' THEN BEGIN
                        SalesHeadr := GetSalesHeader();
                        TESTFIELD("Contract No.", SalesHeadr."Contract No.");
                    END;

                    UpdateUnitPrice(FIELDNO("Contract No."));
                END;
            end;
        }
        field(14017752; "Ship-to Code"; Code[10])
        {
            Description = 'NV - FB';
        }
        field(14017756; "Item Group Code"; Code[10])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
        }
        field(37015330; "FB Order No."; Code[20])
        {
            Description = 'NV - FB';
        }
        field(37015331; "FB Line No."; Integer)
        {
            Description = 'NV - FB';
        }
        field(37015332; "FB Tag No."; Code[20])
        {
            Description = 'NV - FB';
        }
        field(37015333; "FB Customer Bin"; Code[20])
        {
            Description = 'NV - FB';
        } */
        //TODO
    }

    Var
        ShippingAgent: Record 291;
        SalesSetup: Record 311;
        NIFItemCrossRef: Record 5777;
        NVM: Codeunit 50021;
        SalesPrice: Record 7002;
        RunFromEDI: Boolean;
        EDITemp: Boolean;
        Text14000701: Label 'Packages already exist for this line.';

    PROCEDURE CalcStdPackQty(Qty: Decimal): Decimal;
    BEGIN
        IF "LAX Qty. per Std. Pack" <> 0 THEN
            EXIT(ROUND(Qty / "LAx Qty. per Std. Pack", 0.00001))
        ELSE
            EXIT(0);
    END;

    PROCEDURE CalcPackageQty(Qty: Decimal): Decimal;
    BEGIN
        IF "LAX Std. Packs per Package" <> 0 THEN
            EXIT(ROUND(Qty / "LAX Std. Packs per Package", 0.00001))
        ELSE
            EXIT(0);
    END;

    PROCEDURE CalcEShipWhseOutstQtyBase(LocationPacking: Boolean; LocationCode: Code[10]) QtyBase: Decimal;
    VAR
        SalesLine: Record 37;
    BEGIN
        QtyBase := 0;

        SalesLine.COPY(Rec);
        IF LocationPacking THEN
            SalesLine.SETRANGE("Location Code", LocationCode);
        IF SalesLine.FIND('-') THEN
            REPEAT
                SalesLine.CALCFIELDS("LAX EShip Invt Outst Qty(Base)");
                //>> NF1.00:CIS.NG    10/12/16
                //IF (SalesLine."Qty. to Ship (Base)" = 0) OR (SalesLine."E-Ship Invt. Outst. Qty (Base)"<> 0)
                IF (SalesLine."Qty. to Ship (Base)" = 0) AND (SalesLine."LAX EShip Invt Outst Qty(Base)" <> 0)
                //<< NF1.00:CIS.NG    10/12/16
                THEN BEGIN
                    SalesLine.CALCFIELDS(
                      "LAX EShip Whse Outst.Qty(Base)", "LAX EShip Whse Ship. Qty(Base)");
                    QtyBase :=
                      QtyBase +
                      SalesLine."LAX EShip Whse Outst.Qty(Base)" + SalesLine."LAX EShip Whse Ship. Qty(Base)" +
                      SalesLine."LAX EShip Invt Outst Qty(Base)";
                END;
            UNTIL SalesLine.NEXT = 0;
    END;


    /*  LOCAL PROCEDURE UpdateRequiredShippingAgent();
     VAR
         RequiredShippingAgent: Record 14000722;
         ShippingAgent: Record 291;
         EShipAgentService: Record 14000708;
     BEGIN
         IF NOT "LAX Pack" THEN
             EXIT;

         CLEAR(RequiredShippingAgent);
         IF NOT RequiredShippingAgent.GET(Type, "No.", SalesHeader."Shipping Agent Code")
         THEN BEGIN
             RequiredShippingAgent.RESET;
             RequiredShippingAgent.SETRANGE(Type, Type);
             RequiredShippingAgent.SETRANGE(Code, "No.");
             RequiredShippingAgent.SETRANGE("Use for All Shipping Agents", TRUE);
             IF NOT RequiredShippingAgent.FIND('-') THEN
               ;
         END;

         IF RequiredShippingAgent."Shipping Agent Code" <> '' THEN BEGIN
             GetSalesHeader();

             VALIDATE("LAX Req. Shipping Agent Code", RequiredShippingAgent."Shipping Agent Code");
             ShippingAgent.GET("LAX Req. Shipping Agent Code");
             CASE TRUE OF
                 EShipAgentService.InternationalShipment(ShippingAgent, SalesHeader."Ship-to Country/Region Code"):
                     VALIDATE("LAX Req. E-Ship Agent Service", RequiredShippingAgent."Required Int. Ship. Agent Serv");
                 EShipAgentService.UPSCanadianShipment(ShippingAgent, SalesHeader."Ship-to Country/Region Code"):
                     VALIDATE("LAX Req. E-Ship Agent Service", RequiredShippingAgent."Req. UPS CA Ship. Agent Serv.");
                 EShipAgentService.UPSPuertoRicoShipment(ShippingAgent, SalesHeader."Ship-to Country/Region Code"):
                     VALIDATE("LAX Req. E-Ship Agent Service", RequiredShippingAgent."Req. UPS PR Ship. Agent Serv.");
                 ELSE
                     VALIDATE("LAX Req. E-Ship Agent Service", RequiredShippingAgent."Required Dom. Ship. Agent Serv");
             END;
             VALIDATE("LAX Allow Other ShipAgent/Serv", RequiredShippingAgent."Allow Other Service");
         END;
     END;
  */
    PROCEDURE SetRunFromEDI(EDI: Boolean);
    BEGIN
        // >> EDI
        IF EDI THEN
            RunFromEDI := TRUE
        ELSE
            RunFromEDI := FALSE;
        // << EDI
    END;

    PROCEDURE SetEDITemp(EDI: Boolean);
    BEGIN
        // >> EDI
        IF EDI THEN
            EDITemp := TRUE
        ELSE
            EDITemp := FALSE;
        // << EDI
    END;

    PROCEDURE AllowInWarehousePosting(): Boolean;
    BEGIN
        EXIT("LAX Shipping Charge" OR ((Type = Type::Resource) AND "LAX Pack"));
    END;


    PROCEDURE "<<NIF fcn>>"();
    BEGIN
    END;

    PROCEDURE ShowSpecialFields();
    VAR
        SalesLine: Record 37;
        Specialfields: Page 50006;
    BEGIN
        IF (Type <> Type::Item) OR ("No." = '') THEN
            EXIT;
        SalesLine.SETRANGE("Document Type", "Document Type");
        SalesLine.SETRANGE("Document No.", "Document No.");
        SalesLine.SETRANGE("Line No.", "Line No.");
        Specialfields.SETTABLEVIEW(SalesLine);
        Specialfields.RUN();
    END;

    PROCEDURE CheckParcelQty(VAR OrderQty: Decimal): Boolean;
    VAR
        Item: Record 27;
        OrderMultiple: Decimal;
        ParcelOrderQty: Decimal;
        TextConst001: Label 'Item %1 has a Standard Net Pack of %2 .\', Comment = '%1=ItemNo.,%2=OrderMultiple';
        TextConst002: Label 'A quantity of %3 %7 would create an even Pack quantity of %4.\\', Comment = '%3=ParcleOrderQty,%7=ItemBaseUnitOfMeasure,%4=ParcelOrderQty DIV OrderMultiple';
        TextConst003: Label 'Do you want to change the quantity from %5 to %6?', Comment = '%5=OrderQty,%6=ParcelOrderQty';
    BEGIN
        //function passes and returns qty through variable
        //also returns TRUE if qty was changed
        //if qty is zero, exit
        IF OrderQty <= 1 THEN
            EXIT;

        //if no "Units per Parcel", then exit
        IF "Units per Parcel" = 0 THEN
            EXIT;

        Item.GET("No.");
        OrderMultiple := "Units per Parcel";

        //if multiple divides qty cleanly, exit
        IF OrderQty MOD OrderMultiple = 0 THEN
            EXIT;

        //otherwise, propose new qty
        ParcelOrderQty := ((OrderQty DIV OrderMultiple) + 1) * OrderMultiple;

        //exit if not confirmed
        IF GUIALLOWED THEN  //NF1.00:CIS.NG  10/30/15
            IF NOT CONFIRM(
              STRSUBSTNO(TextConst001 + TextConst002 + TextConst003,
                             Item."No.", OrderMultiple,
                                ParcelOrderQty, ParcelOrderQty DIV OrderMultiple,
                                   OrderQty, ParcelOrderQty, Item."Base Unit of Measure"))
                 THEN
                EXIT;
        //NF1.00:CIS.NG  10/30/15

        //if confirmed, pass back new quantity
        OrderQty := ParcelOrderQty;

        EXIT(TRUE);
    END;

    PROCEDURE DeleteLineComments();
    BEGIN
        //>> NF1.00:CIS.CM 09-29-15
        //SalesLineCommentLine.RESET;
        //SalesLineCommentLine.SETRANGE("Document Type","Document Type");
        //SalesLineCommentLine.SETRANGE("No.","Document No.");
        //SalesLineCommentLine.SETRANGE("Doc. Line No.","Line No.");
        //SalesLineCommentLine.DELETEALL;
        //<< NF1.00:CIS.CM 09-29-15
    END;

    PROCEDURE UpdateSpecialOrderCost();
    var
        SalesHeader: Record "Sales Header";
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
    BEGIN
        SalesHeader := GetSalesHeader();
        IF SalesHeader."Currency Code" <> '' THEN BEGIN
            Currency.TESTFIELD("Unit-Amount Rounding Precision");
            "Unit Cost" :=
              ROUND(
                CurrExchRate.ExchangeAmtLCYToFCY(
                  GetDate(), SalesHeader."Currency Code",
                  "Unit Cost (LCY)", SalesHeader."Currency Factor"),
                  Currency."Unit-Amount Rounding Precision")
        END ELSE
            "Unit Cost" := "Unit Cost (LCY)";
    END;

    PROCEDURE InsertLineComments();
    VAR
        CommentLine: Record 97;
    BEGIN
        //TODO
        CommentLine.SETRANGE("Table Name", CommentLine."Table Name"::Item);
        CommentLine.SETRANGE("No.", "No.");
        CommentLine.SETRANGE("Include in Sales Orders", TRUE);
        IF CommentLine.FIND('-') THEN
            REPEAT
            //>> NF1.00:CIS.CM 09-29-15
            //SalesLineCommentLine.INIT;
            //SalesLineCommentLine."Document Type" := "Document Type";
            //SalesLineCommentLine."No." := "Document No.";
            //SalesLineCommentLine."Doc. Line No." := "Line No.";
            //SalesLineCommentLine."Line No." := CommentLine."Line No.";
            //SalesLineCommentLine.Code := CommentLine.Code;
            //SalesLineCommentLine.Comment := CommentLine.Comment;
            //SalesLineCommentLine."Print On Quote" := CommentLine."Print On Sales Quote";
            //SalesLineCommentLine."Print On Pick Ticket" := CommentLine."Print On Pick Ticket";
            //SalesLineCommentLine."Print On Order Confirmation" := CommentLine."Print On Order Confirmation";
            //SalesLineCommentLine."Print On Shipment" := CommentLine."Print On Shipment";
            //SalesLineCommentLine."Print On Invoice" := CommentLine."Print On Sales Invoice";
            //SalesLineCommentLine.INSERT(TRUE);
            //<< NF1.00:CIS.CM 09-29-15
            UNTIL CommentLine.NEXT() = 0;
        //TODO
    END;

    PROCEDURE CheckIfLineComments(): Boolean;
    VAR
        CommentLine: Record 97;
    BEGIN
        //TODO
        CommentLine.SETRANGE("Table Name", CommentLine."Table Name"::Item);
        CommentLine.SETRANGE("No.", "No.");
        CommentLine.SETRANGE("Include in Sales Orders", TRUE);
        EXIT(CommentLine.FIND('-'));
        //TODO
    END;

    PROCEDURE GetAltUOM();
    VAR
        ItemUOMRec: Record 5404;
    BEGIN
        //TODO
        IF "Quantity (Base)" = 0 THEN EXIT;
        ItemUOMRec.RESET;
        ItemUOMRec.SETRANGE("Item No.", "No.");
        ItemUOMRec.SETRANGE("Sales Qty Alt.", TRUE);

        IF NOT ItemUOMRec.ISEMPTY THEN BEGIN
            ItemUOMRec.FIND('-');

            //>> NIF 03/17/0
            IF ItemUOMRec."Alt. Base Qty." < 1 THEN
                "Alt. Quantity" := "Quantity (Base)" / ItemUOMRec."Qty. per Unit of Measure"
            ELSE
                //<< NIF
                "Alt. Quantity" := "Quantity (Base)" * ItemUOMRec."Alt. Base Qty.";
            "Alt. Qty. UOM" := ItemUOMRec.Code;
            "Alt. Price UOM" := ItemUOMRec."Sales Price Per Alt.";
            //>> NIF 06-21-05
            //use current uom if existing one is blank
            //END
        END ELSE BEGIN
            "Alt. Quantity" := "Quantity (Base)" * "Qty. per Unit of Measure";
            "Alt. Qty. UOM" := "Unit of Measure Code";
            "Alt. Price UOM" := "Unit of Measure Code";
        END;
        //<< NIF 06-21-05 
        //TODO
    END;

    PROCEDURE GetAltPrice(CalledByFieldNo: Integer);
    VAR
        ItemUOMRec: Record 5404;
    BEGIN
        //TODO
        //>> NIF RTT 04-25-05
        //if alt. price was entered, then do not recalc
        IF (CalledByFieldNo = FIELDNO("Alt. Price")) THEN
            EXIT;
        //<< NIF RTT 04-25-05

        IF "Alt. Price UOM" = '' THEN EXIT;
        ItemUOMRec.GET("No.", "Alt. Price UOM");
        IF ItemUOMRec."Alt. Base Qty." <> 0 THEN BEGIN
            "Alt. Price" := ROUND("Net Unit Price" / ItemUOMRec."Alt. Base Qty.", 0.01, '>');
            "Alt. Sales Cost" := ROUND("Unit Cost" / ItemUOMRec."Alt. Base Qty.", 0.01, '>');
            //>> NIF 06-12-05
            //  END;
        END
        ELSE BEGIN
            "Alt. Price" := ROUND("Net Unit Price" / ItemUOMRec."Qty. per Unit of Measure", 0.01, '>');
            "Alt. Sales Cost" := ROUND("Unit Cost" / ItemUOMRec."Qty. per Unit of Measure", 0.01, '>');
        END;
        //<< NIF 06-12-05 
        //TODO
    END;

    PROCEDURE UpdateWeight();
    BEGIN
        //TODO
        "Line Gross Weight" := Quantity * "Gross Weight";
        "Line Net Weight" := Quantity * "Net Weight";
        "Outstanding Gross Weight" := "Outstanding Quantity" * "Gross Weight";
        "Outstanding Net Weight" := "Outstanding Quantity" * "Net Weight";
        //TODO
    END;

    PROCEDURE ShowVendor();
    VAR
        Vendor: Record 23;
        Item: Record 27;
    BEGIN
        //>> NF1.00:CIS.NG 09-01-15
        IF (Type = Type::Item) AND ("No." <> '') THEN
            IF Item.GET("No.") AND (Item."Vendor No." <> '') THEN BEGIN
                Vendor.SETRANGE("No.", Item."Vendor No.");
                PAGE.RUN(PAGE::"Vendor Card", Vendor);
            END;
        //<< NF1.00:CIS.NG 09-01-15
    END;

    PROCEDURE ShowItemVendor();
    VAR
        ItemVendor: Record 99;
    BEGIN
        //>> NF1.00:CIS.NG 09-01-15
        IF (Type = Type::Item) AND ("No." <> '') THEN BEGIN
            ItemVendor.SETRANGE("Item No.", "No.");
            PAGE.RUN(PAGE::"Item Vendor Catalog", ItemVendor);
        END;
        //<< NF1.00:CIS.NG 09-01-15
    END;

    PROCEDURE ShowPurchaseOrderLines();
    VAR
        PurchLine: Record 39;
    BEGIN
        //>> NF1.00:CIS.NG 09-01-15
        IF (Type = Type::Item) AND ("No." <> '') THEN BEGIN
            PurchLine.SETRANGE(Type, PurchLine.Type::Item);
            PurchLine.SETRANGE("No.", "No.");
            PurchLine.SETFILTER("Outstanding Quantity", '<>0');
            PAGE.RUN(0, PurchLine);
        END;
        //<< NF1.00:CIS.NG 09-01-15
    END;

    PROCEDURE ShowRequisitionLines();
    VAR
        ReqLine: Record 246;
    BEGIN
        //>> NF1.00:CIS.NG 09-01-15
        IF (Type = Type::Item) AND ("No." <> '') THEN BEGIN
            ReqLine.SETRANGE(Type, ReqLine.Type::Item);
            ReqLine.SETRANGE("No.", "No.");
            PAGE.RUN(0, ReqLine);
        END;
        //<< NF1.00:CIS.NG 09-01-15
    END;

    PROCEDURE HasTypeToFillMandatotyFields(): Boolean;
    BEGIN
        EXIT(Type <> Type::" ");
    END;

}
