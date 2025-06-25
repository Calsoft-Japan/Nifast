report 50088 "Item Age Composition-Value NIF"
{
    // NF1.00:CIS.SP  09-15-15 Merged during upgrade
    // NF1.00:CIS.NG  08-03-16 Adjust the Margin in Report from Left & Right
    // >>NF1
    // Export To Excel as per requirement
    // <<NF1
    // 
    // >> NIF
    // 05-23-05 RTT Created, copied from report 5808
    // Code to use variable length periods
    // - changed PeriodLength variable to an array variable of size 8
    // - changed dim of PeriodStartDate from 6 to 9
    // - changed dim of InvtQty from 6 to 8
    // - changed dim of InvtValue from 6 to 8
    // - code at OnPreReport
    // - code at RequestForm-OnOpenForm
    // - code at CalcRemainingQty
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
    //   Integer, Body (1) - OnPreSection
    //   Item Ledger Entry, Body (2) - OnPreSection
    //   Item, Footer (7) - OnPreSection
    DefaultLayout = RDLC;
    RDLCLayout = '.\RDLC\Item Age Composition-Value NIF.rdlc';

    Caption = 'Item Age Composition-Value NIF';

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.")
                                WHERE(Type = CONST(Inventory));
            RequestFilterFields = "No.", "Inventory Posting Group", "Statistics Group", "Location Filter";
            column(Item_No; Item."No.")
            {
            }
            column(Item_Description; Item.Description)
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(AsOfDate; 'As of ' + FORMAT(AsOfDate))
            {
            }
            column(AgingOption; 'Aged by ' + FORMAT(AgingOption))
            {
            }
            column(ItemTableCaptItemFilter; TABLECAPTION + ': ' + ItemFilter)
            {
            }
            column(ItemFilter; ItemFilter)
            {
            }
            column(ShowACY; ShowACY)
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
            column(PrintDetail; PrintDetail)
            {
            }
            column(DecimalPlacesFormat; DecimalPlacesFormat)
            {
                DecimalPlaces = 0 : 2;
            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Item No." = FIELD("No."),
                               "Location Code" = FIELD("Location Filter"),
                               "Variant Code" = FIELD("Variant Filter"),
                               "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                               "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
                DataItemTableView = SORTING("Item No.", "Variant Code", Open, Positive, "Location Code");
                column(ItemLedgEntryPostingDate; FORMAT("Item Ledger Entry"."Posting Date"))
                {
                }
                column(ItemLedgEntryLocationCode; "Item Ledger Entry"."Location Code")
                {
                }
                column(ItemLedgEntryLotNo; "Item Ledger Entry"."Lot No.")
                {
                }
                column(InvtValue12_ItemLedgerEntry; InvtValue[1] + InvtValue[2])
                {
                }
                column(InvtValue3_ItemLedgerEntry; InvtValue[3])
                {
                    AutoFormatType = 1;
                }
                column(InvtValue4_ItemLedgerEntry; InvtValue[4])
                {
                    AutoFormatType = 1;
                }
                column(InvtValue5_ItemLedgerEntry; InvtValue[5])
                {
                    AutoFormatType = 1;
                }
                column(InvtValue6_ItemLedgerEntry; InvtValue[6])
                {
                    AutoFormatType = 1;
                }
                column(InvtValue7_ItemLedgerEntry; InvtValue[7])
                {
                    AutoFormatType = 1;
                }
                column(TotalInvtValue_ItemLedgerEntry; TotalInvtValue)
                {
                    AutoFormatType = 1;
                }
                column(PrintLine; PrintLine)
                {
                }
                column(CostExpectedACY; "Item Ledger Entry"."Cost Amount (Expected) (ACY)")
                {
                }
                column(CostActualACY; "Item Ledger Entry"."Cost Amount (Actual) (ACY)")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //>> NIF 07-01-05 RTT
                    AdjustItemLedgEntryToAsOfDate("Item Ledger Entry");
                    //<< NIF 07-01-05 RTT

                    IF "Remaining Quantity" = 0 THEN
                        CurrReport.SKIP;
                    PrintLine := TRUE;
                    //>> NIF 07-01-05 RTT

                    RemainingQty := "Remaining Quantity";
                    //>>NIF 020107
                    //CalcUnitCost;
                    //<<NIF 020107
                    IF ShowACY THEN
                        TotalInvtValue := UnitCostACY * RemainingQty
                    ELSE
                        TotalInvtValue := UnitCost * RemainingQty;
                    CalcValueBucket;
                    //<< NIF 07-01-05 RTT

                    //>> NF1.00:CIS.SP 09-15-15
                    PrintLine := TRUE;

                    ExcelItemWiseTotalInvtValue12 += InvtValue[1] + InvtValue[2];
                    ExcelItemWiseTotalInvtValue3 += InvtValue[3];
                    ExcelItemWiseTotalInvtValue4 += InvtValue[4];
                    ExcelItemWiseTotalInvtValue5 += InvtValue[5];
                    ExcelItemWiseTotalInvtValue6 += InvtValue[6];
                    ExcelItemWiseTotalInvtValue7 += InvtValue[7];
                    ExcelItemWiseTotalInvtValueTotal += TotalInvtValue;

                    IF (ExportToExcel) AND (PrintDetail) THEN
                        MakeExcelDataBodyPrintDetails;
                    //<< NF1.00:CIS.SP 09-15-15
                end;

                trigger OnPreDataItem()
                begin
                    CurrReport.CREATETOTALS(InvtValue[1], InvtValue[2], InvtValue[3], InvtValue[4], InvtValue[5], InvtValue[6], InvtValue[7], InvtValue[8], TotalInvtValue);//InvtValue BC Upgrade
                    //>> NIF 07-01-05 RTT
                    SETRANGE("Posting Date", 0D, AsOfDate);
                    //<< NIF 07-01-05 RTT
                end;
            }
            dataitem(DataItem5444; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                column(TotalInvtValue_ItemLedgEntry; ExcelItemWiseTotalInvtValueTotal)
                {
                    AutoFormatType = 1;
                }
                column(InvtValue12__ItemLedgEntry; ExcelItemWiseTotalInvtValue12)
                {
                }
                column(InvtValue7_ItemLedgEntry; ExcelItemWiseTotalInvtValue7)
                {
                    AutoFormatType = 1;
                }
                column(InvtValue6_ItemLedgEntry; ExcelItemWiseTotalInvtValue6)
                {
                    AutoFormatType = 1;
                }
                column(InvtValue5_ItemLedgEntry; ExcelItemWiseTotalInvtValue5)
                {
                    AutoFormatType = 1;
                }
                column(InvtValue4_ItemLedgEntry; ExcelItemWiseTotalInvtValue4)
                {
                    AutoFormatType = 1;
                }
                column(InvtValue3_ItemLedgEntry; ExcelItemWiseTotalInvtValue3)
                {
                    AutoFormatType = 1;
                }

                trigger OnAfterGetRecord()
                begin
                    //>> NF1.00:CIS.SP 09-15-15
                    IF (ExportToExcel) AND (Item."No." <> '') AND (NOT PrintDetail) AND
                       ((ExcelItemWiseTotalInvtValue12 <> 0) OR (ExcelItemWiseTotalInvtValue3 <> 0) OR (ExcelItemWiseTotalInvtValue4 <> 0) OR
                       (ExcelItemWiseTotalInvtValue5 <> 0) OR (ExcelItemWiseTotalInvtValue6 <> 0) OR (ExcelItemWiseTotalInvtValue7 <> 0) OR
                       (ExcelItemWiseTotalInvtValueTotal <> 0)) THEN
                        MakeExcelDataBody;
                    //<< NF1.00:CIS.SP 09-15-15
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //>> NIF 07-01-05 RTT
                //IF Item."Costing Method" = Item."Costing Method"::Average THEN
                //  ItemCostMgt.CalculateAverageCost(Item,AverageCost,AverageCostACY);
                //<< NIF 07-01-05 RTT

                PrintLine := FALSE;
                //>> NIF 07-01-05 RTT
                d.UPDATE(1, "No.");
                //<< NIF 07-01-05 RTT

                ClearExcelTotalInvtVariables; //NF1.00:CIS.SP 09-15-15
            end;

            trigger OnPostDataItem()
            begin
                //>> NIF 07-01-05 RTT
                d.CLOSE;
                //<< NIF 07-01-05 RTT

                //>> NF1.00:CIS.SP 09-15-15
                IF ExportToExcel THEN
                    MakeExcelDataFooterGrandTotals;
                //<< NF1.00:CIS.SP 09-15-15
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.CREATETOTALS(InvtValue[1], InvtValue[2], InvtValue[3], InvtValue[4], InvtValue[5], InvtValue[6], InvtValue[7], InvtValue[8], TotalInvtValue);//InvtValue BC Upgrade
                SETRANGE("Date Filter", 0D, AsOfDate);

                //>> NIF 07-01-05 RTT
                d.OPEN('Reading Item #1##################');
                //<< NIF 07-01-05 RTT
            end;
        }
    }

    requestpage
    {
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
                        Caption = 'Period Length[1]';

                        trigger OnValidate()
                        begin
                            IF FORMAT(PeriodLength[1]) = '' THEN
                                EVALUATE(PeriodLength[1], '<60D>');
                        end;
                    }
                    field("Period Length[2]"; PeriodLength[2])
                    {
                        Caption = 'Period Length[2]';

                        trigger OnValidate()
                        begin
                            IF FORMAT(PeriodLength[2]) = '' THEN
                                EVALUATE(PeriodLength[2], '<60D>');
                        end;
                    }
                    field("Period Length[3]"; PeriodLength[3])
                    {
                        Caption = 'Period Length[3]';

                        trigger OnValidate()
                        begin
                            IF FORMAT(PeriodLength[3]) = '' THEN
                                EVALUATE(PeriodLength[3], '<60D>');
                        end;
                    }
                    field("Period Length[4]"; PeriodLength[4])
                    {
                        Caption = 'Period Length[4]';

                        trigger OnValidate()
                        begin
                            IF FORMAT(PeriodLength[4]) = '' THEN
                                EVALUATE(PeriodLength[4], '<90D>');
                        end;
                    }
                    field("Period Length[5]"; PeriodLength[5])
                    {
                        Caption = 'Period Length[5]';

                        trigger OnValidate()
                        begin
                            IF FORMAT(PeriodLength[5]) = '' THEN
                                EVALUATE(PeriodLength[5], '<90D>');
                        end;
                    }
                    field("Print Detail"; PrintDetail)
                    {
                        Caption = 'Print Detail';
                    }
                    field("Export to Excel"; ExportToExcel)
                    {
                        Caption = 'Export to Excel';
                    }
                    field("Aged by:"; AgingOption)
                    {
                        Caption = 'Aged by:';
                    }
                    field("Use Additional reporting Currency"; ShowACY)
                    {
                        Caption = 'Use Additional reporting Currency';
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
        ItemAgeCompositionValueCaption = 'Item Age Composition-Value NIF';
        CurrReportPageNoCaption = 'Page';
        AllInventoryUSDCaption = 'All Inventory Values are shown in USD';
        AfterCaption = 'After...';
        BeforeCaption = '...Before';
        InventoryValueCaption = 'Inventory Value';
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
        //>> NF1.00:CIS.SP 09-15-15
        IF ExportToExcel THEN
            CreateExcelbook;
        //<< NF1.00:CIS.SP 09-15-15
    end;

    trigger OnPreReport()
    var
        NegPeriodLength: DateFormula;
    begin
        ItemFilter := Item.GETFILTERS;
        GLSetup.GET; //RAM

        //>> NIF
        //PeriodStartDate[6] := 12319999D;
        //FOR i := 1 TO 3 DO
        //  PeriodStartDate[5 - i] := CALCDATE('-' + FORMAT(PeriodLength),PeriodStartDate[6 - i]);
        PeriodStartDate[8] := 18991231D;
        PeriodStartDate[1] := 99991231D;
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

        //>> NIF RTT 11-02-05
        IF ExportToExcel THEN BEGIN
            ExcelBuf.DELETEALL;
            MainTitle := 'Item Aging Composition';
            SubTitle := 'by Value';
            IF PrintDetail THEN
                SubTitle2 := 'Detail'
            ELSE
                SubTitle2 := 'Summary';
            SubTitle2 := SubTitle2 + ' as of ' + FORMAT(AsOfDate);

            MakeExcelInfo; //NF1.00:CIS.SP 09-15-15
        END;
        //<< NIF RTT 11-02-05

        //>> NF1.00:CIS.SP 09-15-15
        ExcelGrandTotalInvtValue12 := 0;
        ExcelGrandTotalInvtValue3 := 0;
        ExcelGrandTotalInvtValue4 := 0;
        ExcelGrandTotalInvtValue5 := 0;
        ExcelGrandTotalInvtValue6 := 0;
        ExcelGrandTotalInvtValue7 := 0;
        ExcelGrandTotalInvtValueTotal := 0;
        //<< NF1.00:CIS.SP 09-15-15
    end;

    var
        ItemCostMgt: Codeunit ItemCostManagement;
        ItemFilter: Text;
        InvtValue: array[8] of Decimal;
        InvtValueRTC: array[6] of Decimal;
        InvtQty: array[8] of Decimal;
        UnitCost: Decimal;
        PeriodStartDate: array[9] of Date;
        PeriodLength: array[8] of DateFormula;
        i: Integer;
        TotalInvtValue: Decimal;
        TotalInvtValueRTC: Decimal;
        TotalInvtQty: Decimal;
        PrintLine: Boolean;
        AverageCost: Decimal;
        AverageCostACY: Decimal;
        ">>NIF_GV": Integer;
        DaysText: array[8] of Text[30];
        PrintDetail: Boolean;
        AsOfDate: Date;
        RemainingQty: Decimal;
        d: Dialog;
        ExcelBuf: Record "Excel Buffer" temporary;
        RowNo: Integer;
        ColumnNo: Integer;
        ExportToExcel: Boolean;
        MainTitle: Text[100];
        SubTitle: Text[100];
        SubTitle2: Text[100];
        ">>020107": Integer;
        CurrInvtValue: Decimal;
        AgingOption: Option "Lot Creation Date","Posting Date";
        LotNoInfo: Record "Lot No. Information";
        BasisDate: Date;
        ShowACY: Boolean;
        UnitCostACY: Decimal;
        Text002: Label 'Sub Title 2';
        Text003: Label 'Sub Title';
        Text004: Label 'Main Title';
        Text005: Label 'Company Name';
        Text006: Label 'Report No.';
        Text007: Label 'Report Name';
        Text008: Label 'User ID';
        Text009: Label 'Date';
        Text011: Label 'Item Filters';
        Text012: Label 'Item Age Composition-Value NIF';
        Text013: Label 'All Inventory Values are shown in USD';
        Text014: Label 'Days';
        Text015: Label 'Location Code';
        Text016: Label 'Item No.';
        Text017: Label 'Description';
        Text018: Label 'Posting Date';
        Text019: Label 'Lot No.';
        Text020: Label 'After ';
        Text021: Label 'Before ';
        Text022: Label 'Inventory Value';
        Text023: Label 'Total';
        ExcelItemWiseTotalInvtValue12: Decimal;
        ExcelItemWiseTotalInvtValue3: Decimal;
        ExcelItemWiseTotalInvtValue4: Decimal;
        ExcelItemWiseTotalInvtValue5: Decimal;
        ExcelItemWiseTotalInvtValue6: Decimal;
        ExcelItemWiseTotalInvtValue7: Decimal;
        ExcelItemWiseTotalInvtValueTotal: Decimal;
        ExcelGrandTotalInvtValue12: Decimal;
        ExcelGrandTotalInvtValue3: Decimal;
        ExcelGrandTotalInvtValue4: Decimal;
        ExcelGrandTotalInvtValue5: Decimal;
        ExcelGrandTotalInvtValue6: Decimal;
        ExcelGrandTotalInvtValue7: Decimal;
        ExcelGrandTotalInvtValueTotal: Decimal;
        DecimalPlacesFormat: Decimal;
        GLSetup: Record "General Ledger Setup";

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
        CurrExchRate: Record "Currency Exchange Rate";
        PostingDate: Date;
        LotNoInfo: Record "Lot No. Information";
    begin
        WITH ItemLedgEntry DO BEGIN
            // adjust remaining quantity
            "Remaining Quantity" := Quantity;
            IF Positive THEN BEGIN
                ItemApplnEntry.RESET;
                ItemApplnEntry.SETCURRENTKEY(
                  "Inbound Item Entry No.", "Cost Application", "Outbound Item Entry No.");
                ItemApplnEntry.SETRANGE("Inbound Item Entry No.", "Entry No.");
                ItemApplnEntry.SETRANGE("Posting Date", 0D, AsOfDate);
                ItemApplnEntry.SETFILTER("Outbound Item Entry No.", '<>%1', 0);
                ItemApplnEntry.SETFILTER("Item Ledger Entry No.", '<>%1', "Entry No.");
                IF ItemApplnEntry.FIND('-') THEN
                    REPEAT
                        IF ItemLedgEntry2.GET(ItemApplnEntry."Item Ledger Entry No.") AND
                           (ItemLedgEntry2."Posting Date" <= AsOfDate)
                        THEN
                            "Remaining Quantity" := "Remaining Quantity" + ItemApplnEntry.Quantity;
                    UNTIL ItemApplnEntry.NEXT = 0;
            END ELSE BEGIN
                ItemApplnEntry.RESET;
                ItemApplnEntry.SETCURRENTKEY("Item Ledger Entry No.", "Outbound Item Entry No.", "Cost Application");
                ItemApplnEntry.SETRANGE("Item Ledger Entry No.", "Entry No.");
                ItemApplnEntry.SETRANGE("Outbound Item Entry No.", "Entry No.");
                ItemApplnEntry.SETRANGE("Posting Date", 0D, AsOfDate);
                IF ItemApplnEntry.FIND('-') THEN
                    REPEAT
                        IF ItemLedgEntry2.GET(ItemApplnEntry."Inbound Item Entry No.") AND
                           (ItemLedgEntry2."Posting Date" <= AsOfDate)
                        THEN
                            "Remaining Quantity" := "Remaining Quantity" - ItemApplnEntry.Quantity;
                    UNTIL ItemApplnEntry.NEXT = 0;
            END;

            // calculate adjusted cost of entry
            ValueEntry.RESET;
            ValueEntry.SETCURRENTKEY(
              "Item Ledger Entry No.", "Expected Cost", "Document No.", "Partial Revaluation", "Entry Type", "Variance Type");
            ValueEntry.SETRANGE("Item Ledger Entry No.", "Entry No.");
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

            //>>CIS.RAM
            IF (ShowACY) AND
               (("Document Type" IN ["Document Type"::"Purchase Receipt"]) OR
               ("Entry Type" = "Entry Type"::Transfer))
               AND
               (GLSetup."Additional Reporting Currency" <> '')
            THEN BEGIN
                PostingDate := 0D;
                LotNoInfo.RESET;
                IF "Lot No." <> '' THEN
                    //Item No.,Variant Code,Lot No.
                    IF LotNoInfo.GET("Item No.", "Variant Code", "Lot No.") THEN
                        PostingDate := LotNoInfo."Lot Creation Date";
                IF PostingDate = 0D THEN
                    PostingDate := "Posting Date";
                //MESSAGE('BEFORE: %1\%2\%3',InvoicedValue,InvoicedValueACY,"Posting Date");
                //InvoicedValueACY := CurrExchRate.ExchangeAmtLCYToFCY("Posting Date",GLSetup."Additional Reporting Currency",InvoicedValue,1);
                InvoicedValueACY := CurrExchRate.ExchangeAmount(InvoicedValue, GLSetup."LCY Code", GLSetup."Additional Reporting Currency", PostingDate);
                //MESSAGE('AFTER: %1\%2\%3',InvoicedValue,InvoicedValueACY,"Posting Date");
            END;
            //<<CIS.RAM

            //>>NIF 020107
            IF ValuedQty <> 0 THEN BEGIN
                UnitCost := (InvoicedValue + ExpectedValue) / ValuedQty;
                UnitCostACY := (InvoicedValueACY + ExpectedValueACY) / ValuedQty;
            END ELSE BEGIN
                UnitCost := 0;
                UnitCostACY := 0;
            END;
            //<<NIF 020107
            "Cost Amount (Actual)" := ROUND(InvoicedValue + ExpectedValue);
            //x"Cost Amount (Actual) (ACY)" := ROUND(InvoicedValueACY + ExpectedValueACY,Currency."Amount Rounding Precision");
        END;
    end;

    procedure CalcValueBucket()
    begin
        WITH "Item Ledger Entry" DO BEGIN
            FOR i := 1 TO 7 DO BEGIN
                InvtQty[i] := 0;
                InvtValue[i] := 0;
            END;

            TotalInvtQty := "Remaining Quantity";

            //>>NIF 060807 RTT
            /*
            FOR i := 1 TO 7 DO
              IF ("Posting Date" <= PeriodStartDate[i]) AND
                ("Posting Date" > (PeriodStartDate[i + 1]))
                THEN BEGIN

                    IF ShowACY THEN
                    InvtValue[i] := UnitCostACY * TotalInvtQty

                    ELSE
                    InvtValue[i] := UnitCost * TotalInvtQty;





                    EXIT;
                  END;
            */
            BasisDate := "Posting Date";
            IF AgingOption = AgingOption::"Lot Creation Date" THEN
                IF LotNoInfo.GET("Item No.", '', "Lot No.") THEN
                    IF LotNoInfo."Lot Creation Date" <> 0D THEN
                        BasisDate := LotNoInfo."Lot Creation Date";

            FOR i := 1 TO 7 DO
                IF (BasisDate <= PeriodStartDate[i]) AND
                  (BasisDate > (PeriodStartDate[i + 1]))
                  THEN BEGIN

                    IF ShowACY THEN
                        InvtValue[i] := UnitCostACY * TotalInvtQty

                    ELSE
                        InvtValue[i] := UnitCost * TotalInvtQty;






                    EXIT;
                END;

            //<<NIF 060807 RTT


        END;

    end;

    local procedure MakeExcelInfo()
    begin
        //>> NF1.00:CIS.SP 09-15-15
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(FORMAT(Text005), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(COMPANYNAME, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text006), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(REPORT::"Item Age Composition-Value NIF", FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
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
        ExcelBuf.AddInfoColumn(FORMAT(Text011), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(COPYSTR(Item.GETFILTERS, 1, 250), FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        IF ShowACY THEN BEGIN
            ExcelBuf.NewRow;
            ExcelBuf.AddInfoColumn(FORMAT(Text013), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        END;
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
        //<< NF1.00:CIS.SP 09-15-15
    end;

    local procedure MakeExcelDataHeader()
    begin
        //>> NF1.00:CIS.SP 09-15-15
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
        ExcelBuf.AddColumn(FORMAT(PeriodStartDate[4] + 1), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(PeriodStartDate[5] + 1), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(PeriodStartDate[6] + 1), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(PeriodStartDate[7] + 1), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Text016, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Text017, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        IF PrintDetail THEN BEGIN
            ExcelBuf.AddColumn(Text018, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(Text015, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(Text019, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        END;
        ExcelBuf.AddColumn(Text020 + FORMAT(PeriodStartDate[3] + 1), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(PeriodStartDate[3]), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(PeriodStartDate[4]), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(PeriodStartDate[5]), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(PeriodStartDate[6]), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Text021 + FORMAT(PeriodStartDate[7] + 1), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Text022, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Expected Cost', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Actual Cost', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        //<< NF1.00:CIS.SP 09-15-15
    end;

    local procedure MakeExcelDataBody()
    begin
        //>> NF1.00:CIS.SP 09-15-15
        ExcelGrandTotalInvtValue12 += ExcelItemWiseTotalInvtValue12;
        ExcelGrandTotalInvtValue3 += ExcelItemWiseTotalInvtValue3;
        ExcelGrandTotalInvtValue4 += ExcelItemWiseTotalInvtValue4;
        ExcelGrandTotalInvtValue5 += ExcelItemWiseTotalInvtValue5;
        ExcelGrandTotalInvtValue6 += ExcelItemWiseTotalInvtValue6;
        ExcelGrandTotalInvtValue7 += ExcelItemWiseTotalInvtValue7;
        ExcelGrandTotalInvtValueTotal += ExcelItemWiseTotalInvtValueTotal;

        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Item."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Item.Description, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        IF ExcelItemWiseTotalInvtValue12 <> 0 THEN
            ExcelBuf.AddColumn(ExcelItemWiseTotalInvtValue12, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number)
        ELSE
            ExcelBuf.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        IF ExcelItemWiseTotalInvtValue3 <> 0 THEN
            ExcelBuf.AddColumn(ExcelItemWiseTotalInvtValue3, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number)
        ELSE
            ExcelBuf.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        IF ExcelItemWiseTotalInvtValue4 <> 0 THEN
            ExcelBuf.AddColumn(ExcelItemWiseTotalInvtValue4, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number)
        ELSE
            ExcelBuf.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        IF ExcelItemWiseTotalInvtValue5 <> 0 THEN
            ExcelBuf.AddColumn(ExcelItemWiseTotalInvtValue5, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number)
        ELSE
            ExcelBuf.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        IF ExcelItemWiseTotalInvtValue6 <> 0 THEN
            ExcelBuf.AddColumn(ExcelItemWiseTotalInvtValue6, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number)
        ELSE
            ExcelBuf.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        IF ExcelItemWiseTotalInvtValue7 <> 0 THEN
            ExcelBuf.AddColumn(ExcelItemWiseTotalInvtValue7, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number)
        ELSE
            ExcelBuf.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        IF ExcelItemWiseTotalInvtValueTotal <> 0 THEN
            ExcelBuf.AddColumn(ExcelItemWiseTotalInvtValueTotal, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number)
        ELSE
            ExcelBuf.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        //<< NF1.00:CIS.SP 09-15-15

        //IF ExcelItemWiseTotalInvtValueTotal <> 0 THEN
        //ELSE
        // ExcelBuf.AddColumn(0,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
    end;

    local procedure MakeExcelDataBodyPrintDetails()
    begin
        //>> NF1.00:CIS.SP 09-15-15
        ExcelGrandTotalInvtValue12 += InvtValue[1] + InvtValue[2];
        ExcelGrandTotalInvtValue3 += InvtValue[3];
        ExcelGrandTotalInvtValue4 += InvtValue[4];
        ExcelGrandTotalInvtValue5 += InvtValue[5];
        ExcelGrandTotalInvtValue6 += InvtValue[6];
        ExcelGrandTotalInvtValue7 += InvtValue[7];
        ExcelGrandTotalInvtValueTotal += TotalInvtValue;

        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Item."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Item.Description, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Item Ledger Entry"."Posting Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddColumn("Item Ledger Entry"."Location Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Item Ledger Entry"."Lot No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        IF (InvtValue[1] + InvtValue[2] <> 0) THEN
            ExcelBuf.AddColumn(InvtValue[1] + InvtValue[2], FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number)
        ELSE
            ExcelBuf.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        IF (InvtValue[3] <> 0) THEN
            ExcelBuf.AddColumn(InvtValue[3], FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number)
        ELSE
            ExcelBuf.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        IF (InvtValue[4] <> 0) THEN
            ExcelBuf.AddColumn(InvtValue[4], FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number)
        ELSE
            ExcelBuf.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        IF (InvtValue[5] <> 0) THEN
            ExcelBuf.AddColumn(InvtValue[5], FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number)
        ELSE
            ExcelBuf.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        IF (InvtValue[6] <> 0) THEN
            ExcelBuf.AddColumn(InvtValue[6], FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number)
        ELSE
            ExcelBuf.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        IF (InvtValue[7] <> 0) THEN
            ExcelBuf.AddColumn(InvtValue[7], FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number)
        ELSE
            ExcelBuf.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        IF (TotalInvtValue <> 0) THEN
            ExcelBuf.AddColumn(TotalInvtValue, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number)
        ELSE
            ExcelBuf.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn("Item Ledger Entry"."Cost Amount (Expected) (ACY)", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn("Item Ledger Entry"."Cost Amount (Actual) (ACY)", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);

        //<< NF1.00:CIS.SP 09-15-15
    end;

    local procedure MakeExcelDataFooterGrandTotals()
    begin
        //>> NF1.00:CIS.SP 09-15-15
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        IF PrintDetail THEN BEGIN
            ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        END;
        ExcelBuf.AddColumn(Text023, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ExcelGrandTotalInvtValue12, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(ExcelGrandTotalInvtValue3, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(ExcelGrandTotalInvtValue4, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(ExcelGrandTotalInvtValue5, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(ExcelGrandTotalInvtValue6, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(ExcelGrandTotalInvtValue7, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(ExcelGrandTotalInvtValueTotal, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        //<< NF1.00:CIS.SP 09-15-15
    end;

    local procedure CreateExcelbook()
    begin
        //>> NF1.00:CIS.SP 09-15-15
        //ExcelBuf.CreateBookAndOpenExcel(MainTitle, MainTitle, COMPANYNAME, USERID); BC Upgrade
        ExcelBuf.CreateNewBook(MainTitle);
        ExcelBuf.WriteSheet(MainTitle, COMPANYNAME, USERID);
        ExcelBuf.CloseBook();
        ExcelBuf.OpenExcel();
        ERROR('');
        //<< NF1.00:CIS.SP 09-15-15
    end;

    local procedure ClearExcelTotalInvtVariables()
    begin
        //>> NF1.00:CIS.SP 09-15-15
        ExcelItemWiseTotalInvtValue12 := 0;
        ExcelItemWiseTotalInvtValue3 := 0;
        ExcelItemWiseTotalInvtValue4 := 0;
        ExcelItemWiseTotalInvtValue5 := 0;
        ExcelItemWiseTotalInvtValue6 := 0;
        ExcelItemWiseTotalInvtValue7 := 0;
        ExcelItemWiseTotalInvtValueTotal := 0;
        //<< NF1.00:CIS.SP 09-15-15
    end;
}

