page 50020 "Lot Entry"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    Caption = 'Lot Entry';
    InsertAllowed = false;
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    Permissions = TableData "Whse. Item Tracking Line" = rimd;
    SourceTable = "Lot Entry";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(" "; '')
                {
                    CaptionClass = FORMAT(HeaderString[1]);
                    Editable = false;
                    ToolTip = 'Specifies the value of the '''' field.';
                }
                field("  "; '')
                {
                    CaptionClass = FORMAT(HeaderString[2]);
                    Editable = false;
                    ToolTip = 'Specifies the value of the '''' field.';
                }
                field("   "; '')
                {
                    CaptionClass = FORMAT(HeaderString[3]);
                    Editable = false;
                    ToolTip = 'Specifies the value of the '''' field.';
                }
                field(QtyAssigned; QtyAssigned)
                {
                    Caption = 'Qty. Assigned';
                    DecimalPlaces = 0 : 2;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Qty. Assigned field.';
                }
                field(QtyOutstanding; QtyOutstanding)
                {
                    Caption = 'Qty. Outstanding';
                    DecimalPlaces = 0 : 2;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Qty. Outstanding field.';
                }
                field(QtyRemaining; QtyRemaining)
                {
                    Caption = 'Qty. Remaining';
                    DecimalPlaces = 0 : 2;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Qty. Remaining field.';
                }
            }
            group(Generals)
            {
                field("Order Line No."; Rec."Order Line No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Order Line No. field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    DecimalPlaces = 0 : 2;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Expiration Date field.';
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ToolTip = 'Specifies the value of the Lot No. field.';

                    trigger OnAssistEdit()
                    var
                        Location: Record Location;
                        ItemTrackingMgt: Codeunit "Item Tracking Management";
                        MaxQuantity: Decimal;
                        SourceQuantityArray: array[5] of Decimal;
                        CurrentSignFactor: Integer;
                    begin
                        MaxQuantity := Rec.CalcQtyOutstanding - Rec.CalcQtyAssigned + Rec.Quantity;

                        //determine whether location is WMS to pick lookup method
                        IF NOT Location.GET(Rec."Location Code") THEN
                            CLEAR(Location);

                        IF Location."Bin Mandatory" THEN
                            AssistEditLotSerialNoWMS(Rec, MaxQuantity)
                        ELSE
                            AssistEditLotSerialNo2(Rec,
                              CurrentSignFactor * SourceQuantityArray[1] < 0, CurrentSignFactor, 1, MaxQuantity);

                        CurrPage.UPDATE();
                    end;
                }
                field("Inspected Parts"; Rec."Inspected Parts")
                {
                    ToolTip = 'Specifies the value of the Inspected Parts field.';
                }
                field("CVE Pediment No."; Rec."CVE Pediment No.")
                {
                    DrillDown = false;
                    Lookup = false;
                    Visible = "CVE Pediment No.Visible";
                    ToolTip = 'Specifies the value of the CVE Pediment No. field.';
                }
                field("Revision No."; Rec."Revision No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Revision No. field.';
                }
                field("External Lot No."; Rec."External Lot No.")
                {
                    Caption = 'Mfg. Lot No.';
                    ToolTip = 'Specifies the value of the Mfg. Lot No. field.';
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ToolTip = 'Specifies the value of the Creation Date field.';
                }
                field("Country of Origin"; Rec."Country of Origin")
                {
                    ToolTip = 'Specifies the value of the Country of Origin field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ClearLines)
            {
                Caption = '&Clear Lines';
                Promoted = true;
                Image = ClearFilter;
                PromotedCategory = Process;
                ToolTip = 'Executes the &Clear Lines action.';

                trigger OnAction()
                var
                    NVM: Codeunit "NewVision Management_New";
                begin
                    NVM.ClearLotEntryLines(Rec."Document Type", Rec."Document No.", Rec);
                end;
            }
            action(SuggestLines)
            {
                Caption = '&Suggest Lines';
                Image = SuggestReconciliationLines;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the &Suggest Lines action.';

                trigger OnAction()
                var
                    NVM: Codeunit "NewVision Management_New";
                begin
                    NVM.SuggestLotEntryLines(Rec."Document Type", Rec."Document No.", Rec);
                end;
            }
            action(SplitLiness)
            {
                Caption = '&Split Lines';
                Promoted = true;
                Image = Split;
                PromotedCategory = Process;
                Visible = SplitLinesVisible;
                ToolTip = 'Executes the &Split Lines action.';

                trigger OnAction()
                begin
                    SplitLines();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord();
    end;

    trigger OnInit()
    begin
        "CVE Pediment No.Visible" := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord();
    end;

    trigger OnOpenPage()
    begin
        //>>NIF 051206 RTT #10775
        IF STRPOS(COMPANYNAME, 'Mexi') = 0 THEN
            "CVE Pediment No.Visible" := FALSE;
        //<<NIF 051206 RTT #10775
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF CloseAction = ACTION::LookupOK THEN
            LookupOKOnPush();
    end;

    var
        SalesHeader: Record "Sales Header";
        TransferHeader: Record "Transfer Header";
        ItemTrackingSummaryForm: Page 6500;
        "CVE Pediment No.Visible": Boolean;
        SplitLinesVisible: Boolean;
        QtyAssigned: Decimal;
        QtyOutstanding: Decimal;
        QtyRemaining: Decimal;
        Text004: TextConst ENU = 'Counting records...';
        HeaderString: array[3] of Text[100];

    procedure GetHeaderText()
    var
        PurchHeader: Record "Purchase Header";
        WhseShptLine: Record "Warehouse Shipment Line";
    begin
        //if already have header text then exit
        IF HeaderString[1] <> '' THEN
            EXIT;

        //otherwise proceed

        CLEAR(HeaderString);

        CASE Rec."Document Type" OF
            Rec."Document Type"::"Whse. Shipment":
                BEGIN
                    IF NOT WhseShptLine.GET(Rec."Document No.", Rec."Order Line No.") THEN
                        CLEAR(WhseShptLine);

                    CASE WhseShptLine."Source Type" OF
                        DATABASE::"Sales Line":
                            IF SalesHeader.GET(WhseShptLine."Source Subtype", WhseShptLine."Source No.") THEN BEGIN
                                HeaderString[1] := FORMAT(SalesHeader."Document Type") + ' ' + SalesHeader."No.";
                                HeaderString[2] := SalesHeader."Sell-to Customer No." + ' ' + SalesHeader."Ship-to Name";
                            END;

                        DATABASE::"Transfer Line":
                            IF TransferHeader.GET(WhseShptLine."Source No.") THEN BEGIN
                                HeaderString[1] := 'Transfer Order ' + TransferHeader."No.";
                                HeaderString[2] := 'Transfer From: ' + TransferHeader."Transfer-from Code" + ' ' + TransferHeader."Transfer-from Name";
                                HeaderString[3] := 'Transfer To: ' + TransferHeader."Transfer-to Code" + ' ' + TransferHeader."Transfer-to Name";
                            END;
                    END;
                END;

            Rec."Document Type"::"Transfer Order":
                IF TransferHeader.GET(Rec."Document No.") THEN BEGIN
                    HeaderString[1] := 'Transfer Order ' + TransferHeader."No.";
                    HeaderString[2] := 'Transfer From: ' + TransferHeader."Transfer-from Code" + ' ' + TransferHeader."Transfer-from Name";
                    HeaderString[3] := 'Transfer To: ' + TransferHeader."Transfer-to Code" + ' ' + TransferHeader."Transfer-to Name";
                END;
            Rec."Document Type"::"Purchase Order":
                IF PurchHeader.GET(PurchHeader."Document Type"::Order, Rec."Document No.") THEN BEGIN
                    HeaderString[1] := 'Purchase Order ' + PurchHeader."No.";
                    HeaderString[2] := PurchHeader."Buy-from Vendor No." + ' ' + PurchHeader."Buy-from Vendor Name";
                END;
            ELSE
                IF SalesHeader.GET(Rec."Document Type", Rec."Document No.") THEN BEGIN
                    HeaderString[1] := FORMAT(SalesHeader."Document Type") + ' ' + SalesHeader."No.";
                    HeaderString[2] := SalesHeader."Sell-to Customer No." + ' ' + SalesHeader."Ship-to Name";
                END;
        END;   //END CASE
    end;

    procedure SplitLines()
    var
        LotEntry: Record "Lot Entry";
    begin
        LotEntry.COPY(Rec);
        Rec.SplitLine(LotEntry);
        CurrPage.UPDATE(FALSE);
    end;

    procedure CalcQuantities()
    begin
        QtyAssigned := Rec.CalcQtyAssigned;
        QtyOutstanding := Rec.CalcQtyOutstanding;

        QtyRemaining := QtyOutstanding - QtyAssigned;
    end;

    procedure CheckQuantities(var ErrorMsg: Text[250]): Boolean
    var
        LotEntry: Record "Lot Entry";
        TextLbl: Label 'Check Item %1, Line %2. Quantities do not match.', Comment = '%1%2';
        Text00Lbl: Label 'Check Item %1, Lot is blank. Quantities do not match.', Comment = '%1';
    begin
        LotEntry.SETRANGE("Document Type", Rec."Document Type");
        LotEntry.SETRANGE("Document No.", Rec."Document No.");
        LotEntry.FIND('-');
        REPEAT
            //IF (CalcQtyAssigned<>CalcQtyOutstanding) THEN
            IF (Rec.CalcQtyAssigned() <> Rec.CalcQtyToShip()) THEN BEGIN
                ErrorMsg := STRSUBSTNO(TextLbl, LotEntry."Item No.", LotEntry."Order Line No.");
                EXIT(FALSE);
            END;

            IF (LotEntry."Lot No." = '') THEN BEGIN
                ErrorMsg := STRSUBSTNO(Text00Lbl, LotEntry."Item No.");
                EXIT(FALSE);
            END;

        UNTIL LotEntry.NEXT() = 0;

        EXIT(TRUE);
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        GetHeaderText();
        CalcQuantities();

        //show suggest lines only if location is bin enabled
        //CurrForm.SuggestLines.VISIBLE("Document Type" = "Document Type"::"Whse. Shipment");
        //CurrForm.ClearLines.VISIBLE("Document Type" = "Document Type"::"Whse. Shipment");
        SplitLinesVisible := Rec."Document Type" <> Rec."Document Type"::"Purchase Order";
        CurrPage.EDITABLE(Rec."Document Type" <> Rec."Document Type"::"Purchase Order");
    end;

    local procedure LookupOKOnPush()
    var
        ErrorMsg: Text[250];
    begin
        IF NOT CheckQuantities(ErrorMsg) THEN
            IF Rec."Document Type" = Rec."Document Type"::"Whse. Shipment" THEN
                EXIT
            ELSE
                MESSAGE('%1', ErrorMsg);
    end;

    PROCEDURE AssistEditLotSerialNoWMS(VAR LotEntry: Record 50002; MaxQuantity: Decimal);
    VAR
        ItemTrackingSummaryForm: Page 50022;
        Item: Record 27;
        TempLotBinContent: Record 50001 temporary;
        NVM: Codeunit 50021;
        LotEntry2: Record 50002;
    BEGIN
        Item.GET(LotEntry."Item No.");

        Item.SETRANGE("Location Filter", LotEntry."Location Code");

        Item.GetLotBinContents(TempLotBinContent);

        //>> 07-10-05

        IF LotEntry."Use Revision No." <> '' THEN
            TempLotBinContent.SETRANGE("Revision No.", LotEntry."Use Revision No.");

        //<< 07-10-05

        TempLotBinContent.SETFILTER("Bin Type Code", NVM.GetBinTypeFilter(3));

        ItemTrackingSummaryForm.SetSources(TempLotBinContent);

        ItemTrackingSummaryForm.LOOKUPMODE(TRUE);

        IF TempLotBinContent.FIND('-') THEN
            ItemTrackingSummaryForm.SETRECORD(TempLotBinContent);

        TempLotBinContent.RESET;

        IF ItemTrackingSummaryForm.RUNMODAL = ACTION::LookupOK THEN BEGIN

            ItemTrackingSummaryForm.GETRECORD(TempLotBinContent);

            //>> ISTRTT 9638 02-04-05

            IF (TempLotBinContent."Block Movement" = TempLotBinContent."Block Movement"::Outbound) OR

                 (TempLotBinContent."Block Movement" = TempLotBinContent."Block Movement"::All) THEN
                ERROR('You cannot pick from Bin %1 for Item %2.\' +

                        'Block Movement = %3', TempLotBinContent."Bin Code",

                          TempLotBinContent."Item No.", TempLotBinContent."Block Movement");

            //<< ISTRTT 9638 02-04-05

            //make sure it isn't already on another line

            LotEntry2.SETRANGE("Document Type", LotEntry."Document Type");

            LotEntry2.SETRANGE("Document No.", LotEntry."Document No.");

            LotEntry2.SETRANGE("Order Line No.", LotEntry."Order Line No.");

            LotEntry2.SETFILTER("Line No.", '<>%1', LotEntry."Line No.");

            LotEntry2.SETRANGE("Lot No.", TempLotBinContent."Lot No.");

            IF LotEntry2.FIND('-') THEN
                ERROR('This lot has already been selected.');

            LotEntry.VALIDATE("Lot No.", TempLotBinContent."Lot No.");

            LotEntry."Expiration Date" := TempLotBinContent."Expiration Date";

            LotEntry.VALIDATE(Quantity, MinValueAbs(TempLotBinContent.CalcQtyAvailable(0), MaxQuantity));
        END;
    END;

    PROCEDURE AssistEditLotSerialNo2(VAR LotEntry: Record 50002 temporary; SearchForSupply: Boolean; CurrentSignFactor: Integer; LookupMode: Option "Serial No.","Lot No."; MaxQuantity: Decimal): Boolean;
    VAR
        ItemLedgEntry: Record 32;

        ReservEntry: Record 337;

        TempReservEntry: Record 337 temporary;

        TempEntrySummary: Record 338 temporary;

        WarehouseEntry: Record 7312;

        LastEntryNo: Integer;

        AvailabilityDate: Date;

        Window: Dialog;

        InsertRec: Boolean;

        ">>NIF_LV": Integer;

        LotNoInfo: Record 6505;
    BEGIN
        //NV code was commented

        SearchForSupply := TRUE;

        CurrentSignFactor := -1;

        LookupMode := LookupMode::"Lot No.";

        Window.OPEN(Text004);

        TempReservEntry.RESET;

        TempReservEntry.DELETEALL;

        ReservEntry.RESET;

        ReservEntry.SETCURRENTKEY("Item No.", "Variant Code", "Location Code",

          "Source Type", "Source Subtype", "Reservation Status", "Expected Receipt Date");

        ReservEntry.SETRANGE("Reservation Status",

          ReservEntry."Reservation Status"::Reservation, ReservEntry."Reservation Status"::Surplus);

        ReservEntry.SETRANGE("Item No.", LotEntry."Item No.");

        ReservEntry.SETRANGE("Variant Code", LotEntry."Variant Code");

        ReservEntry.SETRANGE("Location Code", LotEntry."Location Code");

        ItemLedgEntry.RESET;

        ItemLedgEntry.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date");

        ItemLedgEntry.SETRANGE("Item No.", LotEntry."Item No.");

        ItemLedgEntry.SETRANGE("Variant Code", LotEntry."Variant Code");

        ItemLedgEntry.SETRANGE(Open, TRUE);

        ItemLedgEntry.SETRANGE("Location Code", LotEntry."Location Code");

        CASE LookupMode OF

            LookupMode::"Serial No.":

                BEGIN

                    IF MaxQuantity <> 0 THEN
                        MaxQuantity := MaxQuantity / ABS(MaxQuantity); // Set to a signed value of 1.

                    ItemLedgEntry.SETFILTER("Serial No.", '<>%1', '');

                    ReservEntry.SETFILTER("Serial No.", '<>%1', '');

                END;

            LookupMode::"Lot No.":

                BEGIN

                    ItemLedgEntry.SETFILTER("Lot No.", '<>%1', '');

                    ReservEntry.SETFILTER("Lot No.", '<>%1', '');

                END;

        END;

        IF ItemLedgEntry.FIND('-') THEN
            REPEAT

                /*

                IF SalesLotEntry."Bin Code" <> '' THEN BEGIN

                            InsertRec := FALSE;

                            WarehouseEntry.RESET;

                            WarehouseEntry.SETCURRENTKEY(

                              "Item No.", "Bin Code", "Location Code", "Variant Code",

                              "Unit of Measure Code", "Lot No.", "Serial No.");

                            WarehouseEntry.SETRANGE("Item No.", SalesLotEntry."Item No.");

                            WarehouseEntry.SETRANGE("Bin Code", SalesLotEntry."Bin Code");

                            WarehouseEntry.SETRANGE("Location Code", SalesLotEntry."Location Code");

                            WarehouseEntry.SETRANGE("Variant Code", SalesLotEntry."Variant Code");

                            CASE LookupMode OF

                                LookupMode::"Serial No.":

                                    WarehouseEntry.SETRANGE("Serial No.", ItemLedgEntry."Serial No.");

                                LookupMode::"Lot No.":

                                    WarehouseEntry.SETRANGE("Lot No.", ItemLedgEntry."Lot No.");

                            END;

                            WarehouseEntry.CALCSUMS("Qty. (Base)");

                            IF WarehouseEntry."Qty. (Base)" > 0 THEN
                                InsertRec := TRUE;

                        END ELSE

                            */

                InsertRec := TRUE;

                TempReservEntry.INIT;

                TempReservEntry."Entry No." := -ItemLedgEntry."Entry No.";

                TempReservEntry."Reservation Status" := ReservEntry."Reservation Status"::Surplus;

                TempReservEntry.Positive := ItemLedgEntry.Positive;

                TempReservEntry."Item No." := ItemLedgEntry."Item No.";

                TempReservEntry."Location Code" := ItemLedgEntry."Location Code";

                TempReservEntry."Quantity (Base)" := ItemLedgEntry."Remaining Quantity";

                TempReservEntry."Source Type" := DATABASE::"Item Ledger Entry";

                TempReservEntry."Source Ref. No." := ItemLedgEntry."Entry No.";

                TempReservEntry."Serial No." := ItemLedgEntry."Serial No.";

                TempReservEntry."Lot No." := ItemLedgEntry."Lot No.";

                TempReservEntry."Variant Code" := ItemLedgEntry."Variant Code";

                TempReservEntry."Mfg. Lot No." := ItemLedgEntry."External Lot No.";

                IF TempReservEntry.Positive THEN BEGIN

                    TempReservEntry."Warranty Date" := ItemLedgEntry."Warranty Date";

                    TempReservEntry."Expiration Date" := ItemLedgEntry."Expiration Date";

                    TempReservEntry."Expected Receipt Date" := 0D

                END ELSE
                    TempReservEntry."Shipment Date" := DMY2Date(31, 12, 9999);

                IF InsertRec THEN
                    TempReservEntry.INSERT;

            UNTIL ItemLedgEntry.NEXT = 0;

        IF ReservEntry.FIND('-') THEN
            REPEAT

                TempReservEntry := ReservEntry;

                TempReservEntry.INSERT;

            UNTIL ReservEntry.NEXT = 0;

        IF TempReservEntry.FIND('-') THEN
            REPEAT

                CASE LookupMode OF

                    LookupMode::"Serial No.":
                        TempEntrySummary.SETRANGE("Serial No.", TempReservEntry."Serial No.");

                    LookupMode::"Lot No.":
                        TempEntrySummary.SETRANGE("Lot No.", TempReservEntry."Lot No.");

                END;

                IF NOT TempEntrySummary.FIND('-') THEN BEGIN

                    TempEntrySummary.INIT;

                    TempEntrySummary."Entry No." := LastEntryNo + 1;

                    LastEntryNo := TempEntrySummary."Entry No.";

                    TempEntrySummary."Table ID" := TempReservEntry."Source Type";

                    TempEntrySummary."Summary Type" := '';

                    TempEntrySummary."Lot No." := TempReservEntry."Lot No.";

                    IF LookupMode = LookupMode::"Serial No." THEN
                        TempEntrySummary."Serial No." := TempReservEntry."Serial No.";

                    //>> NIF 07-10-05 RTT

                    //get lot info fields

                    IF LotNoInfo.GET(LotEntry."Item No.", LotEntry."Variant Code", TempReservEntry."Lot No.") THEN BEGIN

                        TempEntrySummary."Mfg. Lot No." := LotNoInfo."Mfg. Lot No.";

                        TempEntrySummary."Revision No." := LotNoInfo."Revision No.";

                    END;

                    //<< NIF 07-10-05 RTT

                    TempEntrySummary.INSERT;

                END;

                IF TempReservEntry.Positive THEN BEGIN

                    TempEntrySummary."Warranty Date" := TempReservEntry."Warranty Date";

                    TempEntrySummary."Expiration Date" := TempReservEntry."Expiration Date";

                    IF TempReservEntry."Entry No." < 0 THEN
                        TempEntrySummary."Total Quantity" += TempReservEntry."Quantity (Base)";

                    IF TempReservEntry."Reservation Status" = TempReservEntry."Reservation Status"::Reservation THEN
                        TempEntrySummary."Total Reserved Quantity" += TempReservEntry."Quantity (Base)";

                END ELSE BEGIN

                    TempEntrySummary."Total Requested Quantity" -= TempReservEntry."Quantity (Base)";

                    IF (TempReservEntry."Reservation Status" = TempReservEntry."Reservation Status"::Reservation) AND

                       (

                       ((LotEntry."Document Type" <> LotEntry."Document Type"::"Transfer Order") AND

                       (TempReservEntry."Source Type" = DATABASE::"Sales Line") AND

                       (TempReservEntry."Source Subtype" = LotEntry."Document Type") AND

                       (TempReservEntry."Source ID" = LotEntry."Document No.") AND

                       (TempReservEntry."Source Ref. No." = LotEntry."Order Line No."))

                       OR

                       ((LotEntry."Document Type" = LotEntry."Document Type"::"Transfer Order") AND

                       (TempReservEntry."Source Type" = DATABASE::"Transfer Line") AND

                       (TempReservEntry."Source Subtype" = 0) AND

                       (TempReservEntry."Source ID" = LotEntry."Document No.") AND

                       (TempReservEntry."Source Ref. No." = LotEntry."Order Line No."))

                       )

                     THEN
                        TempEntrySummary."Current Reserved Quantity" -= TempReservEntry."Quantity (Base)";

                END;

                TempEntrySummary."Total Available Quantity" :=

                  TempEntrySummary."Total Quantity" -

                  TempEntrySummary."Total Requested Quantity" +

                  TempEntrySummary."Current Reserved Quantity";

                TempEntrySummary.MODIFY;

            UNTIL TempReservEntry.NEXT = 0;

        TempEntrySummary.RESET;

        ItemTrackingSummaryForm.SetSources(TempReservEntry, TempEntrySummary);

        ItemTrackingSummaryForm.LOOKUPMODE(SearchForSupply);

        //xTempEntrySummary.SETRANGE("Serial No.",LotEntry."Serial No.");

        TempEntrySummary.SETRANGE("Lot No.", LotEntry."Lot No.");

        IF TempEntrySummary.FIND('-') THEN
            ItemTrackingSummaryForm.SETRECORD(TempEntrySummary);

        TempEntrySummary.RESET;

        Window.CLOSE;

        IF ItemTrackingSummaryForm.RUNMODAL = ACTION::LookupOK THEN BEGIN

            ItemTrackingSummaryForm.GETRECORD(TempEntrySummary);

            //xSalesLotEntry."Serial No." := TempEntrySummary."Serial No.";

            LotEntry.VALIDATE("Lot No.", TempEntrySummary."Lot No.");

            //>> istrtt 01-11-05 9488

            LotEntry."External Lot No." := TempEntrySummary."Mfg. Lot No.";

            LotEntry."Expiration Date" := TempEntrySummary."Expiration Date";

            //<< istrtt 01-11-05 9488

            IF ((CurrentSignFactor < 0) AND SearchForSupply) THEN
                LotEntry.VALIDATE(Quantity,

                  MinValueAbs(TempEntrySummary."Total Available Quantity", MaxQuantity))

            ELSE
                LotEntry.VALIDATE(Quantity,

                  MinValueAbs(-TempEntrySummary."Total Available Quantity", MaxQuantity));

        END;
    END;

    LOCAL PROCEDURE MinValueAbs(Value1: Decimal; Value2: Decimal): Decimal;
    BEGIN

        IF ABS(Value1) < ABS(Value2) THEN
            EXIT(Value1)

        ELSE
            EXIT(Value2);

    END;
}

