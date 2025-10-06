page 50023 "Bin Movement"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade
    // NF2.00:CIS.RAM 02/22/17 Added code to store bin details into table

    PageType = Card;

    layout
    {
        area(content)
        {
            field(FromLocationCode;FromLocationCode)
            {
                Caption = 'From Location';
                Editable = true;

                trigger OnLookup(var Text: Text): Boolean
                var
                    Location: Record "14";
                    WhseEmployee: Record "7301";
                begin
                    //mark valid locations
                    CLEAR(Location);
                    WhseEmployee.RESET;
                    WhseEmployee.SETRANGE("User ID",USERID);
                    IF WhseEmployee.FIND('-') THEN
                      REPEAT
                        IF Location.GET(WhseEmployee."Location Code") THEN
                          Location.MARK(TRUE);
                      UNTIL WhseEmployee.NEXT=0;

                    Location.MARKEDONLY(TRUE);
                    IF PAGE.RUNMODAL(0,Location)=ACTION::LookupOK THEN
                      FromLocationCode := Location.Code;
                end;

                trigger OnValidate()
                begin
                    IF FromLocationCode<>'' THEN
                      BEGIN
                        WhseEmp.RESET;
                        WhseEmp.SETRANGE("User ID",USERID);
                        WhseEmp.SETRANGE("Location Code",FromLocationCode);
                        IF NOT WhseEmp.FIND('-') THEN
                          ERROR('You are not set up for this location.');
                      END;

                    ToLocationCode := FromLocationCode;
                end;
            }
            field(txFromBinCode;FromBinCode)
            {
                Caption = 'From Bin';

                trigger OnLookup(var Text: Text): Boolean
                var
                    ItemTrackingMgt: Codeunit "6500";
                begin
                    Bin.SETRANGE("Location Code",FromLocationCode);
                    IF PAGE.RUNMODAL(PAGE::"Bin List",Bin) = ACTION::LookupOK THEN
                      FromBinCode := Bin.Code;
                end;

                trigger OnValidate()
                begin
                    IF FromBinCode<>'' THEN
                      IF NOT Bin.GET(FromLocationCode,FromBinCode) THEN
                        ERROR('Invalid Bin Code');
                end;
            }
            field(ItemNo;ItemNo)
            {
                Caption = 'Item/Lot No.';

                trigger OnLookup(var Text: Text): Boolean
                var
                    ItemTrackingMgt: Codeunit "6500";
                    LookupItemNo: Code[20];
                    LookupLotNo: Code[20];
                begin
                    IF Bin.GET(FromLocationCode,FromBinCode) THEN
                      IF ItemTrackingMgt.LotBinContentLookupBin2(Bin,LookupItemNo,LookupLotNo,Quantity) THEN
                        BEGIN
                          IF NOT LotNoInfo.GET(LookupItemNo,'',LookupLotNo) THEN
                            CLEAR(LotNoInfo);
                         UseItemNo :=LotNoInfo."Item No.";
                         UseItemDesc := LotNoInfo.Description;
                         UseLotNo := LotNoInfo."Lot No.";
                         BinCount := NVMgmt.LotHistory(LookupItemNo,LookupLotNo,Bins);
                         ItemNo := UseLotNo;

                         //NF2.00:CIS.RAM >>>
                         BinMovementLines.DELETEALL;
                         FOR i := 1 TO 50 DO BEGIN
                           IF Bins[i,1] <> '' THEN BEGIN
                             BinMovementLines.INIT;
                             BinMovementLines."From Location" := FromLocationCode;
                             BinMovementLines."From Bin"  :=  FromBinCode;
                             BinMovementLines."Item Lot No." := ItemNo;
                             BinMovementLines."Line No." := i;
                             BinMovementLines.Bins := Bins[i,1];
                             IF Bins[i,3] <>'' THEN
                               EVALUATE(BinMovementLines.Quantity,(Bins[i,3]))
                             ELSE
                               BinMovementLines.Quantity := 0;
                             BinMovementLines.UOM    := Bins[i,5];
                             BinMovementLines."Location Code"  := Bins[i,2];
                             BinMovementLines.INSERT;
                           END;
                         END;
                         //NF2.00:CIS.RAM <<<


                       END;
                    //<< 05-11-05
                end;

                trigger OnValidate()
                begin
                    IF ItemNo='' THEN BEGIN
                      CLEAR(UseItemNo);
                      CLEAR(UseItemDesc);
                      CLEAR(UseLotNo);
                    END;

                    ValidateFlag := FALSE;  //NF2.00:CIS.RAM
                    IF (UseLotNo='') AND (Item.GET(ItemNo)) THEN
                     BEGIN
                        //if tracking code is blank, this must be an item that is not lot tracked
                        IF Item."Item Tracking Code"='' THEN
                          ItemType := ItemType::"Item No."
                        //else if invalid item tracking code, return error
                        ELSE
                        IF NOT ItemTrackingCode.GET(Item."Item Tracking Code") THEN
                            ERROR('Item %1 has an invalid Item Tracking Code of %2.',Item."No.",Item."Item Tracking Code")
                        //otherwise, return error if item is lot tracked
                        ELSE
                        IF ItemTrackingCode."Lot Specific Tracking" THEN
                           ERROR('You must specify a enter a Lot No. for this Item.');

                        UseItemNo := Item."No.";
                        UseLotNo := '';
                        UseItemDesc := Item.Description;
                        ItemType:=ItemType::"Item No.";
                        BinCount := NVMgmt.LotHistory(UseItemNo,'',Bins);
                        ValidateFlag := TRUE;   //NF2.00:CIS.RAM
                     END
                    ELSE
                     BEGIN
                       IF (UseItemNo<>'') THEN BEGIN
                         LotNoInfo.SETRANGE("Item No.",UseItemNo);
                         LotNoInfo.SETRANGE("Lot No.",UseLotNo);
                       END ELSE
                         LotNoInfo.SETRANGE("Lot No.",ItemNo);

                       IF LotNoInfo.COUNT>1 THEN
                         ERROR('Please use lookup. More than one Item exists with this Lot %1.',ItemNo)
                       ELSE IF NOT LotNoInfo.FIND('-') THEN
                         CLEAR(LotNoInfo);
                       UseItemNo := LotNoInfo."Item No.";
                       UseLotNo := LotNoInfo."Lot No.";
                       UseItemDesc := LotNoInfo.Description;
                       ItemType:= ItemType::"Lot No.";
                       BinCount := NVMgmt.LotHistory(UseItemNo,UseLotNo,Bins);
                       ItemNo := LotNoInfo."Lot No.";
                       ValidateFlag := TRUE;
                     END;

                    //NF2.00:CIS.RAM >>>
                    BinMovementLines.DELETEALL;
                    IF ValidateFlag THEN BEGIN
                      FOR i := 1 TO 50 DO BEGIN
                        IF Bins[i,1] <> '' THEN BEGIN
                          BinMovementLines.INIT;
                          BinMovementLines."From Location" := FromLocationCode;
                          BinMovementLines."From Bin"  :=  FromBinCode;
                          BinMovementLines."Item Lot No." := ItemNo;
                          BinMovementLines."Line No." := i;
                          BinMovementLines.Bins    := Bins[i,1];
                          IF Bins[i,3] <>'' THEN
                            EVALUATE(BinMovementLines.Quantity,(Bins[i,3]))
                          ELSE
                            BinMovementLines.Quantity := 0;
                          BinMovementLines.UOM    := Bins[i,5];
                          BinMovementLines."Location Code"  := Bins[i,2];
                          BinMovementLines.INSERT;
                        END;
                      END;
                    END;
                    //NF2.00:CIS.RAM <<<
                end;
            }
            field(Quantity;Quantity)
            {
                Caption = 'Quantity';
                DecimalPlaces = 0:2;
            }
            field(ToLocationCode;ToLocationCode)
            {
                Caption = 'To Location';

                trigger OnLookup(var Text: Text): Boolean
                begin
                    //mark valid locations
                    IF PAGE.RUNMODAL(0,Location)=ACTION::LookupOK THEN
                      ToLocationCode := Location.Code;
                end;

                trigger OnValidate()
                begin
                    IF ToLocationCode<>'' THEN
                      IF NOT Location.GET(ToLocationCode) THEN
                        ERROR('Invalid To Location.');
                end;
            }
            field(ToBinCode;ToBinCode)
            {
                Caption = 'To Bin';

                trigger OnLookup(var Text: Text): Boolean
                begin
                    Bin2.SETRANGE("Location Code",ToLocationCode);
                    IF PAGE.RUNMODAL(PAGE::"Bin List",Bin2) = ACTION::LookupOK THEN
                      ToBinCode := Bin2.Code;
                end;

                trigger OnValidate()
                begin
                    ToBinCodeOnAfterValidate;
                end;
            }
            field(UseItemNo;UseItemNo)
            {
                Editable = false;
                Style = Strong;
                StyleExpr = TRUE;
            }
            field(;'')
            {
                CaptionClass = FORMAT (UseItemDesc);
                Style = Strong;
                StyleExpr = TRUE;
            }
            part(BinMovementLines;50115)
            {
                Caption = 'Details';
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Item Card")
            {
                Caption = 'Item Card';
                Image = ReviewWorksheet;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ToolTip = 'Item Card';

                trigger OnAction()
                begin

                    IF UseItemNo<>'' THEN
                      BEGIN
                        Item.GET(UseItemNo);
                        PAGE.RUN(PAGE::"Item Card",Item);
                       END;
                end;
            }
            action(Tsfer)
            {
                Caption = '&Transfer';
                Image = TransferReceipt;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Location.GET(FromLocationCode);

                    IF FromBinCode = Location."Receipt Bin Code" THEN
                      FromBinCode2 := ''
                    ELSE
                      FromBinCode2 := FromBinCode;

                    IF ToLocationCode<>FromLocationCode THEN
                      BEGIN
                         IF NVMgmt.CreateMovementLoc(UseItemNo,UseLotNo,ToLocationCode,ToBinCode,
                                                              FromLocationCode,FromBinCode,USERID,Quantity,ErrorMsg) THEN
                           MESSAGE('Movement Complete.');
                      END
                    ELSE
                    IF NOT NVMgmt.CreateMovement(UseItemNo,UseLotNo,ToBinCode,FromLocationCode,FromBinCode2,USERID,Quantity,ErrorMsg) THEN
                      ERROR(ErrorMsg)
                    ELSE
                      MESSAGE('Movement Complete.');

                    ItemNo := '';
                    ToBinCode := '';
                    Quantity := 0;
                    CLEAR(UseItemNo);
                    CLEAR(UseLotNo);
                    CLEAR(UseItemDesc);
                    CLEAR(Bins);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        WhseEmp.RESET;
        WhseEmp.SETRANGE("User ID",UPPERCASE(USERID));
        WhseEmp.SETRANGE(Default,TRUE);
        IF NOT WhseEmp.FIND('-') THEN
          ERROR(USERID + ' is not setup with a default location.');

        FromLocationCode := WhseEmp."Location Code";
        ToLocationCode := FromLocationCode;
        IF FromLocationCode<>'' THEN
         BEGIN
           IF NOT Location.GET(FromLocationCode) THEN
             BEGIN
               CLEAR(Location);
               MESSAGE('Warning: Default Location %1 does not exist.',FromLocationCode);
             END;
           FromBinCode := Location."Receipt Bin Code";
         END;
        ItemType := ItemType::"Lot No.";

        BinMovementLines.DELETEALL;  //NF2.00:CIS.RAM
    end;

    var
        ItemNo: Code[20];
        Quantity: Decimal;
        ToBinCode: Code[20];
        FromBinCode: Code[20];
        NVMgmt: Codeunit "50021";
        LotNoInfo: Record "6505";
        Bin: Record "7354";
        Bin2: Record "7354";
        Bins: array [50,50] of Text[30];
        BinCount: Integer;
        i: Integer;
        BinList: Text[1024];
        Qty: array [20,20] of Decimal;
        MaxQty: array [20,20] of Decimal;
        WhseEmp: Record "7301";
        ErrorMsg: Text[30];
        FromBinCode2: Code[20];
        UserSetup: Record "91";
        FromLocationCode: Code[20];
        Location: Record "14";
        ItemType: Option "Item No.","Lot No.";
        Item: Record "27";
        ItemTrackingCode: Record "6502";
        ToLocationCode: Code[20];
        UseItemNo: Code[20];
        UseLotNo: Code[20];
        UseItemDesc: Text[50];
        Text19030776: Label 'Bins';
        Text19077822: Label 'Qty';
        Text19027750: Label 'UOM';
        Text19037993: Label 'Location';
        BinMovementLines: Record "50041";
        ValidateFlag: Boolean;

    local procedure ToBinCodeOnAfterValidate()
    begin
        IF ToBinCode<>'' THEN
          IF NOT Bin.GET(ToLocationCode,ToBinCode) THEN
            ERROR('Invalid Bin %1 for Location %2.',ToBinCode,ToLocationCode);
    end;

    local procedure Bins1441OnActivate()
    begin
        ToBinCode := Bins[1,1]
    end;

    local procedure Bins4441OnActivate()
    begin
        ToBinCode := 'me';
    end;

    local procedure Bins4442OnActivate()
    begin
        ToBinCode := 'me';
    end;

    local procedure Bins1442OnActivate()
    begin
        ToBinCode := Bins[1,1]
    end;
}

