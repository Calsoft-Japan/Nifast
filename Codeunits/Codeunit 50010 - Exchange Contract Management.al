codeunit 50010 "Exchange Contract Management"
{
    // >> IST
    // Date     Init  SCR    Description
    // 04-11-05 DPC   #9806  New Codeunit to handle "4X Contracts"
    //                #9806   - batch process Purchase Orders
    // << IST


    trigger OnRun()
    begin
        ERROR('Not Working');  //NG-N
        //PurchInvoiceSumLine.SETRANGE("Receiving Dock Code",FALSE);
        IF PurchInvoiceSumLine.FIND('-') THEN BEGIN // do we have any lines to post
          REPEAT
            IF  PurchInvoiceSumLine."Item No." = '' THEN BEGIN // do we have manually entered value in PO code ?
              //ExcContractHeader.SETRANGE("Vendor PO No.", PurchInvoiceSumLine."Vendor Order No.");
              //IF ExcContractHeader.FIND('-') THEN // Do we have any Exchange Contract Order
                //filter purchase Orders to match Exchange Contract No.
              PurchHeader.INIT;
        //      PurchHeader.SETRANGE("Contract Note No.", PurchInvoiceSumLine."Master Po No.");
              IF PurchHeader.FIND('-') THEN BEGIN// can we find a PO to post
                //PostPurchOrder; // Call to Post function
                IdentifyLines;
              END;
            END
            ELSE BEGIN
              IF PurchHeader.GET(PurchHeader."Document Type"::Order, PurchInvoiceSumLine."Item No.") THEN BEGIN
                PurchLine.SETRANGE("Document No.", PurchHeader."No.");

                IF PurchLine.FIND('-') THEN BEGIN // We now have the correct PO line to post!
                  PostLine(PurchLine);

                  TPurchHeader.SETRANGE("No.", PurchHeader."No.");

                  IF NOT TPurchHeader.FIND('-') THEN BEGIN // If the curr. PO Header is not in the temp table, then we add it.
                    PurchHeader.Receive := TRUE;
                    PurchHeader.Invoice := TRUE;
                    Increment := Increment + 1;
                    PurchHeader."Vendor Invoice No." := PurchInvoiceSumLine."Location Code" + ' - ' + FORMAT(Increment);

                    IF PurchHeader."Posting Date" = 0D THEN
                      PurchHeader."Posting Date" := WORKDATE;

                    PurchHeader.MODIFY;
                    TPurchHeader.INIT;
                    TPurchHeader.TRANSFERFIELDS(PurchHeader);
                    TPurchHeader.INSERT;
                  END;
                END;

              END;
            END;

          UNTIL PurchInvoiceSumLine.NEXT = 0;

        TPurchHeader.RESET;
        IF TPurchHeader.FIND('-') THEN BEGIN
          REPEAT
            PostPO.RUN(TPurchHeader);
          UNTIL TPurchHeader.NEXT = 0;

          CloseMaster(TPurchHeader."Contract Note No.");
          TPurchHeader.DELETEALL;
        END;

        // Show warning - need manual action
        IF ManWarning THEN
          MESSAGE(TEXT001);

        // All journal lines posted - show message
        IF NOT ManWarning THEN
          IF PurchInvoiceSumLine.NEXT = 0 THEN BEGIN
            ExcSumHeader.GET(PurchInvoiceSumLine."Location Code");
        //    ExcSumHeader.Closed := TRUE;
            ExcSumHeader.MODIFY;
            MESSAGE(TEXT002);
          END;

        END ELSE
          MESSAGE(TEXT005);
    end;

    var
        PurchHeader: Record "38";
        PurchPost: Codeunit "90";
        PurchInvoiceSumLine: Record "50012";
        ExcContractHeader: Record "50011";
        PostPO: Codeunit "90";
        Increment: Integer;
        TPurchLine: Record "39" temporary;
        PurchLine: Record "39";
        MessageText: Text[250];
        ManWarning: Boolean;
        TEXT001: Label 'Not All Journal Lines Could be Posted\Please select Purchase Orders to use for remaining lines.';
        TEXT002: Label 'All Journal lines Posted';
        PurchLine2: Record "39";
        ExcSumLine: Record "50012";
        ExcSumHeader: Record "50013";
        TEXT003: Label 'Please Manually Select another Exchange Contract or Specify a Spot Rate';
        TEXT004: Label 'Spot Rates Updated';
        TEXT005: Label 'No Lines to Post';
        TPurchHeader: Record "38" temporary;
        MasterHeader: Record "50011";
        TEXT006: Label 'Can''t add Spot Rates';

    procedure PostPurchOrder()
    begin
        ERROR('Not Working');  //NG-N
        PurchLine.INIT;
        PurchLine.SETRANGE("Document No.", PurchHeader."No.");

        IF PurchLine.FIND('-') THEN BEGIN// Set Qty. to Recieve = qty from jurnal line, else set value to 0.(do not post these lines)
          REPEAT
            IF PurchLine."No." = PurchInvoiceSumLine."Customer No." THEN BEGIN // this is the line we want to post
        //      PurchLine.VALIDATE("Qty. to Receive", PurchInvoiceSumLine."No.");
              PurchLine.MODIFY(TRUE);
            END
            ELSE BEGIN
              PurchLine.VALIDATE("Qty. to Receive", 0);
              PurchLine.VALIDATE("Qty. to Invoice", 0);
              PurchLine.MODIFY(TRUE);
            END;
          UNTIL PurchLine.NEXT = 0;

        PurchHeader.Receive := TRUE;
        PurchHeader.Invoice := TRUE;

        //Increment Vendor Invoice No.
        PurchHeader."Vendor Invoice No." := PurchHeader."Vendor Invoice No." + '-1';

        PostPO.RUN(PurchHeader);
        END;
    end;

    procedure IdentifyLines()
    begin
        ERROR('Not Working');  //NG-N
        TPurchLine.DELETEALL;
        IF PurchHeader.FIND('-') THEN
        REPEAT
          PurchLine.SETRANGE("Document No.", PurchHeader."No.");
          IF PurchLine.FIND('-') THEN
            REPEAT
        //      IF PurchLine."Outstanding Quantity" <> 0 THEN
        //        IF PurchLine."No." = PurchInvoiceSumLine."Customer No." THEN
        //          IF PurchInvoiceSumLine."No." = PurchLine.Quantity THEN BEGIN
        //            TPurchLine.INIT;
        //            TPurchLine.TRANSFERFIELDS(PurchLine);
        //            TPurchLine.INSERT;
        //          END;
            UNTIL PurchLine.NEXT = 0;
        UNTIL PurchHeader.NEXT = 0;

        IF TPurchLine.FIND('-') THEN
          IF TPurchLine.NEXT = 0 THEN BEGIN // means we only have 1 match !
            PostLine(TPurchLine);
          END
          ELSE
            ManWarning := TRUE;
    end;

    procedure PostLine(PurchLineToPost: Record "39")
    begin
        ERROR('Not Working');  //NG-N
        PurchLine2.INIT;
        PurchLine2.SETRANGE("Document No.", PurchLineToPost."Document No.");

        IF PurchLine2.FIND('-') THEN
          REPEAT
            IF PurchLine2."No." = PurchInvoiceSumLine."Customer No." THEN BEGIN // this is the line we want to post
        //      PurchLine2.VALIDATE("Qty. to Receive", PurchInvoiceSumLine."No.");
              PurchLine2.MODIFY(TRUE);
            END;
          UNTIL PurchLine2.NEXT = 0;

        //PurchInvoiceSumLine."Receiving Dock Code" := TRUE;
        PurchInvoiceSumLine.MODIFY;
    end;

    procedure ValidateLine(VendorPO: Code[20];ItemNo: Code[20];ItemQty: Decimal) "PO No.": Code[20]
    begin
        ERROR('Not Working');  //NG-N
        PurchHeader.INIT;
        PurchHeader.SETRANGE("Contract Note No.", VendorPO);

        IF PurchHeader.FIND('-') THEN BEGIN

        //
        TPurchLine.DELETEALL;
        //IF PurchHeader.FIND('-') THEN
        REPEAT
          PurchLine.SETRANGE("Document No.", PurchHeader."No.");
          IF PurchLine.FIND('-') THEN
            REPEAT
              IF PurchLine."Outstanding Quantity" <> 0 THEN
                IF PurchLine."No." = ItemNo THEN
                  IF ItemQty = PurchLine.Quantity THEN BEGIN
                    TPurchLine.INIT;
                    TPurchLine.TRANSFERFIELDS(PurchLine);
                    TPurchLine.INSERT;
                  END;
            UNTIL PurchLine.NEXT = 0;
        UNTIL PurchHeader.NEXT = 0;

        IF TPurchLine.FIND('-') THEN
          IF TPurchLine.NEXT = 0 THEN BEGIN // means we only have 1 match !
            "PO No." := PurchHeader."No."; // Value to return!
          END
          ELSE
            ManWarning := TRUE;
        END;
    end;

    procedure GetAllLines("Contract Note No.": Code[20])
    var
        Warning: Boolean;
    begin
        ERROR('Not Working');  //NG-N
        //Identify and PO lines and create ExcLines

        CLEAR(TPurchLine);
        ExcSumLine.SETRANGE(ExcSumLine."Location Code", "Contract Note No.");
        //ExcSumLine.DELETEALL;
        ExcContractHeader.INIT;
        ExcContractHeader.SETRANGE("Authorized By", "Contract Note No.");

        IF ExcContractHeader.FIND('-') THEN
          REPEAT
            PurchHeader.SETRANGE("Contract Note No.", ExcContractHeader."No.");
            IF PurchHeader.FIND('-') THEN
              REPEAT
                PurchLine.SETRANGE("Document No.", PurchHeader."No.");
                IF PurchLine.FIND('-') THEN
                  REPEAT
                    IF PurchLine."Outstanding Quantity" <> 0 THEN BEGIN
                      ExcSumLine."Customer No." := PurchLine."No.";
                      ExcSumLine."Location Code" := "Contract Note No.";
        //              ExcSumLine."No." := PurchLine.Quantity;
        //              ExcSumLine."Unit Of Measure" := PurchLine."Unit of Measure";
        //              ExcSumLine."Cross-Reference Type" := PurchLine.Description;
        //              ExcSumLine."Unit Price (JPY)" := PurchLine."Direct Unit Cost";
        //              ExcSumLine."Line Amount (JPY)" := PurchLine.Quantity * PurchLine."Direct Unit Cost";
        //              ExcSumLine."Release Number" := PurchLine."Unit Cost (LCY)";
                      ExcSumLine.VALIDATE("Item No.",PurchHeader."No.");
                      IF ExcSumLine."Cross-Reference No." = '' THEN
                        Warning := TRUE;
                      ExcSumLine.INSERT(TRUE);
                    END;
                  UNTIL PurchLine.NEXT = 0;
              UNTIL PurchHeader.NEXT = 0;
          UNTIL ExcContractHeader.NEXT = 0;

        IF Warning THEN
          MESSAGE(TEXT003);
    end;

    procedure UpdateSpotRates(ContractNo: Code[20])
    begin
        ERROR('Not Working');  //NG-N
        // If no Exchange Contract No. is specified, then Spot Rate will be copied from the header to the line

        ExcSumHeader.SETRANGE("Delivery Schedule Batch No.", ContractNo);

        IF ExcSumHeader.FIND('-') THEN BEGIN

          ExcSumLine.SETRANGE("Location Code", ExcSumHeader."Delivery Schedule Batch No.");
          ExcSumLine.SETRANGE("Cross-Reference No.",'');

          IF ExcSumLine.FIND('-') THEN BEGIN
            REPEAT
              ExcSumLine.VALIDATE("Model Year", ExcSumHeader."Customer No.");
              ExcSumLine.MODIFY;
            UNTIL ExcSumLine.NEXT = 0;

            MESSAGE(TEXT004);
          END
          ELSE
            MESSAGE(TEXT006);
        END;
    end;

    procedure UpdateExchContract("ExchContract No.": Code[20])
    var
        ExchContract: Record "50010";
    begin
        ERROR('Not Working');  //NG-N
        IF ExchContract.GET("ExchContract No.") THEN BEGIN
         ExchContract.RemainingAmount := 0;
         ExcSumLine.SETRANGE("Cross-Reference No.", ExchContract."No.");
          IF ExcSumLine.FIND('-') THEN
          REPEAT
        //    ExchContract.RemainingAmount := ExchContract.RemainingAmount - ExcSumLine."Line Amount (JPY)";
          UNTIL ExcSumLine.NEXT = 0;
          ExchContract.MODIFY;
        END;
    end;

    procedure CloseMaster("Master PO": Code[20])
    begin
        ERROR('Not Working');  //NG-N
        MasterHeader.SETRANGE("No.", "Master PO");
        IF MasterHeader.FIND('-') THEN BEGIN
          PurchHeader.SETRANGE("Contract Note No.", "Master PO");
            IF NOT PurchHeader.FIND('-') THEN BEGIN
        //      MasterHeader."Foreign Exchange Requested" := TRUE;
              MasterHeader.MODIFY;
            END;
        END;
    end;
}

