codeunit 50016 "EDI Create Delivery Schedule"
{
    // //>> NIF
    // Functions Modified:
    //   CreDetailLine()
    // 
    // Date   Init   Proj  Desc
    // 111505 RTT  #10477  code at CreDetailLine to pick up new fields
    // //<< NIF

    TableNo = 14002358;

    trigger OnRun()
    begin
        IF "Navision Document" <> 'I_DELFOR' THEN
          ERROR('EDI Navision Document %1 does not match this function.',"Navision Document");

        EDITemplate.GET("EDI Template Code");
        EDIRecDocHdr2.GET(
          "Trade Partner No.","Navision Document","EDI Document No.","EDI Version","Internal Doc. No.");
        IF EDIRecDocHdr2."Company Name" <> COMPANYNAME THEN
          ERROR(
            'The recive document %1 is for company %2.  You are currently in company %3.',
            EDIRecDocHdr2."Internal Doc. No.",EDIRecDocHdr2."Company Name",COMPANYNAME);
        IF "Document Created" = "Document Created"::"Delivery Schedule" THEN
          IF NOT CONFIRM(
            'Delivery Schedule has already been created.\' +
            'Do you wish to re-create it?') THEN
            ERROR('Delivery Schedule not created.');

        ProgressWindow.OPEN(
          'Delivery Schedule......\' +
          'Trading Partner      #1##################\' +
          'Reference No.        #2##################\' +
          'Internal Doc No.     #3########\' +
          'Customer No.         #4##################\' +
          'Item No.             #5##################\' +
          'Creating Lines       @6@@@@@@@@@@@@@@@@@@');

        ProgressWindow.UPDATE(1,"Trade Partner No.");
        ProgressWindow.UPDATE(3,"Internal Doc. No.");
        ProgressWindow.UPDATE(4,"Customer No.");

        EDITradePartner.GET(EDIRecDocHdr2."Trade Partner No.");

        EDIRecDocFields.RESET;
        EDIRecDocFields.SETCURRENTKEY("Internal Doc. No.","Field Name");
        EDIRecDocFields.SETRANGE("Internal Doc. No.",EDIRecDocHdr2."Internal Doc. No.");
        IF EDIRecDocFields.FIND('-') THEN BEGIN
          IF EDITradePartner."Customer No." <> '' THEN
            LastCustomerNo := EDITradePartner."Customer No."
          ELSE BEGIN
            EDIRecDocFields.RESET;
            EDIRecDocFields.SETCURRENTKEY("Internal Doc. No.","NAV Table No.","Nav Field No.");
            EDIRecDocFields.SETRANGE("Internal Doc. No.",EDIRecDocHdr2."Internal Doc. No.");
            EDIRecDocFields.SETRANGE("NAV Table No.",50020);
            EDIRecDocFields.SETRANGE("Nav Field No.",DeliverySchBatch.FIELDNO("Customer No."));
            IF EDIRecDocFields.FIND('-') THEN BEGIN
              EDICustCrossRef.RESET;
              EDICustCrossRef.SETRANGE("Trade Partner No.",EDIRecDocFields."Trade Partner No.");
              EDICustCrossRef.SETRANGE("EDI Sell To Code",COPYSTR(EDIRecDocFields."Field Text Value",1,20));
              EDICustCrossRef.FIND('-');
              LastCustomerNo := COPYSTR(EDIRecDocFields."Field Text Value",1,20);
            END;
          END;
        END;

        EDIRecDocFields.RESET;
        EDIRecDocFields.SETCURRENTKEY(
          EDIRecDocFields."Internal Doc. No.","NAV Table No.","Nav Field No.");
        EDIRecDocFields.SETRANGE(
          EDIRecDocFields."Internal Doc. No.","Internal Doc. No.");
        EDIRecDocFields.SETRANGE(EDIRecDocFields."NAV Table No.",50020);
        IF EDIRecDocFields.FIND('-') THEN BEGIN
          // Locking to prevent Deadlocking
          EDIRecDocHdr.LOCKTABLE;
          EDIRecDocFields.LOCKTABLE;
          DeliverySchBatch.LOCKTABLE;
          DeliverySchHeader.LOCKTABLE;
          DeliverySchLine.LOCKTABLE;


          DeliverySchBatch.INIT;
          CLEAR(DeliverySchBatch);

          DeliverySchBatch."EDI Trade Partner" := "Trade Partner No.";
          EDITradePartner.GET("Trade Partner No.");
          DeliverySchBatch.VALIDATE("Customer No.",LastCustomerNo);

          EDIRecDocHdr2."Customer No." := DeliverySchBatch."Customer No.";
          EDIRecDocHdr2.MODIFY;

          Customer.GET(DeliverySchBatch."Customer No.");
          ProgressWindow.UPDATE(4,DeliverySchBatch."Customer No.");
          EDIRecDocHdr2."Customer No." := DeliverySchBatch."Customer No.";
          EDIRecDocHdr2.MODIFY;

          DeliverySchBatch."EDI Internal Doc. No." := "Internal Doc. No.";
          MapPlnSchFields;
          DeliverySchBatch.INSERT(TRUE);

          ProgressWindow.UPDATE(2,DeliverySchBatch."No.");
          i := 1;

        END ELSE
          ERROR('There are no fields mapped to the Planning Schedule.');

        // Create Delviery Schedule Header
        CmdCount := 0;
        EDIRecDocFields.RESET;
        EDIRecDocFields.SETCURRENTKEY("Internal Doc. No.","Line No.");
        EDIRecDocFields.SETRANGE("Internal Doc. No.","Internal Doc. No.");
        ResetFSValues();
        ResetFSLValues();
        TotalLineElements := EDIRecDocFields.COUNT;
        TotalLines := 0;
        IF EDIRecDocFields.FIND('-') THEN
          REPEAT
            TotalLines := TotalLines + 1;
            IF EDIRecDocFields."Command ID" <> '' THEN BEGIN
              CommandEnd := FALSE;
              IF (CmdCount > 0) THEN
                IF CommandIDArray[CmdCount] = EDIRecDocFields."Command ID" THEN
                    CommandEnd := TRUE;
              IF NOT CommandEnd THEN BEGIN
                CmdCount := CmdCount + 1;
                CommandIDArray[CmdCount] := EDIRecDocFields."Command ID";

                IF ('PS' = COPYSTR(EDIRecDocFields."Command ID",1,2)) THEN BEGIN
                  DeliverySchHeader.SETRANGE("Delivery Schedule Batch No.",DeliverySchBatch."No.");

                  CLEAR(DeliverySchHeader);
                  DeliverySchHeader.INIT;
                  DeliverySchHeader."Delivery Schedule Batch No." := DeliverySchBatch."No.";
                  DeliverySchHeader."Customer No." := DeliverySchBatch."Customer No.";
                  DeliverySchHeader.INSERT(TRUE);
                  DeliverySchHeaderLoop := TRUE;
                END;
              END;
            END;

            IF EDIRecDocFields."Field Name" = 'EndDate' THEN
              EndDate := EDIRecDocFields."Field Date Value";
            IF EDIRecDocFields."Field Name" = 'StartDate' THEN
              StartDate := EDIRecDocFields."Field Date Value";

            // Delivery Schedule Header
            IF (EDIRecDocFields."Nav Field No." = DeliverySchHeader.FIELDNO(DeliverySchHeader."Item No.")) AND
               (EDIRecDocFields."NAV Table No." = 50012) THEN BEGIN
              LastItemNo := EDIRecDocFields."Field Text Value";
              LastCrossRefNo := '';
              LastItemCrossRefNo := '';
            END;
            IF (EDIRecDocFields."Nav Field No." = DeliverySchHeader.FIELDNO(DeliverySchHeader."EDI Item Cross Ref.")) AND
               (EDIRecDocFields."NAV Table No." = 50012) THEN BEGIN
              LastCrossRefNo := EDIRecDocFields."Field Text Value";
              LastItemNo := '';
              LastItemCrossRefNo := '';
            END;
            IF (EDIRecDocFields."Nav Field No." = DeliverySchHeader.FIELDNO(DeliverySchHeader."Cross-Reference No.")) AND
               (EDIRecDocFields."NAV Table No." = 50012) THEN BEGIN
              LastItemCrossRefNo := EDIRecDocFields."Field Text Value";
              LastCrossRefNo := '';
              LastItemNo := '';
            END;
            IF (EDIRecDocFields."Nav Field No." = DeliverySchHeader.FIELDNO(DeliverySchHeader."Location Code")) AND
               (EDIRecDocFields."NAV Table No." = 50012) THEN BEGIN
              LastLocationCode := EDIRecDocFields."Field Text Value";
            END;
            IF (EDIRecDocFields."Nav Field No." = DeliverySchHeader.FIELDNO(DeliverySchHeader."Model Year")) AND
               (EDIRecDocFields."NAV Table No." = 50012) THEN BEGIN
              LastModelYear := EDIRecDocFields."Field Text Value";
            END;
            IF (EDIRecDocFields."Nav Field No." = DeliverySchHeader.FIELDNO(DeliverySchHeader."Release Number")) AND
               (EDIRecDocFields."NAV Table No." = 50012) THEN BEGIN
              LastReleaseNumber := EDIRecDocFields."Field Text Value";
            END;
            IF (EDIRecDocFields."Nav Field No." = DeliverySchHeader.FIELDNO(DeliverySchHeader."Receiving Dock Code")) AND
               (EDIRecDocFields."NAV Table No." = 50012) THEN BEGIN
              LastReceivingDockCode := EDIRecDocFields."Field Text Value";
            END;
            IF (EDIRecDocFields."Nav Field No." = DeliverySchHeader.FIELDNO(DeliverySchHeader."Stockman Code")) AND
               (EDIRecDocFields."NAV Table No." = 50012) THEN BEGIN
              LastStockmanCode := EDIRecDocFields."Field Text Value";
            END;
            IF (EDIRecDocFields."Nav Field No." = DeliverySchHeader.FIELDNO(DeliverySchHeader."Order Reference No.")) AND
               (EDIRecDocFields."NAV Table No." = 50012) THEN BEGIN
              LastOrderReferenceNo := EDIRecDocFields."Field Text Value";
            END;
            IF (EDIRecDocFields."Nav Field No." = DeliverySchHeader.FIELDNO(DeliverySchHeader."Quantity CYTD")) AND
               (EDIRecDocFields."NAV Table No." = 50012) THEN BEGIN
              LastQuantityCYTD := EDIRecDocFields."Field Integer Value";
            END;
            IF (EDIRecDocFields."Nav Field No." = DeliverySchHeader.FIELDNO(DeliverySchHeader."Unit of Measure CYTD")) AND
               (EDIRecDocFields."NAV Table No." = 50012) THEN BEGIN
              LastUOMCYTD := EDIRecDocFields."Field Text Value";
            END;
            IF (EDIRecDocFields."Nav Field No." = DeliverySchHeader.FIELDNO(DeliverySchHeader."Start Date CYTD")) AND
               (EDIRecDocFields."NAV Table No." = 50012) THEN BEGIN
              LastStartDateCYTD := EDIRecDocFields."Field Date Value";
            END;
            IF (EDIRecDocFields."Nav Field No." = DeliverySchHeader.FIELDNO(DeliverySchHeader."End Date CYTD")) AND
               (EDIRecDocFields."NAV Table No." = 50012) THEN BEGIN
              LastEndDateCYTD := EDIRecDocFields."Field Date Value";
            END;
            IF (EDIRecDocFields."Nav Field No." = DeliverySchHeader.FIELDNO(DeliverySchHeader."Quantity Shipped CYTD")) AND
               (EDIRecDocFields."NAV Table No." = 50012) THEN BEGIN
              LastQuantityShippedCYTD := EDIRecDocFields."Field Integer Value";
            END;
            IF (EDIRecDocFields."Nav Field No." = DeliverySchHeader.FIELDNO(DeliverySchHeader."Unit of Measure Shipped CYTD")) AND
               (EDIRecDocFields."NAV Table No." = 50012) THEN BEGIN
              LastUOMShippedCYTD := EDIRecDocFields."Field Text Value";
            END;
            IF (EDIRecDocFields."Nav Field No." = DeliverySchHeader.FIELDNO(DeliverySchHeader."Start Date Shipped CYTD")) AND
               (EDIRecDocFields."NAV Table No." = 50012) THEN BEGIN
              LastStartDateShippedCYTD := EDIRecDocFields."Field Date Value";
            END;
            IF (EDIRecDocFields."Nav Field No." = DeliverySchHeader.FIELDNO(DeliverySchHeader."End Date Shipped CYTD")) AND
               (EDIRecDocFields."NAV Table No." = 50012) THEN BEGIN
              LastEndDateShippedCYTD := EDIRecDocFields."Field Date Value";
            END;


            //Delivery Schedule Line
            IF (EDIRecDocFields."Nav Field No." = DeliverySchLine.FIELDNO(DeliverySchLine."Type Code")) AND
               (EDIRecDocFields."NAV Table No." = 50013) THEN BEGIN
              LastTypeCode := EDIRecDocFields."Field Integer Value";
            END;
            IF (EDIRecDocFields."Nav Field No." = DeliverySchLine.FIELDNO(DeliverySchLine."Frequency Code")) AND
               (EDIRecDocFields."NAV Table No." = 50013) THEN BEGIN
              LastFrequencyCode := EDIRecDocFields."Field Text Value";
            END;
            IF (EDIRecDocFields."Nav Field No." = DeliverySchLine.FIELDNO(DeliverySchLine."Forecast Unit of Measure")) AND
               (EDIRecDocFields."NAV Table No." = 50013) THEN BEGIN
              LastForecastUOM := EDIRecDocFields."Field Text Value";
            END;
            IF (EDIRecDocFields."Nav Field No." = DeliverySchLine.FIELDNO(DeliverySchLine."Forecast Quantity")) AND
               (EDIRecDocFields."NAV Table No." = 50013) THEN BEGIN
              LastForecastQuantity := EDIRecDocFields."Field Integer Value";
            END;
            IF (EDIRecDocFields."Nav Field No." = DeliverySchLine.FIELDNO(DeliverySchLine."Expected Delivery Date")) AND
               (EDIRecDocFields."NAV Table No." = 50013) THEN BEGIN
              LastExpDeliveryDate := EDIRecDocFields."Field Date Value";
            END;
            IF (EDIRecDocFields."Nav Field No." = DeliverySchLine.FIELDNO(DeliverySchLine."Start Date")) AND
               (EDIRecDocFields."NAV Table No." = 50013) THEN BEGIN
              LastStartDate := EDIRecDocFields."Field Date Value";
            END;
            IF (EDIRecDocFields."Nav Field No." = DeliverySchLine.FIELDNO(DeliverySchLine."End Date")) AND
               (EDIRecDocFields."NAV Table No." = 50013) THEN BEGIN
              LastEndDate := EDIRecDocFields."Field Date Value";
            END;

            IF CommandEnd THEN
              IF DeliverySchHeaderLoop THEN BEGIN
                CreDetailHeader();
                ResetFSValues();
                CmdCount := CmdCount - 1;
                DeliverySchHeaderLoop := FALSE;
              END ELSE IF ('FS' = COPYSTR(EDIRecDocFields."Command ID",1,2)) THEN BEGIN
                CreDetailLine();
                ResetFSLValues();
                CmdCount := CmdCount - 1;
              END;

          UNTIL EDIRecDocFields.NEXT = 0;

        EDIRecDocHdr2."Document Created" := EDIRecDocHdr."Document Created"::"Delivery Schedule";
        EDIRecDocHdr2."Created Date" := WORKDATE;
        EDIRecDocHdr2."Created Time" := TIME;
        EDIRecDocHdr2."Data Error" := FALSE;

        EDIRecDocHdr2.MODIFY;

        COMMIT;

        ProgressWindow.CLOSE;
    end;

    var
        Customer: Record "18";
        EDITemplate: Record "14002350";
        EDITradePartner: Record "14002360";
        EDIRecDocHdr: Record "14002358";
        EDIRecDocHdr2: Record "14002358";
        EDIRecDocFields: Record "14002359";
        EDIRecDocFields2: Record "14002359";
        EDIRecDocFields3: Record "14002359";
        EDICustCrossRef: Record "14002362";
        EDICustCrossRef2: Record "14002362";
        TradePartnerUnitofMeasure: Record "14002365";
        TradePartnerItem: Record "14002364";
        ItemUnitOfMeasure: Record "5404";
        Item: Record "27";
        ReleaseSalesDocument: Codeunit "414";
        ProgressWindow: Dialog;
        i: Integer;
        j: Integer;
        BeginLineNo: Integer;
        EndLineNo: Integer;
        LastItemNo: Code[20];
        LastItemCrossRefNo: Code[20];
        LastItemRefNo: Integer;
        LastCrossRefNo: Code[20];
        LastUOM: Text[10];
        LastEDIUOM: Code[2];
        LastQty: Decimal;
        LastCustomerNo: Code[20];
        LastLocationCode: Code[20];
        LastModelYear: Code[10];
        LastReleaseNumber: Code[10];
        LastReceivingDockCode: Code[10];
        LastStockmanCode: Code[10];
        LastOrderReferenceNo: Code[20];
        LastQuantityCYTD: Integer;
        LastUOMCYTD: Text[10];
        LastStartDateCYTD: Date;
        LastEndDateCYTD: Date;
        LastQuantityShippedCYTD: Integer;
        LastUOMShippedCYTD: Text[10];
        LastStartDateShippedCYTD: Date;
        LastEndDateShippedCYTD: Date;
        LastTypeCode: Integer;
        LastFrequencyCode: Text[10];
        LastExpDeliveryDate: Date;
        LastForecastUOM: Text[10];
        LastForecastQuantity: Integer;
        LastStartDate: Date;
        LastEndDate: Date;
        PrevItemNo: Code[20];
        DeliverySchBatch: Record "50020";
        DeliverySchBatch2: Record "50020";
        DeliverySchHeader: Record "50012";
        DeliverySchLine: Record "50013";
        LineNo: Integer;
        FSLineNo: Integer;
        TotalLines: Integer;
        c: Integer;
        FoundCmdID: Boolean;
        CommandIDArray: array [1024] of Code[10];
        CmdCount: Integer;
        CommandEnd: Boolean;
        TotalLineElements: Integer;
        TotalFSLines: Integer;
        NavBaseQty: Integer;
        OrderBaseQty: Integer;
        MultiplierQty: Integer;
        TotalDelvieryScheduleHdr: Integer;
        StartDate: Date;
        EndDate: Date;
        DeliverySchHeaderLoop: Boolean;

    procedure MapPlnSchFields()
    begin
        EDIRecDocFields.RESET;
        EDIRecDocFields.SETCURRENTKEY("Internal Doc. No.","NAV Table No.","Nav Field No.");
        EDIRecDocFields.SETRANGE("Internal Doc. No.",EDIRecDocHdr2."Internal Doc. No.");
        EDIRecDocFields.SETRANGE(EDIRecDocFields."NAV Table No.",50020);
        IF EDIRecDocFields.FIND('-') THEN
          REPEAT
            CASE EDIRecDocFields."Nav Field No." OF
              DeliverySchBatch.FIELDNO(DeliverySchBatch."Release No."):
                DeliverySchBatch."Release No." := EDIRecDocFields."Field Text Value";
              DeliverySchBatch.FIELDNO(DeliverySchBatch."Expected Delivery Date"):
                DeliverySchBatch."Expected Delivery Date" := EDIRecDocFields."Field Date Value";
              DeliverySchBatch.FIELDNO(DeliverySchBatch."Horizon Start Date"):
                DeliverySchBatch."Horizon Start Date" := EDIRecDocFields."Field Date Value";
              DeliverySchBatch.FIELDNO(DeliverySchBatch."Horizon End Date"):
                DeliverySchBatch."Horizon End Date" := EDIRecDocFields."Field Date Value";
              DeliverySchBatch.FIELDNO(DeliverySchBatch."Material Issuer No."):
                DeliverySchBatch."Material Issuer No." := EDIRecDocFields."Field Text Value";
              DeliverySchBatch.FIELDNO(DeliverySchBatch."Material Issuer Name"):
                DeliverySchBatch."Material Issuer Name" := EDIRecDocFields."Field Text Value";
              DeliverySchBatch.FIELDNO(DeliverySchBatch."Material Issuer Name 2"):
                DeliverySchBatch."Material Issuer Name 2" := EDIRecDocFields."Field Text Value";
              DeliverySchBatch.FIELDNO(DeliverySchBatch."Material Issuer Address"):
                DeliverySchBatch."Material Issuer Address" := EDIRecDocFields."Field Text Value";
              DeliverySchBatch.FIELDNO(DeliverySchBatch."Material Issuer Address 2"):
                DeliverySchBatch."Material Issuer Address 2" := EDIRecDocFields."Field Text Value";
              DeliverySchBatch.FIELDNO(DeliverySchBatch."Material Issuer City"):
                DeliverySchBatch."Material Issuer City" := EDIRecDocFields."Field Text Value";
              DeliverySchBatch.FIELDNO(DeliverySchBatch."Material Issuer State"):
                DeliverySchBatch."Material Issuer State" := EDIRecDocFields."Field Text Value";
              DeliverySchBatch.FIELDNO(DeliverySchBatch."Material Issuer Postal Code"):
                DeliverySchBatch."Material Issuer Postal Code" := EDIRecDocFields."Field Text Value";
              DeliverySchBatch.FIELDNO(DeliverySchBatch."Material Issuer Country Code"):
                DeliverySchBatch."Material Issuer Country Code" := EDIRecDocFields."Field Text Value";
              DeliverySchBatch.FIELDNO(DeliverySchBatch."Supplier No."):
                DeliverySchBatch."Supplier No." := EDIRecDocFields."Field Text Value";
              DeliverySchBatch.FIELDNO(DeliverySchBatch."Supplier Name"):
                DeliverySchBatch."Supplier Name" := EDIRecDocFields."Field Text Value";
              DeliverySchBatch.FIELDNO(DeliverySchBatch."Supplier Name 2"):
                DeliverySchBatch."Supplier Name 2" := EDIRecDocFields."Field Text Value";
              DeliverySchBatch.FIELDNO(DeliverySchBatch."Supplier Address"):
                DeliverySchBatch."Supplier Address" := EDIRecDocFields."Field Text Value";
              DeliverySchBatch.FIELDNO(DeliverySchBatch."Supplier Address 2"):
                DeliverySchBatch."Supplier Address 2" := EDIRecDocFields."Field Text Value";
              DeliverySchBatch.FIELDNO(DeliverySchBatch."Supplier City"):
                DeliverySchBatch."Supplier City" := EDIRecDocFields."Field Text Value";
              DeliverySchBatch.FIELDNO(DeliverySchBatch."Supplier State"):
                DeliverySchBatch."Supplier State" := EDIRecDocFields."Field Text Value";
              DeliverySchBatch.FIELDNO(DeliverySchBatch."Supplier Postal Code"):
                DeliverySchBatch."Supplier Postal Code" := EDIRecDocFields."Field Text Value";
              DeliverySchBatch.FIELDNO(DeliverySchBatch."Supplier Country Code"):
                DeliverySchBatch."Supplier Country Code" := EDIRecDocFields."Field Text Value";
              DeliverySchBatch.FIELDNO(DeliverySchBatch."Document Function Code"):
                DeliverySchBatch.VALIDATE("Document Function Code",EDIRecDocFields."Field Integer Value");

            END;
          UNTIL EDIRecDocFields.NEXT = 0;
    end;

    procedure ResetFSValues()
    begin

        LastItemNo := '';
        LastItemCrossRefNo := '';
        LastItemRefNo := 0;
        LastCrossRefNo := '';
        LastUOM := '';
        LastEDIUOM := '';
        LastQty := 0;
        LastCustomerNo := '';
        LastLocationCode := '';
        LastModelYear := '';
        LastReleaseNumber := '';
        LastReceivingDockCode := '';
        LastStockmanCode := '';
        LastOrderReferenceNo := '';
        LastQuantityCYTD := 0;
        LastUOMCYTD := '';
        LastStartDateCYTD := 0D;
        LastEndDateCYTD := 0D;
        LastQuantityShippedCYTD := 0;
        LastUOMShippedCYTD := '';
        LastStartDateShippedCYTD := 0D;
        LastEndDateShippedCYTD := 0D;
        StartDate := 0D;
        EndDate := 0D;
    end;

    procedure ResetFSLValues()
    begin

        LastTypeCode := 0;
        LastFrequencyCode := '';
        LastForecastUOM := '';
        LastForecastQuantity := 0;
        LastExpDeliveryDate := 0D;
        LastStartDate := 0D;
        LastEndDate := 0D;
        StartDate := 0D;
        EndDate := 0D;
    end;

    procedure CreDetailLine()
    begin

        DeliverySchLine.SETRANGE("Delivery Schedule Batch No.",DeliverySchHeader."Delivery Schedule Batch No.");
        DeliverySchLine.SETRANGE("Customer No.",DeliverySchHeader."Customer No.");
        DeliverySchLine.SETRANGE("Document No.",DeliverySchHeader."No.");
        IF DeliverySchLine.FIND('+') THEN
          LineNo := DeliverySchLine."Line No." + 10000
        ELSE
          LineNo := 10000;

        DeliverySchLine.INIT;
        DeliverySchLine."Delivery Schedule Batch No." := DeliverySchHeader."Delivery Schedule Batch No.";
        DeliverySchLine."Customer No." := DeliverySchHeader."Customer No.";
        DeliverySchLine."Document No." := DeliverySchHeader."No.";
        DeliverySchLine."Line No." := LineNo;

        DeliverySchLine.VALIDATE("Type Code",LastTypeCode);
        DeliverySchLine.VALIDATE("Frequency Code",LastFrequencyCode);
        DeliverySchLine."Forecast Quantity" := LastForecastQuantity;
        DeliverySchLine."Expected Delivery Date" := LastExpDeliveryDate;
        IF LastStartDate <> 0D THEN
          DeliverySchLine."Start Date" := LastStartDate
        ELSE
          DeliverySchLine."Start Date" := StartDate;
        IF LastEndDate <> 0D THEN
          DeliverySchLine."End Date" := LastEndDate
        ELSE
          DeliverySchLine."End Date" := EndDate;

        //>>  NIF 111505 RTT #10477
        //istrtt 8523
        IF DeliverySchHeader."Item No."<>'' THEN
          DeliverySchLine."Item No." := DeliverySchHeader."Item No.";
        IF DeliverySchHeader."Model Year"<>'' THEN
          DeliverySchLine."Model Year" := DeliverySchHeader."Model Year";
        //<< NIF 111505 RTT #10477


        DeliverySchLine.INSERT(TRUE);

        IF TotalLines <> 0 THEN
          ProgressWindow.UPDATE(6,ROUND(10000 * (TotalLines / TotalLineElements),1));

        EDIRecDocFields."Document No." := FORMAT(DeliverySchLine."Document No.");
        EDIRecDocFields."Document Line No." := DeliverySchLine."Line No.";
        EDIRecDocFields.MODIFY;
    end;

    procedure CreDetailHeader()
    begin

        DeliverySchHeader."Location Code" := LastLocationCode;
        DeliverySchHeader."Model Year" := LastModelYear;
        DeliverySchHeader."Release Number" := LastReleaseNumber;
        DeliverySchHeader."Receiving Dock Code" := LastReceivingDockCode;
        DeliverySchHeader."Stockman Code" := LastStockmanCode;
        DeliverySchHeader."Order Reference No." := LastOrderReferenceNo;
        DeliverySchHeader."Quantity CYTD" := LastQuantityCYTD;
        DeliverySchHeader."Unit of Measure CYTD" := LastUOMCYTD;
        DeliverySchHeader."Start Date CYTD" := LastStartDateCYTD;
        DeliverySchHeader."End Date CYTD" := LastEndDateCYTD;
        DeliverySchHeader."Quantity Shipped CYTD" := LastQuantityShippedCYTD;
        DeliverySchHeader."Unit of Measure Shipped CYTD" := LastUOMShippedCYTD;
        IF LastStartDateShippedCYTD <> 0D THEN
          DeliverySchHeader."Start Date Shipped CYTD" := LastStartDateShippedCYTD
        ELSE
          DeliverySchHeader."Start Date Shipped CYTD" := LastStartDateShippedCYTD;
        IF LastEndDateShippedCYTD <> 0D THEN
          DeliverySchHeader."End Date Shipped CYTD" := LastEndDateShippedCYTD
        ELSE
          DeliverySchHeader."End Date Shipped CYTD" := LastEndDateShippedCYTD;

        IF (LastCrossRefNo <> '') OR (LastItemCrossRefNo <> '') THEN BEGIN
          IF LastItemCrossRefNo <> '' THEN BEGIN
            DeliverySchHeader."Cross-Reference Type" := DeliverySchHeader."Cross-Reference Type"::Customer;
            DeliverySchHeader."Cross-Reference Type No." := DeliverySchHeader."Customer No.";
            DeliverySchHeader."Cross-Reference No." := LastItemCrossRefNo;
            DeliverySchHeader.VALIDATE(DeliverySchHeader."Cross-Reference No.",LastItemCrossRefNo);
            IF DeliverySchHeader."Item No." = '' THEN BEGIN
              DeliverySchHeader."Cross-Reference No." := LastItemCrossRefNo;
              DeliverySchHeader."Cross-Reference No. Not Found" := TRUE;
              ProgressWindow.UPDATE(5,LastItemCrossRefNo);
            END;
          END;
          IF LastCrossRefNo <> '' THEN BEGIN
            TradePartnerItem.RESET;
            TradePartnerItem.SETCURRENTKEY("Trade Partner No.","Partner Item No.");
            TradePartnerItem.SETRANGE("Trade Partner No.",EDIRecDocHdr2."Trade Partner No.");
            TradePartnerItem.SETRANGE("Partner Item No.",LastCrossRefNo);
            IF TradePartnerItem.FIND('-') THEN
              LastItemNo := TradePartnerItem."Navision Item No."
            ELSE
              LastItemNo := LastCrossRefNo;

            DeliverySchHeader.VALIDATE("Item No.",LastItemNo);
            DeliverySchHeader."EDI Item Cross Ref." := LastCrossRefNo;
            ProgressWindow.UPDATE(5,LastCrossRefNo);
          END;
        END ELSE BEGIN
          DeliverySchHeader.VALIDATE("Item No.",LastItemNo);
          ProgressWindow.UPDATE(5,LastItemNo);
        END;

        DeliverySchHeader.MODIFY(TRUE);

        TotalDelvieryScheduleHdr := TotalDelvieryScheduleHdr + 1;
        IF PrevItemNo <> DeliverySchHeader."Item No." THEN BEGIN
          PrevItemNo := DeliverySchHeader."Item No.";
          ProgressWindow.UPDATE(5,PrevItemNo);
        END;
    end;
}

