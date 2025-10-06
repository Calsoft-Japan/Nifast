codeunit 50030 ConsolidationExp
{
    // //\\ RAM 01:2018 02/28/2018
    //  # Created a new codeunit

    TableNo = 220;

    trigger OnRun()
    var
        PreviousDate: Date;
        i: Integer;
    begin
        BusUnit := Rec;
        IF NORMALDATE(EndingDate) - NORMALDATE(StartingDate) + 1 > ARRAYLEN(RoundingResiduals) THEN
          ReportError(STRSUBSTNO(Text008,ARRAYLEN(RoundingResiduals)));

        IF ("Starting Date" <> 0D) OR ("Ending Date" <> 0D) THEN BEGIN
          IF "Starting Date" = 0D THEN
            ReportError(STRSUBSTNO(
                Text033,FIELDCAPTION("Starting Date"),
                FIELDCAPTION("Ending Date"),"Company Name"));
          IF "Ending Date" = 0D THEN
            ReportError(STRSUBSTNO(
                Text033,FIELDCAPTION("Ending Date"),
                FIELDCAPTION("Starting Date"),"Company Name"));
          IF "Starting Date" > "Ending Date" THEN
            ReportError(STRSUBSTNO(
                Text032,FIELDCAPTION("Starting Date"),
                FIELDCAPTION("Ending Date"),"Company Name"));
        END;

        ConsolidatingClosingDate :=
          (StartingDate = EndingDate) AND
          (StartingDate <> NORMALDATE(StartingDate));
        IF (StartingDate <> NORMALDATE(StartingDate)) AND
           (StartingDate <> EndingDate)
        THEN
          ReportError(Text030);

        ReadGLSetup;//<<<Ram ---01
        ReadSourceCodeSetup;
        ClearInternals;
        Window.OPEN(Text001 + Text002 + Text003 + Text004);
        Window.UPDATE(1,BusUnit.Code);

        IF NOT TestMode THEN BEGIN
          UpdatePhase(Text018);
          ClearPreviousConsolidation;
        END;

        IF ("Last Balance Currency Factor" <> 0) AND
           ("Balance Currency Factor" <> "Last Balance Currency Factor")
        THEN BEGIN
          UpdatePhase(Text019);
          UpdatePriorPeriodBalances;
        END;

        // Consolidate Current Entries
        UpdatePhase(Text020);
        CLEAR(GenJnlLine);
        GenJnlLine."Business Unit Code" := BusUnit.Code;
        GenJnlLine."Document No." := GLDocNo;
        GenJnlLine."Source Code" := ConsolidSourceCode;
        TempSubsidGLEntry.RESET;
        TempSubsidGLEntry.SETCURRENTKEY("G/L Account No.","Posting Date");
        TempSubsidGLEntry.SETRANGE("Posting Date",StartingDate,EndingDate);
        TempSubsidGLAcc.RESET;
        IF TempSubsidGLAcc.FINDSET THEN
          REPEAT
            Window.UPDATE(3,TempSubsidGLAcc."No.");
            TestGLAccounts;
            TempGLEntry.RESET;
            TempGLEntry.DELETEALL;
            DimBufMgt.DeleteAllDimensions;
            TempSubsidGLEntry.SETRANGE("G/L Account No.",TempSubsidGLAcc."No.");
            PreviousDate := 0D;
            IF TempSubsidGLEntry.FINDSET THEN
              REPEAT
                IF (TempSubsidGLEntry."Posting Date" <> NORMALDATE(TempSubsidGLEntry."Posting Date")) AND
                   NOT ConsolidatingClosingDate
                THEN
                  ReportError(
                    STRSUBSTNO(Text031,
                      TempSubsidGLEntry.TABLECAPTION,
                      TempSubsidGLEntry.FIELDCAPTION("Posting Date"),
                      TempSubsidGLEntry."Posting Date"));
                IF (TempSubsidGLAcc."Consol. Translation Method" = TempSubsidGLAcc."Consol. Translation Method"::"Historical Rate") AND
                   (TempSubsidGLEntry."Posting Date" <> PreviousDate)
                THEN BEGIN
                  IF PreviousDate <> 0D THEN BEGIN
                    TempDimBufOut.RESET;
                    TempDimBufOut.DELETEALL;
                    IF TempGLEntry.FINDSET THEN
                      REPEAT
                        IF NOT SkipAllDimensions THEN BEGIN
                          DimBufMgt.GetDimensions(TempGLEntry."Entry No.",TempDimBufOut);
                          TempDimBufOut.SETRANGE("Entry No.",TempGLEntry."Entry No.");
                        END;
                        CreateAndPostGenJnlLine(GenJnlLine,TempGLEntry,TempDimBufOut,TRUE);
                        CreateAndPostGenJnlLine(GenJnlLine,TempGLEntry,TempDimBufOut,FALSE);
                      UNTIL TempGLEntry.NEXT = 0;
                  END;
                  TempGLEntry.RESET;
                  TempGLEntry.DELETEALL;
                  DimBufMgt.DeleteAllDimensions;
                  PreviousDate := TempSubsidGLEntry."Posting Date";
                END;
                TempDimBufIn.RESET;
                TempDimBufIn.DELETEALL;
                IF NOT SkipAllDimensions THEN BEGIN
                  TempSubsidDimBuf.SETRANGE("Entry No.",TempSubsidGLEntry."Entry No.");
                  IF TempSubsidDimBuf.FINDSET THEN
                    REPEAT
                      IF TempSelectedDim.GET('',0,0,'',TempSubsidDimBuf."Dimension Code") THEN BEGIN
                        TempDimBufIn.INIT;
                        TempDimBufIn."Table ID" := DATABASE::"G/L Entry";
                        TempDimBufIn."Entry No." := TempSubsidGLEntry."Entry No.";
                        TempDimBufIn."Dimension Code" := TempSubsidDimBuf."Dimension Code";
                        TempDimBufIn."Dimension Value Code" := TempSubsidDimBuf."Dimension Value Code";
                        TempDimBufIn.INSERT;
                      END;
                    UNTIL TempSubsidDimBuf.NEXT = 0;
                END;
                UpdateTempGLEntry(TempSubsidGLEntry);
              UNTIL TempSubsidGLEntry.NEXT = 0;

            TempDimBufOut.RESET;
            TempDimBufOut.DELETEALL;
            IF TempGLEntry.FINDSET THEN
              REPEAT
                IF NOT SkipAllDimensions THEN BEGIN
                  DimBufMgt.GetDimensions(TempGLEntry."Entry No.",TempDimBufOut);
                  TempDimBufOut.SETRANGE("Entry No.",TempGLEntry."Entry No.");
                END;
                CreateAndPostGenJnlLine(GenJnlLine,TempGLEntry,TempDimBufOut,TRUE);
                CreateAndPostGenJnlLine(GenJnlLine,TempGLEntry,TempDimBufOut,FALSE);
              UNTIL TempGLEntry.NEXT = 0;
          UNTIL TempSubsidGLAcc.NEXT = 0;

        // Post balancing entries and adjustments
        UpdatePhase(Text025);

        FOR i := 1 TO NORMALDATE(EndingDate) - NORMALDATE(StartingDate) + 1 DO BEGIN
          IF ExchRateAdjAmounts[i] <> 0 THEN BEGIN
            GenJnlLine.Amount := ExchRateAdjAmounts[i];
            IF (BusUnit."Consolidation %" < 100) AND
               (BusUnit."Consolidation %" > 0)
            THEN BEGIN
              GenJnlLine.Amount := GenJnlLine.Amount * 100 / BusUnit."Consolidation %";
              MinorExchRateAdjAmts[i] :=
                MinorExchRateAdjAmts[i] - GenJnlLine.Amount + ExchRateAdjAmounts[i];
            END;
            IF GenJnlLine.Amount < 0 THEN BEGIN
              BusUnit.TESTFIELD("Exch. Rate Gains Acc.");
              GenJnlLine."Account No." := BusUnit."Exch. Rate Gains Acc.";
            END ELSE BEGIN
              BusUnit.TESTFIELD("Exch. Rate Losses Acc.");
              GenJnlLine."Account No." := BusUnit."Exch. Rate Losses Acc.";
            END;
            Window.UPDATE(3,GenJnlLine."Account No.");
            IF NOT ConsolidatingClosingDate THEN
              GenJnlLine."Posting Date" := StartingDate + i - 1
            ELSE
              GenJnlLine."Posting Date" := StartingDate;
            GenJnlLine.Description := STRSUBSTNO(Text015,WORKDATE);
            GenJnlPostLineTmp(GenJnlLine);
            RoundingResiduals[i] := RoundingResiduals[i] + GenJnlLine.Amount;
          END;
          IF CompExchRateAdjAmts[i] <> 0 THEN BEGIN
            GenJnlLine.Amount := CompExchRateAdjAmts[i];
            IF (BusUnit."Consolidation %" < 100) AND
               (BusUnit."Consolidation %" > 0)
            THEN BEGIN
              GenJnlLine.Amount := GenJnlLine.Amount * 100 / BusUnit."Consolidation %";
              MinorExchRateAdjAmts[i] :=
                MinorExchRateAdjAmts[i] - GenJnlLine.Amount + CompExchRateAdjAmts[i];
            END;
            IF GenJnlLine.Amount < 0 THEN BEGIN
              BusUnit.TESTFIELD("Comp. Exch. Rate Gains Acc.");
              GenJnlLine."Account No." := BusUnit."Comp. Exch. Rate Gains Acc.";
            END ELSE BEGIN
              BusUnit.TESTFIELD("Comp. Exch. Rate Losses Acc.");
              GenJnlLine."Account No." := BusUnit."Comp. Exch. Rate Losses Acc.";
            END;
            Window.UPDATE(3,GenJnlLine."Account No.");
            IF NOT ConsolidatingClosingDate THEN
              GenJnlLine."Posting Date" := StartingDate + i - 1
            ELSE
              GenJnlLine."Posting Date" := StartingDate;
            GenJnlLine.Description := STRSUBSTNO(Text027 + Text015,WORKDATE);
            GenJnlPostLineTmp(GenJnlLine);
            RoundingResiduals[i] := RoundingResiduals[i] + GenJnlLine.Amount;
          END;
          IF EqExchRateAdjAmts[i] <> 0 THEN BEGIN
            GenJnlLine.Amount := EqExchRateAdjAmts[i];
            IF (BusUnit."Consolidation %" < 100) AND
               (BusUnit."Consolidation %" > 0)
            THEN BEGIN
              GenJnlLine.Amount := GenJnlLine.Amount * 100 / BusUnit."Consolidation %";
              MinorExchRateAdjAmts[i] :=
                MinorExchRateAdjAmts[i] - GenJnlLine.Amount + EqExchRateAdjAmts[i];
            END;
            IF GenJnlLine.Amount < 0 THEN BEGIN
              BusUnit.TESTFIELD("Equity Exch. Rate Gains Acc.");
              GenJnlLine."Account No." := BusUnit."Equity Exch. Rate Gains Acc.";
            END ELSE BEGIN
              BusUnit.TESTFIELD("Equity Exch. Rate Losses Acc.");
              GenJnlLine."Account No." := BusUnit."Equity Exch. Rate Losses Acc.";
            END;
            Window.UPDATE(3,GenJnlLine."Account No.");
            IF NOT ConsolidatingClosingDate THEN
              GenJnlLine."Posting Date" := StartingDate + i - 1
            ELSE
              GenJnlLine."Posting Date" := StartingDate;
            GenJnlLine.Description := STRSUBSTNO(Text028 + Text015,WORKDATE);
            GenJnlPostLineTmp(GenJnlLine);
            RoundingResiduals[i] := RoundingResiduals[i] + GenJnlLine.Amount;
          END;
          IF MinorExchRateAdjAmts[i] <> 0 THEN BEGIN
            GenJnlLine.Amount := MinorExchRateAdjAmts[i];
            IF GenJnlLine.Amount < 0 THEN BEGIN
              BusUnit.TESTFIELD("Minority Exch. Rate Gains Acc.");
              GenJnlLine."Account No." := BusUnit."Minority Exch. Rate Gains Acc.";
            END ELSE BEGIN
              BusUnit.TESTFIELD("Minority Exch. Rate Losses Acc");
              GenJnlLine."Account No." := BusUnit."Minority Exch. Rate Losses Acc";
            END;
            Window.UPDATE(3,GenJnlLine."Account No.");
            GenJnlLine."Posting Date" := StartingDate + i - 1;
            GenJnlLine.Description := STRSUBSTNO(Text029 + Text015,WORKDATE);
            GenJnlPostLineTmp(GenJnlLine);
            RoundingResiduals[i] := RoundingResiduals[i] + GenJnlLine.Amount;
          END;
          IF RoundingResiduals[i] <> 0 THEN BEGIN
            GenJnlLine.Amount := -RoundingResiduals[i];
            BusUnit.TESTFIELD("Residual Account");
            GenJnlLine."Account No." := BusUnit."Residual Account";
            Window.UPDATE(3,GenJnlLine."Account No.");
            IF NOT ConsolidatingClosingDate THEN
              GenJnlLine."Posting Date" := StartingDate + i - 1
            ELSE
              GenJnlLine."Posting Date" := StartingDate;
            GenJnlLine.Description :=
              COPYSTR(
                STRSUBSTNO(Text016,WORKDATE,GenJnlLine.Amount),
                1,MAXSTRLEN(GenJnlLine.Description));
            GenJnlPostLineTmp(GenJnlLine);
          END;
        END;

        IF NOT TestMode THEN BEGIN
          UpdatePhase(Text026);
          GenJnlPostLineFinally;
        END;
        Window.CLOSE;

        IF NOT TestMode THEN BEGIN
          BusUnit."Last Balance Currency Factor" := BusUnit."Balance Currency Factor";
          BusUnit.MODIFY;
        END;

        IF AnalysisViewEntriesDeleted THEN
          MESSAGE(Text005);
    end;

    var
        BusUnit: Record "220";
        ConsolidGLAcc: Record "15";
        ConsolidGLEntry: Record "17";
        ConsolidDimSetEntry: Record "480";
        ConsolidCurrExchRate: Record "330";
        TempSubsidGLAcc: Record "15" temporary;
        TempSubsidGLEntry: Record "17" temporary;
        TempSubsidDimBuf: Record "360" temporary;
        TempSubsidCurrExchRate: Record "330" temporary;
        TempSelectedDim: Record "369" temporary;
        GenJnlLine: Record "81";
        TempGenJnlLine: Record "81" temporary;
        TempDimBufIn: Record "360" temporary;
        TempDimBufOut: Record "360" temporary;
        DimBufMgt: Codeunit "411";
        DimMgt: Codeunit "408";
        TempGLEntry: Record "17" temporary;
        Window: Dialog;
        GLDocNo: Code[20];
        ProductVersion: Code[10];
        FormatVersion: Code[10];
        SubCompanyName: Text[30];
        CurrencyLCY: Code[10];
        CurrencyACY: Code[10];
        CurrencyPCY: Code[10];
        StoredCheckSum: Decimal;
        StartingDate: Date;
        EndingDate: Date;
        ConsolidSourceCode: Code[10];
        RoundingResiduals: array [500] of Decimal;
        ExchRateAdjAmounts: array [500] of Decimal;
        CompExchRateAdjAmts: array [500] of Decimal;
        EqExchRateAdjAmts: array [500] of Decimal;
        MinorExchRateAdjAmts: array [500] of Decimal;
        DeletedAmounts: array [500] of Decimal;
        DeletedDates: array [500] of Date;
        DeletedIndex: Integer;
        MaxDeletedIndex: Integer;
        AnalysisViewEntriesDeleted: Boolean;
        Text000: Label 'Enter a document number.';
        Text001: Label 'Consolidating companies...\\';
        Text002: Label 'Business Unit Code   #1###################\';
        Text003: Label 'Phase                #2############################\';
        Text004: Label 'G/L Account No.      #3##################';
        Text005: Label 'Analysis View Entries were deleted during the consolidation. An update is necessary.';
        Text006: Label 'There are more than %1 errors.';
        Text008: Label 'The consolidation can include a maximum of %1 days.';
        Text010: Label 'Previously consolidated entries cannot be erased because this would cause the general ledger to be out of balance by an amount of %1. ';
        Text011: Label ' Check for manually posted G/L entries on %2 for posting across business units.';
        Text013: Label '%1 adjusted from %2 to %3 on %4';
        Text014: Label 'Adjustment of opening entries on %1';
        Text015: Label 'Exchange rate adjustment on %1';
        Text016: Label 'Posted %2 to residual account as of %1';
        Text017: Label '%1 at exchange rate %2 on %3';
        Text018: Label 'Clear Previous Consolidation';
        SkipAllDimensions: Boolean;
        Text019: Label 'Update Prior Period Balances';
        ConsolidatingClosingDate: Boolean;
        ExchRateAdjAmount: Decimal;
        HistoricalCurrencyFactor: Decimal;
        NextLineNo: Integer;
        Text020: Label 'Consolidate Current Data';
        Text021: Label 'Within the Subsidiary (%5), there are two G/L Accounts: %1 and %4; which refer to the same %2, but with a different %3.';
        Text022: Label '%1 %2, referenced by %5 %3 %4, does not exist in the consolidated %3 table.';
        Text023: Label '%7 %1 %2 must have the same %3 as consolidated %1 %4. (%5 and %6, respectively)';
        Text024: Label '%1 at %2 %3';
        Text025: Label 'Calculate Residual Entries';
        Text026: Label 'Post to General Ledger';
        Text027: Label 'Composite ';
        Text028: Label 'Equity ';
        Text029: Label 'Minority ';
        TestMode: Boolean;
        CurErrorIdx: Integer;
        ErrorText: array [500] of Text[250];
        Text030: Label 'When using closing dates, the starting and ending dates must be the same.';
        Text031: Label 'A %1 with %2 on a closing date (%3) was found while consolidating non-closing entries.';
        Text032: Label 'The %1 is later than the %2 in company %3.';
        Text033: Label '%1 must not be empty when %2 is not empty, in company %3.';
        Text034: Label 'It is not possible to consolidate ledger entry dimensions for G/L Entry No. %1, because there are conflicting dimension values %2 and %3 for consolidation dimension %4.';
        Text50001: Label '%1 at %2 on %3';
        "...............CustomVars................": Integer;
        HistoricalExcRate: Decimal;
        RefCurrencyCode: Code[10];
        CurrentExchRate: Decimal;
        CurrentExchRate2: Decimal;
        NewRefExchRate: Decimal;
        NewRefExchRate2: Decimal;
        RefExchRate: Decimal;
        Text50003: Label 'The %1 field is not set up properly in the Currrency Exchange Rates window. ';
        Text50004: Label 'For %2 or the currency set up in the %3 field, the %1 field should be set to both.';
        GlobalDim1Code: Code[20];
        GlobalDim2Code: Code[20];
        ClearAllHistory: Boolean;

    procedure SetDocNo(NewDocNo: Code[20])
    begin
        GLDocNo := NewDocNo;
        IF GLDocNo = '' THEN
          ERROR(Text000);
    end;

    procedure SetSelectedDim(var SelectedDim: Record "369")
    begin
        TempSelectedDim.RESET;
        TempSelectedDim.DELETEALL;
        SkipAllDimensions := SelectedDim.ISEMPTY;
        IF SkipAllDimensions THEN
          EXIT;

        IF SelectedDim.FINDSET THEN
          REPEAT
            TempSelectedDim := SelectedDim;
            TempSelectedDim."User ID" := '';
            TempSelectedDim."Object Type" := 0;
            TempSelectedDim."Object ID" := 0;
            TempSelectedDim.INSERT;
          UNTIL SelectedDim.NEXT = 0;
    end;

    procedure SetGlobals(NewProductVersion: Code[10];NewFormatVersion: Code[10];NewCompanyName: Text[30];NewCurrencyLCY: Code[10];NewCurrencyACY: Code[10];NewCurrencyPCY: Code[10];NewCheckSum: Decimal;NewStartingDate: Date;NewEndingDate: Date)
    begin
        ProductVersion := NewProductVersion;
        FormatVersion := NewFormatVersion;
        SubCompanyName := NewCompanyName;
        CurrencyLCY := NewCurrencyLCY;
        CurrencyACY := NewCurrencyACY;
        CurrencyPCY := NewCurrencyPCY;
        StoredCheckSum := NewCheckSum;
        StartingDate := NewStartingDate;
        EndingDate := NewEndingDate;
    end;

    procedure InsertGLAccount(NewGLAccount: Record "15")
    begin
        TempSubsidGLAcc.INIT;
        TempSubsidGLAcc."No." := NewGLAccount."No.";
        TempSubsidGLAcc."Consol. Translation Method" := NewGLAccount."Consol. Translation Method";
        TempSubsidGLAcc."Consol. Debit Acc." := NewGLAccount."Consol. Debit Acc.";
        TempSubsidGLAcc."Consol. Credit Acc." := NewGLAccount."Consol. Credit Acc.";
        TempSubsidGLAcc.INSERT;
    end;

    procedure InsertGLEntry(NewGLEntry: Record "17"): Integer
    var
        NextEntryNo: Integer;
    begin
        IF TempSubsidGLEntry.FINDLAST THEN
          NextEntryNo := TempSubsidGLEntry."Entry No." + 1
        ELSE
          NextEntryNo := 1;
        TempSubsidGLEntry.INIT;
        TempSubsidGLEntry."Entry No." := NextEntryNo;
        TempSubsidGLEntry."G/L Account No." := NewGLEntry."G/L Account No.";
        TempSubsidGLEntry."Posting Date" := NewGLEntry."Posting Date";
        TempSubsidGLEntry."Debit Amount" := NewGLEntry."Debit Amount";
        TempSubsidGLEntry."Credit Amount" := NewGLEntry."Credit Amount";
        TempSubsidGLEntry."Add.-Currency Debit Amount" := NewGLEntry."Add.-Currency Debit Amount";
        TempSubsidGLEntry."Add.-Currency Credit Amount" := NewGLEntry."Add.-Currency Credit Amount";
        TempSubsidGLEntry.INSERT;
        EXIT(NextEntryNo);
    end;

    procedure InsertEntryDim(NewDimBuf: Record "360";GLEntryNo: Integer)
    begin
        IF TempSubsidDimBuf.GET(NewDimBuf."Table ID",GLEntryNo,NewDimBuf."Dimension Code") THEN BEGIN
          IF NewDimBuf."Dimension Value Code" <> TempSubsidDimBuf."Dimension Value Code" THEN
            ERROR(
              Text034,GLEntryNo,NewDimBuf."Dimension Value Code",TempSubsidDimBuf."Dimension Value Code",
              NewDimBuf."Dimension Code");
        END ELSE BEGIN
          TempSubsidDimBuf.INIT;
          TempSubsidDimBuf := NewDimBuf;
          TempSubsidDimBuf."Entry No." := GLEntryNo;
          TempSubsidDimBuf.INSERT;
        END;
    end;

    procedure InsertExchRate(NewCurrExchRate: Record "330")
    begin
        TempSubsidCurrExchRate.INIT;
        TempSubsidCurrExchRate."Currency Code" := NewCurrExchRate."Currency Code";
        TempSubsidCurrExchRate."Starting Date" := NewCurrExchRate."Starting Date";
        TempSubsidCurrExchRate."Relational Currency Code" := NewCurrExchRate."Relational Currency Code";
        TempSubsidCurrExchRate."Exchange Rate Amount" := NewCurrExchRate."Exchange Rate Amount";
        TempSubsidCurrExchRate."Relational Exch. Rate Amount" := NewCurrExchRate."Relational Exch. Rate Amount";
        TempSubsidCurrExchRate.INSERT;
    end;

    procedure UpdateGLEntryDimSetID()
    begin
        IF SkipAllDimensions THEN
          EXIT;

        TempSubsidGLEntry.RESET;
        TempSubsidDimBuf.RESET;
        TempSubsidDimBuf.SETRANGE("Table ID",DATABASE::"G/L Entry");
        WITH TempSubsidGLEntry DO BEGIN
          RESET;
          IF FINDSET(TRUE,FALSE) THEN
            REPEAT
              TempSubsidDimBuf.SETRANGE("Entry No.","Entry No.");
              IF NOT TempSubsidDimBuf.ISEMPTY THEN BEGIN
                "Dimension Set ID" := DimMgt.CreateDimSetIDFromDimBuf(TempSubsidDimBuf);
                MODIFY;
              END;
            UNTIL NEXT = 0;
        END;
    end;

    procedure CalcCheckSum() CheckSum: Decimal
    begin
        CheckSum :=
          DateToDecimal(StartingDate) + DateToDecimal(EndingDate) +
          TextToDecimal(FormatVersion) + TextToDecimal(ProductVersion);
        TempSubsidGLAcc.RESET;
        IF TempSubsidGLAcc.FINDSET THEN
          REPEAT
            CheckSum :=
              CheckSum +
              TextToDecimal(COPYSTR(TempSubsidGLAcc."No.",1,10)) + TextToDecimal(COPYSTR(TempSubsidGLAcc."No.",11,10)) +
              TextToDecimal(COPYSTR(TempSubsidGLAcc."Consol. Debit Acc.",1,10)) +
              TextToDecimal(COPYSTR(TempSubsidGLAcc."Consol. Debit Acc.",11,10)) +
              TextToDecimal(COPYSTR(TempSubsidGLAcc."Consol. Credit Acc.",1,10)) +
              TextToDecimal(COPYSTR(TempSubsidGLAcc."Consol. Credit Acc.",11,10)) ;
          UNTIL TempSubsidGLAcc.NEXT = 0;
        TempSubsidGLEntry.RESET;
        IF TempSubsidGLEntry.FINDSET THEN
          REPEAT
            CheckSum := CheckSum +
              TempSubsidGLEntry."Debit Amount" + TempSubsidGLEntry."Credit Amount" +
              TempSubsidGLEntry."Add.-Currency Debit Amount" + TempSubsidGLEntry."Add.-Currency Credit Amount" +
              DateToDecimal(TempSubsidGLEntry."Posting Date");
          UNTIL TempSubsidGLEntry.NEXT = 0;
    end;

    procedure ImportFromXML(FileName: Text)
    var
        Consolidation: XMLport "1";
        InputFile: File;
        InputStream: InStream;
    begin
        InputFile.TEXTMODE(TRUE);
        InputFile.WRITEMODE(FALSE);
        InputFile.OPEN(FileName);

        InputFile.CREATEINSTREAM(InputStream);

        Consolidation.SETSOURCE(InputStream);
        Consolidation.IMPORT;
        InputFile.CLOSE;

        Consolidation.GetGLAccount(TempSubsidGLAcc);
        Consolidation.GetGLEntry(TempSubsidGLEntry);
        Consolidation.GetEntryDim(TempSubsidDimBuf);
        Consolidation.GetExchRate(TempSubsidCurrExchRate);
        Consolidation.GetGlobals(
          ProductVersion,FormatVersion,SubCompanyName,CurrencyLCY,CurrencyACY,CurrencyPCY,
          StoredCheckSum,StartingDate,EndingDate);

        SelectAllImportedDimensions;
    end;

    procedure ExportToXML(FileName: Text)
    var
        Consolidation: XMLport "1";
        OutputFile: File;
        OutputStream: OutStream;
    begin
        OutputFile.TEXTMODE(TRUE);
        OutputFile.WRITEMODE(TRUE);
        OutputFile.CREATE(FileName);

        OutputFile.CREATEOUTSTREAM(OutputStream);

        Consolidation.SetGlobals(SubCompanyName,CurrencyLCY,CurrencyACY,CurrencyPCY,StoredCheckSum,StartingDate,EndingDate);
        Consolidation.SetGLAccount(TempSubsidGLAcc);
        Consolidation.SetGLEntry(TempSubsidGLEntry);
        Consolidation.SetEntryDim(TempSubsidDimBuf);
        Consolidation.SetExchRate(TempSubsidCurrExchRate);

        Consolidation.SETDESTINATION(OutputStream);
        Consolidation.EXPORT;
        OutputFile.CLOSE;
    end;

    procedure GetGlobals(var ImpProductVersion: Code[10];var ImpFormatVersion: Code[10];var ImpCompanyName: Text[30];var ImpCurrencyLCY: Code[10];var ImpCurrencyACY: Code[10];var ImpCurrencyPCY: Code[10];var ImpCheckSum: Decimal;var ImpStartingDate: Date;var ImpEndingDate: Date)
    begin
        ImpProductVersion := ProductVersion;
        ImpFormatVersion := FormatVersion;
        ImpCompanyName := SubCompanyName;
        ImpCurrencyLCY := CurrencyLCY;
        ImpCurrencyACY := CurrencyACY;
        ImpCurrencyPCY := CurrencyPCY;
        ImpCheckSum := StoredCheckSum;
        ImpStartingDate := StartingDate;
        ImpEndingDate := EndingDate;
    end;

    procedure SetTestMode(NewTestMode: Boolean)
    begin
        TestMode := NewTestMode;
        CurErrorIdx := 0;
    end;

    procedure GetAccumulatedErrors(var NumErrors: Integer;var Errors: array [100] of Text[250])
    var
        Idx: Integer;
    begin
        NumErrors := 0;
        CLEAR(Errors);
        FOR Idx := 1 TO CurErrorIdx DO BEGIN
          NumErrors := NumErrors + 1;
          Errors[NumErrors] := ErrorText[Idx];
          IF (Idx = ARRAYLEN(Errors)) AND (CurErrorIdx > Idx) THEN BEGIN
            COPYARRAY(ErrorText,ErrorText,ARRAYLEN(Errors) + 1);
            CurErrorIdx := CurErrorIdx - ARRAYLEN(Errors);
            EXIT;
          END;
        END;
        CurErrorIdx := 0;
        CLEAR(ErrorText);
    end;

    procedure SelectAllImportedDimensions()
    begin
        // assume all dimensions that were imported were also selected.
        TempSelectedDim.RESET;
        TempSelectedDim.DELETEALL;
        IF TempSubsidDimBuf.FINDSET THEN
          REPEAT
            TempSelectedDim.INIT;
            TempSelectedDim."User ID" := '';
            TempSelectedDim."Object Type" := 0;
            TempSelectedDim."Object ID" := 0;
            TempSelectedDim."Dimension Code" := TempSubsidDimBuf."Dimension Code";
            IF TempSelectedDim.INSERT THEN ;
          UNTIL TempSubsidDimBuf.NEXT = 0;
        SkipAllDimensions := TempSelectedDim.ISEMPTY;
    end;

    local procedure ReadSourceCodeSetup()
    var
        SourceCodeSetup: Record "242";
    begin
        SourceCodeSetup.GET;
        ConsolidSourceCode := SourceCodeSetup.Consolidation;
    end;

    local procedure ClearInternals()
    begin
        NextLineNo := 0;
        AnalysisViewEntriesDeleted := FALSE;
        TempGenJnlLine.RESET;
        TempGenJnlLine.DELETEALL;
        TempDimBufOut.RESET;
        TempDimBufOut.DELETEALL;
        TempDimBufIn.RESET;
        TempDimBufIn.DELETEALL;
        CLEAR(RoundingResiduals);
        CLEAR(ExchRateAdjAmounts);
        CLEAR(CompExchRateAdjAmts);
        CLEAR(EqExchRateAdjAmts);
        CLEAR(MinorExchRateAdjAmts);
    end;

    local procedure UpdatePhase(PhaseText: Text[50])
    begin
        Window.UPDATE(2,PhaseText);
        Window.UPDATE(3,'');
    end;

    local procedure ClearPreviousConsolidation()
    var
        TempGLAccount: Record "15" temporary;
        AnalysisView: Record "363";
        TempAnalysisView: Record "363" temporary;
        AnalysisViewEntry: Record "365";
        AnalysisViewFound: Boolean;
    begin
        ClearAmountArray;
        WITH ConsolidGLEntry DO BEGIN
          IF NOT
             SETCURRENTKEY("G/L Account No.","Business Unit Code","Global Dimension 1 Code","Global Dimension 2 Code","Posting Date")
          THEN
            SETCURRENTKEY("G/L Account No.","Business Unit Code","Posting Date");
          SETRANGE("Business Unit Code",BusUnit.Code);
          SETRANGE("Posting Date",StartingDate,EndingDate);
          IF FINDSET(TRUE,FALSE) THEN
            REPEAT
              UpdateAmountArray("Posting Date",Amount);
              Description := '';
              Amount := 0;
              "Debit Amount" := 0;
              "Credit Amount" := 0;
              "Additional-Currency Amount" := 0;
              "Add.-Currency Debit Amount" := 0;
              "Add.-Currency Credit Amount" := 0;
              MODIFY;
              IF "G/L Account No." <> TempGLAccount."No." THEN BEGIN
                Window.UPDATE(3,"G/L Account No.");
                TempGLAccount."No." := "G/L Account No.";
                TempGLAccount.INSERT;
              END;
            UNTIL NEXT = 0;
        END;
        CheckAmountArray;

        IF AnalysisView.FINDSET THEN
          REPEAT
            AnalysisViewFound := FALSE;
            IF TempGLAccount.FINDSET THEN
              REPEAT
                AnalysisViewEntry.SETRANGE("Analysis View Code",AnalysisView.Code);
                AnalysisViewEntry.SETRANGE("Account No.",TempGLAccount."No.");
                AnalysisViewEntry.SETRANGE("Account Source",AnalysisViewEntry."Account Source"::"G/L Account");
                IF AnalysisViewEntry.FINDFIRST THEN BEGIN
                  TempAnalysisView.Code := AnalysisViewEntry."Analysis View Code";
                  TempAnalysisView."Account Source" := AnalysisViewEntry."Account Source";
                  TempAnalysisView.INSERT;
                  AnalysisViewFound := TRUE;
                END;
              UNTIL (TempGLAccount.NEXT = 0) OR AnalysisViewFound;
          UNTIL AnalysisView.NEXT = 0;

        AnalysisViewEntry.RESET;
        IF TempAnalysisView.FINDSET THEN
          REPEAT
            AnalysisView.GET(TempAnalysisView.Code);
            IF AnalysisView.Blocked THEN BEGIN
              AnalysisView."Refresh When Unblocked" := TRUE;
              AnalysisView.MODIFY;
            END ELSE BEGIN
              AnalysisViewEntry.SETRANGE("Analysis View Code",TempAnalysisView.Code);
              AnalysisViewEntry.DELETEALL;
              AnalysisView."Last Entry No." := 0;
              AnalysisView."Last Date Updated" := 0D;
              AnalysisView.MODIFY;
              AnalysisViewEntriesDeleted := TRUE;
            END;
          UNTIL TempAnalysisView.NEXT = 0;
    end;

    local procedure ClearAmountArray()
    begin
        CLEAR(DeletedAmounts);
        CLEAR(DeletedDates);
        DeletedIndex := 0;
        MaxDeletedIndex := 0;
    end;

    local procedure UpdateAmountArray(PostingDate: Date;Amount: Decimal)
    var
        Top: Integer;
        Bottom: Integer;
        Middle: Integer;
        Found: Boolean;
        NotFound: Boolean;
        idx: Integer;
    begin
        IF DeletedIndex = 0 THEN BEGIN
          DeletedIndex := 1;
          MaxDeletedIndex := 1;
          DeletedDates[DeletedIndex] := PostingDate;
          DeletedAmounts[DeletedIndex] := Amount;
        END ELSE
          IF PostingDate = DeletedDates[DeletedIndex] THEN
            DeletedAmounts[DeletedIndex] := DeletedAmounts[DeletedIndex] + Amount
          ELSE BEGIN
            Top := 0;
            Bottom := MaxDeletedIndex + 1;
            Found := FALSE;
            NotFound := FALSE;
            REPEAT
              Middle := (Top + Bottom) DIV 2;
              IF Bottom - Top <= 1 THEN
                NotFound := TRUE
              ELSE
                IF DeletedDates[Middle] > PostingDate THEN
                  Bottom := Middle
                ELSE
                  IF DeletedDates[Middle] < PostingDate THEN
                    Top := Middle
                  ELSE
                    Found := TRUE;
            UNTIL Found OR NotFound;
            IF Found THEN BEGIN
              DeletedIndex := Middle;
              DeletedAmounts[DeletedIndex] := DeletedAmounts[DeletedIndex] + Amount;
            END ELSE BEGIN
              IF MaxDeletedIndex >= ARRAYLEN(DeletedDates) THEN
                ReportError(STRSUBSTNO(Text008,ARRAYLEN(DeletedDates)))
              ELSE
                MaxDeletedIndex := MaxDeletedIndex + 1;
              FOR idx := MaxDeletedIndex DOWNTO Bottom + 1 DO BEGIN
                DeletedAmounts[idx] := DeletedAmounts[idx - 1];
                DeletedDates[idx] := DeletedDates[idx - 1];
              END;
              DeletedIndex := Bottom;
              DeletedDates[DeletedIndex] := PostingDate;
              DeletedAmounts[DeletedIndex] := Amount;
            END;
          END;
    end;

    local procedure CheckAmountArray()
    var
        idx: Integer;
    begin
        FOR idx := 1 TO MaxDeletedIndex DO
          IF DeletedAmounts[idx] <> 0 THEN
            ReportError(STRSUBSTNO(Text010 + Text011,DeletedAmounts[idx],DeletedDates[idx]));
    end;

    local procedure TestGLAccounts()
    var
        AccountToTest: Record "15";
    begin
        // First test within the Subsidiary Chart of Accounts
        AccountToTest := TempSubsidGLAcc;
        IF AccountToTest.TranslationMethodConflict(TempSubsidGLAcc) THEN BEGIN
          IF TempSubsidGLAcc.GETFILTER("Consol. Debit Acc.") <> '' THEN
            ReportError(
              STRSUBSTNO(
                Text021,
                TempSubsidGLAcc."No.",
                TempSubsidGLAcc.FIELDCAPTION("Consol. Debit Acc."),
                TempSubsidGLAcc.FIELDCAPTION("Consol. Translation Method"),
                AccountToTest."No.",BusUnit.TABLECAPTION))
          ELSE
            ReportError(
              STRSUBSTNO(Text021,
                TempSubsidGLAcc."No.",
                TempSubsidGLAcc.FIELDCAPTION("Consol. Credit Acc."),
                TempSubsidGLAcc.FIELDCAPTION("Consol. Translation Method"),
                AccountToTest."No.",BusUnit.TABLECAPTION));
        END ELSE BEGIN
          TempSubsidGLAcc.RESET;
          TempSubsidGLAcc := AccountToTest;
          TempSubsidGLAcc.FIND('=');
        END;
        // Then, test for conflicts between subsidiary and parent (consolidated)
        IF TempSubsidGLAcc."Consol. Debit Acc." <> '' THEN BEGIN
          IF NOT ConsolidGLAcc.GET(TempSubsidGLAcc."Consol. Debit Acc.") THEN
            ReportError(
              STRSUBSTNO(Text022,
                TempSubsidGLAcc.FIELDCAPTION("Consol. Debit Acc."),TempSubsidGLAcc."Consol. Debit Acc.",
                TempSubsidGLAcc.TABLECAPTION,TempSubsidGLAcc."No.",BusUnit.TABLECAPTION));
          IF (TempSubsidGLAcc."Consol. Translation Method" <> ConsolidGLAcc."Consol. Translation Method") AND
             (BusUnit."File Format" <> BusUnit."File Format"::"Version 3.70 or Earlier (.txt)")
          THEN
            ReportError(
              STRSUBSTNO(Text023,
                TempSubsidGLAcc.TABLECAPTION,TempSubsidGLAcc."No.",
                TempSubsidGLAcc.FIELDCAPTION("Consol. Translation Method"),ConsolidGLAcc."No.",
                TempSubsidGLAcc."Consol. Translation Method",ConsolidGLAcc."Consol. Translation Method",
                BusUnit.TABLECAPTION));
        END;
        IF TempSubsidGLAcc."Consol. Debit Acc." = TempSubsidGLAcc."Consol. Credit Acc." THEN
          EXIT;
        IF TempSubsidGLAcc."Consol. Credit Acc." <> '' THEN BEGIN
          IF NOT ConsolidGLAcc.GET(TempSubsidGLAcc."Consol. Credit Acc.") THEN
            ReportError(
              STRSUBSTNO(Text022,
                TempSubsidGLAcc.FIELDCAPTION("Consol. Credit Acc."),TempSubsidGLAcc."Consol. Credit Acc.",
                TempSubsidGLAcc.TABLECAPTION,TempSubsidGLAcc."No.",BusUnit.TABLECAPTION));
          IF (TempSubsidGLAcc."Consol. Translation Method" <> ConsolidGLAcc."Consol. Translation Method") AND
             (BusUnit."File Format" <> BusUnit."File Format"::"Version 3.70 or Earlier (.txt)")
          THEN
            ReportError(
              STRSUBSTNO(Text023,
                TempSubsidGLAcc.TABLECAPTION,TempSubsidGLAcc."No.",
                TempSubsidGLAcc.FIELDCAPTION("Consol. Translation Method"),ConsolidGLAcc."No.",
                TempSubsidGLAcc."Consol. Translation Method",ConsolidGLAcc."Consol. Translation Method",
                BusUnit.TABLECAPTION));
        END;
    end;

    local procedure UpdatePriorPeriodBalances()
    var
        idx: Integer;
        AdjustmentAmount: Decimal;
    begin
        CLEAR(GenJnlLine);
        GenJnlLine."Business Unit Code" := BusUnit.Code;
        GenJnlLine."Document No." := GLDocNo;
        GenJnlLine."Source Code" := ConsolidSourceCode;

        BusUnit.TESTFIELD("Balance Currency Factor");
        BusUnit.TESTFIELD("Last Balance Currency Factor");
        ExchRateAdjAmount := 0;
        idx := NORMALDATE(EndingDate) - NORMALDATE(StartingDate) + 1;

        WITH ConsolidGLAcc DO BEGIN
          RESET;
          SETRANGE("Account Type","Account Type"::Posting);
          SETRANGE("Business Unit Filter",BusUnit.Code);
          SETRANGE("Date Filter",0D,EndingDate);
          SETRANGE("Income/Balance","Income/Balance"::"Balance Sheet");
          SETFILTER(
            "No.",'<>%1&<>%2&<>%3&<>%4&<>%5&<>%6&<>%7&<>%8&<>%9',
            BusUnit."Exch. Rate Losses Acc.",BusUnit."Exch. Rate Gains Acc.",
            BusUnit."Comp. Exch. Rate Gains Acc.",BusUnit."Comp. Exch. Rate Losses Acc.",
            BusUnit."Equity Exch. Rate Gains Acc.",BusUnit."Equity Exch. Rate Losses Acc.",
            BusUnit."Minority Exch. Rate Gains Acc.",BusUnit."Minority Exch. Rate Losses Acc",
            BusUnit."Residual Account");
          IF FINDSET THEN
            REPEAT
              Window.UPDATE(3,"No.");
              CASE "Consol. Translation Method" OF
                "Consol. Translation Method"::"Average Rate (Manual)",
                "Consol. Translation Method"::"Closing Rate":
                  // Post adjustment to existing balance to convert that balance to new Closing Rate
                  IF SkipAllDimensions THEN BEGIN
                    CALCFIELDS("Debit Amount","Credit Amount");
                    IF "Debit Amount" <> 0 THEN
                      PostBalanceAdjustment("No.","Debit Amount");
                    IF "Credit Amount" <> 0 THEN
                      PostBalanceAdjustment("No.",-"Credit Amount");
                  END ELSE BEGIN
                    TempGLEntry.RESET;
                    TempGLEntry.DELETEALL;
                    DimBufMgt.DeleteAllDimensions;
                    ConsolidGLEntry.RESET;
                    ConsolidGLEntry.SETCURRENTKEY("G/L Account No.","Posting Date");
                    ConsolidGLEntry.SETRANGE("G/L Account No.","No.");
                    ConsolidGLEntry.SETRANGE("Posting Date",0D,EndingDate);
                    ConsolidGLEntry.SETRANGE("Business Unit Code",BusUnit.Code);
                    IF ConsolidGLEntry.FINDSET THEN
                      REPEAT
                        TempDimBufIn.RESET;
                        TempDimBufIn.DELETEALL;
                        ConsolidDimSetEntry.SETRANGE("Dimension Set ID",ConsolidGLEntry."Dimension Set ID");
                        IF ConsolidDimSetEntry.FINDSET THEN
                          REPEAT
                            IF TempSelectedDim.GET('',0,0,'',ConsolidDimSetEntry."Dimension Code") THEN BEGIN
                              TempDimBufIn.INIT;
                              TempDimBufIn."Table ID" := DATABASE::"G/L Entry";
                              TempDimBufIn."Entry No." := ConsolidGLEntry."Entry No.";
                              TempDimBufIn."Dimension Code" := ConsolidDimSetEntry."Dimension Code";
                              TempDimBufIn."Dimension Value Code" := ConsolidDimSetEntry."Dimension Value Code";
                              TempDimBufIn.INSERT;
                            END;
                          UNTIL ConsolidDimSetEntry.NEXT = 0;
                        UpdateTempGLEntry(ConsolidGLEntry);
                      UNTIL ConsolidGLEntry.NEXT = 0;
                    TempDimBufOut.RESET;
                    TempDimBufOut.DELETEALL;
                    IF TempGLEntry.FINDSET THEN
                      REPEAT
                        DimBufMgt.GetDimensions(TempGLEntry."Entry No.",TempDimBufOut);
                        TempDimBufOut.SETRANGE("Entry No.",TempGLEntry."Entry No.");
                        IF TempGLEntry."Debit Amount" <> 0 THEN
                          PostBalanceAdjustment("No.",TempGLEntry."Debit Amount");
                        IF TempGLEntry."Credit Amount" <> 0 THEN
                          PostBalanceAdjustment("No.",-TempGLEntry."Credit Amount");
                      UNTIL TempGLEntry.NEXT = 0;
                  END;
                "Consol. Translation Method"::"Historical Rate":
                  // accumulate adjustment for historical accounts
                  BEGIN
                    CALCFIELDS("Balance at Date");
                    AdjustmentAmount := 0;
                    ExchRateAdjAmounts[idx] := ExchRateAdjAmounts[idx] + AdjustmentAmount;
                  END;
                "Consol. Translation Method"::"Composite Rate":
                  // accumulate adjustment for composite accounts
                  BEGIN
                    CALCFIELDS("Balance at Date");
                    AdjustmentAmount := 0;
                    CompExchRateAdjAmts[idx] := CompExchRateAdjAmts[idx] + AdjustmentAmount;
                  END;
                "Consol. Translation Method"::"Equity Rate":
                  // accumulate adjustment for equity accounts
                  BEGIN
                    CALCFIELDS("Balance at Date");
                    AdjustmentAmount := 0;
                    EqExchRateAdjAmts[idx] := EqExchRateAdjAmts[idx] + AdjustmentAmount;
                  END;
              END;
            UNTIL NEXT = 0;
        END;

        TempDimBufOut.RESET;
        TempDimBufOut.DELETEALL;

        IF ExchRateAdjAmount <> 0 THEN BEGIN
          CLEAR(GenJnlLine);
          GenJnlLine."Business Unit Code" := BusUnit.Code;
          GenJnlLine."Document No." := GLDocNo;
          GenJnlLine."Source Code" := ConsolidSourceCode;
          GenJnlLine.Amount := -ExchRateAdjAmount;
          IF GenJnlLine.Amount < 0 THEN BEGIN
            BusUnit.TESTFIELD("Exch. Rate Gains Acc.");
            GenJnlLine."Account No." := BusUnit."Exch. Rate Gains Acc.";
          END ELSE BEGIN
            BusUnit.TESTFIELD("Exch. Rate Losses Acc.");
            GenJnlLine."Account No." := BusUnit."Exch. Rate Losses Acc.";
          END;
          Window.UPDATE(3,GenJnlLine."Account No.");
          GenJnlLine."Posting Date" := EndingDate;
          GenJnlLine.Description := STRSUBSTNO(Text014,WORKDATE);
          GenJnlPostLineTmp(GenJnlLine);
        END;
    end;

    local procedure PostBalanceAdjustment(GLAccNo: Code[20];AmountToPost: Decimal)
    var
        TempDimSetEntry2: Record "480" temporary;
        DimValue: Record "349";
    begin
        GenJnlLine.Amount :=
          ROUND(
            (AmountToPost * BusUnit."Last Balance Currency Factor" / BusUnit."Balance Currency Factor") - AmountToPost);
        IF GenJnlLine.Amount <> 0 THEN BEGIN
          GenJnlLine."Account No." := GLAccNo;
          GenJnlLine."Posting Date" := EndingDate;
        //\\ RAM --- 01
        //GenJnlLine."Console. Adjustment Entry" := TRUE; // Check it - Code bring out from OLD
        //\\RAM +++01

          GenJnlLine.Description :=
            COPYSTR(
              STRSUBSTNO(
                Text013,
                AmountToPost,
                //\\RAM ---01
                //ROUND(BusUnit."Last Balance Currency Factor",0.00001), //Commented the standard Code //RAM
                //ROUND(BusUnit."Balance Currency Factor",0.00001),//Commented the standard Code //RAM
                //\\RAM ---01
                ROUND(1/BusUnit."Last Balance Currency Factor",0.00001),
                ROUND(1/BusUnit."Balance Currency Factor",0.00001),
               //\\RAM +++01
                WORKDATE),
              1,MAXSTRLEN(GenJnlLine.Description));
          IF TempDimBufOut.FINDSET THEN BEGIN
            REPEAT
              TempDimSetEntry2.INIT;
              TempDimSetEntry2."Dimension Code" := TempDimBufOut."Dimension Code";
              TempDimSetEntry2."Dimension Value Code" := TempDimBufOut."Dimension Value Code";
              DimValue.GET(TempDimSetEntry2."Dimension Code",TempDimSetEntry2."Dimension Value Code");
              TempDimSetEntry2."Dimension Value ID" := DimValue."Dimension Value ID";
              TempDimSetEntry2.INSERT;
            UNTIL TempDimBufOut.NEXT = 0;
            GenJnlLine."Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry2);
          END;
          GenJnlPostLineTmp(GenJnlLine);
          ExchRateAdjAmount := ExchRateAdjAmount + GenJnlLine.Amount;
        END;
    end;

    local procedure UpdateTempGLEntry(var GLEntry: Record "17")
    var
        DimEntryNo: Integer;
        Found: Boolean;
    begin
        DimEntryNo := DimBufMgt.FindDimensions(TempDimBufIn);
        Found := TempDimBufIn.FINDFIRST;
        IF Found AND (DimEntryNo = 0) THEN BEGIN
          TempGLEntry := GLEntry;
        //\\ RAM ---01
        // TempGLEntry."Automatic Elimination Entry" := GLEntry."Automatic Elimination Entry";  //---------- Check it, Bring Out from Old//RAM
        //\\ RAM +++01
          TempGLEntry."Entry No." := DimBufMgt.InsertDimensions(TempDimBufIn);
          TempGLEntry.INSERT;
        END ELSE BEGIN
          IF TempGLEntry.GET(DimEntryNo) THEN BEGIN
            TempGLEntry.Amount := TempGLEntry.Amount + GLEntry.Amount;
            TempGLEntry."Debit Amount" := TempGLEntry."Debit Amount" + GLEntry."Debit Amount";
            TempGLEntry."Credit Amount" := TempGLEntry."Credit Amount" + GLEntry."Credit Amount";
            TempGLEntry."Additional-Currency Amount" := TempGLEntry."Additional-Currency Amount" + GLEntry."Additional-Currency Amount";
            TempGLEntry."Add.-Currency Debit Amount" := TempGLEntry."Add.-Currency Debit Amount" + GLEntry."Add.-Currency Debit Amount";
            TempGLEntry."Add.-Currency Credit Amount" :=
              TempGLEntry."Add.-Currency Credit Amount" + GLEntry."Add.-Currency Credit Amount";
         //\\ RAM ---01
         // TempGLEntry."Automatic Elimination Entry" := GLEntry."Automatic Elimination Entry";  //---------- Check it, Bring Out from Old//RAM
         //\\ RAM +++01

            TempGLEntry.MODIFY;
          END ELSE BEGIN
            TempGLEntry := GLEntry;
         //\\ RAM ---01
         // TempGLEntry."Automatic Elimination Entry" := GLEntry."Automatic Elimination Entry";  //---------- Check it, Bring Out from Old//RAM
         //\\ RAM +++01

            TempGLEntry."Entry No." := DimEntryNo;
            TempGLEntry.INSERT;
          END;
        END;
    end;

    local procedure CreateAndPostGenJnlLine(GenJnlLine: Record "81";var GLEntry: Record "17";var DimBuf: Record "360";PostDebit: Boolean)
    var
        TempDimSetEntry2: Record "480" temporary;
        DimValue: Record "349";
        ConsolidAmount: Decimal;
        AmountToPost: Decimal;
        AdjustAmount: Decimal;
        ClosingAmount: Decimal;
        TranslationNeeded: Boolean;
        idx: Integer;
        OriginalTranslationMethod: Integer;
    begin
        WITH GenJnlLine DO BEGIN
          IF PostDebit THEN BEGIN
            IF BusUnit."Data Source" = BusUnit."Data Source"::"Local Curr. (LCY)" THEN
              AmountToPost := GLEntry."Debit Amount"
            ELSE
              AmountToPost := GLEntry."Add.-Currency Debit Amount";
            "Account No." := TempSubsidGLAcc."Consol. Debit Acc.";
          END ELSE BEGIN
            IF BusUnit."Data Source" = BusUnit."Data Source"::"Local Curr. (LCY)" THEN
              AmountToPost := -GLEntry."Credit Amount"
            ELSE
              AmountToPost := -GLEntry."Add.-Currency Credit Amount";
            "Account No." := TempSubsidGLAcc."Consol. Credit Acc.";
          END;
          IF "Account No." = '' THEN
            "Account No." := TempSubsidGLAcc."No.";
          IF AmountToPost = 0 THEN
            EXIT;
          ConsolidGLAcc.GET("Account No.");
        
          OriginalTranslationMethod := TempSubsidGLAcc."Consol. Translation Method";
          IF TempSubsidGLAcc."Consol. Translation Method" = TempSubsidGLAcc."Consol. Translation Method"::"Average Rate (Manual)" THEN
            IF ConsolidGLAcc."Income/Balance" = ConsolidGLAcc."Income/Balance"::"Balance Sheet" THEN
              TempSubsidGLAcc."Consol. Translation Method" := TempSubsidGLAcc."Consol. Translation Method"::"Closing Rate";
        
          ConsolidAmount := AmountToPost * BusUnit."Consolidation %" / 100;
        //\\ RAM ---01
        // GenJnlLine."Automatic Elimination Entry" := GLEntry."Automatic Elimination Entry";  //---------- Check it, Bring Out from Old//RAM
        //\\ RAM +++01
        
        
          TranslationNeeded := (BusUnit."Currency Code" <> '');
          IF TranslationNeeded THEN
            IF BusUnit."Data Source" = BusUnit."Data Source"::"Add. Rep. Curr. (ACY)" THEN
              TranslationNeeded := (BusUnit."Currency Code" <> CurrencyACY);
        
          IF TranslationNeeded THEN BEGIN
            ClosingAmount :=
              ROUND(
                ConsolidCurrExchRate.ExchangeAmtFCYToLCY(
                  EndingDate,BusUnit."Currency Code",
                  ConsolidAmount,BusUnit."Balance Currency Factor"));
            CASE TempSubsidGLAcc."Consol. Translation Method" OF
              TempSubsidGLAcc."Consol. Translation Method"::"Closing Rate":
                BEGIN
                  Amount := ClosingAmount;
                  //\\ RAM ---01
                  /*  //Standard One
                  Description :=
                    COPYSTR(
                      STRSUBSTNO(
                        Text017,
                        ConsolidAmount,ROUND(BusUnit."Balance Currency Factor",0.00001),EndingDate),
                      1,MAXSTRLEN(Description));
                      */
                  // Bring out from Old
                  Description :=
                    COPYSTR(
                      STRSUBSTNO(
                        Text50001,
                        ConsolidAmount,ROUND((1/BusUnit."Balance Currency Factor"),0.00001),EndingDate),
                      1,MAXSTRLEN(Description));
        
                  //\\ RAM +++01
                END;
              TempSubsidGLAcc."Consol. Translation Method"::"Composite Rate",
              TempSubsidGLAcc."Consol. Translation Method"::"Equity Rate",
              TempSubsidGLAcc."Consol. Translation Method"::"Average Rate (Manual)":
                BEGIN
                  Amount :=
                    ROUND(
                      ConsolidCurrExchRate.ExchangeAmtFCYToLCY(
                        EndingDate,BusUnit."Currency Code",
                        ConsolidAmount,BusUnit."Income Currency Factor"));
                  //\\ RAM ---01
                  /* //Standard One
                  Description :=
                    COPYSTR(
                      STRSUBSTNO(
                        Text017,
                        ConsolidAmount,ROUND(BusUnit."Income Currency Factor",0.00001),EndingDate),
                      1,MAXSTRLEN(Description));
                      */
                  // Bring Out From Old One
                  Description :=
                    COPYSTR(
                      STRSUBSTNO(
                        Text50001,
                        ConsolidAmount,ROUND((1/BusUnit."Income Currency Factor"),0.00001),EndingDate),
                      1,MAXSTRLEN(Description));
        
                  //\\ RAM +++01
                END;
              TempSubsidGLAcc."Consol. Translation Method"::"Historical Rate":
                BEGIN
                  Amount := TranslateUsingHistoricalRate(ConsolidAmount,GLEntry."Posting Date");
                  //\\ RAM ---01
                  //Standard One
                  /*
                  Description :=
                    COPYSTR(
                      STRSUBSTNO(
                        Text017,
                        ConsolidAmount,ROUND(HistoricalCurrencyFactor,0.00001),GLEntry."Posting Date"),
                      1,MAXSTRLEN(Description));
                      */
                  // Bring Out From Old One
                  Description :=
                    COPYSTR(
                      STRSUBSTNO(
                        Text50001,
                        ConsolidAmount,ROUND(HistoricalExcRate,0.00001),GLEntry."Posting Date"),
                      1,MAXSTRLEN(Description));
        
                  //\\ RAM +++01
                END;
            END;
          END ELSE BEGIN
            Amount := ROUND(ConsolidAmount);
            ClosingAmount := Amount;
            Description :=
              STRSUBSTNO(Text024,AmountToPost,BusUnit."Consolidation %",BusUnit.FIELDCAPTION("Consolidation %"));
          END;
        
          IF TempSubsidGLAcc."Consol. Translation Method" = TempSubsidGLAcc."Consol. Translation Method"::"Historical Rate" THEN
            "Posting Date" := GLEntry."Posting Date"
          ELSE
            "Posting Date" := EndingDate;
          idx := NORMALDATE("Posting Date") - NORMALDATE(StartingDate) + 1;
        
          IF DimBuf.FINDSET THEN BEGIN
            REPEAT
              TempDimSetEntry2.INIT;
              TempDimSetEntry2."Dimension Code" := DimBuf."Dimension Code";
              TempDimSetEntry2."Dimension Value Code" := DimBuf."Dimension Value Code";
              DimValue.GET(TempDimSetEntry2."Dimension Code",TempDimSetEntry2."Dimension Value Code");
              TempDimSetEntry2."Dimension Value ID" := DimValue."Dimension Value ID";
              TempDimSetEntry2.INSERT;
            UNTIL DimBuf.NEXT = 0;
            "Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry2);
            DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID",
              "Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
          END;
        
          IF Amount <> 0 THEN
            GenJnlPostLineTmp(GenJnlLine);
          TempDimSetEntry2.RESET;
          TempDimSetEntry2.DELETEALL;
        
          RoundingResiduals[idx] := RoundingResiduals[idx] + Amount;
          AdjustAmount := ClosingAmount - Amount;
          CASE TempSubsidGLAcc."Consol. Translation Method" OF
            TempSubsidGLAcc."Consol. Translation Method"::"Composite Rate":
              CompExchRateAdjAmts[idx] := CompExchRateAdjAmts[idx] + AdjustAmount;
            TempSubsidGLAcc."Consol. Translation Method"::"Equity Rate":
              EqExchRateAdjAmts[idx] := EqExchRateAdjAmts[idx] + AdjustAmount;
            ELSE
              ExchRateAdjAmounts[idx] := ExchRateAdjAmounts[idx] + AdjustAmount;
          END;
          TempSubsidGLAcc."Consol. Translation Method" := OriginalTranslationMethod;
        END;

    end;

    local procedure TranslateUsingHistoricalRate(AmountToTranslate: Decimal;DateToTranslate: Date) TranslatedAmount: Decimal
    begin
        IF BusUnit."Currency Exchange Rate Table" = BusUnit."Currency Exchange Rate Table"::"Local"
        THEN BEGIN
          ConsolidCurrExchRate.RESET;
          ConsolidCurrExchRate.SETRANGE("Currency Code",BusUnit."Currency Code");
          ConsolidCurrExchRate.SETRANGE("Starting Date",0D,DateToTranslate);
          ConsolidCurrExchRate.FINDLAST;
          ConsolidCurrExchRate.TESTFIELD("Exchange Rate Amount");
          ConsolidCurrExchRate.TESTFIELD("Relational Exch. Rate Amount");
          ConsolidCurrExchRate.TESTFIELD("Relational Currency Code",'');
          HistoricalCurrencyFactor :=
            ConsolidCurrExchRate."Exchange Rate Amount" / ConsolidCurrExchRate."Relational Exch. Rate Amount";
          //\\RAM ---01
          HistoricalExcRate := ConsolidCurrExchRate."Relational Exch. Rate Amount"; //Check it. //RAM
          //\\RAM +++01
        END ELSE BEGIN
          TempSubsidCurrExchRate.RESET;
          TempSubsidCurrExchRate.SETRANGE("Starting Date",0D,DateToTranslate);
          TempSubsidCurrExchRate.SETRANGE("Currency Code",CurrencyPCY);
          TempSubsidCurrExchRate.FINDLAST;
          TempSubsidCurrExchRate.TESTFIELD("Exchange Rate Amount");
          TempSubsidCurrExchRate.TESTFIELD("Relational Exch. Rate Amount");
          TempSubsidCurrExchRate.TESTFIELD("Relational Currency Code",'');
          HistoricalCurrencyFactor := TempSubsidCurrExchRate."Relational Exch. Rate Amount" /
            TempSubsidCurrExchRate."Exchange Rate Amount";
          //\\RAM ---01
          HistoricalExcRate :=  TempSubsidCurrExchRate."Relational Exch. Rate Amount"; //Check it. //RAM
          //\\RAM +++01

          IF BusUnit."Data Source" = BusUnit."Data Source"::"Add. Rep. Curr. (ACY)" THEN BEGIN
            TempSubsidCurrExchRate.SETRANGE("Currency Code",CurrencyACY);
            TempSubsidCurrExchRate.FINDLAST;
            TempSubsidCurrExchRate.TESTFIELD("Exchange Rate Amount");
            TempSubsidCurrExchRate.TESTFIELD("Relational Exch. Rate Amount");
            TempSubsidCurrExchRate.TESTFIELD("Relational Currency Code",'');
            HistoricalCurrencyFactor := HistoricalCurrencyFactor *
              TempSubsidCurrExchRate."Exchange Rate Amount" / TempSubsidCurrExchRate."Relational Exch. Rate Amount";
          END;
        END;
        TranslatedAmount := ROUND(AmountToTranslate / HistoricalCurrencyFactor);
    end;

    local procedure GenJnlPostLineTmp(var GenJnlLine: Record "81")
    begin
        NextLineNo := NextLineNo + 1;
        TempGenJnlLine := GenJnlLine;
        TempGenJnlLine.Amount := ROUND(TempGenJnlLine.Amount);
        TempGenJnlLine."Line No." := NextLineNo;
        TempGenJnlLine."System-Created Entry" := TRUE;
        DimMgt.UpdateGlobalDimFromDimSetID(GenJnlLine."Dimension Set ID",
          GenJnlLine."Shortcut Dimension 1 Code",GenJnlLine."Shortcut Dimension 2 Code");
        TempGenJnlLine.INSERT;
    end;

    local procedure GenJnlPostLineFinally()
    var
        GenJnlPostLine: Codeunit "12";
    begin
        TempGenJnlLine.SETCURRENTKEY("Journal Template Name","Journal Batch Name","Posting Date");
        IF TempGenJnlLine.FINDSET THEN
          REPEAT
            Window.UPDATE(3,TempGenJnlLine."Account No.");
            GenJnlPostLine.RunWithCheck(TempGenJnlLine);
          UNTIL TempGenJnlLine.NEXT = 0;
    end;

    local procedure TextToDecimal(Txt: Text[50]) Result: Decimal
    var
        DecOnlyTxt: Text[50];
        Idx: Integer;
    begin
        FOR Idx := 1 TO STRLEN(Txt) DO
          IF Txt[Idx] IN ['0','1','2','3','4','5','6','7','8','9'] THEN
            DecOnlyTxt := DecOnlyTxt + COPYSTR(Txt,Idx,1);
        IF DecOnlyTxt = '' THEN
          Result := 0
        ELSE
          EVALUATE(Result,DecOnlyTxt);
    end;

    local procedure DateToDecimal(Dt: Date) Result: Decimal
    var
        Mon: Decimal;
        Day: Decimal;
        Yr: Decimal;
    begin
        Day := DATE2DMY(Dt,1);
        Mon := DATE2DMY(Dt,2);
        Yr := DATE2DMY(Dt,3);
        Result := Yr * 100 + Mon + Day / 100;
    end;

    local procedure ReportError(ErrorMsg: Text[250])
    begin
        IF TestMode THEN BEGIN
          IF CurErrorIdx = ARRAYLEN(ErrorText) THEN
            ErrorText[CurErrorIdx] := STRSUBSTNO(Text006,ARRAYLEN(ErrorText))
          ELSE BEGIN
            CurErrorIdx := CurErrorIdx + 1;
            ErrorText[CurErrorIdx] := ErrorMsg;
          END;
        END ELSE
          ERROR(ErrorMsg);
    end;

    procedure GetNumSubsidGLAcc(): Integer
    begin
        TempSubsidGLAcc.RESET;
        EXIT(TempSubsidGLAcc.COUNT);
    end;

    procedure Get1stSubsidGLAcc(var GlAccount: Record "15"): Boolean
    begin
        TempSubsidGLAcc.RESET;
        IF TempSubsidGLAcc.FINDFIRST THEN BEGIN
          GlAccount := TempSubsidGLAcc;
          IF TestMode THEN
            TestGLAccounts;
          EXIT(TRUE);
        END;
        EXIT(FALSE);
    end;

    procedure GetNxtSubsidGLAcc(var GLAccount: Record "15"): Boolean
    begin
        IF TempSubsidGLAcc.NEXT <> 0 THEN BEGIN
          GLAccount := TempSubsidGLAcc;
          IF TestMode THEN
            TestGLAccounts;
          EXIT(TRUE);
        END;
        EXIT(FALSE);
    end;

    procedure GetNumSubsidGLEntry(): Integer
    begin
        WITH TempSubsidGLEntry DO BEGIN
          RESET;
          SETCURRENTKEY("G/L Account No.","Posting Date");
          SETRANGE("G/L Account No.",TempSubsidGLAcc."No.");
          EXIT(COUNT);
        END;
    end;

    procedure Get1stSubsidGLEntry(var GLEntry: Record "17"): Boolean
    begin
        ConsolidatingClosingDate :=
          (StartingDate = EndingDate) AND
          (StartingDate <> NORMALDATE(StartingDate));
        IF (StartingDate <> NORMALDATE(StartingDate)) AND
           (StartingDate <> EndingDate)
        THEN
          ReportError(Text030);
        WITH TempSubsidGLEntry DO BEGIN
          RESET;
          SETCURRENTKEY("G/L Account No.","Posting Date");
          SETRANGE("G/L Account No.",TempSubsidGLAcc."No.");
          IF FINDFIRST THEN BEGIN
            GLEntry := TempSubsidGLEntry;
            IF TestMode THEN BEGIN
              IF ("Posting Date" <> NORMALDATE("Posting Date")) AND
                 NOT ConsolidatingClosingDate
              THEN
                ReportError(STRSUBSTNO(
                    Text031,
                    TABLECAPTION,
                    FIELDCAPTION("Posting Date"),
                    "Posting Date"));
            END;
            EXIT(TRUE);
          END;
          EXIT(FALSE);
        END;
    end;

    procedure GetNxtSubsidGLEntry(var GLEntry: Record "17"): Boolean
    begin
        WITH TempSubsidGLEntry DO BEGIN
          IF NEXT <> 0 THEN BEGIN
            GLEntry := TempSubsidGLEntry;
            IF TestMode THEN BEGIN
              IF ("Posting Date" <> NORMALDATE("Posting Date")) AND
                 NOT ConsolidatingClosingDate
              THEN
                ReportError(STRSUBSTNO(
                    Text031,
                    TABLECAPTION,
                    FIELDCAPTION("Posting Date"),
                    "Posting Date"));
            END;
            EXIT(TRUE);
          END;
          EXIT(FALSE);
        END;
    end;

    procedure GetNumGenJnlLine(): Integer
    begin
        IF TestMode THEN
          EXIT(TempGenJnlLine.COUNT);

        EXIT(0);
    end;

    procedure Get1stGenJnlLine(var GenJnlLine: Record "81"): Boolean
    begin
        IF TestMode THEN BEGIN
          TempGenJnlLine.SETCURRENTKEY("Journal Template Name","Journal Batch Name","Posting Date");
          IF TempGenJnlLine.FINDFIRST THEN BEGIN
            GenJnlLine := TempGenJnlLine;
            EXIT(TRUE);
          END;
          EXIT(FALSE);
        END;
        EXIT(FALSE);
    end;

    procedure GetNxtGenJnlLine(var GenJnlLine: Record "81"): Boolean
    begin
        IF TestMode THEN BEGIN
          IF TempGenJnlLine.NEXT <> 0 THEN BEGIN
            GenJnlLine := TempGenJnlLine;
            EXIT(TRUE);
          END;
          EXIT(FALSE);
        END;
        EXIT(FALSE);
    end;

    procedure UpdateBUForExRates(MonthEndDate: Date)
    var
        CompanyRec: Record "79";
        BusUnitRec: Record "220";
        CurrencyCode3: Code[10];
        Date3: Date;
        CurrencyFactor: Decimal;
    begin

        BusUnitRec.RESET;
        IF BusUnitRec.FINDSET(TRUE,FALSE) THEN BEGIN
          REPEAT
            //Closing Rate
            CurrencyCode3 := BusUnitRec."Currency Code";
            CurrencyFactor := BusUnitRec."Balance Currency Factor";
            Date3 := MonthEndDate;
            IF CurrencyCode3 <> '' THEN BEGIN
              InitValues(CurrencyCode3,CurrencyFactor,Date3);
              IF RefCurrencyCode = '' THEN
                BusUnitRec."Balance Currency Factor" := CurrentExchRate / NewRefExchRate
              ELSE
                BusUnitRec."Balance Currency Factor" := (CurrentExchRate * CurrentExchRate2) / (RefExchRate * NewRefExchRate2);

              //>>TL01
              CurrencyCode3 := BusUnitRec."Currency Code";
              CurrencyFactor := BusUnitRec."Balance Currency Factor";
              Date3 := CALCDATE('-1M+CM',MonthEndDate);
              InitValues(CurrencyCode3,CurrencyFactor,Date3);
              IF RefCurrencyCode = '' THEN
                BusUnitRec."Last Balance Currency Factor" := CurrentExchRate / NewRefExchRate
              ELSE
                BusUnitRec."Last Balance Currency Factor" := (CurrentExchRate * CurrentExchRate2) / (RefExchRate * NewRefExchRate2);
              //<<TL01

              //Average Rate
              CurrencyCode3 := BusUnitRec."Currency Code";
              CurrencyFactor := BusUnitRec."Income Currency Factor";
              Date3 := MonthEndDate;
              InitValues(CurrencyCode3,CurrencyFactor,Date3);
              IF RefCurrencyCode = '' THEN
                BusUnitRec."Income Currency Factor" := CurrentExchRate / NewRefExchRate
              ELSE
                BusUnitRec."Income Currency Factor" := (CurrentExchRate * CurrentExchRate2) / (RefExchRate * NewRefExchRate2);

              BusUnitRec.MODIFY;
            END;
          UNTIL BusUnitRec.NEXT = 0;
        END;
    end;

    procedure InitValues(pCurrencyCode: Code[10];pCurrencyFactor: Decimal;pDate: Date)
    var
        CurrExchRate: Record "330";
        CurrencyCode: Code[10];
        RefExchRate2: Decimal;
        Fix: Option Currency,"Relational Currency",Both;
        Fix2: Option Currency,"Relational Currency",Both;
    begin

        WITH CurrExchRate DO BEGIN
          SETRANGE("Currency Code",pCurrencyCode);
          SETRANGE("Starting Date",0D,pDate);
          FINDLAST;
          CurrencyCode := "Currency Code";
          CurrentExchRate := "Exchange Rate Amount";
          RefExchRate := "Relational Exch. Rate Amount";
          NewRefExchRate := "Relational Exch. Rate Amount";
          RefCurrencyCode := "Relational Currency Code";
          Fix:= "Fix Exchange Rate Amount";

          SETRANGE("Currency Code",RefCurrencyCode);
          SETRANGE("Starting Date",0D,pDate);
          IF FINDLAST THEN BEGIN
            CurrentExchRate2 := "Exchange Rate Amount";
            RefExchRate2 := "Relational Exch. Rate Amount";
            NewRefExchRate2 := "Relational Exch. Rate Amount";
            Fix2 := "Fix Exchange Rate Amount";
          END;

          CASE Fix OF
            "Fix Exchange Rate Amount"::Currency :
              BEGIN
                IF RefCurrencyCode = '' THEN
                  RefExchRate := CurrentExchRate / pCurrencyFactor
                ELSE
                  RefExchRate := (CurrentExchRate * CurrentExchRate2) / (pCurrencyFactor * RefExchRate2);
              END;
            "Fix Exchange Rate Amount"::"Relational Currency" :
              BEGIN
                IF RefCurrencyCode = '' THEN
                  CurrentExchRate := pCurrencyFactor * RefExchRate
                ELSE
                  CurrentExchRate := (RefExchRate * RefExchRate2 * pCurrencyFactor) / CurrentExchRate2;
              END;
            "Fix Exchange Rate Amount"::Both :
              BEGIN
              END;
          END;

          IF RefCurrencyCode <> '' THEN BEGIN
            IF (Fix <> "Fix Exchange Rate Amount"::Both) AND (Fix2 <> "Fix Exchange Rate Amount"::Both) THEN
              ERROR(
                Text50003 +
                Text50004,
                CurrExchRate.FIELDCAPTION("Fix Exchange Rate Amount"),CurrencyCode,
                CurrExchRate.FIELDCAPTION("Relational Currency Code"));
            CASE Fix2 OF
              "Fix Exchange Rate Amount"::Currency :
                BEGIN
                  RefExchRate2 := (CurrentExchRate * CurrentExchRate2) / (pCurrencyFactor * RefExchRate);
                END;
              "Fix Exchange Rate Amount"::"Relational Currency" :
                BEGIN
                  CurrentExchRate2 := (pCurrencyFactor * RefExchRate * RefExchRate2) / CurrentExchRate;
                END;
              "Fix Exchange Rate Amount"::Both :
                BEGIN
                END;
            END;
          END;
        END;
    end;

    local procedure ReadGLSetup()
    var
        GLSetup: Record "98";
        SourceCodeSetup: Record "242";
    begin
        //\\ RAM ---01
        GLSetup.GET;
        GlobalDim1Code := GLSetup."Global Dimension 1 Code";
        GlobalDim2Code := GLSetup."Global Dimension 2 Code";
        SourceCodeSetup.GET;
        ConsolidSourceCode := SourceCodeSetup.Consolidation;
        //\\ RAM +++01
    end;

    procedure SetClearAll(ClearAll: Boolean)
    begin

        //>>Ram ---01
        ClearAllHistory := ClearAll; //.............Check It.
        //>>Ram ---01
    end;

    procedure HasgotLocalGlobalDim(GLAcc: Code[20];var LoclDimArray: Code[20]): Boolean
    var
        DefDim: Record "352";
        Dimension: Record "348";
        j: Integer;
    begin

        //RAM
        j := 0;
        DefDim.RESET;
        DefDim.SETRANGE("Table ID",15);
        DefDim.SETRANGE("No.",GLAcc);
        IF DefDim.FINDSET THEN
          REPEAT
            CASE DefDim."Value Posting" OF
              DefDim."Value Posting"::"Same Code":
                BEGIN
                  Dimension.RESET;
                 // IF Dimension.GET(DefDim."Dimension Code") THEN
        //            IF Dimension."Dimension Type" = Dimension."Dimension Type"::"Local" THEN BEGIN        ///........... Chek it
        //              j += 1;
        //              LoclDimArray[j][1] := DefDim."Dimension Code";
        //              LoclDimArray[j][2] := DefDim."Dimension Value Code";
        //            END;
                END;
              ELSE BEGIN
                Dimension.RESET;
        //        IF Dimension.GET(DefDim."Dimension Code") THEN
        //          IF Dimension."Dimension Type" = Dimension."Dimension Type"::"Local" THEN BEGIN   // .........Check It //RAM
        //            j += 1;
        //            LoclDimArray[j][1] := DefDim."Dimension Code";
        //          END;
              END;
            END;
          UNTIL DefDim.NEXT = 0;

        IF j > 0 THEN
          EXIT(TRUE);

        EXIT(FALSE);
        //RAM
    end;
}

