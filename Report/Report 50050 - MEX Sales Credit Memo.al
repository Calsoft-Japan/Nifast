report 50050 "MEX Sales Credit Memo"
{
    // NF1.00:CIS.CM    09/29/15 Update for New Vision Removal Task
    // >> NIF
    // Date     Init   Proj   Desc
    // 07-10-05 RTT           new field "Revision No."
    // 07-14-05 RTT           code at SalesInvLine-OAfterTGetRecord to zero out ordered qty
    // << NIF
    DefaultLayout = RDLC;
    RDLCLayout = '.\RDLC\MEX Sales Credit Memo.rdlc';


    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "Bill-to Customer No.", "Ship-to Code", "No. Printed";
            RequestFilterHeading = 'Sales Invoice';
            dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");

                trigger OnAfterGetRecord()
                begin
                    TempSalesCreditMemoLine := "Sales Cr.Memo Line";
                    TempSalesCreditMemoLine.INSERT;
                    HighestLineNo := "Line No.";
                end;

                trigger OnPreDataItem()
                begin
                    TempSalesCreditMemoLine.RESET;
                    TempSalesCreditMemoLine.DELETEALL;
                end;
            }
            dataitem("Sales Comment Line"; "Sales Comment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.", "Line No.")
                                    WHERE("Document Type" = CONST("Posted Credit Memo"));//, "Print On Credit Memo"=CONST(Yes)); BC Upgrade

                trigger OnAfterGetRecord()
                begin
                    TempSalesCreditMemoLine.INIT;
                    TempSalesCreditMemoLine."Document No." := "Sales Cr.Memo Header"."No.";
                    TempSalesCreditMemoLine."Line No." := HighestLineNo + 1000;
                    HighestLineNo := TempSalesCreditMemoLine."Line No.";

                    IF STRLEN(Comment) <= MAXSTRLEN(TempSalesCreditMemoLine.Description) THEN BEGIN
                        TempSalesCreditMemoLine.Description := Comment;
                        TempSalesCreditMemoLine."Description 2" := '';
                    END ELSE BEGIN
                        SpacePointer := MAXSTRLEN(TempSalesCreditMemoLine.Description) + 1;
                        WHILE (SpacePointer > 1) AND (Comment[SpacePointer] <> ' ') DO
                            SpacePointer := SpacePointer - 1;
                        IF SpacePointer = 1 THEN
                            SpacePointer := MAXSTRLEN(TempSalesCreditMemoLine.Description) + 1;
                        TempSalesCreditMemoLine.Description := COPYSTR(Comment, 1, SpacePointer - 1);
                        TempSalesCreditMemoLine."Description 2" :=
                          COPYSTR(COPYSTR(Comment, SpacePointer + 1), 1, MAXSTRLEN(TempSalesCreditMemoLine."Description 2"));
                    END;
                    TempSalesCreditMemoLine.INSERT;
                end;
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(Sales_Cr_Memo_Header_No_; "Sales Cr.Memo Header"."No.")
                    {
                    }
                    column(CopyNo; CopyNo)
                    {
                    }
                    column(BillToAddress_1_; BillToAddress[1])
                    {
                    }
                    column(mCustomer__VAT_Registration_No__; mCustomer."VAT Registration No.")
                    {
                    }
                    column(tLongAddress; tLongAddress)
                    {
                    }
                    column(tLongCityState; tLongCityState)
                    {
                    }
                    column(Sales_Cr_Memo_Header___No______________Sales_Cr_Memo_Header___Mex__Factura_No__; "Sales Cr.Memo Header"."No." + ' / ' + "Sales Cr.Memo Header"."Mex. Factura No.")
                    {
                    }
                    column(tDayText; tDayText)
                    {
                    }
                    column(tMonText; tMonText)
                    {
                    }
                    column(tYrText; tYrText)
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    column(PrintFooter; PrintFooter)
                    {
                    }
                    dataitem(SalesCrMemo; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(STRSUBSTNO_Text001_CurrReport_PAGENO___1_; STRSUBSTNO(Text001, 1))//CurrReport.PAGENO - 1))BC Upgrade
                        {
                        }
                        column(TempSalesCreditMemoLine__Unit_of_Measure_; TempSalesCreditMemoLine."Unit of Measure")
                        {
                        }
                        column(TempSalesCreditMemoLine_Quantity; TempSalesCreditMemoLine.Quantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(UnitPriceToPrint; UnitPriceToPrint)
                        {
                            DecimalPlaces = 2 : 5;
                        }
                        column(AmountExclInvDisc; AmountExclInvDisc)
                        {
                        }
                        column(TempSalesCreditMemoLine__No__________TempSalesCreditMemoLine_Description; TempSalesCreditMemoLine."No." + '  ' + TempSalesCreditMemoLine.Description)
                        {
                        }
                        column(STRSUBSTNO_Text002_CurrReport_PAGENO___1_; STRSUBSTNO(Text002, 1))//CurrReport.PAGENO + 1))BC Upgrade
                        {
                        }
                        column(AmountExclInvDisc_Control79; AmountExclInvDisc)
                        {
                        }
                        column(TempSalesCreditMemoLine__Amount_Including_VAT____TempSalesCreditMemoLine_Amount; TempSalesCreditMemoLine."Amount Including VAT" - TempSalesCreditMemoLine.Amount)
                        {
                        }
                        column(TempSalesCreditMemoLine__Amount_Including_VAT_; TempSalesCreditMemoLine."Amount Including VAT")
                        {
                        }
                        column(TotalTaxLabel; TotalTaxLabel)
                        {
                        }
                        column(Sales_Cr_Memo_Header___Currency_Code_; '$' + "Sales Cr.Memo Header"."Currency Code")
                        {
                            //DecimalPlaces = 2 : 5;
                        }
                        column(Subtotal_Caption; Subtotal_CaptionLbl)
                        {
                        }
                        column(SalesCrMemo_Number; Number)
                        {
                        }
                        dataitem("<Sales Comment Line2>"; "Sales Comment Line")
                        {
                            DataItemTableView = SORTING("Document Type", "No.", "Line No.", Date)
                                                WHERE("Document Type" = CONST("Posted Credit Memo"));//,"Print On Credit Memo"=CONST(Yes)); BC Upgrade
                            column(Sales_Line_Comment_Line_Comment; Comment)
                            {
                            }
                            column(Sales_Line_Comment_Line_Document_Type; "Document Type")
                            {
                            }
                            column(Sales_Line_Comment_Line_No_; "No.")
                            {
                            }
                            column(Sales_Line_Comment_Line_Doc__Line_No_; "Document Line No.")
                            {
                            }
                            column(Sales_Line_Comment_Line_Line_No_; "Line No.")
                            {
                            }

                            trigger OnPreDataItem()
                            begin
                                SETRANGE("No.", TempSalesCreditMemoLine."Document No.");
                                //SETRANGE("Doc. Line No.",TempSalesCreditMemoLine."Line No.");  //NF1.00:CIS.CM 09-29-15-O
                                SETRANGE("Document Line No.", TempSalesCreditMemoLine."Line No.");  //NF1.00:CIS.CM 09-29-15-N
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            OnLineNumber := OnLineNumber + 1;

                            IF OnLineNumber = 1 THEN
                                TempSalesCreditMemoLine.FIND('-')
                            ELSE
                                TempSalesCreditMemoLine.NEXT;

                            IF TempSalesCreditMemoLine.Type = TempSalesCreditMemoLine.Type::" " THEN BEGIN
                                TempSalesCreditMemoLine."No." := '';
                                TempSalesCreditMemoLine."Unit of Measure" := '';
                                TempSalesCreditMemoLine.Amount := 0;
                                TempSalesCreditMemoLine."Amount Including VAT" := 0;
                                TempSalesCreditMemoLine."Inv. Discount Amount" := 0;
                                TempSalesCreditMemoLine.Quantity := 0;
                            END ELSE IF TempSalesCreditMemoLine.Type = TempSalesCreditMemoLine.Type::"G/L Account" THEN
                                    TempSalesCreditMemoLine."No." := '';

                            IF TempSalesCreditMemoLine.Amount <> TempSalesCreditMemoLine."Amount Including VAT" THEN BEGIN
                                TaxFlag := TRUE;
                                TaxLiable := TempSalesCreditMemoLine.Amount;
                            END ELSE BEGIN
                                TaxFlag := FALSE;
                                TaxLiable := 0;
                            END;

                            AmountExclInvDisc := TempSalesCreditMemoLine.Amount + TempSalesCreditMemoLine."Inv. Discount Amount";

                            IF TempSalesCreditMemoLine.Quantity = 0 THEN
                                UnitPriceToPrint := 0  // so it won't print
                                                       //>>NIF 02/14/06 RTT
                            ELSE IF TempSalesCreditMemoLine."Line Discount Amount" = 0 THEN
                                UnitPriceToPrint := TempSalesCreditMemoLine."Unit Price"
                            //<<NIF 02/14/06 RTT
                            ELSE
                                UnitPriceToPrint := ROUND(AmountExclInvDisc / TempSalesCreditMemoLine.Quantity, 0.00001);

                            IF OnLineNumber = NumberOfLines THEN
                                PrintFooter := TRUE;
                        end;

                        trigger OnPreDataItem()
                        begin
                            //CurrReport.CREATETOTALS(TaxLiable, AmountExclInvDisc, TempSalesCreditMemoLine.Amount, TempSalesCreditMemoLine."Amount Including VAT");BC Upgrade
                            NumberOfLines := TempSalesCreditMemoLine.COUNT;
                            SETRANGE(Number, 1, NumberOfLines);
                            OnLineNumber := 0;
                            PrintFooter := FALSE;

                            //>>NIF 04/20/06 RTT
                            CLEAR(LineCounter);
                            //<<NIF 04/20/06 RTT
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    //CurrReport.PAGENO := 1;BC Upgrade

                    IF CopyNo = NoLoops THEN BEGIN
                        IF NOT CurrReport.PREVIEW THEN
                            SalesCrMemoPrinted.RUN("Sales Cr.Memo Header");
                        CurrReport.BREAK;
                    END ELSE
                        CopyNo := CopyNo + 1;
                    IF CopyNo = 1 THEN // Original
                        CLEAR(CopyTxt)
                    ELSE
                        CopyTxt := Text000;
                end;

                trigger OnPreDataItem()
                begin
                    NoLoops := 1 + ABS(NoCopies) + Customer."Invoice Copies";
                    IF NoLoops <= 0 THEN
                        NoLoops := 1;
                    CopyNo := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF PrintCompany THEN BEGIN
                    IF RespCenter.GET("Responsibility Center") THEN BEGIN
                        FormatAddress.RespCenter(CompanyAddress, RespCenter);
                        CompanyInformation."Phone No." := RespCenter."Phone No.";
                        CompanyInformation."Fax No." := RespCenter."Fax No.";
                    END;
                END;

                Language_T.Reset();//BC Upgrade 2025-06-23
                Language_T.Get("Language Code");//BC Upgrade 2025-06-23
                CurrReport.LANGUAGE := Language_T."Windows Language ID";//BC Upgrade 2025-06-23
                //Language.GetLanguageID("Language Code"); BC Upgrade 2025-06-23

                //>>NIF 042006 RTT
                GetRemissionText();
                //<<NIF 042006 RTT

                //>>NIF 050506 MAK
                CLEAR(tDayText);
                CLEAR(tMonText);
                CLEAR(tYrText);
                tDayText := FORMAT(DATE2DMY("Posting Date", 1));
                tMonText := FORMAT(DATE2DMY("Posting Date", 2));
                tYrText := FORMAT(DATE2DMY("Posting Date", 3));
                IF STRLEN(FORMAT(tDayText)) = 1 THEN tDayText := '0' + FORMAT(tDayText);
                IF STRLEN(FORMAT(tMonText)) = 1 THEN tMonText := '0' + FORMAT(tMonText);

                CLEAR(tLongAddress);
                CLEAR(tLongCityState);
                CLEAR(mCountry);
                IF "Bill-to Country/Region Code" <> '' THEN
                    mCountry.GET("Bill-to Country/Region Code");
                IF STRLEN(FORMAT("Bill-to Address 2")) > 0 THEN
                    tLongAddress := FORMAT("Bill-to Address") + ', ' + FORMAT("Bill-to Address 2")
                ELSE
                    tLongAddress := FORMAT("Bill-to Address");
                tLongCityState := FORMAT("Bill-to City") + ', ' + FORMAT("Bill-to County") + '  ' + FORMAT("Bill-to Post Code") +
                  '     ' + FORMAT(mCountry.Name);

                mCustomer.GET("Bill-to Customer No.");
                //<<NIF 050506 MAK

                IF "Salesperson Code" = '' THEN
                    CLEAR(SalesPurchPerson)
                ELSE
                    SalesPurchPerson.GET("Salesperson Code");

                IF "Inside Salesperson Code" = '' THEN
                    CLEAR(SalesPurchPerson2)
                ELSE
                    SalesPurchPerson2.GET("Inside Salesperson Code");

                FormatAddress.SalesCrMemoBillTo(BillToAddress, "Sales Cr.Memo Header");
                FormatAddress.SalesCrMemoShipTo(ShipToAddress, BillToAddress, "Sales Cr.Memo Header");//BC Upgrade

                IF "Payment Terms Code" = '' THEN
                    CLEAR(PaymentTerms)
                ELSE
                    PaymentTerms.GET("Payment Terms Code");

                IF "Shipment Method Code" = '' THEN
                    CLEAR(ShipmentMethod)
                ELSE
                    ShipmentMethod.GET("Shipment Method Code");

                Customer.GET("Bill-to Customer No.");

                IF LogInteraction THEN
                    IF NOT CurrReport.PREVIEW THEN BEGIN
                        SegManagement.LogDocument(
                          6, "No.", 0, 0, DATABASE::Customer, "Sell-to Customer No.", "Salesperson Code",
                          "Campaign No.", "Posting Description", '');
                    END;


                CLEAR(BreakdownTitle);
                CLEAR(BreakdownLabel);
                CLEAR(BreakdownAmt);
                TotalTaxLabel := Text008;
                TaxRegNo := '';
                TaxRegLabel := '';
                IF "Tax Area Code" <> '' THEN BEGIN
                    TaxArea.GET("Tax Area Code");
                    CASE TaxArea."Country/Region" OF
                        TaxArea."Country/Region"::US:
                            TotalTaxLabel := Text005;
                        TaxArea."Country/Region"::CA:
                            BEGIN
                                TotalTaxLabel := Text007;
                                TaxRegNo := CompanyInformation."VAT Registration No.";
                                TaxRegLabel := CompanyInformation.FIELDCAPTION("VAT Registration No.");
                            END;
                    END;
                    SalesTaxCalc.StartSalesTaxCalculation;
                    IF TaxArea."Use External Tax Engine" THEN
                        SalesTaxCalc.CallExternalTaxEngineForDoc(DATABASE::"Sales Cr.Memo Header", 0, "No.")
                    ELSE BEGIN
                        SalesTaxCalc.AddSalesCrMemoLines("No.");
                        SalesTaxCalc.EndSalesTaxCalculation("Posting Date");
                    END;
                    SalesTaxCalc.GetSummarizedSalesTaxTable(TempSalesTaxAmtLine);
                    BrkIdx := 0;
                    PrevPrintOrder := 0;
                    PrevTaxPercent := 0;

                    TempSalesTaxAmtLine.RESET;
                    TempSalesTaxAmtLine.SETCURRENTKEY("Print Order", "Tax Area Code for Key", "Tax Jurisdiction Code");
                    IF TempSalesTaxAmtLine.FIND('-') THEN
                        REPEAT
                            IF (TempSalesTaxAmtLine."Print Order" = 0) OR
                               (TempSalesTaxAmtLine."Print Order" <> PrevPrintOrder) OR
                               (TempSalesTaxAmtLine."Tax %" <> PrevTaxPercent)
                            THEN BEGIN
                                BrkIdx := BrkIdx + 1;
                                IF BrkIdx > 1 THEN BEGIN
                                    IF TaxArea."Country/Region" = TaxArea."Country/Region"::CA THEN
                                        BreakdownTitle := Text006
                                    ELSE
                                        BreakdownTitle := Text003;
                                END;
                                IF BrkIdx > ARRAYLEN(BreakdownAmt) THEN BEGIN
                                    BrkIdx := BrkIdx - 1;
                                    BreakdownLabel[BrkIdx] := Text004;
                                END ELSE
                                    BreakdownLabel[BrkIdx] := STRSUBSTNO(TempSalesTaxAmtLine."Print Description", TempSalesTaxAmtLine."Tax %");
                            END;
                            BreakdownAmt[BrkIdx] := BreakdownAmt[BrkIdx] + TempSalesTaxAmtLine."Tax Amount";
                        UNTIL TempSalesTaxAmtLine.NEXT = 0;

                    IF BrkIdx = 1 THEN BEGIN
                        CLEAR(BreakdownLabel);
                        CLEAR(BreakdownAmt);
                    END;
                END;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.GET('');
                CompanyInformation.CALCFIELDS("Document Logo");
                IF PrintCompany THEN BEGIN
                    //FormatAddress.Company(CompanyAddress,CompanyInformation);
                    //FormatAddress.NifastMexCompanySlsDocs(CompanyAddress, CompanyInformation);   //NIF MAK 050206 BC Upgrade
                    FormatAddress.Company(CompanyAddress, CompanyInformation);//BC Upgrade
                END ELSE
                    CLEAR(CompanyAddress);
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
                    field(NoCopies; NoCopies)
                    {
                        Caption = 'Number of Copies';
                    }
                    field(PrintCompany; PrintCompany)
                    {
                        Caption = 'Print Company Address';
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            LogInteraction := SegManagement.FindInteractionTemplateCode("Interaction Log Entry Document Type"::"Sales Cr. Memo") <> ''; //FindInteractTmplCode(6) <> ''; BC Upgrade
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        ////PrintCompany := TRUE;   //050506 MAK
    end;

    trigger OnPreReport()
    begin
        ShipmentLine.SETCURRENTKEY("Order No.", "Order Line No.");
        IF NOT CurrReport.USEREQUESTPAGE THEN
            InitLogInteraction;
    end;

    var
        TaxLiable: Decimal;
        OrderedQuantity: Decimal;
        UnitPriceToPrint: Decimal;
        AmountExclInvDisc: Decimal;
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInformation: Record "Company Information";
        Customer: Record Customer;
        OrderLine: Record "Sales Line";
        ShipmentLine: Record "Sales Shipment Line";
        TempSalesCreditMemoLine: Record "Sales Cr.Memo Line" temporary;
        RespCenter: Record "Responsibility Center";
        Language_T: Record Language;
        TempSalesTaxAmtLine: Record "Sales Tax Amount Line" temporary;
        TaxArea: Record "Tax Area";
        CompanyAddress: array[8] of Text[50];
        BillToAddress: array[8] of Text[50];
        ShipToAddress: array[8] of Text[50];
        CopyTxt: Text[10];
        DescriptionToPrint: Text[210];
        HighDescriptionToPrint: Text[210];
        LowDescriptionToPrint: Text[210];
        PrintCompany: Boolean;
        PrintFooter: Boolean;
        TaxFlag: Boolean;
        NoCopies: Integer;
        NoLoops: Integer;
        CopyNo: Integer;
        NumberOfLines: Integer;
        OnLineNumber: Integer;
        HighestLineNo: Integer;
        SpacePointer: Integer;
        SalesCrMemoPrinted: Codeunit "Sales Cr. Memo-Printed";
        FormatAddress: Codeunit "Format Address";
        SalesTaxCalc: Codeunit "Sales Tax Calculate";
        SegManagement: Codeunit SegManagement;
        Text000: Label 'COPY';
        Text001: Label 'Transferred from page %1';
        Text002: Label 'Transferred to page %1';
        LogInteraction: Boolean;
        TaxRegNo: Text[30];
        TaxRegLabel: Text[30];
        TotalTaxLabel: Text[30];
        BreakdownTitle: Text[30];
        BreakdownLabel: array[4] of Text[30];
        BreakdownAmt: array[4] of Decimal;
        BrkIdx: Integer;
        PrevPrintOrder: Integer;
        PrevTaxPercent: Decimal;
        SalesPurchPerson2: Record "Salesperson/Purchaser";
        Text003: Label 'Sales Tax Breakdown:';
        Text004: Label 'Other Taxes';
        Text005: Label 'Total Sales Tax:';
        Text006: Label 'Tax Breakdown:';
        Text007: Label 'Total Tax:';
        Text008: Label 'Tax:';
        "<<NIF>>": Integer;
        RevisionText: Text[100];
        LineCounter: Integer;
        LineCounterText: Text[30];
        RemissionText: Text[1000];
        CustOrdNoText: Text[1000];
        tDayText: Text[2];
        tMonText: Text[2];
        tYrText: Text[4];
        tLongAddress: Text[80];
        tLongCityState: Text[80];
        tLongDescription: Text[100];
        mCustomer: Record Customer;
        mCountry: Record "Country/Region";
        Subtotal_CaptionLbl: Label 'Subtotal:';
        //[InDataSet]BC Upgrade
        LogInteractionEnable: Boolean;

    procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractionTemplateCode("Interaction Log Entry Document Type"::"Sales Inv.") <> ''; //FindInteractTmplCode(4) <> ''; BC Upgrade
    end;

    procedure ">>NIF"()
    begin
    end;

    procedure GetRemissionText()
    var
        TempSalesShptHdr: Record "Sales Shipment Header" temporary;
        SalesInvLine: Record "Sales Invoice Line";
        RowText: Text[100];
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        ValueEntryRelation: Record "Value Entry Relation";
        ValueEntry: Record "Value Entry";
        ItemLedgEntry: Record "Item Ledger Entry";
        SalesShptHdr: Record "Sales Shipment Header";
    begin
        TempSalesShptHdr.DELETEALL;
        CLEAR(RemissionText);
        CLEAR(CustOrdNoText);   //050606 MAK

        SalesInvLine.SETRANGE("Document No.", "Sales Cr.Memo Header"."No.");
        SalesInvLine.SETRANGE(Type, SalesInvLine.Type::Item);
        SalesInvLine.SETFILTER(Quantity, '<>%1', 0);
        IF SalesInvLine.FIND('-') THEN
            REPEAT
                RowText := ItemTrackingMgt.ComposeRowID(DATABASE::"Sales Cr.Memo Line", 0,
                                                   SalesInvLine."Document No.", '', 0, SalesInvLine."Line No.");
                ValueEntryRelation.SETCURRENTKEY("Source RowId");
                ValueEntryRelation.SETRANGE("Source RowId", RowText);
                IF ValueEntryRelation.FIND('-') THEN BEGIN
                    REPEAT
                        ValueEntry.GET(ValueEntryRelation."Value Entry No.");
                        ItemLedgEntry.GET(ValueEntry."Item Ledger Entry No.");
                        IF SalesShptHdr.GET(ItemLedgEntry."Document No.") THEN
                            IF NOT TempSalesShptHdr.GET(SalesShptHdr."No.") THEN BEGIN
                                TempSalesShptHdr.INIT;
                                TempSalesShptHdr := SalesShptHdr;
                                TempSalesShptHdr.INSERT;
                            END;
                    UNTIL ValueEntryRelation.NEXT = 0;
                END;
            UNTIL SalesInvLine.NEXT = 0;


        IF TempSalesShptHdr.FIND('-') THEN
            REPEAT
                IF RemissionText <> '' THEN
                    RemissionText := RemissionText + ' / ' + TempSalesShptHdr."No."
                ELSE
                    RemissionText := TempSalesShptHdr."No.";
                IF CustOrdNoText <> '' THEN
                    CustOrdNoText := CustOrdNoText + ' / ' + TempSalesShptHdr."External Document No."
                ELSE
                    CustOrdNoText := TempSalesShptHdr."External Document No.";
            UNTIL TempSalesShptHdr.NEXT = 0;

        //>>MAK 050606
        IF RemissionText <> '' THEN
            RemissionText := 'Remissions: ' + RemissionText;
        IF CustOrdNoText <> '' THEN
            CustOrdNoText := 'Customer Orders: ' + CustOrdNoText;
    end;
}

