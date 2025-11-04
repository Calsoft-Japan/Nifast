report 50031 "Suggest Vendor Payments New"
{
    // NF1.00:CIS.CM  07/30/15 Merged during upgrade
    // NF1.00:CIS.NG  07/08/16 Update code to solve issue when we run report with "summarixe per vendor" option
    // NF1.00:CIS.NG  08/04/16 Added code to solve error of Purchase Invoice No. Not found
    // //>>IST
    // Date   Init ProjID Description
    // 052505 DPC  #9806  New function: "Set4xValues"
    // 052505 DPC  #9806  New Globals: "use4x", "4xSpotRate", PurchInvLine
    // 052505 DPC  #9806  MakeGenJnlLines() Modified for Foreign Exchange Contracts (4X Contract)
    // 
    // 061405 MAK  ?????  Changed "Description" to show vendor name
    //                    Populated External Document number from Vendor Ledger Entry
    //                    Added new Text Constant ISTText0001
    //                    Globals Added: NIFVendor, NIFVendLedgEntry
    // //<<IST
    // 
    // NF1.00:CIS.RAM 09/07/15 Forex Change
    //  # Commented existing 4x code and added FOREX code

    Caption = 'Suggest Vendor Payments New';
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = SORTING("No.")
                                WHERE(Blocked = FILTER(= ' '));
            RequestFilterFields = "No.", "Payment Method Code", "Currency Code";

            trigger OnAfterGetRecord()
            begin
                CLEAR(VendorBalance);
                CALCFIELDS("Balance (LCY)");
                VendorBalance := "Balance (LCY)";

                IF StopPayments THEN
                    CurrReport.BREAK();
                Window.UPDATE(1, "No.");
                IF VendorBalance > 0 THEN BEGIN
                    GetVendLedgEntries(TRUE, FALSE);
                    GetVendLedgEntries(FALSE, FALSE);
                    CheckAmounts(FALSE);
                    ClearNegative();
                END;
            end;

            trigger OnPostDataItem()
            begin
                IF UsePriority AND NOT StopPayments THEN BEGIN
                    RESET();
                    COPYFILTERS(Vend2);
                    SETCURRENTKEY(Priority);
                    SETRANGE(Priority, 0);
                    IF FIND('-') THEN
                        REPEAT
                            CLEAR(VendorBalance);
                            CALCFIELDS("Balance (LCY)");
                            VendorBalance := "Balance (LCY)";
                            IF VendorBalance > 0 THEN BEGIN
                                Window.UPDATE(1, "No.");
                                GetVendLedgEntries(TRUE, FALSE);
                                GetVendLedgEntries(FALSE, FALSE);
                                CheckAmounts(FALSE);
                                ClearNegative();
                            END;
                        UNTIL (NEXT() = 0) OR StopPayments;
                END;

                IF UsePaymentDisc AND NOT StopPayments THEN BEGIN
                    RESET();
                    COPYFILTERS(Vend2);
                    Window2.OPEN(Text007);
                    IF FIND('-') THEN
                        REPEAT
                            CLEAR(VendorBalance);
                            CALCFIELDS("Balance (LCY)");
                            VendorBalance := "Balance (LCY)";
                            Window2.UPDATE(1, "No.");
                            PayableVendLedgEntry.SETRANGE("Vendor No.", "No.");
                            IF VendorBalance > 0 THEN BEGIN
                                GetVendLedgEntries(TRUE, TRUE);
                                GetVendLedgEntries(FALSE, TRUE);
                                CheckAmounts(TRUE);
                                ClearNegative();
                            END;
                        UNTIL (NEXT() = 0) OR StopPayments;
                    Window2.CLOSE();
                END ELSE
                    IF FIND('-') THEN
                        REPEAT
                            ClearNegative();
                        UNTIL NEXT() = 0;

                DimSetEntry.LOCKTABLE();
                GenJnlLine.LOCKTABLE();
                GenJnlTemplate.GET(GenJnlLine."Journal Template Name");
                GenJnlBatch.GET(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name");
                GenJnlLine.SETRANGE("Journal Template Name", GenJnlLine."Journal Template Name");
                GenJnlLine.SETRANGE("Journal Batch Name", GenJnlLine."Journal Batch Name");
                IF GenJnlLine.FINDLAST() THEN BEGIN
                    FirstLineNo := GenJnlLine."Line No.";
                    LastLineNo := GenJnlLine."Line No.";
                    GenJnlLine.INIT();
                END;

                Window2.OPEN(Text008);

                PayableVendLedgEntry.RESET();
                PayableVendLedgEntry.SETRANGE(Priority, 1, 2147483647);
                MakeGenJnlLines();
                PayableVendLedgEntry.RESET();
                PayableVendLedgEntry.SETRANGE(Priority, 0);
                MakeGenJnlLines();
                PayableVendLedgEntry.RESET();
                PayableVendLedgEntry.DELETEALL();

                Window2.CLOSE();
                Window.CLOSE();
                ShowMessage(MessageText);
            end;

            trigger OnPreDataItem()
            begin
                IF LastDueDateToPayReq = 0D THEN
                    ERROR(Text000);
                IF (PostingDate = 0D) AND (NOT UseDueDateAsPostingDate) THEN
                    ERROR(Text001);

                BankPmtType := GenJnlLine2."Bank Payment Type";
                BalAccType := GenJnlLine2."Bal. Account Type";
                BalAccNo := GenJnlLine2."Bal. Account No.";
                GenJnlLineInserted := FALSE;
                SeveralCurrencies := FALSE;
                MessageText := '';

                IF ((BankPmtType = BankPmtType::" ") OR
                    SummarizePerVend) AND
                   (NextDocNo = '')
                THEN
                    ERROR(Text002);

                IF ((BankPmtType = BankPmtType::"Manual Check") AND
                    NOT SummarizePerVend AND
                    NOT DocNoPerLine)
                THEN
                    ERROR(Text017, GenJnlLine2.FIELDCAPTION("Bank Payment Type"), SELECTSTR(BankPmtType + 1, Text023));

                IF UsePaymentDisc AND (LastDueDateToPayReq < WORKDATE()) THEN
                    IF NOT CONFIRM(Text003, FALSE, WORKDATE()) THEN
                        ERROR(Text005);

                Vend2.COPYFILTERS(Vendor);

                OriginalAmtAvailable := AmountAvailable;
                IF UsePriority THEN BEGIN
                    SETCURRENTKEY(Priority);
                    SETRANGE(Priority, 1, 2147483647);
                    UsePriority := TRUE;
                END;
                Window.OPEN(Text006);

                SelectedDim.SETRANGE("User ID", USERID);
                SelectedDim.SETRANGE("Object Type", 3);
                SelectedDim.SETRANGE("Object ID", REPORT::"Suggest Vendor Payments");
                SummarizePerDim := SelectedDim.FIND('-') AND SummarizePerVend;

                NextEntryNo := 1;
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
                    group("Find Payments")
                    {
                        Caption = 'Find Payments';
                        field(LastPaymentDate; LastDueDateToPayReq)
                        {
                            Caption = 'Last Payment Date';
                            ApplicationArea = All;
                        }
                        field(FindPaymentDiscounts; UsePaymentDisc)
                        {
                            Caption = 'Find Payment Discounts';
                            MultiLine = true;
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                IF UsePaymentDisc AND UseDueDateAsPostingDate THEN
                                    ERROR(PmtDiscUnavailableErr);
                            end;
                        }
                        field(UseVendorPriority; UsePriority)
                        {
                            Caption = 'Use Vendor Priority';
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                IF NOT UsePriority AND (AmountAvailable <> 0) THEN
                                    ERROR(Text011);
                            end;
                        }
                        field("Available Amount (LCY)"; AmountAvailable)
                        {
                            Caption = 'Available Amount ($)';
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                IF AmountAvailable <> 0 THEN
                                    UsePriority := TRUE;
                            end;
                        }
                        field(SkipExportedPayments; SkipExportedPayments)
                        {
                            Caption = 'Skip Exported Payments';
                            ApplicationArea = All;
                        }
                    }
                    group("Summarize Results")
                    {
                        Caption = 'Summarize Results';
                        field(SummarizePerVendor; SummarizePerVend)
                        {
                            Caption = 'Summarize per Vendor';
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                IF SummarizePerVend AND UseDueDateAsPostingDate THEN
                                    ERROR(PmtDiscUnavailableErr);
                            end;
                        }
                        field(SummarizePerDimText; SummarizePerDimText)
                        {
                            Caption = 'By Dimension';
                            Editable = false;
                            Enabled = SummarizePerDimTextEnable;
                            ApplicationArea = All;

                            trigger OnAssistEdit()
                            var
                                DimSelectionBuf: Record "Dimension Selection Buffer";
                            begin
                                DimSelectionBuf.SetDimSelectionMultiple(3, REPORT::"Suggest Vendor Payments", SummarizePerDimText);
                            end;
                        }
                    }
                    group("Fill in Journal Lines")
                    {
                        Caption = 'Fill in Journal Lines';
                        field(PostingDate; PostingDate)
                        {
                            Caption = 'Posting Date';
                            Editable = UseDueDateAsPostingDate = FALSE;
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                ValidatePostingDate();
                            end;
                        }
                        field(UseDueDateAsPostingDate; UseDueDateAsPostingDate)
                        {
                            Caption = 'Calculate Posting Date from Applies-to-Doc. Due Date';
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                IF UseDueDateAsPostingDate AND (SummarizePerVend OR UsePaymentDisc) THEN
                                    ERROR(PmtDiscUnavailableErr);
                                IF NOT UseDueDateAsPostingDate THEN
                                    CLEAR(DueDateOffset);
                            end;
                        }
                        field(DueDateOffset; DueDateOffset)
                        {
                            Caption = 'Applies-to-Doc. Due Date Offset';
                            Editable = UseDueDateAsPostingDate;
                            Enabled = UseDueDateAsPostingDate;
                            ApplicationArea = All;
                        }
                        field(StartingDocumentNo; NextDocNo)
                        {
                            Caption = 'Starting Document No.';
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                IF NextDocNo <> '' THEN
                                    IF INCSTR(NextDocNo) = '' THEN
                                        ERROR(Text012);
                            end;
                        }
                        field(NewDocNoPerLine; DocNoPerLine)
                        {
                            Caption = 'New Doc. No. per Line';
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                IF NOT UsePriority AND (AmountAvailable <> 0) THEN
                                    ERROR(Text013);
                            end;
                        }
                        field(BalAccountType; GenJnlLine2."Bal. Account Type")
                        {
                            Caption = 'Bal. Account Type';
                            OptionCaption = 'G/L Account,,,Bank Account';
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                GenJnlLine2."Bal. Account No." := '';
                            end;
                        }
                        field(BalAccountNo; GenJnlLine2."Bal. Account No.")
                        {
                            Caption = 'Bal. Account No.';
                            ApplicationArea = All;

                            trigger OnLookup(var Text: Text): Boolean
                            begin
                                CASE GenJnlLine2."Bal. Account Type" OF
                                    GenJnlLine2."Bal. Account Type"::"G/L Account":
                                        IF PAGE.RUNMODAL(0, GLAcc) = ACTION::LookupOK THEN
                                            GenJnlLine2."Bal. Account No." := GLAcc."No.";
                                    GenJnlLine2."Bal. Account Type"::Customer, GenJnlLine2."Bal. Account Type"::Vendor:
                                        ERROR(Text009, GenJnlLine2.FIELDCAPTION("Bal. Account Type"));
                                    GenJnlLine2."Bal. Account Type"::"Bank Account":
                                        IF PAGE.RUNMODAL(0, BankAcc) = ACTION::LookupOK THEN
                                            GenJnlLine2."Bal. Account No." := BankAcc."No.";
                                END;
                            end;

                            trigger OnValidate()
                            begin
                                IF GenJnlLine2."Bal. Account No." <> '' THEN
                                    CASE GenJnlLine2."Bal. Account Type" OF
                                        GenJnlLine2."Bal. Account Type"::"G/L Account":
                                            GLAcc.GET(GenJnlLine2."Bal. Account No.");
                                        GenJnlLine2."Bal. Account Type"::Customer, GenJnlLine2."Bal. Account Type"::Vendor:
                                            ERROR(Text009, GenJnlLine2.FIELDCAPTION("Bal. Account Type"));
                                        GenJnlLine2."Bal. Account Type"::"Bank Account":
                                            BankAcc.GET(GenJnlLine2."Bal. Account No.");
                                    END;
                            end;
                        }
                        field(BankPaymentType; GenJnlLine2."Bank Payment Type")
                        {
                            Caption = 'Bank Payment Type';
                            OptionCaption = ' ,Computer Check,Manual Check,Electronic Payment';
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                IF (GenJnlLine2."Bal. Account Type" <> GenJnlLine2."Bal. Account Type"::"Bank Account") AND
                                   (GenJnlLine2."Bank Payment Type" > 0)
                                THEN
                                    ERROR(
                                      Text010,
                                      GenJnlLine2.FIELDCAPTION("Bank Payment Type"),
                                      GenJnlLine2.FIELDCAPTION("Bal. Account Type"));
                            end;
                        }
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            SummarizePerDimTextEnable := TRUE;
            SkipExportedPayments := TRUE;
        end;

        trigger OnOpenPage()
        begin
            IF PostingDate = 0D THEN
                PostingDate := WORKDATE();
            ValidatePostingDate();
        end;
    }

    labels
    {
    }

    trigger OnPostReport()
    var
        PaymentJnl: Page "Payment Journal";
    begin
        COMMIT();
        IF NOT VendorLedgEntryTemp.ISEMPTY THEN
            IF CONFIRM(Text024) THEN
                PAGE.RUNMODAL(0, VendorLedgEntryTemp);

        //>>FOREX
        PaymentJnl.Insert3WayCurrency(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name")
        //<<FOREX
    end;

    trigger OnPreReport()
    begin
        CompanyInformation.GET();
        VendorLedgEntryTemp.DELETEALL();
        ShowPostingDateWarning := FALSE;
    end;

    var
        BankAcc: Record "Bank Account";
        CompanyInformation: Record "Company Information";
        DimSetEntry: Record "Dimension Set Entry";
        GLAcc: Record "G/L Account";
        GenJnlBatch: Record "Gen. Journal Batch";
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlLine2: Record "Gen. Journal Line";
        GenJnlTemplate: Record "Gen. Journal Template";
        PayableVendLedgEntry: Record "Payable Vendor Ledger Entry" temporary;
        OldTempPaymentBuffer: Record "Vendor Payment Buffer" temporary;
        TempPaymentBuffer: Record "Vendor Payment Buffer" temporary;
        SelectedDim: Record "Selected Dimension";
        NIFVendor: Record Vendor;
        Vend2: Record Vendor;
        NIFVendLedgEntry: Record "Vendor Ledger Entry";
        VendLedgEntry: Record "Vendor Ledger Entry";
        VendorLedgEntryTemp: Record "Vendor Ledger Entry" temporary;
        DimBufMgt: Codeunit "Dimension Buffer Management";
        DimMgt: Codeunit DimensionManagement;
        NoSeriesMgt: Codeunit "No. Series";
        VendEntryEdit: Codeunit "Vend. Entry-Edit";
        DueDateOffset: DateFormula;
        DocNoPerLine: Boolean;
        GenJnlLineInserted: Boolean;
        SeveralCurrencies: Boolean;
        ShowPostingDateWarning: Boolean;
        SkipExportedPayments: Boolean;
        StopPayments: Boolean;
        SummarizePerDim: Boolean;
        SummarizePerDimTextEnable: Boolean;
        SummarizePerVend: Boolean;
        Use4x: Boolean;
        UseDueDateAsPostingDate: Boolean;
        UsePaymentDisc: Boolean;
        UsePriority: Boolean;
        BalAccNo: Code[20];
        NextDocNo: Code[20];
        LastDueDateToPayReq: Date;
        PostingDate: Date;
        "4xSpotRate": Decimal;
        AmountAvailable: Decimal;
        OriginalAmtAvailable: Decimal;
        VendorBalance: Decimal;
        Window: Dialog;
        Window2: Dialog;
        FirstLineNo: Integer;
        LastLineNo: Integer;
        NextEntryNo: Integer;
        ISTText001: Label 'Pmt. To %1';
        MessageToRecipientMsg: Label 'Payment of %1 %2 ', Comment = '%1 document type, %2 Document No.';
        PmtDiscUnavailableErr: Label 'You cannot use Find Payment Discounts or Summarize per Vendor together with Calculate Posting Date from Applies-to-Doc. Due Date, because the resulting posting date might not match the payment discount date.';
        ReplacePostingDateMsg: Label 'For one or more entries, the requested posting date is before the work date.\\These posting dates will use the work date.';
        Text000: Label 'In the Last Payment Date field, specify the last possible date that payments must be made.';
        Text001: Label 'In the Posting Date field, specify the date that will be used as the posting date for the journal entries.';
        Text002: Label 'In the Starting Document No. field, specify the first document number to be used.';
        Text003: Label 'The payment date is earlier than %1.\\Do you still want to run the batch job?', Comment = '%1 is a date';
        Text005: Label 'The batch job was interrupted.';
        Text006: Label 'Processing vendors                       #1##########';
        Text007: Label 'Processing vendors for payment discounts #1##########';
        Text008: Label 'Inserting payment journal lines          #1##########';
        Text009: Label '%1 must be G/L Account or Bank Account.';
        Text010: Label '%1 must be filled only when %2 is Bank Account.';
        Text011: Label 'Use Vendor Priority must be activated when the value in the Amount Available field is not 0.';
        Text012: Label 'Starting Document No. must contain a number.';
        Text013: Label 'Use Vendor Priority must be activated when the value in the Amount Available Amount ($) field is not 0.';
        Text014: Label 'Payment to vendor %1';
        Text016: Label ' is already applied to %1 %2 for vendor %3.';
        Text017: Label 'If %1 = %2 and you have not selected the Summarize per Vendor field,\ then you must select the New Doc. No. per Line.', Comment = 'If Bank Payment Type = Computer Check and you have not selected the Summarize per Vendor field,\ then you must select the New Doc. No. per Line.';
        Text020: Label 'You have only created suggested vendor payment lines for the %1 %2.\ However, there are other open vendor ledger entries in currencies other than %2.\\', Comment = 'You have only created suggested vendor payment lines for the Currency Code EUR.\ However, there are other open vendor ledger entries in currencies other than EUR.';
        Text021: Label 'You have only created suggested vendor payment lines for the %1 %2.\ There are no other open vendor ledger entries in other currencies.\\', Comment = 'You have only created suggested vendor payment lines for the Currency Code EUR\ There are no other open vendor ledger entries in other currencies.\\';
        Text022: Label 'You have created suggested vendor payment lines for all currencies.\\';
        Text023: Label ' ,Computer Check,Manual Check';
        Text024: Label 'There are one or more entries for which no payment suggestions have been made because the posting dates of the entries are later than the requested posting date. Do you want to see the entries?';
        Text025: Label 'The %1 with the number %2 has a %3 with the number %4.';
        BankPmtType: Option " ","Computer Check","Manual Check";
        BalAccType: Option "G/L Account",Customer,Vendor,"Bank Account";
        MessageText: Text;
        SummarizePerDimText: Text[250];

    procedure SetGenJnlLine(NewGenJnlLine: Record "Gen. Journal Line")
    begin
        GenJnlLine := NewGenJnlLine;
    end;

    local procedure ValidatePostingDate()
    begin
        GenJnlBatch.GET(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name");
        IF GenJnlBatch."No. Series" = '' THEN
            NextDocNo := ''
        ELSE BEGIN
            NextDocNo := NoSeriesMgt.GetNextNo(GenJnlBatch."No. Series", PostingDate, FALSE);
            CLEAR(NoSeriesMgt);
        END;
    end;

    procedure InitializeRequest(LastPmtDate: Date; FindPmtDisc: Boolean; NewAvailableAmount: Decimal; NewSkipExportedPayments: Boolean; NewPostingDate: Date; NewStartDocNo: Code[20]; NewSummarizePerVend: Boolean; BalAccType: Option "G/L Account",Customer,Vendor,"Bank Account"; BalAccNo: Code[20]; BankPmtType: Option " ","Computer Check","Manual Check")
    begin
        LastDueDateToPayReq := LastPmtDate;
        UsePaymentDisc := FindPmtDisc;
        AmountAvailable := NewAvailableAmount;
        SkipExportedPayments := NewSkipExportedPayments;
        PostingDate := NewPostingDate;
        NextDocNo := NewStartDocNo;
        SummarizePerVend := NewSummarizePerVend;
        GenJnlLine2."Bal. Account Type" := BalAccType;
        GenJnlLine2."Bal. Account No." := BalAccNo;
        GenJnlLine2."Bank Payment Type" := BankPmtType;
    end;

    procedure GetVendLedgEntries(Positive: Boolean; Future: Boolean)
    begin
        VendLedgEntry.RESET();
        VendLedgEntry.SETCURRENTKEY("Vendor No.", Open, Positive, "Due Date");
        VendLedgEntry.SETRANGE("Vendor No.", Vendor."No.");
        VendLedgEntry.SETRANGE(Open, TRUE);
        VendLedgEntry.SETRANGE(Positive, Positive);
        VendLedgEntry.SETRANGE("Applies-to ID", '');
        VendLedgEntry.SETFILTER("Document Type", '<>%1', VendLedgEntry."Document Type"::Payment);
        IF Future THEN BEGIN
            VendLedgEntry.SETRANGE("Due Date", LastDueDateToPayReq + 1, 99991231D);
            VendLedgEntry.SETRANGE("Pmt. Discount Date", PostingDate, LastDueDateToPayReq);
            VendLedgEntry.SETFILTER("Remaining Pmt. Disc. Possible", '<>0');
        END ELSE
            VendLedgEntry.SETRANGE("Due Date", 0D, LastDueDateToPayReq);
        IF SkipExportedPayments THEN
            VendLedgEntry.SETRANGE("Exported to Payment File", FALSE);
        VendLedgEntry.SETRANGE("On Hold", '');
        VendLedgEntry.SETFILTER("Currency Code", Vendor.GETFILTER("Currency Filter"));
        VendLedgEntry.SETFILTER("Global Dimension 1 Code", Vendor.GETFILTER("Global Dimension 1 Filter"));
        VendLedgEntry.SETFILTER("Global Dimension 2 Code", Vendor.GETFILTER("Global Dimension 2 Filter"));

        IF VendLedgEntry.FIND('-') THEN
            REPEAT
                SaveAmount();
                IF VendLedgEntry."Accepted Pmt. Disc. Tolerance" OR
                   (VendLedgEntry."Accepted Payment Tolerance" <> 0)
                THEN BEGIN
                    VendLedgEntry."Accepted Pmt. Disc. Tolerance" := FALSE;
                    VendLedgEntry."Accepted Payment Tolerance" := 0;
                    VendEntryEdit.RUN(VendLedgEntry);
                END;
            UNTIL VendLedgEntry.NEXT() = 0;
    end;

    local procedure SaveAmount()
    var
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
    begin
        WITH GenJnlLine DO BEGIN
            INIT();
            SetPostingDate(GenJnlLine, VendLedgEntry."Due Date", PostingDate);
            "Document Type" := "Document Type"::Payment;
            "Account Type" := "Account Type"::Vendor;
            Vend2.GET(VendLedgEntry."Vendor No.");
            Vend2.CheckBlockedVendOnJnls(Vend2, "Document Type", FALSE);
            Description := Vend2.Name;
            "Posting Group" := Vend2."Vendor Posting Group";
            "Salespers./Purch. Code" := Vend2."Purchaser Code";
            "Payment Terms Code" := Vend2."Payment Terms Code";
            VALIDATE("Bill-to/Pay-to No.", "Account No.");
            VALIDATE("Sell-to/Buy-from No.", "Account No.");
            "Gen. Posting Type" := 0;
            "Gen. Bus. Posting Group" := '';
            "Gen. Prod. Posting Group" := '';
            "VAT Bus. Posting Group" := '';
            "VAT Prod. Posting Group" := '';
            VALIDATE("Currency Code", VendLedgEntry."Currency Code");
            VALIDATE("Payment Terms Code");
            VendLedgEntry.CALCFIELDS("Remaining Amount");
            IF PaymentToleranceMgt.CheckCalcPmtDiscGenJnlVend(GenJnlLine, VendLedgEntry, 0, FALSE) THEN
                Amount := -(VendLedgEntry."Remaining Amount" - VendLedgEntry."Remaining Pmt. Disc. Possible")
            ELSE
                Amount := -VendLedgEntry."Remaining Amount";
            VALIDATE(Amount);
        END;

        IF UsePriority THEN
            PayableVendLedgEntry.Priority := Vendor.Priority
        ELSE
            PayableVendLedgEntry.Priority := 0;
        PayableVendLedgEntry."Vendor No." := VendLedgEntry."Vendor No.";
        PayableVendLedgEntry."Entry No." := NextEntryNo;
        PayableVendLedgEntry."Vendor Ledg. Entry No." := VendLedgEntry."Entry No.";
        PayableVendLedgEntry.Amount := GenJnlLine.Amount;
        PayableVendLedgEntry."Amount (LCY)" := GenJnlLine."Amount (LCY)";
        PayableVendLedgEntry."USD Value" := GenJnlLine."USD Value"; //FOREX
        PayableVendLedgEntry.Positive := (PayableVendLedgEntry.Amount > 0);
        PayableVendLedgEntry.Future := (VendLedgEntry."Due Date" > LastDueDateToPayReq);
        PayableVendLedgEntry."Currency Code" := VendLedgEntry."Currency Code";
        PayableVendLedgEntry.INSERT();
        NextEntryNo := NextEntryNo + 1;
    end;

    procedure CheckAmounts(Future: Boolean)
    var
        PrevCurrency: Code[10];
        CurrencyBalance: Decimal;
    begin
        PayableVendLedgEntry.SETRANGE("Vendor No.", Vendor."No.");
        PayableVendLedgEntry.SETRANGE(Future, Future);

        IF PayableVendLedgEntry.FIND('-') THEN BEGIN
            REPEAT
                IF PayableVendLedgEntry."Currency Code" <> PrevCurrency THEN BEGIN
                    IF CurrencyBalance > 0 THEN
                        AmountAvailable := AmountAvailable - CurrencyBalance;
                    CurrencyBalance := 0;
                    PrevCurrency := PayableVendLedgEntry."Currency Code";
                END;
                IF (OriginalAmtAvailable = 0) OR
                   (AmountAvailable >= CurrencyBalance + PayableVendLedgEntry."Amount (LCY)")
                THEN
                    CurrencyBalance := CurrencyBalance + PayableVendLedgEntry."Amount (LCY)"
                ELSE
                    PayableVendLedgEntry.DELETE();
            UNTIL PayableVendLedgEntry.NEXT() = 0;
            IF OriginalAmtAvailable > 0 THEN
                AmountAvailable := AmountAvailable - CurrencyBalance;
            IF (OriginalAmtAvailable > 0) AND (AmountAvailable <= 0) THEN
                StopPayments := TRUE;
        END;
        PayableVendLedgEntry.RESET();
    end;

    local procedure MakeGenJnlLines()
    var
        DimBuf: Record "Dimension Buffer";
        GenJnlLine1: Record "Gen. Journal Line";
        PurchSetup: Record "Purchases & Payables Setup";
        Vendor: Record Vendor;
        RemainingAmtAvailable: Decimal;
    begin
        TempPaymentBuffer.RESET();
        TempPaymentBuffer.DELETEALL();

        IF BalAccType = BalAccType::"Bank Account" THEN BEGIN
            CheckCurrencies(BalAccType, BalAccNo, PayableVendLedgEntry);
            SetBankAccCurrencyFilter(BalAccType, BalAccNo, PayableVendLedgEntry);
        END;

        IF OriginalAmtAvailable <> 0 THEN BEGIN
            RemainingAmtAvailable := OriginalAmtAvailable;
            RemovePaymentsAboveLimit(PayableVendLedgEntry, RemainingAmtAvailable);
        END;
        IF PayableVendLedgEntry.FIND('-') THEN
            REPEAT
                PayableVendLedgEntry.SETRANGE("Vendor No.", PayableVendLedgEntry."Vendor No.");
                PayableVendLedgEntry.FIND('-');
                REPEAT
                    //>>FOREX
                    IF Vendor."No." <> VendLedgEntry."Vendor No." THEN
                        Vendor.GET(VendLedgEntry."Vendor No.");
                    //<<FOREX
                    VendLedgEntry.GET(PayableVendLedgEntry."Vendor Ledg. Entry No.");
                    SetPostingDate(GenJnlLine1, VendLedgEntry."Due Date", PostingDate);
                    IF VendLedgEntry."Posting Date" <= GenJnlLine1."Posting Date" THEN BEGIN
                        TempPaymentBuffer."Vendor No." := VendLedgEntry."Vendor No.";
                        //FOREX
                        IF Vendor."3 Way Currency Adjmt." THEN
                            TempPaymentBuffer."Currency Code" := 'USD'
                        ELSE
                            //<<FOREX
                            TempPaymentBuffer."Currency Code" := VendLedgEntry."Currency Code";
                        //>>IST 052305 DPC #9806
                        //TODO
                        // TempPaymentBuffer."Contract Note No." := VendLedgEntry."Contract Note No.";
                        // TempPaymentBuffer."Exchange Contract No." := VendLedgEntry."Exchange Contract No.";
                        //<<IST 052305 DPC #9806
                        TempPaymentBuffer."Payment Method Code" := VendLedgEntry."Payment Method Code";
                        TempPaymentBuffer."Creditor No." := VendLedgEntry."Creditor No.";
                        TempPaymentBuffer."Payment Reference" := VendLedgEntry."Payment Reference";
                        TempPaymentBuffer."Exported to Payment File" := VendLedgEntry."Exported to Payment File";
                        TempPaymentBuffer."Applies-to Ext. Doc. No." := VendLedgEntry."External Document No.";

                        SetTempPaymentBufferDims(DimBuf);

                        VendLedgEntry.CALCFIELDS("Remaining Amount");

                        IF SummarizePerVend THEN BEGIN
                            TempPaymentBuffer."Vendor Ledg. Entry No." := 0;
                            IF TempPaymentBuffer.FIND() THEN BEGIN
                                TempPaymentBuffer.Amount := TempPaymentBuffer.Amount + PayableVendLedgEntry.Amount;
                                //>>FOREX
                                //TempPaymentBuffer."USD Value" := TempPaymentBuffer.Amount + PayableVendLedgEntry."USD Value";
                                //TODO
                                // TempPaymentBuffer."USD Value" := TempPaymentBuffer."USD Value" + GetUSDValue(PayableVendLedgEntry.Amount, PayableVendLedgEntry."Currency Code",
                                //    VendLedgEntry."Document No.");
                                //<<FOREX
                                TempPaymentBuffer.MODIFY();
                            END ELSE BEGIN
                                TempPaymentBuffer."Document No." := NextDocNo;
                                NextDocNo := INCSTR(NextDocNo);
                                TempPaymentBuffer.Amount := PayableVendLedgEntry.Amount;
                                //>>FOREX
                                //TempPaymentBuffer."USD Value" := PayableVendLedgEntry."USD Value";
                                //TODO
                                //TempPaymentBuffer."USD Value" := GetUSDValue(PayableVendLedgEntry.Amount, PayableVendLedgEntry."Currency Code", VendLedgEntry."Document No.");
                                //<<FOREX
                                Window2.UPDATE(1, VendLedgEntry."Vendor No.");
                                TempPaymentBuffer.INSERT();
                            END;
                            VendLedgEntry."Applies-to ID" := TempPaymentBuffer."Document No.";
                        END ELSE BEGIN
                            CheckIfEntryAlreadyApplied(GenJnlLine, VendLedgEntry);

                            TempPaymentBuffer."Vendor Ledg. Entry Doc. Type" := VendLedgEntry."Document Type";
                            TempPaymentBuffer."Vendor Ledg. Entry Doc. No." := VendLedgEntry."Document No.";
                            TempPaymentBuffer."Global Dimension 1 Code" := VendLedgEntry."Global Dimension 1 Code";
                            TempPaymentBuffer."Global Dimension 2 Code" := VendLedgEntry."Global Dimension 2 Code";
                            TempPaymentBuffer."Dimension Set ID" := VendLedgEntry."Dimension Set ID";
                            TempPaymentBuffer."Vendor Ledg. Entry No." := VendLedgEntry."Entry No.";
                            TempPaymentBuffer.Amount := PayableVendLedgEntry.Amount;
                            //>>FOREX
                            //TempPaymentBuffer."USD Value" := VendLedgEntry."USD Value";
                            //TODO
                            //TempPaymentBuffer."USD Value" := GetUSDValue(PayableVendLedgEntry.Amount, PayableVendLedgEntry."Currency Code", VendLedgEntry."Document No.");
                            //<<FOREX
                            Window2.UPDATE(1, VendLedgEntry."Vendor No.");
                            TempPaymentBuffer.INSERT();
                        END;

                        VendLedgEntry."Amount to Apply" := VendLedgEntry."Remaining Amount";
                        VendEntryEdit.RUN(VendLedgEntry);
                    END ELSE BEGIN
                        VendorLedgEntryTemp := VendLedgEntry;
                        VendorLedgEntryTemp.INSERT();
                    END;

                    PayableVendLedgEntry.DELETE();
                    IF OriginalAmtAvailable <> 0 THEN BEGIN
                        RemainingAmtAvailable := RemainingAmtAvailable - PayableVendLedgEntry."Amount (LCY)";
                        RemovePaymentsAboveLimit(PayableVendLedgEntry, RemainingAmtAvailable);
                    END;

                UNTIL NOT PayableVendLedgEntry.FINDSET();
                PayableVendLedgEntry.DELETEALL();
                PayableVendLedgEntry.SETRANGE("Vendor No.");
            UNTIL NOT PayableVendLedgEntry.FIND('-');

        CLEAR(OldTempPaymentBuffer);
        TempPaymentBuffer.SETCURRENTKEY("Document No.");
        TempPaymentBuffer.SETFILTER(
          "Vendor Ledg. Entry Doc. Type", '<>%1&<>%2', TempPaymentBuffer."Vendor Ledg. Entry Doc. Type"::Refund,
          TempPaymentBuffer."Vendor Ledg. Entry Doc. Type"::Payment);
        IF TempPaymentBuffer.FIND('-') THEN
            REPEAT
                WITH GenJnlLine DO BEGIN
                    INIT();
                    Window2.UPDATE(1, TempPaymentBuffer."Vendor No.");
                    LastLineNo := LastLineNo + 10000;
                    "Line No." := LastLineNo;
                    "Document Type" := "Document Type"::Payment;
                    "Posting No. Series" := GenJnlBatch."Posting No. Series";
                    IF SummarizePerVend THEN
                        "Document No." := TempPaymentBuffer."Document No."
                    ELSE
                        IF DocNoPerLine THEN BEGIN
                            IF TempPaymentBuffer.Amount < 0 THEN
                                "Document Type" := "Document Type"::Refund;

                            "Document No." := NextDocNo;
                            NextDocNo := INCSTR(NextDocNo);
                        END ELSE
                            IF (TempPaymentBuffer."Vendor No." = OldTempPaymentBuffer."Vendor No.") AND
                               (TempPaymentBuffer."Currency Code" = OldTempPaymentBuffer."Currency Code")
                            THEN
                                "Document No." := OldTempPaymentBuffer."Document No."
                            ELSE BEGIN
                                "Document No." := NextDocNo;
                                NextDocNo := INCSTR(NextDocNo);
                                OldTempPaymentBuffer := TempPaymentBuffer;
                                OldTempPaymentBuffer."Document No." := "Document No.";
                            END;
                    "Account Type" := "Account Type"::Vendor;
                    SetHideValidation(TRUE);
                    ShowPostingDateWarning := ShowPostingDateWarning OR
                      SetPostingDate(GenJnlLine, GetApplDueDate(TempPaymentBuffer."Vendor Ledg. Entry No."), PostingDate);
                    VALIDATE("Account No.", TempPaymentBuffer."Vendor No.");
                    Vendor.GET(TempPaymentBuffer."Vendor No.");
                    IF (Vendor."Pay-to Vendor No." <> '') AND (Vendor."Pay-to Vendor No." <> "Account No.") THEN
                        MESSAGE(Text025, Vendor.TABLECAPTION, Vendor."No.", Vendor.FIELDCAPTION("Pay-to Vendor No."),
                          Vendor."Pay-to Vendor No.");
                    "Bal. Account Type" := BalAccType;
                    VALIDATE("Bal. Account No.", BalAccNo);
                    VALIDATE("Currency Code", TempPaymentBuffer."Currency Code");
                    "Message to Recipient" := GetMessageToRecipient(SummarizePerVend);
                    "Bank Payment Type" := BankPmtType;
                    IF SummarizePerVend THEN BEGIN
                        "Applies-to ID" := "Document No.";
                        Description := STRSUBSTNO(Text014, TempPaymentBuffer."Vendor No.");
                    END ELSE
                        //>>NIF 061405 MAK
                        //        Description :=                                         //Following 4 lines are original code
                        //          STRSUBSTNO(
                        //            Text015,
                        //            TempPaymentBuffer."Vendor Ledg. Entry Doc. Type",
                        //            TempPaymentBuffer."Vendor Ledg. Entry Doc. No.");
                        NIFVendor.GET(TempPaymentBuffer."Vendor No.");
                    //>> NF1.00:CIS.NG  07/08/16
                    //NIFVendLedgEntry.GET(TempPaymentBuffer."Vendor Ledg. Entry No.")
                    IF NIFVendLedgEntry.GET(TempPaymentBuffer."Vendor Ledg. Entry No.") THEN
                        //<< NF1.00:CIS.NG  07/08/16
                        "External Document No." := NIFVendLedgEntry."External Document No.";


                    Description := COPYSTR(STRSUBSTNO(ISTText001, NIFVendor.Name), 1, 50);
                    //<<NIF

                    "Source Line No." := TempPaymentBuffer."Vendor Ledg. Entry No.";
                    "Shortcut Dimension 1 Code" := TempPaymentBuffer."Global Dimension 1 Code";
                    "Shortcut Dimension 2 Code" := TempPaymentBuffer."Global Dimension 2 Code";
                    "Dimension Set ID" := TempPaymentBuffer."Dimension Set ID";
                    "Source Code" := GenJnlTemplate."Source Code";
                    "Reason Code" := GenJnlBatch."Reason Code";

                    //>> IST 052305 DPC #9806
                    /*
                    VALIDATE(Amount,TempPaymentBuffer.Amount);
                    "Applies-to Doc. Type" := TempPaymentBuffer."Vendor Ledg. Entry Doc. Type";
                    "Applies-to Doc. No." := TempPaymentBuffer."Vendor Ledg. Entry Doc. No.";
                    */
                    //>>NF1.00:CIS.RAM
                    /*
                    IF NOT Use4x THEN BEGIN
                    */
                    //>>FOREX
                    IF Vendor."3 Way Currency Adjmt." THEN BEGIN
                        //TODO
                        //VALIDATE(Amount, TempPaymentBuffer."USD Value");
                        "Document No." := TempPaymentBuffer."Vendor Ledg. Entry Doc. No.";
                        PurchSetup.GET();
                        //IF NOT PurchSetup."3-way Balance Sheet solution" THEN BEGIN
                        "Applies-to Doc. Type" := TempPaymentBuffer."Vendor Ledg. Entry Doc. Type";
                        "Applies-to Doc. No." := TempPaymentBuffer."Vendor Ledg. Entry Doc. No.";
                        //END;
                    END ELSE BEGIN
                        //<<FOREX
                        VALIDATE(Amount, TempPaymentBuffer.Amount);
                        "Applies-to Doc. Type" := TempPaymentBuffer."Vendor Ledg. Entry Doc. Type";
                        "Applies-to Doc. No." := TempPaymentBuffer."Vendor Ledg. Entry Doc. No.";
                    END; //FOREX
                    "Payment Method Code" := TempPaymentBuffer."Payment Method Code";
                    "Creditor No." := TempPaymentBuffer."Creditor No.";
                    "Payment Reference" := TempPaymentBuffer."Payment Reference";
                    "Exported to Payment File" := TempPaymentBuffer."Exported to Payment File";
                    "Applies-to Ext. Doc. No." := TempPaymentBuffer."Applies-to Ext. Doc. No.";

                    UpdateDimensions(GenJnlLine);
                    INSERT();
                    /*
                    END ELSE BEGIN
                      PurchInvLine.SETRANGE("Document No.", TempPaymentBuffer."Vendor Ledg. Entry Doc. No.");
                      PurchInvLine.SETRANGE(Type, PurchInvLine.Type::Item);
                      Bank4XContract.INIT;
                      IF PurchInvLine.FIND('-') THEN
                        REPEAT
                          IF Bank4XContract.GET(PurchInvLine."Exchange Contract No.") THEN BEGIN
                            Bank4XContract.VALIDATE(RemainingAmount);
                            _Avaliable := Bank4XContract.RemainingAmount;
                            IF _Avaliable < 0 THEN
                              ERROR('Not enough JPY left...\%1', _Avaliable);

                            _Remaining := PurchInvLine.Amount;
                            "Contract Note No." := PurchInvLine."Contract Note No.";
                            REPEAT
                              LastLineNo := LastLineNo + 10000;
                              "Line No." := LastLineNo;

                              IF _Avaliable > _Remaining THEN BEGIN
                                VALIDATE(Amount,_Remaining);
                                "Currency Code" := 'JPY';
                                VALIDATE("Currency Factor", Bank4XContract.ExchangeRate);
                                VALIDATE("Exchange Contract No.", Bank4XContract."No.");
                                "Currency Code" := 'JPY';
                                _Remaining := 0;
                              END ELSE BEGIN
                                IF _Avaliable <> 0 THEN BEGIN
                                  VALIDATE(Amount,_Avaliable);
                                  VALIDATE("Currency Factor", Bank4XContract.ExchangeRate);
                                  VALIDATE("Exchange Contract No.", Bank4XContract."No.");
                                  "Currency Code" := 'JPY';
                                  _Remaining := _Remaining - _Avaliable;
                                  _Avaliable := 0;
                                END ELSE BEGIN
                                  //MESSAGE('%1', _Remaining);
                                  Amount := _Remaining;
                                  "Exchange Contract No." := 'SPOT';
                                  "Currency Code" :=  'JPY';
                                  "Currency Factor" := 1;
                                  "Amount (LCY)" := 0;
                                  _Remaining := 0;
                                END;
                              END;

                              "Applies-to Doc. Type" := TempPaymentBuffer."Vendor Ledg. Entry Doc. Type";
                              "Applies-to Doc. No." := TempPaymentBuffer."Vendor Ledg. Entry Doc. No.";
                              "Payment Method Code" := TempPaymentBuffer."Payment Method Code";
                              "Creditor No." := TempPaymentBuffer."Creditor No.";
                              "Payment Reference" := TempPaymentBuffer."Payment Reference";
                              "Exported to Payment File" := TempPaymentBuffer."Exported to Payment File";
                              "Applies-to Ext. Doc. No." := TempPaymentBuffer."Applies-to Ext. Doc. No.";

                              UpdateDimensions(GenJnlLine);
                              INSERT;
                            UNTIL _Remaining = 0;
                          END; // ELSE                          //090606 MAK - Removed ";", added "ELSE"
                          //>>MAK 090606
                          ///BEGIN
                          ///  LastLineNo := LastLineNo + 10000;
                          ///  "Line No." := LastLineNo;
                          ///  VALIDATE(Amount, 1.55);
                          ///  VALIDATE("Currency Factor", 1.00);
                          ///  VALIDATE("Currency Code", 'JPY');
                          ///  "Applies-to Doc. Type" := TempPaymentBuffer."Vendor Ledg. Entry Doc. Type";
                          ///  "Applies-to Doc. No." := TempPaymentBuffer."Vendor Ledg. Entry Doc. No.";
                          ///  INSERT(TRUE);
                          ///END;
                          //<<MAK 090606
                        UNTIL PurchInvLine.NEXT = 0;
                    END;
                    //<< IST 052305 DPC #9806
                    */
                    //<<NF1.00:CIS.RAM
                    GenJnlLineInserted := TRUE;
                END;
            UNTIL TempPaymentBuffer.NEXT() = 0;

    end;

    local procedure UpdateDimensions(var GenJnlLine: Record "Gen. Journal Line")
    var
        DimBuf: Record "Dimension Buffer";
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
        TempDimSetEntry2: Record "Dimension Set Entry" temporary;
        DimVal: Record "Dimension Value";
        DimSetIDArr: array[10] of Integer;
        NewDimensionID: Integer;
    begin
        WITH GenJnlLine DO BEGIN
            NewDimensionID := "Dimension Set ID";
            IF SummarizePerVend THEN BEGIN
                DimBuf.RESET();
                DimBuf.DELETEALL();
                DimBufMgt.GetDimensions(TempPaymentBuffer."Dimension Entry No.", DimBuf);
                IF DimBuf.FINDSET() THEN
                    REPEAT
                        DimVal.GET(DimBuf."Dimension Code", DimBuf."Dimension Value Code");
                        TempDimSetEntry."Dimension Code" := DimBuf."Dimension Code";
                        TempDimSetEntry."Dimension Value Code" := DimBuf."Dimension Value Code";
                        TempDimSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
                        TempDimSetEntry.INSERT();
                    UNTIL DimBuf.NEXT() = 0;
                NewDimensionID := DimMgt.GetDimensionSetID(TempDimSetEntry);
                "Dimension Set ID" := NewDimensionID;
            END;
            //TODO
            /* CreateDim(
              DimMgt.TypeToTableID1("Account Type"), "Account No.",
              DimMgt.TypeToTableID1("Bal. Account Type"), "Bal. Account No.",
              DATABASE::Job, "Job No.",
              DATABASE::"Salesperson/Purchaser", "Salespers./Purch. Code",
              DATABASE::Campaign, "Campaign No."); */
            IF NewDimensionID <> "Dimension Set ID" THEN BEGIN
                DimSetIDArr[1] := "Dimension Set ID";
                DimSetIDArr[2] := NewDimensionID;
                "Dimension Set ID" :=
                  DimMgt.GetCombinedDimensionSetID(DimSetIDArr, "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            END;

            IF SummarizePerVend THEN BEGIN
                DimMgt.GetDimensionSet(TempDimSetEntry, "Dimension Set ID");
                AdjustAgainstSelectedDim(TempDimSetEntry, TempDimSetEntry2);
                "Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry2);
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code",
                  "Shortcut Dimension 2 Code");
            END;
        END;
    end;

    local procedure CheckIfEntryAlreadyApplied(GenJnlLine3: Record "Gen. Journal Line"; VendLedgEntry2: Record "Vendor Ledger Entry")
    var
        GenJnlLine4: Record "Gen. Journal Line";
    begin
        GenJnlLine4.RESET();
        GenJnlLine4.SETCURRENTKEY(
          "Account Type", "Account No.", "Applies-to Doc. Type", "Applies-to Doc. No.");
        GenJnlLine4.SETRANGE("Journal Template Name", GenJnlLine3."Journal Template Name");
        GenJnlLine4.SETRANGE("Journal Batch Name", GenJnlLine3."Journal Batch Name");
        GenJnlLine4.SETRANGE("Account Type", GenJnlLine4."Account Type"::Vendor);
        GenJnlLine4.SETRANGE("Account No.", VendLedgEntry2."Vendor No.");
        GenJnlLine4.SETRANGE("Applies-to Doc. Type", VendLedgEntry2."Document Type");
        GenJnlLine4.SETRANGE("Applies-to Doc. No.", VendLedgEntry2."Document No.");
        IF GenJnlLine4.FINDFIRST() THEN
            GenJnlLine4.FIELDERROR(
              "Applies-to Doc. No.",
              STRSUBSTNO(
                Text016,
                VendLedgEntry2."Document Type", VendLedgEntry2."Document No.",
                VendLedgEntry2."Vendor No."));
    end;

    local procedure SetBankAccCurrencyFilter(BalAccType: Option "G/L Account",Customer,Vendor,"Bank Account"; BalAccNo: Code[20]; var TmpPayableVendLedgEntry: Record "Payable Vendor Ledger Entry")
    var
        BankAcc: Record "Bank Account";
    begin
        IF BalAccType = BalAccType::"Bank Account" THEN
            IF BalAccNo <> '' THEN BEGIN
                BankAcc.GET(BalAccNo);
                IF BankAcc."Currency Code" <> '' THEN
                    TmpPayableVendLedgEntry.SETRANGE("Currency Code", BankAcc."Currency Code");
            END;
    end;

    local procedure ShowMessage(Text: Text)
    begin
        IF GenJnlLineInserted THEN BEGIN
            IF ShowPostingDateWarning THEN
                Text += ReplacePostingDateMsg;
            IF Text <> '' THEN
                MESSAGE(Text);
        END;
    end;

    local procedure CheckCurrencies(BalAccType: Option "G/L Account",Customer,Vendor,"Bank Account"; BalAccNo: Code[20]; var TmpPayableVendLedgEntry: Record "Payable Vendor Ledger Entry")
    var
        BankAcc: Record "Bank Account";
        TmpPayableVendLedgEntry2: Record "Payable Vendor Ledger Entry" temporary;
    begin
        IF BalAccType = BalAccType::"Bank Account" THEN
            IF BalAccNo <> '' THEN BEGIN
                BankAcc.GET(BalAccNo);
                IF BankAcc."Currency Code" <> '' THEN BEGIN
                    TmpPayableVendLedgEntry2.RESET();
                    TmpPayableVendLedgEntry2.DELETEALL();
                    IF TmpPayableVendLedgEntry.FIND('-') THEN
                        REPEAT
                            TmpPayableVendLedgEntry2 := TmpPayableVendLedgEntry;
                            TmpPayableVendLedgEntry2.INSERT();
                        UNTIL TmpPayableVendLedgEntry.NEXT() = 0;

                    TmpPayableVendLedgEntry2.SETFILTER("Currency Code", '<>%1', BankAcc."Currency Code");
                    SeveralCurrencies := SeveralCurrencies OR TmpPayableVendLedgEntry2.FINDFIRST();

                    IF SeveralCurrencies THEN
                        MessageText :=
                          STRSUBSTNO(Text020, BankAcc.FIELDCAPTION("Currency Code"), BankAcc."Currency Code")
                    ELSE
                        MessageText :=
                          STRSUBSTNO(Text021, BankAcc.FIELDCAPTION("Currency Code"), BankAcc."Currency Code");
                END ELSE
                    MessageText := Text022;
            END;
    end;

    procedure ClearNegative()
    var
        TempCurrency: Record Currency temporary;
        PayableVendLedgEntry2: Record "Payable Vendor Ledger Entry" temporary;
        CurrencyBalance: Decimal;
    begin
        CLEAR(PayableVendLedgEntry);
        PayableVendLedgEntry.SETRANGE("Vendor No.", Vendor."No.");

        WHILE PayableVendLedgEntry.NEXT() <> 0 DO BEGIN
            TempCurrency.Code := PayableVendLedgEntry."Currency Code";
            CurrencyBalance := 0;
            IF TempCurrency.INSERT() THEN BEGIN
                PayableVendLedgEntry2 := PayableVendLedgEntry;
                PayableVendLedgEntry.SETRANGE("Currency Code", PayableVendLedgEntry."Currency Code");
                REPEAT
                    CurrencyBalance := CurrencyBalance + PayableVendLedgEntry."Amount (LCY)"
                UNTIL PayableVendLedgEntry.NEXT() = 0;
                IF CurrencyBalance < 0 THEN
                    PayableVendLedgEntry.DELETEALL();
                PayableVendLedgEntry.SETRANGE("Currency Code");
                PayableVendLedgEntry := PayableVendLedgEntry2;
            END;
        END;
        PayableVendLedgEntry.RESET();
    end;

    local procedure DimCodeIsInDimBuf(DimCode: Code[20]; DimBuf: Record "Dimension Buffer"): Boolean
    begin
        DimBuf.RESET();
        DimBuf.SETRANGE("Dimension Code", DimCode);
        EXIT(NOT DimBuf.ISEMPTY);
    end;

    local procedure RemovePaymentsAboveLimit(var PayableVendLedgEntry: Record "Payable Vendor Ledger Entry"; RemainingAmtAvailable: Decimal)
    begin
        PayableVendLedgEntry.SETFILTER("Amount (LCY)", '>%1', RemainingAmtAvailable);
        PayableVendLedgEntry.DELETEALL();
        PayableVendLedgEntry.SETRANGE("Amount (LCY)");
    end;

    local procedure InsertDimBuf(var DimBuf: Record "Dimension Buffer"; TableID: Integer; EntryNo: Integer; DimCode: Code[20]; DimValue: Code[20])
    begin
        DimBuf.INIT();
        DimBuf."Table ID" := TableID;
        DimBuf."Entry No." := EntryNo;
        DimBuf."Dimension Code" := DimCode;
        DimBuf."Dimension Value Code" := DimValue;
        DimBuf.INSERT();
    end;

    local procedure GetMessageToRecipient(SummarizePerVend: Boolean): Text[70]
    begin
        IF SummarizePerVend THEN
            EXIT(CompanyInformation.Name);
        EXIT(
          STRSUBSTNO(
            MessageToRecipientMsg,
            TempPaymentBuffer."Vendor Ledg. Entry Doc. Type",
            TempPaymentBuffer."Applies-to Ext. Doc. No."));
    end;

    local procedure SetPostingDate(var GenJnlLine: Record "Gen. Journal Line"; DueDate: Date; PostingDate: Date): Boolean
    begin
        IF NOT UseDueDateAsPostingDate THEN BEGIN
            GenJnlLine.VALIDATE("Posting Date", PostingDate);
            EXIT(FALSE);
        END;

        IF DueDate = 0D THEN
            DueDate := GenJnlLine.GetAppliesToDocDueDate();
        EXIT(GenJnlLine.SetPostingDateAsDueDate(DueDate, DueDateOffset));
    end;

    local procedure GetApplDueDate(VendLedgEntryNo: Integer): Date
    var
        AppliedVendLedgEntry: Record "Vendor Ledger Entry";
    begin
        IF AppliedVendLedgEntry.GET(VendLedgEntryNo) THEN
            EXIT(AppliedVendLedgEntry."Due Date");

        EXIT(PostingDate);
    end;

    local procedure AdjustAgainstSelectedDim(var TempDimSetEntry: Record "Dimension Set Entry" temporary; var TempDimSetEntry2: Record "Dimension Set Entry" temporary)
    begin
        IF SelectedDim.FINDSET() THEN
            REPEAT
                TempDimSetEntry.SETRANGE("Dimension Code", SelectedDim."Dimension Code");
                IF TempDimSetEntry.FINDFIRST() THEN BEGIN
                    TempDimSetEntry2.TRANSFERFIELDS(TempDimSetEntry, TRUE);
                    TempDimSetEntry2.INSERT();
                END;
            UNTIL SelectedDim.NEXT() = 0;
    end;

    local procedure SetTempPaymentBufferDims(var DimBuf: Record "Dimension Buffer")
    var
        GLSetup: Record "General Ledger Setup";
        EntryNo: Integer;
    begin
        IF SummarizePerDim THEN BEGIN
            DimBuf.RESET();
            DimBuf.DELETEALL();
            IF SelectedDim.FIND('-') THEN
                REPEAT
                    IF DimSetEntry.GET(
                         VendLedgEntry."Dimension Set ID", SelectedDim."Dimension Code")
                    THEN
                        InsertDimBuf(DimBuf, DATABASE::"Dimension Buffer", 0, DimSetEntry."Dimension Code",
                          DimSetEntry."Dimension Value Code");
                UNTIL SelectedDim.NEXT() = 0;
            EntryNo := DimBufMgt.FindDimensions(DimBuf);
            IF EntryNo = 0 THEN
                EntryNo := DimBufMgt.InsertDimensions(DimBuf);
            TempPaymentBuffer."Dimension Entry No." := EntryNo;
            IF TempPaymentBuffer."Dimension Entry No." <> 0 THEN BEGIN
                GLSetup.GET();
                IF DimCodeIsInDimBuf(GLSetup."Global Dimension 1 Code", DimBuf) THEN
                    TempPaymentBuffer."Global Dimension 1 Code" := VendLedgEntry."Global Dimension 1 Code"
                ELSE
                    TempPaymentBuffer."Global Dimension 1 Code" := '';
                IF DimCodeIsInDimBuf(GLSetup."Global Dimension 2 Code", DimBuf) THEN
                    TempPaymentBuffer."Global Dimension 2 Code" := VendLedgEntry."Global Dimension 2 Code"
                ELSE
                    TempPaymentBuffer."Global Dimension 2 Code" := '';
            END ELSE BEGIN
                TempPaymentBuffer."Global Dimension 1 Code" := '';
                TempPaymentBuffer."Global Dimension 2 Code" := '';
            END;
            TempPaymentBuffer."Dimension Set ID" := VendLedgEntry."Dimension Set ID";
        END ELSE BEGIN
            TempPaymentBuffer."Dimension Entry No." := 0;
            TempPaymentBuffer."Global Dimension 1 Code" := '';
            TempPaymentBuffer."Global Dimension 2 Code" := '';
            TempPaymentBuffer."Dimension Set ID" := 0;
        END;
    end;

    procedure ">>>IST"()
    begin
    end;

    procedure Set4xValues(Spot: Decimal; enable: Boolean)
    begin
        "4xSpotRate" := Spot;
        Use4x := enable;
    end;

    local procedure GetUSDValue(InputFCY: Decimal; InputCurrency: Code[20]; OriginalInvoiceNumber: Code[20]): Decimal
    var
        CurrExchRate: Record "Currency Exchange Rate";
        GLSetup: Record "General Ledger Setup";
        PINVH: Record "Purch. Inv. Header";
        MXNValue: Decimal;
        ReturnUSDValue: Decimal;
    begin
        //NF1.00:CIS.RAM FOREX
        //MESSAGE('%1',InputFCY);
        GLSetup.GET();
        ReturnUSDValue := 0;
        /*
        ReturnUSDValue :=
          ROUND(
            "3WayCurrExchRate".ExchangeAmtFCYToUSD(
              WORKDATE,
              InputCurrency,
              'USD',                  //This is always USD
              InputFCY), //This is the Peso amount to be converted to USD value
            GLSetup."Unit-Amount Rounding Precision");
        EXIT(ReturnUSDValue);
        //NF1.00:CIS.RAM FOREX
        */

        PINVH.RESET();
        //>> NF1.00:CIS.NG  08/04/16
        //PINVH.GET(OriginalInvoiceNumber);
        IF NOT PINVH.GET(OriginalInvoiceNumber) THEN
            EXIT(0);
        //<< NF1.00:CIS.NG  08/04/16

        //  EXIT(0);
        PINVH.TESTFIELD("Currency Factor");
        MXNValue := CurrExchRate.ExchangeAmtFCYToLCY(
              WORKDATE(), PINVH."Currency Code",
              InputFCY, PINVH."Currency Factor");
        //MESSAGE('MXN%1',MXNValue);

        ReturnUSDValue := CurrExchRate.ExchangeAmtFCYToFCY(
              WORKDATE(), '', 'USD',
              MXNValue);
        //MESSAGE('USD %1',ReturnUSDValue); //This is the Peso amount to be converted to USD value

        EXIT(ReturnUSDValue);

    end;
}

