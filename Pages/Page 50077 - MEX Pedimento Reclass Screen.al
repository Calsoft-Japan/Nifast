page 50077 "MEX Pedimento Reclass Screen"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    PageType = Card;

    layout
    {
        area(content)
        {
            field(ItemNo;ItemNo)
            {
                Caption = 'Item No.';
                TableRelation = Item;

                trigger OnLookup(var Text: Text): Boolean
                var
                    Item: Record "27";
                begin
                    IF (FromLocationBinEnabled AND (OrderNo<>'')) THEN
                      ShowBinContentLines
                    ELSE IF ((NOT FromLocationBinEnabled) AND (OrderNo<>'')) THEN
                      ShowItemLedgLines
                    ELSE IF PAGE.RUNMODAL(0,Item)=ACTION::LookupOK THEN
                      ItemNo := Item."No.";
                end;
            }
            field(FromLot;FromLot)
            {
                Caption = 'From Lot No.';
                Editable = false;

                trigger OnLookup(var Text: Text): Boolean
                var
                    Bin: Record "7354";
                begin
                    IF (FromLocationBinEnabled AND (OrderNo<>'')) THEN
                      ShowBinContentLines
                    ELSE IF ((NOT FromLocationBinEnabled) AND (OrderNo<>'')) THEN
                      ShowItemLedgLines
                    ELSE IF (FromLocationBinEnabled AND (OrderNo='')) THEN
                      ShowBinContentLines2
                    ELSE IF ((NOT FromLocationBinEnabled) AND (OrderNo='')) THEN
                      ShowItemLedgLines2
                end;
            }
            field(MfgLotNo;MfgLotNo)
            {
                Caption = 'Mfg. Lot No.';
                Editable = false;
            }
            field(Qty;Qty)
            {
                Caption = 'Quantity';
                DecimalPlaces = 0:2;
            }
            group(Detail)
            {
                Caption = 'Detail';
                group(From)
                {
                    Caption = 'From';
                    field(FromLocation;FromLocation)
                    {
                        Caption = 'Location Code';
                        Editable = false;
                        TableRelation = Location;

                        trigger OnValidate()
                        begin
                            FromLocationOnAfterValidate;
                        end;
                    }
                    field(FromBin;FromBin)
                    {
                        Caption = 'Bin Code';
                        Editable = false;
                        Visible = FromBinVisible;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            Bin: Record "7354";
                        begin
                            IF FromLocation<>'' THEN
                              BEGIN
                                Bin.SETRANGE("Location Code",FromLocation);
                                IF PAGE.RUNMODAL(0,Bin)=ACTION::LookupOK THEN
                                  FromBin := Bin.Code;
                              END;
                        end;
                    }
                    field(FromCVEPedimento;FromCVEPedimento)
                    {
                        Caption = 'CVE Pedimento';
                        Editable = false;
                    }
                    field(FromPatenteOrig;FromPatenteOrig)
                    {
                        Caption = 'Patente Original';
                        Editable = false;
                    }
                    field(FromAuduanaES;FromAuduanaES)
                    {
                        Caption = 'Aduana E/S';
                        Editable = false;
                    }
                    field(FromPedimentNo;FromPedimentNo)
                    {
                        Caption = 'Pediment No.';
                        Editable = false;
                    }
                }
                group(To)
                {
                    Caption = 'To';
                    field(ToLocation;ToLocation)
                    {
                        Caption = 'To Location';
                        Editable = false;
                        TableRelation = Location;

                        trigger OnValidate()
                        begin
                            ToLocationOnAfterValidate;
                        end;
                    }
                    field(ToBin;ToBin)
                    {
                        Caption = 'To Bin Code';

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            Bin: Record "7354";
                        begin
                            IF ToLocation<>'' THEN
                              BEGIN
                                Bin.SETRANGE("Location Code",ToLocation);
                                IF PAGE.RUNMODAL(0,Bin)=ACTION::LookupOK THEN
                                  ToBin := Bin.Code;
                              END;
                        end;
                    }
                    field(ToCVEPedimento;ToCVEPedimento)
                    {
                        Caption = 'To CVE Pedimento';
                        TableRelation = "CVE Pedimento";
                    }
                    field(ToPatenteOrig;ToPatenteOrig)
                    {
                        Caption = 'To Patente Original';
                    }
                    field(ToAuduanaES;ToAuduanaES)
                    {
                        Caption = 'To Aduana E/S';
                        Editable = true;
                    }
                    field(ToPedimentNo;ToPedimentNo)
                    {
                        Caption = 'To Pediment No.';
                    }
                }
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
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    PrintLabel;
                end;
            }
            action("&Transfer")
            {
                Caption = '&Transfer';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    IF ToPatenteOrig='' THEN
                      ERROR('You must enter Patente Original');
                    IF ToAuduanaES='' THEN
                      ERROR('You must enter Aduana E/S');
                    IF ToPedimentNo='' THEN
                      ERROR('You must enter Pediment No.');
                    IF ToCVEPedimento='' THEN
                      ERROR('You must enter CVE Pedimento');

                    NVM.SetPedimentoInfo(ToPatenteOrig,ToAuduanaES,ToPedimentNo,ToCVEPedimento);
                    IF NOT NVM.CreateMovementReclass(ItemNo,ToLot,ToLocation,ToBin,FromLot,FromLocation,FromBin,MfgLotNo,USERID,Qty,ErrorMsg) THEN
                      MESSAGE('%1',ErrorMsg)
                    ELSE
                      BEGIN
                        MESSAGE('New Lot %1 assigned.',ToLot);
                        ToLot := '';
                      END;

                    FromLot := '';
                    FromPatenteOrig := '';
                    FromAuduanaES := '';
                    FromPedimentNo := '';
                    FromCVEPedimento := '';

                    ToPatenteOrig := '';
                    ToAuduanaES := '';
                    ToPedimentNo := '';
                    ToCVEPedimento := '';

                    FromBin := '';
                    Qty := 0;
                    MfgLotNo :='';
                    ItemNo := '';
                end;
            }
            action("&List")
            {
                Caption = '&List';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    IF (FromLocationBinEnabled AND (OrderNo<>'')) THEN
                      ShowBinContentLines
                    ELSE IF ((NOT FromLocationBinEnabled) AND (OrderNo<>'')) THEN
                      ShowItemLedgLines
                    ELSE IF (FromLocationBinEnabled AND (OrderNo='')) THEN
                      ShowBinContentLines2
                    ELSE IF ((NOT FromLocationBinEnabled) AND (OrderNo='')) THEN
                      ShowItemLedgLines2
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
        FromLocation := 'MEX';
        ToLocation := 'MEX';
    end;

    var
        OrderNo: Code[20];
        ItemNo: Code[20];
        MfgLotNo: Text[30];
        Qty: Decimal;
        ToBin: Code[10];
        FromLocation: Code[10];
        ToLocation: Code[10];
        FromLot: Code[20];
        FromBin: Code[10];
        Location: Record "14";
        PurchRcptHdr: Record "120";
        NVM: Codeunit "50021";
        ToLot: Code[20];
        ErrorMsg: Text[30];
        VendorName: Text[50];
        FromPatenteOrig: Code[10];
        FromAuduanaES: Code[10];
        FromPedimentNo: Code[10];
        FromCVEPedimento: Code[10];
        ToPatenteOrig: Code[10];
        ToAuduanaES: Code[10];
        ToPedimentNo: Code[10];
        ToCVEPedimento: Code[10];
        [InDataSet]
        FromBinVisible: Boolean;
        Text19078561: Label 'From';
        Text19015238: Label 'To';

    procedure ShowItemLedgLines()
    var
        ItemLedgEntry: Record "32";
        FilterString: Text[1024];
        Counter: Integer;
        ItemEntryRelation: Record "6507";
        PurchRcptLine: Record "121";
    begin
        //read purch. rcpts into a filter string
        PurchRcptHdr.SETCURRENTKEY("Order No.");
        PurchRcptHdr.SETRANGE("Order No.",OrderNo);
        IF NOT PurchRcptHdr.FIND('-') THEN
          BEGIN
            MESSAGE('No lines found.');
            EXIT;
          END;
        
        CLEAR(FilterString);
        CLEAR(Counter);
        
        REPEAT
          IF (FilterString<>'') THEN
            FilterString := FilterString + '|';
          FilterString := FilterString + PurchRcptHdr."No.";
          Counter := Counter + 1;
        UNTIL PurchRcptHdr.NEXT=0;
        
        //filter on item entry relation line for the receipts
        ItemEntryRelation.SETCURRENTKEY("Source ID","Source Type","Source Subtype","Source Ref. No.");
        IF Counter>1 THEN
          ItemEntryRelation.SETFILTER("Source ID",FilterString)
        ELSE
          ItemEntryRelation.SETRANGE("Source ID",FilterString);
        ItemEntryRelation.SETRANGE("Source Type",DATABASE::"Purch. Rcpt. Line");
        
        IF NOT ItemEntryRelation.FIND('-') THEN
          BEGIN
            MESSAGE('No Receipt Lines found.');
            EXIT;
          END;
        
        REPEAT
          PurchRcptLine.GET(ItemEntryRelation."Source ID",ItemEntryRelation."Source Ref. No.");
          ItemLedgEntry.SETCURRENTKEY(
              "Item No.","Variant Code",Open,Positive,"Location Code","Posting Date","Expiration Date","Lot No.");
          ItemLedgEntry.SETRANGE("Item No.",PurchRcptLine."No.");
          ItemLedgEntry.SETRANGE(Open,TRUE);
          ItemLedgEntry.SETRANGE(Positive,TRUE);
          ItemLedgEntry.SETRANGE("Location Code",FromLocation);
          ItemLedgEntry.SETRANGE("Lot No.",ItemEntryRelation."Lot No.");
          IF ItemLedgEntry.FIND('-') THEN
            REPEAT
              ItemLedgEntry.MARK(TRUE);
            UNTIL ItemLedgEntry.NEXT=0;
        UNTIL ItemEntryRelation.NEXT=0;
        
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
        
        IF PAGE.RUNMODAL(PAGE::"Item Ledger Entries - Reclass",ItemLedgEntry)=ACTION::LookupOK THEN
          BEGIN
            FromLot := ItemLedgEntry."Lot No.";
            ItemNo := ItemLedgEntry."Item No.";
            Qty := ItemLedgEntry."Remaining Quantity";
            GetSupportingInfo(ItemNo,FromLot);
          END;

    end;

    procedure ShowBinContentLines()
    var
        ItemLedgEntry: Record "32";
        PurchRcptHdr: Record "120";
        FilterString: Text[1024];
        Counter: Integer;
        LotString: Text[250];
        TempLotInfo: Record "6505" temporary;
        TempLotBinContent: Record "50001" temporary;
        TempLotBinContentSub: Record "50001" temporary;
        LotNoInfo: Record "6505";
        ItemTrackingMgt: Codeunit "6500";
        LookupItemNo: Code[20];
        LookupQty: Decimal;
        LookupFromLotNo: Code[20];
        LookupFromBin: Code[10];
        ItemEntryRelation: Record "6507";
        PurchRcptLine: Record "121";
    begin
        //read purch. rcpts into a filter string
        PurchRcptHdr.RESET;
        PurchRcptHdr.SETCURRENTKEY("Order No.");
        PurchRcptHdr.SETRANGE("Order No.",OrderNo);
        IF NOT PurchRcptHdr.FIND('-') THEN
          BEGIN
            MESSAGE('No lines found.');
            EXIT;
          END;
        
        CLEAR(FilterString);
        CLEAR(Counter);
        
        REPEAT
          IF (FilterString<>'') THEN
            FilterString := FilterString + '|';
          FilterString := FilterString + PurchRcptHdr."No.";
          Counter := Counter + 1;
        UNTIL PurchRcptHdr.NEXT=0;
        
        //filter on item entry relation line for the receipts
        ItemEntryRelation.SETCURRENTKEY("Source ID","Source Type","Source Subtype","Source Ref. No.");
        IF Counter>1 THEN
          ItemEntryRelation.SETFILTER("Source ID",FilterString)
        ELSE
          ItemEntryRelation.SETRANGE("Source ID",FilterString);
        ItemEntryRelation.SETRANGE("Source Type",DATABASE::"Purch. Rcpt. Line");
        
        
        IF NOT ItemEntryRelation.FIND('-') THEN
          BEGIN
            MESSAGE('No Receipt Lines found.');
            EXIT;
          END;
        
        
        ItemLedgEntry.RESET;
        REPEAT
          PurchRcptLine.GET(ItemEntryRelation."Source ID",ItemEntryRelation."Source Ref. No.");
          ItemLedgEntry.SETCURRENTKEY(
              "Item No.","Variant Code",Open,Positive,"Location Code","Posting Date","Expiration Date","Lot No.");
          ItemLedgEntry.SETRANGE("Item No.",PurchRcptLine."No.");
          ItemLedgEntry.SETRANGE(Open,TRUE);
          ItemLedgEntry.SETRANGE(Positive,TRUE);
          ItemLedgEntry.SETRANGE("Location Code",FromLocation);
          ItemLedgEntry.SETRANGE("Lot No.",ItemEntryRelation."Lot No.");
          IF ItemLedgEntry.FIND('-') THEN
            REPEAT
              ItemLedgEntry.MARK(TRUE);
            UNTIL ItemLedgEntry.NEXT=0;
        UNTIL ItemEntryRelation.NEXT=0;
        
        
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
        IF NOT ItemLedgEntry.FIND('-') THEN
          BEGIN
            MESSAGE('No lots found.');
            EXIT;
          END;
        
        TempLotInfo.DELETEALL;
        REPEAT
          TempLotInfo.INIT;
          TempLotInfo."Item No." := ItemLedgEntry."Item No.";
          TempLotInfo."Lot No." := ItemLedgEntry."Lot No.";
          IF NOT TempLotInfo.INSERT THEN;
        UNTIL ItemLedgEntry.NEXT=0;
        
        //now get lot bin content, and store in Total Lot Bin Content
        TempLotInfo.FIND('-');
        REPEAT
          GetLotBinContents(TempLotInfo,FromLocation,TempLotBinContentSub);
          IF TempLotBinContentSub.FIND('-') THEN
            REPEAT
              TempLotBinContent.TRANSFERFIELDS(TempLotBinContentSub);
              IF TempLotBinContent."Item No."<>'' THEN
                 IF NOT TempLotBinContent.INSERT THEN;
            UNTIL TempLotBinContentSub.NEXT=0;
        UNTIL TempLotInfo.NEXT=0;
        
        
        //now call selection
        IF ItemTrackingMgt.LotBinContentLookupBin3(TempLotBinContent,LookupFromBin,LookupItemNo,LookupFromLotNo,LookupQty) THEN
          BEGIN
            FromBin := LookupFromBin;
            ToBin := FromBin;
            ItemNo := LookupItemNo;
            FromLot := LookupFromLotNo;
            Qty := LookupQty;
            GetSupportingInfo(ItemNo,FromLot);
         END;

    end;

    procedure FromLocationBinEnabled(): Boolean
    begin
        IF NOT Location.GET(FromLocation) THEN
          CLEAR(Location);

        EXIT(Location."Bin Mandatory");
    end;

    procedure GetLotBinContents(var LotNoInfo: Record "6505";LocationCode: Code[10];var TempLotBinContent: Record "50001" temporary)
    var
        WhseEntry: Record "7312";
        BinContent: Record "7302";
    begin
        TempLotBinContent.DELETEALL;

        //loop through whse. entry
        WhseEntry.SETCURRENTKEY("Item No.",Open,Positive,"Location Code","Zone Code",
                                  "Bin Code","Serial No.","Lot No.","Expiration Date","Posting Date");

        WhseEntry.SETRANGE("Item No.",LotNoInfo."Item No.");
        WhseEntry.SETRANGE(Open,TRUE);
        WhseEntry.SETRANGE("Location Code",LocationCode);
        WhseEntry.SETRANGE("Lot No.",LotNoInfo."Lot No.");
           REPEAT
             WITH TempLotBinContent DO
               BEGIN
                 //get Lot Info record if exists
                 IF NOT LotNoInfo.GET(WhseEntry."Item No.",WhseEntry."Variant Code",WhseEntry."Lot No.") THEN
                   CLEAR(LotNoInfo);

                 IF NOT TempLotBinContent.GET(WhseEntry."Location Code",WhseEntry."Bin Code",WhseEntry."Item No.",
                      WhseEntry."Variant Code",WhseEntry."Unit of Measure Code",WhseEntry."Lot No.") THEN
                    BEGIN
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
                      INSERT;
                    END;
               END;
           UNTIL WhseEntry.NEXT=0;
    end;

    procedure PrintLabel()
    var
        Receive: Record "14000601";
        ReceiveLine: Record "14000602";
        UseReceiveNo: Code[20];
        Item: Record "27";
        NoSeriesMgt: Codeunit "396";
        LabelMgt: Codeunit "50017";
    begin
        IF ItemNo='' THEN
          BEGIN
            MESSAGE('You must specify Item No.');
            EXIT;
          END;

        IF OrderNo='' THEN
          BEGIN
            MESSAGE('You must specify a Purchase Order No.');
            EXIT;
          END;

        IF Qty=0 THEN
          BEGIN
            MESSAGE('You must specific a Quantity');
            EXIT;
          END;

        Item.GET(ItemNo);
        IF ToLot='' THEN
          ToLot := NoSeriesMgt.GetNextNo(Item."Lot Nos.",TODAY,TRUE);


        UseReceiveNo := USERID + 'RCLS';
        IF Receive.GET(UseReceiveNo) THEN
          Receive.DELETE(TRUE);

        Receive.INIT;
        Receive."No." := UseReceiveNo;
        //Receive."Purchase Order No." := OrderNo;
        Receive.INSERT;

        ReceiveLine.INIT;
        ReceiveLine."Receive No." := Receive."No.";
        ReceiveLine.Type := ReceiveLine.Type::Item;
        ReceiveLine."No." := ItemNo;
        ReceiveLine.Description := Item.Description;
        ReceiveLine.Quantity := Qty;
        ReceiveLine."Quantity (Base)" := Qty;
        ReceiveLine."Lot No." := ToLot;
        //ReceiveLine."Purchase Order No." := OrderNo;
        ReceiveLine."Mfg. Lot No." := MfgLotNo;
        ReceiveLine.INSERT;

        LabelMgt.PromptReceiveLineLabel(ReceiveLine,Qty,Qty,TRUE);

        Receive.DELETE(TRUE);
    end;

    procedure ShowItemLedgLines2()
    var
        ItemLedgEntry: Record "32";
        FilterString: Text[250];
        Counter: Integer;
        ItemEntryRelation: Record "6507";
        PurchRcptLine: Record "121";
    begin
        IF (ItemNo='') AND (OrderNo='') THEN
          BEGIN
            MESSAGE('You must enter an Item or an Order Number.');
            EXIT;
          END;

        ItemLedgEntry.SETCURRENTKEY(
            "Item No.","Variant Code",Open,Positive,"Location Code","Posting Date","Expiration Date","Lot No.");
        ItemLedgEntry.SETRANGE("Item No.",ItemNo);
        ItemLedgEntry.SETRANGE(Open,TRUE);
        ItemLedgEntry.SETRANGE(Positive,TRUE);
        ItemLedgEntry.SETRANGE("Location Code",FromLocation);
        IF ItemLedgEntry.FIND('-') THEN
          REPEAT
            ItemLedgEntry.MARK(TRUE);
          UNTIL ItemLedgEntry.NEXT=0;

        ItemLedgEntry.SETCURRENTKEY("Entry No.");
        ItemLedgEntry.SETRANGE("Item No.");
        ItemLedgEntry.SETRANGE("Lot No.");
        ItemLedgEntry.MARKEDONLY(TRUE);

        IF PAGE.RUNMODAL(PAGE::"Item Ledger Entries - Reclass",ItemLedgEntry)=ACTION::LookupOK THEN
          BEGIN
            FromLot := ItemLedgEntry."Lot No.";
            ItemNo := ItemLedgEntry."Item No.";
            Qty := ItemLedgEntry."Remaining Quantity";
            GetSupportingInfo(ItemNo,FromLot);
          END;
    end;

    procedure ShowBinContentLines2()
    var
        ItemLedgEntry: Record "32";
        PurchRcptHdr: Record "120";
        FilterString: Text[250];
        Counter: Integer;
        LotString: Text[250];
        TempLotInfo: Record "6505" temporary;
        TempLotBinContent: Record "50001" temporary;
        TempLotBinContentSub: Record "50001" temporary;
        LotNoInfo: Record "6505";
        ItemTrackingMgt: Codeunit "6500";
        LookupItemNo: Code[20];
        LookupQty: Decimal;
        LookupFromLotNo: Code[20];
        LookupFromBin: Code[10];
        ItemEntryRelation: Record "6507";
        PurchRcptLine: Record "121";
    begin
        IF (ItemNo='') AND (OrderNo='') THEN
          BEGIN
            MESSAGE('You must enter an Item or an Order Number.');
            EXIT;
          END;

        ItemLedgEntry.RESET;
        ItemLedgEntry.SETCURRENTKEY(
            "Item No.","Variant Code",Open,Positive,"Location Code","Posting Date","Expiration Date","Lot No.");
        ItemLedgEntry.SETRANGE("Item No.",ItemNo);
        ItemLedgEntry.SETRANGE(Open,TRUE);
        ItemLedgEntry.SETRANGE(Positive,TRUE);
        ItemLedgEntry.SETRANGE("Location Code",FromLocation);
        IF ItemLedgEntry.FIND('-') THEN
          REPEAT
            ItemLedgEntry.MARK(TRUE);
          UNTIL ItemLedgEntry.NEXT=0;

        ItemLedgEntry.SETCURRENTKEY("Entry No.");
        ItemLedgEntry.SETRANGE("Item No.");
        ItemLedgEntry.SETRANGE("Lot No.");
        ItemLedgEntry.MARKEDONLY(TRUE);


        //build a temp lot table to store lots in prep for bin contents
        IF NOT ItemLedgEntry.FIND('-') THEN
          BEGIN
            MESSAGE('No lots found.');
            EXIT;
          END;

        TempLotInfo.DELETEALL;
        REPEAT
          TempLotInfo.INIT;
          TempLotInfo."Item No." := ItemLedgEntry."Item No.";
          TempLotInfo."Lot No." := ItemLedgEntry."Lot No.";
          IF NOT TempLotInfo.INSERT THEN;
        UNTIL ItemLedgEntry.NEXT=0;

        //now get lot bin content, and store in Total Lot Bin Content
        TempLotInfo.FIND('-');
        REPEAT
          GetLotBinContents(TempLotInfo,FromLocation,TempLotBinContentSub);
          IF TempLotBinContentSub.FIND('-') THEN
            REPEAT
              TempLotBinContent.TRANSFERFIELDS(TempLotBinContentSub);
              IF TempLotBinContent."Item No."<>'' THEN
                 IF NOT TempLotBinContent.INSERT THEN;
            UNTIL TempLotBinContentSub.NEXT=0;
        UNTIL TempLotInfo.NEXT=0;


        //now call selection
        IF ItemTrackingMgt.LotBinContentLookupBin3(TempLotBinContent,LookupFromBin,LookupItemNo,LookupFromLotNo,LookupQty) THEN
          BEGIN
            FromBin := LookupFromBin;
            ToBin := FromBin;
            ItemNo := LookupItemNo;
            FromLot := LookupFromLotNo;
            Qty := LookupQty;
            GetSupportingInfo(ItemNo,FromLot);
         END;
    end;

    procedure GetSupportingInfo(ItemNo: Code[20];LotNo: Code[20])
    var
        LotNoInfo: Record "6505";
    begin
        IF LotNoInfo.GET(ItemNo,'',LotNo) THEN BEGIN
         FromPatenteOrig := LotNoInfo."Patente Original";
         FromAuduanaES := LotNoInfo."Aduana E/S";
         FromPedimentNo := LotNoInfo."Pediment No.";
         FromCVEPedimento := LotNoInfo."CVE Pedimento";
         MfgLotNo := LotNoInfo."Mfg. Lot No.";
        END;
    end;

    local procedure FromLocationOnAfterValidate()
    begin
        FromBinVisible := FromLocationBinEnabled;
    end;

    local procedure ToLocationOnAfterValidate()
    begin
        IF NOT Location.GET(ToLocation) THEN
          CLEAR(Location);
        ToBin := Location."Receipt Bin Code";
    end;
}

