pageextension 50256 "Payment Journal Ext" extends "Payment Journal"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }
    PROCEDURE Insert3WayCurrency(JnlTemplateName: Code[20]; JnlBatchName: Code[20]);
    VAR
        lGenJnlLine: Record "Gen. Journal Line";
        lGenJnlLineModify: Record "Gen. Journal Line";
        TempJnlLine: Record "Gen. Journal Line" temporary;
        PurchSetup: Record "Purchases & Payables Setup";
        Vendor: Record Vendor;
        GenJnlPost: Codeunit "Gen. Jnl.-Post Line";
        LoopCount: Integer;
        MaxCount: Integer;
    BEGIN
        //>>FOREX
        LoopCount := 0;
        lGenJnlLine.LOCKTABLE();
        lGenJnlLine.SETRANGE("Journal Template Name", JnlTemplateName);
        lGenJnlLine.SETRANGE("Journal Batch Name", JnlBatchName);
        lGenJnlLine.SETRANGE("3-Way Applied", FALSE);
        IF lGenJnlLine.FINDSET() THEN BEGIN
            TempJnlLine.RESET();
            TempJnlLine.DELETEALL();
            MaxCount := lGenJnlLine.COUNT;
            REPEAT
                LoopCount += 1;
                CLEAR(GenJnlPost);
                IF lGenJnlLine."Account Type" = lGenJnlLine."Account Type"::Vendor THEN BEGIN
                    Vendor.RESET();
                    Vendor.GET(lGenJnlLine."Account No.");
                    IF Vendor."3 Way Currency Adjmt." THEN BEGIN
                        PurchSetup.RESET();
                        PurchSetup.GET();
                        IF PurchSetup."3-way Balance Sheet solution" THEN BEGIN
                            PostUSDPurchaseJournal(lGenJnlLine, TempJnlLine);
                            ReverseFCPurchaseTrans(lGenJnlLine, TempJnlLine);
                        END;
                        "PostFCAdjustment3-way"(lGenJnlLine, TempJnlLine);
                        //GenJnlPost."PostLCYAdjustment3-way"(lGenJnlLine,TempJnlLine); //This is not required since NAV auto adjusts the LCY
                    END;
                    CLEAR(lGenJnlLineModify);
                    lGenJnlLineModify := lGenJnlLine;
                    lGenJnlLineModify."3-Way Applied" := TRUE;
                    lGenJnlLineModify.MODIFY();
                END;
            UNTIL (lGenJnlLine.NEXT() = 0) OR (LoopCount = MaxCount);
            TempJnlLine.RESET();
            IF TempJnlLine.FINDSET() THEN
                REPEAT
                    lGenJnlLine.RESET();
                    lGenJnlLine := TempJnlLine;
                    lGenJnlLine.INSERT();
                UNTIL TempJnlLine.NEXT() = 0;
        END;
        //<<FOREX
    END;

    PROCEDURE PostUSDPurchaseJournal(VendUSDJnl: Record "Gen. Journal Line"; VAR GenJnlLine: Record "Gen. Journal Line" temporary);
    VAR
        PurchInvHead: Record "Purch. Inv. Header";
        PurchSetup: Record "Purchases & Payables Setup";
        DocNumber: Text;
        ExtDoc: Text[250];
    BEGIN
        //>>FOREX
        WITH VendUSDJnl DO BEGIN
            PurchSetup.RESET();
            PurchSetup.GET();
            PurchInvHead.RESET();
            PurchInvHead.SETCURRENTKEY("Vendor Invoice No.");
            PurchInvHead.SETFILTER("Vendor Invoice No.", VendUSDJnl."External Document No.");
            PurchInvHead.FINDFIRST();
            GenJnlLine.INIT();
            GenJnlLine."Journal Template Name" := "Journal Template Name";
            GenJnlLine."Journal Batch Name" := "Journal Batch Name";
            GenJnlLine."Line No." := "Line No." + 10;
            GenJnlLine."3-Way Line applied to" := "Line No.";
            GenJnlLine."Posting Date" := VendUSDJnl."Posting Date"; //PurchInvHead."Posting Date";
            GenJnlLine."Document Date" := VendUSDJnl."Posting Date"; //PurchInvHead."Document Date";
            GenJnlLine.Description := 'USD Journal for ' + PurchInvHead."No.";
            GenJnlLine."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
            GenJnlLine."Dimension Set ID" := "Dimension Set ID";
            GenJnlLine."Reason Code" := "Reason Code";
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::Vendor;
            GenJnlLine."Account No." := "Account No.";
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::Invoice;
            DocNumber := '';
            DocNumber := DELCHR(FORMAT(TIME), '=', '/:');
            IF STRLEN(PurchInvHead."No." + DocNumber) < 20 THEN
                GenJnlLine."Document No." := PurchInvHead."No." + ' ' + DocNumber
            ELSE
                GenJnlLine."Document No." := PurchInvHead."No." + ' ' + COPYSTR(DocNumber, 1, 19 - STRLEN(PurchInvHead."No."));
            ExtDoc := FORMAT(CURRENTDATETIME);
            ExtDoc := DELCHR(ExtDoc, '=', '/:');
            IF (STRLEN("External Document No.") + STRLEN(ExtDoc)) < 20 THEN
                GenJnlLine."External Document No." := "External Document No." + ' ' + ExtDoc
            ELSE
                GenJnlLine."External Document No." := "External Document No." + ' ' + COPYSTR(ExtDoc, 1, 19 - STRLEN("External Document No."));
            //GenJnlLine."External Document No." := "External Document No.";

            GenJnlLine."Currency Code" := 'USD';
            GenJnlLine.Amount := -Amount;
            GenJnlLine."Source Currency Code" := "Source Currency Code";
            GenJnlLine."Source Currency Amount" := "Source Currency Amount";
            GenJnlLine."Amount (LCY)" := -"Amount (LCY)";
            IF "Currency Code" = '' THEN
                GenJnlLine."Currency Factor" := 1
            ELSE
                GenJnlLine."Currency Factor" := "Currency Factor";
            GenJnlLine."Sales/Purch. (LCY)" := "Sales/Purch. (LCY)";
            GenJnlLine.Correction := Correction;
            GenJnlLine."Inv. Discount (LCY)" := 0;
            GenJnlLine."Sell-to/Buy-from No." := "Sell-to/Buy-from No.";
            GenJnlLine."Bill-to/Pay-to No." := "Bill-to/Pay-to No.";
            GenJnlLine."Salespers./Purch. Code" := "Salespers./Purch. Code";
            GenJnlLine."System-Created Entry" := TRUE;
            GenJnlLine."On Hold" := "On Hold";
            GenJnlLine."Applies-to Doc. Type" := "Applies-to Doc. Type";
            GenJnlLine."Applies-to Doc. No." := "Applies-to Doc. No.";
            GenJnlLine."Applies-to ID" := "Applies-to ID";
            GenJnlLine."Allow Application" := "Bal. Account No." = '';
            GenJnlLine."Due Date" := "Due Date";
            GenJnlLine."Payment Terms Code" := "Payment Terms Code";
            GenJnlLine."Pmt. Discount Date" := "Pmt. Discount Date";
            GenJnlLine."Payment Discount %" := "Payment Discount %";
            GenJnlLine."Source Type" := GenJnlLine."Source Type"::Vendor;
            GenJnlLine."Source No." := "Source No.";
            GenJnlLine."Source Code" := "Source Code";
            GenJnlLine."Posting No. Series" := "Posting No. Series";
            GenJnlLine."IC Partner Code" := "IC Partner Code";
            GenJnlLine."Creditor No." := "Creditor No.";
            GenJnlLine."Payment Reference" := "Payment Reference";
            GenJnlLine."Payment Method Code" := "Payment Method Code";
            GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
            GenJnlLine."Bal. Account No." := PurchSetup."Bal G/L Acc to Create USD Inv";
            IF "IRS 1099 Code" <> '' THEN BEGIN
                GenJnlLine."IRS 1099 Code" := "IRS 1099 Code";
                GenJnlLine."IRS 1099 Amount" := "IRS 1099 Amount";
            END;
            GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::" ";
            GenJnlLine."Applies-to Doc. No." := '';
            GenJnlLine.INSERT();
            // {
            // CLEAR(GenJnlPostLine);
            //     GenJnlPostLine.Set3wayentry;
            //     GenJnlPostLine.RunWithCheck(GenJnlLine);
            //     CLEAR(GenJnlPostLine);
            // }
        END;
        //<<FOREX
    END;

    PROCEDURE ReverseFCPurchaseTrans(VendUSDJnl: Record "Gen. Journal Line"; VAR GenJnlLine: Record "Gen. Journal Line" temporary);
    VAR
        PurchInvHead: Record "Purch. Inv. Header";
        PurchSetup: Record "Purchases & Payables Setup";
        ExtDoc: Text[250];
    BEGIN
        //>>FOREX
        WITH VendUSDJnl DO BEGIN
            PurchSetup.RESET();
            PurchSetup.GET();
            PurchInvHead.RESET();
            PurchInvHead.SETCURRENTKEY("Vendor Invoice No.");
            PurchInvHead.SETFILTER("Vendor Invoice No.", VendUSDJnl."External Document No.");
            PurchInvHead.FINDFIRST();

            GenJnlLine.INIT();
            GenJnlLine."Journal Template Name" := "Journal Template Name";
            GenJnlLine."Journal Batch Name" := "Journal Batch Name";
            GenJnlLine."Line No." := "Line No." + 20;
            GenJnlLine."3-Way Line applied to" := "Line No.";
            GenJnlLine."Posting Date" := PurchInvHead."Posting Date";
            GenJnlLine."Document Date" := PurchInvHead."Document Date";
            GenJnlLine.Description := 'Reverse Original Inv ' + PurchInvHead."No.";
            GenJnlLine."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
            GenJnlLine."Dimension Set ID" := "Dimension Set ID";
            GenJnlLine."Reason Code" := "Reason Code";
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::Vendor;
            GenJnlLine.VALIDATE("Account No.", "Account No.");
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::"Credit Memo";
            GenJnlLine."Document No." := PurchInvHead."No.";

            ExtDoc := FORMAT(CURRENTDATETIME);
            ExtDoc := DELCHR(ExtDoc, '=', '/:');
            IF (STRLEN("External Document No.") + STRLEN(ExtDoc)) < 20 THEN
                GenJnlLine."External Document No." := "External Document No." + ' ' + ExtDoc
            ELSE
                GenJnlLine."External Document No." := "External Document No." + ' ' + COPYSTR(ExtDoc, 1, 19 - STRLEN("External Document No."));
            //GenJnlLine."External Document No." := "External Document No.";

            GenJnlLine."Currency Code" := PurchInvHead."Currency Code";
            PurchInvHead.CALCFIELDS("Amount Including VAT");
            GenJnlLine.VALIDATE(Amount, PurchInvHead."Amount Including VAT");
            GenJnlLine."Source Currency Code" := PurchInvHead."Currency Code";
            GenJnlLine."Source Currency Amount" := PurchInvHead."Amount Including VAT";
            // {
            // GenJnlLine."Amount (LCY)" := "Amount (LCY)";
            //     IF "Currency Code" = '' THEN
            //         GenJnlLine."Currency Factor" := 1
            //     ELSE
            //         GenJnlLine."Currency Factor" := "Currency Factor";
            // }
            GenJnlLine."Sales/Purch. (LCY)" := "Sales/Purch. (LCY)";
            GenJnlLine.Correction := Correction;
            GenJnlLine."Inv. Discount (LCY)" := 0;
            GenJnlLine."Sell-to/Buy-from No." := "Sell-to/Buy-from No.";
            GenJnlLine."Bill-to/Pay-to No." := "Bill-to/Pay-to No.";
            GenJnlLine."Salespers./Purch. Code" := "Salespers./Purch. Code";
            GenJnlLine."System-Created Entry" := TRUE;
            GenJnlLine."On Hold" := "On Hold";
            GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
            GenJnlLine."Applies-to Doc. No." := PurchInvHead."No.";
            GenJnlLine."Applies-to ID" := "Applies-to ID";
            GenJnlLine."Allow Application" := "Bal. Account No." = '';
            GenJnlLine."Due Date" := "Due Date";
            GenJnlLine."Payment Terms Code" := "Payment Terms Code";
            GenJnlLine."Pmt. Discount Date" := "Pmt. Discount Date";
            GenJnlLine."Payment Discount %" := "Payment Discount %";
            GenJnlLine."Source Type" := GenJnlLine."Source Type"::Vendor;
            GenJnlLine."Source No." := "Source No.";
            GenJnlLine."Source Code" := "Source Code";
            GenJnlLine."Posting No. Series" := "Posting No. Series";
            GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
            GenJnlLine."Bal. Account No." := PurchSetup."Bal G/L Acc to Reverse JPY Inv";
            GenJnlLine."IC Partner Code" := "IC Partner Code";
            GenJnlLine."Creditor No." := "Creditor No.";
            GenJnlLine."Payment Reference" := "Payment Reference";
            GenJnlLine."Payment Method Code" := "Payment Method Code";
            IF "IRS 1099 Code" <> '' THEN BEGIN
                GenJnlLine."IRS 1099 Code" := "IRS 1099 Code";
                GenJnlLine."IRS 1099 Amount" := "IRS 1099 Amount";
            END;
            GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::" ";
            GenJnlLine."Applies-to Doc. No." := '';
            GenJnlLine.INSERT();
            // {
            // CLEAR(GenJnlPostLine);
            //     GenJnlPostLine.Set3wayentry;
            //     GenJnlPostLine.RunWithCheck(GenJnlLine);
            //     CLEAR(GenJnlPostLine);
            // }
        END;
        //<<FOREX
    END;

    PROCEDURE "PostFCAdjustment3-way"(VendUSDJnl: Record "Gen. Journal Line"; VAR GenJnlLine: Record "Gen. Journal Line" temporary);
    VAR
        "3WayCurrExchRate": Record "3 Way Currency Exchange Rate";
        Currency: Record Currency;
        GLsetup: Record "General Ledger Setup";
        PurchInvHead: Record "Purch. Inv. Header";
        PurchSetup: Record "Purchases & Payables Setup";
        Vendor: Record Vendor;
        Amt: Decimal;
        MXNValue: Decimal;
        OriginalFCAmt: Decimal;
        GainLoss: option Gain,Loss;
        ExtDoc: Text[250];
    BEGIN
        //>>FOREX
        GLsetup.GET();
        PurchSetup.GET();
        PurchInvHead.RESET();
        PurchInvHead.SETCURRENTKEY("Vendor Invoice No.");
        PurchInvHead.SETFILTER("Vendor Invoice No.", VendUSDJnl."External Document No.");
        PurchInvHead.FINDFIRST();
        Vendor.GET(PurchInvHead."Pay-to Vendor No.");
        IF Vendor."3 Way Currency Adjmt." THEN BEGIN
            PurchInvHead.CALCFIELDS("Amount Including VAT", PurchInvHead."Total USD Value");
            Amt := 0;
            OriginalFCAmt := 0;
            // {
            // Amt :=
            //   ROUND(
            //     "3WayCurrExchRate".ExchangeAmtFCYToUSD(
            //       VendUSDJnl."Posting Date",
            //       PurchInvHead."Currency Code",
            //       'USD',                  //This is always USD
            //       PurchInvHead."Amount Including VAT"), //This is the Peso amount to be converted to USD value
            //     GLsetup."Unit-Amount Rounding Precision");
            // }
            // {
            // OriginalFCAmt :=
            //   ROUND(
            //     "3WayCurrExchRate".ExchangeAmtFCYToUSD(
            //       PurchInvHead."Posting Date",
            //       PurchInvHead."Currency Code",
            //       'USD',                  //This is always USD
            //       PurchInvHead."Amount Including VAT"), //This is the Peso amount to be converted to USD value
            //     GLsetup."Unit-Amount Rounding Precision");
            // }
            PurchInvHead.TESTFIELD("Currency Factor");
            MXNValue := 0;
            MXNValue := "3WayCurrExchRate".ExchangeAmtFCYToLCY(
                  PurchInvHead."Posting Date", PurchInvHead."Currency Code",
                  PurchInvHead."Amount Including VAT", PurchInvHead."Currency Factor");
            //MESSAGE('MXN%1',MXNValue);
            OriginalFCAmt := "3WayCurrExchRate".ExchangeAmtFCYToFCY(
                  PurchInvHead."Posting Date", '', 'USD',
                  MXNValue);

        END;

        Amt := VendUSDJnl.Amount;

        //MESSAGE('FC %1\%2\%3',OriginalFCAmt,Amt,Amt-OriginalFCAmt);
        IF Amt <> 0 THEN BEGIN
            Currency.GET('USD');
            Amt := ROUND(Amt, Currency."Amount Rounding Precision");
            OriginalFCAmt := ROUND(OriginalFCAmt, Currency."Amount Rounding Precision");
        END;
        // {
        // IF Amt = PurchInvHead."Total USD Value" THEN BEGIN
        //   //Do nothing
        // END ELSE IF Amt > PurchInvHead."Total USD Value" THEN BEGIN
        //   //Post Loss
        //   //Amt := Amt - PurchInvHead."Total USD Value";
        //   Amt := ABS(Amt - PurchInvHead."Total USD Value");
        //   GainLoss := GainLoss::Loss;
        // END ELSE IF Amt < PurchInvHead."Total USD Value" THEN BEGIN
        //   //Post Gain
        //   //Amt := PurchInvHead."Total USD Value" - Amt;
        //   Amt := -ABS(Amt - PurchInvHead."Total USD Value");
        //   GainLoss := GainLoss::Gain;
        // END;
        // }
        IF Amt = OriginalFCAmt THEN BEGIN
            //Do nothing
        END ELSE IF Amt > OriginalFCAmt THEN BEGIN
            //Post Loss
            //Amt := Amt - PurchInvHead."Total USD Value";
            Amt := ABS(Amt - OriginalFCAmt);
            GainLoss := GainLoss::Loss;
        END ELSE IF Amt < OriginalFCAmt THEN BEGIN
            //Post Gain
            //Amt := PurchInvHead."Total USD Value" - Amt;
            Amt := -ABS(Amt - OriginalFCAmt);
            GainLoss := GainLoss::Gain;
        END;

        IF GainLoss > 0 THEN
            WITH VendUSDJnl DO BEGIN
                GenJnlLine.INIT();
                GenJnlLine."Journal Template Name" := "Journal Template Name";
                GenJnlLine."Journal Batch Name" := "Journal Batch Name";
                //GenJnlLine."Journal Template Name" := PurchSetup."Curr.Gain/LossJnlTemplate";
                //GenJnlLine."Journal Batch Name" := PurchSetup."Curr.Gain/LossJnlBatch";
                GenJnlLine."Line No." := "Line No." + 30;
                GenJnlLine."3-Way Line applied to" := "Line No.";
                GenJnlLine."Posting Date" := "Posting Date";
                GenJnlLine."Document Date" := "Document Date";
                IF GainLoss = GainLoss::Gain THEN
                    GenJnlLine.Description := 'USD Gain for Inv.' + PurchInvHead."No."
                ELSE
                    GenJnlLine.Description := 'USD Loss for Inv.' + PurchInvHead."No.";
                GenJnlLine."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
                GenJnlLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
                GenJnlLine."Dimension Set ID" := "Dimension Set ID";
                GenJnlLine."Reason Code" := "Reason Code";
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                IF GainLoss = GainLoss::Gain THEN
                    GenJnlLine."Account No." := PurchSetup."FC Gain Account"
                ELSE
                    GenJnlLine."Account No." := PurchSetup."FC Loss Account";
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                GenJnlLine."Document No." := PurchInvHead."No.";

                ExtDoc := FORMAT(CURRENTDATETIME);
                ExtDoc := DELCHR(ExtDoc, '=', '/:');
                IF (STRLEN("External Document No.") + STRLEN(ExtDoc)) < 20 THEN
                    GenJnlLine."External Document No." := "External Document No." + ' ' + ExtDoc
                ELSE
                    GenJnlLine."External Document No." := "External Document No." + ' ' + COPYSTR(ExtDoc, 1, 19 - STRLEN("External Document No."));
                //GenJnlLine."External Document No." := "External Document No.";

                GenJnlLine."Currency Code" := 'USD';
                //IF GainLoss = GainLoss::Gain THEN
                GenJnlLine.Amount := Amt;
                //ELSE
                //  GenJnlLine.Amount := -Amt;

                //GenJnlLine."Source Currency Code" := PurchInvHead."Currency Code";
                //GenJnlLine."Source Currency Amount" := PurchInvHead."Amount Including VAT";
                //GenJnlLine."Amount (LCY)" := "Amount (LCY)";
                IF "Currency Code" = '' THEN
                    GenJnlLine."Currency Factor" := 1
                ELSE
                    GenJnlLine."Currency Factor" := "Currency Factor";
                GenJnlLine.VALIDATE(Amount);
                //GenJnlLine."Sales/Purch. (LCY)" := "Sales/Purch. (LCY)";
                //GenJnlLine.Correction := Correction;
                //GenJnlLine."Inv. Discount (LCY)" := 0;
                //GenJnlLine."Sell-to/Buy-from No." := "Sell-to/Buy-from No.";
                //GenJnlLine."Bill-to/Pay-to No." := "Bill-to/Pay-to No.";
                //GenJnlLine."Salespers./Purch. Code" := "Salespers./Purch. Code";
                //GenJnlLine."System-Created Entry" := TRUE;
                //GenJnlLine."On Hold" := "On Hold";
                //GenJnlLine."Applies-to Doc. Type" := "Applies-to Doc. Type";
                //GenJnlLine."Applies-to Doc. No." := "Applies-to Doc. No.";
                //GenJnlLine."Applies-to ID" := "Applies-to ID";
                //GenJnlLine."Allow Application" := "Bal. Account No." = '';
                //GenJnlLine."Due Date" := "Due Date";
                //GenJnlLine."Payment Terms Code" := "Payment Terms Code";
                //GenJnlLine."Pmt. Discount Date" := "Pmt. Discount Date";
                //GenJnlLine."Payment Discount %" := "Payment Discount %";
                GenJnlLine."Source Type" := GenJnlLine."Source Type"::Vendor;
                GenJnlLine."Source No." := "Source No.";
                GenJnlLine."Source Code" := "Source Code";
                GenJnlLine."Posting No. Series" := "Posting No. Series";
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                IF GainLoss = GainLoss::Gain THEN
                    GenJnlLine."Bal. Account No." := PurchSetup."FC Gain Bal. Account"
                ELSE
                    GenJnlLine."Bal. Account No." := PurchSetup."FC Loss Bal. Account";
                //GenJnlLine."IC Partner Code" := "IC Partner Code";
                //GenJnlLine."Creditor No." := "Creditor No.";
                //GenJnlLine."Payment Reference" := "Payment Reference";
                //GenJnlLine."Payment Method Code" := "Payment Method Code";
                //IF "IRS 1099 Code" <> '' THEN BEGIN
                //  GenJnlLine."IRS 1099 Code" := "IRS 1099 Code";
                //  GenJnlLine."IRS 1099 Amount" := "IRS 1099 Amount";
                //END;
                //None,Amount Only,Additional-Currency Amount Only
                GenJnlLine."Additional-Currency Posting" := GenJnlLine."Additional-Currency Posting"::"Additional-Currency Amount Only";
                GenJnlLine.INSERT();
                // {
                // CLEAR(GenJnlPostLine);
                //       GenJnlPostLine.Set3wayentry;
                //       GenJnlPostLine.RunWithCheck(GenJnlLine);
                //       CLEAR(GenJnlPostLine);
                // }
            END;
        //<<FOREX
    END;
}