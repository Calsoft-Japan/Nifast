report 50002 "Daily Invoicing Report New"
{
    // NF1.00:CIS.NG  08-07-15 Merged during upgrade
    DefaultLayout = RDLC;
    RDLCLayout = '.\RDLC\DailyInvoicingReport.rdlc';

    Caption = 'Daily Invoicing Report New';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Currency; Currency)
        {
            DataItemTableView = SORTING(Code);

            trigger OnAfterGetRecord()
            begin
                TempCurrency := Currency;
                TempCurrency.INSERT;
            end;

            trigger OnPreDataItem()
            begin
                IF UseCurrency THEN BEGIN
                    CLEAR(TempCurrency);
                    TempCurrency.INSERT;
                END ELSE
                    CurrReport.BREAK;
            end;
        }
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = SORTING(Number);
            PrintOnlyIfDetail = true;
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
            column(IncludeInvoices; IncludeInvoices)
            {
            }
            column(IncludeCreditMemos; IncludeCreditMemos)
            {
            }
            column(FilterString; FilterString)
            {
            }
            column(TempCurrency_TABLENAME__________TempCurrency_Code; TempCurrency.TABLENAME + ': ' + TempCurrency.Code)
            {
            }
            column(TempCurrency_Description; TempCurrency.Description)
            {
            }
            column(TempCurrency_Code_Control1020000; TempCurrency.Code)
            {
            }
            column(UseCurrency; UseCurrency)
            {
            }
            column(Integer_Number; Number)
            {
            }
            column(Daily_Invoicing_ReportCaption; Daily_Invoicing_ReportCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            dataitem("Sales Invoice Header"; "Sales Invoice Header")
            {
                CalcFields = Amount;
                DataItemTableView = SORTING("No.");
                RequestFilterFields = "Posting Date", "Bill-to Customer No.", "Salesperson Code", "Payment Terms Code";
                RequestFilterHeading = 'Sales Invoice';
                column(Sales_Invoice_Header__No__; "No.")
                {
                }
                column(Sales_Invoice_Header__Posting_Date_; FORMAT("Posting Date"))
                {
                }
                column(Sales_Invoice_Header__Bill_to_Customer_No__; "Bill-to Customer No.")
                {
                }
                column(Sales_Invoice_Header__Bill_to_Name_; "Bill-to Name")
                {
                }
                column(Sales_Invoice_Header__Payment_Terms_Code_; "Payment Terms Code")
                {
                }
                column(Sales_Invoice_Header__Salesperson_Code_; "Salesperson Code")
                {
                }
                column(Sales_Invoice_Header_Amount; Amount)
                {
                }
                column(SalesTax; SalesTax)
                {
                }
                column(Sales_Invoice_Header__Amount_Including_VAT_; "Amount Including VAT")
                {
                }
                column(Sales_Invoice_Header_Amount_Control49; Amount)
                {
                }
                column(Sales_Invoice_Header__Amount; "Sales Invoice Header".Amount)
                {
                }
                column(Sales_Invoice_Header___No__; "Sales Invoice Header"."No.")
                {
                }
                column(Sales_Invoice_Header___Posting_Date_; "Sales Invoice Header"."Posting Date")
                {
                }
                column(Sales_Invoice_Header___Bill_to_Customer_No__; "Sales Invoice Header"."Bill-to Customer No.")
                {
                }
                column(Sales_Invoice_Header___Bill_to_Name_; "Sales Invoice Header"."Bill-to Name")
                {
                }
                column(SalesTax_Control50; SalesTax)
                {
                }
                column(Sales_Invoice_Header__Amount_Including_VAT__Control51; "Amount Including VAT")
                {
                }
                column(TempCurrency_Code; TempCurrency.Code)
                {
                }
                column(TotalSalesInvHdrAmt; TotalSalesInvHdrAmt)
                {
                }
                column(Sales_Invoice_Header__No__Caption; Sales_Invoice_Header__No__CaptionLbl)
                {
                }
                column(Sales_Invoice_Header__Posting_Date_Caption; Sales_Invoice_Header__Posting_Date_CaptionLbl)
                {
                }
                column(Sales_Invoice_Header__Bill_to_Customer_No__Caption; FIELDCAPTION("Bill-to Customer No."))
                {
                }
                column(Sales_Invoice_Header__Bill_to_Name_Caption; FIELDCAPTION("Bill-to Name"))
                {
                }
                column(Sales_Invoice_Header__Payment_Terms_Code_Caption; FIELDCAPTION("Payment Terms Code"))
                {
                }
                column(Sales_Invoice_Header__Salesperson_Code_Caption; FIELDCAPTION("Salesperson Code"))
                {
                }
                column(Sales_Invoice_Header_AmountCaption; FIELDCAPTION(Amount))
                {
                }
                column(SalesTaxCaption; SalesTaxCaptionLbl)
                {
                }
                column(Sales_Invoice_Header__Amount_Including_VAT_Caption; FIELDCAPTION("Amount Including VAT"))
                {
                }
                column(Total_of_all_InvoicesCaption; Total_of_all_InvoicesCaptionLbl)
                {
                }
                dataitem("Value Entry"; "Value Entry")
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemTableView = SORTING("Document No.", "Posting Date");
                    column(Value_Entry__Cost_Amount__Actual__; "Cost Amount (Actual)")
                    {
                    }
                    column(Sales_Invoice_Line___No__; "Sales Invoice Line"."No.")
                    {
                    }
                    column(GPD; GPD)
                    {
                    }
                    column(GPP; GPP)
                    {
                        DecimalPlaces = 2 : 2;
                    }
                    column(Value_Entry_Entry_No_; "Entry No.")
                    {
                    }
                    column(Value_Entry_Document_No_; "Document No.")
                    {
                    }

                    trigger OnPreDataItem()
                    begin
                        CurrReport.CREATETOTALS("Cost Amount (Actual)");
                    end;
                }
                dataitem("Sales Invoice Line"; "Sales Invoice Line")
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemTableView = SORTING("Document No.", "Line No.")
                                        WHERE(Type = FILTER(Resource));
                    column(Sales_Invoice_Line__No__; "No.")
                    {
                    }
                    column(Sales_Invoice_Line_Document_No_; "Document No.")
                    {
                    }
                    column(Sales_Invoice_Line_Line_No_; "Line No.")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    IF IncludeInvoices THEN BEGIN
                        CALCFIELDS(Amount, "Amount Including VAT");
                        SalesTax := "Amount Including VAT" - Amount;
                        TotalAmtExclTax := TotalAmtExclTax + Amount;
                        TotalSalesTax := TotalSalesTax + SalesTax;
                        TotalAmtInclTax := TotalAmtInclTax + "Amount Including VAT";
                        //>> NF1.00:CIS.NG 08-07-15
                        TotalSalesInvHdrAmt += "Sales Invoice Header".Amount;
                        TotalSalesInvHdrSalesTax += SalesTax;
                        //<< NF1.00:CIS.NG 08-07-15
                    END ELSE
                        CurrReport.BREAK;
                end;

                trigger OnPreDataItem()
                begin
                    CurrReport.CREATETOTALS("Value Entry"."Cost Amount (Actual)");

                    IF IncludeInvoices THEN
                        CurrReport.CREATETOTALS(Amount, "Amount Including VAT", SalesTax)
                    ELSE
                        CurrReport.BREAK;

                    IF UseCurrency THEN
                        SETRANGE("Currency Code", TempCurrency.Code);


                    "Value Entry".SETCURRENTKEY("Document No.", "Posting Date");
                    "Value Entry".SETRANGE("Document No.", "No.");
                    //"Value Entry".SETRANGE("Document No.");
                    //"Value Entry".SETRANGE("Posting Date");

                    "Value Entry".CALCSUMS("Cost Amount (Actual)");
                    CostAmount := "Value Entry"."Cost Amount (Actual)";
                    //>> NF1.00:CIS.NG 08-07-15
                    TotalSalesInvHdrAmt := 0;
                    TotalSalesInvHdrSalesTax := 0;
                    //<< NF1.00:CIS.NG 08-07-15
                end;
            }
            dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
            {
                DataItemTableView = SORTING("No.");
                column(Sales_Cr_Memo_Header__No__; "No.")
                {
                }
                column(Sales_Cr_Memo_Header__Posting_Date_; "Posting Date")
                {
                }
                column(Sales_Cr_Memo_Header__Bill_to_Customer_No__; "Bill-to Customer No.")
                {
                }
                column(Sales_Cr_Memo_Header__Bill_to_Name_; "Bill-to Name")
                {
                }
                column(Sales_Cr_Memo_Header__Applies_to_Doc__No__; "Applies-to Doc. No.")
                {
                }
                column(Sales_Cr_Memo_Header__Salesperson_Code_; "Salesperson Code")
                {
                }
                column(Sales_Cr_Memo_Header_Amount; Amount)
                {
                }
                column(SalesTax_Control60; SalesTax)
                {
                }
                column(Sales_Cr_Memo_Header__Amount_Including_VAT_; "Amount Including VAT")
                {
                }
                column(Sales_Cr_Memo_Header_Amount_Control62; Amount)
                {
                }
                column(SalesTax_Control63; SalesTax)
                {
                }
                column(Sales_Cr_Memo_Header__Amount_Including_VAT__Control64; "Amount Including VAT")
                {
                }
                column(TempCurrency_Code_Control4; TempCurrency.Code)
                {
                }
                column(TotalAmtExclTax; TotalAmtExclTax)
                {
                }
                column(TotalSalesTax; TotalSalesTax)
                {
                }
                column(TotalAmtInclTax; TotalAmtInclTax)
                {
                }
                column(TempCurrency_Code_Control5; TempCurrency.Code)
                {
                }
                column(Sales_Cr_Memo_Header__No__Caption; Sales_Cr_Memo_Header__No__CaptionLbl)
                {
                }
                column(Cr__Memo_DateCaption; Cr__Memo_DateCaptionLbl)
                {
                }
                column(Sales_Cr_Memo_Header__Bill_to_Customer_No__Caption; FIELDCAPTION("Bill-to Customer No."))
                {
                }
                column(Sales_Cr_Memo_Header__Bill_to_Name_Caption; FIELDCAPTION("Bill-to Name"))
                {
                }
                column(Sales_Cr_Memo_Header__Applies_to_Doc__No__Caption; FIELDCAPTION("Applies-to Doc. No."))
                {
                }
                column(Sales_Cr_Memo_Header__Salesperson_Code_Caption; FIELDCAPTION("Salesperson Code"))
                {
                }
                column(Sales_Cr_Memo_Header_AmountCaption; FIELDCAPTION(Amount))
                {
                }
                column(SalesTax_Control60Caption; SalesTax_Control60CaptionLbl)
                {
                }
                column(Sales_Cr_Memo_Header__Amount_Including_VAT_Caption; FIELDCAPTION("Amount Including VAT"))
                {
                }
                column(Total_of_all_Credit_MemosCaption; Total_of_all_Credit_MemosCaptionLbl)
                {
                }
                column(Grand_Total_of_all_Invoices_and_Credit_MemosCaption; Grand_Total_of_all_Invoices_and_Credit_MemosCaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF IncludeCreditMemos THEN BEGIN
                        CALCFIELDS(Amount, "Amount Including VAT");
                        SalesTax := "Amount Including VAT" - Amount;
                        TotalAmtExclTax := TotalAmtExclTax - Amount;
                        TotalSalesTax := TotalSalesTax - SalesTax;
                        TotalAmtInclTax := TotalAmtInclTax - "Amount Including VAT";
                        //>> NF1.00:CIS.NG 08-07-15
                        TotalSalesCrMemoAmt += Amount;
                        TotalSalesCrMemoSalesTax += SalesTax;
                        //<< NF1.00:CIS.NG 08-07-15
                    END ELSE
                        CurrReport.BREAK;
                end;

                trigger OnPreDataItem()
                begin
                    IF IncludeCreditMemos THEN BEGIN
                        IF UseCurrency THEN
                            SETRANGE("Currency Code", TempCurrency.Code);
                        "Sales Invoice Header".COPYFILTER("Posting Date", "Posting Date");
                        "Sales Invoice Header".COPYFILTER("Bill-to Customer No.", "Bill-to Customer No.");
                        "Sales Invoice Header".COPYFILTER("Salesperson Code", "Salesperson Code");
                        "Sales Invoice Header".COPYFILTER("Payment Terms Code", "Payment Terms Code");
                        "Sales Invoice Header".COPYFILTER("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
                        "Sales Invoice Header".COPYFILTER("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
                        "Sales Invoice Header".COPYFILTER("Sell-to Customer No.", "Sell-to Customer No.");
                        "Sales Invoice Header".COPYFILTER("Location Code", "Location Code");
                        "Sales Invoice Header".COPYFILTER("Tax Area Code", "Tax Area Code");
                        "Sales Invoice Header".COPYFILTER("Responsibility Center", "Responsibility Center");
                        CurrReport.CREATETOTALS(Amount, "Amount Including VAT", SalesTax);
                        //>> NF1.00:CIS.NG 08-07-15
                        TotalSalesCrMemoAmt := 0;
                        TotalSalesCrMemoSalesTax := 0;
                        //<< NF1.00:CIS.NG 08-07-15
                    END ELSE
                        CurrReport.BREAK;
                end;
            }
            dataitem(TotalAmount; "Integer")
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                MaxIteration = 1;
                column(TotalNetAmt; TotalSalesInvHdrAmt - TotalSalesCrMemoAmt)
                {
                }
                column(TotalNetSalesTax; TotalSalesInvHdrSalesTax - TotalSalesCrMemoSalesTax)
                {
                }

                trigger OnPreDataItem()
                begin
                    //>> NF1.00:CIS.NG 08-07-15
                    IF TotalSalesInvHdrAmt + TotalSalesCrMemoAmt + TotalSalesInvHdrSalesTax + TotalSalesCrMemoSalesTax = 0 THEN
                        CurrReport.BREAK;
                    //<< NF1.00:CIS.NG 08-07-15
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF UseCurrency THEN BEGIN
                    IF Number = 1 THEN
                        TempCurrency.FIND('-')
                    ELSE
                        TempCurrency.NEXT;
                END;

                TotalAmtExclTax := 0.0;
                TotalSalesTax := 0.0;
                TotalAmtInclTax := 0.0;
                TotalSalesInvHdrAmt := 0;  //NF1.00:CIS.NG 08-07-15
            end;

            trigger OnPreDataItem()
            begin
                IF UseCurrency THEN
                    SETRANGE(Number, 1, TempCurrency.COUNT)
                ELSE BEGIN
                    SETRANGE(Number, 1);
                    CLEAR(TempCurrency);
                END;
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
                    field(IncludeInvoices; IncludeInvoices)
                    {
                        Caption = 'Include Invoices';
                        ApplicationArea = All;
                    }
                    field(IncludeCreditMemos; IncludeCreditMemos)
                    {
                        Caption = 'Include Credit Memos';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IncludeInvoices := TRUE;
            IncludeCreditMemos := FALSE;
        end;
    }

    labels
    {
        SalesAmountLbl = 'Sales Amount';
        ResourcesLbl = 'Resources';
        CostLbl = 'Cost';
        GPSalesCostLbl = 'GP$ (Sales-Cost)';
        GPPecLbl = 'GP %';
        GrandTotalLbl = 'Grand Total of all Invoices and Credit Memos';
    }

    trigger OnPreReport()
    begin
        IF NOT (IncludeInvoices OR IncludeCreditMemos) THEN
            ERROR(Text000);

        CompanyInformation.GET;
        FilterString := "Sales Invoice Header".GETFILTERS;
        UseCurrency := Currency.FIND('-');
    end;

    var
        CompanyInformation: Record 79;
        TempCurrency: Record 4 temporary;
        FilterString: Text;
        SalesTax: Decimal;
        IncludeInvoices: Boolean;
        IncludeCreditMemos: Boolean;
        UseCurrency: Boolean;
        TotalAmtExclTax: Decimal;
        TotalSalesTax: Decimal;
        TotalAmtInclTax: Decimal;
        Text000: Label 'You must Include either Invoices or Credit Memos.';
        Daily_Invoicing_ReportCaptionLbl: Label 'Daily Invoicing Report';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Sales_Invoice_Header__No__CaptionLbl: Label 'Invoice Number';
        Sales_Invoice_Header__Posting_Date_CaptionLbl: Label 'Invoice Date';
        SalesTaxCaptionLbl: Label 'Sales Tax';
        Total_of_all_InvoicesCaptionLbl: Label 'Total of all Invoices';
        Sales_Cr_Memo_Header__No__CaptionLbl: Label 'Cr. Memo Number';
        Cr__Memo_DateCaptionLbl: Label 'Cr. Memo Date';
        SalesTax_Control60CaptionLbl: Label 'Sales Tax';
        Total_of_all_Credit_MemosCaptionLbl: Label 'Total of all Credit Memos';
        Grand_Total_of_all_Invoices_and_Credit_MemosCaptionLbl: Label 'Grand Total of all Invoices and Credit Memos';
        CostAmount: Decimal;
        GPD: Decimal;
        GPP: Decimal;
        GPDtotal: Decimal;
        GPPtotal: Decimal;
        TotalSalesInvHdrAmt: Decimal;
        TotalSalesCrMemoAmt: Decimal;
        TotalSalesInvHdrSalesTax: Decimal;
        TotalSalesCrMemoSalesTax: Decimal;
}

