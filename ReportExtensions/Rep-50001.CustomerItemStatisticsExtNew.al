report 50001 "Customer/Item Statistics New"
{
    // NF1.00:CIS.NG  08-07-15 Merged during upgrade
    // //>> NIF
    // Made Quantity field wider
    // Changed Decimal places property on Quantity to 0:2
    // 
    // Excel:
    //   Functions Added:
    //     EnterCell
    //   Globals Added:
    //     d
    //     ExcelBuf
    //     RowNo
    //     ColumnNo
    //     ExportToExcel
    //     MainTitle
    //     SubTitle
    //     FilterTitle
    //     FilterTitle2
    //   Prep Code:
    //     OnPreReport()
    //     OnPostReport()
    //   Request Form:
    //     Added "Export to Excel" option
    //   OnPreSection Code:
    //     Customer, Header(1)
    //     Customer, Header(4)
    //     Value Entry, GroupFooter(1)
    //     Value Entry, Footer (2)
    //     Customer,Footer(6)
    // 
    // SM 001 - 4/25/17 Text "Customer Total" was added
    // SM 001 - 5/3/17 Added Global Dimension 1 Code
    // SM 001 - 4/6/22 Added Cross Reference No on Excel
    // 11/22/22 CIS.Ram - Show in foreing currency
    // //CIS.Ram Added on 10/06/23
    // TotalAmount_ARC := 0;
    // TotalMargin_ARC := 0;
    // //CIS.Ram Added on 10/06/23
    DefaultLayout = RDLC;
    RDLCLayout = '.\RDLC\CustomerItemStatistics.rdl';

    Caption = 'Customer/Item Statistics New';
    ApplicationArea = All;

    dataset
    {
        dataitem(Customer; Customer)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Customer Posting Group";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(TIME; TIME)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(Customer_TABLECAPTION___________FilterString; Customer.TABLECAPTION + ':  ' + FilterString)
            {
            }
            column(Value_Entry__TABLECAPTION___________FilterString2; "Value Entry".TABLECAPTION + ':  ' + FilterString2)
            {
            }
            column(groupno; groupno)
            {
            }
            column(PrintToExcel; PrintToExcel)
            {
            }
            column(FilterString; FilterString)
            {
            }
            column(FilterString2; FilterString2)
            {
            }
            column(OnlyOnePerPage; OnlyOnePerPage)
            {
            }
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(Customer__Phone_No__; "Phone No.")
            {
            }
            column(Customer_Contact; Contact)
            {
            }
            column(Value_Entry___Sales_Amount__Actual__; "Value Entry"."Sales Amount (Actual)")
            {
            }
            column(Profit; Profit)
            {
            }
            column(Value_Entry___Discount_Amount_; "Value Entry"."Discount Amount")
            {
            }
            column(Profit__; "Profit%")
            {
                DecimalPlaces = 1 : 1;
            }
            column(Customer_Global_Dimension_1_Filter; "Global Dimension 1 Filter")
            {
            }
            column(Customer_Global_Dimension_2_Filter; "Global Dimension 2 Filter")
            {
            }
            column(ShowDetails; ShowDetails)
            {
            }
            column(Customer_Item_StatisticsCaption; Customer_Item_StatisticsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Customer_NoCaption; Customer_NoCaptionLbl)
            {
            }
            column(Customer_NameCaption; FIELDCAPTION(Name))
            {
            }
            column(Value_Entry__Item_No__Caption; "Value Entry".FIELDCAPTION("Item No."))
            {
            }
            column(Item_DescriptionCaption; Item_DescriptionCaptionLbl)
            {
            }
            column(Invoiced_Quantity_Caption; Invoiced_Quantity_CaptionLbl)
            {
            }
            column(Value_Entry__Sales_Amount__Actual__Caption; Value_Entry__Sales_Amount__Actual__CaptionLbl)
            {
            }
            column(Profit_Control38Caption; Profit_Control38CaptionLbl)
            {
            }
            column(Value_Entry__Discount_Amount_Caption; Value_Entry__Discount_Amount_CaptionLbl)
            {
            }
            column(Profit___Control40Caption; Profit___Control40CaptionLbl)
            {
            }
            column(Item__Base_Unit_of_Measure_Caption; Item__Base_Unit_of_Measure_CaptionLbl)
            {
            }
            column(Phone_Caption; Phone_CaptionLbl)
            {
            }
            column(Contact_Caption; Contact_CaptionLbl)
            {
            }
            column(Report_TotalCaption; Report_TotalCaptionLbl)
            {
            }
            column(DivCode; Customer."Global Dimension 1 Code")
            {
            }
            dataitem("Value Entry"; "Value Entry")
            {
                DataItemLink = "Source No." = FIELD("No."),
                               "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                               "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
                DataItemTableView = SORTING("Source Type", "Source No.", "Item Ledger Entry Type", "Item No.", "Posting Date")
                                    WHERE("Source Type" = CONST(Customer),
                                          "Item Ledger Entry Type" = CONST(Sale),
                                          "Expected Cost" = CONST(false));
                RequestFilterFields = "Item No.", "Inventory Posting Group", "Posting Date";
                column(Value_Entry__Item_No__; "Item No.")
                {
                }
                column(Item_Description; Item.Description)
                {
                }
                column(Invoiced_Quantity_; -"Invoiced Quantity")
                {
                    DecimalPlaces = 0 : 2;
                }
                column(Item__Base_Unit_of_Measure_; Item."Base Unit of Measure")
                {
                }
                column(Profit_Control38; Profit)
                {
                }
                column(Value_Entry__Discount_Amount_; "Discount Amount")
                {
                }
                column(Profit___Control40; "Profit%")
                {
                    DecimalPlaces = 1 : 1;
                }
                column(Value_Entry__Sales_Amount__Actual__; "Sales Amount (Actual)")
                {
                }
                column(Customer__No___Control41; Customer."No.")
                {
                }
                column(Value_Entry__Sales_Amount__Actual___Control42; "Sales Amount (Actual)")
                {
                }
                column(Profit_Control43; Profit)
                {
                }
                column(Value_Entry__Discount_Amount__Control44; "Discount Amount")
                {
                }
                column(Profit___Control45; "Profit%")
                {
                    DecimalPlaces = 1 : 1;
                }
                column(Value_Entry_Entry_No_; "Entry No.")
                {
                }
                column(Value_Entry_Source_No_; "Source No.")
                {
                }
                column(Value_Entry_Global_Dimension_1_Code; "Global Dimension 1 Code")
                {
                }
                column(Value_Entry_Global_Dimension_2_Code; "Global Dimension 2 Code")
                {
                }
                column(Customer_TotalCaption; Customer_TotalCaptionLbl)
                {
                }
                column(Item_CountryofOriginCode; Item."Country/Region of Origin Code")
                {
                }
                column(Item_ManufacturerCode; Item."Manufacturer Code")
                {
                }
                column(Item_VendorNo; Item."Vendor No.")
                {
                }
                dataitem("Item Reference"; "Item Reference")
                {
                    DataItemLink = "Item No." = FIELD("Item No."),
                                   "Reference Type No." = FIELD("Source No.");
                    column(Cross_Ref_No; "Item Reference"."Reference No.")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    IF ValueEntryTotalForItem."Item No." <> "Item No." THEN BEGIN
                        "CalculateProfit%"();
                        IF PrintToExcel AND (ValueEntryTotalForItem."Item No." <> '') THEN
                            MakeExcelDataBody;
                        CLEAR(ValueEntryTotalForItem);
                        ProfitTotalForItemARC := 0;
                        ProfitTotalForItem := 0;
                        IF NOT Item.GET("Item No.") THEN BEGIN
                            Item.Description := Text000;
                            Item."Base Unit of Measure" := '';
                        END;
                    END;
                    IF ShowARC THEN BEGIN
                        CurrencyCode := '';
                        CurrencyCode := Customer."Currency Code";
                        GetCurrencyRecord(Currency, CurrencyCode);
                        CurrencyFactor := CurrExchRate.ExchangeRate("Posting Date", CurrencyCode);
                        SAmount_ARC := CurrExchRate.ExchangeAmtLCYToFCY("Posting Date", CurrencyCode, "Sales Amount (Actual)", CurrencyFactor);
                        //Profit := SAmount_ARC + "Cost Amount (Actual) (ACY)";
                        IF "Cost Amount (Actual)" <> 0 THEN
                            Profit := ("Sales Amount (Actual)" * "Cost Amount (Actual) (ACY)" / "Cost Amount (Actual)") + "Cost Amount (Actual) (ACY)";
                        //MESSAGE('%1\%2',SAmount_ARC,Profit);
                    END ELSE
                        Profit := "Sales Amount (Actual)" + "Cost Amount (Actual)";
                    "Discount Amount" := -"Discount Amount";

                    ValueEntryTotalForItem."Item No." := "Item No.";
                    ValueEntryTotalForItem."Invoiced Quantity" += "Invoiced Quantity";
                    IF NOT ShowARC THEN BEGIN //CIS.Ram - Show in foreing currency
                        ValueEntryTotalForItem."Sales Amount (Actual)" += "Sales Amount (Actual)";
                        ValueEntryTotalForItem."Discount Amount" += "Discount Amount";
                        ProfitTotalForItem += Profit;
                        //>>CIS.Ram - Show in foreing currency
                    END;// ELSE

                    //<<CIS.Ram - Show in foreing currency
                    //>> NF1.00:CIS.NG 08-07-15
                    ValueEntryExists_gBln := TRUE;
                    TotalAmount_gDec += "Sales Amount (Actual)";
                    TotalMargin_gDec += Profit;
                    TotalDiscount_gDec += "Discount Amount";
                    GrandTotalAmount_gDec += "Sales Amount (Actual)";
                    GrandTotalMargin_gDec += Profit;
                    GrandTotalDiscount_gDec += "Discount Amount";
                    //<< NF1.00:CIS.NG 08-07-15

                    //>>CIS.Ram - Show in foreing currency
                    CurrencyCode := '';
                    CurrencyCode := Customer."Currency Code";
                    GetCurrencyRecord(Currency, CurrencyCode);
                    CurrencyFactor := CurrExchRate.ExchangeRate("Posting Date", CurrencyCode);

                    IF ShowARC THEN BEGIN
                        TotalAmount_ARC += CurrExchRate.ExchangeAmtLCYToFCY("Posting Date", CurrencyCode, "Sales Amount (Actual)", CurrencyFactor);
                        TotalMargin_ARC += Profit; //CurrExchRate.ExchangeAmtLCYToFCY(010722D,CurrencyCode,Profit,CurrencyFactor);  //"Posting Date"
                        TotalDiscount_ARC += CurrExchRate.ExchangeAmtLCYToFCY("Posting Date", CurrencyCode, "Discount Amount", CurrencyFactor);
                        GrandTotalAmount_ARC += CurrExchRate.ExchangeAmtLCYToFCY("Posting Date", CurrencyCode, "Sales Amount (Actual)", CurrencyFactor);
                        GrandTotalMargin_ARC += Profit; //CurrExchRate.ExchangeAmtLCYToFCY(010722D,CurrencyCode,Profit,CurrencyFactor);  //"Posting Date"
                        GrandTotalDiscount_ARC += CurrExchRate.ExchangeAmtLCYToFCY("Posting Date", CurrencyCode, "Discount Amount", CurrencyFactor);
                        ValueEntryTotalForItem."Sales Amount (Actual)" +=
                          CurrExchRate.ExchangeAmtLCYToFCY("Posting Date", CurrencyCode, "Sales Amount (Actual)", CurrencyFactor);
                        ValueEntryTotalForItem."Discount Amount" +=
                          CurrExchRate.ExchangeAmtLCYToFCY("Posting Date", CurrencyCode, "Discount Amount", CurrencyFactor);
                        ProfitTotalForItemARC += Profit; //CurrExchRate.ExchangeAmtLCYToFCY(010722D,CurrencyCode,Profit,CurrencyFactor); //"Posting Date"
                    END;
                    //<<CIS.Ram - Show in foreing currency
                end;

                trigger OnPostDataItem()
                begin
                    IF PrintToExcel AND (ValueEntryTotalForItem."Item No." <> '') THEN BEGIN
                        "CalculateProfit%";
                        MakeExcelDataBody;
                    END;

                    //>> NF1.00:CIS.NG 08-07-15
                    IF PrintToExcel AND ValueEntryExists_gBln THEN BEGIN
                        ExcelBuf.NewRow;
                        ExcelBuf.AddColumn(Customer."No.", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        //ExcelBuf.AddColumn(Customer.Name,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('Customer Total', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        //4/6/22 SM
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        //4/6/22 SM
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        IF NOT ShowARC THEN BEGIN //CIS.Ram - Show in foreing currency
                            ExcelBuf.AddColumn(TotalAmount_gDec, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                            ExcelBuf.AddColumn(TotalMargin_gDec, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                            IF TotalAmount_gDec <> 0 THEN
                                Perc_gDec := ROUND(100 * TotalMargin_gDec / TotalAmount_gDec, 0.1)
                            ELSE
                                Perc_gDec := 0;

                            ExcelBuf.AddColumn(TotalDiscount_gDec, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                            ExcelBuf.AddColumn(Perc_gDec, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                            //>>CIS.Ram - Show in foreing currency
                        END ELSE BEGIN
                            ExcelBuf.AddColumn(TotalAmount_ARC, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                            ExcelBuf.AddColumn(TotalMargin_ARC, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                            IF TotalAmount_ARC <> 0 THEN
                                Perc_ARC := ROUND(100 * TotalMargin_ARC / TotalAmount_ARC, 0.1)
                            ELSE
                                Perc_ARC := 0;

                            ExcelBuf.AddColumn(TotalDiscount_ARC, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                            ExcelBuf.AddColumn(Perc_ARC, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                        END;
                        //<<CIS.Ram - Show in foreing currency
                        ExcelBuf.NewRow;
                    END;
                    //<< NF1.00:CIS.NG 08-07-15
                end;

                trigger OnPreDataItem()
                begin
                    CurrReport.CREATETOTALS("Invoiced Quantity", "Sales Amount (Actual)", Profit, "Discount Amount");
                    CLEAR(ValueEntryTotalForItem);
                    ProfitTotalForItem := 0;
                    //>> NF1.00:CIS.NG 08-07-15
                    ValueEntryExists_gBln := FALSE;
                    TotalAmount_gDec := 0;
                    TotalMargin_gDec := 0;
                    TotalDiscount_gDec := 0;
                    //<< NF1.00:CIS.NG 08-07-15
                    //CIS.Ram Added on 10/06/23
                    TotalAmount_ARC := 0;
                    TotalMargin_ARC := 0;
                    //CIS.Ram Added on 10/06/23
                    GrandTotalMargin_ARC := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF OnlyOnePerPage THEN
                    groupno := groupno + 1
            end;

            trigger OnPostDataItem()
            begin
                //>> NF1.00:CIS.NG 08-07-15
                IF PrintToExcel THEN BEGIN

                    ExcelBuf.NewRow;
                    ExcelBuf.NewRow;
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Report Total', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    // 4/6/22 SM
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    //4/6/22 SM
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(GrandTotalAmount_gDec, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(GrandTotalMargin_gDec, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                    IF GrandTotalAmount_gDec <> 0 THEN
                        Perc_gDec := ROUND(100 * GrandTotalMargin_gDec / GrandTotalAmount_gDec, 0.1)
                    ELSE
                        Perc_gDec := 0;

                    ExcelBuf.AddColumn(GrandTotalDiscount_gDec, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(Perc_gDec, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.NewRow;
                END;
                //<< NF1.00:CIS.NG 08-07-15
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.NEWPAGEPERRECORD := OnlyOnePerPage;

                CurrReport.CREATETOTALS("Value Entry"."Sales Amount (Actual)", Profit, "Value Entry"."Discount Amount");
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
                    field(OnlyOnePerPage; OnlyOnePerPage)
                    {
                        Caption = 'New Page per Account';
                        ApplicationArea = All;
                    }
                    field(PrintToExcel; PrintToExcel)
                    {
                        Caption = 'Print To Excel';
                        ApplicationArea = All;
                    }
                    field(ShowDetails; ShowDetails)
                    {
                        Caption = 'Show Countries, Manufacturers and Vendors';
                        ApplicationArea = All;
                    }
                    field(ShowARC; ShowARC)
                    {
                        Caption = 'Show in Additional Reporting Currency';
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
        CountryLbl = 'Country';
        ManufacturerLbl = 'Manufacturer';
        VendorNoLbl = 'Vendor No.';
    }

    trigger OnPostReport()
    begin
        IF PrintToExcel THEN
            CreateExcelbook;
    end;

    trigger OnPreReport()
    begin
        CompanyInformation.GET;
        FilterString := Customer.GETFILTERS;
        FilterString2 := "Value Entry".GETFILTERS;
        IF PrintToExcel THEN
            MakeExcelInfo;
    end;

    var
        ExcelBuf: Record 370 temporary;
        FilterString: Text;
        FilterString2: Text;
        Profit: Decimal;
        "Profit%": Decimal;
        OnlyOnePerPage: Boolean;
        Item: Record 27;
        CompanyInformation: Record 79;
        PrintToExcel: Boolean;
        Text000: Label 'Invalid Item';
        Text001: Label 'Data';
        Text002: Label 'Customer/Item Statistics';
        Text003: Label 'Company Name';
        Text004: Label 'Report No.';
        Text005: Label 'Report Name';
        Text006: Label 'User ID';
        Text007: Label 'Date / Time';
        Text008: Label 'Customer Filters';
        Text009: Label 'Value Entry Filters';
        Text010: Label 'Contribution Margin';
        Text011: Label 'Contribution Ratio';
        groupno: Integer;
        ValueEntryTotalForItem: Record 5802;
        ProfitTotalForItem: Decimal;
        Customer_Item_StatisticsCaptionLbl: Label 'Customer/Item Statistics';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Customer_NoCaptionLbl: Label 'Customer No';
        Item_DescriptionCaptionLbl: Label 'Item Description';
        Invoiced_Quantity_CaptionLbl: Label 'Quantity';
        Value_Entry__Sales_Amount__Actual__CaptionLbl: Label 'Amount';
        Profit_Control38CaptionLbl: Label 'Contribution Margin';
        Value_Entry__Discount_Amount_CaptionLbl: Label 'Discount';
        Profit___Control40CaptionLbl: Label 'Contrib Ratio';
        Item__Base_Unit_of_Measure_CaptionLbl: Label 'Unit';
        Phone_CaptionLbl: Label 'Phone:';
        Contact_CaptionLbl: Label 'Contact:';
        Report_TotalCaptionLbl: Label 'Report Total';
        Customer_TotalCaptionLbl: Label 'Customer Total';
        "<<Excel>>": Integer;
        d: Dialog;
        RowNo: Integer;
        ColumnNo: Integer;
        ExportToExcel: Boolean;
        MainTitle: Text[100];
        SubTitle: Text[100];
        FilterTitle: Text[250];
        FilterTitle2: Text[250];
        ShowDetails: Boolean;
        ValueEntryExists_gBln: Boolean;
        TotalAmount_gDec: Decimal;
        TotalMargin_gDec: Decimal;
        TotalDiscount_gDec: Decimal;
        GrandTotalAmount_gDec: Decimal;
        GrandTotalMargin_gDec: Decimal;
        GrandTotalDiscount_gDec: Decimal;
        Perc_gDec: Decimal;
        CISText001: Label 'Showing in Additional Report Currency';
        ShowARC: Boolean;
        TotalAmount_ARC: Decimal;
        TotalMargin_ARC: Decimal;
        TotalDiscount_ARC: Decimal;
        GrandTotalAmount_ARC: Decimal;
        GrandTotalMargin_ARC: Decimal;
        GrandTotalDiscount_ARC: Decimal;
        Perc_ARC: Decimal;
        CurrencyFactor: Decimal;
        CurrExchRate: Record 330;
        GLSetup: Record 98;
        Currency: Record 4;
        CurrencyCode: Code[10];
        ProfitTotalForItemARC: Decimal;
        SAmount_ARC: Decimal;

    procedure "CalculateProfit%"()
    begin
        IF ValueEntryTotalForItem."Sales Amount (Actual)" <> 0 THEN
            "Profit%" := ROUND(100 * ProfitTotalForItem / ValueEntryTotalForItem."Sales Amount (Actual)", 0.1)
        ELSE
            "Profit%" := 0;
    end;

    local procedure MakeExcelInfo()
    begin
        ExcelBuf.SetUseInfoSheet();
        ExcelBuf.AddInfoColumn(Format(Text003), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(CompanyInformation.Name, false, false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow();
        ExcelBuf.AddInfoColumn(Format(Text005), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(Format(Text002), false, false, false, false, '', ExcelBuf."Cell Type"::Text);
        //>>CIS.Ram - Show in foreing currency
        IF ShowARC THEN BEGIN
            ExcelBuf.NewRow;
            ExcelBuf.AddInfoColumn(FORMAT(CISText001), FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        END;
        //<<CIS.Ram - Show in foreing currency
        ExcelBuf.NewRow();
        ExcelBuf.AddInfoColumn(Format(Text004), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(REPORT::"Customer/Item Statistics", false, false, false, false, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.NewRow();
        ExcelBuf.AddInfoColumn(Format(Text006), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(UserId, false, false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow();
        ExcelBuf.AddInfoColumn(Format(Text007), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(Today, false, false, false, false, '', ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddInfoColumn(Time, false, false, false, false, '', ExcelBuf."Cell Type"::Time);
        ExcelBuf.NewRow();
        ExcelBuf.AddInfoColumn(Format(Text008), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FilterString, false, false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow();
        ExcelBuf.AddInfoColumn(Format(Text009), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FilterString2, false, false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.ClearNewRow();
        MakeExcelDataHeader();
    end;

    local procedure MakeExcelDataHeader()
    begin
        //>> NF1.00:CIS.NG 08-07-15
        ExcelBuf.AddColumn(CompanyInformation.Name, FALSE, '', FALSE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);

        //>>CIS.Ram - Show in foreing currency
        IF ShowARC THEN
            ExcelBuf.AddColumn(FORMAT(CISText001), FALSE, '', FALSE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        //<<CIS.Ram - Show in foreing currency

        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(FilterString, FALSE, '', FALSE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(FilterString2, FALSE, '', FALSE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;

        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Contribution', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Contrib.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Cust No.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Customer Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Item No.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Cross Ref No.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Item Description', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Quantity', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Unit', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Amount', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Margin', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Discount', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Ratio', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Country', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Manufacturer', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Vendor No.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        //<< NF1.00:CIS.NG 08-07-15
    end;

    local procedure MakeExcelDataBody()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Customer."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer.Name, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ValueEntryTotalForItem."Item No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Item Reference"."Reference No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Item.Description, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(-ValueEntryTotalForItem."Invoiced Quantity", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(Item."Base Unit of Measure", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(
          ValueEntryTotalForItem."Sales Amount (Actual)", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        IF NOT ShowARC THEN BEGIN  //CIS.Ram - Show in foreing currency
            ExcelBuf.AddColumn(ProfitTotalForItem, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
            //>>CIS.Ram - Show in foreing currency
        END ELSE
            ExcelBuf.AddColumn(ProfitTotalForItemARC, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        //>>CIS.Ram - Show in foreing currency
        ExcelBuf.AddColumn(ValueEntryTotalForItem."Discount Amount", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn("Profit%" / 100, FALSE, '', FALSE, FALSE, FALSE, '0.0%', ExcelBuf."Cell Type"::Number);

        //>> NF1.00:CIS.NG 08-07-15
        ExcelBuf.AddColumn(Item."Country/Region of Origin Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Item."Manufacturer Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Item."Vendor No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer."Global Dimension 1 Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        //<< NF1.00:CIS.NG 08-07-15
    end;

    local procedure CreateExcelbook()
    begin
        //ExcelBuf.CreateBookAndOpenExcel(Text001, Text002, COMPANYNAME, USERID);
        ExcelBuf.CreateNewBook(Text001);
        ExcelBuf.WriteSheet(Text001, CompanyName, UserId);
        ExcelBuf.SetFriendlyFilename(Text001);
        ExcelBuf.CloseBook();
        ExcelBuf.OpenExcel();
        ERROR('');
    end;

    local procedure GetCurrencyRecord(var Currency: Record 4; CurrencyCode: Code[10])
    begin
        IF CurrencyCode = '' THEN BEGIN
            CLEAR(Currency);
            Currency.Description := GLSetup."LCY Code";
            Currency."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
        END ELSE
            IF Currency.Code <> CurrencyCode THEN
                Currency.GET(CurrencyCode);
    end;

    local procedure GetCurrencyCaptionCode(CurrencyCode: Code[10]): Text[80]
    begin
        //IF PrintAmountsInLocal THEN BEGIN
        IF CurrencyCode = '' THEN
            EXIT('101,1,' + Text001);

        GetCurrencyRecord(Currency, CurrencyCode);
        EXIT('101,4,' + STRSUBSTNO(Text001, Currency.Description));
        //END;
        EXIT('');
    end;
}

