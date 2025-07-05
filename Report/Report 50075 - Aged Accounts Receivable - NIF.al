report 50075 "Aged Accounts Receivable - NIF"
{
    // NF1.00:CIS.NG  09-15-15 Merged during upgrade
    // NF1.00:CIS.NG  08-04-16 Adjust Layout to Increase Report Margin from Left Side
    // >> NIF
    // extended no. of columns by 1
    // - array size from 4->5: AmountDue,"BalanceDue$", ColumnHead, PercentString
    // - array size from 5->6: PeriodEndingDate
    // - at fcn CalcPct, changed array size from 4 to 5 for Amounts
    // Left Margin from 2100 to 250
    // Code at CalcPercents to extend FOR statement from 4 to 5
    // Code at Customer, Header(1) to adjust column headings
    // Code at Customer, Footer (9) to include newly added column 5 in total
    // 
    // Add variable length buckets
    // - changed PeriodCalculation from non-array to array of dim 5
    // - code at Report-OnPreReport
    // - code at Request Form (Report-OnOpenForm)
    // CIS002 - CIS.RAM 01/15/2020 Added code to print credit limit in Reporting Currency
    // 
    // SM 03-03-20 Added two more brackets
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = '.\RDLC\Aged Accounts Receivable - NIF.rdlc';

    Caption = 'Aged Accounts Receivable - NIF';

    dataset
    {
        dataitem(Customer; Customer)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Customer Posting Group", "Payment Terms Code", "Salesperson Code";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(TIME; TIME)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CurrReport_PAGENO; 1)//CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(SubTitle; SubTitle)
            {
            }
            column(DateTitle; DateTitle)
            {
            }
            column(Customer_TABLECAPTION__________FilterString; Customer.TABLECAPTION + ': ' + FilterString)
            {
            }
            column(ColumnHeadHead; ColumnHeadHead)
            {
            }
            column(ColumnHead_1_; ColumnHead[1])
            {
            }
            column(ColumnHead_2_; ColumnHead[2])
            {
            }
            column(ColumnHead_3_; ColumnHead[3])
            {
            }
            column(ColumnHead_4_; ColumnHead[4])
            {
            }
            column(ColumnHead_5_; ColumnHead[5])
            {
            }
            column(PrintDetail; PrintDetail)
            {
            }
            column(PrintToExcel; PrintToExcel)
            {
            }
            column(PrintAmountsInLocal; PrintAmountsInLocal)
            {
            }
            column(ShowAllForOverdue; ShowAllForOverdue)
            {
            }
            column(FilterString; FilterString)
            {
            }
            column(ColumnHeadHead_Control21; ColumnHeadHead)
            {
            }
            column(ShortDateTitle; ShortDateTitle)
            {
            }
            column(ColumnHead_1__Control26; ColumnHead[1])
            {
            }
            column(ColumnHead_2__Control27; ColumnHead[2])
            {
            }
            column(ColumnHead_3__Control28; ColumnHead[3])
            {
            }
            column(ColumnHead_4__Control29; ColumnHead[4])
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
            column(BlockedDescription; BlockedDescription)
            {
            }
            column(OverLimitDescription; OverLimitDescription)
            {
            }
            column(TotalBalanceDue__; "TotalBalanceDue$")
            {
            }
            column(BalanceDue___1_; "BalanceDue$"[1])
            {
            }
            column(BalanceDue___2_; "BalanceDue$"[2])
            {
            }
            column(BalanceDue___3_; "BalanceDue$"[3])
            {
            }
            column(BalanceDue___4_; "BalanceDue$"[4])
            {
            }
            column(PercentString_1_; PercentString[1])
            {
            }
            column(PercentString_2_; PercentString[2])
            {
            }
            column(PercentString_3_; PercentString[3])
            {
            }
            column(PercentString_4_; PercentString[4])
            {
            }
            column(TotalBalanceDue___Control30; "TotalBalanceDue$")
            {
            }
            column(BalanceDue___1__Control48; "BalanceDue$"[1])
            {
            }
            column(BalanceDue___2__Control94; "BalanceDue$"[2])
            {
            }
            column(PercentString_1__Control95; PercentString[1])
            {
            }
            column(PercentString_2__Control96; PercentString[2])
            {
            }
            column(BalanceDue___3__Control97; "BalanceDue$"[3])
            {
            }
            column(PercentString_3__Control98; PercentString[3])
            {
            }
            column(BalanceDue___4__Control99; "BalanceDue$"[4])
            {
            }
            column(BalanceDue___5; "BalanceDue$"[5])
            {
            }
            column(PercentString_4__Control100; PercentString[4])
            {
            }
            column(Customer_Global_Dimension_2_Filter; "Global Dimension 2 Filter")
            {
            }
            column(Customer_Global_Dimension_1_Filter; "Global Dimension 1 Filter")
            {
            }
            column(PaymentTermsCode_Customer; "Payment Terms Code")
            {
            }
            column(DueDateCalculation_Customer; "Due Date Calculation")
            {
            }
            column(FilterString2; FilterString2)
            {
            }
            column(Aged_Accounts_ReceivableCaption; Aged_Accounts_ReceivableCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Aged_byCaption; Aged_byCaptionLbl)
            {
            }
            column(Control11Caption; CAPTIONCLASSTRANSLATE('101,1,' + Text021))
            {
            }
            column(Customer__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Customer_NameCaption; FIELDCAPTION(Name))
            {
            }
            column(AmountDueToPrint_Control74Caption; AmountDueToPrint_Control74CaptionLbl)
            {
            }
            column(Credit_LimitCaption; Credit_LimitCaptionLbl)
            {
            }
            column(Customer__No__Caption_Control22; FIELDCAPTION("No."))
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Cust__Ledger_Entry___Document_No__Caption; Cust__Ledger_Entry___Document_No__CaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__DescriptionCaption; Cust__Ledger_Entry__DescriptionCaptionLbl)
            {
            }
            column(Cust__Ledger_Entry___Document_Type_Caption; Cust__Ledger_Entry___Document_Type_CaptionLbl)
            {
            }
            column(AmountDueToPrint_Control63Caption; AmountDueToPrint_Control63CaptionLbl)
            {
            }
            column(Cust__Ledger_Entry___Currency_Code_Caption; Cust__Ledger_Entry___Currency_Code_CaptionLbl)
            {
            }
            column(DocumentCaption; DocumentCaptionLbl)
            {
            }
            column(Customer__Phone_No__Caption; FIELDCAPTION("Phone No."))
            {
            }
            column(Customer_ContactCaption; FIELDCAPTION(Contact))
            {
            }
            column(Control1020000Caption; CAPTIONCLASSTRANSLATE(GetCurrencyCaptionCode("Currency Code")))
            {
            }
            column(Control47Caption; CAPTIONCLASSTRANSLATE('101,0,' + Text022))
            {
            }
            column(Control8Caption; CAPTIONCLASSTRANSLATE('101,0,' + Text022))
            {
            }
            column(GrandTotalBalanceDue_; GrandTotalBalanceDue)
            {
            }
            column(GrandBalanceDue_1_; GrandBalanceDue[1])
            {
            }
            column(GrandBalanceDue_2_; GrandBalanceDue[2])
            {
            }
            column(GrandBalanceDue_3_; GrandBalanceDue[3])
            {
            }
            column(GrandBalanceDue_4_; GrandBalanceDue[4])
            {
            }
            column(GrandBalanceDue_5_; GrandBalanceDue[5])
            {
            }
            column(RemainingAmountARC; "Cust. Ledger Entry"."Remaining Amount")
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD("No."),
                               "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                               "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter");
                DataItemTableView = SORTING("Customer No.", Open, Positive, "Due Date", "Currency Code");
                RequestFilterFields = "Due Date";
                RequestFilterHeading = 'Due Date';

                trigger OnAfterGetRecord()
                begin
                    SETRANGE("Date Filter", 0D, PeriodEndingDate[1]);
                    CALCFIELDS("Remaining Amount");
                    IF "Remaining Amount" <> 0 THEN
                        InsertTemp("Cust. Ledger Entry");
                    CurrReport.SKIP;    // this fools the system into thinking that no details "printed"...yet
                end;

                trigger OnPreDataItem()
                begin
                    // Find ledger entries which are posted before the date of the aging
                    SETRANGE("Posting Date", 0D, PeriodEndingDate[1]);

                    IF (FORMAT(ShowOnlyOverDueBy) <> '') AND NOT ShowAllForOverdue THEN
                        SETRANGE("Due Date", 0D, CalculatedDate);
                end;
            }
            dataitem(Totals; Integer)
            {
                DataItemTableView = SORTING(Number);
                column(AmountDueToPrint; AmountDueToPrint)
                {
                }
                column(AmountDue_1_; AmountDue[1])
                {
                }
                column(AmountDue_2_; AmountDue[2])
                {
                }
                column(AmountDue_3_; AmountDue[3])
                {
                }
                column(AmountDue_4_; AmountDue[4])
                {
                }
                column(AmountDue_5_; AmountDue[5])
                {
                }
                column(AgingDate; FORMAT(AgingDate))
                {
                }
                column(Cust__Ledger_Entry__Description; "Cust. Ledger Entry".Description)
                {
                }
                column(Cust__Ledger_Entry___Document_Type_; "Cust. Ledger Entry"."Document Type")
                {
                }
                column(Cust__Ledger_Entry___Document_No__; "Cust. Ledger Entry"."Document No.")
                {
                }
                column(AmountDueToPrint_Control63; AmountDueToPrint)
                {
                }
                column(AmountDue_1__Control64; AmountDue[1])
                {
                }
                column(AmountDue_2__Control65; AmountDue[2])
                {
                }
                column(AmountDue_3__Control66; AmountDue[3])
                {
                }
                column(AmountDue_4__Control67; AmountDue[4])
                {
                }
                column(Cust__Ledger_Entry___Currency_Code_; "Cust. Ledger Entry"."Currency Code")
                {
                }
                column(AmountDueToPrint_Control68; AmountDueToPrint)
                {
                }
                column(AmountDue_1__Control69; AmountDue[1])
                {
                }
                column(AmountDue_2__Control70; AmountDue[2])
                {
                }
                column(AmountDue_3__Control71; AmountDue[3])
                {
                }
                column(AmountDue_4__Control72; AmountDue[4])
                {
                }
                column(AmountDueToPrint_Control74; AmountDueToPrint)
                {
                }
                column(AmountDue_1__Control75; AmountDue[1])
                {
                }
                column(AmountDue_2__Control76; AmountDue[2])
                {
                }
                column(AmountDue_3__Control77; AmountDue[3])
                {
                }
                column(AmountDue_4__Control78; AmountDue[4])
                {
                }
                column(CreditLimitToPrint; CreditLimitToPrint)
                {
                }
                column(PercentString_1__Control4; PercentString[1])
                {
                }
                column(PercentString_2__Control5; PercentString[2])
                {
                }
                column(PercentString_3__Control6; PercentString[3])
                {
                }
                column(PercentString_4__Control7; PercentString[4])
                {
                }
                column(PercentString_5; PercentString[5])
                {
                }
                column(Customer__No___Control80; Customer."No.")
                {
                }
                column(AmountDueToPrint_Control81; AmountDueToPrint)
                {
                }
                column(AmountDue_1__Control82; AmountDue[1])
                {
                }
                column(AmountDue_2__Control83; AmountDue[2])
                {
                }
                column(AmountDue_3__Control84; AmountDue[3])
                {
                }
                column(AmountDue_4__Control85; AmountDue[4])
                {
                }
                column(CreditLimitToPrint_Control88; CreditLimitToPrint)
                {
                }
                column(PercentString_1__Control89; PercentString[1])
                {
                }
                column(PercentString_2__Control90; PercentString[2])
                {
                }
                column(PercentString_3__Control91; PercentString[3])
                {
                }
                column(PercentString_4__Control92; PercentString[4])
                {
                }
                column(Totals_Number; Number)
                {
                }
                column(Balance_ForwardCaption; Balance_ForwardCaptionLbl)
                {
                }
                column(Balance_to_Carry_ForwardCaption; Balance_to_Carry_ForwardCaptionLbl)
                {
                }
                column(Total_Amount_DueCaption; Total_Amount_DueCaptionLbl)
                {
                }
                column(Total_Amount_DueCaption_Control86; Total_Amount_DueCaption_Control86Lbl)
                {
                }
                column(Credit_Limit_Caption; Credit_Limit_CaptionLbl)
                {
                }
                column(Control1020001Caption; CAPTIONCLASSTRANSLATE(GetCurrencyCaptionCode(Customer."Currency Code")))
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CalcPercents(AmountDueToPrint, AmountDue);

                    IF Number = 1 THEN
                        TempCustLedgEntry.FIND('-')
                    ELSE
                        TempCustLedgEntry.NEXT;
                    TempCustLedgEntry.SETRANGE("Date Filter", 0D, PeriodEndingDate[1]);
                    TempCustLedgEntry.CALCFIELDS("Remaining Amount", "Remaining Amt. (LCY)");

                    IF TempCustLedgEntry."Remaining Amount" = 0 THEN
                        CurrReport.SKIP;
                    IF NOT ShowARC THEN BEGIN //>>CSI.RAM
                        IF TempCustLedgEntry."Currency Code" <> '' THEN
                            TempCustLedgEntry."Remaining Amt. (LCY)" :=
                              ROUND(
                                CurrExchRate.ExchangeAmtFCYToFCY(
                                  PeriodEndingDate[1],
                                  TempCustLedgEntry."Currency Code",
                                  '',
                                  TempCustLedgEntry."Remaining Amount"));
                        IF PrintAmountsInLocal THEN BEGIN
                            TempCustLedgEntry."Remaining Amount" :=
                              ROUND(
                                CurrExchRate.ExchangeAmtFCYToFCY(
                                  PeriodEndingDate[1],
                                  TempCustLedgEntry."Currency Code",
                                  Customer."Currency Code",
                                  TempCustLedgEntry."Remaining Amount"),
                                Currency."Amount Rounding Precision");
                            AmountDueToPrint := TempCustLedgEntry."Remaining Amount";
                        END ELSE
                            AmountDueToPrint := TempCustLedgEntry."Remaining Amt. (LCY)";
                        //>>CSI.RAM 02/07/2018
                    END ELSE BEGIN
                        IF ShowARC THEN BEGIN
                            TempCustLedgEntry.CALCFIELDS("Remaining Amt. (LCY)");
                            //MESSAGE('1-%1\%2',TempCustLedgEntry."Remaining Amount",TempCustLedgEntry."Remaining Amt. (LCY)");
                            IF TempCustLedgEntry."Currency Code" = GLSetup."Additional Reporting Currency" THEN
                                AmountDueToPrint := TempCustLedgEntry."Remaining Amount"
                            ELSE IF TempCustLedgEntry."Currency Code" = GLSetup."LCY Code" THEN
                                //AmountDueToPrint := ExchangeAmtLCYToFCY(TempCustLedgEntry."Posting Date",TempCustLedgEntry."Remaining Amount",FALSE)
                                AmountDueToPrint := ExchangeAmtLCYToFCY(PeriodEndingDate[1], TempCustLedgEntry."Remaining Amount", FALSE)
                            ELSE
                                //AmountDueToPrint := ExchangeAmtLCYToFCY(TempCustLedgEntry."Posting Date",TempCustLedgEntry."Remaining Amt. (LCY)",FALSE);
                                AmountDueToPrint := ExchangeAmtLCYToFCY(PeriodEndingDate[1], TempCustLedgEntry."Remaining Amt. (LCY)", FALSE);
                            //MESSAGE('2-%1',TempCustLedgEntry."Remaining Amount");
                        END;
                    END;
                    //SM001 1/26/18
                    //IF ShowARC THEN
                    //  AmountDueToPrint := TempCustLedgEntry."Remaining Amount";
                    //<<CSI.RAM 02/07/2018

                    /*
                        ROUND(
                          CurrExchRate.ExchangeAmtFCYToFCY(
                            PeriodEndingDate[1],
                            TempCustLedgEntry."Currency Code",
                            Customer."Currency Code",
                            TempCustLedgEntry."Remaining Amount"),
                          Currency."Amount Rounding Precision");
                      AmountDueToPrint := TempCustLedgEntry."Remaining Amount";
                    END ELSE
                      AmountDueToPrint := TempCustLedgEntry."Remaining Amt. (LCY)";
                    */
                    //SM001 1/26/18

                    CASE AgingMethod OF
                        AgingMethod::"Due Date":
                            AgingDate := TempCustLedgEntry."Due Date";
                        AgingMethod::"Trans Date":
                            AgingDate := TempCustLedgEntry."Posting Date";
                        AgingMethod::"Document Date":
                            AgingDate := TempCustLedgEntry."Document Date";
                    END;
                    j := 0;
                    //>> NF1.00:CIS.NG 09-15-15
                    //WHILE AgingDate < PeriodEndingDate[j + 1] DO
                    WHILE AgingDate <= PeriodEndingDate[j + 1] DO
                        //>> NF1.00:CIS.NG 09-15-15
                        j := j + 1;
                    IF j = 0 THEN
                        j := 1;

                    AmountDue[j] := AmountDueToPrint;

                    //SM001 1/26/18
                    //"BalanceDue$"[j] := "BalanceDue$"[j] + TempCustLedgEntry."Remaining Amt. (LCY)";
                    //SM001 1/26/18

                    //SM001 1/26/18
                    IF ShowARC THEN
                        "BalanceDue$"[j] := "BalanceDue$"[j] + AmountDueToPrint //TempCustLedgEntry."Remaining Amount"      //CIS.RAM
                    ELSE
                        //SM001 1/26/18
                        "BalanceDue$"[j] := "BalanceDue$"[j] + TempCustLedgEntry."Remaining Amt. (LCY)";


                    CustTotAmountDue[j] := CustTotAmountDue[j] + AmountDueToPrint;
                    CustTotAmountDueToPrint := CustTotAmountDueToPrint + AmountDueToPrint;

                    "TotalBalanceDue$" := 0;
                    //>> NIF 07-05-05 RTT
                    //FOR j := 1 TO 4 DO
                    FOR j := 1 TO 6 DO
                        //<< NIF 07-05-05 RTT
                        "TotalBalanceDue$" := "TotalBalanceDue$" + "BalanceDue$"[j];
                    CalcPercents("TotalBalanceDue$", "BalanceDue$");

                    "Cust. Ledger Entry" := TempCustLedgEntry;

                    // Do NOT use the following fields in the sections:
                    // "Applied-To Doc. Type"
                    // "Applied-To Doc. No."
                    // Open
                    // "Paym. Disc. Taken"
                    // "Closed by Entry No."
                    // "Closed at Date"
                    // "Closed by Amount"

                    TotalNumberOfEntries -= 1;
                    IF TotalNumberOfEntries = 0 THEN BEGIN
                        FOR j := 1 TO 6 DO
                            GrandBalanceDue[j] += "BalanceDue$"[j];
                        GrandTotalBalanceDue += "TotalBalanceDue$";
                    END;

                    IF PrintDetail AND PrintToExcel THEN
                        MakeExcelDataBody;

                end;

                trigger OnPostDataItem()
                begin
                    IF TempCustLedgEntry.COUNT > 0 THEN BEGIN
                        //>> NF1.00:CIS.NG 09-15-15
                        //FOR j := 1 TO 4 DO
                        FOR j := 1 TO 6 DO
                            //<< NF1.00:CIS.NG 09-15-15
                            AmountDue[j] := CustTotAmountDue[j];
                        AmountDueToPrint := CustTotAmountDueToPrint;
                        IF NOT PrintDetail AND PrintToExcel THEN
                            MakeExcelDataBody;

                        //>> NF1.00:CIS.NG 09-15-15
                        IF PrintDetail AND PrintToExcel THEN
                            MakeExcelGroupDataBody;
                        //<< NF1.00:CIS.NG 09-15-15
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    //CurrReport.CREATETOTALS(AmountDueToPrint, AmountDue[1], AmountDue[2], AmountDue[3], AmountDue[4], AmountDue[5], AmountDue[6], AmountDue[7]);//AmountDue BC Upgrade
                    SETRANGE(Number, 1, TempCustLedgEntry.COUNT);
                    TempCustLedgEntry.SETCURRENTKEY("Customer No.", "Posting Date");
                    CLEAR(CustTotAmountDue);
                    CustTotAmountDueToPrint := 0;
                    TotalNumberOfEntries := TempCustLedgEntry.COUNT;
                end;
            }

            trigger OnAfterGetRecord()
            var
                CustLedgEntry: Record "Cust. Ledger Entry";
            begin
                CLEAR("BalanceDue$");
                IF PrintAmountsInLocal THEN BEGIN
                    GetCurrencyRecord(Currency, "Currency Code");
                    CurrencyFactor := CurrExchRate.ExchangeRate(PeriodEndingDate[1], "Currency Code");
                END;

                //SM001 1/26/18
                /*
                IF ShowARC THEN BEGIN
                  GetCurrencyRecord(Currency,"Currency Code");
                  CurrencyFactor := CurrExchRate.ExchangeRate(PeriodEndingDate[1],"Currency Code");
                END;
                */
                //SM001

                IF Blocked <> Blocked::" " THEN
                    BlockedDescription := STRSUBSTNO(Text002, Blocked)
                ELSE
                    BlockedDescription := '';

                IF "Credit Limit (LCY)" = 0 THEN BEGIN
                    CreditLimitToPrint := Text003;
                    OverLimitDescription := '';
                END ELSE BEGIN
                    SETRANGE("Date Filter", 0D, PeriodEndingDate[1]);
                    CALCFIELDS("Net Change (LCY)");
                    IF "Net Change (LCY)" > "Credit Limit (LCY)" THEN
                        OverLimitDescription := Text004
                    ELSE
                        OverLimitDescription := '';
                    IF NOT ShowARC THEN BEGIN //CIS002
                        IF PrintAmountsInLocal AND ("Currency Code" <> '') THEN
                            "Credit Limit (LCY)" :=
                              CurrExchRate.ExchangeAmtLCYToFCY(PeriodEndingDate[1], "Currency Code", "Credit Limit (LCY)", CurrencyFactor);
                        //>>CIS002
                    END ELSE IF ShowARC THEN BEGIN
                        GetCurrencyRecord(Currency, "Currency Code");
                        "Credit Limit (LCY)" := ExchangeAmtLCYToFCY(PeriodEndingDate[1], "Credit Limit (LCY)", FALSE);
                    END;
                    //<<CIS002
                    CreditLimitToPrint := FORMAT(ROUND("Credit Limit (LCY)", 1));
                END;

                TempCustLedgEntry.DELETEALL;

                IF FORMAT(ShowOnlyOverDueBy) <> '' THEN
                    CalculatedDate := CALCDATE(ShowOnlyOverDueBy, PeriodEndingDate[1]);

                IF ShowAllForOverdue AND (FORMAT(ShowOnlyOverDueBy) <> '') THEN BEGIN
                    CustLedgEntry.SETRANGE("Customer No.", "No.");
                    CustLedgEntry.SETRANGE(Open, TRUE);
                    CustLedgEntry.SETRANGE("Due Date", 0D, CalculatedDate);
                    IF NOT CustLedgEntry.FINDFIRST THEN
                        CurrReport.SKIP;
                END;

            end;

            trigger OnPreDataItem()
            begin
                CLEAR("BalanceDue$");

                IF PrintDetail THEN
                    SubTitle := Text006
                ELSE
                    SubTitle := Text007;

                SubTitle := SubTitle + Text008 + ' ' + FORMAT(PeriodEndingDate[1], 0, 4) + ')';


                //SM001 1/26/18
                IF ShowARC THEN
                    ShowARCcaption := 'Showing in Additional Report Currency';
                //SM001 1/26/18


                CASE AgingMethod OF
                    AgingMethod::"Due Date":
                        BEGIN
                            DateTitle := Text009;
                            ShortDateTitle := Text010;
                            //>> NIF 07-05-05 RTT
                            /*
                            ColumnHead[2] := Text011 + ' '
                              + FORMAT(PeriodEndingDate[1] - PeriodEndingDate[3])
                              + Text012;
                            */

                            ColumnHead[2] := FORMAT(PeriodEndingDate[1] - PeriodEndingDate[2] + 1)
                                             + ' - '
                                             + FORMAT(PeriodEndingDate[1] - PeriodEndingDate[3])
                                             + Text012;
                            //<< NIF 07-05-05 RTT
                            ColumnHeadHead := Text013 + ' ';
                        END;
                    AgingMethod::"Trans Date":
                        BEGIN
                            DateTitle := Text014;
                            ShortDateTitle := Text015;
                            ColumnHead[2] := FORMAT(PeriodEndingDate[1] - PeriodEndingDate[2] + 1)
                              + ' - '
                              + FORMAT(PeriodEndingDate[1] - PeriodEndingDate[3])
                              + Text012;
                            ColumnHeadHead := Text016 + ' ';
                        END;
                    AgingMethod::"Document Date":
                        BEGIN
                            DateTitle := Text017;
                            ShortDateTitle := Text018;
                            ColumnHead[2] := FORMAT(PeriodEndingDate[1] - PeriodEndingDate[2] + 1)
                              + ' - '
                              + FORMAT(PeriodEndingDate[1] - PeriodEndingDate[3])
                              + Text012;
                            ColumnHeadHead := Text016 + ' ';
                        END;
                END;

                ColumnHead[1] := Text019;
                ColumnHead[3] := FORMAT(PeriodEndingDate[1] - PeriodEndingDate[3] + 1)
                  + ' - '
                  + FORMAT(PeriodEndingDate[1] - PeriodEndingDate[4])
                  + Text012;
                //>> NIF 07-05-05 RTT
                /*
                ColumnHead[4] := Text020 + ' '
                  + FORMAT(PeriodEndingDate[1] - PeriodEndingDate[4])
                  + Text012;
                */
                ColumnHead[4] := FORMAT(PeriodEndingDate[1] - PeriodEndingDate[4] + 1)
                                 + ' - '
                                 + FORMAT(PeriodEndingDate[1] - PeriodEndingDate[5])
                                 + Text012;
                //SM 03-03-20
                ColumnHead[5] := FORMAT(PeriodEndingDate[1] - PeriodEndingDate[5] + 1)
                                 + ' - '
                                 + FORMAT(PeriodEndingDate[1] - PeriodEndingDate[6])
                                 + Text012;


                //SM 03-03-20
                ColumnHead[6] := Text020 + ' '
                                 + FORMAT(PeriodEndingDate[1] - PeriodEndingDate[6])
                                 + Text012;
                //<< NIF 07-05-05 RTT

                IF PrintToExcel THEN
                    MakeExcelInfo;

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
                    field(AgedAsOf; PeriodEndingDate[1])
                    {
                        ApplicationArea = All;
                        Caption = 'Aged as of';

                        trigger OnValidate()
                        begin
                            IF PeriodEndingDate[1] = 0D THEN
                                PeriodEndingDate[1] := WORKDATE;
                        end;
                    }
                    field(AgedBy; AgingMethod)
                    {
                        ApplicationArea = All;
                        Caption = 'Aged by';
                        OptionCaption = 'Trans Date,Due Date,Document Date';

                        trigger OnValidate()
                        begin
                            IF AgingMethod IN [AgingMethod::"Document Date", AgingMethod::"Trans Date"] THEN BEGIN
                                EVALUATE(ShowOnlyOverDueBy, '');
                                ShowAllForOverdue := FALSE;
                            END;
                        end;
                    }
                    field("LengthOfAgingPeriods-1"; PeriodCalculation[1])
                    {
                        ApplicationArea = All;
                        Caption = 'Length of Aging Periods - 1';
                        //DateFormula = true; BC Upgrade
                        trigger OnValidate()
                        begin
                            IF FORMAT(PeriodCalculation[1]) = '' THEN
                                ERROR(Text121);
                        end;
                    }
                    field("LengthOfAgingPeriods-2"; PeriodCalculation[2])
                    {
                        ApplicationArea = All;
                        Caption = 'Length of Aging Periods - 2';
                        //DateFormula = true; BC Upgrade

                        trigger OnValidate()
                        begin
                            IF FORMAT(PeriodCalculation[2]) = '' THEN
                                ERROR(Text121);
                        end;
                    }
                    field("LengthOfAgingPeriods-3"; PeriodCalculation[3])
                    {
                        ApplicationArea = All;
                        Caption = 'Length of Aging Periods - 3';
                        //DateFormula = true; BC Upgrade

                        trigger OnValidate()
                        begin
                            IF FORMAT(PeriodCalculation[3]) = '' THEN
                                ERROR(Text121);
                        end;
                    }
                    field("LengthOfAgingPeriods-4"; PeriodCalculation[4])
                    {
                        ApplicationArea = All;
                        Caption = 'Length of Aging Periods - 4';
                        //DateFormula = true; BC Upgrade

                        trigger OnValidate()
                        begin
                            IF FORMAT(PeriodCalculation[4]) = '' THEN
                                ERROR(Text121);
                        end;
                    }
                    field("LengthOfAgingPeriods-5"; PeriodCalculation[5])
                    {
                        ApplicationArea = All;
                        Caption = 'Length of Aging Periods - 5';
                    }
                    field(ShowOnlyOverDueBy; ShowOnlyOverDueBy)
                    {
                        ApplicationArea = All;
                        Caption = 'Show If Overdue By';
                        //DateFormula = true; BC Upgrade

                        trigger OnValidate()
                        begin
                            IF AgingMethod <> AgingMethod::"Due Date" THEN
                                ERROR(Text120);
                            IF FORMAT(ShowOnlyOverDueBy) = '' THEN
                                ShowAllForOverdue := FALSE;
                        end;
                    }
                    field(ShowAllForOverdue; ShowAllForOverdue)
                    {
                        ApplicationArea = All;
                        Caption = 'Show All for Overdue Customer';

                        trigger OnValidate()
                        begin
                            IF AgingMethod <> AgingMethod::"Due Date" THEN
                                ERROR(Text120);
                            IF ShowAllForOverdue AND (FORMAT(ShowOnlyOverDueBy) = '') THEN
                                ERROR(Text119);
                        end;
                    }
                    field(PrintAmountsInVendorsCurrency; PrintAmountsInLocal)
                    {
                        ApplicationArea = All;
                        Caption = 'Print Amounts in Customer''s Currency';
                        MultiLine = true;
                    }
                    field(PrintDetail; PrintDetail)
                    {
                        ApplicationArea = All;
                        Caption = 'Print Detail';
                    }
                    field(PrintToExcel; PrintToExcel)
                    {
                        ApplicationArea = All;
                        Caption = 'Print to Excel';
                    }
                    field(ShowARC; ShowARC)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Additional Reporting Currency';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IF PeriodEndingDate[1] = 0D THEN BEGIN
                PeriodEndingDate[1] := WORKDATE;
                //>> NIF 07-05-05 RTT
                //EVALUATE(PeriodCalculation,'<30D>');

                EVALUATE(PeriodCalculation[1], '60D');
                EVALUATE(PeriodCalculation[2], '60D');
                EVALUATE(PeriodCalculation[3], '60D');
                EVALUATE(PeriodCalculation[4], '180D');
                //<< NIF 07-05-05 RTT
            END;
        end;
    }

    labels
    {
        PaymentTermsLbl = 'Payment Terms';
    }

    trigger OnPostReport()
    begin
        IF PrintToExcel THEN BEGIN
            MakeExcelGrandTotal;  //NF1.00:CIS.NG 09-15-15
            CreateExcelbook;
        END;
    end;

    trigger OnPreReport()
    begin
        IF FORMAT(PeriodCalculation[1]) <> '' THEN
            EVALUATE(PeriodCalculation[1], '-' + FORMAT(PeriodCalculation[1]));
        //>> NF1.00:CIS.NG  09-15-15
        IF FORMAT(PeriodCalculation[2]) <> '' THEN
            EVALUATE(PeriodCalculation[2], '-' + FORMAT(PeriodCalculation[2]));
        IF FORMAT(PeriodCalculation[3]) <> '' THEN
            EVALUATE(PeriodCalculation[3], '-' + FORMAT(PeriodCalculation[3]));
        IF FORMAT(PeriodCalculation[4]) <> '' THEN
            EVALUATE(PeriodCalculation[4], '-' + FORMAT(PeriodCalculation[4]));
        IF FORMAT(PeriodCalculation[5]) <> '' THEN
            EVALUATE(PeriodCalculation[5], '-' + FORMAT(PeriodCalculation[5]));


        //<< NF1.00:CIS.NG  09-15-15
        IF FORMAT(ShowOnlyOverDueBy) <> '' THEN
            EVALUATE(ShowOnlyOverDueBy, '-' + FORMAT(ShowOnlyOverDueBy));
        IF AgingMethod = AgingMethod::"Due Date" THEN BEGIN
            //>> NIF 07-05-05 RTT
            /*
              PeriodEndingDate[2] := PeriodEndingDate[1];
              FOR j := 3 TO 4 DO
                PeriodEndingDate[j] := CALCDATE(PeriodCalculation,PeriodEndingDate[j - 1]);
            END ELSE
              FOR j := 2 TO 4 DO
                PeriodEndingDate[j] := CALCDATE(PeriodCalculation,PeriodEndingDate[j - 1]);
            PeriodEndingDate[5] := 0D;
            */
            PeriodEndingDate[2] := CALCDATE(PeriodCalculation[1], PeriodEndingDate[1]);
            FOR j := 3 TO 6 DO
                PeriodEndingDate[j] := CALCDATE(PeriodCalculation[j - 1], PeriodEndingDate[j - 1]);
        END ELSE BEGIN
            FOR j := 2 TO 6 DO
                PeriodEndingDate[j] := CALCDATE(PeriodCalculation[j - 1], PeriodEndingDate[j - 1]);
        END;
        PeriodEndingDate[7] := 0D;
        //<< NIF 07-05-05 RTT


        CompanyInformation.GET;
        GLSetup.GET;
        FilterString := Customer.GETFILTERS;
        FilterString2 := "Cust. Ledger Entry".GETFILTERS;

        //>> NIF RTT 01-17-06
        IF ExportToExcel THEN BEGIN
            ExcelBuf.DELETEALL;
            MainTitle := 'Aged Accounts Receivable - NIF';
        END;
        //<< NIF RTT 01-17-06

    end;

    var
        CompanyInformation: Record "Company Information";
        TempCustLedgEntry: Record "Cust. Ledger Entry" temporary;
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        GLSetup: Record "General Ledger Setup";
        ExcelBuf: Record "Excel Buffer" temporary;
        PeriodCalculation: array[7] of DateFormula;
        ShowOnlyOverDueBy: DateFormula;
        AgingMethod: Option "Trans Date","Due Date","Document Date";
        PrintAmountsInLocal: Boolean;
        PrintDetail: Boolean;
        PrintToExcel: Boolean;
        AmountDue: array[7] of Decimal;
        "BalanceDue$": array[7] of Decimal;
        ColumnHead: array[7] of Text[20];
        ColumnHeadHead: Text[59];
        PercentString: array[7] of Text[10];
        Percent: Decimal;
        "TotalBalanceDue$": Decimal;
        AmountDueToPrint: Decimal;
        CreditLimitToPrint: Text[25];
        BlockedDescription: Text[60];
        OverLimitDescription: Text[25];
        j: Integer;
        CurrencyFactor: Decimal;
        FilterString: Text;
        SubTitle: Text[88];
        DateTitle: Text[20];
        ShortDateTitle: Text[20];
        PeriodEndingDate: array[8] of Date;
        AgingDate: Date;
        Text001: Label 'Amounts are in %1';
        Text002: Label '*** This customer is blocked  for %1 processing ***  ';
        Text003: Label 'No Limit';
        Text004: Label '*** Over Limit ***';
        Text006: Label '(Detail';
        Text007: Label '(Summary';
        Text008: Label ', aged as of';
        Text009: Label 'due date.';
        Text010: Label 'Due Date';
        Text011: Label 'Up To';
        Text012: Label ' Days';
        Text013: Label ' Aged Overdue Amounts';
        Text014: Label 'transaction date.';
        Text015: Label 'Trx Date';
        Text016: Label ' Aged Customer Balances';
        Text017: Label 'document date.';
        Text018: Label 'Doc Date';
        Text019: Label 'Current';
        Text020: Label 'Over';
        Text021: Label 'Amounts are in the customer''s local currency (report totals are in %1).';
        Text022: Label 'Report Total Amount Due (%1)';
        Text101: Label 'Data';
        Text102: Label 'Aged Accounts Receivable';
        Text103: Label 'Company Name';
        Text104: Label 'Report No.';
        Text105: Label 'Report Name';
        Text106: Label 'User ID';
        Text107: Label 'Date / Time';
        Text108: Label 'Customer Filters';
        Text109: Label 'Aged by';
        Text110: Label 'Amounts are';
        Text111: Label 'In our Functional Currency';
        Text112: Label 'As indicated in Data';
        Text113: Label 'Aged as of';
        Text114: Label 'Aging Date (%1)';
        Text115: Label 'Balance Due';
        Text116: Label 'Document Currency';
        Text117: Label 'Customer Currency';
        Text118: Label 'Credit Limit';
        Text119: Label 'Show Only Overdue By Needs a Valid Date Formula';
        ShowAllForOverdue: Boolean;
        CalculatedDate: Date;
        Text120: Label 'This option is only allowed for method Due Date';
        CustTotAmountDue: array[7] of Decimal;
        CustTotAmountDueToPrint: Decimal;
        Text121: Label 'You must enter a period calculation in the Length of Aging Periods field.';
        Aged_Accounts_ReceivableCaptionLbl: Label 'Aged Accounts Receivable';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Aged_byCaptionLbl: Label 'Aged by';
        AmountDueToPrint_Control74CaptionLbl: Label 'Balance Due';
        Credit_LimitCaptionLbl: Label 'Credit Limit';
        NameCaptionLbl: Label 'Name';
        Cust__Ledger_Entry___Document_No__CaptionLbl: Label 'Number';
        Cust__Ledger_Entry__DescriptionCaptionLbl: Label 'Description';
        Cust__Ledger_Entry___Document_Type_CaptionLbl: Label 'Type';
        AmountDueToPrint_Control63CaptionLbl: Label 'Balance Due';
        Cust__Ledger_Entry___Currency_Code_CaptionLbl: Label 'Doc. Curr.';
        DocumentCaptionLbl: Label 'Document';
        Balance_ForwardCaptionLbl: Label 'Balance Forward';
        Balance_to_Carry_ForwardCaptionLbl: Label 'Balance to Carry Forward';
        Total_Amount_DueCaptionLbl: Label 'Total Amount Due';
        Total_Amount_DueCaption_Control86Lbl: Label 'Total Amount Due';
        Credit_Limit_CaptionLbl: Label 'Credit Limit:';
        TotalNumberOfEntries: Integer;
        GrandTotalBalanceDue: Decimal;
        GrandBalanceDue: array[7] of Decimal;
        ">>NIF_Excel": Integer;
        d: Dialog;
        RowNo: Integer;
        ColumnNo: Integer;
        ExportToExcel: Boolean;
        MainTitle: Text[100];
        SubTitle2: Text[100];
        FilterString2: Text[250];
        ShowARC: Boolean;
        ShowARCcaption: Text;

    local procedure InsertTemp(var CustLedgEntry: Record "Cust. Ledger Entry")
    begin
        IF TempCustLedgEntry.GET(CustLedgEntry."Entry No.") THEN
            EXIT;
        TempCustLedgEntry := CustLedgEntry;
        /*
        //>>CSI.RAM 02/07/2018
        IF ShowARC THEN BEGIN
          TempCustLedgEntry.CALCFIELDS("Remaining Amt. (LCY)");
          MESSAGE('1-%1\%2',TempCustLedgEntry."Remaining Amount",TempCustLedgEntry."Remaining Amt. (LCY)");
          IF TempCustLedgEntry."Currency Code" = GLSetup."LCY Code" THEN
            TempCustLedgEntry."Remaining Amount" := ExchangeAmtLCYToFCY(TempCustLedgEntry."Posting Date",TempCustLedgEntry."Remaining Amount",FALSE)
          ELSE
            TempCustLedgEntry."Remaining Amount" := ExchangeAmtLCYToFCY(TempCustLedgEntry."Posting Date",TempCustLedgEntry."Remaining Amt. (LCY)",FALSE);
          MESSAGE('2-%1',TempCustLedgEntry."Remaining Amount");
        END;
        //<<CSI.RAM 02/07/2018
        */
        CASE AgingMethod OF
            AgingMethod::"Due Date":
                TempCustLedgEntry."Posting Date" := TempCustLedgEntry."Due Date";
            AgingMethod::"Document Date":
                TempCustLedgEntry."Posting Date" := TempCustLedgEntry."Document Date";
        END;
        TempCustLedgEntry.INSERT;

    end;

    procedure CalcPercents(Total: Decimal; Amounts: array[5] of Decimal)
    var
        i: Integer;
        j: Integer;
    begin
        CLEAR(PercentString);
        IF Total <> 0 THEN
            //>> NIF 07-05-05 RTT
            //FOR i := 1 TO 4 DO BEGIN
            FOR i := 1 TO 6 DO BEGIN
                //<< NIF 07-05-05 RTT
                Percent := Amounts[i] / Total * 100.0;
                IF STRLEN(FORMAT(ROUND(Percent))) + 4 > MAXSTRLEN(PercentString[1]) THEN
                    PercentString[i] := PADSTR(PercentString[i], MAXSTRLEN(PercentString[i]), '*')
                ELSE BEGIN
                    PercentString[i] := FORMAT(ROUND(Percent));
                    j := STRPOS(PercentString[i], '.');
                    IF j = 0 THEN
                        PercentString[i] := PercentString[i] + '.00'
                    ELSE
                        IF j = STRLEN(PercentString[i]) - 1 THEN
                            PercentString[i] := PercentString[i] + '0';
                    PercentString[i] := PercentString[i] + '%';
                END;
            END;
    end;

    local procedure GetCurrencyRecord(var Currency: Record Currency; CurrencyCode: Code[10])
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
        IF PrintAmountsInLocal THEN BEGIN
            IF CurrencyCode = '' THEN
                EXIT('101,1,' + Text001);

            GetCurrencyRecord(Currency, CurrencyCode);
            EXIT('101,4,' + STRSUBSTNO(Text001, Currency.Description));
        END;
        EXIT('');
    end;

    local procedure MakeExcelInfo()
    begin
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(FORMAT(Text103), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(CompanyInformation.Name, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text105), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FORMAT(Text102), FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text104), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(REPORT::"Aged Accounts Receivable", FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.NewRow;

        //SM001 1/26/18
        IF ShowARC THEN BEGIN
            ExcelBuf.AddInfoColumn(ShowARCcaption, FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.NewRow;
        END;
        //SM001 1/26/18

        ExcelBuf.AddInfoColumn(FORMAT(Text106), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(USERID, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text107), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(TODAY, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddInfoColumn(TIME, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Time);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text108), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FilterString, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text109), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(DateTitle, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text113), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(PeriodEndingDate[1], FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text110), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        IF PrintAmountsInLocal THEN
            ExcelBuf.AddInfoColumn(FORMAT(Text112), FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
        //SM001 1/26/18
        ELSE IF ShowARC THEN
            ExcelBuf.AddInfoColumn('Additional Reporting Currency', FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
        //SM001 1/26/18
        ELSE
            ExcelBuf.AddInfoColumn(FORMAT(Text111), FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
    end;

    local procedure MakeExcelDataHeader()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn("Cust. Ledger Entry".FIELDCAPTION("Customer No."), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer.FIELDCAPTION(Name), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        IF PrintDetail THEN BEGIN
            ExcelBuf.AddColumn(STRSUBSTNO(Text114, ShortDateTitle), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn("Cust. Ledger Entry".FIELDCAPTION(Description), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn("Cust. Ledger Entry".FIELDCAPTION("Document Type"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn("Cust. Ledger Entry".FIELDCAPTION("Document No."), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        END ELSE
            ExcelBuf.AddColumn(FORMAT(Text118), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(Text115), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ColumnHead[1], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ColumnHead[2], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ColumnHead[3], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ColumnHead[4], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ColumnHead[5], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);  //NF1.00:CIS.NG 09-15-15
        ExcelBuf.AddColumn(ColumnHead[6], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);  //SM 03-03-20

        IF PrintAmountsInLocal THEN BEGIN
            IF PrintDetail THEN
                ExcelBuf.AddColumn(FORMAT(Text116), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text)
            ELSE
                ExcelBuf.AddColumn(FORMAT(Text117), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        END;

        //SM001 1/26/18
        IF ShowARC THEN BEGIN
            IF PrintDetail THEN
                ExcelBuf.AddColumn(FORMAT(Text116), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text)
            ELSE
                ExcelBuf.AddColumn('Payment Terms', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('Customer Posting Group', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('Additional Reporting Currency', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        END;
        //SM001 1/26/18
    end;

    local procedure MakeExcelDataBody()
    var
        CurrencyCodeToPrint: Code[20];
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Customer."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer.Name, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn(Customer."Payment Terms Code",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        IF PrintDetail THEN BEGIN
            ExcelBuf.AddColumn(AgingDate, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
            ExcelBuf.AddColumn("Cust. Ledger Entry".Description, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(FORMAT("Cust. Ledger Entry"."Document Type"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn("Cust. Ledger Entry"."Document No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        END ELSE
            IF OverLimitDescription = '' THEN
                ExcelBuf.AddColumn(CreditLimitToPrint, FALSE, '', FALSE, FALSE, FALSE, '#,##0', ExcelBuf."Cell Type"::Number)
            ELSE
                ExcelBuf.AddColumn(CreditLimitToPrint, FALSE, OverLimitDescription, TRUE, FALSE, FALSE, '#,##0', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(AmountDueToPrint, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(AmountDue[1], FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(AmountDue[2], FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(AmountDue[3], FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(AmountDue[4], FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(AmountDue[5], FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);  //NF1.00:CIS.NG 09-15-15
        ExcelBuf.AddColumn(AmountDue[6], FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);  //SM 03-03-20
        ExcelBuf.AddColumn(Customer."Payment Terms Code", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer."Customer Posting Group", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        IF PrintAmountsInLocal THEN BEGIN
            IF PrintDetail THEN
                CurrencyCodeToPrint := "Cust. Ledger Entry"."Currency Code"
            ELSE
                CurrencyCodeToPrint := Customer."Currency Code";
            IF CurrencyCodeToPrint = '' THEN
                CurrencyCodeToPrint := GLSetup."LCY Code";
            ExcelBuf.AddColumn(CurrencyCodeToPrint, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
        END;
    end;

    local procedure MakeExcelGroupDataBody()
    var
        CurrencyCodeToPrint: Code[20];
    begin
        //>> NF1.00:CIS.NG 09-15-15
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Customer."No.", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer.Name, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        IF PrintDetail THEN BEGIN

            //SM001 1/26/18
            //ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
            //SM001 1/26/18

            ExcelBuf.AddColumn(Customer."Payment Terms Code", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(Customer."Due Date Calculation", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

            //SM001 1/26/18
            //ExcelBuf.AddColumn('Total Amount Due',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
            //SM001 1/26/18

            ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        END ELSE
            IF OverLimitDescription = '' THEN
                ExcelBuf.AddColumn(CreditLimitToPrint, FALSE, '', TRUE, FALSE, FALSE, '#,##0', ExcelBuf."Cell Type"::Number)
            ELSE
                ExcelBuf.AddColumn(CreditLimitToPrint, FALSE, OverLimitDescription, TRUE, FALSE, FALSE, '#,##0', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(AmountDueToPrint, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(AmountDue[1], FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(AmountDue[2], FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(AmountDue[3], FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(AmountDue[4], FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(AmountDue[5], FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);  //NF1.00:CIS.NG 09-15-15
        ExcelBuf.AddColumn(AmountDue[6], FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);  //SM 03-03-20
        ExcelBuf.AddColumn(Customer."Payment Terms Code", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer."Customer Posting Group", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        IF PrintAmountsInLocal THEN BEGIN
            IF PrintDetail THEN
                CurrencyCodeToPrint := "Cust. Ledger Entry"."Currency Code"
            ELSE
                CurrencyCodeToPrint := Customer."Currency Code";
            IF CurrencyCodeToPrint = '' THEN
                CurrencyCodeToPrint := GLSetup."LCY Code";
            ExcelBuf.AddColumn(CurrencyCodeToPrint, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
        END;
        //<< NF1.00:CIS.NG 09-15-15
    end;

    local procedure MakeExcelGrandTotal()
    var
        CurrencyCodeToPrint: Code[20];
    begin
        //>> NF1.00:CIS.NG 09-15-15
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);


        //SM001 1/26/18
        IF ShowARC THEN
            ExcelBuf.AddColumn('Report Total Amount Due (ARC)', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
        ELSE
            //SM001 1/26/18
            ExcelBuf.AddColumn('Report Total Amount Due ($)', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        IF PrintDetail THEN BEGIN
            ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        END;

        ExcelBuf.AddColumn(GrandTotalBalanceDue, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(GrandBalanceDue[1], FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(GrandBalanceDue[2], FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(GrandBalanceDue[3], FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(GrandBalanceDue[4], FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(GrandBalanceDue[5], FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);  //NF1.00:CIS.NG 09-15-15
        ExcelBuf.AddColumn(GrandBalanceDue[6], FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);  //SM 03-03-20
        //<< NF1.00:CIS.NG 09-15-15
    end;

    local procedure CreateExcelbook()
    begin
        //ExcelBuf.CreateBookAndOpenExcel(Text101, Text102, COMPANYNAME, USERID); BC Upgrade
        ExcelBuf.CreateNewBook(MainTitle);
        ExcelBuf.WriteSheet(MainTitle, COMPANYNAME, USERID);
        ExcelBuf.CloseBook();
        ExcelBuf.OpenExcel();
    end;

    local procedure ExchangeAmtLCYToFCY(PostingDate: Date; Amount: Decimal; IsUnitAmount: Boolean): Decimal
    var
        AmtRndgPrec: Decimal;
    begin
        //>>CSI.RAM 02/07/2018
        IF IsUnitAmount THEN
            AmtRndgPrec := Currency."Unit-Amount Rounding Precision"
        ELSE
            AmtRndgPrec := Currency."Amount Rounding Precision";
        EXIT(
          ROUND(
            CurrExchRate.ExchangeAmtLCYToFCY(
              PostingDate, GLSetup."Additional Reporting Currency", Amount,
              CurrExchRate.ExchangeRate(PostingDate, GLSetup."Additional Reporting Currency")),
            AmtRndgPrec));
        //<<CSI.RAM 02/07/2018
    end;
}

