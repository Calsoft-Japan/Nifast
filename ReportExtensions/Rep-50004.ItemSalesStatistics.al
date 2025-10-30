report 50004 "Item Sales Statistics New"
{
    // NF1.00:CIS.NU  08-18-15 Merged during upgrade
    DefaultLayout = RDLC;
    RDLCLayout = '.\RDLC\ItemSalesStatistics.rdl';

    Caption = 'Item Sales Statistics New';
    ApplicationArea = All;

    dataset
    {
        dataitem(Item; Item)
        {
            CalcFields = "Sales (Qty.)", "Sales (LCY)", "COGS (LCY)";
            RequestFilterFields = "No.", "Search Description", "Inventory Posting Group", "Statistics Group", "Base Unit of Measure", "Date Filter", "Location Filter", "Customer Filter", "Sales (Qty.)", "Sales (LCY)", "Vendor No.";
            column(Title; Title)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(TIME; TIME)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CurrReport_PAGENO; '')
            {
            }
            column(USERID; USERID)
            {
            }
            column(ItemFilter; ItemFilter)
            {
            }
            column(BreakdownByVariant; BreakdownByVariant)
            {
            }
            column(IncludeItemDescriptions; IncludeItemDescriptions)
            {
            }
            column(PrintOnlyIfSales; PrintOnlyIfSales)
            {
            }
            column(TLGroup; TLGroup)
            {
            }
            column(GroupField; GroupField)
            {
            }
            column(NoShow; NoShow)
            {
            }
            column(ItemDateFilterExsit; ItemDateFilterExsit)
            {
            }
            column(Item_TABLECAPTION__________ItemFilter; Item.TABLECAPTION + ': ' + ItemFilter)
            {
            }
            column(GroupName_________GroupNo; GroupName + ' ' + GroupNo)
            {
            }
            column(GroupDesc; GroupDesc)
            {
            }
            column(Item__No__; "No.")
            {
            }
            column(Item__Base_Unit_of_Measure_; "Base Unit of Measure")
            {
            }
            column(Item__COGS__LCY__; "COGS (LCY)")
            {
            }
            column(Item__Unit_Price_; "Unit Price")
            {
            }
            column(Item__Sales__Qty___; "Sales (Qty.)")
            {
                DecimalPlaces = 2 : 5;
            }
            column(Item__Sales__LCY__; "Sales (LCY)")
            {
            }
            column(Profit; Profit)
            {
            }
            column(UnitCost_Item; "Unit Cost")
            {
                IncludeCaption = true;
            }
            column(ItemProfitPct; ItemProfitPct)
            {
                DecimalPlaces = 1 : 1;
            }
            column(QuantityReturned; QuantityReturned)
            {
                DecimalPlaces = 2 : 5;
            }
            column(NoVariant; NoVariant)
            {
            }
            column(Item_Description; Description)
            {
            }
            column(Text003_________GroupName_________GroupNo; Text003 + ' ' + GroupName + ' ' + GroupNo)
            {
            }
            column(Item__Sales__Qty____Control32; "Sales (Qty.)")
            {
                DecimalPlaces = 2 : 5;
            }
            column(Item__Sales__LCY___Control33; "Sales (LCY)")
            {
            }
            column(Profit_Control34; Profit)
            {
            }
            column(ItemProfitPct_Control35; ItemProfitPct)
            {
                DecimalPlaces = 1 : 1;
            }
            column(QuantityReturned_Control3; QuantityReturned)
            {
                DecimalPlaces = 2 : 5;
            }
            column(Item__COGS__LCY___Control4; "COGS (LCY)")
            {
            }
            column(Item__Sales__Qty____Control37; "Sales (Qty.)")
            {
                DecimalPlaces = 2 : 5;
            }
            column(Item__Sales__LCY___Control38; "Sales (LCY)")
            {
            }
            column(Profit_Control39; Profit)
            {
            }
            column(ItemProfitPct_Control40; ItemProfitPct)
            {
                DecimalPlaces = 1 : 1;
            }
            column(QuantityReturned_Control5; QuantityReturned)
            {
                DecimalPlaces = 2 : 5;
            }
            column(Inventory_Item; Inventory)
            {
            }
            column(Item__COGS__LCY___Control6; "COGS (LCY)")
            {
            }
            column(Item_Inventory_Posting_Group; "Inventory Posting Group")
            {
            }
            column(Item_Vendor_No_; "Vendor No.")
            {
            }
            column(GrpSalesQty; GrpSalesQty)
            {
            }
            column(GrpSalesLCY; GrpSalesLCY)
            {
            }
            column(GrpCogsLCY; GrpCogsLCY)
            {
            }
            column(GrpQuantityReturned; GrpQuantityReturned)
            {
            }
            column(GrpProfit; GrpProfit)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Inventory_items_without_sales_are_not_included_on_this_report_Caption; Inventory_items_without_sales_are_not_included_on_this_report_CaptionLbl)
            {
            }
            column(Inventory_items_without_sales_during_the_above_period_are_not_included_on_this_report_Caption; Inventory_items_without_sales_during_the_above_period_are_not_included_on_this_report_CaptionLbl)
            {
            }
            column(Item__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Item__Base_Unit_of_Measure_Caption; FIELDCAPTION("Base Unit of Measure"))
            {
            }
            column(Item__COGS__LCY__Caption; FIELDCAPTION("COGS (LCY)"))
            {
            }
            column(Item__Unit_Price_Caption; FIELDCAPTION("Unit Price"))
            {
            }
            column(Item__Sales__Qty___Caption; FIELDCAPTION("Sales (Qty.)"))
            {
            }
            column(Item__Sales__LCY__Caption; FIELDCAPTION("Sales (LCY)"))
            {
            }
            column(ProfitCaption; ProfitCaptionLbl)
            {
            }
            column(ItemProfitPctCaption; ItemProfitPctCaptionLbl)
            {
            }
            column(QuantityReturnedCaption; QuantityReturnedCaptionLbl)
            {
            }
            column(Item__No__Caption_Control41; FIELDCAPTION("No."))
            {
            }
            column(Item__Base_Unit_of_Measure_Caption_Control43; FIELDCAPTION("Base Unit of Measure"))
            {
            }
            column(Item__Unit_Price_Caption_Control44; FIELDCAPTION("Unit Price"))
            {
            }
            column(Item__Sales__Qty___Caption_Control45; FIELDCAPTION("Sales (Qty.)"))
            {
            }
            column(QuantityReturnedCaption_Control46; QuantityReturnedCaption_Control46Lbl)
            {
            }
            column(Item__Sales__LCY__Caption_Control47; FIELDCAPTION("Sales (LCY)"))
            {
            }
            column(Item__COGS__LCY__Caption_Control48; FIELDCAPTION("COGS (LCY)"))
            {
            }
            column(ProfitCaption_Control49; ProfitCaption_Control49Lbl)
            {
            }
            column(ItemProfitPctCaption_Control50; ItemProfitPctCaption_Control50Lbl)
            {
            }
            column(Item_Variant_CodeCaption; Item_Variant_CodeCaptionLbl)
            {
            }
            column(Report_TotalCaption; Report_TotalCaptionLbl)
            {
            }
            dataitem("Item Variant"; "Item Variant")
            {
                DataItemLink = "Item No." = FIELD("No.");
                DataItemTableView = SORTING("Item No.", Code);
                column(Item_Variant_Code; Code)
                {
                }
                column(Item__No___Control53; Item."No.")
                {
                }
                column(Item__Base_Unit_of_Measure__Control55; Item."Base Unit of Measure")
                {
                }
                column(Item__Unit_Price__Control56; Item."Unit Price")
                {
                }
                column(Item__Sales__Qty____Control57; Item."Sales (Qty.)")
                {
                    DecimalPlaces = 2 : 5;
                }
                column(QuantityReturned_Control58; QuantityReturned)
                {
                    DecimalPlaces = 2 : 5;
                }
                column(Item__Sales__LCY___Control59; Item."Sales (LCY)")
                {
                }
                column(Item__COGS__LCY___Control60; Item."COGS (LCY)")
                {
                }
                column(Profit_Control61; Profit)
                {
                }
                column(ItemProfitPct_Control62; ItemProfitPct)
                {
                    DecimalPlaces = 1 : 1;
                }
                column(Item_Description_Control63; Item.Description)
                {
                }
                column(Item_Variant_Description; Description)
                {
                }
                column(Item_Variant_Item_No_; "Item No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF BlankVariant THEN BEGIN
                        Code := '';
                        "Item No." := '';
                        Description := 'Blank Variant';
                        "Description 2" := '';
                        BlankVariant := FALSE;
                    END;

                    Item.SETRANGE("Variant Filter", Code);
                    Item.CALCFIELDS("Sales (Qty.)", "Sales (LCY)", "COGS (LCY)");
                    IF (Item."Sales (Qty.)" = 0) AND PrintOnlyIfSales THEN
                        CurrReport.SKIP;
                    Profit := Item."Sales (LCY)" - Item."COGS (LCY)";
                    IF Item."Sales (LCY)" <> 0 THEN
                        ItemProfitPct := ROUND(Profit / Item."Sales (LCY)" * 100, 0.1)
                    ELSE
                        ItemProfitPct := 0;
                    QuantityReturned := 0;
                    ItemLedgerEntry.SETRANGE("Item No.", Item."No.");
                    ItemLedgerEntry.SETRANGE("Variant Code", Code);
                    IF ItemLedgerEntry.FIND('-') THEN
                        REPEAT
                            IF ItemLedgerEntry."Invoiced Quantity" > 0 THEN BEGIN
                                QuantityReturned := QuantityReturned + ItemLedgerEntry."Invoiced Quantity";
                                Item."Sales (Qty.)" := Item."Sales (Qty.)" + ItemLedgerEntry."Invoiced Quantity";
                            END;
                        UNTIL ItemLedgerEntry.NEXT = 0;
                    IF (Item."Sales (Qty.)" = 0) AND (QuantityReturned = 0) AND
                       (Item."Sales (LCY)" = 0) AND (Item."COGS (LCY)" = 0)
                    THEN
                        CurrReport.SKIP;
                end;

                trigger OnPreDataItem()
                begin
                    IF NOT BreakdownByVariant THEN
                        CurrReport.BREAK;
                    IF NOT AnyVariants THEN
                        CurrReport.BREAK;

                    BlankVariant := TRUE;
                    CurrReport.CREATETOTALS(Item."Sales (Qty.)", Item."Sales (LCY)", Item."COGS (LCY)",
                      Profit, QuantityReturned);
                end;
            }
            dataitem("Value Entry"; "Value Entry")
            {
                DataItemLink = "Item No." = FIELD("No.");
                RequestFilterFields = "Source No.", "Posting Date", "Location Code";
                column(ValueEntryGroup; 'Value Entry Group')
                {
                }
                column(EntryNo_ValueEntry; "Entry No.")
                {
                }
                column(CostAmountActual_ValueEntry; "Cost Amount (Actual)")
                {
                }
                column(SalesAmountActual_ValueEntry; "Sales Amount (Actual)")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //>> NF1.00:CIS.NU 08-18-15
                    Prof2 := "Sales Amount (Actual)" + "Cost Amount (Actual)";

                    IF "Sales Amount (Actual)" <> 0 THEN     // <>0

                      "Prof%2" := ROUND(100 * (("Sales Amount (Actual)" + "Cost Amount (Actual)") / "Sales Amount (Actual)"), 0.1);

                    ValueEntryExists := TRUE;
                    TotalVESalesAmtAct += "Sales Amount (Actual)";
                    TotalVECostAmtAct += "Cost Amount (Actual)";
                    //<< NF1.00:CIS.NU 08-18-15
                end;

                trigger OnPostDataItem()
                begin
                    //>> NF1.00:CIS.NU 08-18-15
                    IF ExporttoExcel AND ValueEntryExists THEN
                        MakeExcelDataBody();
                    //<< NF1.00:CIS.NU 08-18-15
                end;

                trigger OnPreDataItem()
                begin
                    //>> NF1.00:CIS.NU 08-18-15
                    SETRANGE("Item Ledger Entry Type", "Value Entry"."Item Ledger Entry Type"::Sale);

                    CurrReport.CREATETOTALS("Sales Amount (Actual)");
                    CurrReport.CREATETOTALS("Cost Amount (Actual)");
                    ValueEntryExists := FALSE;
                    TotalVESalesAmtAct := 0;
                    TotalVECostAmtAct := 0;
                    //<< NF1.00:CIS.NU 08-18-15
                end;
            }

            trigger OnAfterGetRecord()
            begin
                NoShow := FALSE;
                IF BreakdownByVariant THEN BEGIN
                    NoVariant := Text002;
                    IF AnyVariants THEN
                        NoShow := TRUE;
                    // EXIT;
                END;

                SETRANGE("Variant Filter");
                CALCFIELDS("Sales (Qty.)", "Sales (LCY)", "COGS (LCY)");
                IF ("Sales (Qty.)" = 0) AND PrintOnlyIfSales THEN
                    CurrReport.SKIP;
                Profit := "Sales (LCY)" - "COGS (LCY)";
                IF "Sales (LCY)" <> 0 THEN
                    ItemProfitPct := 1 //ROUND(Profit / "Sales (LCY)"  * 100,0.1)   //tested
                ELSE
                    ItemProfitPct := 0;
                QuantityReturned := 0;
                ItemLedgerEntry.SETRANGE("Item No.", "No.");
                ItemLedgerEntry.SETRANGE("Variant Code");
                IF ItemLedgerEntry.FIND('-') THEN
                    REPEAT
                        IF ItemLedgerEntry."Invoiced Quantity" > 0 THEN BEGIN
                            QuantityReturned := QuantityReturned + ItemLedgerEntry."Invoiced Quantity";
                            "Sales (Qty.)" := "Sales (Qty.)" + ItemLedgerEntry."Invoiced Quantity";
                        END;
                    UNTIL ItemLedgerEntry.NEXT = 0;

                Item.CALCFIELDS(Inventory);  //NF1.00:CIS.NU 08-18-15

                //>> NF1.00:CIS.NU 08-18-15
                IF STRPOS(CURRENTKEY, FIELDCAPTION("Inventory Posting Group")) = 1 THEN BEGIN
                    IF NOT ItemPostingGr.GET("Inventory Posting Group") THEN
                        ItemPostingGr.INIT;
                    TLGroup := TRUE;
                    GroupField := 2;
                    GroupName := ItemPostingGr.TABLECAPTION;
                    GroupNo := "Inventory Posting Group";
                    GroupDesc := ItemPostingGr.Description;
                END;
                IF STRPOS(CURRENTKEY, FIELDCAPTION("Vendor No.")) = 1 THEN BEGIN
                    IF NOT Vendor.GET("Vendor No.") THEN
                        Vendor.INIT;
                    TLGroup := TRUE;
                    GroupField := 3;
                    GroupName := Vendor.TABLECAPTION;
                    GroupNo := "Vendor No.";
                    GroupDesc := Vendor.Name;
                END;
                IF (STRPOS(CURRENTKEY, FIELDCAPTION("Inventory Posting Group")) = 0) AND
                   (STRPOS(CURRENTKEY, FIELDCAPTION("Vendor No.")) = 0)
                THEN BEGIN
                    TLGroup := FALSE;
                    GroupName := '';
                    GroupNo := '';
                    GroupDesc := '';
                END;

                IF GroupNo <> PreGroupNo THEN BEGIN
                    GrpSalesQty := 0;
                    GrpSalesLCY := 0;
                    GrpCogsLCY := 0;
                    GrpProfit := 0;
                    GrpQuantityReturned := 0;
                    PreGroupNo := GroupNo;
                END;

                GrpSalesQty += "Sales (Qty.)";
                GrpQuantityReturned += QuantityReturned;
                GrpSalesLCY += "Sales (LCY)";
                GrpCogsLCY += "COGS (LCY)";
                GrpProfit += Profit;
                //<< NF1.00:CIS.NU 08-18-15
            end;

            trigger OnPostDataItem()
            begin
                //>> NF1.00:CIS.NU 08-18-15
                CurrReport.CREATETOTALS("Sales (LCY)", "COGS (LCY)",
                                       Profit, QuantityReturned);
                "Value Entry".SETCURRENTKEY("Item No.", "Item Ledger Entry Type", "Posting Date", "Location Code", "Source No.");
                "Value Entry".SETRANGE("Item Ledger Entry Type", "Value Entry"."Item Ledger Entry Type"::Sale);
                COPYFILTER("Date Filter", "Value Entry"."Posting Date");
                COPYFILTER("Location Filter", "Value Entry"."Location Code");
                COPYFILTER("Customer Filter", "Value Entry"."Source No.");
                COPYFILTER("Global Dimension 1 Filter", "Value Entry"."Global Dimension 1 Code");
                COPYFILTER("Global Dimension 2 Filter", "Value Entry"."Global Dimension 2 Code");
                //<< NF1.00:CIS.NU 08-18-15
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.CREATETOTALS("Sales (Qty.)", "Sales (LCY)", "COGS (LCY)",
                  Profit, QuantityReturned);
                ItemLedgerEntry.SETCURRENTKEY("Entry Type", "Item No.");
                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                COPYFILTER("Date Filter", ItemLedgerEntry."Posting Date");
                COPYFILTER("Global Dimension 1 Filter", ItemLedgerEntry."Global Dimension 1 Code");
                COPYFILTER("Global Dimension 2 Filter", ItemLedgerEntry."Global Dimension 2 Code");
                COPYFILTER("Location Filter", ItemLedgerEntry."Location Code");
                //>> NF1.00:CIS.NU 08-18-15
                COPYFILTER("Customer Filter", ItemLedgerEntry."Source No.");
                "Value Entry".SETCURRENTKEY("Item No.", "Item Ledger Entry Type", "Posting Date", "Location Code", "Source No.");
                "Value Entry".SETRANGE("Item Ledger Entry Type", "Value Entry"."Item Ledger Entry Type"::Sale);
                COPYFILTER("Date Filter", "Value Entry"."Posting Date");
                COPYFILTER("Location Filter", "Value Entry"."Location Code");
                COPYFILTER("Customer Filter", "Value Entry"."Source No.");
                COPYFILTER("Global Dimension 1 Filter", "Value Entry"."Global Dimension 1 Code");
                COPYFILTER("Global Dimension 2 Filter", "Value Entry"."Global Dimension 2 Code");
                GrpSalesQty := 0;
                GrpSalesLCY := 0;
                GrpCogsLCY := 0;
                GrpProfit := 0;
                GrpQuantityReturned := 0;
                //<< NF1.00:CIS.NU 08-18-15
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
                    field(PrintOnlyIfSales; PrintOnlyIfSales)
                    {
                        Caption = 'Only Items with Sales';
                        ApplicationArea = All;
                    }
                    field(IncludeItemDescriptions; IncludeItemDescriptions)
                    {
                        Caption = 'Include Item Descriptions';
                        ApplicationArea = All;
                    }
                    field(BreakdownByVariant; BreakdownByVariant)
                    {
                        Caption = 'Breakdown By Variant';
                        ApplicationArea = All;
                    }
                    field(ExporttoExcel; ExporttoExcel)
                    {
                        Caption = 'Export To Excel';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        DescriptionLbl = 'Description';
        QuantityLbl = 'Quantity';
        QuantityonHandLbl = 'Quantity on Hand';
        UnitpriceLbl = 'Unit price';
    }

    trigger OnPostReport()
    begin
        //>> NF1.00:CIS.NU 08-18-15
        IF ExporttoExcel THEN
            CreateExcelWorkBook;
        //<< NF1.00:CIS.NU 08-18-15
    end;

    trigger OnPreReport()
    begin
        Title := Text000;
        IF BreakdownByVariant THEN
            Title := Title + ' - ' + Text001;

        CompanyInformation.GET;
        ItemFilter := Item.GETFILTERS;
        ItemDateFilterExsit := (Item.GETFILTER("Date Filter") <> '');
        //>> NF1.00:CIS.NU 08-18-15
        IF ExporttoExcel THEN BEGIN
            ExcelBuf.RESET;
            ExcelBuf.DELETEALL;
            MainTitle := 'Item Sales Statistics';
            MakeExcelDataInfo;
        END;
        //<< NF1.00:CIS.NU 08-18-15
    end;

    var
        CompanyInformation: Record 79;
        ItemPostingGr: Record 94;
        Vendor: Record 23;
        ItemLedgerEntry: Record 32;
        IncludeItemDescriptions: Boolean;
        BreakdownByVariant: Boolean;
        BlankVariant: Boolean;
        NoShow: Boolean;
        ItemFilter: Text;
        Title: Text[80];
        NoVariant: Text[30];
        Profit: Decimal;
        QuantityReturned: Decimal;
        ItemProfitPct: Decimal;
        PrintOnlyIfSales: Boolean;
        GroupName: Text[30];
        GroupNo: Code[20];
        GroupDesc: Text[30];
        Text000: Label 'Inventory Sales Statistics';
        Text001: Label 'by Variant';
        Text002: Label 'No Variants';
        Text003: Label 'Total';
        TLGroup: Boolean;
        GroupField: Integer;
        ItemDateFilterExsit: Boolean;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Inventory_items_without_sales_are_not_included_on_this_report_CaptionLbl: Label 'Inventory items without sales are not included on this report.';
        Inventory_items_without_sales_during_the_above_period_are_not_included_on_this_report_CaptionLbl: Label 'Inventory items without sales during the above period are not included on this report.';
        ProfitCaptionLbl: Label 'Profit';
        ItemProfitPctCaptionLbl: Label 'Profit %';
        QuantityReturnedCaptionLbl: Label 'Quantity Returned';
        QuantityReturnedCaption_Control46Lbl: Label 'Quantity Returned';
        ProfitCaption_Control49Lbl: Label 'Profit';
        ItemProfitPctCaption_Control50Lbl: Label 'Profit %';
        Item_Variant_CodeCaptionLbl: Label 'Variant Code';
        Report_TotalCaptionLbl: Label 'Report Total';
        MainTitle: Text[30];
        ExcelBuf: Record 370 temporary;
        ExporttoExcel: Boolean;
        Prof2: Decimal;
        "Prof%2": Decimal;
        SalesAmount: Decimal;
        Prof3: Decimal;
        Text50000: Label 'Company Name';
        Text50001: Label 'Report Name';
        Text50002: Label 'Item Filters';
        Text50003: Label 'Item Sales Statistics New';
        GrpSalesQty: Decimal;
        GrpSalesLCY: Decimal;
        GrpCogsLCY: Decimal;
        GrpQuantityReturned: Decimal;
        GrpProfit: Decimal;
        PreGroupNo: Code[20];
        ValueEntryExists: Boolean;
        TotalVESalesAmtAct: Decimal;
        TotalVECostAmtAct: Decimal;

    procedure AnyVariants(): Boolean
    var
        ItemVariant: Record 5401;
    begin
        ItemVariant.SETRANGE("Item No.", Item."No.");
        EXIT(ItemVariant.FINDFIRST);
    end;

    procedure MakeExcelDataInfo()
    begin
        //>> NF1.00:CIS.NU 08-18-15
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(FORMAT(Text50000), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(CompanyInformation.Name, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text50001), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn('Item Sales Statistics', FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text50002), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(ItemFilter, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
        //<< NF1.00:CIS.NU 08-18-15
    end;

    procedure MakeExcelDataHeader()
    begin
        //>> NF1.00:CIS.NU 08-18-15
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Description', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Unit Price', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Sales(Qty)', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Sales($)', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('COgs($)', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Profit', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Profit%', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Quantity', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Unit Cost', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        //<< NF1.00:CIS.NU 08-18-15
    end;

    procedure MakeExcelDataBody()
    begin
        //>> NF1.00:CIS.NU 08-18-15
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Item."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Item.Description, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Item."Unit Price", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(Item."Sales (Qty.)", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(TotalVESalesAmtAct, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(TotalVECostAmtAct, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(TotalVESalesAmtAct + TotalVECostAmtAct, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        IF TotalVESalesAmtAct <> 0 THEN
            ExcelBuf.AddColumn(100 * (TotalVESalesAmtAct + TotalVECostAmtAct) / TotalVESalesAmtAct, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number)
        ELSE
            ExcelBuf.AddColumn('N/A', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Item.Inventory, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(Item."Unit Cost", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00000', ExcelBuf."Cell Type"::Number);
        //<< NF1.00:CIS.NU 08-18-15
    end;

    procedure CreateExcelWorkBook()
    begin
        //>> NF1.00:CIS.NU 08-18-15
        // ExcelBuf.CreateBookAndOpenExcel(Text50000, Text50002, COMPANYNAME, USERID);
        ExcelBuf.CreateNewBook(Text50003);
        ExcelBuf.WriteSheet(Text50003, CompanyName, UserId);
        ExcelBuf.SetFriendlyFilename(Text50003);
        ExcelBuf.CloseBook();
        ExcelBuf.OpenExcel();
        ERROR('');
        //<< NF1.00:CIS.NU 08-18-15
    end;
}

