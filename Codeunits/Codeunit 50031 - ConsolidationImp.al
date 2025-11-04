codeunit 50031 ConsolidationImp
{
    // //\\ RAM 01:2018 02/28/2018
    //  # Created a new codeunit


    trigger OnRun()
    begin
        IF CheckToRunConsolidation() THEN
            //>>KW11.01:EDD-1.9.3.7:2:2
            UpdateBUForExRates();
        //<<KW11.01:EDD-1.9.3.7:2:2
        //RunAllConsolidation();
    end;

    var
        NoSeries: Record 308;
        LastNoSeriesLine: Record 309;
        CurrExchRate: Record 330;
       // Company: Record 2000000006;
        CurrencyCode: Code[10];
        CurrencyCode2: Code[10];
        CurrencyCode3: Code[10];
        RefCurrencyCode: Code[10];
        RefCurrencyCode2: Code[10];
        TryNoSeriesCode: Code[10];
        WarningNoSeriesCode: Code[10];
        Date3: Date;
        MonthEndDate: Date;
        CurrencyFactor: Decimal;
        CurrentExchRate: Decimal;
        CurrentExchRate2: Decimal;
        NewRefExchRate: Decimal;
        NewRefExchRate2: Decimal;
        RefExchRate: Decimal;
        RefExchRate2: Decimal;
        Text004: Label 'You cannot assign new numbers from the number series %1 on %2.', Comment = '%1 %2';
        Text006: Label 'You cannot assign new numbers from the number series %1 on a date before %2.', Comment = '%1 %2';
        Text007: Label 'You cannot assign numbers greater than %1 from the number series %2.', Comment = '%1 %2';
        Text010: Label 'The number %1 cannot be extended to more than 20 characters.', Comment = '%1';
        // Text021: Label 'The %1 field is not set up properly in the Currrency Exchange Rates window. ';
        // Text022: Label 'For %2 or the currency set up in the %3 field, the %1 field should be set to both.';
        Text50002: Label 'No. Series %1 is not available.', Comment = '%1';
        Fix: Option;
        Fix2: Option;
        GlobelControlCompany: Text[50];

    procedure CheckToRunConsolidation(): Boolean
    begin
        //\\ RAM ---01
        //IF KoppersSetup."Global Financial Control" THEN BEGIN
        //  IF KoppersSetup."Run Consolidations Now" THEN BEGIN
        //    MonthEndDate := KoppersSetup."Consolidation Month-End Date";      --------------------CHeck It
        GlobelControlCompany := COMPANYNAME;
        EXIT(TRUE);
        //  END;
        //END ELSE BEGIN
        // Company.SETFILTER(Name, '<>%1', COMPANYNAME);
        // IF Company.FIND('-') THEN BEGIN
        //    REPEAT
        //      IF KoppersSetup.CHANGECOMPANY(Company.Name) THEN BEGIN
        //        IF KoppersSetup.GET THEN BEGIN
        //          IF KoppersSetup."Global Financial Control" THEN BEGIN
        //            IF KoppersSetup."Run Consolidations Now" THEN BEGIN
        //   GlobelControlCompany := Company.Name;
        //              MonthEndDate := KoppersSetup."Consolidation Month-End Date"; --------------------Check It
        // EXIT(TRUE);
        //            END;
        //          END;
        //        END;
        //      END;
        //    UNTIL Company.NEXT =0 ;
        //END;
        //END;
        //EXIT(FALSE);
        //\\ RAM +++01
    end;

    procedure GetNextNo(NoSeriesCode: Code[10]; SeriesDate: Date; ModifySeries: Boolean; GlobelComName: Text[50]): Code[20]
    var
        NoSeriesLine: Record 309;
    begin
        NoSeriesLine.CHANGECOMPANY(GlobelComName);
        NoSeries.CHANGECOMPANY(GlobelComName);
        LastNoSeriesLine.CHANGECOMPANY(GlobelComName);

        IF SeriesDate = 0D THEN
            SeriesDate := WORKDATE();

        IF ModifySeries OR (LastNoSeriesLine."Series Code" = '') THEN BEGIN
            IF ModifySeries THEN
                NoSeriesLine.LOCKTABLE();
            IF NOT NoSeries.GET(NoSeriesCode) THEN
                IF CreateErrorLog('', '', STRSUBSTNO(Text50002, NoSeriesCode)) THEN
                    EXIT;
            SetNoSeriesLineFilter(NoSeriesLine, NoSeriesCode, SeriesDate);
            IF NOT NoSeriesLine.FINDFIRST() THEN BEGIN
                NoSeriesLine.SETRANGE("Starting Date");
                IF NOT NoSeriesLine.ISEMPTY THEN
                    IF CreateErrorLog('', '', STRSUBSTNO(Text004,
                      NoSeriesCode, SeriesDate)) THEN
                        EXIT;
                IF CreateErrorLog('', '', STRSUBSTNO(Text004,
                  NoSeriesCode, SeriesDate)) THEN
                    EXIT;
            END;
        END ELSE
            NoSeriesLine := LastNoSeriesLine;

        IF NoSeries."Date Order" AND (SeriesDate < NoSeriesLine."Last Date Used") THEN
            IF CreateErrorLog('', '', STRSUBSTNO(Text006,
              NoSeries.Code, NoSeriesLine."Last Date Used")) THEN
                EXIT;

        NoSeriesLine."Last Date Used" := SeriesDate;
        IF NoSeriesLine."Last No. Used" = '' THEN BEGIN
            NoSeriesLine.TESTFIELD("Starting No.");
            NoSeriesLine."Last No. Used" := NoSeriesLine."Starting No.";
        END ELSE
            IF NoSeriesLine."Increment-by No." <= 1 THEN
                NoSeriesLine."Last No. Used" := INCSTR(NoSeriesLine."Last No. Used")
            ELSE
                IncrementNoText(NoSeriesLine."Last No. Used", NoSeriesLine."Increment-by No.");
        IF (NoSeriesLine."Ending No." <> '') AND
           (NoSeriesLine."Last No. Used" > NoSeriesLine."Ending No.")
        THEN
            IF CreateErrorLog('', '', STRSUBSTNO(Text007,
              NoSeriesLine."Ending No.", NoSeriesCode)) THEN
                EXIT;

        IF (NoSeriesLine."Ending No." <> '') AND
           (NoSeriesLine."Warning No." <> '') AND
           (NoSeriesLine."Last No. Used" >= NoSeriesLine."Warning No.") AND
           (NoSeriesCode <> WarningNoSeriesCode) AND
           (TryNoSeriesCode = '')
        THEN BEGIN
            WarningNoSeriesCode := NoSeriesCode;
            IF CreateErrorLog('', '', STRSUBSTNO(Text007,
              NoSeriesLine."Ending No.", NoSeriesCode)) THEN
                EXIT;
        END;

        NoSeriesLine.VALIDATE(Open);

        IF ModifySeries THEN
            NoSeriesLine.MODIFY()
        ELSE
            LastNoSeriesLine := NoSeriesLine;
        EXIT(NoSeriesLine."Last No. Used");
    end;

    procedure SetNoSeriesLineFilter(var NoSeriesLine: Record 309; NoSeriesCode: Code[10]; StartDate: Date)
    begin
        IF StartDate = 0D THEN
            StartDate := WORKDATE();
        NoSeriesLine.RESET();
        NoSeriesLine.SETCURRENTKEY("Series Code", "Starting Date");
        NoSeriesLine.SETRANGE("Series Code", NoSeriesCode);
        NoSeriesLine.SETRANGE("Starting Date", 0D, StartDate);
        IF NoSeriesLine.FIND('+') THEN BEGIN
            NoSeriesLine.SETRANGE("Starting Date", NoSeriesLine."Starting Date");
            NoSeriesLine.SETRANGE(Open, TRUE);
        END;
    end;

    local procedure IncrementNoText(var No: Code[20]; IncrementByNo: Decimal)
    var
        DecimalNo: Decimal;
        EndPos: Integer;
        StartPos: Integer;
        NewNo: Text[30];
    begin
        GetIntegerPos(No, StartPos, EndPos);
        EVALUATE(DecimalNo, COPYSTR(No, StartPos, EndPos - StartPos + 1));
        NewNo := FORMAT(DecimalNo + IncrementByNo, 0, 1);
        ReplaceNoText(No, NewNo, 0, StartPos, EndPos);
    end;

    local procedure ReplaceNoText(var No: Code[20]; NewNo: Code[20]; FixedLength: Integer; StartPos: Integer; EndPos: Integer)
    var
        EndNo: Code[20];
        StartNo: Code[20];
        ZeroNo: Code[20];
        NewLength: Integer;
        OldLength: Integer;
    begin
        IF StartPos > 1 THEN
            StartNo := COPYSTR(No, 1, StartPos - 1);
        IF EndPos < STRLEN(No) THEN
            EndNo := COPYSTR(No, EndPos + 1);
        NewLength := STRLEN(NewNo);
        OldLength := EndPos - StartPos + 1;
        IF FixedLength > OldLength THEN
            OldLength := FixedLength;
        IF OldLength > NewLength THEN
            ZeroNo := PADSTR('', OldLength - NewLength, '0');
        IF STRLEN(StartNo) + STRLEN(ZeroNo) + STRLEN(NewNo) + STRLEN(EndNo) > 20 THEN
            IF CreateErrorLog('', '', STRSUBSTNO(Text010, No)) THEN
                EXIT;

        No := StartNo + ZeroNo + NewNo + EndNo;
    end;

    local procedure GetIntegerPos(No: Code[20]; var StartPos: Integer; var EndPos: Integer)
    var
        IsDigit: Boolean;
        i: Integer;
    begin
        StartPos := 0;
        EndPos := 0;
        IF No <> '' THEN BEGIN
            i := STRLEN(No);
            REPEAT
                IsDigit := No[i] IN ['0' .. '9'];
                IF IsDigit THEN BEGIN
                    IF EndPos = 0 THEN
                        EndPos := i;
                    StartPos := i;
                END;
                i := i - 1;
            UNTIL (i = 0) OR (StartPos <> 0) AND NOT IsDigit;
        END;
    end;

    procedure CheckFileForDate(pdatePostingDate: Date): Boolean
    begin
        //\\ RAM ---01
        //KoppersSetup.GET;
        //IF KoppersSetup."Global Financial Control" THEN BEGIN
        //  IF KoppersSetup."Run Consolidations Now" THEN BEGIN
        //    MonthEndDate := KoppersSetup."Consolidation Month-End Date";            --------------------Check It   //RAM
        //  END;
        //END ELSE BEGIN
        //  Company.SETFILTER(Name,'<>%1',COMPANYNAME);
        //  IF Company.FIND('-') THEN BEGIN
        //    REPEAT
        //      IF KoppersSetup.CHANGECOMPANY(Company.Name) THEN BEGIN
        //        IF KoppersSetup.GET THEN BEGIN
        //          IF KoppersSetup."Global Financial Control" THEN BEGIN
        //            IF KoppersSetup."Run Consolidations Now" THEN BEGIN
        //              MonthEndDate := KoppersSetup."Consolidation Month-End Date";    --------------------Consider It  //RAM
        //            END;
        //          END;
        //        END;
        //      END;
        //    UNTIL Company.NEXT =0 ;
        //  END;
        //END;
        //MonthFirstDate := DMY2DATE(1,DATE2DMY(MonthEndDate,2),DATE2DMY(MonthEndDate,3));
        //IF (pdatePostingDate < MonthFirstDate) OR (pdatePostingDate > MonthEndDate) THEN BEGIN
        //  IF CreateErrorLog('','',Text50000) THEN;
        //  EXIT(TRUE);
        //END;
        //EXIT(FALSE);
    end;

    procedure UpdateConsolidationsetup()
    begin
        //Deleted local vars and Parameter as compared to NAV 2009 //RAM - Check It
        //\\ RAM ---01
        //IF ConsolidationsetupLocal.GET(ConsolSetup.Code) THEN BEGIN
        //  ConsolidationsetupLocal.CALCFIELDS("Error Log Exist");
        //  IF NOT ConsolidationsetupLocal."Error Log Exist" THEN BEGIN
        //    ConsolidationsetupLocal."Last Month End Run Date" := MonthEndDate;    --------------------Consider It
        //    ConsolidationsetupLocal.MODIFY;
        //  END;
        //END;
        //\\ RAM +++01
    end;

    procedure UpdateAllAnalysisViews()
    begin
        //Deleted local vars as compared to NAV 2009 //RAM - Check It
        //\\RAM ---01
        //IF ConsolidationSetupUAV.FINDSET(FALSE) THEN BEGIN
        //  REPEAT
        //    Company.SETRANGE(Name,ConsolidationSetupUAV."Consolidation Company Name");
        //    IF Company.FINDSET(FALSE) THEN BEGIN
        //      REPEAT
        //        UpdateAnalysisView.UpdateAll(2,TRUE);     --------------------Consider It
        //      UNTIL Company.NEXT = 0;
        //    END;
        //  UNTIL ConsolidationSetupUAV.NEXT = 0;
        //END;
        //\\RAM ---01
    end;

    procedure CreateErrorLog(ConsolSetupCode: Code[20]; CompanyCode: Code[10]; ErrorText: Text[250]): Boolean
    begin
        //Deleted local vars as compared to NAV 2009 //RAM - Check It

        //\\ RAM ---01
        //ConsolErrorLog.INIT;
        //ConsolErrorLog."Entry No." := FindLastErrorEntryNo +1;
        //ConsolErrorLog."Consolidation  Setup Code" := ConsolSetupCode;
        //ConsolErrorLog."Company Code" := CompanyCode;
        //KoppersSetup.GET;
        //ConsolErrorLog."Month-End Date" := MonthEndDate;
        //ConsolErrorLog."Error Text" := ErrorText;
        //ConsolErrorLog."Run Date" := TODAY;
        //ConsolErrorLog."Run Time" := TIME;
        //ConsolErrorLog.Cleared := FALSE;
        //ConsolErrorLog."User Id" := USERID;           //<< KNA1.24:4354
        //WHILE NOT ConsolErrorLog.INSERT DO
        //  ConsolErrorLog."Entry No." += 1;
        //COMMIT;
        //EXIT(TRUE);
        //\\ RAM +++01
    end;

    procedure UpdateElimination(precBusninessUnit: Record 220; Consolidationsetupcode: Code[20]; CurrCompany: Text[100])
    begin
        //Deleted local vars as compared to NAV 2009 //RAM - Check It
        //\\ RAM ---01
        //KopperSetup.CHANGECOMPANY(GlobelControlCompany);//RAM
        //KopperSetup.GET;
        //GLEntry.CHANGECOMPANY(CurrCompany);
        //AffiliateDimValue.CHANGECOMPANY(CurrCompany);
        //GLAccount.CHANGECOMPANY(CurrCompany);
        //NewGLEntry.CHANGECOMPANY(CurrCompany);
        //GLEntryDim.CHANGECOMPANY(CurrCompany);
        //NewGLEntryDim.CHANGECOMPANY(CurrCompany);

        //AffiliateDimValue.SETRANGE("Business Unit Code",precBusninessUnit.Code);

        //IF AffiliateDimValue.FIND('-') THEN BEGIN
        //  REPEAT
        //    GLEntry.RESET;
        //    GLEntry.SETCURRENTKEY("Posting Date","Automatic Elimination Entry","Console. Adjustment Entry");
        //    GLEntry.SETRANGE("Posting Date",DMY2DATE(1,DATE2DMY(MonthEndDate,2),DATE2DMY(MonthEndDate,3)),MonthEndDate);
        //    GLEntry.SETRANGE("Automatic Elimination Entry",FALSE);
        //    //>>KW11.01:EDD-3.11:2:1
        //    GLEntry.SETRANGE("Console. Adjustment Entry",FALSE);
        //    //<<KW11.01:EDD-3.11:2:1
        //    GLEntry.SETRANGE("Affiliate DimensionCode Filter",KopperSetup."Affiliate Dimension Code");
        //    GLEntry.CALCFIELDS("Affiliate Dim. Value");
        //    GLEntry.SETRANGE("Affiliate Dim. Value",AffiliateDimValue."Affiliate Dimension Value");
        //    GLEntry.SETFILTER("Business Unit Code",'<>%1',precBusninessUnit.Code);
        //    IF GLEntry.FIND('-') THEN BEGIN
        //      REPEAT
        //         LastEntryNo := GetLastEntryNo;
        //         GLAccount.RESET;
        //         IF GLAccount.GET(GLEntry."G/L Account No.") THEN BEGIN
        //           IF GLAccount."Offset Account No." <> '' THEN BEGIN
        //             NewGLEntry.INIT;
        //             //Insert Eliminaton entry
        //             NewGLEntry := GLEntry;
        //             NewGLEntry."Entry No." := LastEntryNo + 1;
        //             NewGLEntry.Description := COPYSTR(Text50003 + GLEntry.Description,
        //                                        1,MAXSTRLEN(NewGLEntry.Description));
        //             NewGLEntry.Amount := -GLEntry.Amount;
        //             IF NewGLEntry.Amount < 0 THEN BEGIN
        //               NewGLEntry."Debit Amount" := 0;
        //               NewGLEntry."Credit Amount" := ABS(GLEntry.Amount);
        //             END ELSE BEGIN
        //               NewGLEntry."Debit Amount" := ABS(GLEntry.Amount);
        //               NewGLEntry."Credit Amount" := 0;
        //             END;
        //             NewGLEntry."Eliminat. Applied-to Entry No." := GLEntry."Entry No.";
        //             NewGLEntry."Automatic Elimination Entry" := TRUE;
        //             NewGLEntry."Elimination Business Unit Code" := GLEntry."Business Unit Code";
        //             NewGLEntry."System-Created Entry" := FALSE;
        //             NewGLEntry.INSERT;
        //             GLEntryDim.RESET;
        //             GLEntryDim.SETRANGE("Table ID",DATABASE::"G/L Entry");
        //             GLEntryDim.SETRANGE("Entry No.",GLEntry."Entry No.");
        //             IF GLEntryDim.FIND('-') THEN BEGIN
        //               REPEAT
        //                 NewGLEntryDim.INIT;
        //                 NewGLEntryDim."Table ID" := GLEntryDim."Table ID";
        //                 NewGLEntryDim."Entry No." := NewGLEntry."Entry No.";
        //                 NewGLEntryDim."Dimension Code" := GLEntryDim."Dimension Code";
        //                 NewGLEntryDim."Dimension Value Code" := GLEntryDim."Dimension Value Code";
        //                 NewGLEntryDim.INSERT;
        //               UNTIL GLEntryDim.NEXT = 0;
        //             END;

        //             //insert balancing entry
        //             NewGLEntry.INIT;
        //             NewGLEntry := GLEntry;
        //             NewGLEntry."Entry No." := LastEntryNo + 2;
        //             NewGLEntry."G/L Account No." :=GLAccount."Offset Account No.";
        //             NewGLEntry.Description := COPYSTR(Text50003 + GLEntry.Description,
        //                                        1,MAXSTRLEN(NewGLEntry.Description));
        //             NewGLEntry.Amount := GLEntry.Amount;
        //             IF NewGLEntry.Amount < 0 THEN BEGIN
        //               NewGLEntry."Debit Amount" := 0;
        //               NewGLEntry."Credit Amount" := ABS(GLEntry.Amount);
        //             END ELSE BEGIN
        //               NewGLEntry."Debit Amount" := ABS(GLEntry.Amount);
        //               NewGLEntry."Credit Amount" := 0;
        //             END;
        //             NewGLEntry."Eliminat. Applied-to Entry No." := GLEntry."Entry No.";
        //             NewGLEntry."Automatic Elimination Entry" := TRUE;
        //             NewGLEntry."Elimination Business Unit Code" := GLEntry."Business Unit Code";
        //             NewGLEntry."System-Created Entry" := FALSE;
        //             NewGLEntry.INSERT;
        //             EnteredLoop := FALSE;
        //             GLEntryDim.RESET;
        //             GLEntryDim.SETRANGE("Table ID",DATABASE::"G/L Entry");
        //             GLEntryDim.SETRANGE("Entry No.",GLEntry."Entry No.");
        //             IF GLEntryDim.FIND('-') THEN BEGIN
        //               REPEAT
        //                 NewGLEntryDim.INIT;
        //                 NewGLEntryDim."Table ID" := GLEntryDim."Table ID";
        //                 NewGLEntryDim."Entry No." := NewGLEntry."Entry No.";
        //                 NewGLEntryDim."Dimension Code" := GLEntryDim."Dimension Code";
        //                 //>>KNA2.02:5629
        //                 IF (GLAccount."Offset Dimension Code" <> '') AND
        //                    (GLAccount."Offset Dimension Value Code" <> '') AND
        //                    (GLAccount."Offset Dimension Code" = GLEntryDim."Dimension Code")
        //                 THEN BEGIN
        //                   NewGLEntryDim."Dimension Value Code" := GLAccount."Offset Dimension Value Code";
        //                   EnteredLoop := TRUE;
        //                 END ELSE
        //                 //<<KNA2.02:5629
        //                 NewGLEntryDim."Dimension Value Code" := GLEntryDim."Dimension Value Code";
        //                 NewGLEntryDim.INSERT;
        //               UNTIL GLEntryDim.NEXT = 0;
        //             END;
        //             //>>KNA2.02:5629
        //             IF (NOT EnteredLoop) AND
        //                (GLAccount."Offset Dimension Code" <> '') AND
        //                (GLAccount."Offset Dimension Value Code" <> '')
        //                //>>KNA2.02:5629-1 Commented
        //                //AND
        //                //(GLAccount."Offset Dimension Code" = GLEntryDim."Dimension Code")
        //                //<<KNA2.02:5629-1
        //             THEN BEGIN
        //               NewGLEntryDim.INIT;
        //               NewGLEntryDim."Table ID" := GLEntryDim."Table ID";
        //               NewGLEntryDim."Entry No." := NewGLEntry."Entry No.";
        //               NewGLEntryDim."Dimension Code" := GLAccount."Offset Dimension Code";
        //               NewGLEntryDim."Dimension Value Code" := GLAccount."Offset Dimension Value Code";
        //               //>>KNA2.02:5629-1
        //               //NewGLEntryDim.INSERT
        //               IF NewGLEntryDim.INSERT THEN;
        //               //<<KNA2.02:5629-1
        //             END;
        //             //<<KNA2.02:5629
        //           END;
        //         END;
        //      UNTIL GLEntry.NEXT = 0;
        //    END;
        //  UNTIL AffiliateDimValue.NEXT=0;
        //END;
        //\\ RAM +++01
    end;

    procedure GetLastEntryNo(): Integer
    var
        lrecGLEntry: Record 17;
    begin
        lrecGLEntry.FINDLAST();
        EXIT(lrecGLEntry."Entry No.");
    end;

    // procedure RunAllConsolidation()
    //begin
    //\\ RAM ---01
    //Deleted some local vars as compared to NAV 2009 //RAM - Check It


    //CLEAR(ErrorExist);
    ////>>ALR
    //NASSetup.CHANGECOMPANY(GlobelControlCompany);
    //NASSetup.GET;
    ////<<ALR
    ////IF KoppersSetup."Consolidation No. Series" <> '' THEN BEGIN//RAM
    ////  "DocumentNo." := GetNextNo(KoppersSetup."Consolidation No. Series",MonthEndDate,TRUE,GlobelControlCompany); //RAM
    //  IF "DocumentNo." = '' THEN BEGIN
    //    IF CreateErrorLog('','', Text50001) THEN
    //      EXIT;
    //  END;
    //  ConsolidationSetup.SETRANGE("Consolidation Company Name",COMPANYNAME);
    //  IF ConsolidationSetup.FIND('-') THEN BEGIN
    //    REPEAT
    //        IF NASSetup."NAS2 Logging Level" >= NASSetup."NAS2 Logging Level"::Consolidation THEN
    //          CreateErrorLog('','',STRSUBSTNO('   NAS2: Consolidating companies per Setup Code %1',ConsolidationSetup.Code));
    //        CompanytoConsolidate.CHANGECOMPANY(GlobelControlCompany);
    //        CompanytoConsolidate.SETRANGE("Consolidation Setup Code",ConsolidationSetup.Code);
    //        IF CompanytoConsolidate.FIND('-') THEN BEGIN
    //          LastRecordPriorty := ConsolidationSetup.Priority;
    //          REPEAT
    //            IF NASSetup."NAS2 Logging Level" = NASSetup."NAS2 Logging Level"::"Business Unit" THEN
    //              CreateErrorLog('','',
    //                STRSUBSTNO('   NAS2: %1 being consolidated into %2',CompanytoConsolidate."Company Name",COMPANYNAME));
    //            IF ErrorExist THEN BEGIN
    //              IF LastRecordPriorty < ConsolidationSetup.Priority THEN BEGIN
    //                CreateErrorLog('','',STRSUBSTNO('NAS2 "priority" exit'));
    //                EXIT;
    //              END;
    //            END;
    //            IF CompanytoConsolidate."Company Source" = CompanytoConsolidate."Company Source"::"Same Database" THEN BEGIN
    //              BusinessUnit.CHANGECOMPANY(ConsolidationSetup."Consolidation Company Name");
    //                BusinessUnit.GET(CompanytoConsolidate.Code);
    //                ConsolidationNAS2.SetCompanyValues(ConsolidationSetup.Code,CompanytoConsolidate.Code);
    //                NASImportDatabase.SetOptionFilters("DocumentNo.",MonthEndDate,ConsolidationSetup,CompanytoConsolidate,
    //                                                    GlobelControlCompany);
    //                IF NOT NASImportDatabase.RunDatabaseConsolidation THEN BEGIN
    //                  IF NASSetup."NAS2 Logging Level" = NASSetup."NAS2 Logging Level"::"Business Unit" THEN
    //                    CreateErrorLog('','',
    //                      STRSUBSTNO('NAS2: %1 RunDatabaseConsolidation failed.',CompanytoConsolidate."Company Name"));
    //                  ErrorExist := TRUE;
    //                END ELSE BEGIN
    //                  //>>ALR Don't mark the whole consolidation complete unless ALL business units were successful!
    //                  IF NASSetup."NAS2 Logging Level" = NASSetup."NAS2 Logging Level"::"Business Unit" THEN
    //                    CreateErrorLog('','',
    //                      STRSUBSTNO('   NAS2: %1 RunDatabaseConsolidation complete.',CompanytoConsolidate."Company Name"));
    ////                  CreateErrorLog('','',STRSUBSTNO('About to update consolidation setup'));
    ////                  UpdateConsolidationsetup(ConsolidationSetup);
    ////                  CreateErrorLog('','',STRSUBSTNO('Updated consolidation setup'));
    //                  //>>ALR
    //                END;
    //            END ELSE BEGIN
    //              BusinessUnit.CHANGECOMPANY(ConsolidationSetup."Consolidation Company Name");
    //              BusinessUnit.GET(CompanytoConsolidate.Code);
    //              ConsolidationNAS2.SetCompanyValues(ConsolidationSetup.Code,CompanytoConsolidate.Code);
    //              NASFileConsolidate.SetOptionFilters(BusinessUnit."File Format"::"Version 4.00 or Later (.xml)",
    //                                                  CompanytoConsolidate."File Name","DocumentNo.",ConsolidationSetup,
    //                                                  CompanytoConsolidate);
    //              IF NASFileConsolidate.RunFileConsolidation THEN BEGIN
    //                AppendDate := '-'+FORMAT(DATE2DMY(MonthEndDate,2))+FORMAT(DATE2DMY(MonthEndDate,3));
    //                RENAME(CompanytoConsolidate."File Name",
    //                       INSSTR(CompanytoConsolidate."File Name",AppendDate,
    //                       STRPOS(CompanytoConsolidate."File Name",'.')));
    //                IF NASSetup."NAS2 Logging Level" = NASSetup."NAS2 Logging Level"::"Business Unit" THEN
    //                  CreateErrorLog('','',
    //                    STRSUBSTNO('   NAS2: %1 RunFileConsolidation complete.',CompanytoConsolidate."Company Name"));

    ////                UpdateConsolidationsetup(ConsolidationSetup);
    //              END ELSE BEGIN
    //                IF NASSetup."NAS2 Logging Level" = NASSetup."NAS2 Logging Level"::"Business Unit" THEN
    //                  CreateErrorLog('','',
    //                    STRSUBSTNO('NAS2: %1 RunFileConsolidation failed.',CompanytoConsolidate."Company Name"));
    //                ErrorExist := TRUE;
    //              END;
    //            END;
    //          UNTIL CompanytoConsolidate.NEXT = 0;
    //        END;
    //        //>>ALR
    //        IF NASSetup."NAS2 Logging Level" >= NASSetup."NAS2 Logging Level"::Consolidation THEN
    //          CreateErrorLog('','',STRSUBSTNO('   NAS2: %1 Eliminations beginning',COMPANYNAME));
    //        //<<ALR
    //        LastRecordPriorty := ConsolidationSetup.Priority;
    //        BusinessUnitEliminate.CHANGECOMPANY(ConsolidationSetup."Consolidation Company Name");
    //        BusinessUnitEliminate.SETRANGE(Consolidate,TRUE);
    //        IF BusinessUnitEliminate.FIND('-') THEN BEGIN
    //          FromEntryNo := GetLastEntryNo +1;
    //          REPEAT
    //            UpdateElimination(BusinessUnitEliminate,ConsolidationSetup.Code,ConsolidationSetup."Consolidation Company Name");
    //          UNTIL BusinessUnitEliminate.NEXT = 0;
    //          ToEntryNo := GetLastEntryNo;
    //        END;
    //        GLReg.CHANGECOMPANY(ConsolidationSetup."Consolidation Company Name");
    //        SourceCodeSetup.CHANGECOMPANY(ConsolidationSetup."Consolidation Company Name");
    //        GLReg.FINDLAST;
    //        LastGLRegNo := GLReg."No.";
    //        GLReg.RESET;
    //        GLReg.LOCKTABLE;
    //        GLReg.INIT;
    //        GLReg."No." := LastGLRegNo + 1;
    //        GLReg."From Entry No." := FromEntryNo;
    //        GLReg."To Entry No." := ToEntryNo;
    //        GLReg."Creation Date" := TODAY;
    //        SourceCodeSetup.GET;
    //        GLReg."Source Code" := SourceCodeSetup.Elimination;
    //        GLReg."User ID" := USERID;
    //        GLReg.INSERT;
    //        //>>ALR
    //        IF NASSetup."NAS2 Logging Level" >= NASSetup."NAS2 Logging Level"::Consolidation THEN
    //          CreateErrorLog('','',STRSUBSTNO('   NAS2: %1 Eliminations complete',COMPANYNAME));
    //        IF NOT ErrorExist THEN
    //          UpdateConsolidationsetup(ConsolidationSetup);
    //        IF NASSetup."NAS2 Logging Level" >= NASSetup."NAS2 Logging Level"::Consolidation THEN
    //          CreateErrorLog('','',STRSUBSTNO('   NAS2: %1 consolidation complete for %2',COMPANYNAME,MonthEndDate));
    //        //<<ALR
    //    UNTIL ConsolidationSetup.NEXT=0;
    //  END;
    //  UpdateAllAnalysisViews;
    //END ELSE BEGIN
    //  IF CreateErrorLog('','', Text101) THEN
    //    EXIT;
    ////END;
    //\\ RAM +++01
    // end;

    //procedure FindLastErrorEntryNo(): Integer
    //begin
    //Deleted local vars as compared to NAV 2009 //RAM - Check It

    //\\ RAM ---01
    //ConsolidationErrorLog.RESET;
    //IF ConsolidationErrorLog.FINDLAST THEN
    //  EXIT(ConsolidationErrorLog."Entry No.")
    //ELSE
    //  EXIT(0);
    //\\ RAM +++01
    //end;

    // procedure EmptyErrorLog()
    //begin
    //Deleted local vars as compared to NAV 2009 //RAM - Check It

    //\\ RAM ---01
    //ConsolErrorLog.RESET;
    //ConsolErrorLog.SETRANGE(Cleared,TRUE);
    //ConsolErrorLog.SETRANGE("User Id", USERID);
    //IF ConsolErrorLog.FINDFIRST THEN
    //  ConsolErrorLog.DELETEALL;
    //\\ RAM +++01
    //end;

    procedure UpdateBUForExRates()
    var
        BusUnitRec: Record 220;
    begin

        BusUnitRec.RESET();
        IF BusUnitRec.FINDSET(TRUE, FALSE) THEN
            REPEAT
                //Closing Rate
                CurrencyCode3 := BusUnitRec."Currency Code";
                CurrencyFactor := BusUnitRec."Balance Currency Factor";
                Date3 := MonthEndDate;
                IF CurrencyCode3 <> '' THEN BEGIN
                    InitValues();
                    IF RefCurrencyCode = '' THEN
                        BusUnitRec."Balance Currency Factor" := CurrentExchRate / NewRefExchRate
                    ELSE
                        BusUnitRec."Balance Currency Factor" := (CurrentExchRate * CurrentExchRate2) / (RefExchRate * NewRefExchRate2);

                    //>>TL01
                    CurrencyCode3 := BusUnitRec."Currency Code";
                    CurrencyFactor := BusUnitRec."Balance Currency Factor";
                    Date3 := CALCDATE('<-1M+CM>', MonthEndDate);
                    InitValues();
                    IF RefCurrencyCode = '' THEN
                        BusUnitRec."Last Balance Currency Factor" := CurrentExchRate / NewRefExchRate
                    ELSE
                        BusUnitRec."Last Balance Currency Factor" := (CurrentExchRate * CurrentExchRate2) / (RefExchRate * NewRefExchRate2);
                    //<<TL01

                    //Average Rate
                    CurrencyCode3 := BusUnitRec."Currency Code";
                    CurrencyFactor := BusUnitRec."Income Currency Factor";
                    Date3 := MonthEndDate;
                    InitValues();
                    IF RefCurrencyCode = '' THEN
                        BusUnitRec."Income Currency Factor" := CurrentExchRate / NewRefExchRate
                    ELSE
                        BusUnitRec."Income Currency Factor" := (CurrentExchRate * CurrentExchRate2) / (RefExchRate * NewRefExchRate2);

                    BusUnitRec.MODIFY();
                END;
            UNTIL BusUnitRec.NEXT() = 0;
    end;

    procedure InitValues()
    begin
        //>>KW11.01:EDD-1.9.3.7:2:1
        CurrExchRate.SETRANGE("Currency Code", CurrencyCode3);
        CurrExchRate.SETRANGE("Starting Date", 0D, Date3);
        CurrExchRate.FIND('+');
        CurrencyCode := CurrExchRate."Currency Code";
        CurrentExchRate := CurrExchRate."Exchange Rate Amount";
        RefExchRate := CurrExchRate."Relational Exch. Rate Amount";
        NewRefExchRate := CurrExchRate."Relational Exch. Rate Amount";
        RefCurrencyCode := CurrExchRate."Relational Currency Code";
        Fix := CurrExchRate."Fix Exchange Rate Amount";
        CurrExchRate.SETRANGE("Currency Code", RefCurrencyCode);
        CurrExchRate.SETRANGE("Starting Date", 0D, Date3);
        IF CurrExchRate.FIND('+') THEN BEGIN
            CurrencyCode2 := CurrExchRate."Currency Code";
            CurrentExchRate2 := CurrExchRate."Exchange Rate Amount";
            RefExchRate2 := CurrExchRate."Relational Exch. Rate Amount";
            NewRefExchRate2 := CurrExchRate."Relational Exch. Rate Amount";
            RefCurrencyCode2 := CurrExchRate."Relational Currency Code";
            Fix2 := CurrExchRate."Fix Exchange Rate Amount";
        END;

        CASE Fix OF
            CurrExchRate."Fix Exchange Rate Amount"::Currency:

                IF RefCurrencyCode = '' THEN
                    RefExchRate := CurrentExchRate / CurrencyFactor
                ELSE
                    RefExchRate := (CurrentExchRate * CurrentExchRate2) / (CurrencyFactor * RefExchRate2);
            CurrExchRate."Fix Exchange Rate Amount"::"Relational Currency":

                IF RefCurrencyCode = '' THEN
                    CurrentExchRate := CurrencyFactor * RefExchRate
                ELSE
                    CurrentExchRate := (RefExchRate * RefExchRate2 * CurrencyFactor) / CurrentExchRate2;
            CurrExchRate."Fix Exchange Rate Amount"::Both:
                ;

        END;

        IF RefCurrencyCode <> '' THEN BEGIN
            IF (Fix <> CurrExchRate."Fix Exchange Rate Amount"::Both) AND (Fix2 <> CurrExchRate."Fix Exchange Rate Amount"::Both) THEN
                ERROR(
                  'The %1 field is not set up properly in the Currrency Exchange Rates window. ' +
                  'For %2 or the currency set up in the %3 field, the %1 field should be set to both.',
                  CurrExchRate.FIELDCAPTION("Fix Exchange Rate Amount"), CurrencyCode,
                  CurrExchRate.FIELDCAPTION("Relational Currency Code"));
            CASE Fix2 OF
                CurrExchRate."Fix Exchange Rate Amount"::Currency:

                    RefExchRate2 := (CurrentExchRate * CurrentExchRate2) / (CurrencyFactor * RefExchRate);
                CurrExchRate."Fix Exchange Rate Amount"::"Relational Currency":

                    CurrentExchRate2 := (CurrencyFactor * RefExchRate * RefExchRate2) / CurrentExchRate;
                CurrExchRate."Fix Exchange Rate Amount"::Both:
                    ;

            END;
        END;
    end;
}

