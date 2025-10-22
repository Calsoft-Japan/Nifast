page 50066 "Lot Reclass Screen"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade
    // >>IST
    // Date   Init GranID SCRID  Description
    //                           Properties Modified:
    //                           Fields Added:
    //                           Fields Modified:
    //                           Globals Added:
    //                           Globals Modified:
    //                           TextConstant Added:
    //                           TextConstant Modified:
    //                           Functions Added:
    //                           Functions Modified:
    // 032309 CCL $12797 #12797    PrintLabel()
    //                           Keys Added:
    //                           Keys Modified:
    //                           Other:
    // <<IST
    // NIF1.01,10/11/21,ST: Enhancements for provision to user to select Applies to Entry when posting reclass. journal.
    //                       - Added code in "Transfer - OnAction()".
    //                       - Added Global Text Constants.
    //                       - Added code in "ShowItemLedgLines()". Code Commented in "OnOpenPage()".
    // 

    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;

    layout
    {
        area(content)
        {
            field(OrderNo; OrderNo)
            {
                Caption = 'Purchase Order No.';
                ToolTip = 'Specifies the value of the Purchase Order No. field.';

                trigger OnValidate()
                begin
                    OrderNoOnAfterValidate();
                end;
            }
            field(VendorName; VendorName)
            {
                Caption = 'Vendor Name';
                Editable = false;
                ToolTip = 'Specifies the value of the Vendor Name field.';
            }
            field(ItemNo; ItemNo)
            {
                Caption = 'Item No.';
                TableRelation = Item;
                ToolTip = 'Specifies the value of the Item No. field.';

                trigger OnLookup(var Text: Text): Boolean
                var
                    Item: Record Item;
                begin
                    IF (FromLocationBinEnabled() AND (OrderNo <> '')) THEN
                        ShowBinContentLines()
                    ELSE
                        IF ((NOT FromLocationBinEnabled()) AND (OrderNo <> '')) THEN
                            ShowItemLedgLines()
                        ELSE
                            IF PAGE.RUNMODAL(0, Item) = ACTION::LookupOK THEN
                                ItemNo := Item."No.";
                end;
            }
            field(FromLocation; FromLocation)
            {
                Caption = 'From Location';
                TableRelation = Location;
                ToolTip = 'Specifies the value of the From Location field.';

                trigger OnValidate()
                begin
                    FromLocationOnAfterValidate();
                end;
            }
            field(FromBin; FromBin)
            {
                Caption = 'From Bin Code';
                Editable = false;
                Visible = FromBinVisible;
                ToolTip = 'Specifies the value of the From Bin Code field.';

                trigger OnLookup(var Text: Text): Boolean
                var
                    Bin: Record Bin;
                begin
                    IF FromLocation <> '' THEN BEGIN
                        Bin.SETRANGE("Location Code", FromLocation);
                        IF PAGE.RUNMODAL(0, Bin) = ACTION::LookupOK THEN
                            FromBin := Bin.Code;
                    END;
                end;
            }
            field(ToLocation; ToLocation)
            {
                Caption = 'To Location';
                TableRelation = Location;
                ToolTip = 'Specifies the value of the To Location field.';

                trigger OnValidate()
                begin
                    ToLocationOnAfterValidate();
                end;
            }
            field(ToBin; ToBin)
            {
                Caption = 'To Bin Code';
                ToolTip = 'Specifies the value of the To Bin Code field.';

                trigger OnLookup(var Text: Text): Boolean
                var
                    Bin: Record Bin;
                begin
                    IF ToLocation <> '' THEN BEGIN
                        Bin.SETRANGE("Location Code", ToLocation);
                        IF PAGE.RUNMODAL(0, Bin) = ACTION::LookupOK THEN
                            ToBin := Bin.Code;
                    END;
                end;
            }
            field(FromLot; FromLot)
            {
                Caption = 'From Lot No.';
                Editable = false;
                ToolTip = 'Specifies the value of the From Lot No. field.';
            }
            field(MfgLotNo; MfgLotNo)
            {
                Caption = 'Mfg. Lot No.';
                ToolTip = 'Specifies the value of the Mfg. Lot No. field.';
            }
            field("Applies To Entry No."; AppliesToEntryNo)
            {
                BlankZero = true;
                ToolTip = 'Specifies the value of the AppliesToEntryNo field.';
                Caption = 'AppliesToEntryNo';

                trigger OnLookup(var Text: Text): Boolean
                begin
                    LookupAppliesToEntryNo(); //NIF1.01
                end;
            }
            field(Qty; Qty)
            {
                Caption = 'Quantity';
                DecimalPlaces = 0 : 2;
                ToolTip = 'Specifies the value of the Quantity field.';
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Print Label")
            {
                Caption = '&Print Label';
                Promoted = true;
                Image = Print;
                PromotedOnly = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the &Print Label action.';

                trigger OnAction()
                begin
                    PrintLabel();
                end;
            }
            action("&Transfer")
            {
                Caption = '&Transfer';
                Promoted = true;
                Image = TransferOrder;
                PromotedCategory = Process;
                ToolTip = 'Executes the &Transfer action.';

                trigger OnAction()
                begin
                    //NIF1.01 Start
                    IF AppliesToEntryNo = 0 THEN
                        ERROR(AppliesToEntryCannotBeEmptyMsg);
                    NVM.SetAppliesToEntryNo(AppliesToEntryNo);
                    //NIF1.01 End

                    IF NOT NVM.CreateMovementReclass(ItemNo, ToLot, ToLocation, ToBin, FromLot, FromLocation, FromBin, MfgLotNo, USERID, Qty, ErrorMsg) THEN
                        MESSAGE('%1', ErrorMsg)
                    ELSE BEGIN
                        MESSAGE('New Lot %1 assigned.', ToLot);
                        ToLot := '';
                    END;

                    FromLot := '';
                    FromBin := '';
                    Qty := 0;
                    MfgLotNo := '';
                    ItemNo := '';
                    AppliesToEntryNo := 0; //NIF1.01
                end;
            }
            action("&List")
            {
                Caption = '&List';
                Promoted = true;
                Image = List;
                PromotedCategory = Process;
                ToolTip = 'Executes the &List action.';

                trigger OnAction()
                begin
                    IF (FromLocationBinEnabled() AND (OrderNo <> '')) THEN
                        ShowBinContentLines()
                    ELSE
                        IF ((NOT FromLocationBinEnabled()) AND (OrderNo <> '')) THEN
                            ShowItemLedgLines()
                        ELSE
                            IF (FromLocationBinEnabled() AND (OrderNo = '')) THEN
                                ShowBinContentLines2()
                            ELSE
                                IF ((NOT FromLocationBinEnabled()) AND (OrderNo = '')) THEN
                                    ShowItemLedgLines2()
                end;
            }
        }
    }

    trigger OnInit()
    begin
        FromBinVisible := TRUE;
    end;

    trigger OnOpenPage()
    begin
        //FromBinVisible := FALSE;  //NIF1.01
    end;

    var
        Location: Record Location;
        PurchRcptHdrGRec: Record "Purch. Rcpt. Header";
        NVM: Codeunit "NewVision Management_New";
        FromBinVisible: Boolean;
        FromBin: Code[10];
        FromLocation: Code[10];
        ToBin: Code[10];
        ToLocation: Code[10];
        FromLot: Code[20];
        ItemNo: Code[20];
        OrderNo: Code[20];
        ToLot: Code[20];
        Qty: Decimal;
        AppliesToEntryNo: Integer;
        AppliesToEntryCannotBeEmptyMsg: Label 'Applies to Entry No. cannot be empty.';
        ErrorMsg: Text[30];
        MfgLotNo: Text[30];
        VendorName: Text[50];

    procedure ShowItemLedgLines()
    var
        ItemEntryRelation: Record "Item Entry Relation";
        ItemLedgEntry: Record "Item Ledger Entry";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        Counter: Integer;
        FilterString: Text[1024];
    begin
        //read purch. rcpts into a filter string
        PurchRcptHdrGRec.SETCURRENTKEY("Order No.");
        PurchRcptHdrGRec.SETRANGE("Order No.", OrderNo);
        IF NOT PurchRcptHdrGRec.FIND('-') THEN BEGIN
            MESSAGE('No lines found.');
            EXIT;
        END;

        CLEAR(FilterString);
        CLEAR(Counter);

        REPEAT
            IF (FilterString <> '') THEN
                FilterString := FilterString + '|';
            FilterString := FilterString + PurchRcptHdrGRec."No.";
            Counter := Counter + 1;
        UNTIL PurchRcptHdrGRec.NEXT() = 0;

        //filter on item entry relation line for the receipts
        ItemEntryRelation.SETCURRENTKEY("Source ID", "Source Type", "Source Subtype", "Source Ref. No.");
        IF Counter > 1 THEN
            ItemEntryRelation.SETFILTER("Source ID", FilterString)
        ELSE
            ItemEntryRelation.SETRANGE("Source ID", FilterString);
        ItemEntryRelation.SETRANGE("Source Type", DATABASE::"Purch. Rcpt. Line");

        IF NOT ItemEntryRelation.FIND('-') THEN BEGIN
            MESSAGE('No Receipt Lines found.');
            EXIT;
        END;

        REPEAT
            PurchRcptLine.GET(ItemEntryRelation."Source ID", ItemEntryRelation."Source Ref. No.");
            ItemLedgEntry.SETCURRENTKEY(
                "Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date", "Expiration Date", "Lot No.");
            ItemLedgEntry.SETRANGE("Item No.", PurchRcptLine."No.");
            ItemLedgEntry.SETRANGE(Open, TRUE);
            ItemLedgEntry.SETRANGE(Positive, TRUE);
            ItemLedgEntry.SETRANGE("Location Code", FromLocation);
            ItemLedgEntry.SETRANGE("Lot No.", ItemEntryRelation."Lot No.");
            IF ItemLedgEntry.FIND('-') THEN
                REPEAT
                    ItemLedgEntry.MARK(TRUE);
                UNTIL ItemLedgEntry.NEXT() = 0;
        UNTIL ItemEntryRelation.NEXT() = 0;

        /*
        ItemLedgEntry.SETCURRENTKEY("Document No.");
        IF Counter>1 THEN
          ItemLedgEntry.SETFILTER("Document No.",FilterString)
        ELSE
          ItemLedgEntry.SETRANGE("Document No.",FilterString);
        ItemLedgEntry.SETRANGE("Location Code",FromLocation);
        ItemLedgEntry.SETRANGE(Open,TRUE);
        */
        ItemLedgEntry.SETCURRENTKEY("Entry No.");
        ItemLedgEntry.SETRANGE("Item No.");
        ItemLedgEntry.SETRANGE("Lot No.");
        ItemLedgEntry.MARKEDONLY(TRUE);

        IF PAGE.RUNMODAL(PAGE::"Item Ledger Entries - Reclass", ItemLedgEntry) = ACTION::LookupOK THEN BEGIN
            FromLot := ItemLedgEntry."Lot No.";
            ItemNo := ItemLedgEntry."Item No.";
            Qty := ItemLedgEntry."Remaining Quantity";
            AppliesToEntryNo := ItemLedgEntry."Entry No."; //NIF1.01
        END;

    end;

    procedure ShowBinContentLines()
    var
        ItemEntryRelation: Record "Item Entry Relation";
        ItemLedgEntry: Record "Item Ledger Entry";
        TempLotBinContent: Record "Lot Bin Content" temporary;
        TempLotBinContentSub: Record "Lot Bin Content" temporary;
        TempLotInfo: Record "Lot No. Information" temporary;
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        LookupFromBin: Code[10];
        LookupFromLotNo: Code[20];
        LookupItemNo: Code[20];
        LookupQty: Decimal;
        Counter: Integer;
        FilterString: Text[1024];
    begin
        //read purch. rcpts into a filter string
        PurchRcptHdr.RESET();
        PurchRcptHdr.SETCURRENTKEY("Order No.");
        PurchRcptHdr.SETRANGE("Order No.", OrderNo);
        IF NOT PurchRcptHdr.FIND('-') THEN BEGIN
            MESSAGE('No lines found.');
            EXIT;
        END;

        CLEAR(FilterString);
        CLEAR(Counter);

        REPEAT
            IF (FilterString <> '') THEN
                FilterString := FilterString + '|';
            FilterString := FilterString + PurchRcptHdr."No.";
            Counter := Counter + 1;
        UNTIL PurchRcptHdr.NEXT() = 0;

        //filter on item entry relation line for the receipts
        ItemEntryRelation.SETCURRENTKEY("Source ID", "Source Type", "Source Subtype", "Source Ref. No.");
        IF Counter > 1 THEN
            ItemEntryRelation.SETFILTER("Source ID", FilterString)
        ELSE
            ItemEntryRelation.SETRANGE("Source ID", FilterString);
        ItemEntryRelation.SETRANGE("Source Type", DATABASE::"Purch. Rcpt. Line");


        IF NOT ItemEntryRelation.FIND('-') THEN BEGIN
            MESSAGE('No Receipt Lines found.');
            EXIT;
        END;


        ItemLedgEntry.RESET();
        REPEAT
            PurchRcptLine.GET(ItemEntryRelation."Source ID", ItemEntryRelation."Source Ref. No.");
            ItemLedgEntry.SETCURRENTKEY(
                "Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date", "Expiration Date", "Lot No.");
            ItemLedgEntry.SETRANGE("Item No.", PurchRcptLine."No.");
            ItemLedgEntry.SETRANGE(Open, TRUE);
            ItemLedgEntry.SETRANGE(Positive, TRUE);
            ItemLedgEntry.SETRANGE("Location Code", FromLocation);
            ItemLedgEntry.SETRANGE("Lot No.", ItemEntryRelation."Lot No.");
            IF ItemLedgEntry.FIND('-') THEN
                REPEAT
                    ItemLedgEntry.MARK(TRUE);
                UNTIL ItemLedgEntry.NEXT() = 0;
        UNTIL ItemEntryRelation.NEXT() = 0;


        /*
        ItemLedgEntry.SETCURRENTKEY("Document No.");
        IF Counter>1 THEN
          ItemLedgEntry.SETFILTER("Document No.",FilterString)
        ELSE
          ItemLedgEntry.SETRANGE("Document No.",FilterString);
        ItemLedgEntry.SETRANGE("Location Code",FromLocation);
        ItemLedgEntry.SETRANGE(Open,TRUE);
        */
        ItemLedgEntry.SETCURRENTKEY("Entry No.");
        ItemLedgEntry.SETRANGE("Item No.");
        ItemLedgEntry.SETRANGE("Lot No.");
        ItemLedgEntry.MARKEDONLY(TRUE);


        //build a temp lot table to store lots in prep for bin contents
        IF NOT ItemLedgEntry.FIND('-') THEN BEGIN
            MESSAGE('No lots found.');
            EXIT;
        END;

        TempLotInfo.DELETEALL();
        REPEAT
            TempLotInfo.INIT();
            TempLotInfo."Item No." := ItemLedgEntry."Item No.";
            TempLotInfo."Lot No." := ItemLedgEntry."Lot No.";
            IF NOT TempLotInfo.INSERT() THEN;
        UNTIL ItemLedgEntry.NEXT() = 0;

        //now get lot bin content, and store in Total Lot Bin Content
        TempLotInfo.FIND('-');
        REPEAT
            GetLotBinContents(TempLotInfo, FromLocation, TempLotBinContentSub);
            IF TempLotBinContentSub.FIND('-') THEN
                REPEAT
                    TempLotBinContent.TRANSFERFIELDS(TempLotBinContentSub);
                    IF TempLotBinContent."Item No." <> '' THEN
                        IF NOT TempLotBinContent.INSERT() THEN;
                UNTIL TempLotBinContentSub.NEXT() = 0;
        UNTIL TempLotInfo.NEXT() = 0;


        //now call selection
        IF ItemTrackingMgt.LotBinContentLookupBin3(TempLotBinContent, LookupFromBin, LookupItemNo, LookupFromLotNo, LookupQty) THEN BEGIN
            FromBin := LookupFromBin;
            ItemNo := LookupItemNo;
            FromLot := LookupFromLotNo;
            Qty := LookupQty;
        END;

    end;

    procedure FromLocationBinEnabled(): Boolean
    begin
        IF NOT Location.GET(FromLocation) THEN
            CLEAR(Location);

        EXIT(Location."Bin Mandatory");
    end;

    procedure GetLotBinContents(var LotNoInfo: Record "Lot No. Information"; LocationCode: Code[10]; var TempLotBinContent: Record "Lot Bin Content" temporary)
    var
        WhseEntry: Record "Warehouse Entry";
    begin
        TempLotBinContent.DELETEALL();

        //loop through whse. entry
        WhseEntry.SETCURRENTKEY("Item No.", Open, Positive, "Location Code", "Zone Code",
                                  "Bin Code", "Serial No.", "Lot No.", "Expiration Date", "Posting Date");

        WhseEntry.SETRANGE("Item No.", LotNoInfo."Item No.");
        WhseEntry.SETRANGE(Open, TRUE);
        WhseEntry.SETRANGE("Location Code", LocationCode);
        WhseEntry.SETRANGE("Lot No.", LotNoInfo."Lot No.");
        REPEAT
            WITH TempLotBinContent DO BEGIN
                //get Lot Info record if exists
                IF NOT LotNoInfo.GET(WhseEntry."Item No.", WhseEntry."Variant Code", WhseEntry."Lot No.") THEN
                    CLEAR(LotNoInfo);

                IF NOT TempLotBinContent.GET(WhseEntry."Location Code", WhseEntry."Bin Code", WhseEntry."Item No.",
                     WhseEntry."Variant Code", WhseEntry."Unit of Measure Code", WhseEntry."Lot No.") THEN BEGIN
                    "Location Code" := WhseEntry."Location Code";
                    "Bin Code" := WhseEntry."Bin Code";
                    "Item No." := WhseEntry."Item No.";
                    "Variant Code" := WhseEntry."Variant Code";
                    "Unit of Measure Code" := WhseEntry."Unit of Measure Code";
                    "Lot No." := WhseEntry."Lot No.";
                    "Zone Code" := WhseEntry."Zone Code";
                    "Bin Type Code" := WhseEntry."Bin Type Code";
                    //"Expiration Date" := LotNoInfo."Expiration Date";
                    "Creation Date" := LotNoInfo."Lot Creation Date";
                    "External Lot No." := LotNoInfo."Mfg. Lot No.";
                    "Qty. per Unit of Measure" := WhseEntry."Qty. per Unit of Measure";
                    //get bin fields
                    //"Warehouse Class Code" := Rec."Warehouse Class Code";
                    //"Bin Ranking" := Rec."Bin Ranking";
                    //"Cross-Dock Bin" := Rec."Cross-Dock Bin";
                    //Default := Rec.Default;
                    //IF BinContent.GET("Location Code","Bin Code","Item No.","Variant Code","Unit of Measure Code") THEN
                    //   "Block Movement" := BinContent."Block Movement"
                    // ELSE
                    //  "Block Movement"  := Rec."Block Movement";
                    INSERT();
                END;
            END;
        UNTIL WhseEntry.NEXT() = 0;
    end;

    procedure PrintLabel()
    var
        Receive: Record "LAX Receive";
        ReceiveLine: Record "LAX Receive Line";
        Item: Record Item;
        LabelMgt: Codeunit "Label Mgmt NIF";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UseReceiveNo: Code[20];
    begin
        IF ItemNo = '' THEN BEGIN
            MESSAGE('You must specify Item No.');
            EXIT;
        END;

        IF OrderNo = '' THEN BEGIN
            MESSAGE('You must specify a Purchase Order No.');
            EXIT;
        END;

        IF Qty = 0 THEN BEGIN
            MESSAGE('You must specific a Quantity');
            EXIT;
        END;

        Item.GET(ItemNo);
        IF ToLot = '' THEN
            ToLot := NoSeriesMgt.GetNextNo(Item."Lot Nos.", TODAY, TRUE);


        UseReceiveNo := USERID + 'RCLS';
        IF Receive.GET(UseReceiveNo) THEN
            Receive.DELETE(TRUE);

        Receive.INIT();
        Receive."No." := UseReceiveNo;
        //>>IST 032309 CCL $12797 #12797
        //Receive."Purchase Order No." := OrderNo;
        Receive."Source ID" := OrderNo;
        //<<IST 032309 CCL $12797 #12797
        Receive.INSERT();

        ReceiveLine.INIT();
        ReceiveLine."Receive No." := Receive."No.";
        ReceiveLine.Type := ReceiveLine.Type::Item;
        ReceiveLine."No." := ItemNo;
        ReceiveLine.Description := Item.Description;
        ReceiveLine.Quantity := Qty;
        ReceiveLine."Quantity (Base)" := Qty;
        ReceiveLine."Lot No." := ToLot;
        //>>IST 032309 CCL $12797 #12797
        //ReceiveLine."Purchase Order No." := OrderNo;
        ReceiveLine."Source ID" := OrderNo;
        //<<IST 032309 CCL $12797 #12797
        ReceiveLine."Mfg. Lot No." := MfgLotNo;
        ReceiveLine.INSERT();

        LabelMgt.PromptReceiveLineLabel(ReceiveLine, Qty, Qty, TRUE);

        Receive.DELETE(TRUE);
    end;

    procedure ShowItemLedgLines2()
    var
        ItemLedgEntry: Record "Item Ledger Entry";
    begin
        IF (ItemNo = '') AND (OrderNo = '') THEN BEGIN
            MESSAGE('You must enter an Item or an Order Number.');
            EXIT;
        END;

        ItemLedgEntry.SETCURRENTKEY(
            "Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date", "Expiration Date", "Lot No.");
        ItemLedgEntry.SETRANGE("Item No.", ItemNo);
        ItemLedgEntry.SETRANGE(Open, TRUE);
        ItemLedgEntry.SETRANGE(Positive, TRUE);
        ItemLedgEntry.SETRANGE("Location Code", FromLocation);
        IF ItemLedgEntry.FIND('-') THEN
            REPEAT
                ItemLedgEntry.MARK(TRUE);
            UNTIL ItemLedgEntry.NEXT() = 0;

        ItemLedgEntry.SETCURRENTKEY("Entry No.");
        ItemLedgEntry.SETRANGE("Item No.");
        ItemLedgEntry.SETRANGE("Lot No.");
        ItemLedgEntry.MARKEDONLY(TRUE);

        IF PAGE.RUNMODAL(PAGE::"Item Ledger Entries - Reclass", ItemLedgEntry) = ACTION::LookupOK THEN BEGIN
            FromLot := ItemLedgEntry."Lot No.";
            ItemNo := ItemLedgEntry."Item No.";
            Qty := ItemLedgEntry."Remaining Quantity";
        END;
    end;

    procedure ShowBinContentLines2()
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        TempLotBinContent: Record "Lot Bin Content" temporary;
        TempLotBinContentSub: Record "Lot Bin Content" temporary;
        TempLotInfo: Record "Lot No. Information" temporary;
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        LookupFromBin: Code[10];
        LookupFromLotNo: Code[20];
        LookupItemNo: Code[20];
        LookupQty: Decimal;
    begin
        IF (ItemNo = '') AND (OrderNo = '') THEN BEGIN
            MESSAGE('You must enter an Item or an Order Number.');
            EXIT;
        END;

        ItemLedgEntry.RESET();
        ItemLedgEntry.SETCURRENTKEY(
            "Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date", "Expiration Date", "Lot No.");
        ItemLedgEntry.SETRANGE("Item No.", ItemNo);
        ItemLedgEntry.SETRANGE(Open, TRUE);
        ItemLedgEntry.SETRANGE(Positive, TRUE);
        ItemLedgEntry.SETRANGE("Location Code", FromLocation);
        IF ItemLedgEntry.FIND('-') THEN
            REPEAT
                ItemLedgEntry.MARK(TRUE);
            UNTIL ItemLedgEntry.NEXT() = 0;

        ItemLedgEntry.SETCURRENTKEY("Entry No.");
        ItemLedgEntry.SETRANGE("Item No.");
        ItemLedgEntry.SETRANGE("Lot No.");
        ItemLedgEntry.MARKEDONLY(TRUE);


        //build a temp lot table to store lots in prep for bin contents
        IF NOT ItemLedgEntry.FIND('-') THEN BEGIN
            MESSAGE('No lots found.');
            EXIT;
        END;

        TempLotInfo.DELETEALL();
        REPEAT
            TempLotInfo.INIT();
            TempLotInfo."Item No." := ItemLedgEntry."Item No.";
            TempLotInfo."Lot No." := ItemLedgEntry."Lot No.";
            IF NOT TempLotInfo.INSERT() THEN;
        UNTIL ItemLedgEntry.NEXT() = 0;

        //now get lot bin content, and store in Total Lot Bin Content
        TempLotInfo.FIND('-');
        REPEAT
            GetLotBinContents(TempLotInfo, FromLocation, TempLotBinContentSub);
            IF TempLotBinContentSub.FIND('-') THEN
                REPEAT
                    TempLotBinContent.TRANSFERFIELDS(TempLotBinContentSub);
                    IF TempLotBinContent."Item No." <> '' THEN
                        IF NOT TempLotBinContent.INSERT() THEN;
                UNTIL TempLotBinContentSub.NEXT() = 0;
        UNTIL TempLotInfo.NEXT() = 0;


        //now call selection
        IF ItemTrackingMgt.LotBinContentLookupBin3(TempLotBinContent, LookupFromBin, LookupItemNo, LookupFromLotNo, LookupQty) THEN BEGIN
            FromBin := LookupFromBin;
            ItemNo := LookupItemNo;
            FromLot := LookupFromLotNo;
            Qty := LookupQty;
        END;
    end;

    local procedure OrderNoOnAfterValidate()
    begin
        IF OrderNo <> '' THEN BEGIN
            PurchRcptHdrGRec.RESET();
            PurchRcptHdrGRec.SETCURRENTKEY("Order No.");
            PurchRcptHdrGRec.SETRANGE("Order No.", OrderNo);
            IF NOT PurchRcptHdrGRec.FIND('-') THEN
                CLEAR(PurchRcptHdrGRec);
            FromLocation := PurchRcptHdrGRec."Location Code";
            VendorName := PurchRcptHdrGRec."Buy-from Vendor Name";
        END
        ELSE BEGIN
            FromLocation := '';
            VendorName := '';
        END;

        FromBinVisible := FromLocationBinEnabled();
    end;

    local procedure FromLocationOnAfterValidate()
    begin
        FromBinVisible := FromLocationBinEnabled();
    end;

    local procedure ToLocationOnAfterValidate()
    begin
        IF NOT Location.GET(ToLocation) THEN
            CLEAR(Location);
        ToBin := Location."Receipt Bin Code";
    end;

    /*   local procedure "---NIF1.01---"()
      begin
      end;
   */
    procedure LookupAppliesToEntryNo()
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        TempItemLedgerEntry: Record "Item Ledger Entry" temporary;
        PurchRcptHeader: Record "Purch. Rcpt. Header";
    begin
        //NIF1.01 Start
        IF OrderNo <> '' THEN BEGIN
            PurchRcptHeader.RESET();
            PurchRcptHeader.SETRANGE("Order No.", OrderNo);
            IF PurchRcptHeader.FINDSET() THEN
                REPEAT
                    ItemLedgerEntry.RESET();
                    ItemLedgerEntry.SETCURRENTKEY("Document No.", "Item No.", "Entry Type", "Entry No.");
                    ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                    ItemLedgerEntry.SETRANGE("Document Type", ItemLedgerEntry."Document Type"::"Purchase Receipt");
                    ItemLedgerEntry.SETRANGE("Document No.", PurchRcptHeader."No.");
                    ItemLedgerEntry.SETFILTER("Remaining Quantity", '<>%1', 0);
                    ItemLedgerEntry.SETRANGE(Positive, TRUE);
                    ItemLedgerEntry.SETRANGE("Item No.", ItemNo);
                    IF ItemLedgerEntry.FINDSET() THEN
                        REPEAT
                            TempItemLedgerEntry.INIT();
                            TempItemLedgerEntry.TRANSFERFIELDS(ItemLedgerEntry);
                            TempItemLedgerEntry.INSERT();
                        UNTIL ItemLedgerEntry.NEXT() = 0;
                UNTIL PurchRcptHeader.NEXT() = 0;
        END ELSE BEGIN
            ItemLedgerEntry.RESET();
            ItemLedgerEntry.SETCURRENTKEY("Item No.", Open, "Variant Code", "Location Code", "Item Tracking", "Lot No.", "Serial No.");
            ItemLedgerEntry.SETRANGE("Item No.", ItemNo);
            ItemLedgerEntry.SETRANGE("Location Code", FromLocation);
            ItemLedgerEntry.SETRANGE("Lot No.", FromLot);
            ItemLedgerEntry.SETFILTER("Remaining Quantity", '<>%1', 0);
            ItemLedgerEntry.SETRANGE(Positive, TRUE);
            IF ItemLedgerEntry.FINDSET() THEN
                REPEAT
                    TempItemLedgerEntry.INIT();
                    TempItemLedgerEntry.TRANSFERFIELDS(ItemLedgerEntry);
                    TempItemLedgerEntry.INSERT();
                UNTIL ItemLedgerEntry.NEXT() = 0;
        END;

        IF PAGE.RUNMODAL(0, TempItemLedgerEntry) = ACTION::LookupOK THEN
            AppliesToEntryNo := TempItemLedgerEntry."Entry No.";
        //NIF1.01 End
    end;
}

