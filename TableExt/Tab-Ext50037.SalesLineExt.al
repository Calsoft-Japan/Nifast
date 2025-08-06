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
                    SalesSetup.GET;
                    IF SalesSetup."Blank Drop Shipm. Qty. to Ship" THEN
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
            begin
                case Type of
                    Type::Resource:
                        begin
                            Res.GET("No.");
                            "Gross Weight" := Res."Gross Weight";
                            "Net Weight" := Res."Net Weight";
                            "Unit Volume" := Res."Unit Volume";
                        End;
                end;
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
    }

    Var
        ShippingAgent: Record 291;
        SalesSetup: Record 311;
        NVM: Codeunit 50021;
        NIFItemCrossRef: Record 5777;
        SalesPrice: Record 7002;
        RunFromEDI: Boolean;
        EDITemp: Boolean;
        Text14000701: Label 'Packages already exist for this line.';

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
        Specialfields.RUN;
    END;

    PROCEDURE CheckParcelQty(VAR OrderQty: Decimal): Boolean;
    VAR
        Item: Record 27;
        OrderMultiple: Decimal;
        ParcelOrderQty: Decimal;
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
        IF GUIALLOWED THEN BEGIN  //NF1.00:CIS.NG  10/30/15
            IF NOT CONFIRM(
              STRSUBSTNO('Item %1 has a Standard Net Pack of %2 .\' +
                         'A quantity of %3 %7 would create an even Pack quantity of %4.\\' +
                         'Do you want to change the quantity from %5 to %6?',
                             Item."No.", OrderMultiple,
                                ParcelOrderQty, ParcelOrderQty DIV OrderMultiple,
                                   OrderQty, ParcelOrderQty, Item."Base Unit of Measure"))
                 THEN
                EXIT;
        END;  //NF1.00:CIS.NG  10/30/15

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
                  GetDate, SalesHeader."Currency Code",
                  "Unit Cost (LCY)", SalesHeader."Currency Factor"),
                  Currency."Unit-Amount Rounding Precision")
        END ELSE
            "Unit Cost" := "Unit Cost (LCY)";
    END;

    PROCEDURE ShowVendor();
    VAR
        Vendor: Record 23;
        Item: Record 27;
    BEGIN
        //>> NF1.00:CIS.NG 09-01-15
        IF (Type = Type::Item) AND ("No." <> '') THEN BEGIN
            IF Item.GET("No.") AND (Item."Vendor No." <> '') THEN BEGIN
                Vendor.SETRANGE("No.", Item."Vendor No.");
                PAGE.RUN(PAGE::"Vendor Card", Vendor);
            END;
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
