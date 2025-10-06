codeunit 50133 "FB Management"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)
    // NF1.00:CIS.NG    10/26/15 Fill-Bill Functionality (Added some missing code in function "GetContractLine")
    // //>> NIF
    // Functions Modified:
    //   LoadFBOrders
    //   CreateSalesOrder
    //   CreateTransferOrder
    //   ProcessFBOrder
    // Functions Added:
    //   CheckFBOrderLines
    // 
    // Date    Init   Proj   Description
    // 011206  RTT   #10566  new functions CheckFBOrderLines and GetContractLine
    // 011206  RTT   #10566  code at ProcessFBOrder
    // 031306  RTT           blank Item No. check for fcn CheckFBOrderLines
    // //<< NIF


    trigger OnRun()
    begin
    end;

    var
        Item: Record "27";
        NVV: Codeunit "50132";

    procedure CalcAvailabilityLine(var FBLine: Record "50137";AllLocations: Boolean): Decimal
    var
        AvailableToPromise: Codeunit "5790";
        GrossRequirement: Decimal;
        ScheduledReceipt: Decimal;
        PeriodType: Option Day,Week,Month,Quarter,Year;
        AvailabilityDate: Date;
        LookaheadDateformula: DateFormula;
    begin
        GetItem(FBLine."Item No.");
        IF FBLine."Order Date" <> 0D THEN
          AvailabilityDate := FBLine."Order Date"
        ELSE
          AvailabilityDate := WORKDATE;

        Item.RESET;
        Item.SETRANGE("Date Filter",0D,AvailabilityDate);
        Item.SETRANGE("Variant Filter",FBLine."Variant Code");
        IF NOT AllLocations THEN
          Item.SETRANGE("Location Filter",FBLine."Location Code");
        Item.SETRANGE("Drop Shipment Filter",FALSE);

        EXIT(AvailableToPromise.QtyAvailabletoPromise(Item,
                                                      GrossRequirement,
                                                      ScheduledReceipt,
                                                      AvailabilityDate,
                                                      PeriodType,
                                                      LookaheadDateformula));
    end;

    procedure GetItem(ItemNo: Code[20])
    begin
        IF ItemNo = '' THEN
         EXIT;
        IF Item."No." <> ItemNo THEN
          Item.GET(ItemNo);
    end;

    procedure LookupItem(ItemNo: Code[20])
    begin
        IF ItemNo = '' THEN
         EXIT;
        GetItem(ItemNo);
        PAGE.RUNMODAL(PAGE::"Item Card",Item);
    end;

    procedure LoadFBOrders(FBImportLog: Record "50138")
    var
        FBHeader: Record "50136";
        FBLine: Record "50137";
        PriceContract: Record "50110";
        FBTag: Record "50134";
        FoundTag: Boolean;
        SalesPrice: Record "7002";
        ItemCrossRef: Record "5717";
        LotInfo: Record "6505";
        SalesPriceFound: Boolean;
        NeedQty: Decimal;
        Window: Dialog;
    begin
        IF GUIALLOWED THEN
          Window.OPEN('Import Data Log No.  #1####################### \'+
                      'Line No.             #2#######################');

        FBHeader.SETCURRENTKEY("Import Data Log No.","Location Code","Sell-to Customer No.","Ship-To Code","Contract No.");

        IF GUIALLOWED THEN BEGIN
          Window.UPDATE(1,FBImportLog."No.");
          Window.UPDATE(2,FORMAT(FBImportLog."Line No."));
        END;
        FoundTag := FBTag.GET(FBImportLog."Tag No.");
        // Header
        FBHeader.SETRANGE("Import Data Log No.",FBImportLog."No.");
        IF FoundTag THEN BEGIN
          FBHeader.SETRANGE("Location Code",FBTag."Location Code");
          FBHeader.SETRANGE("Sell-to Customer No.",FBTag."Customer No.");
          FBHeader.SETRANGE("Ship-To Code",FBTag."Ship-to Code");
          FBHeader.SETRANGE("Contract No.",FBTag."Contract No.");
          FBHeader.SETRANGE("FB Order Type",FBTag."FB Order Type");
        END ELSE BEGIN
          FBHeader.SETRANGE("Location Code",FBImportLog."Location Code");
          FBHeader.SETRANGE("Sell-to Customer No.",FBImportLog."Customer No.");
          FBHeader.SETRANGE("Ship-To Code",FBImportLog."Ship-to Code");
          FBHeader.SETRANGE("Contract No.",FBImportLog."Contract No.");
          IF PriceContract.GET(FBImportLog."Contract No.") THEN
            FBHeader.SETRANGE("FB Order Type",PriceContract."FB Order Type")
          ELSE
            FBHeader.SETRANGE("FB Order Type",0);
        END;
        IF NOT FBHeader.FIND('-') THEN BEGIN
          FBHeader.INIT;
          FBHeader."No." := '';
          FBHeader.INSERT(TRUE);
          FBHeader."Order Date" := FBImportLog."Order Date";
          FBHeader.VALIDATE("Sell-to Customer No.",FBImportLog."Customer No.");
          IF FoundTag THEN BEGIN
            FBHeader.VALIDATE("Location Code",FBTag."Location Code");
            FBHeader.VALIDATE("Ship-To Code",FBTag."Ship-to Code");
            FBHeader."FB Order Type" := FBTag."FB Order Type";
            IF FBTag."Contract No." <> '' THEN
              FBHeader.VALIDATE("Contract No.",FBTag."Contract No.");
            IF FBHeader."FB Order Type" = FBHeader."FB Order Type"::Consigned THEN BEGIN
              FBHeader."Selling Location" := FBTag."Selling Location";
              FBHeader."Shipping Location" := FBTag."Shipping Location";
            END;
          END ELSE BEGIN
            IF FBImportLog."Ship-to Code" <> '' THEN
              FBHeader.VALIDATE("Ship-To Code",FBImportLog."Ship-to Code");
            IF FBImportLog."Location Code" <> '' THEN
              FBHeader.VALIDATE("Location Code",FBImportLog."Location Code");
            IF FBImportLog."Contract No." <> '' THEN
              FBHeader.VALIDATE("Contract No.",FBImportLog."Contract No.");
          END;
          IF PriceContract.GET(FBHeader."Contract No.") THEN BEGIN
            IF FBImportLog."External Document No." = '' THEN
              FBHeader."External Document No." := PriceContract."External Document No."
            ELSE
              FBHeader."External Document No." := FBImportLog."External Document No.";
            IF PriceContract."Salesperson Code" <> '' THEN
                FBHeader.VALIDATE("Salesperson Code",PriceContract."Salesperson Code");
            IF NOT FoundTag THEN
              FBHeader."FB Order Type" := PriceContract."FB Order Type";
            IF FBHeader."FB Order Type" = FBHeader."FB Order Type"::Consigned THEN BEGIN
              FBHeader."Selling Location" := PriceContract."Selling Location Code";
              FBHeader."Shipping Location" := PriceContract."Shipping Location Code";
            END;
          END ELSE BEGIN
            FBHeader."External Document No." := FBImportLog."External Document No.";
            IF FBImportLog."Salesperson Code" <> '' THEN
              FBHeader.VALIDATE("Salesperson Code",FBImportLog."Salesperson Code");
          END;
          FBHeader."Import Data Log No." := FBImportLog."No.";
          FBHeader."Import Date" := FBImportLog."Import Date";
          //>> NIF
          FBHeader."Import Time" := FBImportLog."Import Time";
          //<< NIF
          FBHeader."Import File Name" := FBImportLog."Import File Name";
          FBHeader.Status := FBHeader.Status::New;
          FBHeader.MODIFY;
        END;
        // Lines
        FBLine.INIT;
        FBLine."Document No." := FBHeader."No.";
        FBLine."Line No." := FBImportLog."Line No." * 100;
        FBLine."Import Data Log No." := FBImportLog."No.";
        FBLine."Import Data Log Line No." := FBImportLog."Line No.";
        FBLine."Order Date" := FBHeader."Order Date";
        FBLine."Sell-to Customer No." := FBHeader."Sell-to Customer No.";
        IF FBHeader."Ship-To Code" <> '' THEN
          FBLine.VALIDATE("Ship-To Code",FBHeader."Ship-To Code");
        IF FBHeader."Location Code" <> '' THEN
          FBLine.VALIDATE("Location Code",FBHeader."Location Code");

        FBLine."Contract No." := FBImportLog."Contract No.";
        FBLine."Customer Bin" := FBImportLog."Customer Bin";
        FBLine."FB Order Type" := FBHeader."FB Order Type";
        FBLine."External Document No." := FBHeader."External Document No.";
        IF FBLine."FB Order Type" = FBLine."FB Order Type"::Consigned THEN BEGIN
          FBLine."Selling Location" := FBHeader."Selling Location";
          FBLine."Shipping Location" := FBHeader."Shipping Location";
        END;


        IF FoundTag THEN BEGIN
          FBLine.VALIDATE("Item No.",FBTag."Item No.");
          FBLine.VALIDATE("Variant Code",FBTag."Variant Code");
          FBLine.VALIDATE("Unit of Measure Code",FBTag."Unit of Measure Code");
          FBLine."Customer Bin" := FBTag."Customer Bin";
          FBLine."FB Order Type" := FBTag."FB Order Type";
          FBLine."External Document No." := FBTag."External Document No.";
          FBLine."Replenishment Method" := FBTag."Replenishment Method";
          FBLine."Cross-Reference No." := FBTag."Cross-Reference No.";
          FBLine."Lot No." := FBImportLog."Lot No.";
          IF FBTag."Contract No." <> '' THEN
            FBLine."Contract No." := FBTag."Contract No.";
          IF FBLine."FB Order Type" = FBLine."FB Order Type"::Consigned THEN BEGIN
            FBLine."Selling Location" := FBTag."Selling Location";
            FBLine."Shipping Location" := FBTag."Shipping Location";
          END;
          FBLine.VALIDATE("Tag No.",FBTag."No.");
        END ELSE BEGIN
          IF FBImportLog."Item No." <> '' THEN BEGIN
            FBLine.VALIDATE("Item No.",FBImportLog."Item No.");
            FBLine."Cross-Reference No." := FBImportLog."Cross-Reference No.";
            FBLine.VALIDATE("Unit of Measure Code",FBImportLog."Unit of Measure Code");
          END ELSE BEGIN
            IF FBImportLog."Cross-Reference No." <> '' THEN BEGIN
              ItemCrossRef.SETRANGE("Cross-Reference Type",ItemCrossRef."Cross-Reference Type"::Customer);
              ItemCrossRef.SETRANGE("Cross-Reference Type No.",FBLine."Sell-to Customer No.");
              ItemCrossRef.SETRANGE("Cross-Reference No.",FBImportLog."Cross-Reference No.");
              IF ItemCrossRef.FIND('-') THEN BEGIN
                FBLine."Cross-Reference No." := FBImportLog."Cross-Reference No.";
                FBLine."Cross-Reference Type" := ItemCrossRef."Cross-Reference Type"::Customer;
                FBLine."Cross-Reference Type No." := FBLine."Sell-to Customer No.";
                IF FBLine."Item No." = '' THEN BEGIN
                  FBLine.VALIDATE("Item No.",ItemCrossRef."Item No.");
                  FBLine.VALIDATE("Variant Code",ItemCrossRef."Variant Code");
                  IF FBLine."Unit of Measure Code" = '' THEN
                    FBLine.VALIDATE("Unit of Measure Code",ItemCrossRef."Unit of Measure");
                END;
              END;
            END;
            IF FBImportLog."Lot No." <> '' THEN BEGIN
              FBLine."Lot No." := FBImportLog."Lot No.";
              LotInfo.SETRANGE("Lot No.",FBImportLog."Lot No.");
              IF (LotInfo.FIND('-')) AND (FBImportLog."Item No." = '') THEN BEGIN
                FBLine.VALIDATE("Item No.",LotInfo."Item No.");
                FBLine.VALIDATE("Variant Code",LotInfo."Variant Code");
              END;
            END;
          END;
        END;

        // Price Contract info
        SalesPrice.SETRANGE("Item No.",FBLine."Item No.");
        SalesPrice.SETRANGE("Variant Code",FBLine."Variant Code");
        SalesPrice.SETFILTER("Ending Date",'%1|>=%2',0D,WORKDATE);
        //>>NIF 12-05-05
        IF FBImportLog."Customer Bin"<>'' THEN
          SalesPrice.SETRANGE("Customer Bin",FBImportLog."Customer Bin")
        ELSE
        //<<NIF 12-05-05
        SalesPrice.SETRANGE("Unit of Measure Code",FBLine."Unit of Measure Code");
        SalesPrice.SETRANGE("Starting Date",0D,WORKDATE);
        SalesPrice.SETRANGE("Sales Type",SalesPrice."Sales Type"::Customer);
        SalesPrice.SETRANGE("Sales Code",FBLine."Sell-to Customer No.");
        SalesPrice.SETRANGE("Method of Fullfillment",SalesPrice."Method of Fullfillment"::FillBill);
        IF FBLine."Contract No." <> '' THEN
          SalesPrice.SETRANGE("Contract No.",FBLine."Contract No.");
        SalesPriceFound := SalesPrice.FIND('-');

        IF SalesPriceFound AND (NOT FoundTag) THEN BEGIN
          FBLine."Contract No." := SalesPrice."Contract No.";
          FBLine."External Document No." := SalesPrice."External Document No.";
          FBLine."Replenishment Method" := SalesPrice."Replenishment Method";
          FBLine."FB Order Type" := SalesPrice."FB Order Type";
          IF FBLine."Customer Bin" = '' THEN
            FBLine."Customer Bin" := SalesPrice."Customer Bin";

        //>>NIF 12-05-05
          //IF FBLine."Unit of Measure Code" = '' THEN
          IF SalesPrice."Unit of Measure Code" <> '' THEN
        //<<NIF 12-05-05
            FBLine.VALIDATE("Unit of Measure Code",SalesPrice."Unit of Measure Code");
          IF FBLine."FB Order Type" = FBLine."FB Order Type"::Consigned THEN BEGIN
            FBLine."Selling Location" := SalesPrice."ContractSelling Location Code";
            FBLine."Shipping Location" := SalesPrice."Contract Ship Location Code";
          END;
        END;

        IF FBLine."Variant Code" <> '' THEN
          FBLine.VALIDATE("Variant Code",FBImportLog."Variant Code");

        IF (FBImportLog."Unit of Measure Code" <> '') AND
           (FBLine."Unit of Measure Code" = '') THEN
          FBLine.VALIDATE("Unit of Measure Code",FBImportLog."Unit of Measure Code");

        IF FBLine."Item No." <> '' THEN BEGIN
          GetItem(FBLine."Item No.");
          IF FBLine."Unit of Measure Code" = '' THEN
            FBLine.VALIDATE("Unit of Measure Code",Item."Sales Unit of Measure");
        END;

        IF FoundTag THEN
          FBImportLog."Quantity Type" := FBTag."Quantity Type";

        NeedQty := FBImportLog.Quantity;

        CASE FBImportLog."Quantity Type" OF
          FBImportLog."Quantity Type"::Count : BEGIN
            IF FoundTag THEN BEGIN
              IF FBTag."Reorder Quantity" > 0 THEN BEGIN
                IF FBTag."Min. Quantity" > 0 THEN BEGIN
                  IF FBImportLog.Quantity <= FBTag."Min. Quantity" THEN BEGIN
                    IF FBTag."Max. Quantity" = 0 THEN
                      NeedQty := FBTag."Reorder Quantity"
                    ELSE
                      NeedQty :=
                        ROUND(((FBTag."Max. Quantity" - FBImportLog.Quantity)/FBTag."Reorder Quantity"),1.0,'<')
                        * FBTag."Reorder Quantity";
                  END ELSE
                    NeedQty := 0;
                END ELSE BEGIN
                  IF FBImportLog.Quantity < FBTag."Max. Quantity" THEN
                    NeedQty :=
                      ROUND(((FBTag."Max. Quantity" - FBImportLog.Quantity)/FBTag."Reorder Quantity"),1.0,'<')
                      * FBTag."Reorder Quantity"
                  ELSE
                    NeedQty := 0;
                END;
              END ELSE BEGIN
                IF FBTag."Min. Quantity" > 0 THEN BEGIN
                  IF FBImportLog.Quantity <= FBTag."Min. Quantity" THEN BEGIN
                    IF FBTag."Max. Quantity" = 0 THEN
                      NeedQty := FBTag."Min. Quantity" - FBImportLog.Quantity
                    ELSE
                      NeedQty := FBTag."Max. Quantity" - FBImportLog.Quantity;
                  END ELSE
                    NeedQty := 0;
                END ELSE BEGIN
                  IF FBImportLog.Quantity < FBTag."Max. Quantity" THEN
                    NeedQty := FBTag."Max. Quantity" - FBImportLog.Quantity
                  ELSE
                    NeedQty := 0;
                END;
              END;
            END ELSE BEGIN
              IF SalesPriceFound THEN BEGIN
                IF SalesPrice."Reorder Quantity" > 0 THEN BEGIN
                  IF SalesPrice."Min. Quantity" > 0 THEN BEGIN
                    IF FBImportLog.Quantity <= SalesPrice."Min. Quantity" THEN BEGIN
                      IF SalesPrice."Max. Quantity" = 0 THEN
                        NeedQty := SalesPrice."Reorder Quantity"
                      ELSE
                        NeedQty :=
                          ROUND(((SalesPrice."Max. Quantity" - FBImportLog.Quantity)/SalesPrice."Reorder Quantity"),1.0,'<')
                          * SalesPrice."Reorder Quantity";
                    END ELSE
                      NeedQty := 0;
                  END ELSE BEGIN
                    IF FBImportLog.Quantity < SalesPrice."Max. Quantity" THEN
                      NeedQty :=
                        ROUND(((SalesPrice."Max. Quantity" - FBImportLog.Quantity)/SalesPrice."Reorder Quantity"),1.0,'<')
                        * SalesPrice."Reorder Quantity"
                    ELSE
                      NeedQty := 0;
                  END;
                END ELSE BEGIN
                  IF SalesPrice."Min. Quantity" > 0 THEN BEGIN
                    IF FBImportLog.Quantity <= SalesPrice."Min. Quantity" THEN BEGIN
                      IF SalesPrice."Max. Quantity" = 0 THEN
                        NeedQty := SalesPrice."Min. Quantity" - FBImportLog.Quantity
                      ELSE
                        NeedQty := SalesPrice."Max. Quantity" - FBImportLog.Quantity;
                    END ELSE
                      NeedQty := 0;
                  END ELSE BEGIN
                    IF FBImportLog.Quantity < SalesPrice."Max. Quantity" THEN
                      NeedQty := SalesPrice."Max. Quantity" - FBImportLog.Quantity
                    ELSE
                      NeedQty := 0;
                  END;
                END;
              END ELSE
                NeedQty := 0;
            END;
          END;
        END;

        FBLine.VALIDATE(Quantity,NeedQty);

        FBLine.Status := FBLine.Status::New;

        IF FBLine."Salesperson Code" = '' THEN
          FBLine.VALIDATE("Salesperson Code",FBHeader."Salesperson Code");

        IF FBLine."Inside Salesperson Code" = '' THEN
          FBLine.VALIDATE("Inside Salesperson Code",FBHeader."Inside Salesperson Code");

        //IF FBLine."Contract No." = '' THEN
        //  FBLine.VALIDATE("Contract No.",FBHeader."Contract No.");

        FBLine.INSERT;
        COMMIT;
        IF GUIALLOWED THEN
          Window.CLOSE;
    end;

    procedure WriteMessage(FileName: Code[200];FBOrderNo: Code[20];SalesOrderNo: Code[20];FileNo: Code[20];RecordNo: Integer;SourceCode: Code[10];SetStatus: Option New,Errors,Processed;Msg: Text[250])
    var
        FBMessages: Record "50135";
    begin
        CLEAR(FBMessages);
        FBMessages.INIT;
        FBMessages."File Name" := FileName;
        FBMessages."Import Data Log No." := FileNo;
        FBMessages."Line No." := RecordNo;
        FBMessages."FB Order No." := FBOrderNo;
        FBMessages."Sales Order No." := SalesOrderNo;
        FBMessages.Message := Msg;
        FBMessages.Source := SourceCode;
        FBMessages.Status := SetStatus;
        FBMessages.INSERT(TRUE);
    end;

    procedure PostTagJnl(var TagJnlLine: Record "50141")
    var
        ImportDataLog: Record "50138";
        Window: Dialog;
        DocNo: Code[20];
        NoSeriesMgt: Codeunit "396";
    begin
        TagJnlLine.TESTFIELD("No. Series");
        TagJnlLine.TESTFIELD("Customer No.");

        IF GUIALLOWED THEN
          Window.OPEN('Batch Name   #1############################ \'+
                      'Line No.     #2############################ \'+
                      'Document No. #3############################');

        CLEAR(NoSeriesMgt);
        NoSeriesMgt.InitSeries(TagJnlLine."No. Series",TagJnlLine."No. Series",TagJnlLine."Order Date",DocNo,TagJnlLine."No. Series");

        IF TagJnlLine.FIND('-') THEN REPEAT
          IF GUIALLOWED THEN BEGIN
            Window.UPDATE(1,TagJnlLine."Journal Batch Name");
            Window.UPDATE(2,TagJnlLine."Line No.");
            Window.UPDATE(3,TagJnlLine."Document No.");
          END;
          ImportDataLog.INIT;
          ImportDataLog."No." := DocNo;
          ImportDataLog."Line No." := TagJnlLine."Line No.";
          ImportDataLog."Import File Name" := TagJnlLine."Journal Batch Name";
          ImportDataLog."Import Date" := TODAY;
          ImportDataLog."Import Time" := TIME;
          ImportDataLog."Customer No." := TagJnlLine."Customer No.";
          ImportDataLog."Location Code" := TagJnlLine."Location Code";
          ImportDataLog."Ship-to Code" := TagJnlLine."Ship-to Code";
          ImportDataLog."Contract No." := TagJnlLine."Contract No.";
          ImportDataLog."Item No." := TagJnlLine."Item No.";
          ImportDataLog."Lot No." := TagJnlLine."Lot No.";
          ImportDataLog."Tag No." := TagJnlLine."Tag No.";
          ImportDataLog."Cross-Reference No." := TagJnlLine."Cross-Reference No.";
          IF (ImportDataLog."Cross-Reference No." <> '') AND
             (NOT NVV.ValidateCustItemCrossRef(ImportDataLog."Customer No.",ImportDataLog."Cross-Reference No.")) THEN
            WriteMessage(ImportDataLog."Import File Name",'','',ImportDataLog."No.",ImportDataLog."Line No.",'TAGJNL',1,
                         'Cross-Ref. No. '+ImportDataLog."Cross-Reference No."+' Not Valid');
          ImportDataLog."Variant Code" := TagJnlLine."Variant Code";
          ImportDataLog.Quantity := TagJnlLine.Quantity;
          ImportDataLog."Unit of Measure Code" := TagJnlLine."Unit of Measure Code";
          ImportDataLog."External Document No." := TagJnlLine."External Document No.";
          ImportDataLog."Order Date" := TagJnlLine."Order Date";
          ImportDataLog."Order Time" := TagJnlLine."Order Time";
          ImportDataLog."Salesperson Code" := TagJnlLine."Salesperson Code";
          ImportDataLog."Inside Salesperson Code" := TagJnlLine."Inside Salesperson Code";
          ImportDataLog."Required Date" := TagJnlLine."Required Date";
          ImportDataLog."Customer Bin" := TagJnlLine."Customer Bin";
          ImportDataLog."Purchase Price" := TagJnlLine."Purchase Price";
          ImportDataLog."Sale Price" := TagJnlLine."Sale Price";
          ImportDataLog."Quantity Type" := TagJnlLine."Quantity Type";
          ImportDataLog.INSERT(TRUE);
        UNTIL TagJnlLine.NEXT = 0;

        TagJnlLine.DELETEALL;

        IF GUIALLOWED THEN
          Window.CLOSE;
    end;

    procedure CheckName(CurrentJnlBatchName: Code[10];var FBTagJnlLine: Record "50141")
    var
        FBTagJnlBatch: Record "50140";
    begin
        FBTagJnlBatch.GET(CurrentJnlBatchName);
    end;

    procedure SetName(CurrentJnlBatchName: Code[10];var FBTagJnlLine: Record "50141")
    begin
        FBTagJnlLine.FILTERGROUP := 2;
        FBTagJnlLine.SETRANGE("Journal Batch Name",CurrentJnlBatchName);
        FBTagJnlLine.FILTERGROUP := 0;
        IF FBTagJnlLine.FIND('-') THEN;
    end;

    procedure LookupName(var CurrentJnlBatchName: Code[10];var FBTagJnlLine: Record "50141"): Boolean
    var
        FBTagJnlBatch: Record "50140";
    begin
        COMMIT;
        FBTagJnlBatch.Name := FBTagJnlLine.GETRANGEMAX("Journal Batch Name");
        FBTagJnlBatch.FILTERGROUP := 2;

        FBTagJnlBatch.FILTERGROUP := 0;
        IF PAGE.RUNMODAL(0,FBTagJnlBatch) = ACTION::LookupOK THEN BEGIN
          CurrentJnlBatchName := FBTagJnlBatch.Name;
          SetName(CurrentJnlBatchName,FBTagJnlLine);
        END;
    end;

    procedure OpenJnl(var CurrentJnlBatchName: Code[10];var FBTagJnlLine: Record "50141")
    var
        FBTagJnlBatch: Record "50140";
    begin
        IF NOT FBTagJnlBatch.GET(CurrentJnlBatchName) THEN BEGIN
          IF NOT FBTagJnlBatch.FIND('-') THEN BEGIN
            FBTagJnlBatch.INIT;
            FBTagJnlBatch.Name := 'Default';
            FBTagJnlBatch.Description := 'Default';
            FBTagJnlBatch.INSERT(TRUE);
            COMMIT;
          END;
          CurrentJnlBatchName := FBTagJnlBatch.Name
        END;

        FBTagJnlLine.FILTERGROUP := 2;
        FBTagJnlLine.SETRANGE("Journal Batch Name",CurrentJnlBatchName);
        FBTagJnlLine.FILTERGROUP := 0;
    end;

    procedure ProcessFBOrder(var FBHeader: Record "50136")
    var
        FBLine: Record "50137";
    begin
        //>> NIF 01-12-06 #10566
        CheckFBOrderLines(FBHeader);
        //<< NIF 01-12-06 #10566
        IF FBHeader.FIND('-') THEN REPEAT
          CASE FBHeader."FB Order Type" OF
            FBHeader."FB Order Type"::" ": BEGIN
              FBLine.RESET;
              FBLine.SETRANGE("Document No.",FBHeader."No.");
              IF NOT FBLine.ISEMPTY THEN
                CreateSalesOrder(FBHeader,FBLine,FALSE,FALSE);
              FBHeader.MODIFY;
            END;
            FBHeader."FB Order Type"::Consigned: BEGIN
              FBLine.RESET;
              FBLine.SETRANGE("Document No.",FBHeader."No.");
              IF NOT FBLine.ISEMPTY THEN
                CreateSalesOrder(FBHeader,FBLine,TRUE,TRUE);
              FBLine.SETRANGE("Replenishment Method",FBLine."Replenishment Method"::Automatic);
              IF NOT FBLine.ISEMPTY THEN
                CreateTransferOrder(FBHeader,FBLine,TRUE);
              FBLine.SETRANGE("Replenishment Method",FBLine."Replenishment Method"::Manual);
              IF NOT FBLine.ISEMPTY THEN
                CreateReqLine(FBHeader,FBLine);
              FBHeader.MODIFY;
            END;
            FBHeader."FB Order Type"::"Non-Consigned": BEGIN
              FBLine.RESET;
              FBLine.SETRANGE("Document No.",FBHeader."No.");
              FBLine.SETRANGE("Replenishment Method",FBLine."Replenishment Method"::Automatic);
              IF NOT FBLine.ISEMPTY THEN
                CreateSalesOrder(FBHeader,FBLine,TRUE,FALSE);
              FBLine.SETFILTER("Replenishment Method",'%1|%2',
                               FBLine."Replenishment Method"::" ",
                               FBLine."Replenishment Method"::Manual);
              IF NOT FBLine.ISEMPTY THEN
                CreateSalesOrder(FBHeader,FBLine,FALSE,FALSE);
              FBHeader.MODIFY;
            END;
          END;
        UNTIL FBHeader.NEXT = 0;
    end;

    local procedure CreateSalesOrder(var FBHeader: Record "50136";var FBLine: Record "50137";Release: Boolean;Ship: Boolean)
    var
        SalesHeader: Record "36";
        SalesLine: Record "37";
        ReleaseSalesDoc: Codeunit "414";
        SalesPost: Codeunit "80";
        LineNo: Integer;
    begin
        SalesHeader.INIT;
        SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
        SalesHeader."No." := '';
        SalesHeader.INSERT(TRUE);
        SalesHeader.VALIDATE("Sell-to Customer No.",FBHeader."Sell-to Customer No.");
        SalesHeader.VALIDATE("Ship-to Code",FBHeader."Ship-To Code");
        //>> NIF 12-06-05
        IF FBHeader."Order Date" = 0D THEN
          SalesHeader.VALIDATE("Order Date",WORKDATE)
        ELSE
        //<< NIF 12-06-05
        SalesHeader.VALIDATE("Order Date",FBHeader."Order Date");
        SalesHeader.VALIDATE("Posting Date",WORKDATE);
        SalesHeader.VALIDATE("Contract No.",FBHeader."Contract No.");
        //>> NIF 12-08-05
        //SalesHeader.VALIDATE("Location Code",FBHeader."Selling Location");
        SalesHeader.VALIDATE("Location Code",FBHeader."Location Code");
        //<< NIF 12-08-05
        //>> NIF 12-07-05
        //SalesHeader.VALIDATE("Salesperson Code",FBHeader."Salesperson Code");
        SalesHeader."Salesperson Code" := FBHeader."Salesperson Code";
        //<< NIF 12-07-05
        SalesHeader."External Document No." := FBHeader."External Document No.";
        SalesHeader."Inside Salesperson Code" := FBHeader."Inside Salesperson Code";
        SalesHeader."FB Order No." := FBHeader."No.";
        SalesHeader.MODIFY(TRUE);
        FBHeader."Sales Order No." := SalesHeader."No.";
        FBHeader.Status := FBHeader.Status::Processed;
        FBHeader.MODIFY;
        
        LineNo := 10000;
        
        IF FBLine.FIND('-') THEN REPEAT
        
          SalesLine.INIT;
          SalesLine."Document Type" := SalesHeader."Document Type";
          SalesLine."Document No." := SalesHeader."No.";
          SalesLine."Line No." := LineNo;
          LineNo := LineNo + 10000;
          SalesLine.VALIDATE("Sell-to Customer No.",SalesHeader."Sell-to Customer No.");
          SalesLine.VALIDATE(Type,SalesLine.Type::Item);
          SalesLine.VALIDATE("No.",FBLine."Item No.");
          SalesLine.VALIDATE("Contract No.",FBLine."Contract No.");
          SalesLine.VALIDATE("Location Code",FBLine."Location Code");
          SalesLine.VALIDATE(Quantity,FBLine.Quantity);
          SalesLine.VALIDATE("Unit of Measure Code",FBLine."Unit of Measure Code");
          SalesLine."Cross-Reference No." := FBLine."Cross-Reference No.";
          SalesLine."Unit of Measure (Cross Ref.)" := FBLine."Unit of Measure (Cross Ref.)";
          SalesLine."Cross-Reference Type" := FBLine."Cross-Reference Type";
          SalesLine."Cross-Reference Type No." := FBLine."Cross-Reference Type No.";
          SalesLine."Ship-to Code" := FBLine."Ship-To Code";
          SalesLine."Salesperson Code" := FBLine."Salesperson Code";
          SalesLine."Inside Salesperson Code" := FBLine."Inside Salesperson Code";
          SalesLine."Order Date" := SalesHeader."Order Date";
          SalesLine."Shipment Date" := SalesHeader."Shipment Date";
          SalesLine."Posting Date" := SalesHeader."Posting Date";
          SalesLine."External Document No." := FBLine."External Document No.";
          SalesLine."FB Order No." := FBLine."Document No.";
          SalesLine."FB Line No." := FBLine."Line No.";
          SalesLine."FB Tag No." := FBLine."Tag No.";
          SalesLine."FB Customer Bin" := FBLine."Customer Bin";
        // Still need to handle Lots
          SalesLine.INSERT(TRUE);
          FBLine."Sales Order No." := SalesLine."Document No.";
          FBLine."Sales Order Line No." := SalesLine."Line No.";
          FBLine.MODIFY;
        UNTIL FBLine.NEXT =0;
        
        /*
        IF Release THEN BEGIN
          COMMIT;
          CLEAR(ReleaseSalesDoc);
          IF ReleaseSalesDoc.RUN(SalesHeader) THEN
            SalesHeader.MODIFY
          ELSE BEGIN
            WriteMessage(FBHeader."Import File Name",FBHeader."No.",SalesHeader."No.",FBHeader."Import Data Log No.",
                         0,'PROCESS',1,'Sales Order Not Released');
            FBHeader.Status := FBHeader.Status::Errors;
          END;
          IF Ship THEN BEGIN
            SalesHeader.Ship := Ship;
            SalesHeader.Invoice := FALSE;
            CLEAR(SalesPost);
            IF NOT SalesPost.RUN(SalesHeader) THEN BEGIN
              WriteMessage(FBHeader."Import File Name",FBHeader."No.",SalesHeader."No.",FBHeader."Import Data Log No.",
                           0,'PROCESS',1,'Sales Order Not Shipped');
              FBHeader.Status := FBHeader.Status::Errors;
            END;
          END;
        END;
        */

    end;

    local procedure CreateTransferOrder(var FBHeader: Record "50136";var FBLine: Record "50137";Release: Boolean)
    var
        TransferHeader: Record "5740";
        TransferLine: Record "5741";
        ReleaseTransferDoc: Codeunit "5708";
        LineNo: Integer;
        ">>NIF_LV": Integer;
        Contract: Record "50110";
    begin
        TransferHeader.INIT;
        TransferHeader."No." := '';
        TransferHeader.INSERT(TRUE);
        TransferHeader.VALIDATE("Transfer-from Code",FBHeader."Shipping Location");
        TransferHeader.VALIDATE("Transfer-to Code",FBHeader."Location Code");
        TransferHeader.VALIDATE("Shipment Date",WORKDATE);
        TransferHeader.VALIDATE("Posting Date",WORKDATE);
        TransferHeader."FB Order No." := FBHeader."No.";
        
        //>> NIF 12-13-05
        IF Contract.GET(FBHeader."Contract No.") THEN BEGIN
          TransferHeader."Transfer-to Name" := Contract."Ship-to Name";
          TransferHeader."Transfer-to Name 2" := Contract."Ship-to Name 2";
          TransferHeader."Transfer-to Address" := Contract."Ship-to Address";
          TransferHeader."Transfer-to Address 2" := Contract."Ship-to Address 2";
          TransferHeader."Transfer-to City" := Contract."Ship-to City";
          TransferHeader."Transfer-to Post Code" := Contract."Ship-to Post Code";
          TransferHeader."Transfer-to County" := Contract."Ship-to County";
          TransferHeader."Trsf.-to Country/Region Code" := Contract."Ship-to Country Code";
        END;
        //<< NIF 12-13-05
        
        TransferHeader.MODIFY(TRUE);
        FBHeader.Status := FBHeader.Status::Processed;
        FBHeader.MODIFY;
        
        LineNo := 10000;
        
        IF FBLine.FIND('-') THEN REPEAT
        
          TransferLine.INIT;
          TransferLine."Document No." := TransferHeader."No.";
          TransferLine."Line No." := LineNo;
          LineNo := LineNo + 10000;
          TransferLine.VALIDATE("Item No.",FBLine."Item No.");
          TransferLine.VALIDATE("Transfer-from Code",TransferHeader."Transfer-from Code");
          TransferLine.VALIDATE("Transfer-to Code",TransferHeader."Transfer-to Code");
          TransferLine.VALIDATE(Quantity,FBLine.Quantity);
          TransferLine.VALIDATE("Unit of Measure Code",FBLine."Unit of Measure Code");
          TransferLine."Shipment Date" := TransferHeader."Shipment Date";
          TransferLine."FB Order No." := FBLine."Document No.";
          TransferLine."FB Line No." := FBLine."Line No.";
          TransferLine."FB Tag No." := FBLine."Tag No.";
          TransferLine."FB Customer Bin" := FBLine."Customer Bin";
        // Still need to handle Lots
          TransferLine.INSERT(TRUE);
          FBLine."Transfer Order No." := TransferLine."Document No.";
          FBLine."Transfer Order Line No." := TransferLine."Line No.";
          FBLine.MODIFY;
        UNTIL FBLine.NEXT =0;
        
        /*
        IF Release THEN BEGIN
          COMMIT;
          CLEAR(ReleaseTransferDoc);
          IF ReleaseTransferDoc.RUN(TransferHeader) THEN
            TransferHeader.MODIFY
          ELSE BEGIN
            WriteMessage(FBHeader."Import File Name",FBHeader."No.",TransferHeader."No.",FBHeader."Import Data Log No.",
                         0,'PROCESS',1,'Transfer Order Not Released');
            FBHeader.Status := FBHeader.Status::Errors;
          END;
        END;
        */

    end;

    local procedure CreateReqLine(var FBHeader: Record "50136";var FBLine: Record "50137")
    var
        FBSetup: Record "50133";
        ReqLine: Record "246";
        LineNo: Integer;
    begin
        FBSetup.GET();

        ReqLine.LOCKTABLE;
        ReqLine.SETRANGE("Worksheet Template Name",FBSetup."Req. Worksheet Template");
        ReqLine.SETRANGE("Journal Batch Name",FBSetup."Req. Worksheet Name");
        LineNo := 10000;
        IF ReqLine.FIND('+') THEN
          LineNo := ReqLine."Line No." + 10000;

        IF FBLine.FIND('-') THEN REPEAT

          ReqLine.INIT;
          ReqLine."Worksheet Template Name" := FBSetup."Req. Worksheet Template";
          ReqLine."Journal Batch Name" := FBSetup."Req. Worksheet Name";
          ReqLine."Line No." := LineNo;
          LineNo := LineNo + 10000;
          ReqLine.VALIDATE(Type,ReqLine.Type::Item);
          ReqLine.VALIDATE("No.",FBLine."Item No.");
          ReqLine.VALIDATE(Quantity,FBLine.Quantity);
          ReqLine.VALIDATE("Unit of Measure Code",FBLine."Unit of Measure Code");
          ReqLine.VALIDATE("Location Code",FBLine."Selling Location");
          ReqLine.VALIDATE("Order Date",WORKDATE);
          ReqLine.VALIDATE("Transfer-from Code",FBLine."Shipping Location");
          ReqLine.VALIDATE("Transfer Shipment Date",WORKDATE);
          ReqLine."FB Order No." := FBLine."Document No.";
          ReqLine."FB Line No." := FBLine."Line No.";
          ReqLine."FB Tag No." := FBLine."Tag No.";
          ReqLine."FB Customer Bin" := FBLine."Customer Bin";
          ReqLine.INSERT(TRUE);
        UNTIL FBLine.NEXT =0;
    end;

    procedure ">>NIF_fcn"()
    begin
    end;

    procedure CheckFBOrderLines(FBHeader: Record "50136")
    var
        FBLine: Record "50137";
        PriceContract: Record "50110";
        SalesPrice: Record "7002";
    begin
        FBLine.SETRANGE("Document No.",FBHeader."No.");
        IF FBLine.FIND('-') THEN
          REPEAT
            CLEAR(SalesPrice);
        //>>NIF 031306 RTT
            IF FBLine."Item No."='' THEN BEGIN
              IF NOT CONFIRM(STRSUBSTNO('Item No. is blank for Line %1. Do you want to continue?',FBLine."Line No.")) THEN
                ERROR('Operation Canceled.');
            END ELSE
        //<<NIF 031306 RTT
            //if find on contract, make sure have same replenishment method
            IF GetContractLine(SalesPrice,FBLine) THEN BEGIN
               IF FBLine."Replenishment Method" <> SalesPrice."Replenishment Method" THEN
                 IF NOT CONFIRM(STRSUBSTNO('The %1 for Item %2 UOM %3 does not match Contract. Do you want to continue?',
                        FBLine.FIELDNAME("Replenishment Method"),FBLine."Item No.",FBLine."Unit of Measure Code")) THEN
                   ERROR('Operation Canceled.');
            END ELSE
            IF NOT CONFIRM(STRSUBSTNO('Item %1 UOM %2 not found on Contract %3. Do you want to continue?',
                        FBLine."Item No.",FBLine."Unit of Measure Code",FBLine."Contract No.")) THEN
                   ERROR('Operation Canceled.');
          UNTIL FBLine.NEXT=0;
    end;

    procedure GetContractLine(var SalesPrice: Record "7002";FBLine: Record "50137"): Boolean
    begin
        SalesPrice.SETRANGE("Item No.",FBLine."Item No.");
        SalesPrice.SETRANGE("Variant Code",FBLine."Variant Code");
        SalesPrice.SETFILTER("Ending Date",'%1|>=%2',0D,WORKDATE);
        //>> NF1.00:CIS.NG 10/26/15
        //>>NIF 12-05-05
        IF FBLine."Customer Bin"<>'' THEN
          SalesPrice.SETRANGE("Customer Bin",FBLine."Customer Bin")
        ELSE
        //<<NIF 12-05-05
        //<< NF1.00:CIS.NG 10/26/15
          SalesPrice.SETRANGE("Unit of Measure Code",FBLine."Unit of Measure Code");
        SalesPrice.SETRANGE("Starting Date",0D,WORKDATE);
        SalesPrice.SETRANGE("Sales Type",SalesPrice."Sales Type"::Customer);
        SalesPrice.SETRANGE("Sales Code",FBLine."Sell-to Customer No.");
        SalesPrice.SETRANGE("Method of Fullfillment",SalesPrice."Method of Fullfillment"::FillBill);  //NF1.00:CIS.NG 10/26/15
        IF FBLine."Contract No." <> '' THEN
          SalesPrice.SETRANGE("Contract No.",FBLine."Contract No.");

        EXIT(SalesPrice.FIND('-'));
    end;
}

