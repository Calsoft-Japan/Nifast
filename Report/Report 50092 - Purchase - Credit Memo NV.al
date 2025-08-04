report 50092 "Purchase - Credit Memo NV"
{
    // NF1.00:CIS.NG  07-18-16 Upgrade Report to NAV 2016
    // 
    // SM 001 8/9/16 changed left margin and right margin
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = '.\RDLC\Purchase - Credit Memo NV.rdlc';

    Caption = 'Purchase - Credit Memo NV';
    UsageCategory = ReportsAndAnalysis;


    dataset
    {
        dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Buy-from Vendor No.", "Pay-to Vendor No.", "No. Printed";
            column(No_PurchCrMemoHdr; "No.")
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(CompanyAddress1; CompanyAddress[1])
                    {
                    }
                    column(CompanyAddress2; CompanyAddress[2])
                    {
                    }
                    column(CompanyAddress3; CompanyAddress[3])
                    {
                    }
                    column(CompanyAddress4; CompanyAddress[4])
                    {
                    }
                    column(CompanyAddress5; CompanyAddress[5])
                    {
                    }
                    column(CompanyAddress6; CompanyAddress[6])
                    {
                    }
                    column(DocumentLogo_CompanyInformation; CompanyInformation.Picture)// "Document Logo")
                    {
                    }
                    column(CopyTxt; CopyTxt)
                    {
                    }
                    column(BuyFromAddress1; BuyFromAddress[1])
                    {
                    }
                    column(BuyFromAddress2; BuyFromAddress[2])
                    {
                    }
                    column(BuyFromAddress3; BuyFromAddress[3])
                    {
                    }
                    column(BuyFromAddress4; BuyFromAddress[4])
                    {
                    }
                    column(BuyFromAddress5; BuyFromAddress[5])
                    {
                    }
                    column(BuyFromAddress6; BuyFromAddress[6])
                    {
                    }
                    column(BuyFromAddress7; BuyFromAddress[7])
                    {
                    }
                    column(AppDocType_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Applies-to Doc. Type")
                    {
                    }
                    column(ShipToAddress1; ShipToAddress[1])
                    {
                    }
                    column(ShipToAddress2; ShipToAddress[2])
                    {
                    }
                    column(ShipToAddress3; ShipToAddress[3])
                    {
                    }
                    column(ShipToAddress4; ShipToAddress[4])
                    {
                    }
                    column(ShipToAddress5; ShipToAddress[5])
                    {
                    }
                    column(ShipToAddress6; ShipToAddress[6])
                    {
                    }
                    column(ShipToAddress7; ShipToAddress[7])
                    {
                    }
                    column(PaytoVendNo_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Pay-to Vendor No.")
                    {
                    }
                    column(YourRef_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Your Reference")
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(VendCrMemoNo_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Vendor Cr. Memo No.")
                    {
                    }
                    column(DocDate_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Document Date")
                    {
                    }
                    column(CompanyAddress7; CompanyAddress[7])
                    {
                    }
                    column(CompanyAddress8; CompanyAddress[8])
                    {
                    }
                    column(BuyFromAddress8; BuyFromAddress[8])
                    {
                    }
                    column(ShipToAddress8; ShipToAddress[8])
                    {
                    }
                    column(AppDocNo_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Applies-to Doc. No.")
                    {
                    }
                    column(CopyNo; CopyNo)
                    {
                    }
                    column(VendTaxIdentificationType; FORMAT(Vend."Tax Identification Type"))
                    {
                    }
                    column(ToCaption; ToCaptionLbl)
                    {
                    }
                    column(ApplytoTypeCaption; ApplytoTypeCaptionLbl)
                    {
                    }
                    column(VendorIDCaption; VendorIDCaptionLbl)
                    {
                    }
                    column(ConfirmToCaption; ConfirmToCaptionLbl)
                    {
                    }
                    column(BuyerCaption; BuyerCaptionLbl)
                    {
                    }
                    column(ShipCaption; ShipCaptionLbl)
                    {
                    }
                    column(PurchCreditMemoCaption; PurchCreditMemoCaptionLbl)
                    {
                    }
                    column(PurchaseCreditMemoNumberCaption; PurchaseCreditMemoNumberCaptionLbl)
                    {
                    }
                    column(PurchaseCreditMemoDateCaption; PurchaseCreditMemoDateCaptionLbl)
                    {
                    }
                    column(PageCaption; PageCaptionLbl)
                    {
                    }
                    column(ApplytoNumberCaption; ApplytoNumberCaptionLbl)
                    {
                    }
                    column(PayCaption; PayCaptionLbl)
                    {
                    }
                    column(TaxIdentTypeCaption; TaxIdentTypeCaptionLbl)
                    {
                    }
                    dataitem("Purch. Cr. Memo Line"; "Purch. Cr. Memo Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purch. Cr. Memo Hdr.";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(AmountExclInvDisc; AmountExclInvDisc)
                        {
                        }
                        column(ItemNumberToPrint; ItemNumberToPrint)
                        {
                        }
                        column(UOM_PurchCrMemoLine; "Unit of Measure")
                        {
                        }
                        column(Quantity_PurchCrMemoLine; Quantity)
                        {
                        }
                        column(UnitPriceToPrint; UnitPriceToPrint)
                        {
                            DecimalPlaces = 2 : 5;
                        }
                        column(Desc_PurchCrMemoLine; Description)
                        {
                        }
                        column(AmountExclInvDisc1; Amount - AmountExclInvDisc)
                        {
                        }
                        column(AmountIncludingVATAmount; "Amount Including VAT" - Amount)
                        {
                        }
                        column(AmtIncluVAT_PurchCrMemoLine; "Amount Including VAT")
                        {
                        }
                        column(BreakdownLabel1; BreakdownLabel[1])
                        {
                        }
                        column(BreakdownTitle; BreakdownTitle)
                        {
                        }
                        column(BreakdownLabel2; BreakdownLabel[2])
                        {
                        }
                        column(BreakdownLabel3; BreakdownLabel[3])
                        {
                        }
                        column(BreakdownAmt1; BreakdownAmt[1])
                        {
                        }
                        column(BreakdownAmt2; BreakdownAmt[2])
                        {
                        }
                        column(BreakdownAmt3; BreakdownAmt[3])
                        {
                        }
                        column(BreakdownAmt4; BreakdownAmt[4])
                        {
                        }
                        column(BreakdownLabel4; BreakdownLabel[4])
                        {
                        }
                        column(TotalTaxLabel; TotalTaxLabel)
                        {
                        }
                        column(PrintFooter; PrintFooter)
                        {
                        }
                        column(DocumentNo_PurchCrMemoLine; "Document No.")
                        {
                        }
                        column(LineNo_PurchCrMemoLine; "Line No.")
                        {
                        }
                        column(ItemNoCaption; ItemNoCaptionLbl)
                        {
                        }
                        column(UnitCaption; UnitCaptionLbl)
                        {
                        }
                        column(DescriptionCaption; DescriptionCaptionLbl)
                        {
                        }
                        column(QuantityCaption; QuantityCaptionLbl)
                        {
                        }
                        column(UnitPriceCaption; UnitPriceCaptionLbl)
                        {
                        }
                        column(TotalPriceCaption; TotalPriceCaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(InvoiceDiscountCaption; InvoiceDiscountCaptionLbl)
                        {
                        }
                        column(TotalCaption; TotalCaptionLbl)
                        {
                        }
                        column(TotalInvAmount_gDec; TotalInvAmount_gDec)
                        {
                        }
                        column(TotalInvDiscount_gDec; TotalInvDiscount_gDec)
                        {
                        }
                        column(TotalSalesTax_gDec; TotalSalesTax_gDec)
                        {
                        }
                        column(TotalAmntIncVaT_gDec; TotalAmntIncVaT_gDec)
                        {
                        }
                        dataitem(PurchLineCommentLine; "Purch. Comment Line")
                        {
                            DataItemLink = "No." = FIELD("Document No."),
                                           "Document Line No." = FIELD("Line No.");
                            DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.")
                                                WHERE("Document Type" = CONST("Posted Credit Memo"));//,"Print On Credit Memo"=CONST(Yes)); BC Upgrade
                            column(DocumentType_PurchLineComment; "Document Type")
                            {
                            }
                            column(No_PurchLineComment; "No.")
                            {
                            }
                            column(DocLineNo_PurchLineComment; "Document Line No.")
                            {
                            }
                            column(LineNo_PurchLineComment; "Line No.")
                            {
                            }
                            column(Comment_PurchLineComment; Comment)
                            {
                            }
                            column(Date_PurchLineComment; PurchLineCommentLine.Date)
                            {
                            }

                            trigger OnPreDataItem()
                            begin
                                //PurchLineCommentLine.SETRANGE("No.","Purch. Cr. Memo Line"."Document No.");
                                //PurchLineCommentLine.SETRANGE("Doc. Line No.","Purch. Cr. Memo Line"."Line No.");
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            OnLineNumber := OnLineNumber + 1;

                            IF Type = Type::" " THEN BEGIN
                                ItemNumberToPrint := '';
                                "Unit of Measure" := '';
                                Amount := 0;
                                "Amount Including VAT" := 0;
                                "Inv. Discount Amount" := 0;
                                Quantity := 0;
                            END ELSE
                                IF Type = Type::"G/L Account" THEN
                                    ItemNumberToPrint := "Vendor Item No."
                                ELSE
                                    ItemNumberToPrint := "No.";

                            IF Amount <> "Amount Including VAT" THEN
                                TaxLiable := Amount
                            ELSE
                                TaxLiable := 0;

                            AmountExclInvDisc := Amount + "Inv. Discount Amount";

                            //NIF-NS
                            TotalInvAmount_gDec += AmountExclInvDisc;
                            TotalInvDiscount_gDec += Amount - AmountExclInvDisc;
                            TotalSalesTax_gDec += "Amount Including VAT" - Amount;
                            TotalAmntIncVaT_gDec += "Amount Including VAT";
                            //NIF-NE

                            IF Quantity = 0 THEN
                                UnitPriceToPrint := 0 // so it won't print
                            ELSE
                                UnitPriceToPrint := ROUND(AmountExclInvDisc / Quantity, 0.00001);
                            IF OnLineNumber = NumberOfLines THEN
                                PrintFooter := TRUE;
                        end;

                        trigger OnPreDataItem()
                        begin
                            //CurrReport.CREATETOTALS(TaxLiable, AmountExclInvDisc, Amount, "Amount Including VAT");BC Upgrade
                            NumberOfLines := COUNT;
                            OnLineNumber := 0;
                            PrintFooter := FALSE;
                            TotalInvAmount_gDec := 0;
                            TotalInvDiscount_gDec := 0;
                            TotalSalesTax_gDec := 0;
                            TotalAmntIncVaT_gDec := 0;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    //CurrReport.PAGENO := 1;BC Upgrade

                    IF CopyNo = NoLoops THEN BEGIN
                        IF NOT CurrReport.PREVIEW THEN
                            PurchaseCrMemoPrinted.RUN("Purch. Cr. Memo Hdr.");
                        CurrReport.BREAK;
                    END;
                    CopyNo := CopyNo + 1;
                    IF CopyNo = 1 THEN // Original
                        CLEAR(CopyTxt)
                    ELSE
                        CopyTxt := Text000;
                end;

                trigger OnPreDataItem()
                begin
                    NoLoops := 1 + ABS(NoCopies);
                    IF NoLoops <= 0 THEN
                        NoLoops := 1;
                    CopyNo := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF PrintCompany THEN
                    IF RespCenter.GET("Responsibility Center") THEN BEGIN
                        FormatAddress.RespCenter(CompanyAddress, RespCenter);
                        CompanyInformation."Phone No." := RespCenter."Phone No.";
                        CompanyInformation."Fax No." := RespCenter."Fax No.";
                    END;

                /* Language_T.Reset();//BC Upgrade 2025-06-23
                Language_T.Get("Language Code");//BC Upgrade 2025-06-23
                CurrReport.LANGUAGE := Language_T."Windows Language ID";//BC Upgrade 2025-06-23
                //Language.GetLanguageID("Language Code"); BC Upgrade 2025-06-23 */

                IF "Purchaser Code" = '' THEN
                    CLEAR(SalesPurchPerson)
                ELSE
                    SalesPurchPerson.GET("Purchaser Code");

                IF "Pay-to Vendor No." = '' THEN BEGIN
                    "Buy-from Vendor Name" := Text009;
                    "Ship-to Name" := Text009;
                END;

                FormatAddress.PurchCrMemoPayTo(BuyFromAddress, "Purch. Cr. Memo Hdr.");
                FormatAddress.PurchCrMemoShipTo(ShipToAddress, "Purch. Cr. Memo Hdr.");

                IF LogInteraction THEN
                    IF NOT CurrReport.PREVIEW THEN
                        SegManagement.LogDocument(
                          16, "No.", 0, 0, DATABASE::Vendor, "Buy-from Vendor No.", "Purchaser Code", '', "Posting Description", '');

                CLEAR(BreakdownTitle);
                CLEAR(BreakdownLabel);
                CLEAR(BreakdownAmt);
                TotalTaxLabel := Text008;
                IF "Tax Area Code" <> '' THEN BEGIN
                    TaxArea.GET("Tax Area Code");
                    CASE TaxArea."Country/Region" OF
                        TaxArea."Country/Region"::US:
                            TotalTaxLabel := Text005;
                        TaxArea."Country/Region"::CA:
                            TotalTaxLabel := Text007;
                    END;
                    SalesTaxCalc.StartSalesTaxCalculation;
                    IF TaxArea."Use External Tax Engine" THEN
                        SalesTaxCalc.CallExternalTaxEngineForDoc(DATABASE::"Purch. Cr. Memo Hdr.", 0, "No.")
                    ELSE BEGIN
                        SalesTaxCalc.AddPurchCrMemoLines("No.");
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
                        UNTIL NEXT = 0;
                END;
                IF BrkIdx = 1 THEN BEGIN
                    CLEAR(BreakdownLabel);
                    CLEAR(BreakdownAmt);
                END;

            end;

            trigger OnPreDataItem()
            begin
                IF PrintCompany THEN
                    FormatAddress.Company(CompanyAddress, CompanyInformation)
                ELSE
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
                    field(NumberOfCopies; NoCopies)
                    {
                        ApplicationArea = All;
                        Caption = 'Number of Copies';
                    }
                    field(PrintCompanyAddress; PrintCompany)
                    {
                        ApplicationArea = All;
                        Caption = 'Print Company Address';
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = All;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            LogInteractionEnable := TRUE;
        end;

        trigger OnOpenPage()
        begin
            LogInteraction := SegManagement.FindInteractionTemplateCode("Interaction Log Entry Document Type"::"Purch. Cr. Memo") <> ''; //FindInteractTmplCode(16) <> ''; BC Upgrade
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        PrintFooter := TRUE;
    end;

    trigger OnPreReport()
    begin
        CompanyInformation.GET('');
        CompanyInformation.CALCFIELDS("Document Logo");
        CompanyInformation.CALCFIELDS(Picture);//BC Upgrade
    end;

    var
        TaxLiable: Decimal;
        UnitPriceToPrint: Decimal;
        AmountExclInvDisc: Decimal;
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInformation: Record "Company Information";
        RespCenter: Record "Responsibility Center";
        Language_T: Record Language;
        TempSalesTaxAmtLine: Record "Sales Tax Amount Line" temporary;
        TaxArea: Record "Tax Area";
        Vend: Record Vendor;
        CompanyAddress: array[8] of Text[50];
        BuyFromAddress: array[8] of Text[50];
        ShipToAddress: array[8] of Text[50];
        CopyTxt: Text[10];
        ItemNumberToPrint: Text[20];
        PrintCompany: Boolean;
        PrintFooter: Boolean;
        NoCopies: Integer;
        NoLoops: Integer;
        CopyNo: Integer;
        NumberOfLines: Integer;
        OnLineNumber: Integer;
        PurchaseCrMemoPrinted: Codeunit "PurchCrMemo-Printed";
        FormatAddress: Codeunit "Format Address";
        SalesTaxCalc: Codeunit "Sales Tax Calculate";
        SegManagement: Codeunit SegManagement;
        LogInteraction: Boolean;
        TotalTaxLabel: Text[30];
        BreakdownTitle: Text[30];
        BreakdownLabel: array[4] of Text[30];
        BreakdownAmt: array[4] of Decimal;
        BrkIdx: Integer;
        PrevPrintOrder: Integer;
        PrevTaxPercent: Decimal;
        Text000: Label 'COPY';
        Text003: Label 'Sales Tax Breakdown:';
        Text004: Label 'Other Taxes';
        Text005: Label 'Total Sales Tax:';
        Text006: Label 'Tax Breakdown:';
        Text007: Label 'Total Tax:';
        Text008: Label 'Sales Tax:';
        Text009: Label 'VOID CREDIT MEMO';
        //[InDataSet]BC Upgrade
        LogInteractionEnable: Boolean;
        ToCaptionLbl: Label 'To:';
        ApplytoTypeCaptionLbl: Label 'Apply to Type';
        VendorIDCaptionLbl: Label 'Vendor ID';
        ConfirmToCaptionLbl: Label 'Confirm To';
        BuyerCaptionLbl: Label 'Buyer';
        ShipCaptionLbl: Label 'Ship';
        PurchCreditMemoCaptionLbl: Label 'Purchase Credit Memo';
        PurchaseCreditMemoNumberCaptionLbl: Label 'Purchase Credit Memo Number:';
        PurchaseCreditMemoDateCaptionLbl: Label 'Purchase Credit Memo Date:';
        PageCaptionLbl: Label 'Page';
        ApplytoNumberCaptionLbl: Label 'Apply to Number';
        PayCaptionLbl: Label 'Pay';
        TaxIdentTypeCaptionLbl: Label 'Tax Ident. Type';
        ItemNoCaptionLbl: Label 'Item No.';
        UnitCaptionLbl: Label 'Unit';
        DescriptionCaptionLbl: Label 'Description';
        QuantityCaptionLbl: Label 'Quantity';
        UnitPriceCaptionLbl: Label 'Unit Price';
        TotalPriceCaptionLbl: Label 'Total Price';
        SubtotalCaptionLbl: Label 'Subtotal';
        InvoiceDiscountCaptionLbl: Label 'Invoice Discount:';
        TotalCaptionLbl: Label 'Total';
        TotalInvAmount_gDec: Decimal;
        TotalInvDiscount_gDec: Decimal;
        TotalSalesTax_gDec: Decimal;
        TotalAmntIncVaT_gDec: Decimal;
}

