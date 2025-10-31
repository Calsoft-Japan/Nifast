report 50013 "Customer Sales Statistics New"
{
    // NF1.00:CIS.NU  08-07-15 Merged during upgrade
    // RTT 090407 Code Move CALCFIELDS and filters away from DataItem due to the need to filter on "Sales ($)"
    //            -new global Cust2
    //            -code at Customer-OnAfterGetRcord
    //            -add "Date Filter" and "Sales (LCY)" as ReqFilterFields
    DefaultLayout = RDLC;
    RDLCLayout = '.\RDLC\CustomerSalesStatistics.rdlc';

    Caption = 'Customer Sales Statistics New';

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Search Name", "Customer Posting Group", "Currency Code", "Responsibility Center", "Global Dimension 2 Code", "Salesperson Code", "Date Filter", "Sales (LCY)";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(TIME; TIME)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO())
            {
            }
            column(USERID; USERID)
            {
            }
            column(FilterString; FilterString)
            {
            }
            column(FilterString_Control1400000; FilterString)
            {
            }
            column(PeriodStartingDate_2_; PeriodStartingDate[2])
            {
            }
            column(PeriodStartingDate_3_; PeriodStartingDate[3])
            {
            }
            column(PeriodStartingDate_4_; PeriodStartingDate[4])
            {
            }
            column(PeriodStartingDate_2__Control14; PeriodStartingDate[2])
            {
            }
            column(PeriodStartingDate_3__1; PeriodStartingDate[3] - 1)
            {
            }
            column(PeriodStartingDate_4__1; PeriodStartingDate[4] - 1)
            {
            }
            column(PeriodStartingDate_5__1; PeriodStartingDate[5] - 1)
            {
            }
            column(PeriodStartingDate_5__1_Control18; PeriodStartingDate[5] - 1)
            {
            }
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(Sales___1_; "Sales$"[1])
            {
            }
            column(Sales___2_; "Sales$"[2])
            {
            }
            column(Sales___3_; "Sales$"[3])
            {
            }
            column(Sales___4_; "Sales$"[4])
            {
            }
            column(Sales___5_; "Sales$"[5])
            {
            }
            column(CostOfSales___1_; "CostOfSales$"[1])
            {
            }
            column(CostOfSales___2_; "CostOfSales$"[2])
            {
            }
            column(CostOfSales___3_; "CostOfSales$"[3])
            {
            }
            column(CostOfSales___4_; "CostOfSales$"[4])
            {
            }
            column(CostOfSales___5_; "CostOfSales$"[5])
            {
            }
            column(Profits___1_; "Profits$"[1])
            {
            }
            column(Profits___2_; "Profits$"[2])
            {
            }
            column(Profits___3_; "Profits$"[3])
            {
            }
            column(Profits___4_; "Profits$"[4])
            {
            }
            column(Profits___5_; "Profits$"[5])
            {
            }
            column(Profit___1_; "Profit%"[1])
            {
            }
            column(Profit___2_; "Profit%"[2])
            {
            }
            column(Profit___3_; "Profit%"[3])
            {
            }
            column(Profit___4_; "Profit%"[4])
            {
            }
            column(Profit___5_; "Profit%"[5])
            {
            }
            column(InvoiceDiscounts___1_; "InvoiceDiscounts$"[1])
            {
            }
            column(InvoiceDiscounts___2_; "InvoiceDiscounts$"[2])
            {
            }
            column(InvoiceDiscounts___3_; "InvoiceDiscounts$"[3])
            {
            }
            column(InvoiceDiscounts___4_; "InvoiceDiscounts$"[4])
            {
            }
            column(InvoiceDiscounts___5_; "InvoiceDiscounts$"[5])
            {
            }
            column(PaymentDiscounts___1_; "PaymentDiscounts$"[1])
            {
            }
            column(PaymentDiscounts___2_; "PaymentDiscounts$"[2])
            {
            }
            column(PaymentDiscounts___3_; "PaymentDiscounts$"[3])
            {
            }
            column(PaymentDiscounts___4_; "PaymentDiscounts$"[4])
            {
            }
            column(PaymentDiscounts___5_; "PaymentDiscounts$"[5])
            {
            }
            column(Payments___1_; "Payments$"[1])
            {
            }
            column(Payments___2_; "Payments$"[2])
            {
            }
            column(Payments___3_; "Payments$"[3])
            {
            }
            column(Payments___4_; "Payments$"[4])
            {
            }
            column(Payments___5_; "Payments$"[5])
            {
            }
            column(FinanceCharges___1_; "FinanceCharges$"[1])
            {
            }
            column(FinanceCharges___2_; "FinanceCharges$"[2])
            {
            }
            column(FinanceCharges___3_; "FinanceCharges$"[3])
            {
            }
            column(FinanceCharges___4_; "FinanceCharges$"[4])
            {
            }
            column(FinanceCharges___5_; "FinanceCharges$"[5])
            {
            }
            column(Sales___1__Control71; "Sales$"[1])
            {
            }
            column(Sales___2__Control72; "Sales$"[2])
            {
            }
            column(Sales___3__Control73; "Sales$"[3])
            {
            }
            column(Sales___4__Control74; "Sales$"[4])
            {
            }
            column(Sales___5__Control75; "Sales$"[5])
            {
            }
            column(CostOfSales___1__Control77; "CostOfSales$"[1])
            {
            }
            column(CostOfSales___2__Control78; "CostOfSales$"[2])
            {
            }
            column(CostOfSales___3__Control79; "CostOfSales$"[3])
            {
            }
            column(CostOfSales___4__Control80; "CostOfSales$"[4])
            {
            }
            column(CostOfSales___5__Control81; "CostOfSales$"[5])
            {
            }
            column(Profits___1__Control83; "Profits$"[1])
            {
            }
            column(Profits___2__Control84; "Profits$"[2])
            {
            }
            column(Profits___3__Control85; "Profits$"[3])
            {
            }
            column(Profits___4__Control86; "Profits$"[4])
            {
            }
            column(Profits___5__Control87; "Profits$"[5])
            {
            }
            column(Profit___1__Control89; "Profit%"[1])
            {
            }
            column(Profit___2__Control90; "Profit%"[2])
            {
            }
            column(Profit___3__Control91; "Profit%"[3])
            {
            }
            column(Profit___4__Control92; "Profit%"[4])
            {
            }
            column(Profit___5__Control93; "Profit%"[5])
            {
            }
            column(InvoiceDiscounts___1__Control95; "InvoiceDiscounts$"[1])
            {
            }
            column(InvoiceDiscounts___2__Control96; "InvoiceDiscounts$"[2])
            {
            }
            column(InvoiceDiscounts___3__Control97; "InvoiceDiscounts$"[3])
            {
            }
            column(InvoiceDiscounts___4__Control98; "InvoiceDiscounts$"[4])
            {
            }
            column(InvoiceDiscounts___5__Control99; "InvoiceDiscounts$"[5])
            {
            }
            column(PaymentDiscounts___1__Control101; "PaymentDiscounts$"[1])
            {
            }
            column(PaymentDiscounts___2__Control102; "PaymentDiscounts$"[2])
            {
            }
            column(PaymentDiscounts___3__Control103; "PaymentDiscounts$"[3])
            {
            }
            column(PaymentDiscounts___4__Control104; "PaymentDiscounts$"[4])
            {
            }
            column(PaymentDiscounts___5__Control105; "PaymentDiscounts$"[5])
            {
            }
            column(Payments___1__Control107; "Payments$"[1])
            {
            }
            column(Payments___2__Control108; "Payments$"[2])
            {
            }
            column(Payments___3__Control109; "Payments$"[3])
            {
            }
            column(Payments___4__Control110; "Payments$"[4])
            {
            }
            column(Payments___5__Control111; "Payments$"[5])
            {
            }
            column(FinanceCharges___1__Control113; "FinanceCharges$"[1])
            {
            }
            column(FinanceCharges___2__Control114; "FinanceCharges$"[2])
            {
            }
            column(FinanceCharges___3__Control115; "FinanceCharges$"[3])
            {
            }
            column(FinanceCharges___4__Control116; "FinanceCharges$"[4])
            {
            }
            column(FinanceCharges___5__Control117; "FinanceCharges$"[5])
            {
            }
            column(Customer_Sales_StatisticsCaption; Customer_Sales_StatisticsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(BeforeCaption; BeforeCaptionLbl)
            {
            }
            column(AfterCaption; AfterCaptionLbl)
            {
            }
            column(Customer__No__Caption; Customer__No__CaptionLbl)
            {
            }
            column(Customer_NameCaption; FIELDCAPTION(Name))
            {
            }
            column(SalesCaption; SalesCaptionLbl)
            {
            }
            column(Cost_of_SalesCaption; Cost_of_SalesCaptionLbl)
            {
            }
            column(Contrib__MarginCaption; Contrib__MarginCaptionLbl)
            {
            }
            column(Contrib__Ratio__Caption; Contrib__Ratio__CaptionLbl)
            {
            }
            column(Invoice_DiscountCaption; Invoice_DiscountCaptionLbl)
            {
            }
            column(Payment_DiscountCaption; Payment_DiscountCaptionLbl)
            {
            }
            column(PaymentsCaption; PaymentsCaptionLbl)
            {
            }
            column(Finance_ChargesCaption; Finance_ChargesCaptionLbl)
            {
            }
            column(Report_TotalCaption; Report_TotalCaptionLbl)
            {
            }
            column(Cost_of_SalesCaption_Control82; Cost_of_SalesCaption_Control82Lbl)
            {
            }
            column(Contrib__MarginCaption_Control88; Contrib__MarginCaption_Control88Lbl)
            {
            }
            column(Contrib__Ratio__Caption_Control94; Contrib__Ratio__Caption_Control94Lbl)
            {
            }
            column(Invoice_DiscountCaption_Control100; Invoice_DiscountCaption_Control100Lbl)
            {
            }
            column(Payment_DiscountCaption_Control106; Payment_DiscountCaption_Control106Lbl)
            {
            }
            column(PaymentsCaption_Control112; PaymentsCaption_Control112Lbl)
            {
            }
            column(Finance_ChargesCaption_Control118; Finance_ChargesCaption_Control118Lbl)
            {
            }
            column(SalesCaption_Control1; SalesCaption_Control1Lbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //>> NF1.00:CIS.NU 08-07-15
                Cust2.GET(Customer."No.");
                //<< NF1.00:CIS.NU 08-07-15
                FOR i := 1 TO 5 DO BEGIN
                    SETRANGE("Date Filter", PeriodStartingDate[i], PeriodStartingDate[i + 1] - 1);
                    CALCFIELDS("Sales (LCY)", "Profit (LCY)", "Inv. Discounts (LCY)", "Pmt. Discounts (LCY)",
                      "Fin. Charge Memo Amounts (LCY)", "Payments (LCY)");
                    "Sales$"[i] := "Sales (LCY)";
                    //SM 001 Changes made on 8/16/17
                    "Profits$"[i] := "Profit (LCY)"; // + CostCalcMgt.CalcCustAdjmtCostLCY(Customer);

                    "CostOfSales$"[i] := "Sales$"[i] - "Profits$"[i];
                    IF "Sales$"[i] > 0 THEN
                        "Profit%"[i] := ROUND("Profits$"[i] / "Sales$"[i] * 100, 0.1)
                    ELSE
                        "Profit%"[i] := 0;
                    "InvoiceDiscounts$"[i] := "Inv. Discounts (LCY)";
                    "PaymentDiscounts$"[i] := "Pmt. Discounts (LCY)";
                    "Payments$"[i] := "Payments (LCY)";
                    "FinanceCharges$"[i] := "Fin. Charge Memo Amounts (LCY)";
                END;
                //>>NIF 090407 RTT
                //<<NIF 090407 RTT

                SETRANGE("Date Filter");
            end;

            trigger OnPreDataItem()
            begin
                // CurrReport.CREATETOTALS("Sales$", "Profits$", "InvoiceDiscounts$", "PaymentDiscounts$",
                //   "CostOfSales$", "Payments$", "FinanceCharges$");
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
                    field(PeriodStartingDate; PeriodStartingDate[2])
                    {
                        Caption = 'Start Date';
                    }
                    field(LengthOfPeriods; PeriodLength)
                    {
                        Caption = 'Length of Periods';
                        //DateFormula = true;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IF PeriodStartingDate[2] = 0D THEN
                PeriodStartingDate[2] := WORKDATE();
            IF FORMAT(PeriodLength) = '' THEN
                EVALUATE(PeriodLength, '<1M>');
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        IF FORMAT(PeriodLength) = '' THEN
            EVALUATE(PeriodLength, '<1M>');
        PeriodStartingDate[1] := 0D;
        FOR i := 2 TO 4 DO
            PeriodStartingDate[i + 1] := CALCDATE(PeriodLength, PeriodStartingDate[i]);
        PeriodStartingDate[6] := 99991231D;
        CompanyInformation.GET();
        FilterString := Customer.GETFILTERS;
    end;

    var
        CompanyInformation: Record "Company Information";
        Cust2: Record Customer;
        PeriodLength: DateFormula;
        PeriodStartingDate: array[6] of Date;
        "CostOfSales$": array[5] of Decimal;
        "FinanceCharges$": array[5] of Decimal;
        "InvoiceDiscounts$": array[5] of Decimal;
        "PaymentDiscounts$": array[5] of Decimal;
        "Payments$": array[5] of Decimal;
        "Profit%": array[5] of Decimal;
        "Profits$": array[5] of Decimal;
        "Sales$": array[5] of Decimal;
        i: Integer;
        AfterCaptionLbl: Label 'After';
        BeforeCaptionLbl: Label 'Before';
        Contrib__MarginCaption_Control88Lbl: Label 'Contrib. Margin';
        Contrib__MarginCaptionLbl: Label 'Contrib. Margin';
        Contrib__Ratio__Caption_Control94Lbl: Label 'Contrib. Ratio %';
        Contrib__Ratio__CaptionLbl: Label 'Contrib. Ratio %';
        Cost_of_SalesCaption_Control82Lbl: Label 'Cost of Sales';
        Cost_of_SalesCaptionLbl: Label 'Cost of Sales';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Customer__No__CaptionLbl: Label 'Customer';
        Customer_Sales_StatisticsCaptionLbl: Label 'Customer Sales Statistics';
        Finance_ChargesCaption_Control118Lbl: Label 'Finance Charges';
        Finance_ChargesCaptionLbl: Label 'Finance Charges';
        Invoice_DiscountCaption_Control100Lbl: Label 'Invoice Discount';
        Invoice_DiscountCaptionLbl: Label 'Invoice Discount';
        Payment_DiscountCaption_Control106Lbl: Label 'Payment Discount';
        Payment_DiscountCaptionLbl: Label 'Payment Discount';
        PaymentsCaption_Control112Lbl: Label 'Payments';
        PaymentsCaptionLbl: Label 'Payments';
        Report_TotalCaptionLbl: Label 'Report Total';
        SalesCaption_Control1Lbl: Label 'Sales';
        SalesCaptionLbl: Label 'Sales';
        FilterString: Text;
}

