report 50087 "Item Age Composition - Qty NIF"
{
    // NF1.00:CIS.SP  09-15-15 Merged during upgrade
    // NF1.00:CIS.NG  08-03-16 Adjust the Margin in Report from Left & Right
    // >>NF1
    // Export To Excel as per requirement
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
    DefaultLayout = RDLC;
    RDLCLayout = './Item Age Composition - Qty NIF.rdlc';

    Caption = 'Item Age Composition - Qty NIF';

    dataset
    {
        dataitem(DataItem8129;Table27)
        {
            DataItemTableView = SORTING(No.)
                                WHERE(Type=CONST(Inventory));
            RequestFilterFields = "No.","Inventory Posting Group","Statistics Group","Location Filter";
            column(Item_No;Item."No.")
            {
            }
            column(Item_Description;Item.Description)
            {
            }
            column(CompanyName;CompanyInformation.Name)
            {
            }
            column(AsOfDate;'As of ' + FORMAT(AsOfDate))
            {
            }
            column(AgingOption;'Aged by ' + FORMAT(AgingOption))
            {
            }
            column(ItemTableCaptItemFilter;TABLECAPTION + ': ' + ItemFilter)
            {
            }
            column(ItemFilter;ItemFilter)
            {
            }
            column(DaysText1;FORMAT(DaysText[1]))
            {
            }
            column(DaysText2;FORMAT(DaysText[2]))
            {
            }
            column(DaysText3;FORMAT(DaysText[3]))
            {
            }
            column(DaysText4;FORMAT(DaysText[4]))
            {
            }
            column(DaysText5;FORMAT(DaysText[5]))
            {
            }
            column(DaysText6;FORMAT(DaysText[6]))
            {
            }
            column(AfterPeriodStartDate31;'After ' + FORMAT(PeriodStartDate[3]+1))
            {
            }
            column(PeriodStartDate41;FORMAT(PeriodStartDate[4] + 1))
            {
            }
            column(PeriodStartDate3;FORMAT(PeriodStartDate[3]))
            {
            }
            column(PeriodStartDate4;FORMAT(PeriodStartDate[4]))
            {
            }
            column(PeriodStartDate5;FORMAT(PeriodStartDate[5]))
            {
            }
            column(PeriodStartDate6;FORMAT(PeriodStartDate[6]))
            {
            }
            column(PeriodStartDate51;FORMAT(PeriodStartDate[5] + 1))
            {
            }
            column(PeriodStartDate61;FORMAT(PeriodStartDate[6] + 1))
            {
            }
            column(PeriodStartDate71;FORMAT(PeriodStartDate[7] + 1))
            {
            }
            column(BeforePeriodStartDate71;'Before ' + FORMAT(PeriodStartDate[7]+1))
            {
            }
            column(PrintDetail;PrintDetail)
            {
            }
            column(DecimalPlacesFormat;DecimalPlacesFormat)
            {
                DecimalPlaces = 0:2;
            }
            dataitem(DataItem1102622000;Table32)
            {
                DataItemLink = Item No.=FIELD(No.),
                               Location Code=FIELD(Location Filter),
                               Variant Code=FIELD(Variant Filter),
                               Global Dimension 1 Code=FIELD(Global Dimension 1 Filter),
                               Global Dimension 2 Code=FIELD(Global Dimension 2 Filter);
                DataItemTableView = SORTING(Item No.,Variant Code,Open,Positive,Location Code,Posting Date);
                column(ItemLedgEntryPostingDate;FORMAT("Item Ledger Entry"."Posting Date"))
                {
                }
                column(ItemLedgEntryLocationCode;"Item Ledger Entry"."Location Code")
                {
                }
                column(ItemLedgEntryLotNo;"Item Ledger Entry"."Lot No.")
                {
                }
                column(InvtQty12_ItemLedgerEntry;InvtQty[1]+InvtQty[2])
                {
                    DecimalPlaces = 0:2;
                }
                column(InvtQty3_ItemLedgerEntry;InvtQty[3])
                {
                    AutoFormatType = 1;
                    DecimalPlaces = 0:2;
                }
                column(InvtQty4_ItemLedgerEntry;InvtQty[4])
                {
                    AutoFormatType = 1;
                    DecimalPlaces = 0:2;
                }
                column(InvtQty5_ItemLedgerEntry;InvtQty[5])
                {
                    AutoFormatType = 1;
                    DecimalPlaces = 0:2;
                }
                column(InvtQty6_ItemLedgerEntry;InvtQty[6])
                {
                    AutoFormatType = 1;
                    DecimalPlaces = 0:2;
                }
                column(InvtQty7_ItemLedgerEntry;InvtQty[7])
                {
                    AutoFormatType = 1;
                    DecimalPlaces = 0:2;
                }
                column(TotalInvtQty_ItemLedgerEntry;TotalInvtQty)
                {
                    AutoFormatType = 1;
                    DecimalPlaces = 0:2;
                }
                column(PrintLine;PrintLine)
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
                    
                    FOR i := 1 TO 7 DO
                      InvtQty[i] := 0;
                    
                    TotalInvtQty := "Remaining Quantity";
                    //>>NIF 060807 RTT
                    /*
                    FOR i := 1 TO 7 DO
                      IF ("Posting Date" <= PeriodStartDate[i]) AND
                        ("Posting Date" > (PeriodStartDate[i + 1]))
                      THEN
                        InvtQty[i] := "Remaining Quantity";
                    */
                    BasisDate := "Posting Date";
                    IF AgingOption = AgingOption::"Lot Creation Date" THEN
                      IF LotNoInfo.GET("Item No.",'',"Lot No.") THEN
                        IF LotNoInfo."Lot Creation Date"<>0D THEN
                          BasisDate := LotNoInfo."Lot Creation Date";
                    
                    FOR i := 1 TO 7 DO
                      IF (BasisDate <= PeriodStartDate[i]) AND
                        (BasisDate > (PeriodStartDate[i + 1]))
                      THEN
                        InvtQty[i] := "Remaining Quantity";
                    //<<NIF 060807 RTT
                    
                    //>> NF1.00:CIS.SP 09-15-15
                    PrintLine := TRUE;
                    
                    ExcelItemWiseTotalInvtQty12 += InvtQty[1]+InvtQty[2];
                    ExcelItemWiseTotalInvtQty3 += InvtQty[3];
                    ExcelItemWiseTotalInvtQty4 += InvtQty[4];
                    ExcelItemWiseTotalInvtQty5 += InvtQty[5];
                    ExcelItemWiseTotalInvtQty6 += InvtQty[6];
                    ExcelItemWiseTotalInvtQty7 += InvtQty[7];
                    ExcelItemWiseTotalInvtQtyTotal += TotalInvtQty;
                    
                    IF (ExportToExcel) AND (PrintDetail) THEN
                      MakeExcelDataBodyPrintDetails;
                    //<< NF1.00:CIS.SP 09-15-15

                end;

                trigger OnPreDataItem()
                begin
                    CurrReport.CREATETOTALS(TotalInvtQty,InvtQty);
                    //>> NIF 07-01-05 RTT
                    SETRANGE("Posting Date",0D,AsOfDate);
                    //<< NIF 07-01-05 RTT
                end;
            }
            dataitem(DataItem1102622059;Table2000000026)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number=CONST(1));
                column(TotalInvtQty_ItemLedgEntry;ExcelItemWiseTotalInvtQtyTotal)
                {
                    AutoFormatType = 1;
                    DecimalPlaces = 0:2;
                }
                column(InvtQty12__ItemLedgEntry;ExcelItemWiseTotalInvtQty12)
                {
                    DecimalPlaces = 0:2;
                }
                column(InvtQty7_ItemLedgEntry;ExcelItemWiseTotalInvtQty7)
                {
                    AutoFormatType = 1;
                    DecimalPlaces = 0:2;
                }
                column(InvtQty6_ItemLedgEntry;ExcelItemWiseTotalInvtQty6)
                {
                    AutoFormatType = 1;
                    DecimalPlaces = 0:2;
                }
                column(InvtQty5_ItemLedgEntry;ExcelItemWiseTotalInvtQty5)
                {
                    AutoFormatType = 1;
                    DecimalPlaces = 0:2;
                }
                column(InvtQty4_ItemLedgEntry;ExcelItemWiseTotalInvtQty4)
                {
                    AutoFormatType = 1;
                    DecimalPlaces = 0:2;
                }
                column(InvtQty3_ItemLedgEntry;ExcelItemWiseTotalInvtQty3)
                {
                    AutoFormatType = 1;
                    DecimalPlaces = 0:2;
                }

                trigger OnAfterGetRecord()
                begin
                    //>> NF1.00:CIS.SP 09-15-15
                    IF (ExportToExcel) AND (Item."No." <> '') AND (NOT PrintDetail) AND
                       ((ExcelItemWiseTotalInvtQty12 <> 0) OR (ExcelItemWiseTotalInvtQty3 <> 0) OR (ExcelItemWiseTotalInvtQty4 <> 0) OR
                       (ExcelItemWiseTotalInvtQty5 <> 0) OR (ExcelItemWiseTotalInvtQty6 <> 0) OR (ExcelItemWiseTotalInvtQty7 <> 0) OR
                       (ExcelItemWiseTotalInvtQtyTotal <> 0))THEN
                      MakeExcelDataBody;
                    //<< NF1.00:CIS.SP 09-15-15
                end;
            }

            trigger OnAfterGetRecord()
            var
                ItemLedgEntry: Record "32";
            begin
                PrintLine  := FALSE;
                //>> NIF 07-01-05 RTT
                d.UPDATE(1,"No.");
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
                CurrReport.CREATETOTALS(TotalInvtQty,InvtQty);
                //>> NIF 07-01-05 RTT
                d.OPEN('Reading Item #1##################');
                //<< NIF 07-01-05 RTT
            end;
        }
        dataitem(PageBreak;Table2000000026)
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number=CONST(1));
            column(ValuesExist;ValuesExist)
            {
            }

            trigger OnAfterGetRecord()
            begin
                ValuesExist := ((InvtQty[1]<>0) OR (InvtQty[2]<>0) OR (InvtQty[3]<>0) OR (InvtQty[4]<>0) OR
                                       (InvtQty[5]<>0) OR (InvtQty[6]<>0) OR (InvtQty[7]<>0) OR (TotalInvtQty<>0));
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
                    field("As of Date";PeriodStartDate[2])
                    {
                        Caption = 'As of Date';
                    }
                    field("Period Length[1]";PeriodLength[1])
                    {
                        Caption = 'Period Length[1]';

                        trigger OnValidate()
                        begin
                            IF FORMAT(PeriodLength[1]) = '' THEN
                              EVALUATE(PeriodLength[1],'<60D>');
                        end;
                    }
                    field("Period Length[2]";PeriodLength[2])
                    {
                        Caption = 'Period Length[2]';

                        trigger OnValidate()
                        begin
                            IF FORMAT(PeriodLength[2]) = '' THEN
                              EVALUATE(PeriodLength[2],'<60D>');
                        end;
                    }
                    field("Period Length[3]";PeriodLength[3])
                    {
                        Caption = 'Period Length[3]';

                        trigger OnValidate()
                        begin
                            IF FORMAT(PeriodLength[3]) = '' THEN
                              EVALUATE(PeriodLength[3],'<60D>');
                        end;
                    }
                    field("Period Length[4]";PeriodLength[4])
                    {
                        Caption = 'Period Length[4]';

                        trigger OnValidate()
                        begin
                            IF FORMAT(PeriodLength[4]) = '' THEN
                              EVALUATE(PeriodLength[4],'<90D>');
                        end;
                    }
                    field("Period Length[5]";PeriodLength[5])
                    {
                        Caption = 'Period Length[5]';

                        trigger OnValidate()
                        begin
                            IF FORMAT(PeriodLength[5]) = '' THEN
                              EVALUATE(PeriodLength[5],'<90D>');
                        end;
                    }
                    field("Print Detail";PrintDetail)
                    {
                        Caption = 'Print Detail';
                    }
                    field("Export to Excel";ExportToExcel)
                    {
                        Caption = 'Export to Excel';
                    }
                    field("Aged by:";AgingOption)
                    {
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
              EVALUATE(PeriodLength[1],'<60D>');
            IF FORMAT(PeriodLength[2]) = '' THEN
              EVALUATE(PeriodLength[2],'<60D>');
            IF FORMAT(PeriodLength[3]) = '' THEN
              EVALUATE(PeriodLength[3],'<60D>');
            IF FORMAT(PeriodLength[4]) = '' THEN
              EVALUATE(PeriodLength[4],'<90D>');
            IF FORMAT(PeriodLength[5]) = '' THEN
              EVALUATE(PeriodLength[5],'<90D>');
            //<< NIF
        end;
    }

    labels
    {
        ItemAgeCompositionCaption = 'Item Age Composition - Qty NIF';
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

        //>> NIF
        //PeriodStartDate[6] := 12319999D;
        //FOR i := 1 TO 3 DO
        //  PeriodStartDate[5 - i] := CALCDATE('-' + FORMAT(PeriodLength),PeriodStartDate[6 - i]);
        PeriodStartDate[8] := 12311899D;
        PeriodStartDate[1] := 12319999D;
        IF PeriodStartDate[2] = 0D THEN
          ERROR('You must enter an As of Date.');
        FOR i := 2 TO 6 DO
          PeriodStartDate[i+1] := CALCDATE('-'+FORMAT(PeriodLength[i-1]),PeriodStartDate[i]);

        DaysText[1] := '0-'+ FORMAT(PeriodStartDate[3]-PeriodStartDate[2]);
        FOR i := 2 TO 5 DO
          DaysText[i] := FORMAT(PeriodStartDate[2]-PeriodStartDate[i+1]+1) + '-' +
                         FORMAT(PeriodStartDate[2]-PeriodStartDate[i+2]);
        DaysText[6] := '> ' + FORMAT(PeriodStartDate[2]-PeriodStartDate[7]);

        //<< NIF
        //>> NIF 07-01-05 RTT
        AsOfDate := PeriodStartDate[2];
        //<< NIF 07-01-05 RTT
        CompanyInformation.GET;

        //>> NIF RTT 11-02-05
        IF ExportToExcel THEN BEGIN
         ExcelBuf.DELETEALL;
         MainTitle := 'Item Aging Composition';
         SubTitle := 'by Quantity';
         IF PrintDetail THEN
           SubTitle2 := 'Detail'
         ELSE
           SubTitle2 := 'Summary';
         SubTitle2 := SubTitle2 + ' as of ' + FORMAT(AsOfDate);

          MakeExcelInfo; //NF1.00:CIS.SP 09-15-15
        END;
        //<< NIF RTT 11-02-05

        //>> NF1.00:CIS.SP 09-15-15
        ExcelGrandTotalInvtQty12 := 0;
        ExcelGrandTotalInvtQty3 := 0;
        ExcelGrandTotalInvtQty4 := 0;
        ExcelGrandTotalInvtQty5 := 0;
        ExcelGrandTotalInvtQty6 := 0;
        ExcelGrandTotalInvtQty7 := 0;
        ExcelGrandTotalInvtQtyTotal := 0;
        //<< NF1.00:CIS.SP 09-15-15
    end;

    var
        CompanyInformation: Record "79";
        ItemFilter: Text;
        InvtQty: array [8] of Decimal;
        PeriodStartDate: array [9] of Date;
        PeriodLength: array [8] of DateFormula;
        i: Integer;
        TotalInvtQty: Decimal;
        PrintLine: Boolean;
        ">>NIF_GV": Integer;
        DaysText: array [8] of Text[30];
        PrintDetail: Boolean;
        AsOfDate: Date;
        RemainingQty: Decimal;
        d: Dialog;
        ItemCostMgt: Codeunit "5804";
        ExcelBuf: Record "370" temporary;
        RowNo: Integer;
        ColumnNo: Integer;
        ExportToExcel: Boolean;
        MainTitle: Text[100];
        SubTitle: Text[100];
        SubTitle2: Text[100];
        AgingOption: Option "Lot Creation Date","Posting Date";
        LotNoInfo: Record "6505";
        BasisDate: Date;
        ExcelItemWiseTotalInvtQty12: Decimal;
        ExcelItemWiseTotalInvtQty3: Decimal;
        ExcelItemWiseTotalInvtQty4: Decimal;
        ExcelItemWiseTotalInvtQty5: Decimal;
        ExcelItemWiseTotalInvtQty6: Decimal;
        ExcelItemWiseTotalInvtQty7: Decimal;
        ExcelItemWiseTotalInvtQtyTotal: Decimal;
        ExcelGrandTotalInvtQty12: Decimal;
        ExcelGrandTotalInvtQty3: Decimal;
        ExcelGrandTotalInvtQty4: Decimal;
        ExcelGrandTotalInvtQty5: Decimal;
        ExcelGrandTotalInvtQty6: Decimal;
        ExcelGrandTotalInvtQty7: Decimal;
        ExcelGrandTotalInvtQtyTotal: Decimal;
        DecimalPlacesFormat: Decimal;
        Text002: Label 'Sub Title 2';
        Text003: Label 'Sub Title';
        Text004: Label 'Main Title';
        Text005: Label 'Company Name';
        Text006: Label 'Report No.';
        Text007: Label 'Report Name';
        Text008: Label 'User ID';
        Text009: Label 'Date';
        Text011: Label 'Item Filters';
        Text012: Label 'Item Age Composition - Qty NIF';
        Text014: Label 'Days';
        Text015: Label 'Location Code';
        Text016: Label 'Item No.';
        Text017: Label 'Description';
        Text018: Label 'Posting Date';
        Text019: Label 'Lot No.';
        Text020: Label 'After ';
        Text021: Label 'Before ';
        Text022: Label 'Inventory Qty';
        Text023: Label 'Total';
        ValuesExist: Boolean;

    procedure ">>NIF_fcn"()
    begin
    end;

    local procedure AdjustItemLedgEntryToAsOfDate(var ItemLedgEntry: Record "32")
    var
        ItemApplnEntry: Record "339";
        ValueEntry: Record "5802";
        ItemLedgEntry2: Record "32";
        InvoicedValue: Decimal;
        InvoicedValueACY: Decimal;
        InvoicedQty: Decimal;
        ExpectedValue: Decimal;
        ExpectedValueACY: Decimal;
        ValuedQty: Decimal;
    begin
        WITH ItemLedgEntry DO BEGIN
          // adjust remaining quantity
          "Remaining Quantity" := Quantity;
          IF Positive THEN BEGIN
            ItemApplnEntry.RESET;
            ItemApplnEntry.SETCURRENTKEY(
              "Inbound Item Entry No.","Cost Application","Outbound Item Entry No.");
            ItemApplnEntry.SETRANGE("Inbound Item Entry No.","Entry No.");
            ItemApplnEntry.SETRANGE("Posting Date",0D,AsOfDate);
            ItemApplnEntry.SETFILTER("Outbound Item Entry No.",'<>%1',0);
            ItemApplnEntry.SETFILTER("Item Ledger Entry No.",'<>%1',"Entry No.");
            IF ItemApplnEntry.FIND('-') THEN
              REPEAT
                IF ItemLedgEntry2.GET(ItemApplnEntry."Item Ledger Entry No.") AND
                   (ItemLedgEntry2."Posting Date" <= AsOfDate)
                THEN
                  "Remaining Quantity" := "Remaining Quantity" + ItemApplnEntry.Quantity;
              UNTIL ItemApplnEntry.NEXT = 0;
          END ELSE BEGIN
            ItemApplnEntry.RESET;
            ItemApplnEntry.SETCURRENTKEY("Item Ledger Entry No.","Outbound Item Entry No.","Cost Application");
            ItemApplnEntry.SETRANGE("Item Ledger Entry No.","Entry No.");
            ItemApplnEntry.SETRANGE("Outbound Item Entry No.","Entry No.");
            ItemApplnEntry.SETRANGE("Posting Date",0D,AsOfDate);
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
            "Item Ledger Entry No.","Expected Cost","Document No.","Partial Revaluation","Entry Type","Variance Type");
          ValueEntry.SETRANGE("Item Ledger Entry No.","Entry No.");
          ValueEntry.SETRANGE("Posting Date",0D,AsOfDate);
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
          "Cost Amount (Actual)" := ROUND(InvoicedValue + ExpectedValue);
          //x"Cost Amount (Actual) (ACY)" := ROUND(InvoicedValueACY + ExpectedValueACY,Currency."Amount Rounding Precision");
        END;
    end;

    local procedure MakeExcelInfo()
    begin
        //>> NF1.00:CIS.SP 09-15-15
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(FORMAT(Text005),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(CompanyInformation.Name,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text006),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(REPORT::"Item Age Composition - Qty NIF",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text007),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FORMAT(Text012),FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text008),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(USERID,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text009),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(TODAY,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text004),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(MainTitle,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text003),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(SubTitle,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text002),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(SubTitle2,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text011),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(COPYSTR(Item.GETFILTERS,1,250),FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
        //<< NF1.00:CIS.SP 09-15-15
    end;

    local procedure MakeExcelDataHeader()
    begin
        //>> NF1.00:CIS.SP 09-15-15
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        IF PrintDetail THEN BEGIN
          ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        END;
        ExcelBuf.AddColumn(Text014,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(DaysText[1],FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(DaysText[2],FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(DaysText[3],FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(DaysText[4],FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(DaysText[5],FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(DaysText[6],FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);

        ExcelBuf.NewRow;
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        IF PrintDetail THEN BEGIN
          ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        END;
        ExcelBuf.AddColumn(FORMAT(PeriodStartDate[4] +1),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(PeriodStartDate[5] +1),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(PeriodStartDate[6] +1),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(PeriodStartDate[7] +1),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);

        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Text016,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Text017,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        IF PrintDetail THEN BEGIN
          ExcelBuf.AddColumn(Text018,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          ExcelBuf.AddColumn(Text015,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          ExcelBuf.AddColumn(Text019,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        END;
        ExcelBuf.AddColumn(Text020 + FORMAT(PeriodStartDate[3]+1),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(PeriodStartDate[3]),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(PeriodStartDate[4]),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(PeriodStartDate[5]),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(PeriodStartDate[6]),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Text021 + FORMAT(PeriodStartDate[7]+1),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Text022,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //<< NF1.00:CIS.SP 09-15-15
    end;

    local procedure MakeExcelDataBody()
    begin
        //>> NF1.00:CIS.SP 09-15-15
        ExcelGrandTotalInvtQty12 += ExcelItemWiseTotalInvtQty12;
        ExcelGrandTotalInvtQty3 += ExcelItemWiseTotalInvtQty3;
        ExcelGrandTotalInvtQty4 += ExcelItemWiseTotalInvtQty4;
        ExcelGrandTotalInvtQty5 += ExcelItemWiseTotalInvtQty5;
        ExcelGrandTotalInvtQty6 += ExcelItemWiseTotalInvtQty6;
        ExcelGrandTotalInvtQty7 += ExcelItemWiseTotalInvtQty7;
        ExcelGrandTotalInvtQtyTotal += ExcelItemWiseTotalInvtQtyTotal;

        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Item."No.",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Item.Description,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        IF STRPOS(FORMAT(ExcelItemWiseTotalInvtQty12),'.') = 0 THEN
          ExcelBuf.AddColumn(ExcelItemWiseTotalInvtQty12,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number)
        ELSE
          ExcelBuf.AddColumn(ExcelItemWiseTotalInvtQty12,FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);

        IF STRPOS(FORMAT(ExcelItemWiseTotalInvtQty3),'.') = 0 THEN
          ExcelBuf.AddColumn(ExcelItemWiseTotalInvtQty3,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number)
        ELSE
          ExcelBuf.AddColumn(ExcelItemWiseTotalInvtQty3,FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);

        IF STRPOS(FORMAT(ExcelItemWiseTotalInvtQty4),'.') = 0 THEN
          ExcelBuf.AddColumn(ExcelItemWiseTotalInvtQty4,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number)
        ELSE
          ExcelBuf.AddColumn(ExcelItemWiseTotalInvtQty4,FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);

        IF STRPOS(FORMAT(ExcelItemWiseTotalInvtQty5),'.') = 0 THEN
          ExcelBuf.AddColumn(ExcelItemWiseTotalInvtQty5,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number)
        ELSE
          ExcelBuf.AddColumn(ExcelItemWiseTotalInvtQty5,FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);

        IF STRPOS(FORMAT(ExcelItemWiseTotalInvtQty6),'.') = 0 THEN
          ExcelBuf.AddColumn(ExcelItemWiseTotalInvtQty6,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number)
        ELSE
          ExcelBuf.AddColumn(ExcelItemWiseTotalInvtQty6,FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);

        IF STRPOS(FORMAT(ExcelItemWiseTotalInvtQty7),'.') = 0 THEN
          ExcelBuf.AddColumn(ExcelItemWiseTotalInvtQty7,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number)
        ELSE
          ExcelBuf.AddColumn(ExcelItemWiseTotalInvtQty7,FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);

        IF STRPOS(FORMAT(ExcelItemWiseTotalInvtQtyTotal),'.') = 0 THEN
          ExcelBuf.AddColumn(ExcelItemWiseTotalInvtQtyTotal,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number)
        ELSE
          ExcelBuf.AddColumn(ExcelItemWiseTotalInvtQtyTotal,FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);
        //<< NF1.00:CIS.SP 09-15-15
    end;

    local procedure MakeExcelDataBodyPrintDetails()
    begin
        //>> NF1.00:CIS.SP 09-15-15
        ExcelGrandTotalInvtQty12 += InvtQty[1]+InvtQty[2];
        ExcelGrandTotalInvtQty3 += InvtQty[3];
        ExcelGrandTotalInvtQty4 += InvtQty[4];
        ExcelGrandTotalInvtQty5 += InvtQty[5];
        ExcelGrandTotalInvtQty6 += InvtQty[6];
        ExcelGrandTotalInvtQty7 += InvtQty[7];
        ExcelGrandTotalInvtQtyTotal += TotalInvtQty;

        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Item."No.",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Item.Description,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Item Ledger Entry"."Posting Date",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddColumn("Item Ledger Entry"."Location Code",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Item Ledger Entry"."Lot No.",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);

        IF STRPOS(FORMAT(InvtQty[1]+InvtQty[2]),'.') = 0 THEN
          ExcelBuf.AddColumn(InvtQty[1]+InvtQty[2],FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number)
        ELSE
          ExcelBuf.AddColumn(InvtQty[1]+InvtQty[2],FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);

        IF STRPOS(FORMAT(InvtQty[3]),'.') = 0 THEN
          ExcelBuf.AddColumn(InvtQty[3],FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number)
        ELSE
          ExcelBuf.AddColumn(InvtQty[3],FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);

        IF STRPOS(FORMAT(InvtQty[4]),'.') = 0 THEN
          ExcelBuf.AddColumn(InvtQty[4],FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number)
        ELSE
          ExcelBuf.AddColumn(InvtQty[4],FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);

        IF STRPOS(FORMAT(InvtQty[5]),'.') = 0 THEN
          ExcelBuf.AddColumn(InvtQty[5],FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number)
        ELSE
          ExcelBuf.AddColumn(InvtQty[5],FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);

        IF STRPOS(FORMAT(InvtQty[6]),'.') = 0 THEN
          ExcelBuf.AddColumn(InvtQty[6],FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number)
        ELSE
          ExcelBuf.AddColumn(InvtQty[6],FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);

        IF STRPOS(FORMAT(InvtQty[7]),'.') = 0 THEN
          ExcelBuf.AddColumn(InvtQty[7],FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number)
        ELSE
          ExcelBuf.AddColumn(InvtQty[7],FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);

        IF STRPOS(FORMAT(TotalInvtQty),'.') = 0 THEN
          ExcelBuf.AddColumn(TotalInvtQty,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number)
        ELSE
          ExcelBuf.AddColumn(TotalInvtQty,FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);
        //<< NF1.00:CIS.SP 09-15-15
    end;

    local procedure MakeExcelDataFooterGrandTotals()
    begin
        //>> NF1.00:CIS.SP 09-15-15
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        IF PrintDetail THEN BEGIN
          ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        END;
        ExcelBuf.AddColumn(Text023,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);

        IF STRPOS(FORMAT(ExcelGrandTotalInvtQty12),'.') = 0 THEN
          ExcelBuf.AddColumn(ExcelGrandTotalInvtQty12,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number)
        ELSE
          ExcelBuf.AddColumn(ExcelGrandTotalInvtQty12,FALSE,'',TRUE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);

        IF STRPOS(FORMAT(ExcelGrandTotalInvtQty3),'.') = 0 THEN
          ExcelBuf.AddColumn(ExcelGrandTotalInvtQty3,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number)
        ELSE
          ExcelBuf.AddColumn(ExcelGrandTotalInvtQty3,FALSE,'',TRUE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);

        IF STRPOS(FORMAT(ExcelGrandTotalInvtQty4),'.') = 0 THEN
          ExcelBuf.AddColumn(ExcelGrandTotalInvtQty4,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number)
        ELSE
          ExcelBuf.AddColumn(ExcelGrandTotalInvtQty4,FALSE,'',TRUE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);

        IF STRPOS(FORMAT(ExcelGrandTotalInvtQty5),'.') = 0 THEN
          ExcelBuf.AddColumn(ExcelGrandTotalInvtQty5,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number)
        ELSE
          ExcelBuf.AddColumn(ExcelGrandTotalInvtQty5,FALSE,'',TRUE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);

        IF STRPOS(FORMAT(ExcelGrandTotalInvtQty6),'.') = 0 THEN
          ExcelBuf.AddColumn(ExcelGrandTotalInvtQty6,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number)
        ELSE
          ExcelBuf.AddColumn(ExcelGrandTotalInvtQty6,FALSE,'',TRUE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);

        IF STRPOS(FORMAT(ExcelGrandTotalInvtQty7),'.') = 0 THEN
          ExcelBuf.AddColumn(ExcelGrandTotalInvtQty7,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number)
        ELSE
          ExcelBuf.AddColumn(ExcelGrandTotalInvtQty7,FALSE,'',TRUE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);

        IF STRPOS(FORMAT(ExcelGrandTotalInvtQtyTotal),'.') = 0 THEN
          ExcelBuf.AddColumn(ExcelGrandTotalInvtQtyTotal,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number)
        ELSE
          ExcelBuf.AddColumn(ExcelGrandTotalInvtQtyTotal,FALSE,'',TRUE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);
        //<< NF1.00:CIS.SP 09-15-15
    end;

    local procedure CreateExcelbook()
    begin
        //>> NF1.00:CIS.SP 09-15-15
        ExcelBuf.CreateBookAndOpenExcel(MainTitle,MainTitle,COMPANYNAME,USERID);
        ERROR('');
        //<< NF1.00:CIS.SP 09-15-15
    end;

    local procedure ClearExcelTotalInvtVariables()
    begin
        //>> NF1.00:CIS.SP 09-15-15
        ExcelItemWiseTotalInvtQty12 := 0;
        ExcelItemWiseTotalInvtQty3 := 0;
        ExcelItemWiseTotalInvtQty4 := 0;
        ExcelItemWiseTotalInvtQty5 := 0;
        ExcelItemWiseTotalInvtQty6 := 0;
        ExcelItemWiseTotalInvtQty7 := 0;
        ExcelItemWiseTotalInvtQtyTotal := 0;
        //<< NF1.00:CIS.SP 09-15-15
    end;
}

