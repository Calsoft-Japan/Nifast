codeunit 50175 CU_432
{
    [EventSubscriber(ObjectType::Codeunit, 432, 'OnBeforeInsertGLEntry', '', True, false)]
    local procedure OnBeforeInsertGLEntry(var SubsidGLEntry: Record "G/L Entry"; GLEntry: Record "G/L Entry"): Integer
    var
        TempSubsidGLEntry1: Record 17 TEMPORARY;
        Customer: Record 18;
        TempCustomer: Record 18 TEMPORARY;
        TempVendor: Record 18 TEMPORARY;
        Vendor: Record 23;
        lCLE: Record 25;
        lVLE: Record 25;
        CustomerPostingGroup: Record 92;
        TempCustomerPostingGroup: Record 92 TEMPORARY;
        TempVendorPostingGroup: Record 93 TEMPORARY;
        VendorPostingGroup: Record 93;
        GLSetup: Record 98;
        BusUnit: Record 220;
        ParentBankAcct: Record 270;
        BankAcctLedgerEntry: Record 271;
        DetailedCustLedgEntry: Record 379;
        DetailedVendLedgEntry: Record 380;
        TempSubsidGLEntry: Record "G/L Entry" temporary;

        Found: Boolean;
        DebAmtLCY: Decimal;
        CrAmtFCY: Decimal;
        CrAmtLCY: Decimal;
        DebAmtFCY: Decimal;
        ProRateAmt: Decimal;
        TotAmt: Decimal;
        NextEntryNo: Integer;
    begin
        //>>CIS.RAM
        BusUnit.GET('NICA');
        PurchaseSetup.GET();
        PurchaseSetup.TESTFIELD("FC Gain Account");
        PurchaseSetup.TESTFIELD("FC Loss Account");
        PurchaseSetup.TESTFIELD("FC Gain Bal. Account");
        PurchaseSetup.TESTFIELD("FC Loss Bal. Account");
        PurchaseSetup.TESTFIELD("AP Trade Account");
        ParentCompanyOriginalEntry.RESET();
        ParentCompanyOriginalEntry.CHANGECOMPANY(BusUnit."Company Name");
        ParentCompanyOriginalEntry.GET(SubsidGLEntry."Entry No.");
        ParentCompanyOriginalEntry.CALCFIELDS(ParentCompanyOriginalEntry."Currency Code of Vendor", ParentCompanyOriginalEntry."Currency Code of Customer");

        GLSetup.RESET();
        GLSetup.GET();

        //IF SubsidGLEntry."Entry No." IN [17577663] THEN BEGIN //17575309] THEN BEGIN //17567901] THEN BEGIN //15526632] //16338074] //16338074] //16338076] //15892268] THEN BEGIN //15591393,15591401] THEN BEGIN //15429849] THEN BEGIN //15554203]
        //IF SubsidGLEntry."Document No." = 'PSIV284227' THEN BEGIN
        //    IF NOT CONFIRM('Do you want to debug?') THEN
        //      ERROR('Break');
        //END;
        //END;

        IF ParentCompanyOriginalEntry."G/L Account No." IN ['937', '938', '946', '947'] THEN
            IF (ParentCompanyOriginalEntry."Currency Code of Vendor" = GLSetup."LCY Code") OR
               (ParentCompanyOriginalEntry."Currency Code of Customer" = GLSetup."LCY Code")
            THEN BEGIN
                //040618
                //EXIT(0);
                IF ParentCompanyOriginalEntry."Currency Code of Vendor" = GLSetup."LCY Code" THEN BEGIN
                    //AP
                    Vendor.RESET();
                    Vendor.CHANGECOMPANY(BusUnit."Company Name");
                    Vendor.GET(ParentCompanyOriginalEntry."Source No.");
                    VendorPostingGroup.RESET();
                    VendorPostingGroup.CHANGECOMPANY(BusUnit."Company Name");
                    VendorPostingGroup.GET(Vendor."Vendor Posting Group");
                    IF TempSubsidGLEntry.FINDLAST() THEN
                        NextEntryNo := TempSubsidGLEntry."Entry No." + 1
                    ELSE
                        NextEntryNo := 1;
                    TempSubsidGLEntry.INIT();
                    TempSubsidGLEntry."Entry No." := NextEntryNo;
                    TempSubsidGLEntry."G/L Account No." := VendorPostingGroup."Payables Account";
                    TempSubsidGLEntry."Document No." := SubsidGLEntry."Document No.";
                    TempSubsidGLEntry."Document Type" := SubsidGLEntry."Document Type";
                    TempSubsidGLEntry."Posting Date" := SubsidGLEntry."Posting Date";
                    TempSubsidGLEntry."Debit Amount" := SubsidGLEntry."Debit Amount";
                    TempSubsidGLEntry."Credit Amount" := SubsidGLEntry."Credit Amount";
                    TempSubsidGLEntry."Add.-Currency Debit Amount" := SubsidGLEntry."Add.-Currency Debit Amount";
                    TempSubsidGLEntry."Add.-Currency Credit Amount" := SubsidGLEntry."Add.-Currency Credit Amount";
                    //>>CIS.RAM 04/29/18
                    TempSubsidGLEntry."Original Entry No." := SubsidGLEntry."Entry No.";
                    TempSubsidGLEntry."Original Transaction No." := SubsidGLEntry."Transaction No.";
                    //<<CIS.RAM 04/29/18

                    IF (TempSubsidGLEntry."Debit Amount" <> 0) OR (TempSubsidGLEntry."Credit Amount" <> 0) THEN
                        TempSubsidGLEntry.INSERT();
                    EXIT(NextEntryNo);
                END ELSE BEGIN
                    //AR
                    Customer.RESET();
                    Customer.CHANGECOMPANY(BusUnit."Company Name");
                    Customer.GET(ParentCompanyOriginalEntry."Source No.");
                    CustomerPostingGroup.RESET();
                    CustomerPostingGroup.CHANGECOMPANY(BusUnit."Company Name");
                    CustomerPostingGroup.GET(Customer."Customer Posting Group");
                    IF TempSubsidGLEntry.FINDLAST() THEN
                        NextEntryNo := TempSubsidGLEntry."Entry No." + 1
                    ELSE
                        NextEntryNo := 1;
                    TempSubsidGLEntry.INIT();
                    TempSubsidGLEntry."Entry No." := NextEntryNo;
                    TempSubsidGLEntry."G/L Account No." := CustomerPostingGroup."Receivables Account";
                    TempSubsidGLEntry."Document No." := SubsidGLEntry."Document No.";
                    TempSubsidGLEntry."Document Type" := SubsidGLEntry."Document Type";
                    TempSubsidGLEntry."Posting Date" := SubsidGLEntry."Posting Date";
                    TempSubsidGLEntry."Debit Amount" := SubsidGLEntry."Debit Amount";
                    TempSubsidGLEntry."Credit Amount" := SubsidGLEntry."Credit Amount";
                    TempSubsidGLEntry."Add.-Currency Debit Amount" := SubsidGLEntry."Add.-Currency Debit Amount";
                    TempSubsidGLEntry."Add.-Currency Credit Amount" := SubsidGLEntry."Add.-Currency Credit Amount";
                    IF (TempSubsidGLEntry."Debit Amount" <> 0) OR (TempSubsidGLEntry."Credit Amount" <> 0) THEN
                        //IF TempSubsidGLEntry."Document No." = 'PSIV284227' THEN BEGIN
                        //  IF NOT CONFIRM('Do you want to debug?') THEN
                        //    ERROR('Break');
                        //END;
                        //>>CIS.RAM 04/29/18
                        TempSubsidGLEntry."Original Entry No." := SubsidGLEntry."Entry No.";
                    TempSubsidGLEntry."Original Transaction No." := SubsidGLEntry."Transaction No.";
                    //<<CIS.RAM 04/29/18

                    TempSubsidGLEntry.INSERT();
                    EXIT(NextEntryNo);
                END;
            END;

        IF ParentCompanyOriginalEntry."Source Code" <> 'SALESAPPL' THEN //04/30/2018
            IF (ParentCompanyOriginalEntry."Document Type" = ParentCompanyOriginalEntry."Document Type"::Payment) AND
               (ParentCompanyOriginalEntry."Source Type" IN [ParentCompanyOriginalEntry."Source Type"::Vendor, ParentCompanyOriginalEntry."Source Type"::Customer]) AND
               (ParentCompanyOriginalEntry."Source No." <> '') AND
               (ParentCompanyOriginalEntry."G/L Account No." IN ['129', '310', '311'])
            THEN BEGIN
                TempSubsidGLEntry1.RESET();
                TempSubsidGLEntry1.DELETEALL();
                IF ParentCompanyOriginalEntry."G/L Account No." = PurchaseSetup."AP Trade Account" THEN BEGIN
                    IF (ParentCompanyOriginalEntry."Currency Code of Vendor" IN ['CAD', '']) THEN
                        CreateSubsidGLEntry(ParentCompanyOriginalEntry, TempSubsidGLEntry1)
                END ELSE BEGIN
                    //>>042818
                    TempSubsidGLEntry1.RESET();
                    TempSubsidGLEntry1.DELETEALL();
                    //<<042818

                    GlobalTempCustLedgEntry.RESET();
                    //GlobalTempCustLedgEntry.DELETEALL;
                    IF (ParentCompanyOriginalEntry."Currency Code of Customer" IN ['CAD', '']) THEN
                        CreateSubsidGLEntry1(ParentCompanyOriginalEntry, TempSubsidGLEntry1);
                END;

                IF TempSubsidGLEntry1.FINDSET() THEN BEGIN
                    REPEAT
                        DebAmtLCY := 0;
                        CrAmtLCY := 0;
                        DebAmtFCY := 0;
                        CrAmtFCY := 0;
                        //MESSAGE('2: %1\%2\%3\%4',TempSubsidGLEntry1.COUNT,TempSubsidGLEntry1."Entry No.",TempSubsidGLEntry1."Source No.",TempSubsidGLEntry1."Document No.");
                        //ERROR('3: %1',(TempSubsidGLEntry1."Additional-Currency Amount" + SubsidGLEntry."Additional-Currency Amount") * SubsidGLEntry.Amount/
                        //   SubsidGLEntry."Additional-Currency Amount");
                        //FInd Credit/Debit Amount
                        ProRateAmt := 0;
                        ProRateAmt := SubsidGLEntry."Additional-Currency Amount" * ABS(TempSubsidGLEntry1.Amount) / ABS(SubsidGLEntry.Amount);
                        //IF ABS(SubsidGLEntry."Additional-Currency Amount") <> ABS(TempSubsidGLEntry1."Additional-Currency Amount") THEN BEGIN
                        IF ABS(ProRateAmt) <> ABS(TempSubsidGLEntry1."Additional-Currency Amount") THEN BEGIN
                            //Gain/Loss Entry
                            IF TempSubsidGLEntry.FINDLAST() THEN
                                NextEntryNo := TempSubsidGLEntry."Entry No." + 1
                            ELSE
                                NextEntryNo := 1;
                            TempSubsidGLEntry.INIT();
                            TempSubsidGLEntry."Entry No." := NextEntryNo;
                            TempSubsidGLEntry."Document No." := TempSubsidGLEntry1."Document No.";
                            TempSubsidGLEntry."Posting Date" := SubsidGLEntry."Posting Date";
                            //IF ABS(SubsidGLEntry."Additional-Currency Amount") > ABS(TempSubsidGLEntry1."Additional-Currency Amount") THEN BEGIN
                            IF ABS(ProRateAmt) > ABS(TempSubsidGLEntry1."Additional-Currency Amount") THEN BEGIN
                                TempSubsidGLEntry."G/L Account No." := PurchaseSetup."FC Gain Account";
                                //DebAmtFCY := ABS(TempSubsidGLEntry1."Additional-Currency Amount") - ABS(SubsidGLEntry."Additional-Currency Amount");
                                DebAmtFCY := ABS(TempSubsidGLEntry1."Additional-Currency Amount") - ABS(ProRateAmt);
                                TempSubsidGLEntry."Add.-Currency Debit Amount" := DebAmtFCY;
                                DebAmtLCY := (TempSubsidGLEntry."Add.-Currency Debit Amount" * SubsidGLEntry.Amount / SubsidGLEntry."Additional-Currency Amount"); //This is fine
                                TempSubsidGLEntry."Debit Amount" := DebAmtLCY;
                            END ELSE BEGIN
                                TempSubsidGLEntry."G/L Account No." := PurchaseSetup."FC Loss Account";
                                //CrAmtFCY := ABS(SubsidGLEntry."Additional-Currency Amount") - ABS(TempSubsidGLEntry1."Additional-Currency Amount");
                                CrAmtFCY := ABS(ProRateAmt) - ABS(TempSubsidGLEntry1."Additional-Currency Amount");
                                TempSubsidGLEntry."Add.-Currency Credit Amount" := CrAmtFCY;
                                CrAmtLCY := (TempSubsidGLEntry."Add.-Currency Credit Amount" * SubsidGLEntry.Amount / SubsidGLEntry."Additional-Currency Amount"); //This is fine
                                TempSubsidGLEntry."Credit Amount" := CrAmtLCY;
                            END;

                            //IF TempSubsidGLEntry."Document No." = 'PSIV284227' THEN BEGIN
                            //  IF NOT CONFIRM('Do you want to debug?') THEN
                            //    ERROR('Break');
                            //END;
                            //>>CIS.RAM 04/29/18
                            TempSubsidGLEntry."Original Entry No." := TempSubsidGLEntry1."Entry No.";
                            TempSubsidGLEntry."Original Transaction No." := TempSubsidGLEntry1."Transaction No.";

                            //<<CIS.RAM 04/29/18

                            IF (TempSubsidGLEntry."Debit Amount" <> 0) OR (TempSubsidGLEntry."Credit Amount" <> 0) THEN
                                TempSubsidGLEntry.INSERT();

                            //Gain/Loss Balancing Entry
                            IF TempSubsidGLEntry.FINDLAST() THEN
                                NextEntryNo := TempSubsidGLEntry."Entry No." + 1
                            ELSE
                                NextEntryNo := 1;
                            TempSubsidGLEntry.INIT();
                            TempSubsidGLEntry."Entry No." := NextEntryNo;
                            TempSubsidGLEntry."Document No." := TempSubsidGLEntry1."Document No.";
                            TempSubsidGLEntry."Posting Date" := SubsidGLEntry."Posting Date";
                            //IF ABS(SubsidGLEntry."Additional-Currency Amount") > ABS(TempSubsidGLEntry1."Additional-Currency Amount") THEN BEGIN
                            IF ABS(ProRateAmt) > ABS(TempSubsidGLEntry1."Additional-Currency Amount") THEN BEGIN
                                IF ParentCompanyOriginalEntry."G/L Account No." <> PurchaseSetup."AP Trade Account" THEN
                                    TempSubsidGLEntry."G/L Account No." := '129'
                                ELSE
                                    TempSubsidGLEntry."G/L Account No." := PurchaseSetup."FC Gain Bal. Account";
                                TempSubsidGLEntry."Debit Amount" := -DebAmtLCY;
                                TempSubsidGLEntry."Add.-Currency Debit Amount" := DebAmtFCY;
                            END ELSE BEGIN
                                IF ParentCompanyOriginalEntry."G/L Account No." <> PurchaseSetup."AP Trade Account" THEN
                                    TempSubsidGLEntry."G/L Account No." := '129'
                                ELSE
                                    TempSubsidGLEntry."G/L Account No." := PurchaseSetup."FC Loss Bal. Account";
                                TempSubsidGLEntry."Credit Amount" := -CrAmtLCY;
                                TempSubsidGLEntry."Add.-Currency Credit Amount" := CrAmtFCY;
                            END;

                            //IF TempSubsidGLEntry."Document No." = 'PSIV284227' THEN BEGIN
                            //  IF NOT CONFIRM('Do you want to debug?') THEN
                            //    ERROR('Break');
                            //END;
                            //>>CIS.RAM 04/29/18
                            TempSubsidGLEntry."Original Entry No." := TempSubsidGLEntry1."Entry No.";
                            TempSubsidGLEntry."Original Transaction No." := TempSubsidGLEntry1."Transaction No.";

                            //<<CIS.RAM 04/29/18

                            IF (TempSubsidGLEntry."Debit Amount" <> 0) OR (TempSubsidGLEntry."Credit Amount" <> 0) THEN
                                TempSubsidGLEntry.INSERT();
                            //ERROR('%1\%2\%3\%4',TempSubsidGLEntry."G/L Account No.",TempSubsidGLEntry."Posting Date",TempSubsidGLEntry."Document No.",TempSubsidGLEntry.Amount);
                            //EXIT(NextEntryNo);
                        END;
                    UNTIL TempSubsidGLEntry1.NEXT() = 0;
                END ELSE BEGIN
                    ParentCompanyOriginalEntry.RESET();
                    ParentCompanyOriginalEntry.CHANGECOMPANY(BusUnit."Company Name");
                    ParentCompanyOriginalEntry.GET(SubsidGLEntry."Entry No.");
                    ParentCompanyOriginalEntry.CALCFIELDS(ParentCompanyOriginalEntry."Currency Code of Vendor", ParentCompanyOriginalEntry."Currency Code of Customer");
                    IF ((ParentCompanyOriginalEntry."G/L Account No." = PurchaseSetup."AP Trade Account") AND
                       (ParentCompanyOriginalEntry."Currency Code of Vendor" IN ['CAD', '']))
                    THEN BEGIN
                        lVLE.RESET();
                        lVLE.CHANGECOMPANY(BusUnit."Company Name");
                        lVLE.SETRANGE("Closed by Entry No.", ParentCompanyOriginalEntry."Entry No.");
                        IF NOT lVLE.FINDFIRST() THEN BEGIN
                            //ERROR('Vend')
                            //Do Nothing
                        END ELSE IF STRPOS(lVLE.Description, 'Void') = 0 THEN BEGIN
                            //IF NOT CONFIRM('Cannot find Cust/Vend Invoice for GL Entry: %1\Vend: %2\%3',TRUE,SubsidGLEntry."Entry No.",ParentCompanyOriginalEntry."Currency Code of Vendor",
                            //   ParentCompanyOriginalEntry."Entry No.")
                            //THEN
                            //  ERROR('User terminated the Vend process')
                            //Do Nothing
                        END;
                    END ELSE IF ((ParentCompanyOriginalEntry."G/L Account No." = '129') AND
                       (ParentCompanyOriginalEntry."Currency Code of Customer" IN ['CAD', '']))
                    THEN BEGIN
                        //lCLE.RESET;
                        //lCLE.CHANGECOMPANY(BusUnit."Company Name");
                        //lCLE.SETRANGE("Closed by Entry No.",ParentCompanyOriginalEntry."Entry No.");
                        //IF NOT lCLE.FINDFIRST THEN
                        //  ERROR('Cust')
                        //ELSE IF STRPOS(lCLE.Description,'Void') = 0 THEN
                        //IF NOT CONFIRM('Cannot find Cust/Vend Invoice for GL Entry: %1\Cust: %2\%3',TRUE,SubsidGLEntry."Entry No.",ParentCompanyOriginalEntry."Currency Code of Customer",
                        //   ParentCompanyOriginalEntry."Entry No.")
                        //THEN
                        //  ERROR('User terminated the Cust process');
                    END;
                END;
            END;

        //FOREX RESTATE Entries
        GLSetup.RESET();
        GLSetup.GET();

        IF TempSubsidGLEntry.FINDLAST() THEN
            NextEntryNo := TempSubsidGLEntry."Entry No." + 1
        ELSE
            NextEntryNo := 1;

        ParentCompanyOriginalEntry.RESET();
        ParentCompanyOriginalEntry.CHANGECOMPANY(BusUnit."Company Name");
        ParentCompanyOriginalEntry.GET(SubsidGLEntry."Entry No.");

        //IF STRPOS(ParentCompanyOriginalEntry.Description,'FOREX RESTATE') > 0 THEN BEGIN
        IF ParentCompanyOriginalEntry."Source Code" = 'EXCHRATADJ' THEN BEGIN
            //Bank Ledger Entry
            IF (ParentCompanyOriginalEntry."Source Type" = ParentCompanyOriginalEntry."Source Type"::"Bank Account") AND
               (ParentCompanyOriginalEntry."Source No." <> '')
            THEN BEGIN
                ParentBankAcct.RESET();
                ParentBankAcct.CHANGECOMPANY(BusUnit."Company Name");
                ParentBankAcct.GET(ParentCompanyOriginalEntry."Source No.");
                IF ParentBankAcct."Currency Code" = GLSetup."LCY Code" THEN
                    EXIT(NextEntryNo)
                ELSE BEGIN
                    //TempSubsidGLEntry.INIT;
                    //TempSubsidGLEntry."Entry No." := NextEntryNo;
                    //TempSubsidGLEntry."G/L Account No." := '937';
                    //TempSubsidGLEntry."Document No." := ParentCompanyOriginalEntry."Document No.";
                    //TempSubsidGLEntry."Document Type" := ParentCompanyOriginalEntry."Document Type";
                    //TempSubsidGLEntry."Posting Date" := ParentCompanyOriginalEntry."Posting Date";
                    //TempSubsidGLEntry."Credit Amount" := ParentCompanyOriginalEntry."Debit Amount";
                    //TempSubsidGLEntry."Debit Amount" := ParentCompanyOriginalEntry."Credit Amount";
                    //TempSubsidGLEntry."Add.-Currency Credit Amount" := ParentCompanyOriginalEntry."Add.-Currency Debit Amount";
                    //TempSubsidGLEntry."Add.-Currency Debit Amount" := ParentCompanyOriginalEntry."Add.-Currency Credit Amount";
                    //TempSubsidGLEntry.INSERT;
                END;
            END ELSE BEGIN
                //EXIT(NextEntryNo);
                //Customer/Vendor Ledger Entry
                Found := FALSE;
                CASE TRUE OF
                    ParentCompanyOriginalEntry."G/L Account No." IN ['937', '946']:
                        BEGIN
                            //for bank account loss entries
                            Found := FALSE;
                            BankAcctLedgerEntry.RESET();
                            BankAcctLedgerEntry.CHANGECOMPANY(BusUnit."Company Name");
                            BankAcctLedgerEntry.SETRANGE("Posting Date", ParentCompanyOriginalEntry."Posting Date");
                            BankAcctLedgerEntry.SETRANGE("Document No.", ParentCompanyOriginalEntry."Document No.");
                            BankAcctLedgerEntry.SETFILTER("Currency Code", '<>%1', GLSetup."LCY Code");
                            IF BankAcctLedgerEntry.FINDSET() THEN BEGIN
                                REPEAT
                                    IF ABS(BankAcctLedgerEntry."Amount (LCY)") = ABS(ParentCompanyOriginalEntry.Amount) THEN
                                        Found := TRUE;
                                UNTIL (BankAcctLedgerEntry.NEXT() = 0) OR (Found);
                                IF NOT Found THEN
                                    EXIT(0);
                                //ERROR('Bank ledger was not found, for amount %1',ParentCompanyOriginalEntry.Amount);
                            END ELSE
                                EXIT(0)
                        END;
                    ParentCompanyOriginalEntry."G/L Account No." IN ['938']:
                        BEGIN
                            DetailedCustLedgEntry.RESET();
                            DetailedCustLedgEntry.CHANGECOMPANY(BusUnit."Company Name");
                            DetailedCustLedgEntry.SETRANGE("Posting Date", ParentCompanyOriginalEntry."Posting Date");
                            DetailedCustLedgEntry.SETRANGE("Document No.", ParentCompanyOriginalEntry."Document No.");
                            DetailedCustLedgEntry.SETRANGE("Entry Type", DetailedCustLedgEntry."Entry Type"::"Unrealized Loss");
                            DetailedCustLedgEntry.SETFILTER("Currency Code", 'JPY');
                            TotAmt := 0;
                            IF DetailedCustLedgEntry.FINDSET() THEN BEGIN
                                REPEAT
                                    TotAmt += DetailedCustLedgEntry."Amount (LCY)";
                                UNTIL DetailedCustLedgEntry.NEXT() = 0;
                                //ERROR('1: %1\%2',ParentCompanyOriginalEntry.Amount,TotAmt);
                                IF ABS(ParentCompanyOriginalEntry.Amount) <> ABS(TotAmt) THEN BEGIN
                                    DetailedCustLedgEntry.RESET();
                                    DetailedCustLedgEntry.CHANGECOMPANY(BusUnit."Company Name");
                                    DetailedCustLedgEntry.SETRANGE("Posting Date", ParentCompanyOriginalEntry."Posting Date");
                                    DetailedCustLedgEntry.SETRANGE("Document No.", ParentCompanyOriginalEntry."Document No.");
                                    DetailedCustLedgEntry.SETRANGE("Entry Type", DetailedCustLedgEntry."Entry Type"::"Unrealized Loss");
                                    DetailedCustLedgEntry.SETFILTER("Currency Code", 'EU');
                                    TotAmt := 0;
                                    IF DetailedCustLedgEntry.FINDSET() THEN BEGIN
                                        REPEAT
                                            TotAmt += DetailedCustLedgEntry."Amount (LCY)";
                                        UNTIL DetailedCustLedgEntry.NEXT() = 0;
                                        IF ABS(ParentCompanyOriginalEntry.Amount) <> ABS(TotAmt) THEN BEGIN
                                            //Do Nothing
                                        END ELSE
                                            Found := TRUE;
                                    END;
                                END ELSE
                                    Found := TRUE;
                            END ELSE BEGIN
                                DetailedCustLedgEntry.RESET();
                                DetailedCustLedgEntry.CHANGECOMPANY(BusUnit."Company Name");
                                DetailedCustLedgEntry.SETRANGE("Posting Date", ParentCompanyOriginalEntry."Posting Date");
                                DetailedCustLedgEntry.SETRANGE("Document No.", ParentCompanyOriginalEntry."Document No.");
                                DetailedCustLedgEntry.SETRANGE("Entry Type", DetailedCustLedgEntry."Entry Type"::"Unrealized Loss");
                                DetailedCustLedgEntry.SETFILTER("Currency Code", 'EU');
                                TotAmt := 0;
                                IF DetailedCustLedgEntry.FINDSET() THEN BEGIN
                                    REPEAT
                                        TotAmt += DetailedCustLedgEntry."Amount (LCY)";
                                    UNTIL DetailedCustLedgEntry.NEXT() = 0;
                                    IF ABS(ParentCompanyOriginalEntry.Amount) <> ABS(TotAmt) THEN BEGIN
                                        //Do Nothing
                                    END ELSE
                                        Found := TRUE;
                                END;
                            END;
                            //If the loop did not terminate neither it errored then it must be a Vendor Ledger Entry
                            IF NOT Found THEN BEGIN
                                DetailedVendLedgEntry.RESET();
                                DetailedVendLedgEntry.CHANGECOMPANY(BusUnit."Company Name");
                                DetailedVendLedgEntry.SETRANGE("Posting Date", ParentCompanyOriginalEntry."Posting Date");
                                DetailedVendLedgEntry.SETRANGE("Document No.", ParentCompanyOriginalEntry."Document No.");
                                DetailedVendLedgEntry.SETRANGE("Entry Type", DetailedVendLedgEntry."Entry Type"::"Unrealized Loss");
                                DetailedVendLedgEntry.SETFILTER("Currency Code", 'JPY');
                                TotAmt := 0;
                                IF DetailedVendLedgEntry.FINDSET() THEN BEGIN
                                    REPEAT
                                        TotAmt += DetailedVendLedgEntry."Amount (LCY)";
                                    UNTIL DetailedVendLedgEntry.NEXT() = 0;
                                    IF ABS(ParentCompanyOriginalEntry.Amount) <> ABS(TotAmt) THEN BEGIN
                                        DetailedVendLedgEntry.RESET();
                                        DetailedVendLedgEntry.CHANGECOMPANY(BusUnit."Company Name");
                                        DetailedVendLedgEntry.SETRANGE("Posting Date", ParentCompanyOriginalEntry."Posting Date");
                                        DetailedVendLedgEntry.SETRANGE("Document No.", ParentCompanyOriginalEntry."Document No.");
                                        DetailedVendLedgEntry.SETRANGE("Entry Type", DetailedVendLedgEntry."Entry Type"::"Unrealized Loss");
                                        DetailedVendLedgEntry.SETFILTER("Currency Code", 'EU');
                                        TotAmt := 0;
                                        IF DetailedVendLedgEntry.FINDSET() THEN BEGIN
                                            REPEAT
                                                TotAmt += DetailedVendLedgEntry."Amount (LCY)";
                                            UNTIL DetailedVendLedgEntry.NEXT() = 0;
                                            IF ABS(ParentCompanyOriginalEntry.Amount) <> ABS(TotAmt) THEN BEGIN
                                                EXIT(NextEntryNo);
                                            END;
                                            //VK.begin 15-Jun-18
                                            //END
                                        END ELSE BEGIN
                                            EXIT(NextEntryNo);
                                        END;
                                        //VK.end 15-Jun-18
                                    END;
                                END ELSE BEGIN
                                    DetailedVendLedgEntry.RESET();
                                    DetailedVendLedgEntry.CHANGECOMPANY(BusUnit."Company Name");
                                    DetailedVendLedgEntry.SETRANGE("Posting Date", ParentCompanyOriginalEntry."Posting Date");
                                    DetailedVendLedgEntry.SETRANGE("Document No.", ParentCompanyOriginalEntry."Document No.");
                                    DetailedVendLedgEntry.SETRANGE("Entry Type", DetailedVendLedgEntry."Entry Type"::"Unrealized Loss");
                                    DetailedVendLedgEntry.SETFILTER("Currency Code", 'EU');
                                    TotAmt := 0;
                                    IF DetailedVendLedgEntry.FINDSET() THEN BEGIN
                                        REPEAT
                                            TotAmt += DetailedVendLedgEntry."Amount (LCY)";
                                        UNTIL DetailedVendLedgEntry.NEXT() = 0;
                                        IF ABS(ParentCompanyOriginalEntry.Amount) <> ABS(TotAmt) THEN BEGIN
                                            EXIT(NextEntryNo);
                                        END;
                                    END ELSE
                                        EXIT(NextEntryNo);
                                END;
                            END;
                        END;
                    ParentCompanyOriginalEntry."G/L Account No." IN ['947']:
                        BEGIN
                            Found := FALSE;
                            DetailedCustLedgEntry.RESET();
                            DetailedCustLedgEntry.CHANGECOMPANY(BusUnit."Company Name");
                            DetailedCustLedgEntry.SETRANGE("Posting Date", ParentCompanyOriginalEntry."Posting Date");
                            DetailedCustLedgEntry.SETRANGE("Document No.", ParentCompanyOriginalEntry."Document No.");
                            DetailedCustLedgEntry.SETRANGE("Entry Type", DetailedCustLedgEntry."Entry Type"::"Unrealized Gain");
                            DetailedCustLedgEntry.SETFILTER("Currency Code", 'JPY');
                            TotAmt := 0;
                            IF DetailedCustLedgEntry.FINDSET() THEN BEGIN
                                REPEAT
                                    TotAmt += DetailedCustLedgEntry."Amount (LCY)";
                                UNTIL DetailedCustLedgEntry.NEXT() = 0;
                                IF ABS(ParentCompanyOriginalEntry.Amount) <> ABS(TotAmt) THEN BEGIN
                                    DetailedCustLedgEntry.RESET();
                                    DetailedCustLedgEntry.CHANGECOMPANY(BusUnit."Company Name");
                                    DetailedCustLedgEntry.SETRANGE("Posting Date", ParentCompanyOriginalEntry."Posting Date");
                                    DetailedCustLedgEntry.SETRANGE("Document No.", ParentCompanyOriginalEntry."Document No.");
                                    DetailedCustLedgEntry.SETRANGE("Entry Type", DetailedCustLedgEntry."Entry Type"::"Unrealized Gain");
                                    DetailedCustLedgEntry.SETFILTER("Currency Code", 'EU');
                                    TotAmt := 0;
                                    IF DetailedCustLedgEntry.FINDSET() THEN BEGIN
                                        REPEAT
                                            TotAmt += DetailedCustLedgEntry."Amount (LCY)";
                                        UNTIL DetailedCustLedgEntry.NEXT() = 0;
                                        IF ABS(ParentCompanyOriginalEntry.Amount) <> ABS(TotAmt) THEN BEGIN
                                            //Do nothing
                                        END ELSE
                                            Found := TRUE;
                                    END;
                                END ELSE
                                    Found := TRUE;
                            END ELSE BEGIN
                                DetailedCustLedgEntry.RESET();
                                DetailedCustLedgEntry.CHANGECOMPANY(BusUnit."Company Name");
                                DetailedCustLedgEntry.SETRANGE("Posting Date", ParentCompanyOriginalEntry."Posting Date");
                                DetailedCustLedgEntry.SETRANGE("Document No.", ParentCompanyOriginalEntry."Document No.");
                                DetailedCustLedgEntry.SETRANGE("Entry Type", DetailedCustLedgEntry."Entry Type"::"Unrealized Gain");
                                DetailedCustLedgEntry.SETFILTER("Currency Code", 'EU');
                                TotAmt := 0;
                                IF DetailedCustLedgEntry.FINDSET() THEN BEGIN
                                    REPEAT
                                        TotAmt += DetailedCustLedgEntry."Amount (LCY)";
                                    UNTIL DetailedCustLedgEntry.NEXT() = 0;
                                    IF ABS(ParentCompanyOriginalEntry.Amount) <> ABS(TotAmt) THEN BEGIN
                                        //Do nothing
                                    END ELSE
                                        Found := TRUE;
                                END;
                            END;
                            //If the loop did not terminate neither it errored then it must be a Vendor Ledger Entry
                            IF NOT Found THEN BEGIN
                                DetailedVendLedgEntry.RESET();
                                DetailedVendLedgEntry.CHANGECOMPANY(BusUnit."Company Name");
                                DetailedVendLedgEntry.SETRANGE("Posting Date", ParentCompanyOriginalEntry."Posting Date");
                                DetailedVendLedgEntry.SETRANGE("Document No.", ParentCompanyOriginalEntry."Document No.");
                                DetailedVendLedgEntry.SETRANGE("Entry Type", DetailedVendLedgEntry."Entry Type"::"Unrealized Gain");
                                DetailedVendLedgEntry.SETFILTER("Currency Code", 'JPY');
                                TotAmt := 0;
                                IF DetailedVendLedgEntry.FINDSET() THEN BEGIN
                                    REPEAT
                                        TotAmt += DetailedVendLedgEntry."Amount (LCY)";
                                    UNTIL DetailedVendLedgEntry.NEXT() = 0;
                                    IF ABS(ParentCompanyOriginalEntry.Amount) <> ABS(TotAmt) THEN BEGIN
                                        DetailedVendLedgEntry.RESET();
                                        DetailedVendLedgEntry.CHANGECOMPANY(BusUnit."Company Name");
                                        DetailedVendLedgEntry.SETRANGE("Posting Date", ParentCompanyOriginalEntry."Posting Date");
                                        DetailedVendLedgEntry.SETRANGE("Document No.", ParentCompanyOriginalEntry."Document No.");
                                        DetailedVendLedgEntry.SETRANGE("Entry Type", DetailedVendLedgEntry."Entry Type"::"Unrealized Gain");
                                        DetailedVendLedgEntry.SETFILTER("Currency Code", 'EU');
                                        TotAmt := 0;
                                        IF DetailedVendLedgEntry.FINDSET() THEN BEGIN
                                            REPEAT
                                                TotAmt += DetailedVendLedgEntry."Amount (LCY)";
                                            UNTIL DetailedVendLedgEntry.NEXT() = 0;
                                            IF ABS(ParentCompanyOriginalEntry.Amount) <> ABS(TotAmt) THEN BEGIN
                                                EXIT(NextEntryNo);
                                            END;
                                            //VK.begin 15-Jun-18
                                            //END;
                                        END ELSE BEGIN
                                            EXIT(NextEntryNo);
                                        END;
                                        //VK.end 15-Jun-18
                                    END;
                                END ELSE BEGIN
                                    DetailedVendLedgEntry.RESET();
                                    DetailedVendLedgEntry.CHANGECOMPANY(BusUnit."Company Name");
                                    DetailedVendLedgEntry.SETRANGE("Posting Date", ParentCompanyOriginalEntry."Posting Date");
                                    DetailedVendLedgEntry.SETRANGE("Document No.", ParentCompanyOriginalEntry."Document No.");
                                    DetailedVendLedgEntry.SETRANGE("Entry Type", DetailedVendLedgEntry."Entry Type"::"Unrealized Gain");
                                    DetailedVendLedgEntry.SETFILTER("Currency Code", 'EU');
                                    TotAmt := 0;
                                    IF DetailedVendLedgEntry.FINDSET() THEN BEGIN
                                        REPEAT
                                            TotAmt += DetailedVendLedgEntry."Amount (LCY)";
                                        UNTIL DetailedVendLedgEntry.NEXT() = 0;
                                        IF ABS(ParentCompanyOriginalEntry.Amount) <> ABS(TotAmt) THEN BEGIN
                                            EXIT(NextEntryNo);
                                        END;
                                    END ELSE
                                        EXIT(NextEntryNo);
                                END;
                            END;
                        END;
                    ParentCompanyOriginalEntry."G/L Account No." IN ['129']:
                        BEGIN
                            EXIT(NextEntryNo);
                            //Found := FALSE;
                            //TempCustomer.RESET;
                            //TempCustomer.DELETEALL;
                            //TempCustomerPostingGroup.RESET;
                            //TempCustomerPostingGroup.DELETEALL;
                            //DetailedCustLedgEntry.RESET;
                            //DetailedCustLedgEntry.CHANGECOMPANY(BusUnit."Company Name");
                            //DetailedCustLedgEntry.SETRANGE("Posting Date",ParentCompanyOriginalEntry."Posting Date");
                            //DetailedCustLedgEntry.SETRANGE("Document No.",ParentCompanyOriginalEntry."Document No");
                            //IF DetailedCustLedgEntry.FINDSET THEN
                            //  REPEAT
                            //    IF NOT TempCustomer.GET(DetailedCustLedgEntry."Customer No.") THEN BEGIN
                            //      Customer.RESET;
                            //      Customer.CHANGECOMPANY(BusUnit."Company Name");
                            //      Customer.GET(DetailedCustLedgEntry."Customer No.");
                            //      TempCustomer := Customer;
                            //      TempCustomer.INSERT;
                            //      TempCustomerPostingGroup.RESET;
                            //      IF NOT TempCustomerPostingGroup.GET(Customer."Customer Posting Group") THEN BEGIN
                            //        TempCustomerPostingGroup.RESET;
                            //        TempCustomerPostingGroup.Code := Customer."Customer Posting Group";
                            //        TempCustomerPostingGroup.INSERT;
                            //      END;
                            //    END;
                            //  UNTIL DetailedCustLedgEntry.NEXT = 0;
                            //TempCustomerPostingGroup.RESET;
                            //IF TempCustomerPostingGroup.FINDSET THEN BEGIN
                            //  REPEAT
                            //    TempCustomer.RESET;
                            //    TempCustomer.SETRANGE("Customer Posting Group",TempCustomerPostingGroup.Code);
                            //    IF TempCustomer.FINDFIRST THEN BEGIN
                            //      REPEAT
                            //        DetailedCustLedgEntry.RESET;
                            //        DetailedCustLedgEntry.CHANGECOMPANY(BusUnit."Company Name");
                            //        DetailedCustLedgEntry.SETRANGE("Posting Date",ParentCompanyOriginalEntry."Posting Date");
                            //        DetailedCustLedgEntry.SETRANGE("Document No.",ParentCompanyOriginalEntry."Document No.");
                            //        DetailedCustLedgEntry.SETRANGE("Customer No.",TempCustomer."No.");
                            //        TotAmt := 0;
                            //        IF DetailedCustLedgEntry.FINDSET THEN BEGIN
                            //          REPEAT
                            //            TotAmt += DetailedCustLedgEntry."Amount (LCY)";
                            //          UNTIL DetailedCustLedgEntry.NEXT = 0;
                            //        END;
                            //      UNTIL TempCustomer.NEXT = 0;
                            //
                            //      IF ABS(ParentCompanyOriginalEntry.Amount) = ABS(TotAmt) THEN BEGIN
                            //        Found := TRUE;
                            //        IF DetailedCustLedgEntry."Currency Code" = GLSetup."LCY Code" THEN
                            //          EXIT(NextEntryNo);
                            //      END;
                            //    END;
                            //  UNTIL TempCustomerPostingGroup.NEXT = 0;
                            //  IF NOT Found THEN
                            //    ERROR('Could not find customer ledger for GLEntry %1\Amount: %2',ParentCompanyOriginalEntry."Entry No.",ParentCompanyOriginalEntry.Amount);
                            //END;
                        END;
                    ParentCompanyOriginalEntry."G/L Account No." IN ['310', '311']:
                        BEGIN
                            EXIT(NextEntryNo);
                        END;
                    ParentCompanyOriginalEntry."G/L Account No." IN ['91', '93']:
                        BEGIN
                            //for bank account Balancing entries
                            Found := FALSE;
                            BankAcctLedgerEntry.RESET();
                            BankAcctLedgerEntry.CHANGECOMPANY(BusUnit."Company Name");
                            BankAcctLedgerEntry.SETRANGE("Posting Date", ParentCompanyOriginalEntry."Posting Date");
                            BankAcctLedgerEntry.SETRANGE("Document No.", ParentCompanyOriginalEntry."Document No.");
                            BankAcctLedgerEntry.SETFILTER("Currency Code", '<>%1', GLSetup."LCY Code");
                            IF BankAcctLedgerEntry.FINDSET() THEN BEGIN
                                REPEAT
                                    IF ABS(BankAcctLedgerEntry."Amount (LCY)") = ABS(ParentCompanyOriginalEntry.Amount) THEN
                                        Found := TRUE;
                                UNTIL (BankAcctLedgerEntry.NEXT() = 0) OR (Found);
                                IF NOT Found THEN
                                    EXIT(0);
                                //ERROR('Bank ledger was not found, for amount %1',ParentCompanyOriginalEntry.Amount);
                            END ELSE
                                EXIT(0)
                        END
                    ELSE
                        EXIT(NextEntryNo);
                END;
            END;
        END;
    END;

    LOCAL PROCEDURE CreateSubsidGLEntry1(FromEntry: Record 17; VAR ToEntry: Record 17);
    VAR
        // ParentCompanyOriginalEntry: Record 17;
        CreateCustLedgEntry: Record 21;
        CustLedgEntry: Record 21;
        lCLE: Record 21;
        LocalTempCustLedgEntry: Record 21 temporary;
        GLSetup: Record 98;
        BankAccount: Record 270;
        Done: Boolean;
        BankCurrCode: Code[20];
        TAmt: Decimal;
    BEGIN
        //>>CIS.RAM
        TAmt := 0;
        GlobalTempCustLedgEntry.DELETEALL();
        LocalTempCustLedgEntry.RESET();
        LocalTempCustLedgEntry.DELETEALL();
        ParentCompanyOriginalEntry.RESET();
        BusUnit.GET('NICA');
        ParentCompanyOriginalEntry.CHANGECOMPANY(BusUnit."Company Name");
        ParentCompanyOriginalEntry.GET(FromEntry."Entry No.");
        CustLedgEntry.RESET();
        CustLedgEntry.CHANGECOMPANY(BusUnit."Company Name");
        CustLedgEntry.SETCURRENTKEY("Document No.");
        CustLedgEntry.SETRANGE("Document No.", ParentCompanyOriginalEntry."Document No.");
        CustLedgEntry.SETRANGE("Document Type", CustLedgEntry."Document Type"::Payment);
        CustLedgEntry.SETRANGE("Posting Date", ParentCompanyOriginalEntry."Posting Date");
        //>>RAM 042918
        GLSetup.GET();
        BankCurrCode := '';
        IF (ParentCompanyOriginalEntry."Bal. Account Type" = ParentCompanyOriginalEntry."Bal. Account Type"::"Bank Account") AND
           (ParentCompanyOriginalEntry."Bal. Account No." <> '')
        THEN
            IF BankAccount.GET(ParentCompanyOriginalEntry."Bal. Account No.") THEN
                BankCurrCode := BankAccount."Currency Code";

        IF BankCurrCode <> '' THEN
            IF BankCurrCode = GLSetup."LCY Code" THEN
                EXIT;
        //<<RAM 042918

        CustLedgEntry.SETRANGE(Amount, ParentCompanyOriginalEntry.Amount); //Added today on 032318
        IF NOT CustLedgEntry.FINDFIRST() THEN BEGIN
            CustLedgEntry.RESET();
            CustLedgEntry.CHANGECOMPANY(BusUnit."Company Name");
            CustLedgEntry.SETCURRENTKEY("Document No.");
            CustLedgEntry.SETRANGE("Document No.", ParentCompanyOriginalEntry."Document No.");
            CustLedgEntry.SETRANGE("Document Type", CustLedgEntry."Document Type"::Payment);
            CustLedgEntry.SETRANGE("Posting Date", ParentCompanyOriginalEntry."Posting Date");
        END;

        IF CustLedgEntry.FINDFIRST() THEN
            REPEAT
                CreateCustLedgEntry.RESET();
                CreateCustLedgEntry.CHANGECOMPANY(BusUnit."Company Name");

                IF CustLedgEntry."Entry No." <> 0 THEN BEGIN
                    CreateCustLedgEntry := CustLedgEntry;

                    FindApplnEntriesDtldtCustLedgEntry(CreateCustLedgEntry);
                    CreateCustLedgEntry.SETCURRENTKEY("Entry No.");
                    CreateCustLedgEntry.SETRANGE("Entry No.");

                    IF CreateCustLedgEntry."Closed by Entry No." <> 0 THEN BEGIN
                        CreateCustLedgEntry."Entry No." := CreateCustLedgEntry."Closed by Entry No.";
                        CreateCustLedgEntry.MARK(TRUE);
                        lCLE.RESET();
                        lCLE.CHANGECOMPANY(BusUnit."Company Name");
                        lCLE.GET(CreateCustLedgEntry."Entry No.");
                        LocalTempCustLedgEntry.RESET();
                        LocalTempCustLedgEntry := lCLE; //CreateCustLedgEntry;
                        IF LocalTempCustLedgEntry.INSERT() THEN;
                    END;
                    //>>040118
                    lCLE.RESET();
                    lCLE.CHANGECOMPANY(BusUnit."Company Name");
                    IF (CreateCustLedgEntry."Document Type" = CreateCustLedgEntry."Document Type"::Invoice) THEN
                        IF lCLE.GET(CreateCustLedgEntry."Entry No.") THEN BEGIN
                            //IF (ABS(lCLE.Amount) = ABS(ParentCompanyOriginalEntry.Amount)) THEN BEGIN
                            LocalTempCustLedgEntry.RESET();
                            //lCLE.RESET;
                            //lCLE.CHANGECOMPANY(BusUnit."Company Name");
                            //lCLE.GET(CreateCustLedgEntry."Entry No.");
                            LocalTempCustLedgEntry := lCLE; //CreateCustLedgEntry;
                            IF LocalTempCustLedgEntry.INSERT() THEN;
                        END;
                    //<<040118
                    CreateCustLedgEntry.SETCURRENTKEY("Closed by Entry No.");
                    CreateCustLedgEntry.SETRANGE("Closed by Entry No.", CreateCustLedgEntry."Entry No.");
                    IF CreateCustLedgEntry.FIND('-') THEN
                        REPEAT
                            CreateCustLedgEntry.MARK(TRUE);
                            LocalTempCustLedgEntry.RESET();
                            lCLE.RESET();
                            lCLE.CHANGECOMPANY(BusUnit."Company Name");
                            lCLE.GET(CreateCustLedgEntry."Entry No.");
                            LocalTempCustLedgEntry := lCLE; //CreateCustLedgEntry;
                            IF LocalTempCustLedgEntry.INSERT() THEN;
                        UNTIL CreateCustLedgEntry.NEXT() = 0;
                    CreateCustLedgEntry.SETCURRENTKEY("Entry No.");
                    CreateCustLedgEntry.SETRANGE("Closed by Entry No.");
                END;

                CreateCustLedgEntry.MARKEDONLY(TRUE);
            UNTIL CustLedgEntry.NEXT() = 0;

        LocalTempCustLedgEntry.SETCURRENTKEY("Entry No.");
        LocalTempCustLedgEntry.SETRANGE("Closed by Entry No.");
        IF LocalTempCustLedgEntry.FINDFIRST() THEN BEGIN
            //IF CreateCustLedgEntry.FINDFIRST THEN BEGIN
            Done := FALSE;
            ParentCompanyOriginalEntry.RESET();
            ParentCompanyOriginalEntry.CHANGECOMPANY(BusUnit."Company Name");
            ToEntry.RESET();
            ToEntry.CHANGECOMPANY(BusUnit."Company Name");
            REPEAT
                //Find GL Entries and update ToEntry and return
                IF LocalTempCustLedgEntry."Document Type" IN [LocalTempCustLedgEntry."Document Type"::Invoice, LocalTempCustLedgEntry."Document Type"::"Credit Memo"] THEN BEGIN
                    //>>Added today on 032418
                    GlobalTempCustLedgEntry.RESET();
                    IF (NOT Done) AND
                       (NOT GlobalTempCustLedgEntry.GET(LocalTempCustLedgEntry."Entry No."))
                    THEN BEGIN
                        //IF NOT GlobalTempCustLedgEntry.GET(CreateCustLedgEntry."Entry No.") THEN BEGIN
                        //  CreateCustLedgEntry.NEXT;

                        //  GlobalTempCustLedgEntry.RESET;
                        //  IF GlobalTempCustLedgEntry.GET(CreateCustLedgEntry."Entry No.") THEN
                        //    CreateCustLedgEntry.NEXT;

                        //  GlobalTempCustLedgEntry.RESET;
                        //  GlobalTempCustLedgEntry := CreateCustLedgEntry;
                        //  GlobalTempCustLedgEntry.INSERT;
                        //END ELSE BEGIN
                        GlobalTempCustLedgEntry.RESET();
                        //GlobalTempCustLedgEntry := CreateCustLedgEntry;
                        GlobalTempCustLedgEntry := LocalTempCustLedgEntry;
                        GlobalTempCustLedgEntry.INSERT();
                        //<<Added today on 032418

                        //MESSAGE('1: %1\%2\%3',CreateCustLedgEntry.COUNT,CreateCustLedgEntry."Entry No.",CreateCustLedgEntry."Vendor No.",CreateVendLedgEntry."Document No.");
                        ParentCompanyOriginalEntry.SETRANGE("Document No.", LocalTempCustLedgEntry."Document No."); //CreateCustLedgEntry."Document No.");
                        IF LocalTempCustLedgEntry."Document Type" = LocalTempCustLedgEntry."Document Type"::Invoice THEN
                            ParentCompanyOriginalEntry.SETRANGE("Document Type", ParentCompanyOriginalEntry."Document Type"::Invoice)
                        ELSE IF LocalTempCustLedgEntry."Document Type" = LocalTempCustLedgEntry."Document Type"::"Credit Memo" THEN
                            ParentCompanyOriginalEntry.SETRANGE("Document Type", ParentCompanyOriginalEntry."Document Type"::"Credit Memo");
                        ParentCompanyOriginalEntry.SETRANGE("Posting Date", LocalTempCustLedgEntry."Posting Date"); //CreateCustLedgEntry."Posting Date");
                        ParentCompanyOriginalEntry.SETRANGE("G/L Account No.", '129');
                        ParentCompanyOriginalEntry.FINDSET();
                        ToEntry := ParentCompanyOriginalEntry;
                        ToEntry.INSERT();
                        TAmt += ABS(LocalTempCustLedgEntry."Closed by Amount (LCY)");
                        IF TAmt = ABS(FromEntry.Amount) THEN
                            Done := TRUE;
                        // {
                        // ToEntry.SETRANGE("Document No.", CreateVendLedgEntry."Document No.");
                        //           ToEntry.SETRANGE("Document Type", ToEntry."Document Type"::Invoice);
                        //           ToEntry.SETRANGE("Posting Date", CreateVendLedgEntry."Posting Date");
                        //           ToEntry.SETRANGE("G/L Account No.", PurchaseSetup."AP Trade Account");
                        //           ToEntry.FINDSET;
                        //           IF ToEntry.FINDSET THEN;
                        // }
                    END; //Added today on 032418
                END;
            //UNTIL CreateCustLedgEntry.NEXT = 0;
            UNTIL LocalTempCustLedgEntry.NEXT() = 0;
        END;// ELSE
            //ERROR('Cannot find custledgentry for G/L Entry # %1',ParentCompanyOriginalEntry."Entry No.");
            //<<CIS.RAM
    END;

    LOCAL PROCEDURE FindApplnEntriesDtldtCustLedgEntry(VAR CreateVendLedgEntry: Record 21);
    VAR
        DtldVendLedgEntry1: Record 379;
        DtldVendLedgEntry2: Record 379;
    BEGIN
        //>>CIS.RAM
        DtldVendLedgEntry1.SETCURRENTKEY("Cust. Ledger Entry No.");
        DtldVendLedgEntry1.CHANGECOMPANY(BusUnit."Company Name");
        DtldVendLedgEntry1.SETRANGE("Cust. Ledger Entry No.", CreateVendLedgEntry."Entry No.");
        DtldVendLedgEntry1.SETRANGE(Unapplied, FALSE);
        IF DtldVendLedgEntry1.FINDFIRST() THEN
            REPEAT
                IF DtldVendLedgEntry1."Cust. Ledger Entry No." =
                   DtldVendLedgEntry1."Applied Cust. Ledger Entry No."
                THEN BEGIN
                    DtldVendLedgEntry2.INIT();
                    DtldVendLedgEntry2.CHANGECOMPANY(BusUnit."Company Name");
                    DtldVendLedgEntry2.SETCURRENTKEY("Applied Cust. Ledger Entry No.", "Entry Type");
                    DtldVendLedgEntry2.SETRANGE(
                      "Applied Cust. Ledger Entry No.", DtldVendLedgEntry1."Applied Cust. Ledger Entry No.");
                    DtldVendLedgEntry2.SETRANGE("Entry Type", DtldVendLedgEntry2."Entry Type"::Application);
                    DtldVendLedgEntry2.SETRANGE(Unapplied, FALSE);
                    IF DtldVendLedgEntry2.FIND('-') THEN
                        REPEAT
                            IF DtldVendLedgEntry2."Cust. Ledger Entry No." <>
                               DtldVendLedgEntry2."Applied Cust. Ledger Entry No."
                            THEN BEGIN
                                CreateVendLedgEntry.SETCURRENTKEY("Entry No.");
                                CreateVendLedgEntry.SETRANGE("Entry No.", DtldVendLedgEntry2."Cust. Ledger Entry No.");
                                IF CreateVendLedgEntry.FIND('-') THEN
                                    CreateVendLedgEntry.MARK(TRUE);
                            END;
                        UNTIL DtldVendLedgEntry2.NEXT() = 0;
                END ELSE BEGIN
                    CreateVendLedgEntry.SETCURRENTKEY("Entry No.");
                    CreateVendLedgEntry.SETRANGE("Entry No.", DtldVendLedgEntry1."Applied Cust. Ledger Entry No.");
                    IF CreateVendLedgEntry.FINDFIRST() THEN
                        CreateVendLedgEntry.MARK(TRUE);
                END;
            UNTIL DtldVendLedgEntry1.NEXT() = 0;
        //<<CIS.RAM
    END;

    LOCAL PROCEDURE GetReceiptDate(GLEntry: Record 17): Date;
    VAR
        CreateVendLedgEntry: Record 25;
        VendLedgEntry: Record 25;
        ILE: Record 32;
        ValueEntry: Record 5802;
    BEGIN
        BusUnit.GET('NICA');
        //>>CIS.RAM
        ParentCompanyOriginalEntry.RESET();
        BusUnit.TESTFIELD("Company Name");
        ParentCompanyOriginalEntry.CHANGECOMPANY(BusUnit."Company Name");
        ParentCompanyOriginalEntry.GET(GLEntry."Entry No.");  //15388120
        TempItemEntry.DELETEALL();

        //IF GLEntry."Entry No." IN [17781138] THEN BEGIN //17672143 16016772 16016776] THEN BEGIN //15892268] THEN BEGIN //15377918] //15400920] 15429849] //15628956] //15605322] //15593992] //15527127,15527128] THEN BEGIN //15457609,15457610] THEN BEGIN
        //  IF NOT CONFIRM('Do you want to debug?') THEN
        //    ERROR('Break');
        //END;

        //Trap for Sales Freight lines 180 and 730
        ValueEntry.RESET();
        ValueEntry.CHANGECOMPANY(BusUnit."Company Name");
        ValueEntry.SETCURRENTKEY("Document No.");
        ValueEntry.SETRANGE("Document No.", ParentCompanyOriginalEntry."Document No.");
        ValueEntry.SETRANGE("Posting Date", ParentCompanyOriginalEntry."Posting Date");
        ValueEntry.SETRANGE(Adjustment, TRUE);
        ValueEntry.SETFILTER("Cost Posted to G/L", '%1|%2', ParentCompanyOriginalEntry.Amount, -ParentCompanyOriginalEntry.Amount);
        IF ValueEntry.FINDFIRST() THEN BEGIN
            ValueEntry.RESET();
            ValueEntry.CHANGECOMPANY(BusUnit."Company Name");
            ValueEntry.SETCURRENTKEY("Document No.");
            ValueEntry.SETRANGE("Document No.", ParentCompanyOriginalEntry."Document No.");
            ValueEntry.SETRANGE("Posting Date", ParentCompanyOriginalEntry."Posting Date");
            ValueEntry.SETFILTER("Cost Posted to G/L", '%1|%2', ParentCompanyOriginalEntry.Amount, -ParentCompanyOriginalEntry.Amount); //This added on 3/29 as for 730 it will be reverse sign
                                                                                                                                        //ValueEntry.SETRANGE("Cost Posted to G/L",ParentCompanyOriginalEntry.Amount);
            ValueEntry.SETRANGE(Adjustment, TRUE);
            IF ValueEntry.FINDFIRST() THEN BEGIN  //4966396
                IF ValueEntry."Item Ledger Entry Type" IN [ValueEntry."Item Ledger Entry Type"::"Positive Adjmt.",
                   ValueEntry."Item Ledger Entry Type"::"Negative Adjmt.",
                   ValueEntry."Item Ledger Entry Type"::"Assembly Output"] //This FG item never existed before
                THEN
                    EXIT(ValueEntry."Posting Date");
                IF ValueEntry."Document Type" = ValueEntry."Document Type"::"Sales Credit Memo" THEN
                    EXIT(ValueEntry."Posting Date");
                TempItemEntry.DELETEALL();
                ILE.RESET();
                ILE.CHANGECOMPANY(BusUnit."Company Name");
                ILE.GET(ValueEntry."Item Ledger Entry No."); //1235010
                IF ILE."Entry Type" = ILE."Entry Type"::Purchase THEN
                    EXIT(ILE."Posting Date");
                FindAppliedEntry(ILE);
                TempItemEntry1.DELETEALL();
                IF TempItemEntry.FINDSET() THEN  //1220542
                    REPEAT
                        RecCount := TempItemEntry.COUNT;
                        IF (TempItemEntry."Document Type" IN [TempItemEntry."Document Type"::"Purchase Receipt",
                           TempItemEntry."Document Type"::"Purchase Return Shipment",
                           TempItemEntry."Document Type"::"Sales Return Receipt",
                           TempItemEntry."Document Type"::"Sales Credit Memo"]) OR
                           (TempItemEntry."Entry Type" IN [TempItemEntry."Entry Type"::"Positive Adjmt.",
                            TempItemEntry."Entry Type"::"Negative Adjmt.",
                            TempItemEntry."Entry Type"::"Assembly Output",
                            TempItemEntry."Entry Type"::Purchase])
                        THEN BEGIN
                            IF TempItemEntry."Entry Type" IN [TempItemEntry."Entry Type"::"Positive Adjmt.",
                               TempItemEntry."Entry Type"::"Negative Adjmt.",
                               TempItemEntry."Entry Type"::"Assembly Output",
                               TempItemEntry."Entry Type"::Purchase]
                            THEN
                                EXIT(TempItemEntry."Posting Date")
                            ELSE BEGIN
                                InvoiceDate := 0D;
                                IF GetFrtInvoiceDate(TempItemEntry) THEN
                                    EXIT(InvoiceDate)
                                ELSE
                                    EXIT(TempItemEntry."Posting Date");
                            END;
                        END ELSE BEGIN

                            //>>CIS.RAM 03032022
                            IF TempItemEntry."Posting Date" < 010109D THEN
                                EXIT(TempItemEntry."Posting Date");
                            //>>CIS.RAM 03032022

                            ILE.RESET();
                            ILE.CHANGECOMPANY(BusUnit."Company Name");
                            ILE.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Expiration Date", "Lot No.", "Serial No.");
                            ILE.SETRANGE("Item No.", TempItemEntry."Item No.");
                            ILE.SETRANGE("Document No.", TempItemEntry."Document No.");
                            ILE.SETRANGE("Posting Date", TempItemEntry."Posting Date");
                            IF (TempItemEntry."Entry Type" = TempItemEntry."Entry Type"::Sale)
                            //(TempItemEntry."Entry Type" = TempItemEntry."Entry Type"::"Assembly Consumption")) //AND
                            //(TempItemEntry."Document Type" <> TempItemEntry."Document Type"::"Sales Return Receipt")
                            THEN
                                ILE.SETFILTER(Positive, '%1', FALSE);

                            //IF TempItemEntry."Document Type" <> TempItemEntry."Document Type"::"Sales Return Receipt" THEN
                            //  ILE.SETFILTER("Entry No.",'<>%1',TempItemEntry."Entry No.");  //033018

                            ILE.FINDSET();
                            TempItemEntry2.DELETEALL();
                            FindAppliedEntry1(ILE);
                            IF TempItemEntry1.FINDSET() THEN
                                REPEAT
                                    RecCount := TempItemEntry1.COUNT;
                                    IF (TempItemEntry1."Document Type" IN [TempItemEntry1."Document Type"::"Purchase Receipt",
                                        TempItemEntry1."Document Type"::"Purchase Return Shipment",
                                        TempItemEntry1."Document Type"::"Sales Return Receipt",
                                        TempItemEntry1."Document Type"::"Sales Credit Memo"]) OR
                                       (TempItemEntry1."Entry Type" = TempItemEntry1."Entry Type"::"Positive Adjmt.")
                                    THEN BEGIN
                                        IF TempItemEntry1."Entry Type" IN [TempItemEntry1."Entry Type"::"Positive Adjmt.",
                                           TempItemEntry1."Entry Type"::"Negative Adjmt.",
                                           TempItemEntry1."Entry Type"::"Assembly Output"]
                                        THEN
                                            EXIT(TempItemEntry1."Posting Date")
                                        ELSE BEGIN
                                            InvoiceDate := 0D;
                                            IF GetFrtInvoiceDate(TempItemEntry1) THEN
                                                EXIT(InvoiceDate)
                                            ELSE
                                                EXIT(TempItemEntry1."Posting Date");
                                        END;
                                    END ELSE BEGIN

                                        //>>CIS.RAM 03032022
                                        IF TempItemEntry1."Posting Date" < 010109D THEN
                                            EXIT(TempItemEntry1."Posting Date");
                                        //>>CIS.RAM 03032022


                                        ILE.RESET();
                                        ILE.CHANGECOMPANY(BusUnit."Company Name");
                                        ILE.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Expiration Date", "Lot No.", "Serial No.");
                                        ILE.SETRANGE("Item No.", TempItemEntry1."Item No.");
                                        ILE.SETRANGE("Document No.", TempItemEntry1."Document No.");
                                        ILE.SETRANGE("Posting Date", TempItemEntry1."Posting Date");
                                        //IF TempItemEntry1."Document Type" = TempItemEntry1."Document Type"::"Sales Shipment" THEN
                                        //  ILE.SETFILTER("Entry No.",'<>%1',TempItemEntry1."Entry No.");
                                        ILE.FINDSET();
                                        TempItemEntry3.DELETEALL();
                                        FindAppliedEntry2(ILE);
                                        IF TempItemEntry2.FINDSET() THEN
                                            REPEAT
                                                RecCount := TempItemEntry2.COUNT;
                                                IF (TempItemEntry2."Document Type" IN [TempItemEntry2."Document Type"::"Purchase Receipt",
                                                    TempItemEntry2."Document Type"::"Purchase Return Shipment",
                                                    TempItemEntry2."Document Type"::"Sales Return Receipt",
                                                    TempItemEntry."Document Type"::"Sales Credit Memo"]) OR
                                                   (TempItemEntry2."Entry Type" IN [TempItemEntry2."Entry Type"::"Positive Adjmt.",
                                                    TempItemEntry2."Entry Type"::"Negative Adjmt.",
                                                    TempItemEntry2."Entry Type"::"Assembly Output"])
                                                THEN BEGIN
                                                    IF TempItemEntry2."Entry Type" IN [TempItemEntry2."Entry Type"::"Positive Adjmt.",
                                                       TempItemEntry2."Entry Type"::"Negative Adjmt.",
                                                       TempItemEntry2."Entry Type"::"Assembly Output"]
                                                    THEN
                                                        EXIT(TempItemEntry2."Posting Date")
                                                    ELSE BEGIN
                                                        InvoiceDate := 0D;
                                                        IF GetFrtInvoiceDate(TempItemEntry2) THEN
                                                            EXIT(InvoiceDate)
                                                        ELSE
                                                            EXIT(TempItemEntry2."Posting Date");
                                                    END;
                                                END ELSE BEGIN

                                                    //>>CIS.RAM 03032022
                                                    IF TempItemEntry2."Posting Date" < 010109D THEN
                                                        EXIT(TempItemEntry2."Posting Date");
                                                    //>>CIS.RAM 03032022


                                                    ILE.RESET();
                                                    ILE.CHANGECOMPANY(BusUnit."Company Name");
                                                    ILE.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Expiration Date", "Lot No.", "Serial No.");
                                                    ILE.SETRANGE("Item No.", TempItemEntry2."Item No.");
                                                    ILE.SETRANGE("Document No.", TempItemEntry2."Document No.");
                                                    ILE.SETRANGE("Posting Date", TempItemEntry2."Posting Date");
                                                    ILE.FINDSET();
                                                    //today
                                                    TempItemEntry4.DELETEALL();
                                                    FindAppliedEntry3(ILE);
                                                    IF TempItemEntry3.FINDSET() THEN
                                                        REPEAT
                                                            RecCount := TempItemEntry3.COUNT;
                                                            IF (TempItemEntry3."Document Type" IN [TempItemEntry3."Document Type"::"Purchase Receipt",
                                                                TempItemEntry3."Document Type"::"Purchase Return Shipment",
                                                                TempItemEntry3."Document Type"::"Sales Return Receipt",
                                                                TempItemEntry3."Document Type"::"Sales Credit Memo"]) OR
                                                               (TempItemEntry3."Entry Type" IN [TempItemEntry3."Entry Type"::"Positive Adjmt.",
                                                                TempItemEntry3."Entry Type"::"Negative Adjmt.",
                                                                TempItemEntry3."Entry Type"::"Assembly Output"])
                                                            THEN BEGIN
                                                                IF TempItemEntry3."Entry Type" IN [TempItemEntry3."Entry Type"::"Positive Adjmt.",
                                                                   TempItemEntry3."Entry Type"::"Negative Adjmt.",
                                                                   TempItemEntry3."Entry Type"::"Assembly Output"]
                                                                THEN
                                                                    EXIT(TempItemEntry3."Posting Date")
                                                                ELSE BEGIN
                                                                    InvoiceDate := 0D;
                                                                    IF GetFrtInvoiceDate(TempItemEntry3) THEN
                                                                        EXIT(InvoiceDate)
                                                                    ELSE
                                                                        EXIT(TempItemEntry3."Posting Date");
                                                                END;
                                                            END ELSE BEGIN

                                                                //>>CIS.RAM 03032022
                                                                IF TempItemEntry3."Posting Date" < 010109D THEN
                                                                    EXIT(TempItemEntry3."Posting Date");
                                                                //>>CIS.RAM 03032022


                                                                ILE.RESET();
                                                                ILE.CHANGECOMPANY(BusUnit."Company Name");
                                                                ILE.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Expiration Date", "Lot No.", "Serial No.");
                                                                ILE.SETRANGE("Item No.", TempItemEntry3."Item No.");
                                                                ILE.SETRANGE("Document No.", TempItemEntry3."Document No.");
                                                                ILE.SETRANGE("Posting Date", TempItemEntry3."Posting Date");
                                                                ILE.FINDSET();
                                                                TempItemEntry5.DELETEALL();
                                                                FindAppliedEntry4(ILE);
                                                                IF TempItemEntry4.FINDSET() THEN
                                                                    REPEAT
                                                                        RecCount := TempItemEntry4.COUNT;
                                                                        IF (TempItemEntry4."Document Type" IN [TempItemEntry4."Document Type"::"Purchase Receipt",
                                                                            TempItemEntry4."Document Type"::"Purchase Return Shipment",
                                                                            TempItemEntry4."Document Type"::"Sales Return Receipt",
                                                                            TempItemEntry4."Document Type"::"Sales Credit Memo"]) OR
                                                                           (TempItemEntry4."Entry Type" IN [TempItemEntry4."Entry Type"::"Positive Adjmt.",
                                                                            TempItemEntry4."Entry Type"::"Negative Adjmt.",
                                                                            TempItemEntry4."Entry Type"::"Assembly Output"])
                                                                        THEN BEGIN
                                                                            IF TempItemEntry4."Entry Type" IN [TempItemEntry4."Entry Type"::"Positive Adjmt.",
                                                                               TempItemEntry4."Entry Type"::"Negative Adjmt.",
                                                                               TempItemEntry4."Entry Type"::"Assembly Output"]
                                                                            THEN
                                                                                EXIT(TempItemEntry4."Posting Date")
                                                                            ELSE BEGIN
                                                                                InvoiceDate := 0D;
                                                                                IF GetFrtInvoiceDate(TempItemEntry4) THEN
                                                                                    EXIT(InvoiceDate)
                                                                                ELSE
                                                                                    EXIT(TempItemEntry4."Posting Date");
                                                                            END;
                                                                        END ELSE BEGIN

                                                                            //>>CIS.RAM 03032022
                                                                            IF TempItemEntry4."Posting Date" < 010109D THEN
                                                                                EXIT(TempItemEntry4."Posting Date");
                                                                            //>>CIS.RAM 03032022


                                                                            ILE.RESET();
                                                                            ILE.CHANGECOMPANY(BusUnit."Company Name");
                                                                            ILE.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Expiration Date", "Lot No.", "Serial No.");
                                                                            ILE.SETRANGE("Item No.", TempItemEntry4."Item No.");
                                                                            ILE.SETRANGE("Document No.", TempItemEntry4."Document No.");
                                                                            ILE.SETRANGE("Posting Date", TempItemEntry4."Posting Date");
                                                                            ILE.FINDSET();
                                                                            TempItemEntry6.DELETEALL();
                                                                            FindAppliedEntry5(ILE);
                                                                            IF TempItemEntry5.FINDSET() THEN
                                                                                REPEAT
                                                                                    RecCount := TempItemEntry5.COUNT;
                                                                                    IF (TempItemEntry5."Document Type" IN [TempItemEntry5."Document Type"::"Purchase Receipt",
                                                                                        TempItemEntry5."Document Type"::"Purchase Return Shipment",
                                                                                        TempItemEntry5."Document Type"::"Sales Return Receipt",
                                                                                        TempItemEntry5."Document Type"::"Sales Credit Memo"]) OR
                                                                                       (TempItemEntry5."Entry Type" IN [TempItemEntry5."Entry Type"::"Positive Adjmt.",
                                                                                        TempItemEntry5."Entry Type"::"Negative Adjmt.",
                                                                                        TempItemEntry5."Entry Type"::"Assembly Output"])
                                                                                    THEN BEGIN
                                                                                        IF TempItemEntry5."Entry Type" IN [TempItemEntry5."Entry Type"::"Positive Adjmt.",
                                                                                           TempItemEntry5."Entry Type"::"Negative Adjmt.",
                                                                                           TempItemEntry5."Entry Type"::"Assembly Output"]
                                                                                        THEN
                                                                                            EXIT(TempItemEntry5."Posting Date")
                                                                                        ELSE BEGIN
                                                                                            InvoiceDate := 0D;
                                                                                            IF GetFrtInvoiceDate(TempItemEntry5) THEN
                                                                                                EXIT(InvoiceDate)
                                                                                            ELSE
                                                                                                EXIT(TempItemEntry5."Posting Date");
                                                                                        END;
                                                                                    END ELSE BEGIN

                                                                                        //>>CIS.RAM 03032022
                                                                                        IF TempItemEntry5."Posting Date" < 010109D THEN
                                                                                            EXIT(TempItemEntry5."Posting Date");
                                                                                        //>>CIS.RAM 03032022


                                                                                        ILE.RESET();
                                                                                        ILE.CHANGECOMPANY(BusUnit."Company Name");
                                                                                        ILE.SETRANGE("Item No.", TempItemEntry5."Item No.");
                                                                                        ILE.SETRANGE("Document No.", TempItemEntry5."Document No.");
                                                                                        ILE.SETRANGE("Posting Date", TempItemEntry5."Posting Date");
                                                                                        ILE.FINDSET();
                                                                                        TempItemEntry7.DELETEALL();
                                                                                        FindAppliedEntry6(ILE);
                                                                                        IF TempItemEntry6.FINDSET() THEN
                                                                                            REPEAT
                                                                                                RecCount := TempItemEntry6.COUNT;
                                                                                                IF (TempItemEntry6."Document Type" IN [TempItemEntry6."Document Type"::"Purchase Receipt",
                                                                                                    TempItemEntry6."Document Type"::"Purchase Return Shipment",
                                                                                                    TempItemEntry6."Document Type"::"Sales Return Receipt",
                                                                                                    TempItemEntry6."Document Type"::"Sales Credit Memo"]) OR
                                                                                                   (TempItemEntry6."Entry Type" IN [TempItemEntry6."Entry Type"::"Positive Adjmt.",
                                                                                                    TempItemEntry6."Entry Type"::"Negative Adjmt.",
                                                                                                    TempItemEntry6."Entry Type"::"Assembly Output"])
                                                                                                THEN BEGIN
                                                                                                    IF TempItemEntry6."Entry Type" IN [TempItemEntry6."Entry Type"::"Positive Adjmt.",
                                                                                                       TempItemEntry6."Entry Type"::"Negative Adjmt.",
                                                                                                       TempItemEntry6."Entry Type"::"Assembly Output"]
                                                                                                    THEN
                                                                                                        EXIT(TempItemEntry6."Posting Date")
                                                                                                    ELSE BEGIN
                                                                                                        InvoiceDate := 0D;
                                                                                                        IF GetFrtInvoiceDate(TempItemEntry6) THEN
                                                                                                            EXIT(InvoiceDate)
                                                                                                        ELSE
                                                                                                            EXIT(TempItemEntry6."Posting Date");
                                                                                                    END;
                                                                                                END ELSE BEGIN

                                                                                                    //>>CIS.RAM 03032022
                                                                                                    IF TempItemEntry6."Posting Date" < 010109D THEN
                                                                                                        EXIT(TempItemEntry6."Posting Date");
                                                                                                    //>>CIS.RAM 03032022


                                                                                                    ILE.RESET();
                                                                                                    ILE.CHANGECOMPANY(BusUnit."Company Name");
                                                                                                    ILE.SETRANGE("Item No.", TempItemEntry6."Item No.");
                                                                                                    ILE.SETRANGE("Document No.", TempItemEntry6."Document No.");
                                                                                                    ILE.SETRANGE("Posting Date", TempItemEntry6."Posting Date");
                                                                                                    ILE.FINDSET();
                                                                                                    TempItemEntry8.DELETEALL();
                                                                                                    FindAppliedEntry7(ILE);
                                                                                                    IF TempItemEntry7.FINDSET() THEN
                                                                                                        REPEAT
                                                                                                            RecCount := TempItemEntry7.COUNT;
                                                                                                            IF (TempItemEntry7."Document Type" IN [TempItemEntry7."Document Type"::"Purchase Receipt",
                                                                                                                TempItemEntry7."Document Type"::"Purchase Return Shipment",
                                                                                                                TempItemEntry7."Document Type"::"Sales Return Receipt"]) OR
                                                                                                               (TempItemEntry7."Entry Type" IN [TempItemEntry7."Entry Type"::"Positive Adjmt.",
                                                                                                                TempItemEntry7."Entry Type"::"Negative Adjmt.",
                                                                                                                TempItemEntry7."Entry Type"::"Assembly Output"])
                                                                                                            THEN BEGIN
                                                                                                                IF TempItemEntry7."Entry Type" IN [TempItemEntry7."Entry Type"::"Positive Adjmt.",
                                                                                                                   TempItemEntry7."Entry Type"::"Negative Adjmt.",
                                                                                                                   TempItemEntry7."Entry Type"::"Assembly Output"]
                                                                                                                THEN
                                                                                                                    EXIT(TempItemEntry7."Posting Date")
                                                                                                                ELSE BEGIN
                                                                                                                    InvoiceDate := 0D;
                                                                                                                    IF GetFrtInvoiceDate(TempItemEntry7) THEN
                                                                                                                        EXIT(InvoiceDate)
                                                                                                                    ELSE
                                                                                                                        EXIT(TempItemEntry6."Posting Date");
                                                                                                                END;
                                                                                                            END ELSE BEGIN

                                                                                                                //>>CIS.RAM 03032022
                                                                                                                IF TempItemEntry7."Posting Date" < 010109D THEN
                                                                                                                    EXIT(TempItemEntry7."Posting Date");
                                                                                                                //>>CIS.RAM 03032022


                                                                                                                ILE.RESET();
                                                                                                                ILE.CHANGECOMPANY(BusUnit."Company Name");
                                                                                                                ILE.SETRANGE("Item No.", TempItemEntry7."Item No.");
                                                                                                                ILE.SETRANGE("Document No.", TempItemEntry7."Document No.");
                                                                                                                ILE.SETRANGE("Posting Date", TempItemEntry7."Posting Date");
                                                                                                                ILE.FINDSET();
                                                                                                                TempItemEntry9.DELETEALL();
                                                                                                                MESSAGE('FREIGHT 6: %1', ILE."Entry No.");
                                                                                                                ERROR('Fix %1\%2', ILE."Document Type", GLEntry."Entry No.");
                                                                                                            END;
                                                                                                        UNTIL TempItemEntry7.NEXT() = 0;
                                                                                                END;
                                                                                            UNTIL TempItemEntry6.NEXT() = 0;
                                                                                    END;
                                                                                UNTIL TempItemEntry5.NEXT() = 0;
                                                                        END;
                                                                    UNTIL TempItemEntry4.NEXT() = 0;
                                                            END;
                                                        UNTIL TempItemEntry3.NEXT() = 0;
                                                    //<<today
                                                END;
                                            UNTIL TempItemEntry2.NEXT() = 0;
                                    END;
                                UNTIL TempItemEntry1.NEXT() = 0;
                        END;
                    UNTIL TempItemEntry.NEXT() = 0;
            END ELSE BEGIN
                EXIT(GLEntry."Posting Date");
            END;
        END;

        ValueEntry.RESET();
        ValueEntry.CHANGECOMPANY(BusUnit."Company Name");
        ValueEntry.SETCURRENTKEY("Document No.");
        ValueEntry.SETRANGE("Document No.", ParentCompanyOriginalEntry."Document No.");
        ValueEntry.SETRANGE("Posting Date", ParentCompanyOriginalEntry."Posting Date");
        ValueEntry.SETFILTER("Cost Posted to G/L", '%1|%2', -ParentCompanyOriginalEntry.Amount, ParentCompanyOriginalEntry.Amount);  //Added on 032817
        ValueEntry.SETRANGE(Adjustment, FALSE);
        IF ValueEntry.FINDFIRST() THEN BEGIN
            IF ValueEntry."Item Ledger Entry Type" IN [ValueEntry."Item Ledger Entry Type"::"Negative Adjmt.",
               ValueEntry."Item Ledger Entry Type"::"Positive Adjmt."]
            //ValueEntry."Item Ledger Entry Type"::"Assembly Output"]
            THEN
                EXIT(ValueEntry."Posting Date");

            IF ValueEntry."Document Type" = ValueEntry."Document Type"::"Sales Credit Memo" THEN
                EXIT(ValueEntry."Posting Date");

            ILE.RESET();
            ILE.CHANGECOMPANY(BusUnit."Company Name");
            ILE.GET(ValueEntry."Item Ledger Entry No.");
            IF ILE."Entry Type" = ILE."Entry Type"::Purchase THEN
                EXIT(ILE."Posting Date");
            //>>040218
            IF ValueEntry."Item Ledger Entry Type" = ValueEntry."Item Ledger Entry Type"::"Assembly Output" THEN
                IF ValueEntry."Cost Posted to G/L" = ParentCompanyOriginalEntry.Amount THEN BEGIN
                    BookDeltaAssemblyOutputCost(ILE, ParentCompanyOriginalEntry.Amount);
                    EXIT(ILE."Posting Date");
                END;
            //<<040218

            FindAppliedEntry(ILE);
        END ELSE BEGIN
            EXIT(GLEntry."Posting Date");  //This is either freight or genjnl or Credit Memo record
        END;

        TempItemEntry1.DELETEALL();
        IF TempItemEntry.FINDSET() THEN
            REPEAT
                RecCount := TempItemEntry.COUNT;
                //MESSAGE('1: %1\%2\%3\%4\%5\%6',RecCount,TempItemEntry."Item No.",TempItemEntry."Entry No.",TempItemEntry."Posting Date",
                //   TempItemEntry."Document No.",TempItemEntry."Entry Type");
                IF (TempItemEntry."Document Type" IN [TempItemEntry."Document Type"::"Purchase Receipt",
                    TempItemEntry."Document Type"::"Purchase Return Shipment",
                    TempItemEntry."Document Type"::"Sales Return Receipt"]) OR
                   (TempItemEntry."Entry Type" IN [TempItemEntry."Entry Type"::"Positive Adjmt.",
                    TempItemEntry."Entry Type"::"Negative Adjmt.",
                    TempItemEntry."Entry Type"::"Assembly Output",
                    TempItemEntry."Entry Type"::Purchase])
                THEN BEGIN
                    IF TempItemEntry."Entry Type" IN [TempItemEntry."Entry Type"::"Positive Adjmt.",
                       TempItemEntry."Entry Type"::"Negative Adjmt.",
                       TempItemEntry."Entry Type"::"Assembly Output",
                       TempItemEntry."Entry Type"::Purchase]
                    THEN
                        EXIT(TempItemEntry."Posting Date")
                    ELSE BEGIN
                        InvoiceDate := 0D;
                        IF GetInvoiceDate(TempItemEntry) THEN
                            EXIT(InvoiceDate)
                        ELSE
                            EXIT(TempItemEntry."Posting Date");
                    END;
                END ELSE BEGIN
                    IF TempItemEntry."Entry No." IN [1189396, 1188883] THEN
                        EXIT(TempItemEntry."Posting Date");
                    IF TempItemEntry."Entry Type" = TempItemEntry."Entry Type"::"Negative Adjmt." THEN
                        EXIT(TempItemEntry."Posting Date");

                    //>>CIS.RAM 03032022
                    IF TempItemEntry."Posting Date" < 010109D THEN
                        EXIT(TempItemEntry."Posting Date");
                    //>>CIS.RAM 03032022

                    ILE.RESET();
                    ILE.CHANGECOMPANY(BusUnit."Company Name");
                    ILE.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Expiration Date", "Lot No.", "Serial No.");
                    ILE.SETRANGE("Item No.", TempItemEntry."Item No.");
                    ILE.SETRANGE("Document No.", TempItemEntry."Document No.");
                    ILE.SETRANGE("Posting Date", TempItemEntry."Posting Date");
                    IF (TempItemEntry."Entry Type" = TempItemEntry."Entry Type"::Sale)// OR
                                                                                      //(TempItemEntry."Entry Type" = TempItemEntry."Entry Type"::"Assembly Consumption")) //AND
                                                                                      //(TempItemEntry."Document Type" <> TempItemEntry."Document Type"::"Sales Return Receipt")
                    THEN
                        ILE.SETFILTER(Positive, '%1', FALSE);
                    ILE.FINDSET();
                    FindAppliedEntry1(ILE);
                    IF TempItemEntry1.FINDSET() THEN
                        REPEAT
                            RecCount := TempItemEntry1.COUNT;
                            IF (TempItemEntry1."Document Type" IN [TempItemEntry1."Document Type"::"Purchase Receipt",
                                TempItemEntry1."Document Type"::"Purchase Return Shipment",
                                TempItemEntry1."Document Type"::"Sales Return Receipt"]) OR
                               (TempItemEntry1."Entry Type" IN [TempItemEntry1."Entry Type"::"Positive Adjmt.",
                                TempItemEntry1."Entry Type"::"Negative Adjmt.",
                                TempItemEntry1."Entry Type"::"Assembly Output"])
                            THEN BEGIN
                                IF TempItemEntry1."Entry Type" IN [TempItemEntry1."Entry Type"::"Positive Adjmt.",
                                   TempItemEntry1."Entry Type"::"Negative Adjmt.",
                                   TempItemEntry1."Entry Type"::"Assembly Output"]
                                THEN
                                    EXIT(TempItemEntry1."Posting Date")
                                ELSE BEGIN
                                    InvoiceDate := 0D;
                                    IF GetInvoiceDate(TempItemEntry1) THEN
                                        EXIT(InvoiceDate)
                                    ELSE
                                        EXIT(TempItemEntry1."Posting Date");
                                END;
                            END ELSE BEGIN
                                IF TempItemEntry1."Entry No." IN [1189396, 1188883] THEN
                                    EXIT(TempItemEntry1."Posting Date");
                                ILE.RESET();
                                ILE.CHANGECOMPANY(BusUnit."Company Name");
                                ILE.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Expiration Date", "Lot No.", "Serial No.");
                                ILE.SETRANGE("Item No.", TempItemEntry1."Item No.");
                                ILE.SETRANGE("Document No.", TempItemEntry1."Document No.");
                                ILE.SETRANGE("Posting Date", TempItemEntry1."Posting Date");
                                IF (TempItemEntry1."Entry Type" = TempItemEntry1."Entry Type"::Sale)// OR
                                                                                                    //(TempItemEntry1."Entry Type" = TempItemEntry1."Entry Type"::"Assembly Consumption")
                                THEN
                                    ILE.SETFILTER(Positive, '%1', FALSE);
                                ILE.FINDSET();
                                FindAppliedEntry2(ILE);
                                IF TempItemEntry2.FINDSET() THEN
                                    REPEAT
                                        RecCount := TempItemEntry2.COUNT;
                                        IF (TempItemEntry2."Document Type" IN [TempItemEntry2."Document Type"::"Purchase Receipt",
                                            TempItemEntry2."Document Type"::"Purchase Return Shipment",
                                            TempItemEntry2."Document Type"::"Sales Return Receipt"]) OR
                                           (TempItemEntry2."Entry Type" IN [TempItemEntry2."Entry Type"::"Positive Adjmt.",
                                            TempItemEntry2."Entry Type"::"Negative Adjmt.",
                                            TempItemEntry2."Entry Type"::"Assembly Output"])
                                        THEN BEGIN
                                            IF TempItemEntry2."Entry Type" IN [TempItemEntry2."Entry Type"::"Positive Adjmt.",
                                               TempItemEntry2."Entry Type"::"Negative Adjmt.",
                                               TempItemEntry2."Entry Type"::"Assembly Output"]
                                            THEN
                                                EXIT(TempItemEntry2."Posting Date")
                                            ELSE BEGIN
                                                InvoiceDate := 0D;
                                                IF GetInvoiceDate(TempItemEntry2) THEN
                                                    EXIT(InvoiceDate)
                                                ELSE
                                                    EXIT(TempItemEntry2."Posting Date");
                                            END;
                                        END ELSE BEGIN
                                            IF TempItemEntry2."Entry No." IN [1189396, 1188883] THEN
                                                EXIT(TempItemEntry2."Posting Date");
                                            ILE.RESET();
                                            ILE.CHANGECOMPANY(BusUnit."Company Name");
                                            ILE.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Expiration Date", "Lot No.", "Serial No.");
                                            ILE.SETRANGE("Item No.", TempItemEntry2."Item No.");
                                            ILE.SETRANGE("Document No.", TempItemEntry2."Document No.");
                                            ILE.SETRANGE("Posting Date", TempItemEntry2."Posting Date");
                                            IF (TempItemEntry2."Entry Type" = TempItemEntry2."Entry Type"::Sale)// OR
                                                                                                                //(TempItemEntry2."Entry Type" = TempItemEntry2."Entry Type"::"Assembly Consumption")
                                            THEN
                                                ILE.SETFILTER(Positive, '%1', FALSE);
                                            ILE.FINDSET();
                                            //today
                                            TempItemEntry4.DELETEALL();
                                            FindAppliedEntry3(ILE);
                                            IF TempItemEntry3.FINDSET() THEN
                                                REPEAT
                                                    RecCount := TempItemEntry3.COUNT;
                                                    IF (TempItemEntry3."Document Type" IN [TempItemEntry3."Document Type"::"Purchase Receipt",
                                                        TempItemEntry3."Document Type"::"Purchase Return Shipment",
                                                        TempItemEntry3."Document Type"::"Sales Return Receipt"]) OR
                                                       (TempItemEntry3."Entry Type" IN [TempItemEntry3."Entry Type"::"Positive Adjmt.",
                                                        TempItemEntry3."Entry Type"::"Negative Adjmt.",
                                                        TempItemEntry3."Entry Type"::"Assembly Output"])
                                                    THEN BEGIN
                                                        IF TempItemEntry3."Entry Type" IN [TempItemEntry3."Entry Type"::"Positive Adjmt.",
                                                           TempItemEntry3."Entry Type"::"Negative Adjmt.",
                                                           TempItemEntry3."Entry Type"::"Assembly Output"]
                                                        THEN
                                                            EXIT(TempItemEntry3."Posting Date")
                                                        ELSE BEGIN
                                                            InvoiceDate := 0D;
                                                            IF GetFrtInvoiceDate(TempItemEntry3) THEN
                                                                EXIT(InvoiceDate)
                                                            ELSE
                                                                EXIT(TempItemEntry3."Posting Date");
                                                        END;
                                                    END ELSE BEGIN
                                                        ILE.RESET();
                                                        ILE.CHANGECOMPANY(BusUnit."Company Name");
                                                        ILE.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Expiration Date", "Lot No.", "Serial No.");
                                                        ILE.SETRANGE("Item No.", TempItemEntry3."Item No.");
                                                        ILE.SETRANGE("Document No.", TempItemEntry3."Document No.");
                                                        ILE.SETRANGE("Posting Date", TempItemEntry3."Posting Date");
                                                        IF (TempItemEntry3."Entry Type" = TempItemEntry3."Entry Type"::Sale)// OR
                                                                                                                            //(TempItemEntry3."Entry Type" = TempItemEntry3."Entry Type"::"Assembly Consumption")
                                                        THEN
                                                            ILE.SETFILTER(Positive, '%1', FALSE);

                                                        TempItemEntry5.DELETEALL();
                                                        FindAppliedEntry4(ILE);
                                                        IF TempItemEntry4.FINDSET() THEN
                                                            REPEAT
                                                                RecCount := TempItemEntry4.COUNT;
                                                                IF (TempItemEntry4."Document Type" IN [TempItemEntry4."Document Type"::"Purchase Receipt",
                                                                    TempItemEntry4."Document Type"::"Purchase Return Shipment",
                                                                    TempItemEntry4."Document Type"::"Sales Return Receipt"]) OR
                                                                   (TempItemEntry4."Entry Type" IN [TempItemEntry4."Entry Type"::"Positive Adjmt.",
                                                                    TempItemEntry4."Entry Type"::"Negative Adjmt.",
                                                                    TempItemEntry4."Entry Type"::"Assembly Output"])
                                                                THEN BEGIN
                                                                    IF TempItemEntry4."Entry Type" IN [TempItemEntry4."Entry Type"::"Positive Adjmt.",
                                                                       TempItemEntry4."Entry Type"::"Negative Adjmt.",
                                                                       TempItemEntry4."Entry Type"::"Assembly Output"]
                                                                    THEN
                                                                        EXIT(TempItemEntry4."Posting Date")
                                                                    ELSE BEGIN
                                                                        InvoiceDate := 0D;
                                                                        IF GetFrtInvoiceDate(TempItemEntry4) THEN
                                                                            EXIT(InvoiceDate)
                                                                        ELSE
                                                                            EXIT(TempItemEntry4."Posting Date");
                                                                    END;
                                                                END ELSE BEGIN
                                                                    ILE.RESET();
                                                                    ILE.CHANGECOMPANY(BusUnit."Company Name");
                                                                    ILE.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Expiration Date", "Lot No.", "Serial No.");
                                                                    ILE.SETRANGE("Item No.", TempItemEntry4."Item No.");
                                                                    ILE.SETRANGE("Document No.", TempItemEntry4."Document No.");
                                                                    ILE.SETRANGE("Posting Date", TempItemEntry4."Posting Date");
                                                                    IF (TempItemEntry4."Entry Type" = TempItemEntry4."Entry Type"::Sale)// OR
                                                                                                                                        //(TempItemEntry4."Entry Type" = TempItemEntry4."Entry Type"::"Assembly Consumption")
                                                                    THEN
                                                                        ILE.SETFILTER(Positive, '%1', FALSE);
                                                                    ILE.FINDSET();
                                                                    TempItemEntry6.DELETEALL();
                                                                    FindAppliedEntry5(ILE);
                                                                    IF TempItemEntry5.FINDSET() THEN
                                                                        REPEAT
                                                                            RecCount := TempItemEntry5.COUNT;
                                                                            IF (TempItemEntry5."Document Type" IN [TempItemEntry5."Document Type"::"Purchase Receipt",
                                                                                TempItemEntry5."Document Type"::"Purchase Return Shipment",
                                                                                TempItemEntry5."Document Type"::"Sales Return Receipt"]) OR
                                                                               (TempItemEntry5."Entry Type" IN [TempItemEntry5."Entry Type"::"Positive Adjmt.",
                                                                                TempItemEntry5."Entry Type"::"Negative Adjmt.",
                                                                                TempItemEntry5."Entry Type"::"Assembly Output"])
                                                                            THEN BEGIN
                                                                                IF TempItemEntry5."Entry Type" IN [TempItemEntry5."Entry Type"::"Positive Adjmt.",
                                                                                   TempItemEntry5."Entry Type"::"Negative Adjmt.",
                                                                                   TempItemEntry5."Entry Type"::"Assembly Output"]
                                                                                THEN
                                                                                    EXIT(TempItemEntry5."Posting Date")
                                                                                ELSE BEGIN
                                                                                    InvoiceDate := 0D;
                                                                                    IF GetFrtInvoiceDate(TempItemEntry5) THEN
                                                                                        EXIT(InvoiceDate)
                                                                                    ELSE
                                                                                        EXIT(TempItemEntry5."Posting Date");
                                                                                END;
                                                                            END ELSE BEGIN
                                                                                ILE.RESET();
                                                                                ILE.CHANGECOMPANY(BusUnit."Company Name");
                                                                                ILE.SETRANGE("Item No.", TempItemEntry5."Item No.");
                                                                                ILE.SETRANGE("Document No.", TempItemEntry5."Document No.");
                                                                                ILE.SETRANGE("Posting Date", TempItemEntry5."Posting Date");
                                                                                IF (TempItemEntry5."Entry Type" = TempItemEntry5."Entry Type"::Sale) //OR
                                                                                                                                                     //(TempItemEntry5."Entry Type" = TempItemEntry5."Entry Type"::"Assembly Consumption")
                                                                                THEN
                                                                                    ILE.SETFILTER(Positive, '%1', FALSE);
                                                                                ILE.FINDSET();
                                                                                TempItemEntry7.DELETEALL();
                                                                                FindAppliedEntry6(ILE);
                                                                                IF TempItemEntry6.FINDSET() THEN
                                                                                    REPEAT
                                                                                        RecCount := TempItemEntry6.COUNT;
                                                                                        IF (TempItemEntry6."Document Type" IN [TempItemEntry6."Document Type"::"Purchase Receipt",
                                                                                            TempItemEntry6."Document Type"::"Purchase Return Shipment",
                                                                                            TempItemEntry6."Document Type"::"Sales Return Receipt"]) OR
                                                                                           (TempItemEntry6."Entry Type" IN [TempItemEntry6."Entry Type"::"Positive Adjmt.",
                                                                                            TempItemEntry6."Entry Type"::"Negative Adjmt.",
                                                                                            TempItemEntry6."Entry Type"::"Assembly Output"])
                                                                                        THEN BEGIN
                                                                                            IF TempItemEntry6."Entry Type" IN [TempItemEntry6."Entry Type"::"Positive Adjmt.",
                                                                                               TempItemEntry6."Entry Type"::"Negative Adjmt.",
                                                                                               TempItemEntry6."Entry Type"::"Assembly Output"]
                                                                                            THEN
                                                                                                EXIT(TempItemEntry6."Posting Date")
                                                                                            ELSE BEGIN
                                                                                                InvoiceDate := 0D;
                                                                                                IF GetFrtInvoiceDate(TempItemEntry6) THEN
                                                                                                    EXIT(InvoiceDate)
                                                                                                ELSE
                                                                                                    EXIT(TempItemEntry6."Posting Date");
                                                                                            END;
                                                                                        END ELSE BEGIN
                                                                                            ILE.RESET();
                                                                                            ILE.CHANGECOMPANY(BusUnit."Company Name");
                                                                                            ILE.SETRANGE("Item No.", TempItemEntry6."Item No.");
                                                                                            ILE.SETRANGE("Document No.", TempItemEntry6."Document No.");
                                                                                            ILE.SETRANGE("Posting Date", TempItemEntry6."Posting Date");
                                                                                            IF (TempItemEntry6."Entry Type" = TempItemEntry6."Entry Type"::Sale)// OR
                                                                                                                                                                //(TempItemEntry6."Entry Type" = TempItemEntry6."Entry Type"::"Assembly Consumption")
                                                                                            THEN
                                                                                                ILE.SETFILTER(Positive, '%1', FALSE);
                                                                                            ILE.FINDSET();
                                                                                            TempItemEntry8.DELETEALL();
                                                                                            FindAppliedEntry7(ILE);
                                                                                            IF TempItemEntry7.FINDSET() THEN
                                                                                                REPEAT
                                                                                                    RecCount := TempItemEntry7.COUNT;
                                                                                                    IF (TempItemEntry7."Document Type" IN [TempItemEntry7."Document Type"::"Purchase Receipt",
                                                                                                        TempItemEntry7."Document Type"::"Purchase Return Shipment",
                                                                                                        TempItemEntry7."Document Type"::"Sales Return Receipt"]) OR
                                                                                                       (TempItemEntry7."Entry Type" IN [TempItemEntry7."Entry Type"::"Positive Adjmt.",
                                                                                                        TempItemEntry7."Entry Type"::"Negative Adjmt.",
                                                                                                        TempItemEntry7."Entry Type"::"Assembly Output"])
                                                                                                    THEN BEGIN
                                                                                                        IF TempItemEntry7."Entry Type" IN [TempItemEntry7."Entry Type"::"Positive Adjmt.",
                                                                                                           TempItemEntry7."Entry Type"::"Negative Adjmt.",
                                                                                                           TempItemEntry7."Entry Type"::"Assembly Output"]
                                                                                                        THEN
                                                                                                            EXIT(TempItemEntry7."Posting Date")
                                                                                                        ELSE BEGIN
                                                                                                            InvoiceDate := 0D;
                                                                                                            IF GetFrtInvoiceDate(TempItemEntry7) THEN
                                                                                                                EXIT(InvoiceDate)
                                                                                                            ELSE
                                                                                                                EXIT(TempItemEntry7."Posting Date");
                                                                                                        END;
                                                                                                    END ELSE BEGIN
                                                                                                        ILE.RESET();
                                                                                                        ILE.CHANGECOMPANY(BusUnit."Company Name");
                                                                                                        ILE.SETRANGE("Item No.", TempItemEntry7."Item No.");
                                                                                                        ILE.SETRANGE("Document No.", TempItemEntry7."Document No.");
                                                                                                        ILE.SETRANGE("Posting Date", TempItemEntry7."Posting Date");
                                                                                                        IF (TempItemEntry7."Entry Type" = TempItemEntry7."Entry Type"::Sale)// OR
                                                                                                                                                                            //(TempItemEntry7."Entry Type" = TempItemEntry7."Entry Type"::"Assembly Consumption")
                                                                                                        THEN
                                                                                                            ILE.SETFILTER(Positive, '%1', FALSE);
                                                                                                        ILE.FINDSET();
                                                                                                        TempItemEntry9.DELETEALL();
                                                                                                        FindAppliedEntry8(ILE);
                                                                                                        IF TempItemEntry8.FINDSET() THEN
                                                                                                            REPEAT
                                                                                                                RecCount := TempItemEntry8.COUNT;
                                                                                                                IF (TempItemEntry8."Document Type" IN [TempItemEntry8."Document Type"::"Purchase Receipt",
                                                                                                                    TempItemEntry8."Document Type"::"Purchase Return Shipment",
                                                                                                                    TempItemEntry8."Document Type"::"Sales Return Receipt"]) OR
                                                                                                                   (TempItemEntry8."Entry Type" IN [TempItemEntry8."Entry Type"::"Positive Adjmt.",
                                                                                                                    TempItemEntry8."Entry Type"::"Negative Adjmt.",
                                                                                                                    TempItemEntry8."Entry Type"::"Assembly Output"])
                                                                                                                THEN BEGIN
                                                                                                                    IF TempItemEntry8."Entry Type" IN [TempItemEntry8."Entry Type"::"Positive Adjmt.",
                                                                                                                       TempItemEntry8."Entry Type"::"Negative Adjmt.",
                                                                                                                       TempItemEntry8."Entry Type"::"Assembly Output"]
                                                                                                                    THEN
                                                                                                                        EXIT(TempItemEntry8."Posting Date")
                                                                                                                    ELSE BEGIN
                                                                                                                        InvoiceDate := 0D;
                                                                                                                        IF GetFrtInvoiceDate(TempItemEntry8) THEN
                                                                                                                            EXIT(InvoiceDate)
                                                                                                                        ELSE
                                                                                                                            EXIT(TempItemEntry7."Posting Date");
                                                                                                                    END;
                                                                                                                END ELSE BEGIN
                                                                                                                    ILE.RESET();
                                                                                                                    ILE.CHANGECOMPANY(BusUnit."Company Name");
                                                                                                                    ILE.SETRANGE("Item No.", TempItemEntry8."Item No.");
                                                                                                                    ILE.SETRANGE("Document No.", TempItemEntry8."Document No.");
                                                                                                                    ILE.SETRANGE("Posting Date", TempItemEntry8."Posting Date");
                                                                                                                    IF (TempItemEntry8."Entry Type" = TempItemEntry8."Entry Type"::Sale)// OR
                                                                                                                                                                                        //(TempItemEntry8."Entry Type" = TempItemEntry8."Entry Type"::"Assembly Consumption")
                                                                                                                    THEN
                                                                                                                        ILE.SETFILTER(Positive, '%1', FALSE);
                                                                                                                    ILE.FINDSET();
                                                                                                                    TempItemEntry10.DELETEALL();
                                                                                                                    MESSAGE('Cogs 6: %1', ILE."Entry No.");
                                                                                                                    ERROR('Fix %1\%2', ILE."Document Type", GLEntry."Entry No.");
                                                                                                                END;
                                                                                                            UNTIL TempItemEntry7.NEXT() = 0;
                                                                                                    END;
                                                                                                UNTIL TempItemEntry7.NEXT() = 0;
                                                                                        END;
                                                                                    UNTIL TempItemEntry6.NEXT() = 0;
                                                                            END;
                                                                        UNTIL TempItemEntry5.NEXT() = 0;
                                                                END;
                                                            UNTIL TempItemEntry4.NEXT() = 0;
                                                    END;
                                                UNTIL TempItemEntry3.NEXT() = 0;
                                            //<<today
                                            ILE.FINDSET();
                                        END;
                                    UNTIL TempItemEntry2.NEXT() = 0;
                            END;
                        UNTIL TempItemEntry1.NEXT() = 0;
                END;
            UNTIL TempItemEntry.NEXT() = 0;
        //<<CIS.RAM

        //>>CIS.RAM
        TempSubsidGLEntry."Document No." := NewGLEntry."Document No.";
        TempSubsidGLEntry."Document Type" := NewGLEntry."Document Type";
        IF TempSubsidGLEntry."G/L Account No." IN ['180', '730'] THEN BEGIN //,'707'] THEN BEGIN
            TempSubsidGLEntry."Original Posting Date" := GetReceiptDate(NewGLEntry);
        END;
        //<<CIS.RAM
        //>>CIS.RAM 04/29/18
        TempSubsidGLEntry."Original Entry No." := NewGLEntry."Entry No.";
        TempSubsidGLEntry."Original Transaction No." := NewGLEntry."Transaction No.";
        //IF NewGLEntry."Entry No." = 18784040 THEN     //VK
        //ERROR ('%1',NewGLEntry."Transaction No.");  //VK
        //IF NewGLEntry."Entry No." = 18784041 THEN     //VK
        //ERROR ('%1',NewGLEntry."Transaction No.");  //VK


        //<<CIS.RAM 04/29/18

        IF (TempSubsidGLEntry."Debit Amount" <> 0) OR (TempSubsidGLEntry."Credit Amount" <> 0) THEN
            IF NOT TempSubsidGLEntry.INSERT THEN BEGIN
                NextEntryNo += 3;
                TempSubsidGLEntry."Entry No." := NextEntryNo;
                TempSubsidGLEntry.INSERT;
            END;
    END;

    LOCAL PROCEDURE FindAppliedEntry(ItemLedgEntry: Record 32);
    VAR
        ItemApplnEntry: Record 339;
    BEGIN
        WITH ItemLedgEntry DO
            IF Positive THEN BEGIN
                ItemApplnEntry.RESET();
                ItemApplnEntry.CHANGECOMPANY(BusUnit."Company Name");
                ItemApplnEntry.SETCURRENTKEY("Inbound Item Entry No.", "Outbound Item Entry No.", "Cost Application");
                ItemApplnEntry.SETRANGE("Inbound Item Entry No.", "Entry No.");
                ItemApplnEntry.SETFILTER("Outbound Item Entry No.", '<>%1', 0);
                ItemApplnEntry.SETRANGE("Cost Application", TRUE);
                IF ItemApplnEntry.FIND('-') THEN
                    REPEAT
                        InsertTempEntry(ItemApplnEntry."Outbound Item Entry No.", ItemApplnEntry.Quantity);
                    UNTIL ItemApplnEntry.NEXT() = 0;
            END ELSE BEGIN
                ItemApplnEntry.RESET();
                ItemApplnEntry.CHANGECOMPANY(BusUnit."Company Name");
                ItemApplnEntry.SETCURRENTKEY("Outbound Item Entry No.", "Item Ledger Entry No.", "Cost Application");
                ItemApplnEntry.SETRANGE("Outbound Item Entry No.", "Entry No.");
                ItemApplnEntry.SETRANGE("Item Ledger Entry No.", "Entry No.");
                ItemApplnEntry.SETRANGE("Cost Application", TRUE);
                IF ItemApplnEntry.FIND('-') THEN
                    REPEAT
                        InsertTempEntry(ItemApplnEntry."Inbound Item Entry No.", -ItemApplnEntry.Quantity);
                    UNTIL ItemApplnEntry.NEXT() = 0;
            END;
    END;

    LOCAL PROCEDURE InsertTempEntry(EntryNo: Integer; AppliedQty: Decimal);
    VAR
        ItemLedgEntry: Record 32;
    BEGIN
        ItemLedgEntry.CHANGECOMPANY(BusUnit."Company Name");
        ItemLedgEntry.GET(EntryNo);
        IF AppliedQty * ItemLedgEntry.Quantity < 0 THEN
            EXIT;

        IF NOT TempItemEntry.GET(EntryNo) THEN BEGIN
            TempItemEntry.INIT();
            TempItemEntry := ItemLedgEntry;
            TempItemEntry.Quantity := AppliedQty;
            TempItemEntry.INSERT();
        END ELSE BEGIN
            TempItemEntry.Quantity := TempItemEntry.Quantity + AppliedQty;
            TempItemEntry.MODIFY();
        END;
    END;

    LOCAL PROCEDURE FindAppliedEntry1(ItemLedgEntry: Record 32);
    VAR
        ItemApplnEntry: Record 339;
    BEGIN
        WITH ItemLedgEntry DO
            IF Positive THEN BEGIN
                ItemApplnEntry.RESET();
                ItemApplnEntry.CHANGECOMPANY(BusUnit."Company Name");
                ItemApplnEntry.SETCURRENTKEY("Inbound Item Entry No.", "Outbound Item Entry No.", "Cost Application");
                ItemApplnEntry.SETRANGE("Inbound Item Entry No.", "Entry No.");
                ItemApplnEntry.SETFILTER("Outbound Item Entry No.", '<>%1', 0);
                ItemApplnEntry.SETRANGE("Cost Application", TRUE);
                IF ItemApplnEntry.FIND('-') THEN
                    REPEAT
                        InsertTempEntry1(ItemApplnEntry."Outbound Item Entry No.", ItemApplnEntry.Quantity);
                    UNTIL ItemApplnEntry.NEXT() = 0;
            END ELSE BEGIN
                ItemApplnEntry.RESET();
                ItemApplnEntry.CHANGECOMPANY(BusUnit."Company Name");
                ItemApplnEntry.SETCURRENTKEY("Outbound Item Entry No.", "Item Ledger Entry No.", "Cost Application");
                ItemApplnEntry.SETRANGE("Outbound Item Entry No.", "Entry No.");
                ItemApplnEntry.SETRANGE("Item Ledger Entry No.", "Entry No.");
                ItemApplnEntry.SETRANGE("Cost Application", TRUE);
                IF ItemApplnEntry.FIND('-') THEN
                    REPEAT
                        InsertTempEntry1(ItemApplnEntry."Inbound Item Entry No.", -ItemApplnEntry.Quantity);
                    UNTIL ItemApplnEntry.NEXT() = 0;
            END;
    END;

    LOCAL PROCEDURE InsertTempEntry1(EntryNo: Integer; AppliedQty: Decimal);
    VAR
        ItemLedgEntry: Record 32;
    BEGIN
        ItemLedgEntry.CHANGECOMPANY(BusUnit."Company Name");
        ItemLedgEntry.GET(EntryNo);
        IF AppliedQty * ItemLedgEntry.Quantity < 0 THEN
            EXIT;

        IF NOT TempItemEntry1.GET(EntryNo) THEN BEGIN
            TempItemEntry1.INIT();
            TempItemEntry1 := ItemLedgEntry;
            TempItemEntry1.Quantity := AppliedQty;
            TempItemEntry1.INSERT();
        END ELSE BEGIN
            TempItemEntry1.Quantity := TempItemEntry1.Quantity + AppliedQty;
            TempItemEntry1.MODIFY();
        END;
    END;

    LOCAL PROCEDURE FindAppliedEntry2(ItemLedgEntry: Record 32);
    VAR
        ItemApplnEntry: Record 339;
    BEGIN
        WITH ItemLedgEntry DO
            IF Positive THEN BEGIN
                ItemApplnEntry.RESET();
                ItemApplnEntry.CHANGECOMPANY(BusUnit."Company Name");
                ItemApplnEntry.SETCURRENTKEY("Inbound Item Entry No.", "Outbound Item Entry No.", "Cost Application");
                ItemApplnEntry.SETRANGE("Inbound Item Entry No.", "Entry No.");
                ItemApplnEntry.SETFILTER("Outbound Item Entry No.", '<>%1', 0);
                ItemApplnEntry.SETRANGE("Cost Application", TRUE);
                IF ItemApplnEntry.FIND('-') THEN
                    REPEAT
                        InsertTempEntry2(ItemApplnEntry."Outbound Item Entry No.", ItemApplnEntry.Quantity);
                    UNTIL ItemApplnEntry.NEXT() = 0;
            END ELSE BEGIN
                ItemApplnEntry.RESET();
                ItemApplnEntry.CHANGECOMPANY(BusUnit."Company Name");
                ItemApplnEntry.SETCURRENTKEY("Outbound Item Entry No.", "Item Ledger Entry No.", "Cost Application");
                ItemApplnEntry.SETRANGE("Outbound Item Entry No.", "Entry No.");
                ItemApplnEntry.SETRANGE("Item Ledger Entry No.", "Entry No.");
                ItemApplnEntry.SETRANGE("Cost Application", TRUE);
                IF ItemApplnEntry.FIND('-') THEN
                    REPEAT
                        InsertTempEntry2(ItemApplnEntry."Inbound Item Entry No.", -ItemApplnEntry.Quantity);
                    UNTIL ItemApplnEntry.NEXT() = 0;
            END;
    END;

    LOCAL PROCEDURE InsertTempEntry2(EntryNo: Integer; AppliedQty: Decimal);
    VAR
        ItemLedgEntry: Record 32;
    BEGIN
        ItemLedgEntry.CHANGECOMPANY(BusUnit."Company Name");
        ItemLedgEntry.GET(EntryNo);
        IF AppliedQty * ItemLedgEntry.Quantity < 0 THEN
            EXIT;

        IF NOT TempItemEntry2.GET(EntryNo) THEN BEGIN
            TempItemEntry2.INIT();
            TempItemEntry2 := ItemLedgEntry;
            TempItemEntry2.Quantity := AppliedQty;
            TempItemEntry2.INSERT();
        END ELSE BEGIN
            TempItemEntry2.Quantity := TempItemEntry2.Quantity + AppliedQty;
            TempItemEntry2.MODIFY();
        END;
    END;

    LOCAL PROCEDURE FindAppliedEntry3(ItemLedgEntry: Record 32);
    VAR
        ItemApplnEntry: Record 339;
    BEGIN
        WITH ItemLedgEntry DO
            IF Positive THEN BEGIN
                ItemApplnEntry.RESET();
                ItemApplnEntry.CHANGECOMPANY(BusUnit."Company Name");
                ItemApplnEntry.SETCURRENTKEY("Inbound Item Entry No.", "Outbound Item Entry No.", "Cost Application");
                ItemApplnEntry.SETRANGE("Inbound Item Entry No.", "Entry No.");
                ItemApplnEntry.SETFILTER("Outbound Item Entry No.", '<>%1', 0);
                ItemApplnEntry.SETRANGE("Cost Application", TRUE);
                IF ItemApplnEntry.FIND('-') THEN
                    REPEAT
                        InsertTempEntry3(ItemApplnEntry."Outbound Item Entry No.", ItemApplnEntry.Quantity);
                    UNTIL ItemApplnEntry.NEXT() = 0;
            END ELSE BEGIN
                ItemApplnEntry.RESET();
                ItemApplnEntry.CHANGECOMPANY(BusUnit."Company Name");
                ItemApplnEntry.SETCURRENTKEY("Outbound Item Entry No.", "Item Ledger Entry No.", "Cost Application");
                ItemApplnEntry.SETRANGE("Outbound Item Entry No.", "Entry No.");
                ItemApplnEntry.SETRANGE("Item Ledger Entry No.", "Entry No.");
                ItemApplnEntry.SETRANGE("Cost Application", TRUE);
                IF ItemApplnEntry.FIND('-') THEN
                    REPEAT
                        InsertTempEntry3(ItemApplnEntry."Inbound Item Entry No.", -ItemApplnEntry.Quantity);
                    UNTIL ItemApplnEntry.NEXT() = 0;
            END;
    END;

    LOCAL PROCEDURE InsertTempEntry3(EntryNo: Integer; AppliedQty: Decimal);
    VAR
        ItemLedgEntry: Record 32;
    BEGIN
        ItemLedgEntry.CHANGECOMPANY(BusUnit."Company Name");
        ItemLedgEntry.GET(EntryNo);
        IF AppliedQty * ItemLedgEntry.Quantity < 0 THEN
            EXIT;

        IF NOT TempItemEntry3.GET(EntryNo) THEN BEGIN
            TempItemEntry3.INIT();
            TempItemEntry3 := ItemLedgEntry;
            TempItemEntry3.Quantity := AppliedQty;
            TempItemEntry3.INSERT();
        END ELSE BEGIN
            TempItemEntry3.Quantity := TempItemEntry3.Quantity + AppliedQty;
            TempItemEntry3.MODIFY();
        END;
    END;

    LOCAL PROCEDURE FindAppliedEntry4(ItemLedgEntry: Record 32);
    VAR
        ItemApplnEntry: Record 339;
    BEGIN
        WITH ItemLedgEntry DO
            IF Positive THEN BEGIN
                ItemApplnEntry.RESET();
                ItemApplnEntry.CHANGECOMPANY(BusUnit."Company Name");
                ItemApplnEntry.SETCURRENTKEY("Inbound Item Entry No.", "Outbound Item Entry No.", "Cost Application");
                ItemApplnEntry.SETRANGE("Inbound Item Entry No.", "Entry No.");
                ItemApplnEntry.SETFILTER("Outbound Item Entry No.", '<>%1', 0);
                ItemApplnEntry.SETRANGE("Cost Application", TRUE);
                IF ItemApplnEntry.FIND('-') THEN
                    REPEAT
                        InsertTempEntry4(ItemApplnEntry."Outbound Item Entry No.", ItemApplnEntry.Quantity);
                    UNTIL ItemApplnEntry.NEXT() = 0;
            END ELSE BEGIN
                ItemApplnEntry.RESET();
                ItemApplnEntry.CHANGECOMPANY(BusUnit."Company Name");
                ItemApplnEntry.SETCURRENTKEY("Outbound Item Entry No.", "Item Ledger Entry No.", "Cost Application");
                ItemApplnEntry.SETRANGE("Outbound Item Entry No.", "Entry No.");
                ItemApplnEntry.SETRANGE("Item Ledger Entry No.", "Entry No.");
                ItemApplnEntry.SETRANGE("Cost Application", TRUE);
                IF ItemApplnEntry.FIND('-') THEN
                    REPEAT
                        InsertTempEntry4(ItemApplnEntry."Inbound Item Entry No.", -ItemApplnEntry.Quantity);
                    UNTIL ItemApplnEntry.NEXT() = 0;
            END;
    END;

    LOCAL PROCEDURE InsertTempEntry4(EntryNo: Integer; AppliedQty: Decimal);
    VAR
        ItemLedgEntry: Record 32;
    BEGIN
        ItemLedgEntry.CHANGECOMPANY(BusUnit."Company Name");
        ItemLedgEntry.GET(EntryNo);
        IF AppliedQty * ItemLedgEntry.Quantity < 0 THEN
            EXIT;

        IF NOT TempItemEntry4.GET(EntryNo) THEN BEGIN
            TempItemEntry4.INIT();
            TempItemEntry4 := ItemLedgEntry;
            TempItemEntry4.Quantity := AppliedQty;
            TempItemEntry4.INSERT();
        END ELSE BEGIN
            TempItemEntry4.Quantity := TempItemEntry4.Quantity + AppliedQty;
            TempItemEntry4.MODIFY();
        END;
    END;

    LOCAL PROCEDURE FindAppliedEntry5(ItemLedgEntry: Record 32);
    VAR
        ItemApplnEntry: Record 339;
    BEGIN
        WITH ItemLedgEntry DO
            IF Positive THEN BEGIN
                ItemApplnEntry.RESET();
                ItemApplnEntry.CHANGECOMPANY(BusUnit."Company Name");
                ItemApplnEntry.SETCURRENTKEY("Inbound Item Entry No.", "Outbound Item Entry No.", "Cost Application");
                ItemApplnEntry.SETRANGE("Inbound Item Entry No.", "Entry No.");
                ItemApplnEntry.SETFILTER("Outbound Item Entry No.", '<>%1', 0);
                ItemApplnEntry.SETRANGE("Cost Application", TRUE);
                IF ItemApplnEntry.FIND('-') THEN
                    REPEAT
                        InsertTempEntry5(ItemApplnEntry."Outbound Item Entry No.", ItemApplnEntry.Quantity);
                    UNTIL ItemApplnEntry.NEXT() = 0;
            END ELSE BEGIN
                ItemApplnEntry.RESET();
                ItemApplnEntry.CHANGECOMPANY(BusUnit."Company Name");
                ItemApplnEntry.SETCURRENTKEY("Outbound Item Entry No.", "Item Ledger Entry No.", "Cost Application");
                ItemApplnEntry.SETRANGE("Outbound Item Entry No.", "Entry No.");
                ItemApplnEntry.SETRANGE("Item Ledger Entry No.", "Entry No.");
                ItemApplnEntry.SETRANGE("Cost Application", TRUE);
                IF ItemApplnEntry.FIND('-') THEN
                    REPEAT
                        InsertTempEntry5(ItemApplnEntry."Inbound Item Entry No.", -ItemApplnEntry.Quantity);
                    UNTIL ItemApplnEntry.NEXT() = 0;
            END;
    END;

    LOCAL PROCEDURE InsertTempEntry5(EntryNo: Integer; AppliedQty: Decimal);
    VAR
        ItemLedgEntry: Record 32;
    BEGIN
        ItemLedgEntry.CHANGECOMPANY(BusUnit."Company Name");
        ItemLedgEntry.GET(EntryNo);
        IF AppliedQty * ItemLedgEntry.Quantity < 0 THEN
            EXIT;

        IF NOT TempItemEntry5.GET(EntryNo) THEN BEGIN
            TempItemEntry5.INIT();
            TempItemEntry5 := ItemLedgEntry;
            TempItemEntry5.Quantity := AppliedQty;
            TempItemEntry5.INSERT();
        END ELSE BEGIN
            TempItemEntry5.Quantity := TempItemEntry5.Quantity + AppliedQty;
            TempItemEntry5.MODIFY();
        END;
    END;

    LOCAL PROCEDURE FindAppliedEntry6(ItemLedgEntry: Record 32);
    VAR
        ItemApplnEntry: Record 339;
    BEGIN
        WITH ItemLedgEntry DO
            IF Positive THEN BEGIN
                ItemApplnEntry.RESET();
                ItemApplnEntry.CHANGECOMPANY(BusUnit."Company Name");
                ItemApplnEntry.SETCURRENTKEY("Inbound Item Entry No.", "Outbound Item Entry No.", "Cost Application");
                ItemApplnEntry.SETRANGE("Inbound Item Entry No.", "Entry No.");
                ItemApplnEntry.SETFILTER("Outbound Item Entry No.", '<>%1', 0);
                ItemApplnEntry.SETRANGE("Cost Application", TRUE);
                IF ItemApplnEntry.FIND('-') THEN
                    REPEAT
                        InsertTempEntry6(ItemApplnEntry."Outbound Item Entry No.", ItemApplnEntry.Quantity);
                    UNTIL ItemApplnEntry.NEXT() = 0;
            END ELSE BEGIN
                ItemApplnEntry.RESET();
                ItemApplnEntry.CHANGECOMPANY(BusUnit."Company Name");
                ItemApplnEntry.SETCURRENTKEY("Outbound Item Entry No.", "Item Ledger Entry No.", "Cost Application");
                ItemApplnEntry.SETRANGE("Outbound Item Entry No.", "Entry No.");
                ItemApplnEntry.SETRANGE("Item Ledger Entry No.", "Entry No.");
                ItemApplnEntry.SETRANGE("Cost Application", TRUE);
                IF ItemApplnEntry.FIND('-') THEN
                    REPEAT
                        InsertTempEntry6(ItemApplnEntry."Inbound Item Entry No.", -ItemApplnEntry.Quantity);
                    UNTIL ItemApplnEntry.NEXT() = 0;
            END;
    END;

    LOCAL PROCEDURE InsertTempEntry6(EntryNo: Integer; AppliedQty: Decimal);
    VAR
        ItemLedgEntry: Record 32;
    BEGIN
        ItemLedgEntry.CHANGECOMPANY(BusUnit."Company Name");
        ItemLedgEntry.GET(EntryNo);
        IF AppliedQty * ItemLedgEntry.Quantity < 0 THEN
            EXIT;

        IF NOT TempItemEntry6.GET(EntryNo) THEN BEGIN
            TempItemEntry6.INIT();
            TempItemEntry6 := ItemLedgEntry;
            TempItemEntry6.Quantity := AppliedQty;
            TempItemEntry6.INSERT();
        END ELSE BEGIN
            TempItemEntry6.Quantity := TempItemEntry6.Quantity + AppliedQty;
            TempItemEntry6.MODIFY();
        END;
    END;

    LOCAL PROCEDURE FindAppliedEntry7(ItemLedgEntry: Record 32);
    VAR
        ItemApplnEntry: Record 339;
    BEGIN
        WITH ItemLedgEntry DO
            IF Positive THEN BEGIN
                ItemApplnEntry.RESET();
                ItemApplnEntry.CHANGECOMPANY(BusUnit."Company Name");
                ItemApplnEntry.SETCURRENTKEY("Inbound Item Entry No.", "Outbound Item Entry No.", "Cost Application");
                ItemApplnEntry.SETRANGE("Inbound Item Entry No.", "Entry No.");
                ItemApplnEntry.SETFILTER("Outbound Item Entry No.", '<>%1', 0);
                ItemApplnEntry.SETRANGE("Cost Application", TRUE);
                IF ItemApplnEntry.FIND('-') THEN
                    REPEAT
                        InsertTempEntry7(ItemApplnEntry."Outbound Item Entry No.", ItemApplnEntry.Quantity);
                    UNTIL ItemApplnEntry.NEXT() = 0;
            END ELSE BEGIN
                ItemApplnEntry.RESET();
                ItemApplnEntry.CHANGECOMPANY(BusUnit."Company Name");
                ItemApplnEntry.SETCURRENTKEY("Outbound Item Entry No.", "Item Ledger Entry No.", "Cost Application");
                ItemApplnEntry.SETRANGE("Outbound Item Entry No.", "Entry No.");
                ItemApplnEntry.SETRANGE("Item Ledger Entry No.", "Entry No.");
                ItemApplnEntry.SETRANGE("Cost Application", TRUE);
                IF ItemApplnEntry.FIND('-') THEN
                    REPEAT
                        InsertTempEntry7(ItemApplnEntry."Inbound Item Entry No.", -ItemApplnEntry.Quantity);
                    UNTIL ItemApplnEntry.NEXT() = 0;
            END;
    END;

    LOCAL PROCEDURE InsertTempEntry7(EntryNo: Integer; AppliedQty: Decimal);
    VAR
        ItemLedgEntry: Record 32;
    BEGIN
        ItemLedgEntry.CHANGECOMPANY(BusUnit."Company Name");
        ItemLedgEntry.GET(EntryNo);
        IF AppliedQty * ItemLedgEntry.Quantity < 0 THEN
            EXIT;

        IF NOT TempItemEntry7.GET(EntryNo) THEN BEGIN
            TempItemEntry7.INIT();
            TempItemEntry7 := ItemLedgEntry;
            TempItemEntry7.Quantity := AppliedQty;
            TempItemEntry7.INSERT();
        END ELSE BEGIN
            TempItemEntry7.Quantity := TempItemEntry7.Quantity + AppliedQty;
            TempItemEntry7.MODIFY();
        END;
    END;

    LOCAL PROCEDURE FindAppliedEntry8(ItemLedgEntry: Record 32);
    VAR
        ItemApplnEntry: Record 339;
    BEGIN
        WITH ItemLedgEntry DO
            IF Positive THEN BEGIN
                ItemApplnEntry.RESET();
                ItemApplnEntry.CHANGECOMPANY(BusUnit."Company Name");
                ItemApplnEntry.SETCURRENTKEY("Inbound Item Entry No.", "Outbound Item Entry No.", "Cost Application");
                ItemApplnEntry.SETRANGE("Inbound Item Entry No.", "Entry No.");
                ItemApplnEntry.SETFILTER("Outbound Item Entry No.", '<>%1', 0);
                ItemApplnEntry.SETRANGE("Cost Application", TRUE);
                IF ItemApplnEntry.FIND('-') THEN
                    REPEAT
                        InsertTempEntry8(ItemApplnEntry."Outbound Item Entry No.", ItemApplnEntry.Quantity);
                    UNTIL ItemApplnEntry.NEXT() = 0;
            END ELSE BEGIN
                ItemApplnEntry.RESET();
                ItemApplnEntry.CHANGECOMPANY(BusUnit."Company Name");
                ItemApplnEntry.SETCURRENTKEY("Outbound Item Entry No.", "Item Ledger Entry No.", "Cost Application");
                ItemApplnEntry.SETRANGE("Outbound Item Entry No.", "Entry No.");
                ItemApplnEntry.SETRANGE("Item Ledger Entry No.", "Entry No.");
                ItemApplnEntry.SETRANGE("Cost Application", TRUE);
                IF ItemApplnEntry.FIND('-') THEN
                    REPEAT
                        InsertTempEntry8(ItemApplnEntry."Inbound Item Entry No.", -ItemApplnEntry.Quantity);
                    UNTIL ItemApplnEntry.NEXT() = 0;
            END;
    END;

    LOCAL PROCEDURE InsertTempEntry8(EntryNo: Integer; AppliedQty: Decimal);
    VAR
        ItemLedgEntry: Record 32;
    BEGIN
        ItemLedgEntry.CHANGECOMPANY(BusUnit."Company Name");
        ItemLedgEntry.GET(EntryNo);
        IF AppliedQty * ItemLedgEntry.Quantity < 0 THEN
            EXIT;

        IF NOT TempItemEntry8.GET(EntryNo) THEN BEGIN
            TempItemEntry8.INIT();
            TempItemEntry8 := ItemLedgEntry;
            TempItemEntry8.Quantity := AppliedQty;
            TempItemEntry8.INSERT();
        END ELSE BEGIN
            TempItemEntry8.Quantity := TempItemEntry8.Quantity + AppliedQty;
            TempItemEntry8.MODIFY();
        END;
    END;

    LOCAL PROCEDURE FindAppliedEntry9(ItemLedgEntry: Record 32);
    VAR
        ItemApplnEntry: Record 339;
    BEGIN
        WITH ItemLedgEntry DO
            IF Positive THEN BEGIN
                ItemApplnEntry.RESET();
                ItemApplnEntry.CHANGECOMPANY(BusUnit."Company Name");
                ItemApplnEntry.SETCURRENTKEY("Inbound Item Entry No.", "Outbound Item Entry No.", "Cost Application");
                ItemApplnEntry.SETRANGE("Inbound Item Entry No.", "Entry No.");
                ItemApplnEntry.SETFILTER("Outbound Item Entry No.", '<>%1', 0);
                ItemApplnEntry.SETRANGE("Cost Application", TRUE);
                IF ItemApplnEntry.FIND('-') THEN
                    REPEAT
                        InsertTempEntry9(ItemApplnEntry."Outbound Item Entry No.", ItemApplnEntry.Quantity);
                    UNTIL ItemApplnEntry.NEXT() = 0;
            END ELSE BEGIN
                ItemApplnEntry.RESET();
                ItemApplnEntry.CHANGECOMPANY(BusUnit."Company Name");
                ItemApplnEntry.SETCURRENTKEY("Outbound Item Entry No.", "Item Ledger Entry No.", "Cost Application");
                ItemApplnEntry.SETRANGE("Outbound Item Entry No.", "Entry No.");
                ItemApplnEntry.SETRANGE("Item Ledger Entry No.", "Entry No.");
                ItemApplnEntry.SETRANGE("Cost Application", TRUE);
                IF ItemApplnEntry.FIND('-') THEN
                    REPEAT
                        InsertTempEntry9(ItemApplnEntry."Inbound Item Entry No.", -ItemApplnEntry.Quantity);
                    UNTIL ItemApplnEntry.NEXT() = 0;
            END;
    END;

    LOCAL PROCEDURE InsertTempEntry9(EntryNo: Integer; AppliedQty: Decimal);
    VAR
        ItemLedgEntry: Record 32;
    BEGIN
        ItemLedgEntry.CHANGECOMPANY(BusUnit."Company Name");
        ItemLedgEntry.GET(EntryNo);
        IF AppliedQty * ItemLedgEntry.Quantity < 0 THEN
            EXIT;

        IF NOT TempItemEntry9.GET(EntryNo) THEN BEGIN
            TempItemEntry9.INIT();
            TempItemEntry9 := ItemLedgEntry;
            TempItemEntry9.Quantity := AppliedQty;
            TempItemEntry9.INSERT();
        END ELSE BEGIN
            TempItemEntry9.Quantity := TempItemEntry9.Quantity + AppliedQty;
            TempItemEntry9.MODIFY();
        END;
    END;

    LOCAL PROCEDURE FindAppliedEntry10(ItemLedgEntry: Record 32);
    VAR
        ItemApplnEntry: Record 339;
    BEGIN
        WITH ItemLedgEntry DO
            IF Positive THEN BEGIN
                ItemApplnEntry.RESET();
                ItemApplnEntry.CHANGECOMPANY(BusUnit."Company Name");
                ItemApplnEntry.SETCURRENTKEY("Inbound Item Entry No.", "Outbound Item Entry No.", "Cost Application");
                ItemApplnEntry.SETRANGE("Inbound Item Entry No.", "Entry No.");
                ItemApplnEntry.SETFILTER("Outbound Item Entry No.", '<>%1', 0);
                ItemApplnEntry.SETRANGE("Cost Application", TRUE);
                IF ItemApplnEntry.FIND('-') THEN
                    REPEAT
                        InsertTempEntry10(ItemApplnEntry."Outbound Item Entry No.", ItemApplnEntry.Quantity);
                    UNTIL ItemApplnEntry.NEXT() = 0;
            END ELSE BEGIN
                ItemApplnEntry.RESET();
                ItemApplnEntry.CHANGECOMPANY(BusUnit."Company Name");
                ItemApplnEntry.SETCURRENTKEY("Outbound Item Entry No.", "Item Ledger Entry No.", "Cost Application");
                ItemApplnEntry.SETRANGE("Outbound Item Entry No.", "Entry No.");
                ItemApplnEntry.SETRANGE("Item Ledger Entry No.", "Entry No.");
                ItemApplnEntry.SETRANGE("Cost Application", TRUE);
                IF ItemApplnEntry.FIND('-') THEN
                    REPEAT
                        InsertTempEntry10(ItemApplnEntry."Inbound Item Entry No.", -ItemApplnEntry.Quantity);
                    UNTIL ItemApplnEntry.NEXT() = 0;
            END;
    END;

    LOCAL PROCEDURE InsertTempEntry10(EntryNo: Integer; AppliedQty: Decimal);
    VAR
        ItemLedgEntry: Record 32;
    BEGIN
        ItemLedgEntry.CHANGECOMPANY(BusUnit."Company Name");
        ItemLedgEntry.GET(EntryNo);
        IF AppliedQty * ItemLedgEntry.Quantity < 0 THEN
            EXIT;

        IF NOT TempItemEntry10.GET(EntryNo) THEN BEGIN
            TempItemEntry10.INIT();
            TempItemEntry10 := ItemLedgEntry;
            TempItemEntry10.Quantity := AppliedQty;
            TempItemEntry10.INSERT();
        END ELSE BEGIN
            TempItemEntry10.Quantity := TempItemEntry10.Quantity + AppliedQty;
            TempItemEntry10.MODIFY();
        END;
    END;

    LOCAL PROCEDURE GetInvoiceDate(LocalILE: Record 32): Boolean;
    VAR
        ValueEntry: Record 5802;
    BEGIN
        //>>CIS.RAM
        //15139141
        ValueEntry.RESET();
        ValueEntry.CHANGECOMPANY(BusUnit."Company Name");
        ValueEntry.SETRANGE("Item Ledger Entry No.", LocalILE."Entry No.");
        ValueEntry.SETRANGE("Item No.", LocalILE."Item No.");
        ValueEntry.SETFILTER("Invoiced Quantity", '<>%1', 0);
        //ValueEntry.SETRANGE("Source Code",ParentCompanyOriginalEntry."Source Code");
        IF ValueEntry.FINDFIRST() THEN BEGIN
            //ERROR('%1',ValueEntry."Posting Date");
            InvoiceDate := ValueEntry."Posting Date";
            EXIT(TRUE);
        END ELSE BEGIN
            //ERROR('%1',ValueEntry."Posting Date");
            EXIT(FALSE);
        END;
        //<<CIS.RAM
    END;

    LOCAL PROCEDURE GetFrtInvoiceDate(LocalILE: Record 32): Boolean;
    VAR
        ValueEntry: Record 5802;
    BEGIN
        //>>CIS.RAM
        //15139141
        ValueEntry.RESET();
        ValueEntry.CHANGECOMPANY(BusUnit."Company Name");
        ValueEntry.SETRANGE("Item Ledger Entry No.", LocalILE."Entry No.");
        //ValueEntry.SETRANGE("Item No.",LocalILE."Item No.");
        //ValueEntry.SETFILTER("Invoiced Quantity",'<>%1',0);
        //ValueEntry.SETRANGE("Document Type",ValueEntry."Document Type"::"Purchase Invoice");
        ValueEntry.SETFILTER(ValueEntry."Item Charge No.", '<>%1', '');
        //ValueEntry.SETRANGE("Source Code",ParentCompanyOriginalEntry."Source Code");
        IF ValueEntry.FINDFIRST() THEN BEGIN
            //ERROR('%1',ValueEntry."Posting Date");
            InvoiceDate := ValueEntry."Posting Date";
            EXIT(TRUE);
        END ELSE BEGIN
            ValueEntry.RESET();
            ValueEntry.CHANGECOMPANY(BusUnit."Company Name");
            ValueEntry.SETRANGE("Item Ledger Entry No.", LocalILE."Entry No.");
            //ValueEntry.SETRANGE("Item No.",LocalILE."Item No.");
            //ValueEntry.SETFILTER("Invoiced Quantity",'<>%1',0);
            ValueEntry.SETFILTER("Document Type", '%1|%2|3', ValueEntry."Document Type"::"Purchase Invoice",
               ValueEntry."Document Type"::"Purchase Credit Memo", ValueEntry."Document Type"::"Sales Credit Memo");
            IF ValueEntry.FINDFIRST() THEN BEGIN
                //ERROR('%1',ValueEntry."Posting Date");
                InvoiceDate := ValueEntry."Posting Date";
                EXIT(TRUE);
            END ELSE
                EXIT(FALSE);
        END;
        //<<CIS.RAM
    END;

    PROCEDURE ForexRestate(Sdate: Date; Edate: Date): Integer;
    VAR
        GLSetup: Record 98;
        DetailedCustLedgEntry: Record 379;
        DetailedVendLedgEntry: Record 380;
        TempDetailedCustLedgEntry: Record 379 temporary;
        TempDetailedVendLedgEntry:  Record 380 TEMPORARY;
        NextEntryNo: Integer;
    BEGIN
        //>>CIS.RAM
        BusUnit.GET('NICA');
        GLSetup.GET();
        NextEntryNo := 0;
        IF TempSubsidGLEntry.FINDLAST THEN
            NextEntryNo := TempSubsidGLEntry."Entry No.";

        TempDetailedCustLedgEntry.RESET();
        TempDetailedCustLedgEntry.DELETEALL();
        TempDetailedVendLedgEntry.RESET;
        TempDetailedVendLedgEntry.DELETEALL;
        ParentCompanyOriginalEntry.RESET();
        ParentCompanyOriginalEntry.CHANGECOMPANY(BusUnit."Company Name");
        ParentCompanyOriginalEntry.SETRANGE("Source Code", 'EXCHRATADJ');
        ParentCompanyOriginalEntry.SETRANGE("Posting Date", Sdate, Edate);
        ParentCompanyOriginalEntry.SETFILTER("G/L Account No.", '%1|%2|%3', '129', '310', '311');
        IF ParentCompanyOriginalEntry.FINDSET() THEN
            REPEAT
                DetailedCustLedgEntry.RESET();
                DetailedCustLedgEntry.CHANGECOMPANY(BusUnit."Company Name");
                DetailedCustLedgEntry.SETRANGE("Posting Date", ParentCompanyOriginalEntry."Posting Date");
                DetailedCustLedgEntry.SETRANGE("Document No.", ParentCompanyOriginalEntry."Document No.");
                DetailedCustLedgEntry.SETFILTER("Currency Code", '<>%1', GLSetup."LCY Code");
                IF DetailedCustLedgEntry.FINDSET() THEN
                    REPEAT
                        TempDetailedCustLedgEntry.RESET();
                        IF NOT TempDetailedCustLedgEntry.GET(DetailedCustLedgEntry."Entry No.") THEN BEGIN
                            TempDetailedCustLedgEntry := DetailedCustLedgEntry;
                            TempDetailedCustLedgEntry.INSERT();
                            NextEntryNo += 1;
                            TempSubsidGLEntry.INIT;
                            TempSubsidGLEntry."Entry No." := NextEntryNo;
                            TempSubsidGLEntry."G/L Account No." := ParentCompanyOriginalEntry."G/L Account No.";
                            TempSubsidGLEntry."Document No." := ParentCompanyOriginalEntry."Document No.";
                            TempSubsidGLEntry."Document Type" := ParentCompanyOriginalEntry."Document Type";
                            TempSubsidGLEntry."Posting Date" := ParentCompanyOriginalEntry."Posting Date";
                            TempSubsidGLEntry."Debit Amount" := DetailedCustLedgEntry."Debit Amount (LCY)";
                            TempSubsidGLEntry."Credit Amount" := DetailedCustLedgEntry."Credit Amount (LCY)";
                            //>>04/29/18
                            TempSubsidGLEntry."Original Entry No." := ParentCompanyOriginalEntry."Entry No.";
                            TempSubsidGLEntry."Original Transaction No." := ParentCompanyOriginalEntry."Transaction No.";

                            //<<04/29/18
                            //TempSubsidGLEntry."Add.-Currency Debit Amount" := ParentCompanyOriginalEntry."Add.-Currency Debit Amount";
                            //TempSubsidGLEntry."Add.-Currency Credit Amount" := ParentCompanyOriginalEntry."Add.-Currency Credit Amount";

                            //IF TempSubsidGLEntry."Document No." = 'PSIV284227' THEN BEGIN
                            //  IF NOT CONFIRM('Do you want to debug?') THEN
                            //    ERROR('Break');
                            //END;


                            IF (TempSubsidGLEntry."Debit Amount" <> 0) OR (TempSubsidGLEntry."Credit Amount" <> 0) THEN
                                TempSubsidGLEntry.INSERT
                            ELSE
                                NextEntryNo -= 1;
                        END;
                    UNTIL DetailedCustLedgEntry.NEXT() = 0;

                DetailedVendLedgEntry.RESET();
                DetailedVendLedgEntry.CHANGECOMPANY(BusUnit."Company Name");
                DetailedVendLedgEntry.SETRANGE("Posting Date", ParentCompanyOriginalEntry."Posting Date");
                DetailedVendLedgEntry.SETRANGE("Document No.", ParentCompanyOriginalEntry."Document No.");
                DetailedVendLedgEntry.SETFILTER("Currency Code", '<>%1', GLSetup."LCY Code");
                IF DetailedVendLedgEntry.FINDSET() THEN
                    REPEAT
                        TempDetailedVendLedgEntry.RESET;
                        IF NOT TempDetailedVendLedgEntry.GET(DetailedVendLedgEntry."Entry No.") THEN BEGIN
                            TempDetailedVendLedgEntry := DetailedVendLedgEntry;
                            TempDetailedVendLedgEntry.INSERT;

                            NextEntryNo += 1;
                            TempSubsidGLEntry.INIT;
                            TempSubsidGLEntry."Entry No." := NextEntryNo;
                            TempSubsidGLEntry."G/L Account No." := ParentCompanyOriginalEntry."G/L Account No.";
                            TempSubsidGLEntry."Document No." := ParentCompanyOriginalEntry."Document No.";
                            TempSubsidGLEntry."Document Type" := ParentCompanyOriginalEntry."Document Type";
                            TempSubsidGLEntry."Posting Date" := ParentCompanyOriginalEntry."Posting Date";
                            TempSubsidGLEntry."Debit Amount" := DetailedVendLedgEntry."Debit Amount (LCY)";
                            TempSubsidGLEntry."Credit Amount" := DetailedVendLedgEntry."Credit Amount (LCY)";
                            //TempSubsidGLEntry."Add.-Currency Debit Amount" := ParentCompanyOriginalEntry."Add.-Currency Debit Amount";
                            //TempSubsidGLEntry."Add.-Currency Credit Amount" := ParentCompanyOriginalEntry."Add.-Currency Credit Amount";
                            //>>Ram 04/29/18
                            TempSubsidGLEntry."Original Entry No." := ParentCompanyOriginalEntry."Entry No.";
                            TempSubsidGLEntry."Original Transaction No." := ParentCompanyOriginalEntry."Transaction No.";

                            //<<04/29/18

                            //IF TempSubsidGLEntry."Document No." = 'PSIV284227' THEN BEGIN
                            //  IF NOT CONFIRM('Do you want to debug?') THEN
                            //    ERROR('Break');
                            //END;

                            IF (TempSubsidGLEntry."Debit Amount" <> 0) OR (TempSubsidGLEntry."Credit Amount" <> 0) THEN
                                TempSubsidGLEntry.INSERT
                            ELSE
                                NextEntryNo -= 1;
                        END;
                    UNTIL DetailedVendLedgEntry.NEXT() = 0;
            UNTIL ParentCompanyOriginalEntry.NEXT() = 0;

        ForexRestateAR(Sdate, Edate);
        ForexRestateAP(Sdate, Edate);
        ForexRestateBank(Sdate, Edate);
        EXIT(NextEntryNo);
        //<<CIS.RAM
    END;

    LOCAL PROCEDURE ForexRestateAR(Sdate: Date; Edate: Date);
    VAR
        CustLedgEntry: Record 21;
        CustomerPostingGroup: Record 92;
        FromCurrExchRate: Record 330;
        ToCurrExchRate: Record 330;
        EOMAmount: Decimal;
        OriginalAmount: Decimal;
        NextEntryNo: Integer;
    BEGIN
        //>>CIS.RAM
        BusUnit.GET('NICA');
        NextEntryNo := 0;
        IF TempSubsidGLEntry.FINDLAST THEN
            NextEntryNo := TempSubsidGLEntry."Entry No.";

        CustLedgEntry.RESET();
        CustLedgEntry.CHANGECOMPANY(BusUnit."Company Name");
        CustLedgEntry.SETFILTER("Posting Date", '..%1', Edate);
        CustLedgEntry.SETFILTER("Currency Code", '%1|%2', 'CAD', '');
        CustLedgEntry.SETRANGE("Date Filter", 0D, Edate);
        //CustLedgEntry.SETRANGE(Open,TRUE);
        //CustLedgEntry.SETFILTER("Remaining Amount",'<>0');
        IF CustLedgEntry.FINDSET() THEN
            REPEAT
                //Original Date Valuation
                CustLedgEntry.CALCFIELDS("Remaining Amount");
                IF CustLedgEntry."Remaining Amount" <> 0 THEN BEGIN
                    CustomerPostingGroup.RESET();
                    CustomerPostingGroup.CHANGECOMPANY(BusUnit."Company Name");
                    CustomerPostingGroup.GET(CustLedgEntry."Customer Posting Group");

                    OriginalAmount := 0;
                    FromCurrExchRate.RESET();
                    FromCurrExchRate.CHANGECOMPANY(BusUnit."Company Name");
                    FromCurrExchRate.SETRANGE("Currency Code", 'USD');
                    FromCurrExchRate.SETFILTER("Starting Date", '..%1', CustLedgEntry."Posting Date");
                    FromCurrExchRate.FINDLAST();
                    OriginalAmount := CustLedgEntry."Remaining Amount" / FromCurrExchRate."Relational Exch. Rate Amount";

                    //End Date Valuation
                    EOMAmount := 0;
                    ToCurrExchRate.RESET();
                    ToCurrExchRate.CHANGECOMPANY(BusUnit."Company Name");
                    ToCurrExchRate.SETRANGE("Currency Code", 'USD');
                    ToCurrExchRate.SETFILTER("Starting Date", '..%1', Edate);
                    ToCurrExchRate.FINDLAST();
                    EOMAmount := CustLedgEntry."Remaining Amount" / ToCurrExchRate."Relational Exch. Rate Amount";

                    //Gain/Loss in USD
                    EOMAmount := OriginalAmount - EOMAmount;

                    //Gain/Loss in CAD
                    EOMAmount := EOMAmount * ToCurrExchRate."Relational Exch. Rate Amount";

                    NextEntryNo := NextEntryNo + 1;
                    TempSubsidGLEntry.INIT;
                    TempSubsidGLEntry."Entry No." := NextEntryNo;
                    TempSubsidGLEntry."Document No." := 'FOREX RESTAT ' + DELCHR(FORMAT(Edate), '=', '/');
                    TempSubsidGLEntry."Posting Date" := Edate;
                    IF EOMAmount < 0 THEN BEGIN
                        TempSubsidGLEntry."G/L Account No." := '938';
                        TempSubsidGLEntry."Debit Amount" := EOMAmount;
                        TempSubsidGLEntry."Add.-Currency Debit Amount" := EOMAmount / ToCurrExchRate."Relational Exch. Rate Amount";
                    END ELSE BEGIN
                        TempSubsidGLEntry."G/L Account No." := '947';
                        TempSubsidGLEntry."Credit Amount" := EOMAmount;
                        TempSubsidGLEntry."Add.-Currency Credit Amount" := EOMAmount / ToCurrExchRate."Relational Exch. Rate Amount";
                    END;

                    //IF TempSubsidGLEntry."Document No." = 'PSIV284227' THEN BEGIN
                    //  IF NOT CONFIRM('Do you want to debug?') THEN
                    //    ERROR('Break');
                    //END;

                    IF (TempSubsidGLEntry."Debit Amount" <> 0) OR (TempSubsidGLEntry."Credit Amount" <> 0) THEN
                        TempSubsidGLEntry.INSERT
                    ELSE
                        NextEntryNo -= 1;

                    //Balancing Entry
                    NextEntryNo := NextEntryNo + 1;
                    TempSubsidGLEntry.INIT;
                    TempSubsidGLEntry."Entry No." := NextEntryNo;
                    TempSubsidGLEntry."Document No." := 'FOREX RESTAT ' + DELCHR(FORMAT(Edate), '=', '/');
                    TempSubsidGLEntry."Posting Date" := Edate;
                    IF EOMAmount < 0 THEN BEGIN
                        TempSubsidGLEntry."G/L Account No." := CustomerPostingGroup."Receivables Account"; //'937';
                        TempSubsidGLEntry."Debit Amount" := -EOMAmount;
                        TempSubsidGLEntry."Add.-Currency Debit Amount" := -EOMAmount / ToCurrExchRate."Relational Exch. Rate Amount";
                    END ELSE BEGIN
                        TempSubsidGLEntry."G/L Account No." := CustomerPostingGroup."Receivables Account";  //938
                        TempSubsidGLEntry."Credit Amount" := -EOMAmount;
                        TempSubsidGLEntry."Add.-Currency Credit Amount" := -EOMAmount / ToCurrExchRate."Relational Exch. Rate Amount";
                    END;


                    //IF TempSubsidGLEntry."Document No." = 'PSIV284227' THEN BEGIN
                    //  IF NOT CONFIRM('Do you want to debug?') THEN
                    //    ERROR('Break');
                    //END;

                    IF (TempSubsidGLEntry."Debit Amount" <> 0) OR (TempSubsidGLEntry."Credit Amount" <> 0) THEN
                        TempSubsidGLEntry.INSERT;

                    //Reversal Entry
                    NextEntryNo := NextEntryNo + 1;
                    TempSubsidGLEntry.INIT;
                    TempSubsidGLEntry."Entry No." := NextEntryNo;
                    TempSubsidGLEntry."Document No." := 'FOREX REVERS ' + DELCHR(FORMAT(CALCDATE('+1D', Edate)), '=', '/');
                    TempSubsidGLEntry."Posting Date" := CALCDATE('+1D', Edate);
                    IF EOMAmount < 0 THEN BEGIN
                        TempSubsidGLEntry."G/L Account No." := '938'; //'937';
                        TempSubsidGLEntry."Debit Amount" := -EOMAmount;
                        TempSubsidGLEntry."Add.-Currency Debit Amount" := -EOMAmount / ToCurrExchRate."Relational Exch. Rate Amount";
                    END ELSE BEGIN
                        TempSubsidGLEntry."G/L Account No." := '947';  //'948';
                        TempSubsidGLEntry."Credit Amount" := -EOMAmount;
                        TempSubsidGLEntry."Add.-Currency Credit Amount" := -EOMAmount / ToCurrExchRate."Relational Exch. Rate Amount";
                    END;

                    //IF TempSubsidGLEntry."Document No." = 'PSIV284227' THEN BEGIN
                    //  IF NOT CONFIRM('Do you want to debug?') THEN
                    //    ERROR('Break');
                    //END;

                    IF (TempSubsidGLEntry."Debit Amount" <> 0) OR (TempSubsidGLEntry."Credit Amount" <> 0) THEN
                        TempSubsidGLEntry.INSERT
                    ELSE
                        NextEntryNo -= 1;

                    //Balancing Reversal Entry
                    NextEntryNo := NextEntryNo + 1;
                    TempSubsidGLEntry.INIT;
                    TempSubsidGLEntry."Entry No." := NextEntryNo;
                    TempSubsidGLEntry."Document No." := 'FOREX REVERS ' + DELCHR(FORMAT(CALCDATE('+1D', Edate)), '=', '/');
                    TempSubsidGLEntry."Posting Date" := CALCDATE('+1D', Edate);
                    IF EOMAmount < 0 THEN BEGIN
                        TempSubsidGLEntry."G/L Account No." := CustomerPostingGroup."Receivables Account";  //'947';
                        TempSubsidGLEntry."Debit Amount" := EOMAmount;
                        TempSubsidGLEntry."Add.-Currency Debit Amount" := EOMAmount / ToCurrExchRate."Relational Exch. Rate Amount";
                    END ELSE BEGIN
                        TempSubsidGLEntry."G/L Account No." := CustomerPostingGroup."Receivables Account";  //'938';
                        TempSubsidGLEntry."Credit Amount" := EOMAmount;
                        TempSubsidGLEntry."Add.-Currency Credit Amount" := EOMAmount / ToCurrExchRate."Relational Exch. Rate Amount";
                    END;

                    //IF TempSubsidGLEntry."Document No." = 'PSIV284227' THEN BEGIN
                    //  IF NOT CONFIRM('Do you want to debug?') THEN
                    //    ERROR('Break');
                    //END;

                    IF (TempSubsidGLEntry."Debit Amount" <> 0) OR (TempSubsidGLEntry."Credit Amount" <> 0) THEN
                        TempSubsidGLEntry.INSERT
                    ELSE
                        NextEntryNo -= 1;
                END;
            UNTIL CustLedgEntry.NEXT() = 0;
        //<<CIS.RAM
    END;

    LOCAL PROCEDURE ForexRestateAP(Sdate: Date; Edate: Date);
    VAR
        VendLedgEntry: Record 25;
        VendorPostingGroup: Record 93;
        FromCurrExchRate: Record 330;
        ToCurrExchRate: Record 330;
        EOMAmount: Decimal;
        OriginalAmount: Decimal;
        NextEntryNo: Integer;
    BEGIN
        //>>CIS.RAM
        BusUnit.GET('NICA');
        NextEntryNo := 0;
        IF TempSubsidGLEntry.FINDLAST THEN
            NextEntryNo := TempSubsidGLEntry."Entry No.";

        VendLedgEntry.RESET();
        VendLedgEntry.CHANGECOMPANY(BusUnit."Company Name");
        VendLedgEntry.SETFILTER("Posting Date", '..%1', Edate);
        VendLedgEntry.SETFILTER("Currency Code", '%1|%2', 'CAD', '');
        VendLedgEntry.SETRANGE("Date Filter", 0D, Edate);
        //VendLedgEntry.SETRANGE(Open,TRUE);
        //VendLedgEntry.SETFILTER("Remaining Amount",'<>0');
        IF VendLedgEntry.FINDSET() THEN BEGIN
            REPEAT
                //Original Date Valuation
                VendLedgEntry.CALCFIELDS("Remaining Amount");
                IF VendLedgEntry."Remaining Amount" <> 0 THEN BEGIN
                    VendorPostingGroup.RESET();
                    VendorPostingGroup.CHANGECOMPANY(BusUnit."Company Name");
                    VendorPostingGroup.GET(VendLedgEntry."Vendor Posting Group");

                    OriginalAmount := 0;
                    FromCurrExchRate.RESET();
                    FromCurrExchRate.CHANGECOMPANY(BusUnit."Company Name");
                    FromCurrExchRate.SETRANGE("Currency Code", 'USD');
                    FromCurrExchRate.SETFILTER("Starting Date", '..%1', VendLedgEntry."Posting Date");
                    FromCurrExchRate.FINDLAST();
                    OriginalAmount := VendLedgEntry."Remaining Amount" / FromCurrExchRate."Relational Exch. Rate Amount";

                    //End Date Valuation
                    EOMAmount := 0;
                    ToCurrExchRate.RESET();
                    ToCurrExchRate.CHANGECOMPANY(BusUnit."Company Name");
                    ToCurrExchRate.SETRANGE("Currency Code", 'USD');
                    ToCurrExchRate.SETFILTER("Starting Date", '..%1', Edate);
                    ToCurrExchRate.FINDLAST();
                    EOMAmount := VendLedgEntry."Remaining Amount" / ToCurrExchRate."Relational Exch. Rate Amount";

                    //Gain/Loss in USD
                    EOMAmount := OriginalAmount - EOMAmount;

                    //Gain/Loss in CAD
                    EOMAmount := EOMAmount * ToCurrExchRate."Relational Exch. Rate Amount";

                    NextEntryNo += 1;
                    TempSubsidGLEntry.INIT;
                    TempSubsidGLEntry."Entry No." := NextEntryNo;
                    TempSubsidGLEntry."Document No." := 'FOREX RESTAT ' + DELCHR(FORMAT(Edate), '=', '/');
                    TempSubsidGLEntry."Posting Date" := Edate;
                    IF EOMAmount < 0 THEN BEGIN
                        TempSubsidGLEntry."G/L Account No." := '938';
                        TempSubsidGLEntry."Debit Amount" := EOMAmount;
                        TempSubsidGLEntry."Add.-Currency Debit Amount" := EOMAmount / ToCurrExchRate."Relational Exch. Rate Amount";
                    END ELSE BEGIN
                        TempSubsidGLEntry."G/L Account No." := '947';
                        TempSubsidGLEntry."Credit Amount" := EOMAmount;
                        TempSubsidGLEntry."Add.-Currency Credit Amount" := EOMAmount / ToCurrExchRate."Relational Exch. Rate Amount";
                    END;

                    //There will not be any original entry as these are generated afresh.
                    //TempSubsidGLEntry."Original Entry No." := ParentCompanyOriginalEntry."Entry No.";
                    //TempSubsidGLEntry."Original Transaction No." := ParentCompanyOriginalEntry."Transaction No.";

                    //IF TempSubsidGLEntry."Document No." = 'PSIV284227' THEN BEGIN
                    //  IF NOT CONFIRM('Do you want to debug?') THEN
                    //    ERROR('Break');
                    //END;

                    IF (TempSubsidGLEntry."Debit Amount" <> 0) OR (TempSubsidGLEntry."Credit Amount" <> 0) THEN
                        TempSubsidGLEntry.INSERT
                    ELSE
                        NextEntryNo -= 1;

                    //Balancing Entry
                    NextEntryNo += 1;
                    TempSubsidGLEntry.INIT;
                    TempSubsidGLEntry."Entry No." := NextEntryNo;
                    TempSubsidGLEntry."Document No." := 'FOREX RESTAT ' + DELCHR(FORMAT(Edate), '=', '/');
                    TempSubsidGLEntry."Posting Date" := Edate; //CALCDATE('+1D',Edate);
                    IF EOMAmount < 0 THEN BEGIN
                        TempSubsidGLEntry."G/L Account No." := VendorPostingGroup."Payables Account"; //'310';
                        TempSubsidGLEntry."Debit Amount" := -EOMAmount;
                        TempSubsidGLEntry."Add.-Currency Debit Amount" := -EOMAmount / ToCurrExchRate."Relational Exch. Rate Amount";
                    END ELSE BEGIN
                        TempSubsidGLEntry."G/L Account No." := VendorPostingGroup."Payables Account"; //'310';
                        TempSubsidGLEntry."Credit Amount" := -EOMAmount;
                        TempSubsidGLEntry."Add.-Currency Credit Amount" := -EOMAmount / ToCurrExchRate."Relational Exch. Rate Amount";
                    END;

                    //There will not be any original entry as these are generated afresh.
                    //TempSubsidGLEntry."Original Entry No." := ParentCompanyOriginalEntry."Entry No.";
                    //TempSubsidGLEntry."Original Transaction No." := ParentCompanyOriginalEntry."Transaction No.";

                    //IF TempSubsidGLEntry."Document No." = 'PSIV284227' THEN BEGIN
                    //  IF NOT CONFIRM('Do you want to debug?') THEN
                    //    ERROR('Break');
                    //END;

                    IF (TempSubsidGLEntry."Debit Amount" <> 0) OR (TempSubsidGLEntry."Credit Amount" <> 0) THEN
                        TempSubsidGLEntry.INSERT
                    ELSE
                        NextEntryNo -= 1;

                    //Reversal Entry
                    NextEntryNo += 1;
                    TempSubsidGLEntry.INIT;
                    TempSubsidGLEntry."Entry No." := NextEntryNo;
                    TempSubsidGLEntry."Document No." := 'FOREX REVERS ' + DELCHR(FORMAT(CALCDATE('+1D', Edate)), '=', '/');
                    TempSubsidGLEntry."Posting Date" := CALCDATE('+1D', Edate);
                    IF EOMAmount < 0 THEN BEGIN
                        TempSubsidGLEntry."G/L Account No." := '938';
                        TempSubsidGLEntry."Debit Amount" := EOMAmount;
                        TempSubsidGLEntry."Add.-Currency Debit Amount" := EOMAmount / ToCurrExchRate."Relational Exch. Rate Amount";
                    END ELSE BEGIN
                        TempSubsidGLEntry."G/L Account No." := '947';
                        TempSubsidGLEntry."Credit Amount" := EOMAmount;
                        TempSubsidGLEntry."Add.-Currency Credit Amount" := EOMAmount / ToCurrExchRate."Relational Exch. Rate Amount";
                    END;
                    //There will not be any original entry as these are generated afresh.
                    //TempSubsidGLEntry."Original Entry No." := ParentCompanyOriginalEntry."Entry No.";
                    //TempSubsidGLEntry."Original Transaction No." := ParentCompanyOriginalEntry."Transaction No.";

                    //IF TempSubsidGLEntry."Document No." = 'PSIV284227' THEN BEGIN
                    //  IF NOT CONFIRM('Do you want to debug?') THEN
                    //    ERROR('Break');
                    //END;

                    IF (TempSubsidGLEntry."Debit Amount" <> 0) OR (TempSubsidGLEntry."Credit Amount" <> 0) THEN
                        TempSubsidGLEntry.INSERT
                    ELSE
                        NextEntryNo -= 1;

                    //Balancing Entry
                    NextEntryNo += 1;
                    TempSubsidGLEntry.INIT;
                    TempSubsidGLEntry."Entry No." := NextEntryNo;
                    TempSubsidGLEntry."Document No." := 'FOREX REVERS ' + DELCHR(FORMAT(CALCDATE('+1D', Edate)), '=', '/');
                    TempSubsidGLEntry."Posting Date" := CALCDATE('+1D', Edate);
                    IF EOMAmount < 0 THEN BEGIN
                        TempSubsidGLEntry."G/L Account No." := VendorPostingGroup."Payables Account"; //'310';
                        TempSubsidGLEntry."Debit Amount" := -EOMAmount;
                        TempSubsidGLEntry."Add.-Currency Debit Amount" := -EOMAmount / ToCurrExchRate."Relational Exch. Rate Amount";
                    END ELSE BEGIN
                        TempSubsidGLEntry."G/L Account No." := VendorPostingGroup."Payables Account"; //'310';
                        TempSubsidGLEntry."Credit Amount" := -EOMAmount;
                        TempSubsidGLEntry."Add.-Currency Credit Amount" := -EOMAmount / ToCurrExchRate."Relational Exch. Rate Amount";
                    END;
                    //There will not be any original entry as these are generated afresh.
                    //TempSubsidGLEntry."Original Entry No." := ParentCompanyOriginalEntry."Entry No.";
                    //TempSubsidGLEntry."Original Transaction No." := ParentCompanyOriginalEntry."Transaction No.";

                    //IF TempSubsidGLEntry."Document No." = 'PSIV284227' THEN BEGIN
                    //  IF NOT CONFIRM('Do you want to debug?') THEN
                    //    ERROR('Break');
                    //END;

                    IF (TempSubsidGLEntry."Debit Amount" <> 0) OR (TempSubsidGLEntry."Credit Amount" <> 0) THEN
                        TempSubsidGLEntry.INSERT
                    ELSE
                        NextEntryNo -= 1;
                END;
            UNTIL VendLedgEntry.NEXT() = 0;
        END;
        //<<CIS.RAM
    END;

    LOCAL PROCEDURE ForexRestateBank(Sdate: Date; Edate: Date): Integer;
    VAR
        BankAcctLedgerEntry: Record 271;
        BankAccPostingGroup: Record 277;
        FromCurrExchRate: Record 330;
        ToCurrExchRate: Record 330;
        EOMAmount: Decimal;
        OriginalAmount: Decimal;
        NextEntryNo: Integer;
    BEGIN
        //>>CIS.RAM
        BusUnit.GET('NICA');
        NextEntryNo := 0;
        IF TempSubsidGLEntry.FINDLAST THEN
            NextEntryNo := TempSubsidGLEntry."Entry No.";

        BankAcctLedgerEntry.RESET();
        BankAcctLedgerEntry.CHANGECOMPANY(BusUnit."Company Name");
        BankAcctLedgerEntry.SETFILTER("Posting Date", '%1..%2', Sdate, Edate);
        BankAcctLedgerEntry.SETFILTER("Currency Code", '%1|%2', 'CAD', '');
        BankAcctLedgerEntry.SETFILTER("Remaining Amount", '<>0');
        IF BankAcctLedgerEntry.FINDSET() THEN
            REPEAT
                BankAccPostingGroup.RESET();
                BankAccPostingGroup.CHANGECOMPANY(BusUnit."Company Name");
                BankAccPostingGroup.GET(BankAcctLedgerEntry."Bank Acc. Posting Group");

                //Original Date Valuation
                OriginalAmount := 0;
                FromCurrExchRate.RESET();
                FromCurrExchRate.CHANGECOMPANY(BusUnit."Company Name");
                FromCurrExchRate.SETRANGE("Currency Code", 'USD');
                FromCurrExchRate.SETFILTER("Starting Date", '..%1', BankAcctLedgerEntry."Posting Date");
                FromCurrExchRate.FINDLAST();
                OriginalAmount := BankAcctLedgerEntry."Remaining Amount" / FromCurrExchRate."Relational Exch. Rate Amount";

                //End Date Valuation
                EOMAmount := 0;
                ToCurrExchRate.RESET();
                ToCurrExchRate.CHANGECOMPANY(BusUnit."Company Name");
                ToCurrExchRate.SETRANGE("Currency Code", 'USD');
                ToCurrExchRate.SETFILTER("Starting Date", '..%1', Edate);
                ToCurrExchRate.FINDLAST();
                EOMAmount := BankAcctLedgerEntry."Remaining Amount" / ToCurrExchRate."Relational Exch. Rate Amount";

                //Gain/Loss in USD
                EOMAmount := OriginalAmount - EOMAmount;

                //Gain/Loss in CAD
                EOMAmount := EOMAmount * ToCurrExchRate."Relational Exch. Rate Amount";

                NextEntryNo += 1;
                TempSubsidGLEntry.INIT;
                TempSubsidGLEntry."Entry No." := NextEntryNo;
                TempSubsidGLEntry."Document No." := 'FOREX RESTAT ' + DELCHR(FORMAT(Edate), '=', '/');
                TempSubsidGLEntry."Posting Date" := Edate;
                IF EOMAmount < 0 THEN BEGIN
                    TempSubsidGLEntry."G/L Account No." := '938';
                    TempSubsidGLEntry."Debit Amount" := EOMAmount;
                    TempSubsidGLEntry."Add.-Currency Debit Amount" := EOMAmount / ToCurrExchRate."Relational Exch. Rate Amount";
                END ELSE BEGIN
                    TempSubsidGLEntry."G/L Account No." := '947';
                    TempSubsidGLEntry."Credit Amount" := EOMAmount;
                    TempSubsidGLEntry."Add.-Currency Credit Amount" := EOMAmount / ToCurrExchRate."Relational Exch. Rate Amount";
                END;
                //There will not be any original entry as these are generated afresh.
                //TempSubsidGLEntry."Original Entry No." := ParentCompanyOriginalEntry."Entry No.";
                //TempSubsidGLEntry."Original Transaction No." := ParentCompanyOriginalEntry."Transaction No.";

                //IF TempSubsidGLEntry."Document No." = 'PSIV284227' THEN BEGIN
                //  IF NOT CONFIRM('Do you want to debug?') THEN
                //    ERROR('Break');
                //END;

                IF (TempSubsidGLEntry."Debit Amount" <> 0) OR (TempSubsidGLEntry."Credit Amount" <> 0) THEN
                    TempSubsidGLEntry.INSERT
                ELSE
                    NextEntryNo -= 1;

                //Balancing Entry
                NextEntryNo += 1;
                TempSubsidGLEntry.INIT;
                TempSubsidGLEntry."Entry No." := NextEntryNo;
                TempSubsidGLEntry."Document No." := 'FOREX RESTAT ' + DELCHR(FORMAT(Edate), '=', '/');
                TempSubsidGLEntry."Posting Date" := Edate;
                IF EOMAmount < 0 THEN BEGIN
                    TempSubsidGLEntry."G/L Account No." := BankAccPostingGroup."G/L Bank Account No."; //'937';
                    TempSubsidGLEntry."Debit Amount" := -EOMAmount;
                    TempSubsidGLEntry."Add.-Currency Debit Amount" := -EOMAmount / ToCurrExchRate."Relational Exch. Rate Amount";
                END ELSE BEGIN
                    TempSubsidGLEntry."G/L Account No." := BankAccPostingGroup."G/L Bank Account No."; //'948';
                    TempSubsidGLEntry."Credit Amount" := -EOMAmount;
                    TempSubsidGLEntry."Add.-Currency Credit Amount" := -EOMAmount / ToCurrExchRate."Relational Exch. Rate Amount";
                END;
                //There will not be any original entry as these are generated afresh.
                //TempSubsidGLEntry."Original Entry No." := ParentCompanyOriginalEntry."Entry No.";
                //TempSubsidGLEntry."Original Transaction No." := ParentCompanyOriginalEntry."Transaction No.";

                //IF TempSubsidGLEntry."Document No." = 'PSIV284227' THEN BEGIN
                //  IF NOT CONFIRM('Do you want to debug?') THEN
                //    ERROR('Break');
                //END;

                IF (TempSubsidGLEntry."Debit Amount" <> 0) OR (TempSubsidGLEntry."Credit Amount" <> 0) THEN
                    TempSubsidGLEntry.INSERT
                ELSE
                    NextEntryNo -= 1;
          {
          //Reversal Entry
          NextEntryNo += 1;
                TempSubsidGLEntry.INIT;
                TempSubsidGLEntry."Entry No." := NextEntryNo;
                TempSubsidGLEntry."Document No." := 'FOREX REVERS ' + DELCHR(FORMAT(CALCDATE('+1D', Edate)), '=', '/');
                TempSubsidGLEntry."Posting Date" := CALCDATE('+1D', Edate);
                IF EOMAmount < 0 THEN BEGIN
                    TempSubsidGLEntry."G/L Account No." := '938';
                    TempSubsidGLEntry."Debit Amount" := EOMAmount;
                    TempSubsidGLEntry."Add.-Currency Debit Amount" := EOMAmount / ToCurrExchRate."Relational Exch. Rate Amount";
                END ELSE BEGIN
                    TempSubsidGLEntry."G/L Account No." := '947';
                    TempSubsidGLEntry."Credit Amount" := EOMAmount;
                    TempSubsidGLEntry."Add.-Currency Credit Amount" := EOMAmount / ToCurrExchRate."Relational Exch. Rate Amount";
                END;
                //There will not be any original entry as these are generated afresh.
                //TempSubsidGLEntry."Original Entry No." := ParentCompanyOriginalEntry."Entry No.";
                //TempSubsidGLEntry."Original Transaction No." := ParentCompanyOriginalEntry."Transaction No.";

                //IF TempSubsidGLEntry."Document No." = 'PSIV284227' THEN BEGIN
                //  IF NOT CONFIRM('Do you want to debug?') THEN
                //    ERROR('Break');
                //END;

                IF (TempSubsidGLEntry."Debit Amount" <> 0) OR (TempSubsidGLEntry."Credit Amount" <> 0) THEN
                    TempSubsidGLEntry.INSERT
                ELSE
                    NextEntryNo -= 1;

                //Balancing Entry
                NextEntryNo += 1;
                TempSubsidGLEntry.INIT;
                TempSubsidGLEntry."Entry No." := NextEntryNo;
                TempSubsidGLEntry."Document No." := 'FOREX REVERS ' + DELCHR(FORMAT(CALCDATE('+1D', Edate)), '=', '/');
                TempSubsidGLEntry."Posting Date" := CALCDATE('+1D', Edate);
                IF EOMAmount < 0 THEN BEGIN
                    TempSubsidGLEntry."G/L Account No." := BankAccPostingGroup."G/L Bank Account No."; //'937';
                    TempSubsidGLEntry."Debit Amount" := -EOMAmount;
                    TempSubsidGLEntry."Add.-Currency Debit Amount" := -EOMAmount / ToCurrExchRate."Relational Exch. Rate Amount";
                END ELSE BEGIN
                    TempSubsidGLEntry."G/L Account No." := BankAccPostingGroup."G/L Bank Account No."; //'948';
                    TempSubsidGLEntry."Credit Amount" := -EOMAmount;
                    TempSubsidGLEntry."Add.-Currency Credit Amount" := -EOMAmount / ToCurrExchRate."Relational Exch. Rate Amount";
                END;
                //There will not be any original entry as these are generated afresh.
                //TempSubsidGLEntry."Original Entry No." := ParentCompanyOriginalEntry."Entry No.";
                //TempSubsidGLEntry."Original Transaction No." := ParentCompanyOriginalEntry."Transaction No.";

                //IF TempSubsidGLEntry."Document No." = 'PSIV284227' THEN BEGIN
                //  IF NOT CONFIRM('Do you want to debug?') THEN
                //    ERROR('Break');
                //END;

                IF (TempSubsidGLEntry."Debit Amount" <> 0) OR (TempSubsidGLEntry."Credit Amount" <> 0) THEN
                    TempSubsidGLEntry.INSERT
                ELSE
                    NextEntryNo -= 1;
          }
        UNTIL BankAcctLedgerEntry.NEXT() = 0;

        EXIT(NextEntryNo);
        //<<CIS.RAM
    END;

    LOCAL PROCEDURE BookDeltaAssemblyOutputCost(InputILE: Record 32; BookedAmount: Decimal);
    VAR
        lILE: Record 32;
        lILEScan: Record 32;
        ExchRate: Record 330;
        ValueEntry: Record 5802;
        DeltaAmountCAD: Decimal;
        DeltaAmountUSD: Decimal;
        i: Integer;
        NextEntryNo: Integer;
    BEGIN
        BusUnit.GET('NICA');
        DeltaAmountUSD := 0;
        DeltaAmountCAD := 0;
        lILE.RESET();
        lILE.CHANGECOMPANY(BusUnit."Company Name");
        lILE.SETRANGE("Entry Type", lILE."Entry Type"::"Assembly Consumption");
        lILE.SETRANGE("Document No.", InputILE."Document No.");
        lILE.SETRANGE("Posting Date", InputILE."Posting Date");
        IF lILE.FINDSET() THEN
            REPEAT
                i += 1;
                lILEScan := lILE;
                WHILE i > 0 DO BEGIN
                    TempItemEntryNew[i].DELETEALL();
                    FindAppliedEntryNew(lILEScan, i);
                    TempItemEntryNew[i].CALCFIELDS("Cost Amount (Actual)");
                    //\\ RAM 06/05/2019
                    //IF (TempItemEntryNew[i]."Entry Type" = TempItemEntryNew[i]."Entry Type"::"Positive Adjmt.") OR
                    IF (TempItemEntryNew[i]."Entry Type" IN [TempItemEntryNew[i]."Entry Type"::Transfer, TempItemEntryNew[i]."Entry Type"::"Positive Adjmt."]) OR
                       (TempItemEntryNew[i]."Document Type" = TempItemEntryNew[i]."Document Type"::"Purchase Receipt")
                    THEN BEGIN
                        IF (TempItemEntryNew[i]."Entry Type" = TempItemEntryNew[i]."Entry Type"::"Positive Adjmt.") THEN BEGIN
                            //ValueEntry.Amount needs converted to USD ValueEntry."Posting Date"
                            ValueEntry.RESET();
                            ValueEntry.CHANGECOMPANY(BusUnit."Company Name");
                            ValueEntry.SETRANGE("Item Ledger Entry No.", TempItemEntryNew[i]."Entry No.");
                            ValueEntry.SETRANGE("Item No.", TempItemEntryNew[i]."Item No.");
                            ValueEntry.SETFILTER("Invoiced Quantity", '<>%1', 0);
                            IF ValueEntry.FINDFIRST() THEN BEGIN
                                REPEAT
                                    ExchRate.RESET();
                                    ExchRate.SETRANGE("Currency Code", 'CAD');
                                    ExchRate.SETFILTER(ExchRate."Starting Date", '..%1', ValueEntry."Posting Date");
                                    ExchRate.FINDLAST();
                                    //ValueEntry."Cost Posted to G/L" := ValueEntry."Cost Posted to G/L" * TempItemEntryNew[i].Quantity/TempItemEntryNew[i]."Invoiced Quantity";
                                    //ValueEntry."Cost Posted to G/L" := ValueEntry."Cost Amount (Actual)" + ValueEntry."Cost Amount (Expected)";
                                    ValueEntry."Cost Posted to G/L" := ValueEntry."Cost Posted to G/L" * lILE.Quantity / TempItemEntryNew[i]."Invoiced Quantity";
                                    //MESSAGE('Positive Adjmt: %1',(ValueEntry."Cost Posted to G/L" * ExchRate."Relational Exch. Rate Amount"));
                                    DeltaAmountUSD += ValueEntry."Cost Posted to G/L" * ExchRate."Relational Exch. Rate Amount";
                                UNTIL ValueEntry.NEXT() = 0;
                                i := 0;
                            END;
                        END ELSE BEGIN
                            ValueEntry.RESET();
                            ValueEntry.CHANGECOMPANY(BusUnit."Company Name");
                            ValueEntry.SETRANGE("Item Ledger Entry No.", TempItemEntryNew[i]."Entry No.");
                            ValueEntry.SETRANGE("Item No.", TempItemEntryNew[i]."Item No.");
                            ValueEntry.SETFILTER("Invoiced Quantity", '<>%1', 0);
                            IF ValueEntry.FINDFIRST() THEN
                                REPEAT
                                    //ValueEntry.Amount needs converted to USD ValueEntry."Posting Date"
                                    ExchRate.RESET();
                                    ExchRate.SETRANGE("Currency Code", 'CAD');
                                    ExchRate.SETFILTER(ExchRate."Starting Date", '..%1', ValueEntry."Posting Date");
                                    ExchRate.FINDLAST();
                                    //ValueEntry."Cost Posted to G/L" := ValueEntry."Cost Posted to G/L" * TempItemEntryNew[i].Quantity/TempItemEntryNew[i]."Invoiced Quantity";
                                    //ValueEntry."Cost Posted to G/L" := ValueEntry."Cost Amount (Actual)" + ValueEntry."Cost Amount (Expected)";
                                    ValueEntry."Cost Posted to G/L" := ValueEntry."Cost Posted to G/L" * lILE.Quantity / TempItemEntryNew[i]."Invoiced Quantity";
                                    //MESSAGE('Purch: %1',(ValueEntry."Cost Posted to G/L" * ExchRate."Relational Exch. Rate Amount"));
                                    DeltaAmountUSD += ValueEntry."Cost Posted to G/L" * ExchRate."Relational Exch. Rate Amount";
                                UNTIL ValueEntry.NEXT() = 0;
                            i := 0;
                        END;
                    END ELSE BEGIN
                        lILEScan.RESET();
                        lILEScan.CHANGECOMPANY(BusUnit."Company Name");
                        lILEScan.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Expiration Date", "Lot No.", "Serial No.");
                        lILEScan.SETRANGE("Item No.", TempItemEntryNew[i]."Item No.");
                        lILEScan.SETRANGE("Document No.", TempItemEntryNew[i]."Document No.");
                        lILEScan.SETRANGE("Posting Date", TempItemEntryNew[i]."Posting Date");
                        lILEScan.FINDSET();
                        i += 1;
                        IF i = 10 THEN
                            ERROR('Reached max layers');
                    END;\
          END;
                //Convert Delta Value into CAD again
                ExchRate.RESET();
                ExchRate.SETRANGE("Currency Code", 'CAD');
                ExchRate.SETFILTER(ExchRate."Starting Date", '..%1', lILE."Posting Date");
                ExchRate.FINDLAST();
                //MESSAGE('CAD conversion: %1\%2\%3',DeltaAmountUSD,ExchRate."Relational Exch. Rate Amount",DeltaAmountUSD/ExchRate."Relational Exch. Rate Amount");
                DeltaAmountUSD := DeltaAmountUSD / ExchRate."Relational Exch. Rate Amount";
                DeltaAmountCAD += DeltaAmountUSD;
                DeltaAmountUSD := 0;
            UNTIL lILE.NEXT() = 0;

        IF ABS(BookedAmount) <> ABS(DeltaAmountCAD) THEN BEGIN
            IF TempSubsidGLEntry.FINDLAST THEN
                NextEntryNo := TempSubsidGLEntry."Entry No." + 2
            ELSE
                NextEntryNo := 2;
            TempSubsidGLEntry.INIT;
            TempSubsidGLEntry."Entry No." := NextEntryNo;
            TempSubsidGLEntry."Document No." := InputILE."Document No.";
            TempSubsidGLEntry."Posting Date" := InputILE."Posting Date";
            TempSubsidGLEntry."G/L Account No." := '730';
            IF ABS(BookedAmount) < ABS(DeltaAmountCAD) THEN BEGIN
                //Debit 730 Credit 180
                TempSubsidGLEntry."Debit Amount" := ABS(BookedAmount) - ABS(DeltaAmountCAD);
            END ELSE BEGIN
                TempSubsidGLEntry."Credit Amount" := ABS(BookedAmount) - ABS(DeltaAmountCAD);
            END;
            //There will not be any original entry as these are generated afresh.
            //TempSubsidGLEntry."Original Entry No." := ParentCompanyOriginalEntry."Entry No.";
            //TempSubsidGLEntry."Original Transaction No." := ParentCompanyOriginalEntry."Transaction No.";

            //IF TempSubsidGLEntry."Document No." = 'PSIV284227' THEN BEGIN
            //  IF NOT CONFIRM('Do you want to debug?') THEN
            //    ERROR('Break');
            //END;

            IF (TempSubsidGLEntry."Debit Amount" <> 0) OR (TempSubsidGLEntry."Credit Amount" <> 0) THEN
                TempSubsidGLEntry.INSERT
            ELSE
                NextEntryNo -= 1;

            //Balancing Entry
            NextEntryNo += 1;
            TempSubsidGLEntry.INIT;
            TempSubsidGLEntry."Entry No." := NextEntryNo;
            TempSubsidGLEntry."Document No." := InputILE."Document No.";
            TempSubsidGLEntry."Posting Date" := InputILE."Posting Date";
            TempSubsidGLEntry."G/L Account No." := '180';
            IF ABS(BookedAmount) < ABS(DeltaAmountCAD) THEN BEGIN
                TempSubsidGLEntry."Credit Amount" := ABS(BookedAmount) - ABS(DeltaAmountCAD);
            END ELSE BEGIN
                TempSubsidGLEntry."Debit Amount" := ABS(BookedAmount) - ABS(DeltaAmountCAD);
            END;
            //There will not be any original entry as these are generated afresh.
            //TempSubsidGLEntry."Original Entry No." := ParentCompanyOriginalEntry."Entry No.";
            //TempSubsidGLEntry."Original Transaction No." := ParentCompanyOriginalEntry."Transaction No.";

            //IF TempSubsidGLEntry."Document No." = 'PSIV284227' THEN BEGIN
            //  IF NOT CONFIRM('Do you want to debug?') THEN
            //    ERROR('Break');
            //END;

            IF (TempSubsidGLEntry."Debit Amount" <> 0) OR (TempSubsidGLEntry."Credit Amount" <> 0) THEN
                TempSubsidGLEntry.INSERT
            ELSE
                NextEntryNo -= 1;
        END;
    END;

    LOCAL PROCEDURE FindAppliedEntryNew(ItemLedgEntry: Record 32; i: Integer);
    VAR
        ItemApplnEntry: Record 339;
    BEGIN
        BusUnit.GET('NICA');
        WITH ItemLedgEntry DO
            IF Positive THEN BEGIN
                ItemApplnEntry.RESET();
                ItemApplnEntry.CHANGECOMPANY(BusUnit."Company Name");
                ItemApplnEntry.SETCURRENTKEY("Inbound Item Entry No.", "Outbound Item Entry No.", "Cost Application");
                ItemApplnEntry.SETRANGE("Inbound Item Entry No.", "Entry No.");
                ItemApplnEntry.SETFILTER("Outbound Item Entry No.", '<>%1', 0);
                ItemApplnEntry.SETRANGE("Cost Application", TRUE);
                IF ItemApplnEntry.FIND('-') THEN
                    REPEAT
                        InsertTempEntryNew(ItemApplnEntry."Outbound Item Entry No.", ItemApplnEntry.Quantity, i);
                    UNTIL ItemApplnEntry.NEXT() = 0;
            END ELSE BEGIN
                ItemApplnEntry.RESET();
                ItemApplnEntry.CHANGECOMPANY(BusUnit."Company Name");
                ItemApplnEntry.SETCURRENTKEY("Outbound Item Entry No.", "Item Ledger Entry No.", "Cost Application");
                ItemApplnEntry.SETRANGE("Outbound Item Entry No.", "Entry No.");
                ItemApplnEntry.SETRANGE("Item Ledger Entry No.", "Entry No.");
                ItemApplnEntry.SETRANGE("Cost Application", TRUE);
                IF ItemApplnEntry.FIND('-') THEN
                    REPEAT
                        InsertTempEntryNew(ItemApplnEntry."Inbound Item Entry No.", -ItemApplnEntry.Quantity, i);
                    UNTIL ItemApplnEntry.NEXT() = 0;
            END;
    END;

    LOCAL PROCEDURE InsertTempEntryNew(EntryNo: Integer; AppliedQty: Decimal; j: Integer);
    VAR
        ItemLedgEntry: Record 32;
    BEGIN
        BusUnit.GET('NICA');
        ItemLedgEntry.CHANGECOMPANY(BusUnit."Company Name");
        ItemLedgEntry.GET(EntryNo);
        IF AppliedQty * ItemLedgEntry.Quantity < 0 THEN
            EXIT;

        IF NOT TempItemEntryNew[j].GET(EntryNo) THEN BEGIN
            TempItemEntryNew[j].INIT();
            TempItemEntryNew[j] := ItemLedgEntry;
            TempItemEntryNew[j].Quantity := AppliedQty;
            TempItemEntryNew[j].INSERT();
        END ELSE BEGIN
            TempItemEntryNew[j].Quantity := TempItemEntryNew[j].Quantity + AppliedQty;
            TempItemEntryNew[j].MODIFY();
        END;
    END;



    var

     
        PurchaseSetup: Record 312;
        TempItemEntry: Record 32 temporary;
        TempItemEntry1: Record 32 temporary;
        TempItemEntry2: Record 32 TEMPORARY;
        TempItemEntry3: Record 32 TEMPORARY;
        TempItemEntry4: Record 32 TEMPORARY;
        TempItemEntry5: Record 32 TEMPORARY;
        TempItemEntry6: Record 32 TEMPORARY;
        TempItemEntry7: Record 32 TEMPORARY;
        TempItemEntry8: Record 32 TEMPORARY;
        TempItemEntry9: Record 32 TEMPORARY;
        TempItemEntry10: Record 32 TEMPORARY;
        RecCount: Integer;
        InvoiceDate: Date;
        ParentCompanyOriginalEntry: Record 17;
        SkipRecord: Boolean;
        GlobalTempCustLedgEntry: Record 21 TEMPORARY;
        TempItemEntryNew: ARRAY[10] OF Record 32 TEMPORARY;

}






