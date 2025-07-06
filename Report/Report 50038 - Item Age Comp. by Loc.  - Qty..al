report 50038 "Item Age Comp. by Loc.  - Qty."
{
    // NF1.00:CIS.SP  09-04-15 Merged during upgrade
    // >>NF1
    // Export To Excel as per requirement
    // New Page Per Location Concept and other changes as per requirement
    // <<NF1
    // 
    // >> NIF
    // 05-23-05 RTT Created, copied from report 5807
    // Code to use variable length periods
    // - changed PeriodLength variable to an array variable of size 8
    // - changed dim of PeriodStartDate from 7 to 9
    // - changed dim of InvtQty from 6 to 8
    // - code at OnPreReport
    // - code at RequestForm-OnOpenForm
    // - code at Item Ledger Entry - OnAfterGetRecord
    // 07-01-05 RTT added functionality to mirrir invt. valuation calc
    //          - new fcns
    //          - new var AsOfDate
    //          - Code at OnPreReport
    //          - removed WHERE(Open=CONST(Yes)) for Item Ledger Entry
    // 06-08-07 RTT Add Aging option
    //              - new var AgingOption added to RequestForm
    //              - code at "Item Ledger Entry" - OnAfterGetRecord()
    //              - new report section
    // << NIF
    // 
    // //>>Export to Excel
    // New Globals
    // New function EnterCell
    // Code at OnPreReport
    // Code at OnPostReport
    // Code at OnPreSection for
    //   Item, Header (1) - OnPreSection
    //   Item, Header (3) - OnPreSection
    //   Item Ledger Entry, Footer (3) - OnPreSection
    //   Item Ledger Entry, Body (2) - OnPreSection
    //   Item, Footer (5) - OnPreSection
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = '.\RDLC\Item Age Comp. by Loc.  - Qty..rdlc';

    Caption = 'Item Age Comp. by Loc.  - Qty.';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Location; Location)
        {
            DataItemTableView = SORTING(Code);
            RequestFilterFields = "Code", "Use As In-Transit";
            column(LocationCode; Location.Code)
            {
            }
            column(CompanyName; CompanyInformation.Name)
            {
            }
            column(LocationTableCaptLocationFilter; TABLECAPTION + ': ' + LocationFilter)
            {
            }
            column(LocationFilter; LocationFilter)
            {
            }
            column(AsOfDate; 'As of ' + FORMAT(AsOfDate))
            {
            }
            column(AgingOption; 'Aged by ' + FORMAT(AgingOption))
            {
            }
            column(ItemTableCaptItemFilter; 'Item' + ': ' + ItemFilter)
            {
            }
            column(ItemFilter; ItemFilter)
            {
            }
            column(DaysText1; FORMAT(DaysText[1]))
            {
            }
            column(DaysText2; FORMAT(DaysText[2]))
            {
            }
            column(DaysText3; FORMAT(DaysText[3]))
            {
            }
            column(DaysText4; FORMAT(DaysText[4]))
            {
            }
            column(DaysText5; FORMAT(DaysText[5]))
            {
            }
            column(DaysText6; FORMAT(DaysText[6]))
            {
            }
            column(AfterPeriodStartDate31; 'After ' + FORMAT(PeriodStartDate[3] + 1))
            {
            }
            column(PeriodStartDate41; FORMAT(PeriodStartDate[4] + 1))
            {
            }
            column(PeriodStartDate3; FORMAT(PeriodStartDate[3]))
            {
            }
            column(PeriodStartDate4; FORMAT(PeriodStartDate[4]))
            {
            }
            column(PeriodStartDate5; FORMAT(PeriodStartDate[5]))
            {
            }
            column(PeriodStartDate6; FORMAT(PeriodStartDate[6]))
            {
            }
            column(PeriodStartDate51; FORMAT(PeriodStartDate[5] + 1))
            {
            }
            column(PeriodStartDate61; FORMAT(PeriodStartDate[6] + 1))
            {
            }
            column(PeriodStartDate71; FORMAT(PeriodStartDate[7] + 1))
            {
            }
            column(BeforePeriodStartDate71; 'Before ' + FORMAT(PeriodStartDate[7] + 1))
            {
            }
            column(LocationCodeName; Location.Code + ' - ' + Location.Name)
            {
            }
            column(PrintDetail; PrintDetail)
            {
            }
            column(LocationTotals; 'Location ' + Location.Code + ' Totals')
            {
            }
            column(NewPageCount; NewPageCount)
            {
            }
            column(DecimalPlacesFormat; DecimalPlacesFormat)
            {
                DecimalPlaces = 0 : 2;
            }
            dataitem(Item; Item)
            {
                DataItemLink = "Location Filter" = FIELD(Code);
                DataItemTableView = SORTING("No.")
                                    WHERE(Type = CONST(Inventory));
                RequestFilterFields = "No.", "Inventory Posting Group", "Statistics Group", "Location Filter";
                dataitem("Item Ledger Entry"; "Item Ledger Entry")
                {
                    DataItemLink = "Item No." = FIELD("No."),
                                   "Location Code" = FIELD("Location Filter"),
                                   "Variant Code" = FIELD("Variant Filter"),
                                   "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                   "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
                    DataItemTableView = SORTING("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date");

                    trigger OnAfterGetRecord()
                    begin
                        //>> NIF 07-01-05 RTT
                        AdjustItemLedgEntryToAsOfDate("Item Ledger Entry");
                        //<< NIF 07-01-05 RTT

                        IF "Remaining Quantity" = 0 THEN
                            CurrReport.SKIP;

                        TempItemLedgEntry.INIT;
                        TempItemLedgEntry := "Item Ledger Entry";
                        //>>NIF 060807 RTT
                        IF AgingOption = AgingOption::"Lot Creation Date" THEN
                            IF LotNoInfo.GET("Item No.", '', "Lot No.") THEN
                                IF LotNoInfo."Lot Creation Date" <> 0D THEN
                                    TempItemLedgEntry."Posting Date" := LotNoInfo."Lot Creation Date";
                        //<<NIF 060807 RTT

                        TempItemLedgEntry.INSERT;

                        IF NOT TempItem.GET(Item."No.") THEN BEGIN
                            TempItem.INIT;
                            TempItem := Item;
                            TempItem.INSERT;
                        END;
                    end;

                    trigger OnPreDataItem()
                    begin
                        //CurrReport.CREATETOTALS(TotalInvtQty, InvtQty[1], InvtQty[2], InvtQty[3], InvtQty[4], InvtQty[5], InvtQty[6], InvtQty[7]);//InvtQty BC Upgrade
                        //>> NIF 07-01-05 RTT
                        SETRANGE("Location Code", Location.Code);
                        SETRANGE("Posting Date", 0D, AsOfDate);
                        //<< NIF 07-01-05 RTT
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    ItemLedgEntry: Record "Item Ledger Entry";
                begin
                end;

                trigger OnPreDataItem()
                begin
                    //CurrReport.CREATETOTALS(TotalInvtQty, InvtQty[1], InvtQty[2], InvtQty[3], InvtQty[4], InvtQty[5], InvtQty[6], InvtQty[7]);//InvtQty BC Upgrade
                end;
            }
            dataitem(ItemLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                column(TempItemNo; TempItem."No.")
                {
                }
                column(TempItemDescription; TempItem.Description)
                {
                }
                column(InvtQty12_ItemLoop; InvtQty[1] + InvtQty[2])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(InvtQty3_ItemLoop; InvtQty[3])
                {
                    AutoFormatType = 1;
                    DecimalPlaces = 0 : 2;
                }
                column(InvtQty4_ItemLoop; InvtQty[4])
                {
                    AutoFormatType = 1;
                    DecimalPlaces = 0 : 2;
                }
                column(InvtQty5_ItemLoop; InvtQty[5])
                {
                    AutoFormatType = 1;
                    DecimalPlaces = 0 : 2;
                }
                column(InvtQty6_ItemLoop; InvtQty[6])
                {
                    AutoFormatType = 1;
                    DecimalPlaces = 0 : 2;
                }
                column(InvtQty7_ItemLoop; InvtQty[7])
                {
                    AutoFormatType = 1;
                    DecimalPlaces = 0 : 2;
                }
                column(TotalInvtQty_ItemLoop; TotalInvtQty)
                {
                    AutoFormatType = 1;
                    DecimalPlaces = 0 : 2;
                }
                dataitem(ItemLedgerLoop; Integer)
                {
                    DataItemTableView = SORTING(Number);
                    column(TempItemLedgEntryPostingDate; FORMAT(TempItemLedgEntry."Posting Date"))
                    {
                    }
                    column(TempItemLedgEntryLocationCode; TempItemLedgEntry."Location Code")
                    {
                    }
                    column(TempItemLedgEntryLotNo; TempItemLedgEntry."Lot No.")
                    {
                    }
                    column(InvtQty12_ItemLedgerLoop; InvtQty[1] + InvtQty[2])
                    {
                        DecimalPlaces = 0 : 2;
                    }
                    column(InvtQty3_ItemLedgerLoop; InvtQty[3])
                    {
                        AutoFormatType = 1;
                        DecimalPlaces = 0 : 2;
                    }
                    column(InvtQty4_ItemLedgerLoop; InvtQty[4])
                    {
                        AutoFormatType = 1;
                        DecimalPlaces = 0 : 2;
                    }
                    column(InvtQty5_ItemLedgerLoop; InvtQty[5])
                    {
                        AutoFormatType = 1;
                        DecimalPlaces = 0 : 2;
                    }
                    column(InvtQty6_ItemLedgerLoop; InvtQty[6])
                    {
                        AutoFormatType = 1;
                        DecimalPlaces = 0 : 2;
                    }
                    column(InvtQty7_ItemLedgerLoop; InvtQty[7])
                    {
                        AutoFormatType = 1;
                        DecimalPlaces = 0 : 2;
                    }
                    column(TotalInvtQty_ItemLedgerLoop; TotalInvtQty)
                    {
                        AutoFormatType = 1;
                        DecimalPlaces = 0 : 2;
                    }
                    column(PrintLine; PrintLine)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin

                        IF Number = 1 THEN
                            TempItemLedgEntry.FIND('-')
                        ELSE
                            TempItemLedgEntry.NEXT(1);

                        FOR i := 1 TO 7 DO
                            InvtQty[i] := 0;

                        TotalInvtQty := TempItemLedgEntry."Remaining Quantity";
                        LocTotalInvtQty := LocTotalInvtQty + TotalInvtQty;

                        FOR i := 1 TO 7 DO
                            IF (TempItemLedgEntry."Posting Date" <= PeriodStartDate[i]) AND
                              (TempItemLedgEntry."Posting Date" > (PeriodStartDate[i + 1]))
                            THEN BEGIN
                                InvtQty[i] := TempItemLedgEntry."Remaining Quantity";
                                LocInvtQty[i] := LocInvtQty[i] + InvtQty[i];
                            END;


                        //>> NF1.00:CIS.SP 09-04-15
                        PrintLine := TRUE;

                        ExcelItemWiseTotalInvtQty12 += InvtQty[1] + InvtQty[2];
                        ExcelItemWiseTotalInvtQty3 += InvtQty[3];
                        ExcelItemWiseTotalInvtQty4 += InvtQty[4];
                        ExcelItemWiseTotalInvtQty5 += InvtQty[5];
                        ExcelItemWiseTotalInvtQty6 += InvtQty[6];
                        ExcelItemWiseTotalInvtQty7 += InvtQty[7];
                        ExcelItemWiseTotalInvtQtyTotal += TotalInvtQty;

                        IF (ExportToExcel) AND (TempItemLedgEntry."Location Code" <> '') AND (PrintDetail) THEN
                            MakeExcelDataBodyPrintDetails;
                        //<< NF1.00:CIS.SP 09-04-15
                    end;

                    trigger OnPreDataItem()
                    begin
                        //CurrReport.CREATETOTALS(InvtQty[1], InvtQty[2], InvtQty[3], InvtQty[4], InvtQty[5], InvtQty[6], InvtQty[7], TotalInvtQty);//InvtQty BC Upgrade
                        TempItemLedgEntry.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code");
                        TempItemLedgEntry.SETRANGE("Item No.", TempItem."No.");
                        TempItemLedgEntry.SETRANGE("Location Code", Location.Code);
                        SETRANGE(Number, 1, TempItemLedgEntry.COUNT);
                    end;
                }
                dataitem(DataItem1102622073; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(TotalInvtQty_ItemLedgEntry; ExcelItemWiseTotalInvtQtyTotal)
                    {
                        AutoFormatType = 1;
                        DecimalPlaces = 0 : 2;
                    }
                    column(InvtQty12__ItemLedgEntry; ExcelItemWiseTotalInvtQty12)
                    {
                        DecimalPlaces = 0 : 2;
                    }
                    column(InvtQty7_ItemLedgEntry; ExcelItemWiseTotalInvtQty7)
                    {
                        AutoFormatType = 1;
                        DecimalPlaces = 0 : 2;
                    }
                    column(InvtQty6_ItemLedgEntry; ExcelItemWiseTotalInvtQty6)
                    {
                        AutoFormatType = 1;
                        DecimalPlaces = 0 : 2;
                    }
                    column(InvtQty5_ItemLedgEntry; ExcelItemWiseTotalInvtQty5)
                    {
                        AutoFormatType = 1;
                        DecimalPlaces = 0 : 2;
                    }
                    column(InvtQty4_ItemLedgEntry; ExcelItemWiseTotalInvtQty4)
                    {
                        AutoFormatType = 1;
                        DecimalPlaces = 0 : 2;
                    }
                    column(InvtQty3_ItemLedgEntry; ExcelItemWiseTotalInvtQty3)
                    {
                        AutoFormatType = 1;
                        DecimalPlaces = 0 : 2;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        //>> NF1.00:CIS.SP 09-04-15
                        IF (ExportToExcel) AND (TempItem."No." <> '') AND (NOT PrintDetail) THEN
                            MakeExcelDataBody;
                        //<< NF1.00:CIS.SP 09-04-15
                    end;
                }

                trigger OnAfterGetRecord()
                begin

                    IF Number = 1 THEN
                        TempItem.FIND('-')
                    ELSE
                        TempItem.NEXT(1);

                    //>> NF1.00:CIS.SP 09-04-15
                    PrintLine := FALSE;
                    ExcelItemWiseTotalInvtQty12 := 0;
                    ExcelItemWiseTotalInvtQty3 := 0;
                    ExcelItemWiseTotalInvtQty4 := 0;
                    ExcelItemWiseTotalInvtQty5 := 0;
                    ExcelItemWiseTotalInvtQty6 := 0;
                    ExcelItemWiseTotalInvtQty7 := 0;
                    ExcelItemWiseTotalInvtQtyTotal := 0;
                    //<< NF1.00:CIS.SP 09-04-15
                end;

                trigger OnPostDataItem()
                begin
                    //>> NF1.00:CIS.SP 09-04-15
                    ValuesExist := ((InvtQty[1] <> 0) OR (InvtQty[2] <> 0) OR (InvtQty[3] <> 0) OR (InvtQty[4] <> 0) OR
                                           (InvtQty[5] <> 0) OR (InvtQty[6] <> 0) OR (InvtQty[7] <> 0) OR (TotalInvtQty <> 0));

                    IF (ExportToExcel) AND (ValuesExist) THEN BEGIN
                        MakeExcelDataFooterLocationWiseTotals;
                    END
                    //<< NF1.00:CIS.SP 09-04-15
                end;

                trigger OnPreDataItem()
                begin
                    //CurrReport.CREATETOTALS(InvtQty[1], InvtQty[2], InvtQty[3], InvtQty[4], InvtQty[5], InvtQty[6], InvtQty[7], TotalInvtQty);//InvtQty BC Upgrade
                    SETRANGE(Number, 1, TempItem.COUNT);
                end;
            }
            dataitem(PageBreak; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                column(ValuesExist; ValuesExist)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    ValuesExist := ((LocInvtQty[1] <> 0) OR (LocInvtQty[2] <> 0) OR (LocInvtQty[3] <> 0) OR (LocInvtQty[4] <> 0) OR
                                           (LocInvtQty[5] <> 0) OR (LocInvtQty[6] <> 0) OR (LocInvtQty[7] <> 0) OR (LocTotalInvtQty <> 0));

                    /* BC Upgrade
                    IF NewPagePerLoc AND ValuesExist THEN
                        CurrReport.NEWPAGE; */
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(LocTotalInvtQty);
                CLEAR(LocInvtQty);
                TempItemLedgEntry.DELETEALL;
                TempItem.DELETEALL;

                d.UPDATE(1, Code);

                //>> NF1.00:CIS.SP 09-04-15
                IF NewPagePerLoc THEN BEGIN
                    IF PrevLocation <> Location.Code THEN BEGIN
                        NewPageCount += 1;
                        PrevLocation := Location.Code;
                    END;
                END;

                ClearExcelTotalInvtVariables;
                //<< NF1.00:CIS.SP 09-04-15
            end;

            trigger OnPostDataItem()
            begin
                //>> NF1.00:CIS.SP 09-04-15
                IF ExportToExcel THEN
                    MakeExcelDataFooterGrandTotals;
                //<< NF1.00:CIS.SP 09-04-15
            end;

            trigger OnPreDataItem()
            begin
                d.OPEN('Reading Location #1##################');
                //CurrReport.CREATETOTALS(InvtQty[1], InvtQty[2], InvtQty[3], InvtQty[4], InvtQty[5], InvtQty[6], InvtQty[7], TotalInvtQty);//InvtQty BC Upgrade
            end;
        }
    }

    requestpage
    {
        Caption = 'Item Age Composition - Qty.';
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field("As of Date"; PeriodStartDate[2])
                    {
                        ApplicationArea = All;
                        Caption = 'As of Date';

                        trigger OnValidate()
                        begin
                            //>> NIF
                            //IF PeriodStartDate[5] = 0D THEN
                            //  ERROR(Text002);
                            //<< NIF
                        end;
                    }
                    field("Period Length[1]"; PeriodLength[1])
                    {
                        ApplicationArea = All;
                        Caption = 'Period Length[1]';

                        trigger OnValidate()
                        begin
                            IF FORMAT(PeriodLength[1]) = '' THEN
                                EVALUATE(PeriodLength[1], '<60D>');
                        end;
                    }
                    field("Period Length[2]"; PeriodLength[2])
                    {
                        ApplicationArea = All;
                        Caption = 'Period Length[2]';

                        trigger OnValidate()
                        begin
                            IF FORMAT(PeriodLength[2]) = '' THEN
                                EVALUATE(PeriodLength[2], '<60D>');
                        end;
                    }
                    field("Period Length[3]"; PeriodLength[3])
                    {
                        ApplicationArea = All;
                        Caption = 'Period Length[3]';

                        trigger OnValidate()
                        begin
                            IF FORMAT(PeriodLength[3]) = '' THEN
                                EVALUATE(PeriodLength[3], '<60D>');
                        end;
                    }
                    field("Period Length[4]"; PeriodLength[4])
                    {
                        ApplicationArea = All;
                        Caption = 'Period Length[4]';

                        trigger OnValidate()
                        begin
                            IF FORMAT(PeriodLength[4]) = '' THEN
                                EVALUATE(PeriodLength[4], '<90D>');
                        end;
                    }
                    field("Period Length[5]"; PeriodLength[5])
                    {
                        ApplicationArea = All;
                        Caption = 'Period Length[5]';

                        trigger OnValidate()
                        begin
                            IF FORMAT(PeriodLength[5]) = '' THEN
                                EVALUATE(PeriodLength[5], '<90D>');
                        end;
                    }
                    field("Print Detail"; PrintDetail)
                    {
                        ApplicationArea = All;
                        Caption = 'Print Detail';
                    }
                    field("Export to Excel"; ExportToExcel)
                    {
                        ApplicationArea = All;
                        Caption = 'Export to Excel';
                    }
                    field("New Page per Location"; NewPagePerLoc)
                    {
                        ApplicationArea = All;
                        Caption = 'New Page per Location';
                    }
                    field("Aged by:"; AgingOption)
                    {
                        ApplicationArea = All;
                        Caption = 'Aged by:';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            //>> NIF
            //IF PeriodStartDate[5] = 0D THEN
            //  PeriodStartDate[5] := CALCDATE('<CM>',WORKDATE);
            //IF FORMAT(PeriodLength) = '' THEN
            //  EVALUATE(PeriodLength,'<1M>');
            IF PeriodStartDate[2] = 0D THEN
                PeriodStartDate[2] := WORKDATE;

            IF FORMAT(PeriodLength[1]) = '' THEN
                EVALUATE(PeriodLength[1], '<60D>');
            IF FORMAT(PeriodLength[2]) = '' THEN
                EVALUATE(PeriodLength[2], '<60D>');
            IF FORMAT(PeriodLength[3]) = '' THEN
                EVALUATE(PeriodLength[3], '<60D>');
            IF FORMAT(PeriodLength[4]) = '' THEN
                EVALUATE(PeriodLength[4], '<90D>');
            IF FORMAT(PeriodLength[5]) = '' THEN
                EVALUATE(PeriodLength[5], '<90D>');
            //<< NIF
        end;
    }

    labels
    {
        ItemAgeCompositionCaption = 'Item Age Comp. by Loc.  - Qty.';
        CurrReportPageNoCaption = 'Page';
        AfterCaption = 'After...';
        BeforeCaption = '...Before';
        InventoryValueCaption = 'Inventory';
        ItemDescriptionCaption = 'Description';
        ItemNoCaption = 'Item No.';
        TotalCaption = 'Total';
        PostingDateCaption = 'Posting Date';
        LocationCodeCaption = 'Location Code';
        LotNoCaption = 'Lot No.';
        GrandTotalsCaption = 'Grand Totals';
    }

    trigger OnPostReport()
    begin
        //>> NF1.00:CIS.SP 09-04-15
        IF ExportToExcel THEN
            CreateExcelbook;
        //<< NF1.00:CIS.SP 09-04-15
    end;

    trigger OnPreReport()
    var
        NegPeriodLength: DateFormula;
    begin
        ItemFilter := Item.GETFILTERS;
        LocationFilter := Location.GETFILTERS;
        //>> NIF
        //PeriodStartDate[6] := 12319999D;
        //FOR i := 1 TO 3 DO
        //EVALUATE(NegPeriodLength,STRSUBSTNO('-%1',FORMAT(PeriodLength)));
        //  PeriodStartDate[5 - i] := CALCDATE('-' + FORMAT(PeriodLength),PeriodStartDate[6 - i]);
        PeriodStartDate[8] := 18991231D;//12311899D BC Upgrade
        PeriodStartDate[1] := 99991231D;//12319999D BC Upgrade
        IF PeriodStartDate[2] = 0D THEN
            ERROR('You must enter an As of Date.');
        FOR i := 2 TO 6 DO
            PeriodStartDate[i + 1] := CALCDATE('-' + FORMAT(PeriodLength[i - 1]), PeriodStartDate[i]);

        DaysText[1] := '0-' + FORMAT(PeriodStartDate[3] - PeriodStartDate[2]);
        FOR i := 2 TO 5 DO
            DaysText[i] := FORMAT(PeriodStartDate[2] - PeriodStartDate[i + 1] + 1) + '-' +
                           FORMAT(PeriodStartDate[2] - PeriodStartDate[i + 2]);
        DaysText[6] := '> ' + FORMAT(PeriodStartDate[2] - PeriodStartDate[7]);

        //<< NIF
        //>> NIF 07-01-05 RTT
        AsOfDate := PeriodStartDate[2];
        //<< NIF 07-01-05 RTT
        CompanyInformation.GET;

        //>> NIF RTT 11-02-05
        IF ExportToExcel THEN BEGIN
            ExcelBuf.DELETEALL;
            MainTitle := 'Item Aging Composition';
            SubTitle := 'by Location, by Quantity';
            IF PrintDetail THEN
                SubTitle2 := 'Detail'
            ELSE
                SubTitle2 := 'Summary';
            SubTitle2 := SubTitle2 + ' as of ' + FORMAT(AsOfDate);

            MakeExcelInfo; //NF1.00:CIS.SP 09-04-15
        END;
        //<< NIF RTT 11-02-05

        //>> NF1.00:CIS.SP 09-04-15
        NewPageCount := 0;
        ExcelGrandTotalInvtQty12 := 0;
        ExcelGrandTotalInvtQty3 := 0;
        ExcelGrandTotalInvtQty4 := 0;
        ExcelGrandTotalInvtQty5 := 0;
        ExcelGrandTotalInvtQty6 := 0;
        ExcelGrandTotalInvtQty7 := 0;
        ExcelGrandTotalInvtQtyTotal := 0;
        //<< NF1.00:CIS.SP 09-04-15
    end;

    var
        CompanyInformation: Record "Company Information";
        ItemFilter: Text;
        InvtQty: array[8] of Decimal;
        PeriodStartDate: array[9] of Date;
        PeriodLength: array[8] of DateFormula;
        i: Integer;
        TotalInvtQty: Decimal;
        PrintLine: Boolean;
        ">>NIF_GV": Integer;
        DaysText: array[8] of Text[30];
        PrintDetail: Boolean;
        AsOfDate: Date;
        RemainingQty: Decimal;
        d: Dialog;
        ItemCostMgt: Codeunit ItemCostManagement;
        ExcelBuf: Record "Excel Buffer" temporary;
        RowNo: Integer;
        ColumnNo: Integer;
        ExportToExcel: Boolean;
        MainTitle: Text[100];
        SubTitle: Text[100];
        SubTitle2: Text[100];
        NewPagePerLoc: Boolean;
        ValuesExist: Boolean;
        TempItemLedgEntry: Record "Item Ledger Entry" temporary;
        TempItem: Record Item temporary;
        LocTotalInvtQty: Decimal;
        LocInvtQty: array[8] of Decimal;
        LocationFilter: Text[250];
        AgingOption: Option "Lot Creation Date","Posting Date";
        LotNoInfo: Record "Lot No. Information";
        NewPageCount: Integer;
        PrevLocation: Code[20];
        ExcelItemWiseTotalInvtQty12: Decimal;
        ExcelItemWiseTotalInvtQty3: Decimal;
        ExcelItemWiseTotalInvtQty4: Decimal;
        ExcelItemWiseTotalInvtQty5: Decimal;
        ExcelItemWiseTotalInvtQty6: Decimal;
        ExcelItemWiseTotalInvtQty7: Decimal;
        ExcelItemWiseTotalInvtQtyTotal: Decimal;
        ExcelTotalInvtQty12: Decimal;
        ExcelTotalInvtQty3: Decimal;
        ExcelTotalInvtQty4: Decimal;
        ExcelTotalInvtQty5: Decimal;
        ExcelTotalInvtQty6: Decimal;
        ExcelTotalInvtQty7: Decimal;
        ExcelTotalInvtQtyTotal: Decimal;
        ExcelGrandTotalInvtQty12: Decimal;
        ExcelGrandTotalInvtQty3: Decimal;
        ExcelGrandTotalInvtQty4: Decimal;
        ExcelGrandTotalInvtQty5: Decimal;
        ExcelGrandTotalInvtQty6: Decimal;
        ExcelGrandTotalInvtQty7: Decimal;
        ExcelGrandTotalInvtQtyTotal: Decimal;
        Text002: Label 'Sub Title 2';
        Text003: Label 'Sub Title';
        Text004: Label 'Main Title';
        Text005: Label 'Company Name';
        Text006: Label 'Report No.';
        Text007: Label 'Report Name';
        Text008: Label 'User ID';
        Text009: Label 'Date';
        Text010: Label 'Location Filters';
        Text011: Label 'Item Filters';
        Text012: Label 'Item Age Comp. by Loc.  - Qty.';
        Text014: Label 'Days';
        Text015: Label 'Location Code';
        Text016: Label 'Item No.';
        Text017: Label 'Description';
        Text018: Label 'Posting Date';
        Text019: Label 'Lot No.';
        Text020: Label 'After ';
        Text021: Label 'Before ';
        Text022: Label 'Inventory Qty';
        Text023: Label 'Totals';
        Text024: Label 'Grand Totals';
        DecimalPlacesFormat: Decimal;
        Text025: Label 'Location ';

    procedure ">>NIF_fcn"()
    begin
    end;

    local procedure AdjustItemLedgEntryToAsOfDate(var ItemLedgEntry: Record "Item Ledger Entry")
    var
        ItemApplnEntry: Record "Item Application Entry";
        ValueEntry: Record "Value Entry";
        ItemLedgEntry2: Record "Item Ledger Entry";
        InvoicedValue: Decimal;
        InvoicedValueACY: Decimal;
        InvoicedQty: Decimal;
        ExpectedValue: Decimal;
        ExpectedValueACY: Decimal;
        ValuedQty: Decimal;
    begin

        // adjust remaining quantity
        ItemLedgEntry."Remaining Quantity" := ItemLedgEntry.Quantity;
        IF ItemLedgEntry.Positive THEN BEGIN
            ItemApplnEntry.RESET;
            ItemApplnEntry.SETCURRENTKEY(
              "Inbound Item Entry No.", "Cost Application", "Outbound Item Entry No.");
            ItemApplnEntry.SETRANGE("Inbound Item Entry No.", ItemLedgEntry."Entry No.");
            ItemApplnEntry.SETRANGE("Posting Date", 0D, AsOfDate);
            ItemApplnEntry.SETFILTER("Outbound Item Entry No.", '<>%1', 0);
            ItemApplnEntry.SETFILTER("Item Ledger Entry No.", '<>%1', ItemLedgEntry."Entry No.");
            IF ItemApplnEntry.FIND('-') THEN
                REPEAT
                    IF ItemLedgEntry2.GET(ItemApplnEntry."Item Ledger Entry No.") AND
                       (ItemLedgEntry2."Posting Date" <= AsOfDate)
                    THEN
                        ItemLedgEntry."Remaining Quantity" := ItemLedgEntry."Remaining Quantity" + ItemApplnEntry.Quantity;
                UNTIL ItemApplnEntry.NEXT = 0;
        END ELSE BEGIN
            ItemApplnEntry.RESET;
            ItemApplnEntry.SETCURRENTKEY("Item Ledger Entry No.", "Outbound Item Entry No.", "Cost Application");
            ItemApplnEntry.SETRANGE("Item Ledger Entry No.", ItemLedgEntry."Entry No.");
            ItemApplnEntry.SETRANGE("Outbound Item Entry No.", ItemLedgEntry."Entry No.");
            ItemApplnEntry.SETRANGE("Posting Date", 0D, AsOfDate);
            IF ItemApplnEntry.FIND('-') THEN
                REPEAT
                    IF ItemLedgEntry2.GET(ItemApplnEntry."Inbound Item Entry No.") AND
                       (ItemLedgEntry2."Posting Date" <= AsOfDate)
                    THEN
                        ItemLedgEntry."Remaining Quantity" := ItemLedgEntry."Remaining Quantity" - ItemApplnEntry.Quantity;
                UNTIL ItemApplnEntry.NEXT = 0;
        END;

        // calculate adjusted cost of entry
        ValueEntry.RESET;
        ValueEntry.SETCURRENTKEY(
          "Item Ledger Entry No.", "Expected Cost", "Document No.", "Partial Revaluation", "Entry Type", "Variance Type");
        ValueEntry.SETRANGE("Item Ledger Entry No.", ItemLedgEntry."Entry No.");
        ValueEntry.SETRANGE("Posting Date", 0D, AsOfDate);
        IF ValueEntry.FIND('-') THEN
            REPEAT
                IF ValueEntry."Expected Cost" THEN BEGIN
                    ExpectedValue := ExpectedValue + ValueEntry."Cost Amount (Expected)";
                    ExpectedValueACY := ExpectedValueACY + ValueEntry."Cost Amount (Expected) (ACY)";
                    IF ValuedQty = 0 THEN
                        ValuedQty := ValueEntry."Valued Quantity";
                END ELSE BEGIN
                    InvoicedQty := InvoicedQty + ValueEntry."Invoiced Quantity";
                    InvoicedValue := InvoicedValue + ValueEntry."Cost Amount (Actual)";
                    InvoicedValueACY := InvoicedValueACY + ValueEntry."Cost Amount (Actual) (ACY)";
                END;
            UNTIL ValueEntry.NEXT = 0;
        IF ValuedQty = 0 THEN BEGIN
            ValuedQty := InvoicedQty;
            ExpectedValue := 0;
            ExpectedValueACY := 0;
        END ELSE BEGIN
            ExpectedValue := ExpectedValue * (ValuedQty - InvoicedQty) / ValuedQty;
            ExpectedValueACY := ExpectedValueACY * (ValuedQty - InvoicedQty) / ValuedQty;
        END;
        ItemLedgEntry."Cost Amount (Actual)" := ROUND(InvoicedValue + ExpectedValue);
        //x"Cost Amount (Actual) (ACY)" := ROUND(InvoicedValueACY + ExpectedValueACY,Currency."Amount Rounding Precision");

    end;

    local procedure MakeExcelInfo()
    begin
        //>> NF1.00:CIS.SP 09-04-15
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(FORMAT(Text005), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(COMPANYNAME, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text006), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(REPORT::"Item Age Comp. by Loc.  - Qty.", FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text007), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FORMAT(Text012), FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text008), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(USERID, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text009), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(TODAY, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text004), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(MainTitle, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text003), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(SubTitle, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text002), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(SubTitle2, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text010), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(COPYSTR(Location.GETFILTERS, 1, 250), FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text011), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(COPYSTR(Item.GETFILTERS, 1, 250), FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
        //<< NF1.00:CIS.SP 09-04-15
    end;

    local procedure MakeExcelDataHeader()
    begin
        //>> NF1.00:CIS.SP 09-04-15
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        IF PrintDetail THEN BEGIN
            ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        END;
        ExcelBuf.AddColumn(Text014, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(DaysText[1], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(DaysText[2], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(DaysText[3], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(DaysText[4], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(DaysText[5], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(DaysText[6], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.NewRow;
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        IF PrintDetail THEN BEGIN
            ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        END;
        ExcelBuf.AddColumn(FORMAT(PeriodStartDate[4] + 1), FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(PeriodStartDate[5] + 1), FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(PeriodStartDate[6] + 1), FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(PeriodStartDate[7] + 1), FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.NewRow;
        IF NOT PrintDetail THEN
            ExcelBuf.AddColumn(Text015, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Text016, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Text017, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        IF PrintDetail THEN BEGIN
            ExcelBuf.AddColumn(Text018, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(Text015, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(Text019, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        END;
        ExcelBuf.AddColumn(Text020 + FORMAT(PeriodStartDate[3] + 1), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(PeriodStartDate[3]), FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(PeriodStartDate[4]), FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(PeriodStartDate[5]), FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(PeriodStartDate[6]), FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Text021 + FORMAT(PeriodStartDate[7] + 1), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Text022, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        //<< NF1.00:CIS.SP 09-04-15
    end;

    local procedure MakeExcelDataBody()
    begin
        //>> NF1.00:CIS.SP 09-04-15
        ExcelTotalInvtQty12 += ExcelItemWiseTotalInvtQty12;
        ExcelTotalInvtQty3 += ExcelItemWiseTotalInvtQty3;
        ExcelTotalInvtQty4 += ExcelItemWiseTotalInvtQty4;
        ExcelTotalInvtQty5 += ExcelItemWiseTotalInvtQty5;
        ExcelTotalInvtQty6 += ExcelItemWiseTotalInvtQty6;
        ExcelTotalInvtQty7 += ExcelItemWiseTotalInvtQty7;
        ExcelTotalInvtQtyTotal += ExcelItemWiseTotalInvtQtyTotal;

        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Location.Code, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(TempItem."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(TempItem.Description, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        IF ExcelItemWiseTotalInvtQty12 <> 0 THEN BEGIN
            IF STRPOS(FORMAT(ExcelItemWiseTotalInvtQty12), '.') = 0 THEN
                ExcelBuf.AddColumn(ExcelItemWiseTotalInvtQty12, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number)
            ELSE
                ExcelBuf.AddColumn(ExcelItemWiseTotalInvtQty12, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        END ELSE
            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);

        IF ExcelItemWiseTotalInvtQty3 <> 0 THEN BEGIN
            IF STRPOS(FORMAT(ExcelItemWiseTotalInvtQty3), '.') = 0 THEN
                ExcelBuf.AddColumn(ExcelItemWiseTotalInvtQty3, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number)
            ELSE
                ExcelBuf.AddColumn(ExcelItemWiseTotalInvtQty3, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        END ELSE
            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);

        IF ExcelItemWiseTotalInvtQty4 <> 0 THEN BEGIN
            IF STRPOS(FORMAT(ExcelItemWiseTotalInvtQty4), '.') = 0 THEN
                ExcelBuf.AddColumn(ExcelItemWiseTotalInvtQty4, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number)
            ELSE
                ExcelBuf.AddColumn(ExcelItemWiseTotalInvtQty4, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        END ELSE
            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);

        IF ExcelItemWiseTotalInvtQty5 <> 0 THEN BEGIN
            IF STRPOS(FORMAT(ExcelItemWiseTotalInvtQty5), '.') = 0 THEN
                ExcelBuf.AddColumn(ExcelItemWiseTotalInvtQty5, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number)
            ELSE
                ExcelBuf.AddColumn(ExcelItemWiseTotalInvtQty5, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        END ELSE
            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);

        IF ExcelItemWiseTotalInvtQty6 <> 0 THEN BEGIN
            IF STRPOS(FORMAT(ExcelItemWiseTotalInvtQty6), '.') = 0 THEN
                ExcelBuf.AddColumn(ExcelItemWiseTotalInvtQty6, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number)
            ELSE
                ExcelBuf.AddColumn(ExcelItemWiseTotalInvtQty6, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        END ELSE
            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);

        IF ExcelItemWiseTotalInvtQty7 <> 0 THEN BEGIN
            IF STRPOS(FORMAT(ExcelItemWiseTotalInvtQty7), '.') = 0 THEN
                ExcelBuf.AddColumn(ExcelItemWiseTotalInvtQty7, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number)
            ELSE
                ExcelBuf.AddColumn(ExcelItemWiseTotalInvtQty7, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        END ELSE
            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);

        IF ExcelItemWiseTotalInvtQtyTotal <> 0 THEN BEGIN
            IF STRPOS(FORMAT(ExcelItemWiseTotalInvtQtyTotal), '.') = 0 THEN
                ExcelBuf.AddColumn(ExcelItemWiseTotalInvtQtyTotal, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number)
            ELSE
                ExcelBuf.AddColumn(ExcelItemWiseTotalInvtQtyTotal, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        END ELSE
            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        //<< NF1.00:CIS.SP 09-04-15
    end;

    local procedure MakeExcelDataBodyPrintDetails()
    begin
        //>> NF1.00:CIS.SP 09-04-15
        ExcelTotalInvtQty12 += InvtQty[1] + InvtQty[2];
        ExcelTotalInvtQty3 += InvtQty[3];
        ExcelTotalInvtQty4 += InvtQty[4];
        ExcelTotalInvtQty5 += InvtQty[5];
        ExcelTotalInvtQty6 += InvtQty[6];
        ExcelTotalInvtQty7 += InvtQty[7];
        ExcelTotalInvtQtyTotal += TotalInvtQty;

        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(TempItem."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(TempItem.Description, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(TempItemLedgEntry."Posting Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddColumn(TempItemLedgEntry."Location Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(TempItemLedgEntry."Lot No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        IF InvtQty[1] + InvtQty[2] <> 0 THEN BEGIN
            IF STRPOS(FORMAT(InvtQty[1] + InvtQty[2]), '.') = 0 THEN
                ExcelBuf.AddColumn(InvtQty[1] + InvtQty[2], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number)
            ELSE
                ExcelBuf.AddColumn(InvtQty[1] + InvtQty[2], FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        END ELSE
            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);

        IF InvtQty[3] <> 0 THEN BEGIN
            IF STRPOS(FORMAT(InvtQty[3]), '.') = 0 THEN
                ExcelBuf.AddColumn(InvtQty[3], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number)
            ELSE
                ExcelBuf.AddColumn(InvtQty[3], FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        END ELSE
            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);

        IF InvtQty[4] <> 0 THEN BEGIN
            IF STRPOS(FORMAT(InvtQty[4]), '.') = 0 THEN
                ExcelBuf.AddColumn(InvtQty[4], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number)
            ELSE
                ExcelBuf.AddColumn(InvtQty[4], FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        END ELSE
            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);

        IF InvtQty[5] <> 0 THEN BEGIN
            IF STRPOS(FORMAT(InvtQty[5]), '.') = 0 THEN
                ExcelBuf.AddColumn(InvtQty[5], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number)
            ELSE
                ExcelBuf.AddColumn(InvtQty[5], FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        END ELSE
            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);

        IF InvtQty[6] <> 0 THEN BEGIN
            IF STRPOS(FORMAT(InvtQty[6]), '.') = 0 THEN
                ExcelBuf.AddColumn(InvtQty[6], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number)
            ELSE
                ExcelBuf.AddColumn(InvtQty[6], FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        END ELSE
            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);

        IF InvtQty[7] <> 0 THEN BEGIN
            IF STRPOS(FORMAT(InvtQty[7]), '.') = 0 THEN
                ExcelBuf.AddColumn(InvtQty[7], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number)
            ELSE
                ExcelBuf.AddColumn(InvtQty[7], FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        END ELSE
            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);

        IF TotalInvtQty <> 0 THEN BEGIN
            IF STRPOS(FORMAT(TotalInvtQty), '.') = 0 THEN
                ExcelBuf.AddColumn(TotalInvtQty, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number)
            ELSE
                ExcelBuf.AddColumn(TotalInvtQty, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        END ELSE
            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        //<< NF1.00:CIS.SP 09-04-15
    end;

    local procedure MakeExcelDataFooterLocationWiseTotals()
    begin
        //>> NF1.00:CIS.SP 09-04-15
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        IF PrintDetail THEN BEGIN
            ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        END;
        ExcelBuf.AddColumn(Text025 + Location.Code + Text023, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        IF STRPOS(FORMAT(ExcelTotalInvtQty12), '.') = 0 THEN
            ExcelBuf.AddColumn(ExcelTotalInvtQty12, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number)
        ELSE
            ExcelBuf.AddColumn(ExcelTotalInvtQty12, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);

        IF STRPOS(FORMAT(ExcelTotalInvtQty3), '.') = 0 THEN
            ExcelBuf.AddColumn(ExcelTotalInvtQty3, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number)
        ELSE
            ExcelBuf.AddColumn(ExcelTotalInvtQty3, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);

        IF STRPOS(FORMAT(ExcelTotalInvtQty4), '.') = 0 THEN
            ExcelBuf.AddColumn(ExcelTotalInvtQty4, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number)
        ELSE
            ExcelBuf.AddColumn(ExcelTotalInvtQty4, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);

        IF STRPOS(FORMAT(ExcelTotalInvtQty5), '.') = 0 THEN
            ExcelBuf.AddColumn(ExcelTotalInvtQty5, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number)
        ELSE
            ExcelBuf.AddColumn(ExcelTotalInvtQty5, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);

        IF STRPOS(FORMAT(ExcelTotalInvtQty6), '.') = 0 THEN
            ExcelBuf.AddColumn(ExcelTotalInvtQty6, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number)
        ELSE
            ExcelBuf.AddColumn(ExcelTotalInvtQty6, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);

        IF STRPOS(FORMAT(ExcelTotalInvtQty7), '.') = 0 THEN
            ExcelBuf.AddColumn(ExcelTotalInvtQty7, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number)
        ELSE
            ExcelBuf.AddColumn(ExcelTotalInvtQty7, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);

        IF STRPOS(FORMAT(ExcelTotalInvtQtyTotal), '.') = 0 THEN
            ExcelBuf.AddColumn(ExcelTotalInvtQtyTotal, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number)
        ELSE
            ExcelBuf.AddColumn(ExcelTotalInvtQtyTotal, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.NewRow;

        ExcelGrandTotalInvtQty12 += ExcelTotalInvtQty12;
        ExcelGrandTotalInvtQty3 += ExcelTotalInvtQty3;
        ExcelGrandTotalInvtQty4 += ExcelTotalInvtQty4;
        ExcelGrandTotalInvtQty5 += ExcelTotalInvtQty5;
        ExcelGrandTotalInvtQty6 += ExcelTotalInvtQty6;
        ExcelGrandTotalInvtQty7 += ExcelTotalInvtQty7;
        ExcelGrandTotalInvtQtyTotal += ExcelTotalInvtQtyTotal;
        //<< NF1.00:CIS.SP 09-04-15
    end;

    local procedure MakeExcelDataFooterGrandTotals()
    begin
        //>> NF1.00:CIS.SP 09-04-15
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        IF PrintDetail THEN BEGIN
            ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        END;
        ExcelBuf.AddColumn(Text024, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        IF STRPOS(FORMAT(ExcelGrandTotalInvtQty12), '.') = 0 THEN
            ExcelBuf.AddColumn(ExcelGrandTotalInvtQty12, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number)
        ELSE
            ExcelBuf.AddColumn(ExcelGrandTotalInvtQty12, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);

        IF STRPOS(FORMAT(ExcelGrandTotalInvtQty3), '.') = 0 THEN
            ExcelBuf.AddColumn(ExcelGrandTotalInvtQty3, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number)
        ELSE
            ExcelBuf.AddColumn(ExcelGrandTotalInvtQty3, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);

        IF STRPOS(FORMAT(ExcelGrandTotalInvtQty4), '.') = 0 THEN
            ExcelBuf.AddColumn(ExcelGrandTotalInvtQty4, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number)
        ELSE
            ExcelBuf.AddColumn(ExcelGrandTotalInvtQty4, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);

        IF STRPOS(FORMAT(ExcelGrandTotalInvtQty5), '.') = 0 THEN
            ExcelBuf.AddColumn(ExcelGrandTotalInvtQty5, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number)
        ELSE
            ExcelBuf.AddColumn(ExcelGrandTotalInvtQty5, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);

        IF STRPOS(FORMAT(ExcelGrandTotalInvtQty6), '.') = 0 THEN
            ExcelBuf.AddColumn(ExcelGrandTotalInvtQty6, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number)
        ELSE
            ExcelBuf.AddColumn(ExcelGrandTotalInvtQty6, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);

        IF STRPOS(FORMAT(ExcelGrandTotalInvtQty7), '.') = 0 THEN
            ExcelBuf.AddColumn(ExcelGrandTotalInvtQty7, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number)
        ELSE
            ExcelBuf.AddColumn(ExcelGrandTotalInvtQty7, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);

        IF STRPOS(FORMAT(ExcelGrandTotalInvtQtyTotal), '.') = 0 THEN
            ExcelBuf.AddColumn(ExcelGrandTotalInvtQtyTotal, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number)
        ELSE
            ExcelBuf.AddColumn(ExcelGrandTotalInvtQtyTotal, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        //<< NF1.00:CIS.SP 09-04-15
    end;

    local procedure CreateExcelbook()
    begin
        //>> NF1.00:CIS.SP 09-04-15
        //ExcelBuf.CreateBookAndOpenExcel(MainTitle, MainTitle, COMPANYNAME, USERID);//BC Upgrade
        ExcelBuf.CreateNewBook(MainTitle);//BC Upgrade
        ExcelBuf.WriteSheet(MainTitle, COMPANYNAME, USERID);//BC Upgrade
        ExcelBuf.CloseBook();//BC Upgrade
        ExcelBuf.OpenExcel();//BC Upgrade
        ERROR('');
        //<< NF1.00:CIS.SP 09-04-15
    end;

    local procedure ClearExcelTotalInvtVariables()
    begin
        //>> NF1.00:CIS.SP 09-04-15
        ExcelTotalInvtQty12 := 0;
        ExcelTotalInvtQty3 := 0;
        ExcelTotalInvtQty4 := 0;
        ExcelTotalInvtQty5 := 0;
        ExcelTotalInvtQty6 := 0;
        ExcelTotalInvtQty7 := 0;
        ExcelTotalInvtQtyTotal := 0;

        ExcelItemWiseTotalInvtQty12 := 0;
        ExcelItemWiseTotalInvtQty3 := 0;
        ExcelItemWiseTotalInvtQty4 := 0;
        ExcelItemWiseTotalInvtQty5 := 0;
        ExcelItemWiseTotalInvtQty6 := 0;
        ExcelItemWiseTotalInvtQty7 := 0;
        ExcelItemWiseTotalInvtQtyTotal := 0;
        //<< NF1.00:CIS.SP 09-04-15
    end;
}

