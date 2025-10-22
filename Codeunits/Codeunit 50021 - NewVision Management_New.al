codeunit 50021 "NewVision Management_New"
{
    // NF1.00:CIS.NG  09-01-15 Merged during upgrade. Rename the NV Add-on Codeunit 14018100 - "NewVision Management" --> 50021 "NewVision Management"
    // NF1.00:CIS.CM  09-29-15 Update for New Vision Removal Task
    // NF1.00:CIS.NG  11-03-15 Comment code (Query Repalce function is not available in NAV 2015)
    // NF1.00:CIS.NG  10-12-15 Added code to generate the dimension set id
    // ----------------------------------------------------------------------------------------------------
    // NV4.30 02.16.04 JWW: Added ItemQtyAvailable()
    //                      Changed UpdateSalesLineInfo() to use ItemQtyAvailable()
    //                      Changed UpdatePurchaseLineInfo() to use ItemQtyAvailable()
    // ----------------------------------------------------------------------------------------------------
    // >> NIF
    // Functions Added:
    //   CreateWhseShptTrkgLines
    //   RemoveItemTrackingLines
    //   AddItemTrackingLines
    //   GetBinTypeFilter
    //   SuggestLotEntryLines
    //   ClearLotEntryLines
    //   CreateWhseShptItemTrkgLines
    //   ClearWhseItemTrackingLines
    //   AddWhseItemTrackingLines
    //   DebugCreateFile  clear
    //   DebugWriteFile
    //   LotHistory
    //   CreateMovement
    //   ApplyWhseEntry
    //   GetLotBinContentsNonBin
    // Properties Added:
    //   Permissions
    // Date     Init  Proj  Desc
    // 03-30-05 RTT  #9876  new functions added
    // 05-25-05 RTT         added function ApplyWhseEntry due to permission problem
    // 05-25-05 RTT         added Permission property: TableData Warehouse Entry=m
    // 06-29-05 RTT         added LookupDrawingRevision; called from Sales Line and Purch Line tables
    // 07-10-05 rtt         code at AddItemTrackingLines to filter on revision if sales order
    // 07-29-05 RTT         code at AddItemTrackingLines to filter on "Block Movement" field of bin content
    // 08-31-05 RTT         Code to account for qtys already allocated for a given Order
    //                      -new global var LotBinContentAlloc
    //                      -new fcn UpdateLotBinContentAlloc
    //                      -code at SuggestLotEntryLines to init table
    //                      -code at AddItemTrackingLines to include/update alloc table
    // 12-08-05 RTT         New function GetLotBinContentsNonBin
    //                      -code at SuggestLotEntryLines
    //                      -code at AddItemTrackingLines
    // 02-16-06 RTT         New function GetUserDefaultDims
    //                      -code at CreateMovementLoc and CreateMovementReclass to call function
    // 03-13-06 RTT         Code at CreateMovementReclass to prevent dupl lot
    // 05-09-06 RTT         New function SetPedimentoInfo() (used in conjunction with Lot Reclass)
    //                      -new var TempLotNoInfo
    //                      -code at CreateMovementReclass() to populate Mex fields
    // << NIF
    // 
    // 061407 new CreateConnectionString()
    // CIS.Ram 08/24/17 UserIDCode variable size is increased to 50
    // 
    // NIF1.01,10/11/21,ST: Enhancements for provision to user to select Applies to Entry when posting reclass. journal.
    //                       - Added new function "SetAppliesToEntryNo" and global variables.
    //                       - Added code in function "CreateMovementReclass".

    Permissions = TableData 7312 = m;

    trigger OnRun()
    begin
    end;

    var
        TempDimSetEntry: Record 480 temporary;
        TempLotNoInfo: Record 6505 temporary;
        LotBinContentAlloc: Record 50001 temporary;
        DimMgt_gCdu: Codeunit 408;
        AppliesToEntryNoGbl: Integer;
        RFDebugFileName: Label 'C:\RFDebug.TXT';

    procedure CheckPermission(Permission: Integer): Boolean
    var
        UserSetup: Record 91;
    begin
        IF UserSetup.GET(USERID) THEN BEGIN
            CASE Permission OF
                UserSetup.FIELDNO("Edit Customer"):
                    IF UserSetup."Edit Customer" THEN
                        EXIT(TRUE);
                UserSetup.FIELDNO("Edit Vendor"):
                    IF UserSetup."Edit Vendor" THEN
                        EXIT(TRUE);
                UserSetup.FIELDNO("Edit Item"):
                    IF UserSetup."Edit Item" THEN
                        EXIT(TRUE);
                UserSetup.FIELDNO("Gross Profit Override"):
                    IF UserSetup."Gross Profit Override" THEN
                        EXIT(TRUE);
                UserSetup.FIELDNO("Edit Resource"):
                    IF UserSetup."Edit Resource" THEN
                        EXIT(TRUE);
            END;
            EXIT(FALSE);
        END ELSE
            MESSAGE('You are not setup as a valid user.');
    end;

    procedure TestGPPercent(GBPG: Code[10]; var Amount: Decimal; Cost: Decimal; GPPG: Code[10])
    var
        GenPostingGroup: Record 252;
        GPP: Decimal;
        Max_GPP: Decimal;
        Min_GPP: Decimal;
        GPOption: Option Warning,Override,Denied;
        cString: Text[120];
    begin
        Min_GPP := 0;
        Max_GPP := 0;
        GPP := 0;

        GPP := CalcGPPercent(Cost, Amount);

        IF GenPostingGroup.GET(GBPG, GPPG) THEN BEGIN
            Min_GPP := GenPostingGroup."Gross Profit Min %";
            Max_GPP := GenPostingGroup."Gross Profit Max %";
            GPOption := GenPostingGroup."Gross Profit Option";
        END;

        IF Min_GPP <> 0 THEN
            IF GPP < Min_GPP THEN BEGIN
                cString := 'The gross profit percent of ' + FORMAT(GPP) +
                         '\is less than the minimum percent of ' + FORMAT(Min_GPP);
                CASE GPOption OF
                    GPOption::Warning:

                        MESSAGE(cString);
                    GPOption::Override:

                        IF NOT CheckPermission(14017625) THEN
                            ERROR(cString);
                    GPOption::Denied:

                        ERROR(cString);
                END;
            END;

        IF Max_GPP <> 0 THEN
            IF GPP > Max_GPP THEN BEGIN
                cString := 'The gross profit percent of ' + FORMAT(GPP) +
                '\is more than the maximum percent of ' + FORMAT(Max_GPP);
                CASE GPOption OF
                    GPOption::Warning:

                        MESSAGE(cString);
                    GPOption::Override:

                        IF NOT CheckPermission(14017625) THEN
                            ERROR(cString);
                    GPOption::Denied:

                        ERROR(cString);
                END;
            END;
    end;

    procedure CopyLineCommentLines(FromDocumentType: Integer; ToDocumentType: Integer; FromNumber: Code[20]; ToNumber: Code[20]; FromLine: Integer; ToLine: Integer)
    begin
        //>> NF1.00:CIS.CM 09-29-15
        //SalesLineCommentLine.SETRANGE("Document Type",FromDocumentType);
        //SalesLineCommentLine.SETRANGE("No.",FromNumber);
        //SalesLineCommentLine.SETRANGE("Doc. Line No.",FromLine);
        //IF SalesLineCommentLine.FIND('-') THEN
        //  REPEAT
        //    SalesLineCommentLine2 := SalesLineCommentLine;
        //    SalesLineCommentLine2."Document Type" := ToDocumentType;
        //    SalesLineCommentLine2."No." := ToNumber;
        //    SalesLineCommentLine2."Doc. Line No." := ToLine;
        //    SalesLineCommentLine2.INSERT;
        //  UNTIL SalesLineCommentLine.NEXT = 0;
        //<< NF1.00:CIS.CM 09-29-15
    end;

    procedure CalcGPPercent(Cost: Decimal; var Price: Decimal): Decimal
    begin
        IF Price <> 0 THEN
            EXIT(ROUND(((Price - Cost) / Price) * 100, 0.01))
        ELSE
            EXIT(0);
    end;

    procedure StripNonNumeric(ValueIn: Text[250]) ValueOut: Text[250]
    var
        Length: Integer;
        Position: Integer;
    begin
        Position := 1;
        Length := STRLEN(ValueIn);
        WHILE (Position <= Length) DO
            IF STRPOS('0123456789', COPYSTR(ValueIn, Position, 1)) = 0 THEN BEGIN
                ValueIn := DELCHR(ValueIn, '=', COPYSTR(ValueIn, Position, 1));
                Length := STRLEN(ValueIn);
                Position := 1;
            END ELSE
                Position := Position + 1;
        ValueOut := ValueIn;
    end;

    procedure StripSpecialChars()
    begin
    end;

    // procedure LostSaleQuote(Quote: Record 36)
    // var
    //     QuoteLines: Record 37;
    //     ReasonCode: Record 231;
    // begin
    //     //>> NF1.00:CIS.CM 09-29-15
    //     //CLEAR(LostSalesHeader);
    //     //LostSalesHeader.INIT;
    //     //LostSalesHeader.TRANSFERFIELDS(Quote);
    //     //LostSalesHeader."Reason Code" := '';
    //     //IF LostSalesHeader.INSERT THEN BEGIN
    //     // QuoteLines.SETRANGE("Document Type",Quote."Document Type");
    //     // QuoteLines.SETRANGE("Document No.",Quote."No.");
    //     // IF QuoteLines.FIND('-') THEN REPEAT
    //     //  LostSalesLine.INIT;
    //     //  LostSalesLine.TRANSFERFIELDS(QuoteLines);
    //     //  LostSalesLine.INSERT;
    //     // UNTIL QuoteLines.NEXT=0;
    //     // COMMIT;
    //     // IF ACTION::LookupOK=PAGE.RUNMODAL(0,ReasonCode) THEN BEGIN
    //     //  LostSalesHeader."Reason Code" := ReasonCode.Code;
    //     //  LostSalesHeader.MODIFY;
    //     // END;
    //     //END;
    //     //<< NF1.00:CIS.CM 09-29-15
    // end;

    // procedure LostSaleOrder("Order": Record "36")
    // var
    //     OrderLines: Record "37";
    //     ReasonCode: Record "231";
    // begin
    //     //>> NF1.00:CIS.CM 09-29-15
    //     //CLEAR(LostSalesHeader);
    //     //LostSalesHeader.INIT;
    //     //LostSalesHeader.TRANSFERFIELDS(Order);
    //     //LostSalesHeader."Reason Code" := '';
    //     //IF LostSalesHeader.INSERT THEN BEGIN
    //     // OrderLines.SETRANGE("Document Type",Order."Document Type");
    //     // OrderLines.SETRANGE("Document No.",Order."No.");
    //     // IF OrderLines.FIND('-') THEN REPEAT
    //     //  LostSalesLine.INIT;
    //     //  LostSalesLine.TRANSFERFIELDS(OrderLines);
    //     //  LostSalesLine.INSERT;
    //     // UNTIL OrderLines.NEXT=0;
    //     // COMMIT;
    //     // IF ACTION::LookupOK=PAGE.RUNMODAL(0,ReasonCode) THEN BEGIN
    //     //  LostSalesHeader."Reason Code" := ReasonCode.Code;
    //     //  LostSalesHeader.MODIFY;
    //     // END;
    //     //END;
    //     //<< NF1.00:CIS.CM 09-29-15
    // end;

    // procedure CheckNVGranule(Granule: Text[100]): Boolean
    // begin
    //     //EXIT(NVL.CheckNVLicense(Granule));  // NF1.00:CIS.CM 09-29-15
    // end;

    procedure CheckCreditAutoHoldHeader(SalesHeader: Record 36): Boolean
    var
        Cust: Record 18;
        SRSetup: Record 311;
        CustCreditAmountUSD: Decimal;
    begin
        SRSetup.GET();
        IF NOT SRSetup."Auto Credit Hold" THEN EXIT(FALSE);
        Cust.GET(SalesHeader."Bill-to Customer No.");
        Cust.SETFILTER("Date Filter", '..%1', WORKDATE());
        Cust.CALCFIELDS("Balance (LCY)", "Outstanding Orders (LCY)", "Shipped Not Invoiced (LCY)");
        CustCreditAmountUSD := Cust."Balance (LCY)" + Cust."Shipped Not Invoiced (LCY)" +
                               Cust."Outstanding Orders (LCY)";
        IF Cust."Hold Days" <> 0 THEN BEGIN
            Cust.CALCFIELDS("Past Due Date");
            IF ((WORKDATE() - Cust."Past Due Date") > Cust."Hold Days") THEN EXIT(TRUE);
        END;
        EXIT((CustCreditAmountUSD > Cust."Credit Limit (LCY)") AND
             (Cust."Credit Limit (LCY)" <> 0));
    end;

    procedure CheckCreditAutoHoldLine(SalesLine: Record 37): Boolean
    var
        Cust: Record 18;
        SalesLine2: Record 37;
        SRSetup: Record 311;
        CustCreditAmountUSD: Decimal;
    begin
        SRSetup.GET();
        IF NOT SRSetup."Auto Credit Hold" THEN EXIT(FALSE);
        Cust.GET(SalesLine."Bill-to Customer No.");
        Cust.SETFILTER("Date Filter", '..%1', WORKDATE());
        Cust.CALCFIELDS("Balance (LCY)", "Outstanding Orders (LCY)", "Shipped Not Invoiced (LCY)");
        SalesLine2.RESET();
        SalesLine2.SETRANGE("Document Type", SalesLine."Document Type");
        SalesLine2.SETRANGE("Document No.", SalesLine."Document No.");
        SalesLine2.CALCSUMS("Outstanding Amount (LCY)", "Shipped Not Invoiced (LCY)");
        CustCreditAmountUSD := Cust."Balance (LCY)" + Cust."Shipped Not Invoiced (LCY)" +
                               Cust."Outstanding Orders (LCY)" +
                               SalesLine2."Outstanding Amount (LCY)" + SalesLine2."Shipped Not Invoiced (LCY)";
        EXIT((CustCreditAmountUSD > Cust."Credit Limit (LCY)") AND
             (Cust."Credit Limit (LCY)" <> 0));
    end;

    procedure UpdateSalesLineInfo(SalesLine: Record 37; var LDec: array[20] of Decimal; var LDate: array[10] of Date; var LineItem: Record 27; var LocationItem: Record 27)
    var
        ILE: Record 32;
        SalesLineTotal: Record 37;
        CompanyInfo: Record 79;
        AvailToPromise: Codeunit 5790;
        GrossReq: Decimal;
        SchedRcpt: Decimal;
    begin
        CLEAR(LDec);
        CLEAR(LDate);
        CLEAR(LocationItem);
        CLEAR(LineItem);
        // LDate array:
        // 1 LastSaleDate

        // LDec array:
        // 1  LastSalePrice
        // 2  AvailableQty
        // 3  OrderAmount
        // 4  OrderWeight
        // 5  OrderCost
        // 6  LineMarginAmt
        // 7  OrderMarginAmt
        // 8  LineMarginPer
        // 9  OrderMarginPer
        // 10 LineAmountToShip
        // 11 LineAmountToInvoice
        // 12 LastSaleQty
        // 13 LocationAvailableQty

        SalesLineTotal.SETRANGE("Document Type", SalesLine."Document Type");
        SalesLineTotal.SETRANGE("Document No.", SalesLine."Document No.");
        SalesLineTotal.CALCSUMS("Line Amount", "Line Gross Weight", "Line Cost",
                                "Line Amount to Ship", "Line Amount to Invoice");
        LDec[3] := SalesLineTotal."Line Amount";
        LDec[4] := SalesLineTotal."Line Gross Weight";
        LDec[5] := SalesLineTotal."Line Cost";
        LDec[6] := SalesLine."Line Amount" - SalesLine."Line Cost";
        LDec[7] := LDec[3] - LDec[5];
        LDec[8] := CalcGPPercent(SalesLine."Line Cost", SalesLine."Line Amount");
        LDec[9] := CalcGPPercent(LDec[5], LDec[3]);
        LDec[10] := SalesLineTotal."Line Amount to Ship";
        LDec[11] := SalesLineTotal."Line Amount to Invoice";
        IF (SalesLine.Type = SalesLine.Type::Item) AND (SalesLine."No." <> '') THEN BEGIN
            ILE.SETCURRENTKEY("Entry Type", "Item No.", "Variant Code", "Source Type", "Source No.", "Posting Date");
            ILE.SETRANGE("Item No.", SalesLine."No.");
            ILE.SETRANGE("Variant Code", SalesLine."Variant Code");
            ILE.SETRANGE("Entry Type", ILE."Entry Type"::Sale);
            ILE.SETRANGE("Source Type", ILE."Source Type"::Customer);
            ILE.SETRANGE("Source No.", SalesLine."Sell-to Customer No.");
            ILE.SETFILTER("Invoiced Quantity", '<>%1', 0);
            IF ILE.FIND('+') THEN BEGIN
                LDate[1] := ILE."Posting Date";
                ILE.CALCFIELDS("Sales Amount (Actual)");
                LDec[1] := (ABS(ILE."Sales Amount (Actual)") / ABS(ILE."Invoiced Quantity"));
                LDec[12] := ILE."Invoiced Quantity"
            END;
            LineItem.RESET();
            LineItem.GET(SalesLine."No.");
            LineItem.SETRANGE("No.", SalesLine."No.");
            IF SalesLine."Variant Code" <> '' THEN LineItem.SETRANGE("Variant Filter", SalesLine."Variant Code");
            LineItem.SETRANGE("Date Filter", 0D, WORKDATE());
            //>>NV4.30 02.16.04 JWW: Changed following to use new ItemQtyAvailable() for standardization
            /*
              CompanyInfo.GET;
              AvailToPromise.QtyAvailabletoPromise(
               LineItem,GrossReq,SchedRcpt,LineItem.GETRANGEMAX("Date Filter"),
               CompanyInfo."Check-Avail. Time Bucket",CompanyInfo."Check-Avail. Period Calc.");
              LineItem.CALCFIELDS(Inventory,"Reserved Qty. on Inventory");
              LDec[2] := LineItem.Inventory - LineItem."Reserved Qty. on Inventory" + SchedRcpt - GrossReq;
            */
            // IST 04.06.04 JWW: Added next line
            //>> NF1.00:CIS.CM  09/29/15
            //LineItem.CALCFIELDS(Inventory,"Reserved Qty. on Inventory","Qty. on Purch. Order",
            //                    "Qty. on Sales Order","Qty. in Transit","Qty. on Prod. Kit",
            //                    "Qty. on Prod. Kit Lines","Qty. on Prod. Order","Qty. on Component Lines");
            LineItem.CALCFIELDS(Inventory, "Reserved Qty. on Inventory", "Qty. on Purch. Order",
                                "Qty. on Sales Order", "Qty. in Transit", "Qty. on Prod. Order", "Qty. on Component Lines");
            //<< NF1.00:CIS.CM  09/29/15
            LDec[2] := ItemQtyAvailable(SalesLine."No.", SalesLine."Variant Code");
            CompanyInfo.GET();
            //<<NV4.30 02.16.04 JWW: Changed following to use new ItemQtyAvailable() for standardization
            LocationItem.RESET();
            LocationItem.GET(SalesLine."No.");
            LocationItem.COPYFILTERS(LineItem);
            IF SalesLine."Location Code" <> '' THEN
                LocationItem.SETRANGE("Location Filter", SalesLine."Location Code");
            AvailToPromise.QtyAvailabletoPromise(LocationItem, GrossReq, SchedRcpt, LocationItem.GETRANGEMAX("Date Filter"),
                                                 CompanyInfo."Check-Avail. Time Bucket", CompanyInfo."Check-Avail. Period Calc.");
            LocationItem.CALCFIELDS(Inventory, "Reserved Qty. on Inventory");
            LDec[13] := LocationItem.Inventory - LocationItem."Reserved Qty. on Inventory" + SchedRcpt - GrossReq;
        END;

    end;

    // procedure UpdatePurchaseLineInfo(PurchLine: Record "39";var LDec: array [20] of Decimal;var LDate: array [10] of Date;var LineItem: Record "27";var LocationItem: Record "27")
    // var
    //     PurchLineTotal: Record "39";
    //     ILE: Record "32";
    // begin
    //     CLEAR(LDec);
    //     CLEAR(LDate);
    //     CLEAR(LocationItem);
    //     CLEAR(LineItem);
    //     // LDate array:
    //     // 1 LastPurchDate

    //     // LDec array:
    //     // 1 LastPurchPrice
    //     // 2 AvailableQty
    //     // 3 OrderAmount
    //     // 4 OrderWeight
    //     // 5 ReceiveAmount
    //     // 6 InvoiceAmount
    //     PurchLineTotal.SETRANGE("Document Type",PurchLine."Document Type");
    //     PurchLineTotal.SETRANGE("Document No.",PurchLine."Document No.");
    //     PurchLineTotal.CALCSUMS("Line Amount","Line Gross Weight","Line Amount to Receive","Line Amount to Invoice");
    //     LDec[3] := PurchLineTotal."Line Amount";
    //     LDec[4] := PurchLineTotal."Line Gross Weight";
    //     LDec[5] := PurchLineTotal."Line Amount to Receive";
    //     LDec[6] := PurchLineTotal."Line Amount to Invoice";
    //     IF (PurchLine.Type=PurchLine.Type::Item) AND (PurchLine."No."<>'') THEN BEGIN
    //       ILE.SETCURRENTKEY("Entry Type","Item No.","Variant Code","Source Type","Source No.","Posting Date");
    //       ILE.SETRANGE("Item No.",PurchLine."No.");
    //       ILE.SETRANGE("Variant Code",PurchLine."Variant Code");
    //       ILE.SETRANGE("Entry Type",ILE."Entry Type"::Purchase);
    //       ILE.SETRANGE("Source Type",ILE."Source Type"::Vendor);
    //       ILE.SETRANGE("Source No.",PurchLine."Buy-from Vendor No.");
    //       ILE.SETFILTER("Invoiced Quantity",'<>%1',0);
    //       IF ILE.FIND('+') THEN  BEGIN
    //         LDate[1] := ILE."Posting Date";
    //         ILE.CALCFIELDS("Cost Amount (Actual)");
    //         LDec[1] := (ABS(ILE."Cost Amount (Actual)")/ABS(ILE."Invoiced Quantity"));
    //       END;
    //       LineItem.RESET;
    //       LineItem.GET(PurchLine."No.");
    //       LineItem.SETRANGE("No.",PurchLine."No.");
    //       IF PurchLine."Variant Code" <> '' THEN LineItem.SETRANGE("Variant Filter",PurchLine."Variant Code");
    //       LineItem.SETRANGE("Date Filter",0D,WORKDATE);
    //     //>>NV4.30 02.16.04 JWW: Changed following to use new ItemQtyAvailable() for standardization
    //     /*
    //       LineItem.CALCFIELDS(Inventory,"Qty. on Sales Order","Qty. on Purch. Order",
    //                           "Qty. in Transit","Qty. on Prod. Kit","Qty. on Prod. Kit Lines",
    //                           "Qty. on Prod. Order","Qty. on Component Lines");
    //       LDec[2] := LineItem.Inventory-LineItem."Qty. on Sales Order"+
    //                  LineItem."Qty. on Purch. Order"+LineItem."Qty. on Prod. Kit"-
    //                  LineItem."Qty. on Prod. Kit Lines"+LineItem."Qty. on Prod. Order"-
    //                  LineItem."Qty. on Component Lines";
    //     */
    //       LDec[2] := ItemQtyAvailable(PurchLine."No.",PurchLine."Variant Code");
    //     //<<NV4.30 02.16.04 JWW: Changed following to use new ItemQtyAvailable() for standardization
    //       LocationItem.RESET;
    //       LocationItem.GET(PurchLine."No.");
    //       LocationItem.COPYFILTERS(LineItem);
    //       IF PurchLine."Location Code" <> '' THEN
    //         LocationItem.SETRANGE("Location Filter",PurchLine."Location Code");
    //       LocationItem.CALCFIELDS(Inventory);
    //     END;

    // end;

    procedure CheckSoftBlock(Type: Option Customer,Vendor,Item; "Code 1": Code[20]; "Code 2": Code[20]; "Code 3": Code[20]; "Transaction ID": Integer; var ErrorMessage: Text[80]) Deny: Boolean
    begin
        //>> NF1.00:CIS.CM 09-29-15
        //Deny := FALSE;
        //ErrorMessage := '';
        //CASE Type OF
        // Type::Customer: BEGIN
        //  IF CustomerSoftBlock.GET("Code 1",'') THEN BEGIN
        //   CASE "Transaction ID" OF
        //    1: BEGIN
        //     IF NOT CustomerSoftBlock.Order THEN BEGIN
        //      IF ("Code 2"<>'') AND (CustomerSoftBlock.GET("Code 1","Code 2")) THEN BEGIN
        //       IF CustomerSoftBlock.Order THEN BEGIN
        //        Deny := TRUE;
        //        ErrorMessage := 'Customer '+"Code 1"+' Ship-to '+"Code 2"+' ORDER BLOCKED';
        //       END;
        //      END;
        //     END ELSE BEGIN
        //      Deny := TRUE;
        //      ErrorMessage := 'Customer '+"Code 1"+' ORDER BLOCKED';
        //     END;
        //    END;
        //    0: BEGIN
        //     IF NOT CustomerSoftBlock.Quote THEN BEGIN
        //      IF ("Code 2"<>'') AND (CustomerSoftBlock.GET("Code 1","Code 2")) THEN BEGIN
        //       IF CustomerSoftBlock.Quote THEN BEGIN
        //        Deny := TRUE;
        //        ErrorMessage := 'Customer '+"Code 1"+' Ship-to '+"Code 2"+' QUOTE BLOCKED';
        //       END;
        //      END;
        //     END ELSE BEGIN
        //      Deny := TRUE;
        //      ErrorMessage := 'Customer '+"Code 1"+' QUOTE BLOCKED';
        //     END;
        //    END;
        //    4: BEGIN
        //     IF NOT CustomerSoftBlock."Blanket Order" THEN BEGIN
        //      IF ("Code 2"<>'') AND (CustomerSoftBlock.GET("Code 1","Code 2")) THEN BEGIN
        //       IF CustomerSoftBlock."Blanket Order" THEN BEGIN
        //        Deny := TRUE;
        //        ErrorMessage := 'Customer '+"Code 1"+' Ship-to '+"Code 2"+' BLANKET ORDER BLOCKED';
        //       END;
        //      END;
        //     END ELSE BEGIN
        //      Deny := TRUE;
        //      ErrorMessage := 'Customer '+"Code 1"+' BLANKET ORDER BLOCKED';
        //     END;
        //    END;
        //    2: BEGIN
        //     IF NOT CustomerSoftBlock.Invoice THEN BEGIN
        //      IF ("Code 2"<>'') AND (CustomerSoftBlock.GET("Code 1","Code 2")) THEN BEGIN
        //       IF CustomerSoftBlock.Invoice THEN BEGIN
        //        Deny := TRUE;
        //        ErrorMessage := 'Customer '+"Code 1"+' Ship-to '+"Code 2"+' INVOICE BLOCKED';
        //       END;
        //      END;
        //     END ELSE BEGIN
        //      Deny := TRUE;
        //      ErrorMessage := 'Customer '+"Code 1"+' INVOICE BLOCKED';
        //     END;
        //    END;
        //    5: BEGIN
        //     IF NOT CustomerSoftBlock.Return THEN BEGIN
        //      IF ("Code 2"<>'') AND (CustomerSoftBlock.GET("Code 1","Code 2")) THEN BEGIN
        //       IF CustomerSoftBlock.Return THEN BEGIN
        //        Deny := TRUE;
        //        ErrorMessage := 'Customer '+"Code 1"+' Ship-to '+"Code 2"+' RETURN BLOCKED';
        //       END;
        //      END;
        //     END ELSE BEGIN
        //      Deny := TRUE;
        //      ErrorMessage := 'Customer '+"Code 1"+' RETURN BLOCKED';
        //     END;
        //    END;
        //    3: BEGIN
        //     IF NOT CustomerSoftBlock."Credit Memo" THEN BEGIN
        //      IF ("Code 2"<>'') AND (CustomerSoftBlock.GET("Code 1","Code 2")) THEN BEGIN
        //       IF CustomerSoftBlock."Credit Memo" THEN BEGIN
        //        Deny := TRUE;
        //        ErrorMessage := 'Customer '+"Code 1"+' Ship-to '+"Code 2"+' CREDIT MEMO BLOCKED';
        //       END;
        //      END;
        //     END ELSE BEGIN
        //      Deny := TRUE;
        //      ErrorMessage := 'Customer '+"Code 1"+' CREDIT MEMO BLOCKED';
        //     END;
        //    END;
        //    7: BEGIN
        //     IF NOT CustomerSoftBlock.Shipment THEN BEGIN
        //      IF ("Code 2"<>'') AND (CustomerSoftBlock.GET("Code 1","Code 2")) THEN BEGIN
        //       IF CustomerSoftBlock.Shipment THEN BEGIN
        //        Deny := TRUE;
        //        ErrorMessage := 'Customer '+"Code 1"+' Ship-to '+"Code 2"+' SHIPMENT BLOCKED';
        //       END;
        //      END;
        //     END ELSE BEGIN
        //      Deny := TRUE;
        //      ErrorMessage := 'Customer '+"Code 1"+' SHIPMENT BLOCKED';
        //     END;
        //    END;
        //    8: BEGIN
        //     IF NOT CustomerSoftBlock.Payment THEN BEGIN
        //      IF ("Code 2"<>'') AND (CustomerSoftBlock.GET("Code 1","Code 2")) THEN BEGIN
        //       IF CustomerSoftBlock.Payment THEN BEGIN
        //        Deny := TRUE;
        //        ErrorMessage := 'Customer '+"Code 1"+' Ship-to '+"Code 2"+' PAYMENT BLOCKED';
        //       END;
        //      END;
        //     END ELSE BEGIN
        //      Deny := TRUE;
        //      ErrorMessage := 'Customer '+"Code 1"+' PAYMENT BLOCKED';
        //     END;
        //    END;
        //   END;
        //  END;
        // END; // Customer

        // Type::Vendor: BEGIN
        //  IF VendorSoftBlock.GET("Code 1",'') THEN BEGIN
        //   CASE "Transaction ID" OF
        //    1: BEGIN
        //     IF NOT VendorSoftBlock.Order THEN BEGIN
        //      IF ("Code 2"<>'') AND (VendorSoftBlock.GET("Code 1","Code 2")) THEN BEGIN
        //       IF VendorSoftBlock.Order THEN BEGIN
        //        Deny := TRUE;
        //        ErrorMessage := 'Vendor '+"Code 1"+' Order Address '+"Code 2"+' ORDER BLOCKED';
        //       END;
        //      END;
        //     END ELSE BEGIN
        //      Deny := TRUE;
        //      ErrorMessage := 'Vendor '+"Code 1"+' ORDER BLOCKED';
        //     END;
        //    END;
        //    0: BEGIN
        //     IF NOT VendorSoftBlock.Quote THEN BEGIN
        //      IF ("Code 2"<>'') AND (VendorSoftBlock.GET("Code 1","Code 2")) THEN BEGIN
        //       IF VendorSoftBlock.Quote THEN BEGIN
        //        Deny := TRUE;
        //        ErrorMessage := 'Vendor '+"Code 1"+' Order Address '+"Code 2"+' QUOTE BLOCKED';
        //       END;
        //      END;
        //     END ELSE BEGIN
        //      Deny := TRUE;
        //      ErrorMessage := 'Vendor '+"Code 1"+' QUOTE BLOCKED';
        //     END;
        //    END;
        //    4: BEGIN
        //     IF NOT VendorSoftBlock."Blanket Order" THEN BEGIN
        //      IF ("Code 2"<>'') AND (VendorSoftBlock.GET("Code 1","Code 2")) THEN BEGIN
        //       IF VendorSoftBlock."Blanket Order" THEN BEGIN
        //        Deny := TRUE;
        //        ErrorMessage := 'Vendor '+"Code 1"+' Order Address '+"Code 2"+' BLANKET ORDER BLOCKED';
        //       END;
        //      END;
        //     END ELSE BEGIN
        //      Deny := TRUE;
        //      ErrorMessage := 'Vendor '+"Code 1"+' BLANKET ORDER BLOCKED';
        //     END;
        //    END;
        //    2: BEGIN
        //     IF NOT VendorSoftBlock.Invoice THEN BEGIN
        //      IF ("Code 2"<>'') AND (VendorSoftBlock.GET("Code 1","Code 2")) THEN BEGIN
        //       IF VendorSoftBlock.Invoice THEN BEGIN
        //        Deny := TRUE;
        //        ErrorMessage := 'Vendor '+"Code 1"+' Order Address '+"Code 2"+' INVOICE BLOCKED';
        //       END;
        //      END;
        //     END ELSE BEGIN
        //      Deny := TRUE;
        //      ErrorMessage := 'Vendor '+"Code 1"+' INVOICE BLOCKED';
        //     END;
        //    END;
        //    5: BEGIN
        //     IF NOT VendorSoftBlock.Return THEN BEGIN
        //      IF ("Code 2"<>'') AND (VendorSoftBlock.GET("Code 1","Code 2")) THEN BEGIN
        //       IF VendorSoftBlock.Return THEN BEGIN
        //        Deny := TRUE;
        //        ErrorMessage := 'Vendor '+"Code 1"+' Order Address '+"Code 2"+' RETURN BLOCKED';
        //       END;
        //      END;
        //     END ELSE BEGIN
        //      Deny := TRUE;
        //      ErrorMessage := 'Vendor '+"Code 1"+' RETURN BLOCKED';
        //     END;
        //    END;
        //    3: BEGIN
        //     IF NOT VendorSoftBlock."Credit Memo" THEN BEGIN
        //      IF ("Code 2"<>'') AND (VendorSoftBlock.GET("Code 1","Code 2")) THEN BEGIN
        //       IF VendorSoftBlock."Credit Memo" THEN BEGIN
        //        Deny := TRUE;
        //        ErrorMessage := 'Vendor '+"Code 1"+' Order Address '+"Code 2"+' CREDIT MEMO BLOCKED';
        //       END;
        //      END;
        //     END ELSE BEGIN
        //      Deny := TRUE;
        //      ErrorMessage := 'Vendor '+"Code 1"+' CREDIT MEMO BLOCKED';
        //     END;
        //    END;
        //    7: BEGIN
        //     IF NOT VendorSoftBlock.Receipt THEN BEGIN
        //      IF ("Code 2"<>'') AND (VendorSoftBlock.GET("Code 1","Code 2")) THEN BEGIN
        //       IF VendorSoftBlock.Receipt THEN BEGIN
        //        Deny := TRUE;
        //        ErrorMessage := 'Vendor '+"Code 1"+' Order Address '+"Code 2"+' RECEIPT BLOCKED';
        //       END;
        //      END;
        //     END ELSE BEGIN
        //      Deny := TRUE;
        //      ErrorMessage := 'Vendor '+"Code 1"+' RECEIPT BLOCKED';
        //     END;
        //    END;
        //    8: BEGIN
        //     IF NOT VendorSoftBlock.Payment THEN BEGIN
        //      IF ("Code 2"<>'') AND (VendorSoftBlock.GET("Code 1","Code 2")) THEN BEGIN
        //       IF VendorSoftBlock.Payment THEN BEGIN
        //        Deny := TRUE;
        //        ErrorMessage := 'Vendor '+"Code 1"+' Order Address '+"Code 2"+' PAYMENT BLOCKED';
        //       END;
        //      END;
        //     END ELSE BEGIN
        //      Deny := TRUE;
        //      ErrorMessage := 'Vendor '+"Code 1"+' PAYMENT BLOCKED';
        //     END;
        //    END;
        //   END;
        //  END;
        // END; // Vendor

        // Type::Item: BEGIN
        //  IF ItemSoftBlock.GET("Code 1",'','') THEN BEGIN
        //   CASE "Transaction ID" OF
        //    0: BEGIN
        //     IF NOT ItemSoftBlock.Sales THEN BEGIN
        //      IF ("Code 2"<>'') AND (ItemSoftBlock.GET("Code 1","Code 2","Code 3")) THEN BEGIN
        //       IF ItemSoftBlock.Sales THEN BEGIN
        //        Deny := TRUE;
        //        ErrorMessage := 'Item '+"Code 1"+' Location '+"Code 2"+' Variant '+"Code 3"+' SALES BLOCKED';
        //       END;
        //      END;
        //     END ELSE BEGIN
        //      Deny := TRUE;
        //      ErrorMessage := 'Item '+"Code 1"+' SALES BLOCKED';
        //     END;
        //    END;
        //    1: BEGIN
        //     IF NOT ItemSoftBlock.Purchase THEN BEGIN
        //      IF ("Code 2"<>'') AND (ItemSoftBlock.GET("Code 1","Code 2","Code 3")) THEN BEGIN
        //       IF ItemSoftBlock.Purchase THEN BEGIN
        //        Deny := TRUE;
        //        ErrorMessage := 'Item '+"Code 1"+' Location '+"Code 2"+' Variant '+"Code 3"+' PURCHASE BLOCKED';
        //       END;
        //      END;
        //     END ELSE BEGIN
        //      Deny := TRUE;
        //      ErrorMessage := 'Item '+"Code 1"+' PURCHASE BLOCKED';
        //     END;
        //    END;
        //    2: BEGIN
        //     IF NOT ItemSoftBlock.Transfer THEN BEGIN
        //      IF ("Code 2"<>'') AND (ItemSoftBlock.GET("Code 1","Code 2","Code 3")) THEN BEGIN
        //       IF ItemSoftBlock.Transfer THEN BEGIN
        //        Deny := TRUE;
        //        ErrorMessage := 'Item '+"Code 1"+' Location '+"Code 2"+' Variant '+"Code 3"+' TRANSFER BLOCKED';
        //       END;
        //      END;
        //     END ELSE BEGIN
        //      Deny := TRUE;
        //      ErrorMessage := 'Item '+"Code 1"+' TRANSFER BLOCKED';
        //     END;
        //    END;
        //    3: BEGIN
        //     IF NOT ItemSoftBlock."Sales Return" THEN BEGIN
        //      IF ("Code 2"<>'') AND (ItemSoftBlock.GET("Code 1","Code 2","Code 3")) THEN BEGIN
        //       IF ItemSoftBlock."Sales Return" THEN BEGIN
        //        Deny := TRUE;
        //        ErrorMessage := 'Item '+"Code 1"+' Location '+"Code 2"+' Variant '+"Code 3"+' SALES RETURN BLOCKED';
        //       END;
        //      END;
        //     END ELSE BEGIN
        //      Deny := TRUE;
        //      ErrorMessage := 'Item '+"Code 1"+' SALES RETURN BLOCKED';
        //     END;
        //    END;
        //    4: BEGIN
        //     IF NOT ItemSoftBlock."Purchase Return" THEN BEGIN
        //      IF ("Code 2"<>'') AND (ItemSoftBlock.GET("Code 1","Code 2","Code 3")) THEN BEGIN
        //       IF ItemSoftBlock."Purchase Return" THEN BEGIN
        //        Deny := TRUE;
        //        ErrorMessage := 'Item '+"Code 1"+' Location '+"Code 2"+' Variant '+"Code 3"+' PURCHASE RETURN BLOCKED';
        //       END;
        //      END;
        //     END ELSE BEGIN
        //      Deny := TRUE;
        //      ErrorMessage := 'Item '+"Code 1"+' PURCHASE RETURN BLOCKED';
        //     END;
        //    END;
        //    5: BEGIN
        //     IF NOT ItemSoftBlock.Shipment THEN BEGIN
        //      IF ("Code 2"<>'') AND (ItemSoftBlock.GET("Code 1","Code 2","Code 3")) THEN BEGIN
        //       IF ItemSoftBlock.Shipment THEN BEGIN
        //        Deny := TRUE;
        //        ErrorMessage := 'Item '+"Code 1"+' Location '+"Code 2"+' Variant '+"Code 3"+' SHIPMENT BLOCKED';
        //       END;
        //      END;
        //     END ELSE BEGIN
        //      Deny := TRUE;
        //      ErrorMessage := 'Item '+"Code 1"+' SHIPMENT BLOCKED';
        //     END;
        //    END;
        //    6: BEGIN
        //     IF NOT ItemSoftBlock.Receipt THEN BEGIN
        //      IF ("Code 2"<>'') AND (ItemSoftBlock.GET("Code 1","Code 2","Code 3")) THEN BEGIN
        //       IF ItemSoftBlock.Receipt THEN BEGIN
        //        Deny := TRUE;
        //        ErrorMessage := 'Item '+"Code 1"+' Location '+"Code 2"+' Variant '+"Code 3"+' RECEIPT BLOCKED';
        //       END;
        //      END;
        //     END ELSE BEGIN
        //      Deny := TRUE;
        //      ErrorMessage := 'Item '+"Code 1"+' RECEIPT BLOCKED';
        //     END;
        //    END;
        //   END;
        //  END;
        // END; // Item

        //END;
        //<< NF1.00:CIS.CM 09-29-15
    end;

    procedure DropShipPOfromSO(SalesHeader: Record 36): Boolean
    var
        SalesLine: Record 37;
        PurchHeader: Record 38;
        PurchLine: Record 39;
        NewPO: Boolean;
        OldVendor: Code[20];
    begin
        NewPO := FALSE;
        SalesLine.SETCURRENTKEY("Vendor No.", "Drop Shipment", "Purchase Order No.", "Purch. Order Line No.");
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.SETRANGE("Drop Shipment", TRUE);
        SalesLine.SETRANGE("Purchase Order No.", '');
        SalesLine.SETRANGE("Purch. Order Line No.", 0);
        OldVendor := '';
        IF SalesLine.FIND('-') THEN
            REPEAT
                IF (OldVendor = '') OR (OldVendor <> SalesLine."Vendor No.") THEN BEGIN
                    PurchHeader.INIT();
                    PurchHeader."Document Type" := PurchHeader."Document Type"::Order;
                    PurchHeader."No." := '';
                    NewPO := PurchHeader.INSERT(TRUE);
                    PurchHeader.VALIDATE("Buy-from Vendor No.", SalesLine."Vendor No.");
                    PurchHeader."Your Reference" := SalesHeader."Your Reference";
                    PurchHeader.VALIDATE("Order Date", SalesHeader."Order Date");
                    PurchHeader.VALIDATE("Document Date", SalesHeader."Document Date");
                    PurchHeader.VALIDATE("Expected Receipt Date", SalesHeader."Requested Delivery Date");
                    PurchHeader.VALIDATE("Location Code", SalesHeader."Location Code");
                    PurchHeader."Shortcut Dimension 1 Code" := SalesHeader."Shortcut Dimension 1 Code";
                    PurchHeader."Shortcut Dimension 2 Code" := SalesHeader."Shortcut Dimension 2 Code";
                    PurchHeader."Purchaser Code" := SalesHeader."Salesperson Code";
                    PurchHeader.VALIDATE("Sell-to Customer No.", SalesHeader."Sell-to Customer No.");
                    PurchHeader.VALIDATE("Ship-to Code", SalesHeader."Ship-to Code");
                    PurchHeader."Ship-to Name" := SalesHeader."Ship-to Name";
                    PurchHeader."Ship-to Name 2" := SalesHeader."Ship-to Name 2";
                    PurchHeader."Ship-to Address" := SalesHeader."Ship-to Address";
                    PurchHeader."Ship-to Address 2" := SalesHeader."Ship-to Address 2";
                    PurchHeader."Ship-to City" := SalesHeader."Ship-to City";
                    PurchHeader."Ship-to Contact" := SalesHeader."Ship-to Contact";
                    PurchHeader."Ship-to Post Code" := SalesHeader."Ship-to Post Code";
                    PurchHeader."Ship-to County" := SalesHeader."Ship-to County";
                    PurchHeader."Ship-to Country/Region Code" := SalesHeader."Ship-to Country/Region Code";
                    PurchHeader."Ship-to PO No." := SalesHeader."Ship-to PO No.";
                    PurchHeader.MODIFY();
                    OldVendor := PurchHeader."Buy-from Vendor No.";
                END;
                PurchLine.INIT();
                PurchLine."Document Type" := PurchHeader."Document Type";
                PurchLine."Document No." := PurchHeader."No.";
                PurchLine."Line No." := SalesLine."Line No.";
                PurchLine.VALIDATE("Buy-from Vendor No.", PurchHeader."Buy-from Vendor No.");
                PurchLine.Type := SalesLine.Type;
                PurchLine.VALIDATE("No.", SalesLine."No.");
                PurchLine.VALIDATE("Location Code", SalesLine."Location Code");
                PurchLine.VALIDATE("Expected Receipt Date", SalesLine."Requested Delivery Date");
                PurchLine."Order Date" := PurchHeader."Order Date";
                PurchLine."Purchaser Code" := PurchHeader."Purchaser Code";
                PurchLine.VALIDATE("Unit of Measure Code", SalesLine."Unit of Measure Code");
                PurchLine.VALIDATE(Quantity, SalesLine.Quantity);
                PurchLine.VALIDATE("Purchasing Code", SalesLine."Purchasing Code");
                PurchLine.VALIDATE("Drop Shipment", SalesLine."Drop Shipment");
                PurchLine."Sales Order No." := SalesLine."Document No.";
                PurchLine."Sales Order Line No." := SalesLine."Line No.";
                PurchLine.VALIDATE("Direct Unit Cost");
                PurchLine.INSERT();
                //>>NIF 060807 RTT
                SalesLine.VALIDATE("Unit Cost (LCY)", PurchLine."Unit Cost (LCY)");
                SalesLine.MODIFY();
            //<<NIF 060807 RTT

            UNTIL SalesLine.NEXT() = 0;
        SalesLine.RESET();
        PurchLine.SETCURRENTKEY("Sales Order No.", "Sales Order Line No.");
        PurchLine.SETRANGE("Sales Order No.", SalesHeader."No.");
        IF PurchLine.FIND('-') THEN
            REPEAT
                IF SalesLine.GET(SalesLine."Document Type"::Order, PurchLine."Sales Order No.", PurchLine."Sales Order Line No.") THEN
                    IF SalesLine."Purch. Order Line No." = 0 THEN BEGIN
                        SalesLine."Purchase Order No." := PurchLine."Document No.";
                        SalesLine."Purch. Order Line No." := PurchLine."Line No.";
                        SalesLine.MODIFY();
                    END;
            UNTIL PurchLine.NEXT() = 0;
        EXIT(NewPO);
    end;

    procedure TestRequiredField(TestRecord: RecordRef; FormID: Code[10]; HideMessage: Boolean): Boolean
    begin
        //>> NF1.00:CIS.CM 09-29-15
        //MessageText := '';
        //EVALUATE(FormNo,FormID);
        //ReqField.SETRANGE("Table ID",TestRecord.NUMBER);
        //ReqField.SETRANGE("Form ID",FormNo);
        //ReqField.SETRANGE(Active,TRUE);
        //IF ReqField.FIND('-') THEN
        //  REPEAT
        //    ReqField.CALCFIELDS("Table Name","Field Name","Form Name");
        //    FieldRef := TestRecord.FIELD(ReqField."Field ID");
        //    RecNoRef := TestRecord.FIELDINDEX(1);
        //    IF FORMAT(FieldRef.VALUE)='' THEN
        //      MessageText := MessageText + ReqField."Field Name" + '\';
        //  UNTIL ReqField.NEXT=0;
        //IF MessageText='' THEN
        //  EXIT(FALSE)
        //ELSE BEGIN
        //  IF NOT HideMessage THEN
        //    MESSAGE(Text001+MessageText,ReqField."Form Name",FORMAT(RecNoRef));
        //  EXIT(TRUE);
        //END;
        //<< NF1.00:CIS.CM 09-29-15
    end;

   /* procedure TestPermission(TableID: Integer): Boolean
    var
        PermissionRange: Record "Permission Range";
    begin
        PermissionRange.SETRANGE("Object Type", PermissionRange."Object Type"::TableData);
        PermissionRange.SETRANGE(From, 0, TableID);
        PermissionRange.SETFILTER("To", '>=%1', TableID);
        EXIT(PermissionRange.FIND('-'));
    end;*/

    procedure ItemQtyAvailable(ItemNo: Code[20]; VariantCode: Code[10]) ReturnValue: Decimal
    var
        Item: Record 27;
        CompanyInfo: Record 79;
        AvailToPromise: Codeunit 5790;
        GrossReq: Decimal;
        SchedRcpt: Decimal;
    begin
        //>>NV4.30 02.16.04 JWW: Added ItemQtyAvailable()
        Item.RESET();
        IF Item.GET(ItemNo) THEN BEGIN
            Item.SETRANGE("No.", ItemNo);
            IF VariantCode <> '' THEN
                Item.SETRANGE("Variant Filter", VariantCode);
            Item.SETRANGE("Date Filter", 0D, WORKDATE());
            Item.FIND('-');

            CompanyInfo.GET();
            AvailToPromise.QtyAvailabletoPromise(Item, GrossReq, SchedRcpt, Item.GETRANGEMAX("Date Filter"),
                                                 CompanyInfo."Check-Avail. Time Bucket", CompanyInfo."Check-Avail. Period Calc.");
            //>> NF1.00:CIS.CM  09/29/15
            //Item.CALCFIELDS(Inventory,"Qty. on Sales Order","Qty. on Purch. Order",
            //                   "Qty. in Transit","Qty. on Prod. Kit","Qty. on Prod. Kit Lines",
            //                   "Qty. on Prod. Order","Qty. on Component Lines","Reserved Qty. on Inventory");
            Item.CALCFIELDS(Inventory, "Qty. on Sales Order", "Qty. on Purch. Order",
                               "Qty. in Transit", "Qty. on Prod. Order", "Qty. on Component Lines", "Reserved Qty. on Inventory");
            //<< NF1.00:CIS.CM  09/29/15

            //  ReturnValue := Item.Inventory - Item."Qty. on Sales Order" +
            //                 Item."Qty. on Purch. Order" + Item."Qty. on Prod. Kit"-
            //                 Item."Qty. on Prod. Kit Lines" + Item."Qty. on Prod. Order" -
            //                 Item."Qty. on Component Lines";
            ReturnValue := Item.Inventory - Item."Reserved Qty. on Inventory" + SchedRcpt - GrossReq;
        END ELSE
            ReturnValue := 0;
    end;

    procedure LocItemQtyAvailable(var LocationItem: Record 27; LocCode: Code[10]; ItemNo: Code[20]; VariantCode: Code[10]) ReturnValue: Integer
    var
        CompanyInfo: Record 79;
        AvailToPromise: Codeunit 5790;
        GrossReq: Decimal;
        SchedRcpt: Decimal;
    begin
        //>>NV4.32 04.02.04 JWW: Added LocItemQtyAvailable()
        LocationItem.RESET();
        LocationItem.GET(ItemNo);
        LocationItem.SETRANGE("No.", ItemNo);
        IF VariantCode <> '' THEN
            LocationItem.SETRANGE("Variant Filter", VariantCode);
        LocationItem.SETRANGE("Date Filter", 0D, WORKDATE());
        IF LocCode <> '' THEN
            LocationItem.SETRANGE("Location Filter", LocCode);
        AvailToPromise.QtyAvailabletoPromise(LocationItem, GrossReq, SchedRcpt, LocationItem.GETRANGEMAX("Date Filter"),
                                             CompanyInfo."Check-Avail. Time Bucket", CompanyInfo."Check-Avail. Period Calc.");
        LocationItem.CALCFIELDS(Inventory, "Reserved Qty. on Inventory");
        ReturnValue := LocationItem.Inventory - LocationItem."Reserved Qty. on Inventory" + SchedRcpt - GrossReq;
    end;

    procedure "<<Tracking>>"()
    begin
    end;

    procedure CreateWhseShptTrkgLines(var WhseShptLine: Record 7321)
    var
        Item: Record 27;
        ItemTracking: Record 6502;
        TempLotBinContent: Record 50001 temporary;
    begin
        //get item, exit if no tracking
        Item.GET(WhseShptLine."Item No.");
        IF NOT ItemTracking.GET(Item."Item Tracking Code") THEN
            EXIT;
        IF NOT ItemTracking."Lot Specific Tracking" THEN
            EXIT;

        //get lot bin contents
        Item.SETRANGE("Location Filter", WhseShptLine."Location Code");
        Item.GetLotBinContents(TempLotBinContent);

        /*//ISTRTT //TEMPTOOD
        RemoveItemTrackingLines(
           WhseShptLine."Source Type",WhseShptLine."Source Subtype",
           WhseShptLine."Source No.",WhseShptLine."Source Line No.");
        
        
        AddItemTrackingLines(
           WhseShptLine."Source Type",WhseShptLine."Source Subtype",
           WhseShptLine."Source No.",WhseShptLine."Source Line No.",TempLotBinContent);
        
        //ISTRTT  //TEMPTODD*/

    end;

    procedure RemoveItemTrackingLines(SourceType: Integer; SourceSubType: Integer; SourceNo: Code[20]; SourceLineNo: Integer)
    var
        Item: Record 27;
        SalesLine: Record 37;
        PurchLine: Record 39;
        TrackingSpecification: Record 336;
        TrackingSpecificationTmp: Record 336 temporary;
        TransferLine: Record 5741;
        ReserveSalesLine: Codeunit 99000832;
        ReservePurchLine: Codeunit 99000834;
        ReserveTransferLine: Codeunit 99000836;
        ItemTrackingForm: Page 6510;
        ModifyRecord: Boolean;
        SecondSourceQtyArray: array[3] of Decimal;
        WhsePickQtyBase: Decimal;
        WhseShipQtyBase: Decimal;
    begin
        //clear vars
        CLEAR(ReserveSalesLine);
        CLEAR(ReserveTransferLine);
        CLEAR(ItemTrackingForm);
        CLEAR(ReservePurchLine);


        //determine quantity already on a shipment or pick and set tracking specification, or exit if not a sales or transfer line
        CASE SourceType OF
            DATABASE::"Sales Line":
                BEGIN
                    SalesLine.GET(SourceSubType, SourceNo, SourceLineNo);
                    Item.GET(SalesLine."No.");
                    IF Item."Item Tracking Code" = '' THEN
                        EXIT;
                    SalesLine.CALCFIELDS("LAX EShip Whse Ship. Qty(Base)", "LAX EShip Whse Outst.Qty(Base)");
                    WhseShipQtyBase := SalesLine."LAX EShip Whse Ship. Qty(Base)";
                    WhsePickQtyBase := SalesLine."LAX EShip Whse Outst.Qty(Base)";
                    ReserveSalesLine.InitTrackingSpecification(SalesLine, TrackingSpecification);
                    ItemTrackingForm.SetSource(TrackingSpecification, SalesLine."Shipment Date");
                END;

            DATABASE::"Purchase Line":
                BEGIN
                    PurchLine.GET(SourceSubType, SourceNo, SourceLineNo);
                    Item.GET(PurchLine."No.");
                    IF Item."Item Tracking Code" = '' THEN
                        EXIT;
                    WhseShipQtyBase := 0;
                    WhsePickQtyBase := 0;
                    ReservePurchLine.InitTrackingSpecification(PurchLine, TrackingSpecification);
                    ItemTrackingForm.SetSource(TrackingSpecification, PurchLine."Expected Receipt Date");
                END;

            DATABASE::"Transfer Line":
                BEGIN
                    TransferLine.GET(SourceNo, SourceLineNo);
                    Item.GET(TransferLine."Item No.");
                    IF Item."Item Tracking Code" = '' THEN
                        EXIT;
                    TransferLine.CALCFIELDS("Whse. Ship. Qty (Base)", "Whse. Pick Outst. Qty (Base)");
                    WhseShipQtyBase := TransferLine."Whse. Ship. Qty (Base)";
                    WhsePickQtyBase := TransferLine."Whse. Pick Outst. Qty (Base)";
                    ReserveTransferLine.InitTrackingSpecification(TransferLine, TrackingSpecification, TransferLine."Shipment Date", 0);
                    ItemTrackingForm.SetSource(TrackingSpecification, TransferLine."Shipment Date");
                END;
            //leave if not transfer line or sales line
            ELSE
                EXIT;
        END;

        IF WhseShipQtyBase + WhsePickQtyBase <> 0 THEN BEGIN
            SecondSourceQtyArray[1] := DATABASE::"Warehouse Shipment Line";
            SecondSourceQtyArray[2] := WhseShipQtyBase + WhsePickQtyBase;
            SecondSourceQtyArray[3] := 0;
            ItemTrackingForm.SetSecondSourceQuantity(SecondSourceQtyArray);
        END;

        ItemTrackingForm.NVOpenForm();
        TrackingSpecificationTmp.RESET();
        TrackingSpecificationTmp.DELETEALL();

        ItemTrackingForm.NVGetRecords(TrackingSpecificationTmp);
        IF TrackingSpecificationTmp.FIND('-') THEN BEGIN
            REPEAT
                IF TrackingSpecificationTmp."Quantity Handled (Base)" = 0 THEN
                    ItemTrackingForm.NVDeleteRecord(TrackingSpecificationTmp)
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
                        ItemTrackingForm.NVModifyRecord(TrackingSpecificationTmp);
                END;
            UNTIL TrackingSpecificationTmp.NEXT() = 0;
            ItemTrackingForm.NVCloseForm();
        END;
        //end if TrackingSpecificationTmp.FIND then begin
    end;

    procedure AddItemTrackingLines(SourceType: Integer; SourceSubType: Integer; SourceNo: Code[20]; SourceLineNo: Integer; var TempLotBinContent: Record 50001 temporary)
    var
        Location: Record 14;
        Item: Record 27;
        SalesLine: Record 37;
        PurchLine: Record 39;
        TrackingSpecification: Record 336;
        TrackingSpecificationTmp: Record 336 temporary;
        TransferLine: Record 5741;
        WMSMgt: Codeunit 7302;
        ReserveSalesLine: Codeunit 99000832;
        ReservePurchLine: Codeunit 99000834;
        ReserveTransferLine: Codeunit 99000836;
        ItemTrackingForm: Page 6510;
        LinesInserted: Boolean;
        LotNoToSet: Code[20];
        ExpirationDateToSet: Date;
        WarrantyDateToSet: Date;
        LineQty: Decimal;
        LineQtyToShip: Decimal;
        LineReservedQty: Decimal;
        QtyAvailableBase: Decimal;
        QtyOnOrder: Decimal;
        SecondSourceQtyArray: array[3] of Decimal;
        LastEntryNo: Integer;
    begin
        //exit if no lots found
        TempLotBinContent.SETCURRENTKEY("Creation Date", "Lot No.");
        IF SourceType <> DATABASE::"Purchase Line" THEN
            TempLotBinContent.SETFILTER("Bin Type Code", GetBinTypeFilter(3)); // Picking area
        //>> 07-10-05 RTT
        IF (SourceType = DATABASE::"Sales Line") THEN BEGIN
            SalesLine.GET(SourceSubType, SourceNo, SourceLineNo);
            TempLotBinContent.SETRANGE("Revision No.", SalesLine."Revision No.");
        END;
        //<< 07-10-05 RTT
        //>> 07-29-05 RTT filter on block movement
        IF SourceType = DATABASE::"Sales Line" THEN
            TempLotBinContent.SETFILTER("Block Movement", '%1|%2',
                TempLotBinContent."Block Movement"::" ", TempLotBinContent."Block Movement"::Inbound);
        //<< 07-29-05 RTT

        IF NOT TempLotBinContent.FIND('-') THEN
            EXIT;

        //clear vars
        CLEAR(ReserveSalesLine);
        CLEAR(ItemTrackingForm);
        CLEAR(ReserveTransferLine);
        CLEAR(ReservePurchLine);

        //get the qty to process
        CASE SourceType OF
            DATABASE::"Sales Line":
                BEGIN
                    SalesLine.GET(SourceSubType, SourceNo, SourceLineNo);
                    //LineQtyToShip := "Outstanding Qty. (Base)";
                    LineQtyToShip := SalesLine."Qty. to Ship (Base)";
                    ReserveSalesLine.InitTrackingSpecification(SalesLine, TrackingSpecification);
                    ItemTrackingForm.SetSource(TrackingSpecification, SalesLine."Shipment Date");
                END;
            DATABASE::"Purchase Line":
                BEGIN
                    PurchLine.GET(SourceSubType, SourceNo, SourceLineNo);
                    LineQtyToShip := PurchLine."Outstanding Qty. (Base)";
                    ReservePurchLine.InitTrackingSpecification(PurchLine, TrackingSpecification);
                    ItemTrackingForm.SetSource(TrackingSpecification, PurchLine."Expected Receipt Date");
                END;

            DATABASE::"Transfer Line":
                BEGIN
                    TransferLine.GET(SourceNo, SourceLineNo);
                    LineQtyToShip := TransferLine."Outstanding Qty. (Base)";
                    ReserveTransferLine.InitTrackingSpecification(TransferLine, TrackingSpecification, TransferLine."Shipment Date", 0);
                    ItemTrackingForm.SetSource(TrackingSpecification, TransferLine."Shipment Date");
                END;
            ELSE
                EXIT;  //shouldn't reach here, but exit just in case
        END;

        //>> NIF 05-25-05
        //1 - read each lot into a temp lot info table
        //2 - calculate total qty in bins
        //3 - subtract qty allocated

        //<< NIF 05-25-05


        //now begin loop through the table
        REPEAT
            //find qty available for Lot/Bin
            TempLotBinContent.CALCFIELDS(Quantity, "Pick Qty.", "Neg. Adjmt. Qty.");

            IF SourceType = DATABASE::"Purchase Line" THEN
                //>> NIF 12-08-05 RTT
                //QtyAvailableBase := 100000000000;
                QtyAvailableBase := 100000000000.0
            ELSE IF (Location.GET(TempLotBinContent."Location Code")) AND (NOT Location."Bin Mandatory") THEN BEGIN
                Item.GET(TempLotBinContent."Item No.");
                Item.SETRANGE("Location Filter", TempLotBinContent."Location Code");
                Item.SETRANGE("Lot No. Filter", TempLotBinContent."Lot No.");
                Item.CALCFIELDS(Inventory, "Reserved Qty. on Inventory");
                LineReservedQty :=
                  WMSMgt.CalcLineReservedQtyonInvt(SourceType, SourceSubType, SourceNo, SourceLineNo, 0, '', TempLotBinContent."Lot No.");
                QtyAvailableBase :=
                  (Item.Inventory - ABS(Item."Reserved Qty. on Inventory") + LineReservedQty); //x12-14-05 - LineQtyToShip;

                //XX
                /*
                IF UPPERCASE(USERID)='IST' THEN
                  IF TempLotBinContent."Item No."='PBR0D2104' THEN
                    MESSAGE('Lot %1, Inventory %2, Reserved %3, Line Res %4, LineQtyToShip %5',
                        TempLotBinContent."Lot No.",Item.Inventory,Item."Reserved Qty. on Inventory",
                           LineReservedQty,LineQtyToShip);
                */
                //XX
            END ELSE
                //<< NIF 12-08-05 RTT
                QtyAvailableBase :=
                       (TempLotBinContent.Quantity - TempLotBinContent."Pick Qty." -
                                   TempLotBinContent."Neg. Adjmt. Qty.") * TempLotBinContent."Qty. per Unit of Measure";


            //>> 08-31-05 NIF RTT
            //factor out qtys already allocated
            IF LotBinContentAlloc.GET(TempLotBinContent."Location Code", TempLotBinContent."Bin Code", TempLotBinContent."Item No.",
                            TempLotBinContent."Variant Code", TempLotBinContent."Unit of Measure Code", TempLotBinContent."Lot No.") THEN
                QtyAvailableBase := QtyAvailableBase - LotBinContentAlloc."Qty. to Handle (Base)";
            //<< 08-31-05 NIF RTT

            //>> NIF 06-14-05
            //use quantities exceeding packs only, only for MPD
            Item.GET(TempLotBinContent."Item No.");
            IF (QtyAvailableBase >= Item."Units per Parcel") OR
               ((Item."Units per Parcel" = 0) AND
                  ((TempLotBinContent."Location Code" = 'MPD') OR
                  (TempLotBinContent."Location Code" = 'CNF') OR
                  (TempLotBinContent."Location Code" = 'TENN')) OR

               ((Item."Units per Parcel" <> 0) AND
                   (TempLotBinContent."Location Code" <> 'MPD') AND
                   (TempLotBinContent."Location Code" <> 'CNF') AND
                   (TempLotBinContent."Location Code" <> 'TENN'))) THEN BEGIN
                //<< NIF 06-14-05

                /*
                //also factor in possibility that lot is on a shipment w/o pick released
                IF NOT LotNoInfo.GET(TempLotBinContent."Item No.",TempLotBinContent."Variant Code",TempLotBinContent."Lot No.") THEN
                  CLEAR(QtyOnOrder)
                ELSE
                  QtyOnOrder := LotNoInfo.OutstQtyOnSalesOrder + LotNoInfo.OutstQtyOnTransfOrder;;
                */

                QtyAvailableBase := QtyAvailableBase - QtyOnOrder;
                IF QtyAvailableBase < 0 THEN
                    QtyAvailableBase := 0;

                //MESSAGE('Lot %1, Bin %2, Avail %3, Filters %4',
                //     TempLotBinContent."Lot No.",TempLotBinContent."Bin Code",QtyAvailableBase,TempLotBinContent.GETFILTERS);


                LotNoToSet := TempLotBinContent."Lot No.";
                WarrantyDateToSet := 0D;  //these values could be set differently later
                ExpirationDateToSet := TempLotBinContent."Expiration Date"; //these values could be set differently later

                IF LineQtyToShip >= QtyAvailableBase THEN BEGIN
                    LineQty := QtyAvailableBase;
                    QtyAvailableBase := 0;
                    LineQtyToShip := LineQtyToShip - LineQty;
                    //MESSAGE('1 - Line Qty %1',LineQty);
                END
                ELSE BEGIN
                    LineQty := LineQtyToShip;
                    QtyAvailableBase := QtyAvailableBase - LineQty;
                    LineQtyToShip := 0;
                    //MESSAGE('2 - Line Qty %1',LineQty);
                END;

                //>> NIF 08-31-05 RTT
                UpdateLotBinContentAlloc(TempLotBinContent, LineQty);
                //<< NIF 08-31-05 RTT

                IF (LineQty <> 0) THEN BEGIN
                    SecondSourceQtyArray[1] := DATABASE::"Warehouse Shipment Line";
                    SecondSourceQtyArray[2] := LineQty;
                    SecondSourceQtyArray[3] := 0;
                    ItemTrackingForm.SetSecondSourceQuantity(SecondSourceQtyArray);
                END;

                ItemTrackingForm.NVOpenForm();
                TrackingSpecificationTmp.RESET();
                TrackingSpecificationTmp.DELETEALL();
                ItemTrackingForm.NVGetRecords(TrackingSpecificationTmp);
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
                        ItemTrackingForm.NVModifyRecord(TrackingSpecificationTmp);
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
                        ItemTrackingForm.NVInsertRecord(TrackingSpecificationTmp);
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
                    ItemTrackingForm.NVInsertRecord(TrackingSpecificationTmp);
                END;

                //ItemTrackingForm.NVCloseForm;

                LinesInserted := TRUE;
                //>> NIF 06-14-05
                //end statement for: use quantities exceeding packs only, only for MPD
            END;
        //<< NIF 06-14-05

        UNTIL TempLotBinContent.NEXT = 0;


        ItemTrackingForm.NVCloseForm();

        IF LinesInserted THEN
            COMMIT();

    end;

    procedure GetBinTypeFilter(Type: Option Receive,Ship,"Put Away",Pick): Text[1024]
    var
        BinType: Record 7303;
        "Filter": Text[1024];
    begin
        CASE Type OF
            Type::Receive:
                BinType.SETRANGE(Receive, TRUE);
            Type::Ship:
                BinType.SETRANGE(Ship, TRUE);
            Type::"Put Away":
                BinType.SETRANGE("Put Away", TRUE);
            Type::Pick:
                BinType.SETRANGE(Pick, TRUE);
        END;
        IF BinType.FIND('-') THEN
            REPEAT
                Filter := STRSUBSTNO('%1|%2', Filter, BinType.Code);
            UNTIL BinType.NEXT() = 0;
        IF Filter <> '' THEN
            Filter := COPYSTR(Filter, 2);
        EXIT(Filter);
    end;

    procedure "<<Lot Entry Screen>>"()
    begin
    end;

    procedure SuggestLotEntryLines(DocType: Integer; DocNo: Code[20]; var LotEntry: Record 50002)
    var
        Location: Record 14;
        Item: Record 27;
        PurchSetup: Record 312;
        TempLotBinContent: Record 50001 temporary;
        LotEntry2: Record 50002;
        TempLotEntry: Record 50002 temporary;
        NoSeriesMgt: Codeunit 396;
        SourceNo: Code[20];
        SourceLineNo: Integer;
        SourceSubtype: Integer;
        SourceType: Integer;
    begin
        //read lines into temp table
        TempLotEntry.DELETEALL();

        //clear out lot entry lines and rebuild
        LotEntry2.SETRANGE("Document Type", DocType);
        LotEntry2.SETRANGE("Document No.", DocNo);
        LotEntry2.DELETEALL();

        CASE DocType OF
            LotEntry2."Document Type"::"Transfer Order":
                LotEntry2.GetTransferLines(DocNo);
            LotEntry2."Document Type"::"Purchase Order":
                LotEntry2.GetPurchLines(LotEntry2."Document Type"::"Purchase Order", DocNo);
            LotEntry2."Document Type"::"Whse. Shipment":
                LotEntry2.GetShipmentLines(DocNo);
            ELSE
                LotEntry2.GetSalesLines(DocType, DocNo);
        END;

        IF NOT LotEntry2.FIND('-') THEN
            ERROR('No Lines found');

        REPEAT
            IF NOT TempLotEntry.GET(LotEntry2."Document Type", LotEntry2."Document No.", LotEntry2."Order Line No.", 0) THEN BEGIN
                TempLotEntry := LotEntry2;
                TempLotEntry."Line No." := 0;
                TempLotEntry.INSERT();
            END;
        UNTIL LotEntry2.NEXT() = 0;


        //init item tracking vars
        CASE DocType OF
            LotEntry."Document Type"::"Transfer Order":
                BEGIN
                    SourceType := DATABASE::"Transfer Line";
                    SourceSubtype := 0;
                END;
            LotEntry."Document Type"::"Purchase Order":
                BEGIN
                    SourceType := DATABASE::"Purchase Line";
                    SourceSubtype := 1;  //1=Order
                    PurchSetup.GET();
                    PurchSetup.TESTFIELD("On the Water Lot Nos.");
                END;

            LotEntry."Document Type"::"Whse. Shipment":
                BEGIN
                    SourceType := DATABASE::"Warehouse Shipment Line";
                    SourceSubtype := 0;
                END;

            ELSE BEGIN
                SourceType := DATABASE::"Sales Line";
                SourceSubtype := DocType;
            END;
        END;

        //>> NIF RTT 08-31-05
        //init allocation table, this will be used to track quantities already assigned
        LotBinContentAlloc.DELETEALL();
        //<< NIF RTT 08-31-05

        //loop through temp lines
        TempLotEntry.FIND('-');
        REPEAT

            //get lot bin contents
            //if purchase order, populate bin content with desired lots along with pickable bin
            IF TempLotEntry."Document Type" = TempLotEntry."Document Type"::"Purchase Order" THEN BEGIN
                TempLotBinContent.DELETEALL();
                TempLotBinContent.INIT();
                TempLotBinContent."Location Code" := TempLotEntry."Location Code";
                TempLotBinContent."Bin Code" := '';
                TempLotBinContent."Item No." := TempLotEntry."Item No.";
                TempLotBinContent."Unit of Measure Code" := TempLotEntry."Unit of Measure Code";
                TempLotBinContent."Lot No." := NoSeriesMgt.GetNextNo(PurchSetup."On the Water Lot Nos.", TODAY, TRUE);
                TempLotBinContent."Qty. to Handle" := 100000000000.0;
                TempLotBinContent.INSERT();
            END
            ELSE BEGIN
                Item.GET(TempLotEntry."Item No.");
                Item.SETRANGE("Location Filter", TempLotEntry."Location Code");
                //>> RTT 12-08-05
                IF NOT Location.GET(TempLotEntry."Location Code") THEN
                    CLEAR(Location);
                IF NOT Location."Bin Mandatory" THEN
                    GetLotBinContentsNonBin(Item, TRUE, FALSE, TempLotBinContent)
                ELSE
                    //<< RTT 12-08-05
                    Item.GetLotBinContents(TempLotBinContent);
                //>> RTT 06-11-05
                TempLotBinContent.SETRANGE(Blocked, FALSE);
                //<< RTT 06-11-05
            END;

            SourceNo := TempLotEntry."Document No.";
            SourceLineNo := TempLotEntry."Order Line No.";

            IF TempLotEntry."Document Type" = TempLotEntry."Document Type"::"Whse. Shipment" THEN BEGIN
                ClearWhseItemTrackingLines(SourceType, SourceNo, SourceLineNo);
                AddWhseItemTrackingLines(SourceType, SourceSubtype, SourceNo, SourceLineNo, TempLotBinContent);
            END
            ELSE BEGIN
                RemoveItemTrackingLines(SourceType, SourceSubtype, SourceNo, SourceLineNo);
                AddItemTrackingLines(SourceType, SourceSubtype, SourceNo, SourceLineNo, TempLotBinContent);
                //>> RTT 100406
                TempLotBinContent.SETRANGE("Revision No.");
                //<< RTT 100406
            END;

        UNTIL TempLotEntry.NEXT() = 0;


        //clear out lot entry lines and rebuild
        COMMIT();
        LotEntry.SETRANGE("Document Type", DocType);
        LotEntry.SETRANGE("Document No.", DocNo);
        LotEntry.DELETEALL;
        CASE DocType OF
            LotEntry2."Document Type"::"Transfer Order":
                LotEntry.GetTransferLines(DocNo);
            LotEntry2."Document Type"::"Purchase Order":
                LotEntry.GetPurchLines(DocType, DocNo);

            LotEntry2."Document Type"::"Whse. Shipment":
                LotEntry.GetShipmentLines(DocNo);
            ELSE
                LotEntry.GetSalesLines(DocType, DocNo);
        END;
    end;

    procedure ClearLotEntryLines(DocType: Integer; DocNo: Code[20]; var LotEntry: Record 50002)
    var
        LotEntry2: Record 50002;
        TempLotEntry: Record 50002 temporary;
        SourceNo: Code[20];
        SourceLineNo: Integer;
        SourceSubtype: Integer;
        SourceType: Integer;
    begin
        //read lines into temp table
        TempLotEntry.DELETEALL();

        //clear out lot entry lines and rebuild
        LotEntry2.SETRANGE("Document Type", DocType);
        LotEntry2.SETRANGE("Document No.", DocNo);
        LotEntry2.DELETEALL();
        CASE DocType OF
            LotEntry2."Document Type"::"Transfer Order":
                LotEntry2.GetTransferLines(DocNo);
            LotEntry2."Document Type"::"Whse. Shipment":
                LotEntry2.GetShipmentLines(DocNo);
            LotEntry2."Document Type"::"Purchase Order":
                LotEntry2.GetPurchLines(DocType, DocNo);
            ELSE
                LotEntry2.GetSalesLines(DocType, DocNo);
        END;

        IF NOT LotEntry2.FIND('-') THEN
            ERROR('No Lines found');

        REPEAT
            IF NOT TempLotEntry.GET(LotEntry2."Document Type", LotEntry2."Document No.", LotEntry2."Order Line No.", 0) THEN BEGIN
                TempLotEntry := LotEntry2;
                TempLotEntry."Line No." := 0;
                TempLotEntry.INSERT();
            END;
        UNTIL LotEntry2.NEXT() = 0;


        //init item tracking vars
        CASE DocType OF
            LotEntry."Document Type"::"Transfer Order":
                BEGIN
                    SourceType := DATABASE::"Transfer Line";
                    SourceSubtype := 0;
                END;
            LotEntry."Document Type"::"Purchase Order":
                BEGIN
                    SourceType := DATABASE::"Purchase Line";
                    SourceSubtype := 1;  //1=Order
                END;

            LotEntry."Document Type"::"Whse. Shipment":
                BEGIN
                    SourceType := DATABASE::"Warehouse Shipment Line";
                    SourceSubtype := 0;
                END;
            ELSE BEGIN
                SourceType := DATABASE::"Sales Line";
                SourceSubtype := DocType;
            END;
        END;


        //loop through temp lines
        TempLotEntry.FIND('-');
        REPEAT
            SourceNo := TempLotEntry."Document No.";
            SourceLineNo := TempLotEntry."Order Line No.";

            IF TempLotEntry."Document Type" = TempLotEntry."Document Type"::"Whse. Shipment" THEN
                ClearWhseItemTrackingLines(SourceType, SourceNo, SourceLineNo)
            ELSE
                RemoveItemTrackingLines(SourceType, SourceSubtype, SourceNo, SourceLineNo);
        UNTIL TempLotEntry.NEXT() = 0;


        //clear out lot entry lines and rebuild
        COMMIT();
        LotEntry.SETRANGE("Document Type", DocType);
        LotEntry.SETRANGE("Document No.", DocNo);
        LotEntry.DELETEALL();

        CASE DocType OF
            LotEntry2."Document Type"::"Transfer Order":
                LotEntry.GetTransferLines(DocNo);
            LotEntry2."Document Type"::"Whse. Shipment":
                LotEntry.GetShipmentLines(DocNo);
            LotEntry2."Document Type"::"Purchase Order":
                LotEntry.GetPurchLines(DocType, DocNo);
            ELSE
                LotEntry.GetSalesLines(DocType, DocNo);
        END;
    end;

    procedure "<<WhseItemTrkg>>"()
    begin
    end;

    procedure CreateWhseShptItemTrkgLines(var WhseShptLine: Record 7321)
    var
        Item: Record 27;
        ItemTracking: Record 6502;
        TempLotBinContent: Record 50001 temporary;
    begin
        //get item, exit if no tracking
        Item.GET(WhseShptLine."Item No.");
        IF NOT ItemTracking.GET(Item."Item Tracking Code") THEN
            EXIT;
        IF NOT ItemTracking."Lot Specific Tracking" THEN
            EXIT;


        //get lot bin contents
        Item.SETRANGE("Location Filter", WhseShptLine."Location Code");
        Item.GetLotBinContents(TempLotBinContent);

        ClearWhseItemTrackingLines(
           WhseShptLine."Source Type",
           WhseShptLine."No.", WhseShptLine."Line No.");

        AddWhseItemTrackingLines(
           WhseShptLine."Source Type", WhseShptLine."Source Subtype",
           WhseShptLine."No.", WhseShptLine."Line No.", TempLotBinContent);
    end;

    procedure ClearWhseItemTrackingLines(SourceType: Integer; SourceNo: Code[20]; SourceLineNo: Integer)
    var
        WhseItemTrkgLines: Record 6550;
        WhseShptLine: Record 7321;
    begin
        //get warehouse shipment line
        WhseShptLine.GET(SourceNo, SourceLineNo);


        //clear vars
        WhseItemTrkgLines.SETCURRENTKEY(
                           "Source ID", "Source Type", "Source Subtype", "Source Batch Name",
                                  "Source Prod. Order Line", "Source Ref. No.", "Location Code");

        WhseItemTrkgLines.SETRANGE("Source ID", SourceNo);
        WhseItemTrkgLines.SETRANGE("Source Type", DATABASE::"Warehouse Shipment Line");
        WhseItemTrkgLines.SETRANGE("Source Ref. No.", SourceLineNo);
        WhseItemTrkgLines.SETRANGE("Location Code", WhseShptLine."Location Code");
        IF WhseItemTrkgLines.FIND('-') THEN
            REPEAT
                IF WhseItemTrkgLines."Qty. Registered (Base)" <> 0 THEN BEGIN
                    WhseItemTrkgLines.VALIDATE("Quantity Handled (Base)", WhseItemTrkgLines."Qty. Registered (Base)");
                    WhseItemTrkgLines.VALIDATE("Quantity (Base)", WhseItemTrkgLines."Qty. Registered (Base)");
                    WhseItemTrkgLines.VALIDATE("Qty. to Handle", 0);
                    WhseItemTrkgLines.MODIFY();
                END
                ELSE
                    WhseItemTrkgLines.DELETE();
            UNTIL WhseItemTrkgLines.NEXT() = 0;
    end;

    procedure AddWhseItemTrackingLines(SourceType: Integer; SourceSubType: Integer; SourceNo: Code[20]; SourceLineNo: Integer; var TempLotBinContent: Record 50001 temporary)
    var
        WhseItemTrkgLines: Record 6550;
        WhseShptLine: Record 7321;
        LinesInserted: Boolean;
        LotNoToSet: Code[20];
        ExpirationDateToSet: Date;
        WarrantyDateToSet: Date;
        LineQty: Decimal;
        QtyAvailableBase: Decimal;
        QtyOnOrder: Decimal;
        LineQtyToPick: Integer;
        UseEntryNo: Integer;
    begin

        //exit if no lots found
        TempLotBinContent.SETCURRENTKEY("Creation Date", "Lot No.");
        TempLotBinContent.SETFILTER("Bin Type Code", GetBinTypeFilter(3)); // Picking area

        //>> ISTRTT 02-04-05 9638 filter on block movement
        TempLotBinContent.SETFILTER("Block Movement", '%1|%2',
            TempLotBinContent."Block Movement"::" ", TempLotBinContent."Block Movement"::Inbound);
        //<< ISTRTT 02-04-05 9638

        //>> 02-01-05 if a transfer, suggest newest first
        WhseShptLine.GET(SourceNo, SourceLineNo);
        IF WhseShptLine."Source Type" = DATABASE::"Transfer Line" THEN
            TempLotBinContent.ASCENDING(FALSE);
        //<<

        IF NOT TempLotBinContent.FIND('-') THEN
            EXIT;

        WhseShptLine.GET(SourceNo, SourceLineNo);
        WhseShptLine.CALCFIELDS("Pick Qty. (Base)");
        LineQtyToPick :=
          ROUND(
            (WhseShptLine."Qty. (Base)" - (WhseShptLine."Qty. Picked (Base)" + WhseShptLine."Pick Qty. (Base)")) /
              WhseShptLine."Qty. per Unit of Measure", 0.00001);


        //now begin loop through the table
        REPEAT
            //find qty available for Lot/Bin
            TempLotBinContent.CALCFIELDS(Quantity, "Pick Qty.", "Neg. Adjmt. Qty.");
            QtyAvailableBase :=
                         (TempLotBinContent.Quantity - TempLotBinContent."Pick Qty." -
                                     TempLotBinContent."Neg. Adjmt. Qty.") * TempLotBinContent."Qty. per Unit of Measure";

            QtyAvailableBase := QtyAvailableBase - QtyOnOrder;
            IF QtyAvailableBase < 0 THEN
                QtyAvailableBase := 0;


            LotNoToSet := TempLotBinContent."Lot No.";
            WarrantyDateToSet := 0D;  //these values could be set differently later
            ExpirationDateToSet := TempLotBinContent."Expiration Date"; //these values could be set differently later

            IF LineQtyToPick >= QtyAvailableBase THEN BEGIN
                LineQty := QtyAvailableBase;
                QtyAvailableBase := 0;
                LineQtyToPick := LineQtyToPick - LineQty;
                //MESSAGE('1 - Line Qty %1',LineQty);
            END
            ELSE BEGIN
                LineQty := LineQtyToPick;
                QtyAvailableBase := QtyAvailableBase - LineQty;
                LineQtyToPick := 0;
                //MESSAGE('2 - Line Qty %1',LineQty);
            END;


            //search for Lot in whse. item tracking
            WhseItemTrkgLines.SETCURRENTKEY(
                           "Source ID", "Source Type", "Source Subtype", "Source Batch Name",
                                  "Source Prod. Order Line", "Source Ref. No.", "Location Code");

            WhseItemTrkgLines.SETRANGE("Source ID", SourceNo);
            WhseItemTrkgLines.SETRANGE("Source Type", DATABASE::"Warehouse Shipment Line");
            WhseItemTrkgLines.SETRANGE("Source Ref. No.", SourceLineNo);
            WhseItemTrkgLines.SETRANGE("Location Code", WhseShptLine."Location Code");
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
                WhseItemTrkgLines."Item No." := WhseShptLine."Item No.";
                WhseItemTrkgLines."Location Code" := WhseShptLine."Location Code";
                WhseItemTrkgLines.VALIDATE("Quantity (Base)", LineQty);
                WhseItemTrkgLines.Description := WhseShptLine.Description;
                WhseItemTrkgLines."Source Type" := DATABASE::"Warehouse Shipment Line";
                WhseItemTrkgLines."Source ID" := SourceNo;
                WhseItemTrkgLines."Source Ref. No." := SourceLineNo;
                WhseItemTrkgLines."Qty. per Unit of Measure" := 1;
                WhseItemTrkgLines."Warranty Date" := WarrantyDateToSet;
                WhseItemTrkgLines."Expiration Date" := ExpirationDateToSet;
                WhseItemTrkgLines."Lot No." := TempLotBinContent."Lot No.";
                IF LineQty <> 0 THEN
                    WhseItemTrkgLines.INSERT();
            END;
        UNTIL (TempLotBinContent.NEXT = 0);



        IF LinesInserted THEN
            COMMIT();
    end;

    procedure "<<RF debug>>"()
    begin
    end;

   /* procedure DebugCreateFile()
    var
        RFDebugFile: File;
    begin
        IF EXISTS(RFDebugFileName) THEN
            ERASE(RFDebugFileName);

        CLEAR(RFDebugFile);
        RFDebugFile.TEXTMODE := TRUE;
        RFDebugFile.WRITEMODE := TRUE;
        //RFDebugFile.QUERYREPLACE := FALSE;
        RFDebugFile.CREATE(RFDebugFileName);
    end;*/

   /* procedure DebugWriteFile(TextString: Text[250])
    var
        RFDebugFile: File;
    begin
        RFDebugFile.TEXTMODE := TRUE;
        RFDebugFile.WRITEMODE := TRUE;
        RFDebugFile.OPEN(RFDebugFileName);
        RFDebugFile.SEEK(RFDebugFile.LEN);
        RFDebugFile.WRITE(TextString);
        RFDebugFile.CLOSE;
    end;*/

    procedure "<<Movement Form>>"()
    begin
    end;

    procedure LotHistory(ItemNo: Code[20]; LotNo: Code[20]; var Bins: array[50, 50] of Text[30]): Integer
    var
        Item: Record 27;
        ItemTrackingCode: Record 6502;
        LotNoInfo: Record 6505;
        BinContent: Record 7302;
        i: Integer;
        ItemType: Option "Item No.","Lot No.";
    begin
        //check to see if Item No. was entered
        IF Item.GET(LotNo) THEN BEGIN
            //if tracking code is blank, this must be an item that is not lot tracked
            IF Item."Item Tracking Code" = '' THEN
                ItemType := ItemType::"Item No."
            //else if invalid item tracking code, return error
            ELSE
                IF NOT ItemTrackingCode.GET(Item."Item Tracking Code") THEN
                    EXIT(-1)
                //otherwise, return error if item is lot tracked
                ELSE
                    IF ItemTrackingCode."Lot Specific Tracking" THEN
                        EXIT(-1);

            //if made it to this point, item is not lot tracked so set accordingly
            ItemType := ItemType::"Lot No.";
            LotNo := '';
            ItemNo := Item."No.";
        END
        ELSE
          //begin if lot was entered
          BEGIN
            //>> 10-30-05
            LotNoInfo.SETRANGE("Item No.", ItemNo);
            //<< 10-30-05
            LotNoInfo.SETRANGE("Lot No.", LotNo);
            LotNoInfo.SETRANGE(Blocked, FALSE);

            IF NOT LotNoInfo.FIND('-') THEN
                EXIT(-1);
            ItemNo := LotNoInfo."Item No.";
            ItemType := ItemType::"Lot No.";
        END;   //end if lot was entered

        BinContent.SETRANGE("Item No.", ItemNo);
        BinContent.SETFILTER(Quantity, '<>%1', 0);
        IF NOT BinContent.FIND('-') THEN
            EXIT(-1);


        REPEAT
            BinContent.CALCFIELDS(Quantity);
            i := i + 1;
            Bins[i, 1] := BinContent."Bin Code";
            Bins[i, 2] := BinContent."Location Code";
            Bins[i, 3] := FORMAT(BinContent.Quantity);
            Bins[i, 4] := FORMAT(BinContent."Max. Qty.");
            Bins[i, 5] := BinContent."Unit of Measure Code";

        UNTIL (BinContent.NEXT() = 0) OR (i = 50);

        EXIT(i);
    end;

    procedure "<<NIF>>"()
    begin
    end;

    procedure ApplyWhseEntry(var WhseEntry: Record 7312)
    var
        Item: Record 27;
        WhseEntry2: Record 7312;
        ApplyByExpDate: Boolean;
        ApplyByLicensePlate: Boolean;
        ApplyByLotNo: Boolean;
        ApplyBySerialNo: Boolean;
        SearchDirection: Code[1];
        ApplyQty: Decimal;
        Text001: Label 'is too small to apply to.';
        Text002: Label 'Cannot set required key for Warehouse Entry application. Changes are needed in codeunit 14017990.';
    begin
        IF WhseEntry."Remaining Qty. (Base)" = 0 THEN
            EXIT; // Nothing to apply

        // Setup dimensions to apply
        ApplyBySerialNo := TRUE;
        ApplyByLotNo := TRUE;
        ApplyByExpDate := TRUE;
        ApplyByLicensePlate := TRUE;

        WhseEntry2.RESET();
        IF WhseEntry."Applies-to Entry No." <> 0 THEN BEGIN
            //
            // Apply one specific entry
            //
            WhseEntry2.GET(WhseEntry."Applies-to Entry No."); // Must exist
            WhseEntry2.SETRECFILTER(); // Only settle this one record
            WhseEntry2.TESTFIELD("Item No.", WhseEntry."Item No.");
            WhseEntry2.TESTFIELD(Open, TRUE);
            WhseEntry2.TESTFIELD(Positive, NOT WhseEntry.Positive);
            WhseEntry2.TESTFIELD("Location Code", WhseEntry."Location Code");
            WhseEntry2.TESTFIELD("Zone Code", WhseEntry."Zone Code");
            WhseEntry2.TESTFIELD("Bin Code", WhseEntry."Bin Code");
            IF ApplyBySerialNo THEN
                WhseEntry2.TESTFIELD("Serial No.", WhseEntry."Serial No.");
            IF ApplyByLotNo THEN
                WhseEntry2.TESTFIELD("Lot No.", WhseEntry."Lot No.");
            IF ApplyByExpDate THEN
                WhseEntry2.TESTFIELD("Expiration Date", WhseEntry."Expiration Date");
            IF ApplyByLicensePlate THEN
                WhseEntry2.TESTFIELD("License Plate No.", WhseEntry."License Plate No.");
            IF ABS(WhseEntry2."Remaining Qty. (Base)") < ABS(WhseEntry."Remaining Qty. (Base)") THEN
                WhseEntry2.FIELDERROR("Remaining Qty. (Base)", Text001);
        END ELSE BEGIN
            //
            // Find entries to apply based on Item."Costing Method"
            //
            IF Item."Costing Method" = Item."Costing Method"::Specific THEN
                EXIT; // To be applied manually

            CASE TRUE OF
                NOT (ApplyBySerialNo OR ApplyByLotNo OR ApplyByExpDate):
                    WhseEntry2.SETCURRENTKEY(
                      "Item No.", Open, Positive, "Location Code", "Zone Code", "Bin Code", "Posting Date");
                ApplyBySerialNo AND ApplyByLotNo AND ApplyByExpDate:
                    WhseEntry2.SETCURRENTKEY(
                      "Item No.", Open, Positive, "Location Code", "Zone Code", "Bin Code", "Serial No.", "Lot No.", "Expiration Date", "Posting Date");
                // NOTE: No key for License Plate No. -- if required, a new key must be created
                ELSE
                    ERROR(Text002); // Cannot set required key
            END;

            WhseEntry2.SETRANGE("Item No.", WhseEntry."Item No.");
            WhseEntry2.SETRANGE("Location Code", WhseEntry."Location Code");
            WhseEntry2.SETRANGE("Zone Code", WhseEntry."Zone Code");
            WhseEntry2.SETRANGE("Bin Code", WhseEntry."Bin Code");
            WhseEntry2.SETRANGE(Open, TRUE);
            WhseEntry2.SETRANGE(Positive, NOT WhseEntry.Positive);
            IF ApplyBySerialNo THEN
                WhseEntry2.SETRANGE("Serial No.", WhseEntry."Serial No.");
            IF ApplyByLotNo THEN
                WhseEntry2.SETRANGE("Lot No.", WhseEntry."Lot No.");
            // >> IST 9165 10-19-04
            //IF ApplyByExpDate THEN
            //  WhseEntry2.SETRANGE("Expiration Date",WhseEntry."Expiration Date");
            // << IST 9165 10-19-04
            IF ApplyByLicensePlate THEN
                WhseEntry2.SETRANGE("License Plate No.", WhseEntry."License Plate No.");

            IF Item."Costing Method" = Item."Costing Method"::LIFO THEN
                SearchDirection := '+'
            ELSE
                SearchDirection := '-'; // FIFO, Standard, Average (Specific was excluded above at entry of BEGIN-END)

            IF NOT WhseEntry2.FIND(SearchDirection) THEN
                EXIT; // Nothing to apply -- leave entry open
        END;

        REPEAT
            //
            // Apply entries
            //
            IF ABS(WhseEntry2."Remaining Qty. (Base)") > ABS(WhseEntry."Remaining Qty. (Base)") THEN
                ApplyQty := WhseEntry."Remaining Qty. (Base)"
            ELSE
                ApplyQty := -WhseEntry2."Remaining Qty. (Base)";

            WhseEntry2."Remaining Qty. (Base)" := WhseEntry2."Remaining Qty. (Base)" + ApplyQty;
            WhseEntry2.Open := WhseEntry2."Remaining Qty. (Base)" <> 0;
            IF NOT WhseEntry2.Open THEN BEGIN
                WhseEntry2."Closed by Entry No." := WhseEntry."Entry No.";
                WhseEntry2."Closed at Date" := WhseEntry."Registering Date";
                WhseEntry2."Closed by Qty. (Base)" := -ApplyQty;
            END;
            WhseEntry2.MODIFY();

            WhseEntry."Remaining Qty. (Base)" := WhseEntry."Remaining Qty. (Base)" - ApplyQty;
            WhseEntry.Open := WhseEntry."Remaining Qty. (Base)" <> 0;
            IF (NOT WhseEntry.Open) AND WhseEntry2.Open THEN BEGIN
                WhseEntry."Closed by Entry No." := WhseEntry2."Entry No.";
                WhseEntry."Closed at Date" := WhseEntry2."Registering Date";
                WhseEntry."Closed by Qty. (Base)" := ApplyQty;
            END;

            IF NOT WhseEntry.Open THEN
                EXIT; // Done

            IF WhseEntry."Applies-to Entry No." <> 0 THEN
                EXIT; // Apply only one specific entry

        UNTIL NOT WhseEntry2.FIND(SearchDirection);
    end;

    procedure LookupDrawingRevision(ItemNo: Code[20]; var RevNo: Code[20]; var DrawNo: Code[30]; var RevDate: Date)
    var
        CustItemDrawing: Record 50142;
    begin
        IF ItemNo = '' THEN
            EXIT;

        CustItemDrawing.SETRANGE("Item No.", ItemNo);
        CustItemDrawing.SETRANGE("Customer No.", '');
        IF PAGE.RUNMODAL(0, CustItemDrawing) = ACTION::LookupOK THEN BEGIN
            RevNo := CustItemDrawing."Revision No.";
            DrawNo := CustItemDrawing."Drawing No.";
            RevDate := CustItemDrawing."Revision Date";
        END;
    end;

    procedure GetActiveDrawingRevision(ItemNo: Code[20]; var RevNo: Code[20]; var DrawNo: Code[30]; var RevDate: Date)
    var
        CustItemDrawing: Record 50142;
    begin

        CustItemDrawing.SETRANGE("Item No.", ItemNo);
        CustItemDrawing.SETRANGE("Customer No.", '');
        CustItemDrawing.SETRANGE(Active, TRUE);
        IF CustItemDrawing.FIND('-') THEN BEGIN
            RevNo := CustItemDrawing."Revision No.";
            DrawNo := CustItemDrawing."Drawing No.";
            RevDate := CustItemDrawing."Revision Date";
        END
        ELSE BEGIN
            RevNo := '';
            DrawNo := '';
            RevDate := 0D;
        END;
    end;

    procedure UpdateLotBinContentAlloc(var LotBinContent: Record 50001 temporary; QtyToAdd: Decimal)
    begin
        IF LotBinContentAlloc.GET(LotBinContent."Location Code", LotBinContent."Bin Code", LotBinContent."Item No.", LotBinContent."Variant Code", LotBinContent."Unit of Measure Code", LotBinContent."Lot No.") THEN BEGIN
            LotBinContentAlloc."Qty. to Handle (Base)" := LotBinContentAlloc."Qty. to Handle (Base)" + QtyToAdd;
            LotBinContentAlloc.MODIFY();
        END ELSE BEGIN
            LotBinContentAlloc.TRANSFERFIELDS(LotBinContent);
            LotBinContentAlloc."Qty. to Handle (Base)" := QtyToAdd;
            LotBinContentAlloc.INSERT();
        END;
    end;

    procedure GetLotBinContentsNonBin(var Item: Record 27; DeleteBinContents: Boolean; InsertQty: Boolean; var TempLotBinContent: Record 50001 temporary)
    var
        Location: Record 14;
        LotNoInfo: Record 6505;
    begin
        IF DeleteBinContents THEN
            TempLotBinContent.DELETEALL();

        Location.SETFILTER(Code, Item.GETFILTER("Location Filter"));
        Location.SETRANGE("Bin Mandatory", FALSE);
        IF Location.FIND('-') THEN
            REPEAT
                LotNoInfo.SETRANGE("Item No.", Item."No.");
                LotNoInfo.SETFILTER("Location Filter", Location.Code);
                LotNoInfo.SETFILTER("Variant Code", Item.GETFILTER("Variant Filter"));
                LotNoInfo.SETFILTER(Inventory, '<>0');

                IF LotNoInfo.FIND('-') THEN
                    REPEAT
                        IF NOT TempLotBinContent.GET(Location.Code, '', LotNoInfo."Item No.", LotNoInfo."Variant Code", Item."Base Unit of Measure", LotNoInfo."Lot No.") THEN BEGIN
                            TempLotBinContent.INIT();
                            TempLotBinContent."Location Code" := Location.Code;
                            TempLotBinContent."Item No." := LotNoInfo."Item No.";
                            TempLotBinContent."Bin Code" := '';
                            TempLotBinContent."Variant Code" := LotNoInfo."Variant Code";
                            TempLotBinContent."Unit of Measure Code" := Item."Base Unit of Measure";
                            TempLotBinContent."Lot No." := LotNoInfo."Lot No.";
                            TempLotBinContent."Qty. per Unit of Measure" := 1;
                            IF InsertQty THEN BEGIN
                                LotNoInfo.CALCFIELDS(Inventory);
                                TempLotBinContent."Qty. to Handle" := LotNoInfo.Inventory;
                                TempLotBinContent."Qty. to Handle (Base)" := LotNoInfo.Inventory;
                            END;
                            TempLotBinContent.INSERT();
                        END;
                    UNTIL LotNoInfo.NEXT() = 0;
            //END WITH LotNoInfo DO
            UNTIL Location.NEXT() = 0;
    end;

    procedure GetUserDefaultDims(FromLoc: Code[10]; ToLoc: Code[10]; var Dim1: Code[20]; var Dim2: Code[20])
    var
        UserSetup: Record 91;
        RespCenter: Record 5714;
        PackingStation: Record 14000709;
    begin
        IF NOT UserSetup.GET(USERID) THEN
            CLEAR(UserSetup);
        IF NOT RespCenter.GET(UserSetup."Purchase Resp. Ctr. Filter") THEN
            CLEAR(RespCenter);

        //if resp center not found, revert to To location
        IF RespCenter.Code = '' THEN BEGIN
            RespCenter.SETRANGE("Location Code", ToLoc);
            IF NOT RespCenter.FIND('-') THEN
                CLEAR(RespCenter);
        END;

        //if resp center not found, revert to From location
        IF RespCenter.Code = '' THEN BEGIN
            RespCenter.SETRANGE("Location Code", FromLoc);
            IF NOT RespCenter.FIND('-') THEN
                CLEAR(RespCenter);
        END;

        //if still none found, then take packing station state and match agains resp center  //032306
        IF RespCenter.Code = '' THEN
            IF PackingStation.GET(UserSetup."LAX Packing Station") THEN BEGIN
                RespCenter.RESET();
                RespCenter.SETRANGE(County, PackingStation."Ship-from State");
                IF NOT RespCenter.FIND('-') THEN
                    CLEAR(RespCenter);
            END;


        Dim1 := RespCenter."Global Dimension 1 Code";
        Dim2 := RespCenter."Global Dimension 2 Code";
    end;

    procedure SetPedimentoInfo(PatenteOrig: Code[10]; AuduanaES: Code[10]; PedimentNo: Code[10]; CVEPedimento: Code[10])
    begin
        TempLotNoInfo.DELETEALL();
        TempLotNoInfo."CVE Pedimento" := CVEPedimento;
        TempLotNoInfo."Pediment No." := PedimentNo;
        TempLotNoInfo."Patente Original" := PatenteOrig;
        TempLotNoInfo."Aduana E/S" := AuduanaES;
        TempLotNoInfo.INSERT();
    end;

    procedure ">>FC_FCN"()
    begin
    end;

    procedure CreateConnectionString(UseMaster: Boolean): Text[250]
    begin
    end;

    procedure CreateMovementReclass(ItemNo: Code[20]; var ToLotNo: Code[20]; ToLocCode: Code[20]; ToBinCode: Code[20]; FromLotNo: Code[20]; FromLocCode: Code[20]; FromBinCode: Code[20]; MfgLotNo: Text[30]; UserIDCode: Code[50]; Qty: Decimal; var ErrorMsg: Text[30]): Boolean
    var
        FromLocation: Record 14;
        ToLocation: Record 14;
        Item: Record 27;
        ItemLedgerEntry: Record 32;
        ItemJnlLine: Record 83;
        GLSetup: Record 98;
        ReservEntry: Record 337;
        TempILEDimSetEntry: Record 480 temporary;
        TempItemJnlDimSetEntry: Record 480 temporary;
        TempItemJnlDimSetEntry2: Record 480 temporary;
        ItemTrackingCode: Record 6502;
        LotNoInfo: Record 6505;
        LotNoInfo2: Record 6505;
        ToLotNoInfo: Record 6505;
        WhseEmp: Record 7301;
        FromWhseJnlLine: Record 7311;
        ToWhseJnlLine: Record 7311;
        BinContentBuffer: Record 7330 temporary;
        FromBin: Record 7354;
        ToBin: Record 7354;
        ItemJnlPostLine: Codeunit 22;
        NoSeriesMgt: Codeunit 396;
        DimMgt: Codeunit 408;
        WhseJnlRegisterLine: Codeunit 7301;
        UseEntryNo: Integer;
    begin
        //valid from lot
        LotNoInfo.SETRANGE("Item No.", ItemNo);
        LotNoInfo.SETRANGE("Lot No.", FromLotNo);
        LotNoInfo.SETRANGE(Blocked, FALSE);
        IF NOT LotNoInfo.FIND('-') THEN BEGIN
            ErrorMsg := COPYSTR(STRSUBSTNO('Lot %1 not found', FromLotNo), 1, 30);
            EXIT(FALSE);
        END;

        //check item
        IF NOT Item.GET(LotNoInfo."Item No.") THEN BEGIN
            ErrorMsg := COPYSTR(STRSUBSTNO('Invalid Item %1', LotNoInfo."Item No."), 1, 30);
            EXIT(FALSE);
        END;

        //assign To Lot if blank
        IF ToLotNo = '' THEN BEGIN
            Item.TESTFIELD("Lot Nos.");
            ToLotNo := NoSeriesMgt.GetNextNo(Item."Lot Nos.", TODAY, TRUE);
        END;

        //>> NIF 03-13-06 RTT
        //prevent dupl lot make sure ToLotNo does not exist for another item
        ToLotNoInfo.RESET();
        ToLotNoInfo.SETFILTER("Item No.", '<>%1', ItemNo);
        ToLotNoInfo.SETRANGE("Lot No.", ToLotNo);
        IF ToLotNoInfo.FIND('-') THEN BEGIN
            IF GUIALLOWED THEN
                MESSAGE('DUPLICATE:  Lot %1 already exists for Item %2.', ToLotNo, ToLotNoInfo."Item No.");
            ErrorMsg := 'Close Screen and try again.';
            EXIT(FALSE);
        END;
        ToLotNoInfo.RESET();
        //<< NIF 03-13-06 RTT

        IF NOT ToLotNoInfo.GET(Item."No.", '', ToLotNo) THEN BEGIN
            ToLotNoInfo.INIT();
            ToLotNoInfo.TRANSFERFIELDS(LotNoInfo);
            ToLotNoInfo."Lot No." := ToLotNo;
            ToLotNoInfo."Mfg. Lot No." := MfgLotNo;
            //check QC status
            IF LotNoInfo."Mfg. Lot No." <> '' THEN BEGIN
                LotNoInfo2.SETCURRENTKEY("Item No.", "Mfg. Lot No.");
                LotNoInfo2.SETRANGE("Item No.", ToLotNoInfo."Item No.");
                LotNoInfo2.SETRANGE("Mfg. Lot No.", ToLotNoInfo."Mfg. Lot No.");
                LotNoInfo2.SETRANGE("Passed Inspection", TRUE);
                IF LotNoInfo2.FIND('-') THEN BEGIN
                    ToLotNoInfo."Passed Inspection" := TRUE;
                    ToLotNoInfo."Inspection Comments" :=
                      STRSUBSTNO('Passed Inspection per Lot %1, same Mfg. Lot No. %2', LotNoInfo2."Lot No.", LotNoInfo2."Mfg. Lot No.");
                END;
            END;
            ToLotNoInfo."Lot Creation Date" := TODAY;
            //>>NIF 050906 RTT MEX
            IF NOT TempLotNoInfo.ISEMPTY THEN BEGIN
                ToLotNoInfo."Patente Original" := TempLotNoInfo."Patente Original";
                ToLotNoInfo."Aduana E/S" := TempLotNoInfo."Aduana E/S";
                ToLotNoInfo."Pediment No." := TempLotNoInfo."Pediment No.";
                ToLotNoInfo."CVE Pedimento" := TempLotNoInfo."CVE Pedimento";
            END;
            //<<NIF 050906 RTT MEX
            ToLotNoInfo.INSERT();
        END;

        //make sure to/from location is valid
        IF NOT FromLocation.GET(FromLocCode) THEN BEGIN
            ErrorMsg := 'From Loc not found';
            EXIT(FALSE);
        END;

        IF NOT ToLocation.GET(ToLocCode) THEN BEGIN
            ErrorMsg := 'To Loc not found';
            EXIT(FALSE);
        END;


        //find bin contents if from location is bin enabled
        IF FromLocation."Bin Mandatory" THEN BEGIN
            LotNoInfo.GetBinContentBuffer(BinContentBuffer);
            BinContentBuffer.SETRANGE("Location Code", FromLocCode);
            BinContentBuffer.SETRANGE("Bin Code", FromBinCode);
            IF NOT BinContentBuffer.FIND('-') THEN BEGIN
                ErrorMsg := COPYSTR(STRSUBSTNO('No Lot-Bin Qty: %1-%2', FromLotNo, BinContentBuffer.GETFILTER("Bin Code")), 1, 30);
                EXIT(FALSE);
            END;
            IF BinContentBuffer."Qty. to Handle (Base)" < Qty THEN BEGIN
                ErrorMsg := COPYSTR(STRSUBSTNO('Invalid Bin Qty %1 vs OH %2', Qty, BinContentBuffer."Qty. to Handle (Base)"), 1, 30);
                EXIT(FALSE);
            END;
        END;

        //valid to to bin
        IF (NOT ToBin.GET(ToLocCode, ToBinCode)) AND (ToLocation."Bin Mandatory") THEN BEGIN
            ErrorMsg := COPYSTR(STRSUBSTNO('To Bin %1 invalid', ToBinCode), 1, 30);
            EXIT(FALSE);
        END;

        //valid from bin
        IF (NOT FromBin.GET(FromLocCode, FromBinCode)) AND (FromLocation."Bin Mandatory") THEN BEGIN
            ErrorMsg := COPYSTR(STRSUBSTNO('From Bin %1 invalid', FromBinCode), 1, 30);
            EXIT(FALSE);
        END;

        //valid item onhand
        Item.SETRANGE("Location Filter", FromLocCode);
        Item.SETRANGE("Lot No. Filter", FromLotNo);
        Item.CALCFIELDS(Inventory);
        IF Item.Inventory < Qty THEN BEGIN
            ErrorMsg := COPYSTR(STRSUBSTNO('Invalid Qty %1 vs OH %2', Qty, Item.Inventory), 1, 30);
            EXIT(FALSE);
        END;

        //post transaction
        ItemJnlLine.INIT();
        ItemJnlLine."Posting Date" := WORKDATE();
        ItemJnlLine."Document Date" := WORKDATE();
        ItemJnlLine."Document No." := 'RCLS' + FORMAT(WORKDATE(), 6, 5);
        ItemJnlLine.Description := 'Lot Reclass';
        ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::Transfer;
        ItemJnlLine."Item No." := ItemNo;
        //>> RTT 06-12-05
        GLSetup.GET();
        //xItemJnlLine."Shortcut Dimension 1 Code" := 'MPD';
        //xItemJnlLine."New Shortcut Dimension 1 Code" := 'MPD';

        //>> RTT 02-16-06
        GetUserDefaultDims(FromLocCode, ToLocCode, ItemJnlLine."Shortcut Dimension 1 Code", ItemJnlLine."Shortcut Dimension 2 Code");

        //>>NF1.00:CIS.NG  10-12-15
        FillDimSetEntry_gFnc(ItemJnlLine."Dimension Set ID", TempDimSetEntry);
        UpdateDimSetEntry_gFnc(TempDimSetEntry, GLSetup."Global Dimension 1 Code", ItemJnlLine."Shortcut Dimension 1 Code");
        UpdateDimSetEntry_gFnc(TempDimSetEntry, GLSetup."Global Dimension 2 Code", ItemJnlLine."Shortcut Dimension 2 Code");
        ItemJnlLine."Dimension Set ID" := GetDimensionSetID_gFnc(TempDimSetEntry);
        UpdGlobalDimFromSetID_gFnc(ItemJnlLine."Dimension Set ID", ItemJnlLine."Shortcut Dimension 1 Code", ItemJnlLine."Shortcut Dimension 2 Code");
        //<<NF1.00:CIS.NG  10-12-15

        ItemJnlLine."New Shortcut Dimension 1 Code" := ItemJnlLine."Shortcut Dimension 1 Code";
        ItemJnlLine."New Shortcut Dimension 2 Code" := ItemJnlLine."Shortcut Dimension 2 Code";

        //>>NF1.00:CIS.NG  10-12-15
        FillDimSetEntry_gFnc(ItemJnlLine."New Dimension Set ID", TempDimSetEntry);
        UpdateDimSetEntry_gFnc(TempDimSetEntry, GLSetup."Global Dimension 1 Code", ItemJnlLine."New Shortcut Dimension 1 Code");
        UpdateDimSetEntry_gFnc(TempDimSetEntry, GLSetup."Global Dimension 2 Code", ItemJnlLine."New Shortcut Dimension 2 Code");
        ItemJnlLine."New Dimension Set ID" := GetDimensionSetID_gFnc(TempDimSetEntry);
        UpdGlobalDimFromSetID_gFnc(ItemJnlLine."New Dimension Set ID", ItemJnlLine."New Shortcut Dimension 1 Code", ItemJnlLine."New Shortcut Dimension 2 Code");
        //<<NF1.00:CIS.NG  10-12-15

        IF ItemJnlLine."Shortcut Dimension 1 Code" <> '' THEN;
        //<< RTT 02-16-06
        //TempJnlLineDim."Table ID" := DATABASE::"Item Journal Line";
        //TempJnlLineDim."Journal Template Name" := ItemJnlLine."Journal Template Name";
        //TempJnlLineDim."Journal Batch Name" := ItemJnlLine."Journal Batch Name";
        //TempJnlLineDim."Journal Line No." := ItemJnlLine."Line No.";
        //TempJnlLineDim."Dimension Code" := GLSetup."Global Dimension 1 Code";
        //TempJnlLineDim."Dimension Value Code" := ItemJnlLine."Shortcut Dimension 1 Code";
        //TempJnlLineDim."New Dimension Value Code" := ItemJnlLine."New Shortcut Dimension 1 Code";
        //TempJnlLineDim.INSERT;
        //>> RTT 02-16-06

        //IF ItemJnlLine."Shortcut Dimension 2 Code"<>'' THEN BEGIN
        //  TempJnlLineDim."Table ID" := DATABASE::"Item Journal Line";
        //  TempJnlLineDim."Journal Template Name" := ItemJnlLine."Journal Template Name";
        //  TempJnlLineDim."Journal Batch Name" := ItemJnlLine."Journal Batch Name";
        //  TempJnlLineDim."Journal Line No." := ItemJnlLine."Line No.";
        //  TempJnlLineDim."Dimension Code" := GLSetup."Global Dimension 2 Code";
        //  TempJnlLineDim."Dimension Value Code" := ItemJnlLine."Shortcut Dimension 2 Code";
        //  TempJnlLineDim."New Dimension Value Code" := ItemJnlLine."New Shortcut Dimension 2 Code";
        //  TempJnlLineDim.INSERT;
        //END;
        //<< RTT 02-16-06
        //<< RTT 06-12-05

        //NIF1.01 Start
        IF AppliesToEntryNoGbl <> 0 THEN BEGIN
            TempItemJnlDimSetEntry.RESET();
            TempItemJnlDimSetEntry.DELETEALL();
            TempILEDimSetEntry.RESET();
            TempILEDimSetEntry.DELETEALL();

            IF ItemLedgerEntry.GET(AppliesToEntryNoGbl) THEN;

            DimMgt.GetDimensionSet(TempItemJnlDimSetEntry, ItemJnlLine."Dimension Set ID");
            DimMgt.GetDimensionSet(TempILEDimSetEntry, ItemLedgerEntry."Dimension Set ID");

            TempItemJnlDimSetEntry2.RESET();
            TempItemJnlDimSetEntry2.DELETEALL();

            TempItemJnlDimSetEntry.RESET();
            IF TempItemJnlDimSetEntry.FINDSET() THEN
                REPEAT
                    TempItemJnlDimSetEntry2.INIT();
                    TempItemJnlDimSetEntry2.TRANSFERFIELDS(TempItemJnlDimSetEntry);
                    TempItemJnlDimSetEntry2."Dimension Set ID" := 0;
                    TempItemJnlDimSetEntry2.INSERT();
                UNTIL TempItemJnlDimSetEntry.NEXT() = 0;

            TempILEDimSetEntry.SETRANGE("Dimension Code", GLSetup."Global Dimension 1 Code");
            IF TempILEDimSetEntry.FINDSET() THEN
                REPEAT
                    TempItemJnlDimSetEntry2.SETRANGE("Dimension Code", TempILEDimSetEntry."Dimension Code");
                    IF TempItemJnlDimSetEntry2.FINDFIRST() THEN
                        IF TempItemJnlDimSetEntry2."Dimension Value Code" <> TempILEDimSetEntry."Dimension Value Code" THEN BEGIN
                            TempItemJnlDimSetEntry2.VALIDATE("Dimension Value Code", TempILEDimSetEntry."Dimension Value Code");
                            TempItemJnlDimSetEntry2.MODIFY();
                        END;
                UNTIL TempILEDimSetEntry.NEXT() = 0
            ELSE BEGIN
                TempItemJnlDimSetEntry2.SETRANGE("Dimension Code", GLSetup."Global Dimension 1 Code");
                IF TempItemJnlDimSetEntry2.FINDFIRST() THEN
                    TempItemJnlDimSetEntry2.DELETE();
            END;
            ItemJnlLine.VALIDATE("Dimension Set ID", DimMgt.GetDimensionSetID(TempItemJnlDimSetEntry2));
            ItemJnlLine.VALIDATE("New Dimension Set ID", DimMgt.GetDimensionSetID(TempItemJnlDimSetEntry2));

            TempItemJnlDimSetEntry2.SETRANGE("Dimension Code", GLSetup."Global Dimension 1 Code");
            IF TempItemJnlDimSetEntry2.FINDFIRST() THEN BEGIN
                ItemJnlLine.VALIDATE("Shortcut Dimension 1 Code", TempItemJnlDimSetEntry2."Dimension Value Code");
                ItemJnlLine.VALIDATE("New Shortcut Dimension 1 Code", TempItemJnlDimSetEntry2."Dimension Value Code");
            END;
        END;
        //NIF1.01 End

        ItemJnlLine."Location Code" := FromLocCode;
        ItemJnlLine."New Location Code" := ToLocCode;
        ItemJnlLine.Quantity := Qty;
        ItemJnlLine."Invoiced Quantity" := Qty;
        ItemJnlLine."Quantity (Base)" := Qty;
        ItemJnlLine."Invoiced Qty. (Base)" := Qty;
        //ItemJnlLine."Source Code" := SourceCode;
        Item.GET(ItemNo);
        ItemJnlLine."Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";
        ItemJnlLine."Inventory Posting Group" := Item."Inventory Posting Group";
        ItemJnlLine."Unit of Measure Code" := Item."Base Unit of Measure";
        ItemJnlLine."Qty. per Unit of Measure" := 1;
        ItemJnlLine."Bin Code" := FromBinCode;
        ItemJnlLine."New Bin Code" := ToBinCode;
        //>> NIF 07-10-05
        ItemJnlLine."Revision No." := ToLotNoInfo."Revision No.";
        ItemJnlLine."Drawing No." := ToLotNoInfo."Drawing No.";
        ItemJnlLine."Revision No." := ToLotNoInfo."Revision No.";
        //<< NIF 07-10-05


        //BEGIN lot logic
        //insert lot no. if item tracking is required
        IF (ItemTrackingCode.GET(Item."Item Tracking Code")) AND (ItemTrackingCode."Lot Pos. Adjmt. Outb. Tracking") THEN BEGIN
            IF ReservEntry.FIND('+') THEN
                UseEntryNo := ReservEntry."Entry No." + 1
            ELSE
                UseEntryNo := 1;

            ReservEntry.INIT();
            ReservEntry."Entry No." := UseEntryNo;
            ReservEntry.Positive := (ItemJnlLine.Quantity > 0);
            ReservEntry."Item No." := ItemJnlLine."Item No.";
            ReservEntry."Location Code" := ItemJnlLine."Location Code";
            ReservEntry."Quantity (Base)" := -ItemJnlLine."Quantity (Base)";
            ReservEntry."Reservation Status" := ReservEntry."Reservation Status"::Prospect;
            ReservEntry."Creation Date" := ItemJnlLine."Posting Date";
            ReservEntry."Source Type" := 83;
            ReservEntry."Source Subtype" := 4;
            ReservEntry."Source ID" := ItemJnlLine."Journal Template Name";
            ReservEntry."Source Batch Name" := ItemJnlLine."Journal Batch Name";
            ReservEntry."Source Ref. No." := ItemJnlLine."Line No.";
            ReservEntry."Shipment Date" := ItemJnlLine."Posting Date";
            ReservEntry."Created By" := USERID;
            ReservEntry."Qty. per Unit of Measure" := ItemJnlLine."Qty. per Unit of Measure";
            ReservEntry.Quantity := ItemJnlLine.Quantity;
            ReservEntry."Planning Flexibility" := ReservEntry."Planning Flexibility"::Unlimited;
            ReservEntry."Qty. to Handle (Base)" := -ItemJnlLine."Quantity (Base)";
            ReservEntry."Qty. to Invoice (Base)" := -ItemJnlLine."Quantity (Base)";
            ReservEntry."Mfg. Lot No." := MfgLotNo;
            ReservEntry."New Lot No." := ToLotNo;
            ReservEntry."Lot No." := FromLotNo;
            //NIF1.01 Start
            IF AppliesToEntryNoGbl <> 0 THEN
                ReservEntry.VALIDATE("Appl.-to Item Entry", AppliesToEntryNoGbl);
            //NIF1.01 End
            ReservEntry.INSERT();
            //END; //end tracking line insertion
        END ELSE
            //NIF1.01 Start
            IF AppliesToEntryNoGbl <> 0 THEN
                ItemJnlLine.VALIDATE("Applies-to Entry", AppliesToEntryNoGbl);
        //NIF1.01 End
        //end lot logic

        IF FromLocation."Bin Mandatory" THEN BEGIN
            FromWhseJnlLine.INIT();
            FromWhseJnlLine."Location Code" := ItemJnlLine."Location Code";
            FromWhseJnlLine."Item No." := ItemJnlLine."Item No.";
            FromWhseJnlLine."Registering Date" := ItemJnlLine."Posting Date";
            FromWhseJnlLine."Reference Document" := FromWhseJnlLine."Reference Document"::"Item Journal";
            FromWhseJnlLine."Reference No." := ItemJnlLine."Document No.";
            FromWhseJnlLine.Description := 'Bin Movement';
            FromWhseJnlLine."Posting Date" := ItemJnlLine."Posting Date";
            FromWhseJnlLine."User ID" := WhseEmp."User ID";
            FromWhseJnlLine."Entry Type" := FromWhseJnlLine."Entry Type"::Movement;
            //FromWhseJnlline."From Zone Code" := FromBin."Zone Code";
            //FromWhseJnlline."From Bin Code" := ItemJnlLine."Bin Code";
            FromWhseJnlLine."To Zone Code" := ToBin."Zone Code";
            FromWhseJnlLine."To Bin Code" := ItemJnlLine."Bin Code";
            FromWhseJnlLine."Unit of Measure Code" := ItemJnlLine."Unit of Measure Code";
            FromWhseJnlLine."Qty. per Unit of Measure" := ItemJnlLine."Qty. per Unit of Measure";
            FromWhseJnlLine.Quantity := -ItemJnlLine.Quantity;
            FromWhseJnlLine."Qty. (Base)" := -ItemJnlLine."Quantity (Base)";
            FromWhseJnlLine."Lot No." := FromLotNo;
            FromWhseJnlLine."Qty. (Absolute)" := -ItemJnlLine.Quantity;
            FromWhseJnlLine."Qty. (Absolute, Base)" := -ItemJnlLine."Quantity (Base)";
        END;

        IF ToLocation."Bin Mandatory" THEN BEGIN
            ToWhseJnlLine.INIT();
            ToWhseJnlLine."Location Code" := ItemJnlLine."New Location Code";
            ToWhseJnlLine."Item No." := ItemJnlLine."Item No.";
            ToWhseJnlLine."Registering Date" := ItemJnlLine."Posting Date";
            ToWhseJnlLine."Reference Document" := ToWhseJnlLine."Reference Document"::"Item Journal";
            ToWhseJnlLine."Reference No." := ItemJnlLine."Document No.";
            ToWhseJnlLine.Description := 'Bin Movement';
            ToWhseJnlLine."Posting Date" := ItemJnlLine."Posting Date";
            ToWhseJnlLine."User ID" := WhseEmp."User ID";
            ToWhseJnlLine."Entry Type" := ToWhseJnlLine."Entry Type"::Movement;
            //tOWHSEJNLLINE."From Zone Code" := FromBin."Zone Code";
            //tOWHSEJNLLINE."From Bin Code" := ItemJnlLine."Bin Code";
            ToWhseJnlLine."To Zone Code" := ToBin."Zone Code";
            ToWhseJnlLine."To Bin Code" := ItemJnlLine."New Bin Code";
            ToWhseJnlLine."Unit of Measure Code" := ItemJnlLine."Unit of Measure Code";
            ToWhseJnlLine."Qty. per Unit of Measure" := ItemJnlLine."Qty. per Unit of Measure";
            ToWhseJnlLine.Quantity := ItemJnlLine.Quantity;
            ToWhseJnlLine."Qty. (Base)" := ItemJnlLine."Quantity (Base)";
            ToWhseJnlLine."Lot No." := ToLotNo;
            ToWhseJnlLine."Qty. (Absolute)" := ItemJnlLine.Quantity;
            ToWhseJnlLine."Qty. (Absolute, Base)" := ItemJnlLine."Quantity (Base)";
        END;

        ItemJnlPostLine.RunWithCheck(ItemJnlLine);
        IF FromLocation."Bin Mandatory" THEN
            WhseJnlRegisterLine.RUN(FromWhseJnlLine);
        IF ToLocation."Bin Mandatory" THEN
            WhseJnlRegisterLine.RUN(ToWhseJnlLine);


        EXIT(TRUE);
    end;

    procedure CreateMovementLoc(ItemNo: Code[20]; LotNo: Code[20]; ToLocCode: Code[20]; ToBinCode: Code[20]; FromLocCode: Code[20]; FromBinCode: Code[20]; UserIDCode: Code[50]; Qty: Decimal; var ErrorMsg: Text[30]): Boolean
    var
        Location: Record 14;
        Item: Record 27;
        ItemJnlLine: Record 83;
        GLSetup: Record 98;
        ReservEntry: Record 337;
        ItemTrackingCode: Record 6502;
        LotNoInfo: Record 6505;
        WhseEmp: Record 7301;
        BinContent: Record 7302;
        FromWhseJnlLine: Record 7311;
        ToWhseJnlLine: Record 7311;
        BinContentBuffer: Record 7330 temporary;
        FromBin: Record 7354;
        ToBin: Record 7354;
        ItemJnlPostLine: Codeunit 22;
        WhseJnlRegisterLine: Codeunit 7301;
        UseEntryNo: Integer;
        ItemType: Option "Item No.","Lot No.";
    begin
        IF LotNo = '' THEN BEGIN
            //make sure is valid item
            IF NOT Item.GET(ItemNo) THEN BEGIN
                ErrorMsg := COPYSTR(STRSUBSTNO('Invalid Item: %1', ItemNo), 1, 30);
                EXIT(FALSE);
            END ELSE
                //if tracking code is blank, this must be an item that is not lot tracked
                IF Item."Item Tracking Code" = '' THEN
                    ItemType := ItemType::"Item No."
                //else if invalid item tracking code, return error
                ELSE
                    IF NOT ItemTrackingCode.GET(Item."Item Tracking Code") THEN BEGIN
                        ErrorMsg := COPYSTR(STRSUBSTNO('Invalid Trkg. Code: %1', Item."No."), 1, 30);
                        EXIT(FALSE);
                    END
                    //otherwise, return error if item is lot tracked
                    ELSE
                        IF ItemTrackingCode."Lot Specific Tracking" THEN BEGIN
                            ErrorMsg := COPYSTR(STRSUBSTNO('Lot mandatory: Item %1.', Item."No."), 1, 30);
                            EXIT(FALSE);
                        END;

            //if made it to this point, item is not lot tracked so set accordingly
            LotNo := '';
            ItemNo := Item."No.";
        END
        ELSE
          //begin if lot was entered
          BEGIN
            //valid lot
            LotNoInfo.SETRANGE("Item No.", ItemNo);
            LotNoInfo.SETRANGE("Lot No.", LotNo);
            LotNoInfo.SETRANGE(Blocked, FALSE);

            IF NOT LotNoInfo.FIND('-') THEN BEGIN
                ErrorMsg := COPYSTR(STRSUBSTNO('Lot %1 not found', LotNo), 1, 30);
                EXIT(FALSE);
            END;

            ItemNo := LotNoInfo."Item No.";
            LotNo := LotNoInfo."Lot No.";
            ItemType := ItemType::"Lot No.";
        END;

        //get usersetup , then location
        WhseEmp.SETRANGE("User ID", UserIDCode);
        IF NOT WhseEmp.FIND('-') THEN BEGIN
            ErrorMsg := COPYSTR(STRSUBSTNO('No User Setup %1', UserIDCode), 1, 30);
            EXIT(FALSE);
        END;

        //see if user is allowed to use from location
        WhseEmp.SETRANGE("Location Code", FromLocCode);
        IF NOT WhseEmp.FIND('-') THEN BEGIN
            ErrorMsg := 'Location invalid';
            EXIT(FALSE);
        END;

        //make sure frolocation is valid
        IF NOT Location.GET(FromLocCode) THEN BEGIN
            ErrorMsg := 'From Loc not found';
            EXIT(FALSE);
        END;

        IF NOT Location.GET(ToLocCode) THEN BEGIN
            ErrorMsg := 'To Loc not found';
            EXIT(FALSE);
        END;



        IF ItemType = ItemType::"Lot No." THEN BEGIN
            //check item
            IF NOT Item.GET(LotNoInfo."Item No.") THEN BEGIN
                ErrorMsg := COPYSTR(STRSUBSTNO('Invalid Item %1', LotNoInfo."Item No."), 1, 30);
                EXIT(FALSE);
            END;

            //find bin contents
            LotNoInfo.GetBinContentBuffer(BinContentBuffer);

            //if from bin is blank, use RDOCK (default receiving bin)
            IF FromBinCode = '' THEN BEGIN
                Location.GET(WhseEmp."Location Code");
                FromBinCode := Location."Receipt Bin Code";
            END;


            BinContentBuffer.SETRANGE("Location Code", FromLocCode);
            BinContentBuffer.SETRANGE("Bin Code", FromBinCode);

            IF NOT BinContentBuffer.FIND('-') THEN BEGIN
                ErrorMsg := COPYSTR(STRSUBSTNO('No Lot-Bin Qty: %1-%2', LotNo, BinContentBuffer.GETFILTER("Bin Code")), 1, 30);
                EXIT(FALSE);
            END;

            IF BinContentBuffer."Qty. to Handle (Base)" < Qty THEN BEGIN
                ErrorMsg := COPYSTR(STRSUBSTNO('Invalid Bin Qty %1 vs OH %2', Qty, BinContentBuffer."Qty. to Handle (Base)"), 1, 30);
                EXIT(FALSE);
            END;
        END ELSE BEGIN
            BinContent.SETRANGE("Item No.", ItemNo);
            BinContent.SETRANGE("Bin Code", FromBinCode);
            BinContent.SETRANGE("Qty. per Unit of Measure", 1);
            BinContent.SETFILTER(Quantity, '>=%1', Qty);
            IF NOT BinContent.FIND('-') THEN BEGIN
                ErrorMsg := COPYSTR(STRSUBSTNO('No Item-Bin Qty: %1-%2', ItemNo, FromBinCode), 1, 30);
                EXIT(FALSE);
            END;
        END;

        //if shortcut, then use shipping bin
        IF ToBinCode = '0' THEN BEGIN
            Location.GET(FromLocCode);
            ToBinCode := Location."Shipment Bin Code";
        END;

        //valid to to bin
        IF NOT ToBin.GET(ToLocCode, ToBinCode) THEN BEGIN
            ErrorMsg := COPYSTR(STRSUBSTNO('To Bin %1 invalid', ToBinCode), 1, 30);
            EXIT(FALSE);
        END;

        //valid from bin
        IF NOT FromBin.GET(FromLocCode, FromBinCode) THEN BEGIN
            ErrorMsg := COPYSTR(STRSUBSTNO('From Bin %1 invalid', FromBinCode), 1, 30);
            EXIT(FALSE);
        END;

        //if item at this point is invalid, then error
        IF NOT Item.GET(ItemNo) THEN BEGIN
            ErrorMsg := COPYSTR(STRSUBSTNO('Item is %1 invalid', ItemNo), 1, 30);
            EXIT(FALSE);
        END;

        Item.SETRANGE("Location Filter", FromLocCode);
        Item.CALCFIELDS(Inventory);
        IF Item.Inventory < Qty THEN BEGIN
            ErrorMsg := COPYSTR(STRSUBSTNO('Invalid Qty %1 vs OH %2', Qty, Item.Inventory), 1, 30);
            EXIT(FALSE);
        END;


        //post transaction
        ItemJnlLine.INIT();
        ItemJnlLine."Posting Date" := WORKDATE();
        ItemJnlLine."Document Date" := WORKDATE();
        ItemJnlLine."Document No." := 'XF ' + FORMAT(WORKDATE(), 6, 5);
        ItemJnlLine.Description := 'Location Movement';
        ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::Transfer;
        ItemJnlLine."Item No." := ItemNo;
        //>> RTT 06-12-05
        GLSetup.GET();

        //XItemJnlLine."Shortcut Dimension 1 Code" := 'MPD';
        //XItemJnlLine."New Shortcut Dimension 1 Code" := 'MPD';
        //>> RTT 02-16-06
        GetUserDefaultDims(FromLocCode, ToLocCode, ItemJnlLine."Shortcut Dimension 1 Code", ItemJnlLine."Shortcut Dimension 2 Code");

        //>>NF1.00:CIS.NG  10-12-15
        FillDimSetEntry_gFnc(ItemJnlLine."Dimension Set ID", TempDimSetEntry);
        UpdateDimSetEntry_gFnc(TempDimSetEntry, GLSetup."Global Dimension 1 Code", ItemJnlLine."Shortcut Dimension 1 Code");
        UpdateDimSetEntry_gFnc(TempDimSetEntry, GLSetup."Global Dimension 2 Code", ItemJnlLine."Shortcut Dimension 2 Code");
        ItemJnlLine."Dimension Set ID" := GetDimensionSetID_gFnc(TempDimSetEntry);
        UpdGlobalDimFromSetID_gFnc(ItemJnlLine."Dimension Set ID", ItemJnlLine."Shortcut Dimension 1 Code", ItemJnlLine."Shortcut Dimension 2 Code");
        //<<NF1.00:CIS.NG  10-12-15


        ItemJnlLine."New Shortcut Dimension 1 Code" := ItemJnlLine."Shortcut Dimension 1 Code";
        ItemJnlLine."New Shortcut Dimension 2 Code" := ItemJnlLine."Shortcut Dimension 2 Code";

        //>>NF1.00:CIS.NG  10-12-15
        FillDimSetEntry_gFnc(ItemJnlLine."New Dimension Set ID", TempDimSetEntry);
        UpdateDimSetEntry_gFnc(TempDimSetEntry, GLSetup."Global Dimension 1 Code", ItemJnlLine."New Shortcut Dimension 1 Code");
        UpdateDimSetEntry_gFnc(TempDimSetEntry, GLSetup."Global Dimension 2 Code", ItemJnlLine."New Shortcut Dimension 2 Code");
        ItemJnlLine."New Dimension Set ID" := GetDimensionSetID_gFnc(TempDimSetEntry);
        UpdGlobalDimFromSetID_gFnc(ItemJnlLine."New Dimension Set ID", ItemJnlLine."New Shortcut Dimension 1 Code", ItemJnlLine."New Shortcut Dimension 2 Code");
        //<<NF1.00:CIS.NG  10-12-15

        IF ItemJnlLine."Shortcut Dimension 1 Code" <> '' THEN;
        //<< RTT 02-16-06
        //TempJnlLineDim."Table ID" := DATABASE::"Item Journal Line";
        //TempJnlLineDim."Journal Template Name" := ItemJnlLine."Journal Template Name";
        //TempJnlLineDim."Journal Batch Name" := ItemJnlLine."Journal Batch Name";
        //TempJnlLineDim."Journal Line No." := ItemJnlLine."Line No.";
        //TempJnlLineDim."Dimension Code" := GLSetup."Global Dimension 1 Code";
        //TempJnlLineDim."Dimension Value Code" := ItemJnlLine."Shortcut Dimension 1 Code";
        //TempJnlLineDim."New Dimension Value Code" := ItemJnlLine."New Shortcut Dimension 1 Code";
        //TempJnlLineDim.INSERT;
        //>> RTT 02-16-06

        IF ItemJnlLine."Shortcut Dimension 2 Code" <> '' THEN;
        //  TempJnlLineDim."Table ID" := DATABASE::"Item Journal Line";
        //  TempJnlLineDim."Journal Template Name" := ItemJnlLine."Journal Template Name";
        //  TempJnlLineDim."Journal Batch Name" := ItemJnlLine."Journal Batch Name";
        //  TempJnlLineDim."Journal Line No." := ItemJnlLine."Line No.";
        //  TempJnlLineDim."Dimension Code" := GLSetup."Global Dimension 2 Code";
        //  TempJnlLineDim."Dimension Value Code" := ItemJnlLine."Shortcut Dimension 2 Code";
        //  TempJnlLineDim."New Dimension Value Code" := ItemJnlLine."New Shortcut Dimension 2 Code";
        //  TempJnlLineDim.INSERT;
        //<< RTT 02-16-06
        //<< RTT 06-12-05
        ItemJnlLine."Location Code" := FromLocCode;
        ItemJnlLine."New Location Code" := ToLocCode;
        ItemJnlLine.Quantity := Qty;
        ItemJnlLine."Invoiced Quantity" := Qty;
        ItemJnlLine."Quantity (Base)" := Qty;
        ItemJnlLine."Invoiced Qty. (Base)" := Qty;
        //ItemJnlLine."Source Code" := SourceCode;
        Item.GET(ItemNo);
        ItemJnlLine."Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";
        ItemJnlLine."Inventory Posting Group" := Item."Inventory Posting Group";
        ItemJnlLine."Unit of Measure Code" := Item."Base Unit of Measure";
        ItemJnlLine."Qty. per Unit of Measure" := 1;
        ItemJnlLine."Bin Code" := FromBinCode;
        ItemJnlLine."New Bin Code" := ToBinCode;

        //BEGIN lot logic
        //insert lot no. if item tracking is required
        IF (ItemTrackingCode.GET(Item."Item Tracking Code")) AND (ItemTrackingCode."Lot Pos. Adjmt. Outb. Tracking") THEN BEGIN
            IF ReservEntry.FIND('+') THEN
                UseEntryNo := ReservEntry."Entry No." + 1
            ELSE
                UseEntryNo := 1;

            ReservEntry.INIT();
            ReservEntry."Entry No." := UseEntryNo;
            ReservEntry.Positive := (ItemJnlLine.Quantity > 0);
            ReservEntry."Item No." := ItemJnlLine."Item No.";
            ReservEntry."Location Code" := ItemJnlLine."Location Code";
            ReservEntry."Quantity (Base)" := -ItemJnlLine."Quantity (Base)";
            ReservEntry."Reservation Status" := ReservEntry."Reservation Status"::Prospect;
            ReservEntry."Creation Date" := ItemJnlLine."Posting Date";
            ReservEntry."Source Type" := 83;
            ReservEntry."Source Subtype" := 4;
            ReservEntry."Source ID" := ItemJnlLine."Journal Template Name";
            ReservEntry."Source Batch Name" := ItemJnlLine."Journal Batch Name";
            ReservEntry."Source Ref. No." := ItemJnlLine."Line No.";
            ReservEntry."Shipment Date" := ItemJnlLine."Posting Date";
            ReservEntry."Created By" := USERID;
            ReservEntry."Qty. per Unit of Measure" := ItemJnlLine."Qty. per Unit of Measure";
            ReservEntry.Quantity := ItemJnlLine.Quantity;
            ReservEntry."Planning Flexibility" := ReservEntry."Planning Flexibility"::Unlimited;
            ReservEntry."Qty. to Handle (Base)" := -ItemJnlLine."Quantity (Base)";
            ReservEntry."Qty. to Invoice (Base)" := -ItemJnlLine."Quantity (Base)";
            ReservEntry."New Lot No." := LotNo;
            ReservEntry."Lot No." := LotNo;
            ReservEntry.INSERT();
        END; //end tracking line insertion
             //end lot logic

        /*
        TempDocDim.RESET;
        TempDocDim.SETRANGE("Table ID",DATABASE::"Transfer Line");
        TempDocDim.SETRANGE("Line No.",TransLine3."Line No.");
        DimMgt.CopyDocDimToJnlLineDim(TempDocDim,TempJnlLineDim);
        IF TempJnlLineDim.FIND('-') THEN
          REPEAT
             TempJnlLineDim."New Dimension Value Code" := TempJnlLineDim."Dimension Value Code";
             TempJnlLineDim.MODIFY;
          UNTIL TempJnlLineDim.NEXT = 0;
        */

        FromWhseJnlLine.INIT();
        FromWhseJnlLine."Location Code" := ItemJnlLine."Location Code";
        FromWhseJnlLine."Item No." := ItemJnlLine."Item No.";
        FromWhseJnlLine."Registering Date" := ItemJnlLine."Posting Date";
        FromWhseJnlLine."Reference Document" := FromWhseJnlLine."Reference Document"::"Item Journal";
        FromWhseJnlLine."Reference No." := ItemJnlLine."Document No.";
        FromWhseJnlLine.Description := 'Bin Movement';
        FromWhseJnlLine."Posting Date" := ItemJnlLine."Posting Date";
        FromWhseJnlLine."User ID" := WhseEmp."User ID";
        FromWhseJnlLine."Entry Type" := FromWhseJnlLine."Entry Type"::Movement;
        //FromWhseJnlline."From Zone Code" := FromBin."Zone Code";
        //FromWhseJnlline."From Bin Code" := ItemJnlLine."Bin Code";
        FromWhseJnlLine."To Zone Code" := ToBin."Zone Code";
        FromWhseJnlLine."To Bin Code" := ItemJnlLine."Bin Code";
        FromWhseJnlLine."Unit of Measure Code" := ItemJnlLine."Unit of Measure Code";
        FromWhseJnlLine."Qty. per Unit of Measure" := ItemJnlLine."Qty. per Unit of Measure";
        FromWhseJnlLine.Quantity := -ItemJnlLine.Quantity;
        FromWhseJnlLine."Qty. (Base)" := -ItemJnlLine."Quantity (Base)";
        FromWhseJnlLine."Lot No." := LotNo;
        FromWhseJnlLine."Qty. (Absolute)" := -ItemJnlLine.Quantity;
        FromWhseJnlLine."Qty. (Absolute, Base)" := -ItemJnlLine."Quantity (Base)";

        ToWhseJnlLine.INIT();
        ToWhseJnlLine."Location Code" := ItemJnlLine."New Location Code";
        ToWhseJnlLine."Item No." := ItemJnlLine."Item No.";
        ToWhseJnlLine."Registering Date" := ItemJnlLine."Posting Date";
        ToWhseJnlLine."Reference Document" := ToWhseJnlLine."Reference Document"::"Item Journal";
        ToWhseJnlLine."Reference No." := ItemJnlLine."Document No.";
        ToWhseJnlLine.Description := 'Bin Movement';
        ToWhseJnlLine."Posting Date" := ItemJnlLine."Posting Date";
        ToWhseJnlLine."User ID" := WhseEmp."User ID";
        ToWhseJnlLine."Entry Type" := ToWhseJnlLine."Entry Type"::Movement;
        //tOWHSEJNLLINE."From Zone Code" := FromBin."Zone Code";
        //tOWHSEJNLLINE."From Bin Code" := ItemJnlLine."Bin Code";
        ToWhseJnlLine."To Zone Code" := ToBin."Zone Code";
        ToWhseJnlLine."To Bin Code" := ItemJnlLine."New Bin Code";
        ToWhseJnlLine."Unit of Measure Code" := ItemJnlLine."Unit of Measure Code";
        ToWhseJnlLine."Qty. per Unit of Measure" := ItemJnlLine."Qty. per Unit of Measure";
        ToWhseJnlLine.Quantity := ItemJnlLine.Quantity;
        ToWhseJnlLine."Qty. (Base)" := ItemJnlLine."Quantity (Base)";
        ToWhseJnlLine."Lot No." := LotNo;
        ToWhseJnlLine."Qty. (Absolute)" := ItemJnlLine.Quantity;
        ToWhseJnlLine."Qty. (Absolute, Base)" := ItemJnlLine."Quantity (Base)";


        ItemJnlPostLine.RunWithCheck(ItemJnlLine);
        WhseJnlRegisterLine.RUN(FromWhseJnlLine);
        WhseJnlRegisterLine.RUN(ToWhseJnlLine);


        /*
        IF NOT WhseJnlRegisterLine.RUN(WhseJnlLine) THEN BEGIN
           ErrorMsg := 'Whse Posting Failed.';
           EXIT(FALSE);
         END;
        */
        EXIT(TRUE);

    end;

    procedure CreateMovement(ItemNo: Code[20]; LotNo: Code[20]; ToBinCode: Code[20]; FromLocCode: Code[20]; FromBinCode: Code[20]; UserIDCode: Code[50]; Qty: Decimal; var ErrorMsg: Text[30]): Boolean
    var
        Location: Record 14;
        Item: Record 27;
        ItemTrackingCode: Record 6502;
        LotNoInfo: Record 6505;
        WhseEmp: Record 7301;
        BinContent: Record 7302;
        WhseJnlLine: Record 7311;
        BinContentBuffer: Record 7330 temporary;
        FromBin: Record 7354;
        ToBin: Record 7354;
        WhseJnlRegisterLine: Codeunit 7301;
        ItemType: Option "Item No.","Lot No.";
    begin
        //check to see if item was entered
        IF LotNo = '' THEN BEGIN
            //make sure is valid item
            IF NOT Item.GET(ItemNo) THEN BEGIN
                ErrorMsg := COPYSTR(STRSUBSTNO('Invalid Item: %1', ItemNo), 1, 30);
                EXIT(FALSE);
            END ELSE
                //if tracking code is blank, this must be an item that is not lot tracked
                IF Item."Item Tracking Code" = '' THEN
                    ItemType := ItemType::"Item No."
                //else if invalid item tracking code, return error
                ELSE IF NOT ItemTrackingCode.GET(Item."Item Tracking Code") THEN BEGIN
                    ErrorMsg := COPYSTR(STRSUBSTNO('Invalid Trkg. Code: %1', Item."No."), 1, 30);
                    EXIT(FALSE);
                END
                //otherwise, return error if item is lot tracked
                ELSE IF ItemTrackingCode."Lot Specific Tracking" THEN BEGIN
                    ErrorMsg := COPYSTR(STRSUBSTNO('Lot mandatory: Item %1.', Item."No."), 1, 30);
                    EXIT(FALSE);
                END;

            //if made it to this point, item is not lot tracked so set accordingly
            LotNo := '';
            ItemNo := Item."No.";
        END
        ELSE
          //begin if lot was entered
          BEGIN
            //valid lot
            LotNoInfo.SETRANGE("Item No.", ItemNo);
            LotNoInfo.SETRANGE("Lot No.", LotNo);
            //>> 09-21-05
            //LotNoInfo.SETRANGE(Blocked,FALSE);
            //<< 09-21-05

            IF NOT LotNoInfo.FIND('-') THEN BEGIN
                ErrorMsg := COPYSTR(STRSUBSTNO('Lot %1 not found', LotNo), 1, 30);
                EXIT(FALSE);
            END;

            //>> 09-21-05
            LotNoInfo.TESTFIELD(Blocked, FALSE);
            //<< 09-21-05
            ItemNo := LotNoInfo."Item No.";
            ItemType := ItemType::"Lot No.";
            LotNo := LotNoInfo."Lot No.";
        END;


        //get usersetup , then location
        WhseEmp.SETRANGE("User ID", UserIDCode);
        IF NOT WhseEmp.FIND('-') THEN BEGIN
            ErrorMsg := COPYSTR(STRSUBSTNO('No User Setup %1', UserIDCode), 1, 30);
            EXIT(FALSE);
        END;

        //see if user is allowed to use from location
        WhseEmp.SETRANGE("Location Code", FromLocCode);
        IF NOT WhseEmp.FIND('-') THEN BEGIN
            ErrorMsg := 'Location invalid';
            EXIT(FALSE);
        END;

        //make sure location is valid
        IF NOT Location.GET(FromLocCode) THEN BEGIN
            ErrorMsg := 'Loc not found';
            EXIT(FALSE);
        END;


        IF ItemType = ItemType::"Lot No." THEN BEGIN
            //check item
            IF NOT Item.GET(LotNoInfo."Item No.") THEN BEGIN
                ErrorMsg := COPYSTR(STRSUBSTNO('Invalid Item %1', LotNoInfo."Item No."), 1, 30);
                EXIT(FALSE);
            END;

            //find bin contents
            LotNoInfo.GetBinContentBuffer(BinContentBuffer);

            //if from bin is blank, use RDOCK (default receiving bin)
            IF FromBinCode = '' THEN BEGIN
                Location.GET(WhseEmp."Location Code");
                FromBinCode := Location."Receipt Bin Code";
            END;


            BinContentBuffer.SETRANGE("Location Code", FromLocCode);
            BinContentBuffer.SETRANGE("Bin Code", FromBinCode);

            IF NOT BinContentBuffer.FIND('-') THEN BEGIN
                ErrorMsg := COPYSTR(STRSUBSTNO('No Lot-Bin Qty: %1-%2', LotNo, BinContentBuffer.GETFILTER("Bin Code")), 1, 30);
                EXIT(FALSE);
            END;

            IF BinContentBuffer."Qty. to Handle (Base)" < Qty THEN BEGIN
                ErrorMsg := COPYSTR(STRSUBSTNO('Invalid Bin Qty %1 vs OH %2', Qty, BinContentBuffer."Qty. to Handle (Base)"), 1, 30);
                EXIT(FALSE);
            END;
        END ELSE BEGIN
            BinContent.SETRANGE("Item No.", ItemNo);
            BinContent.SETRANGE("Bin Code", FromBinCode);
            BinContent.SETRANGE("Qty. per Unit of Measure", 1);
            BinContent.SETFILTER(Quantity, '>=%1', Qty);
            IF NOT BinContent.FIND('-') THEN BEGIN
                ErrorMsg := COPYSTR(STRSUBSTNO('No Item-Bin Qty: %1-%2', ItemNo, FromBinCode), 1, 30);
                EXIT(FALSE);
            END;
        END;

        //if shortcut, then use shipping bin
        IF ToBinCode = '0' THEN BEGIN
            Location.GET(FromLocCode);
            ToBinCode := Location."Shipment Bin Code";
        END;

        //valid to to bin
        IF NOT ToBin.GET(FromLocCode, ToBinCode) THEN BEGIN
            ErrorMsg := COPYSTR(STRSUBSTNO('Bin %1 invalid', ToBinCode), 1, 30);
            EXIT(FALSE);
        END;

        //valid from bin
        IF NOT FromBin.GET(FromLocCode, FromBinCode) THEN BEGIN
            ErrorMsg := COPYSTR(STRSUBSTNO('Bin %1 invalid', FromBinCode), 1, 30);
            EXIT(FALSE);
        END;

        //if item at this point is invalid, then error
        IF NOT Item.GET(ItemNo) THEN BEGIN
            ErrorMsg := COPYSTR(STRSUBSTNO('Item is %1 invalid', ItemNo), 1, 30);
            EXIT(FALSE);
        END;

        Item.SETRANGE("Location Filter", FromLocCode);
        Item.CALCFIELDS(Inventory);
        IF Item.Inventory < Qty THEN BEGIN
            ErrorMsg := COPYSTR(STRSUBSTNO('Invalid Qty %1 vs OH %2', Qty, Item.Inventory), 1, 30);
            EXIT(FALSE);
        END;


        //post transaction
        WhseJnlLine.INIT();
        WhseJnlLine."Location Code" := FromLocCode;
        WhseJnlLine."Item No." := ItemNo;
        WhseJnlLine."Registering Date" := TODAY;
        WhseJnlLine.Description := 'Bin Movement';
        // WhseJnlLine."Posting Date" := TODAY;//TODO
        WhseJnlLine."User ID" := WhseEmp."User ID";
        WhseJnlLine."Entry Type" := WhseJnlLine."Entry Type"::Movement;
        WhseJnlLine."From Zone Code" := FromBin."Zone Code";
        WhseJnlLine."From Bin Code" := FromBinCode;
        WhseJnlLine."To Zone Code" := ToBin."Zone Code";
        WhseJnlLine."To Bin Code" := ToBinCode;
        WhseJnlLine."Unit of Measure Code" := Item."Base Unit of Measure";
        WhseJnlLine."Qty. per Unit of Measure" := 1;
        WhseJnlLine.Quantity := Qty;
        WhseJnlLine."Qty. (Base)" := Qty;
        WhseJnlLine."Lot No." := LotNo;
        WhseJnlLine."Qty. (Absolute)" := Qty;
        WhseJnlLine."Qty. (Absolute, Base)" := Qty;

        IF NOT WhseJnlRegisterLine.RUN(WhseJnlLine) THEN BEGIN
            ErrorMsg := 'Posting Failed.';
            EXIT(FALSE);
        END;

        EXIT(TRUE);
    end;

    procedure CreateSKU(ItemNo: Code[20]; LocationCode: Code[10]; VariantCode: Code[10]): Boolean
    var
        Location: Record 14;
        Item2: Record 27;
        StockkeepingUnit: Record 5700;
    begin
        IF Location.GET(LocationCode) AND Location."Use As In-Transit" THEN
            EXIT(FALSE);
        Item2.GET(ItemNo);
        IF NOT StockkeepingUnit.GET(LocationCode, Item2."No.", VariantCode) THEN BEGIN
            StockkeepingUnit.INIT();
            StockkeepingUnit."Item No." := Item2."No.";
            StockkeepingUnit."Location Code" := LocationCode;
            StockkeepingUnit."Variant Code" := VariantCode;
            StockkeepingUnit."Shelf No." := Item2."Shelf No.";
            StockkeepingUnit."Standard Cost" := Item2."Standard Cost";
            StockkeepingUnit."Last Direct Cost" := Item2."Last Direct Cost";
            StockkeepingUnit."Unit Cost" := Item2."Unit Cost";
            StockkeepingUnit."Vendor No." := Item2."Vendor No.";
            StockkeepingUnit."Vendor Item No." := Item2."Vendor Item No.";
            StockkeepingUnit."Lead Time Calculation" := Item2."Lead Time Calculation";
            StockkeepingUnit."Reorder Point" := Item2."Reorder Point";
            StockkeepingUnit."Maximum Inventory" := Item2."Maximum Inventory";
            StockkeepingUnit."Reorder Quantity" := Item2."Reorder Quantity";
            StockkeepingUnit."Lot Size" := Item2."Lot Size";
            StockkeepingUnit."Reordering Policy" := Item2."Reordering Policy";
            StockkeepingUnit."Discrete Order Quantity" := Item2."Discrete Order Quantity";
            StockkeepingUnit."Minimum Order Quantity" := Item2."Minimum Order Quantity";
            StockkeepingUnit."Maximum Order Quantity" := Item2."Maximum Order Quantity";
            StockkeepingUnit."Safety Stock Quantity" := Item2."Safety Stock Quantity";
            StockkeepingUnit."Order Multiple" := Item2."Order Multiple";
            StockkeepingUnit."Safety Lead Time" := Item2."Safety Lead Time";
            StockkeepingUnit."Flushing Method" := Item2."Flushing Method";
            StockkeepingUnit."Replenishment System" := Item2."Replenishment System";
            StockkeepingUnit."Time Bucket" := Item2."Time Bucket";
            StockkeepingUnit."Last Date Modified" := WORKDATE();
            StockkeepingUnit."Special Equipment Code" := Item2."Special Equipment Code";
            StockkeepingUnit."Put-away Template Code" := Item2."Put-away Template Code";
            StockkeepingUnit."Phys Invt Counting Period Code" :=
              Item2."Phys Invt Counting Period Code";
            StockkeepingUnit."Put-away Unit of Measure Code" :=
              Item2."Put-away Unit of Measure Code";
            StockkeepingUnit."Use Cross-Docking" := Item2."Use Cross-Docking";
            EXIT(StockkeepingUnit.INSERT());
        END;
    end;

    local procedure ">>NF1.00_CIS_NG"()
    begin
    end;

    procedure FillDimSetEntry_gFnc(OldDimSetID_lInt: Integer; var DimSetEntry_vRec: Record 480 temporary)
    begin
        //>>NF1.00:CIS.NG  10-12-15
        CLEAR(DimMgt_gCdu);
        DimSetEntry_vRec.RESET;
        DimMgt_gCdu.GetDimensionSet(DimSetEntry_vRec, OldDimSetID_lInt);
        //<<NF1.00:CIS.NG  10-12-15
    end;

    procedure UpdateDimSetEntry_gFnc(var DimSetEntry_vRec: Record 480 temporary; DimensionCode_iCod: Code[20]; DimensionValue_iCod: Code[20]): Boolean
    begin
        //>>NF1.00:CIS.NG  10-12-15
        IF DimensionValue_iCod <> '' THEN BEGIN
            DimSetEntry_vRec.RESET();
            DimSetEntry_vRec.SETRANGE("Dimension Code", DimensionCode_iCod);
            IF NOT DimSetEntry_vRec.FINDFIRST() THEN BEGIN
                DimSetEntry_vRec.INIT();
                DimSetEntry_vRec.VALIDATE("Dimension Code", DimensionCode_iCod);
                DimSetEntry_vRec.VALIDATE("Dimension Value Code", DimensionValue_iCod);
                DimSetEntry_vRec.INSERT(TRUE);
                EXIT(TRUE);
            END ELSE
                IF DimSetEntry_vRec."Dimension Value Code" <> DimensionValue_iCod THEN BEGIN
                    ;
                    DimSetEntry_vRec.VALIDATE("Dimension Value Code", DimensionValue_iCod);
                    DimSetEntry_vRec.MODIFY(TRUE);
                    EXIT(TRUE);
                END;
        END;
        //<<NF1.00:CIS.NG  10-12-15
    end;

    procedure GetDimensionSetID_gFnc(var DimSetEntry_vRecTmp: Record 480 temporary) DimSetID: Integer
    begin
        //>>NF1.00:CIS.NG  10-12-15
        DimSetID := DimMgt_gCdu.GetDimensionSetID(DimSetEntry_vRecTmp);
        //<<NF1.00:CIS.NG  10-12-15
    end;

    procedure UpdGlobalDimFromSetID_gFnc(DimSetID: Integer; var GlobalDimVal1: Code[20]; var GlobalDimVal2: Code[20])
    begin
        //>>NF1.00:CIS.NG  10-12-15
        DimMgt_gCdu.UpdateGlobalDimFromDimSetID(DimSetID, GlobalDimVal1, GlobalDimVal2);
        //<<NF1.00:CIS.NG  10-12-15
    end;

    local procedure "---NIF1.01---"()
    begin
    end;

    procedure SetAppliesToEntryNo(AppliesToEntryNoPar: Integer)
    begin
        AppliesToEntryNoGbl := AppliesToEntryNoPar;
    end;
}

