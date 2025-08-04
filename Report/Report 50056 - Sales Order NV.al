report 50056 "Sales Order NV"
{
    // NF1.00:CIS.NU  09-15-15 Merged during upgrade
    // NF1.00:CIS.NG  09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)
    // NF1.00:CIS.CM  09/29/15 Update for New Vision Removal Task
    // NF1.00:CIS.NG  07-19-16 Fix the Date Format Issue - Make it MM/dd/yy
    // 
    // istrtt 082203 added bar code
    // istrtt 092005 added FreightTerms
    // istrtt 120805 added Cross Ref No. to Sales Line - Body
    //               -code at SalesLine->OnAfterGetRecord
    // istrtt 052506 new vars ASNValue and ASNCaption
    //               -added to Header section
    //               -code at Sales Header - OnAfterGetRecord()
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = '.\RDLC\Sales Order NV.rdlc';

    Caption = 'Sales Order NV';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST(Order));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Sell-to Customer No.", "Bill-to Customer No.", "Ship-to Code", "No. Printed";
            RequestFilterHeading = 'Sales Order';
            column(No_SalesHeader; "No.")
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                    WHERE("Document Type" = CONST(Order));

                trigger OnAfterGetRecord()
                begin
                    TempSalesLine := "Sales Line";
                    TempSalesLine.INSERT;
                    TempSalesLineAsm := "Sales Line";
                    TempSalesLineAsm.INSERT;

                    HighestLineNo := "Line No.";
                    IF ("Sales Header"."Tax Area Code" <> '') AND NOT UseExternalTaxEngine THEN
                        SalesTaxCalc.AddSalesLine(TempSalesLine);
                end;

                trigger OnPostDataItem()
                begin
                    IF "Sales Header"."Tax Area Code" <> '' THEN BEGIN
                        IF UseExternalTaxEngine THEN
                            SalesTaxCalc.CallExternalTaxEngineForSales("Sales Header", TRUE)
                        ELSE
                            SalesTaxCalc.EndSalesTaxCalculation(UseDate);
                        SalesTaxCalc.DistTaxOverSalesLines(TempSalesLine);
                        SalesTaxCalc.GetSummarizedSalesTaxTable(TempSalesTaxAmtLine);
                        BrkIdx := 0;
                        PrevPrintOrder := 0;
                        PrevTaxPercent := 0;

                        TempSalesTaxAmtLine.RESET;
                        TempSalesTaxAmtLine.SETCURRENTKEY("Print Order", "Tax Area Code for Key", "Tax Jurisdiction Code");
                        IF FIND('-') THEN
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

                        IF BrkIdx = 1 THEN BEGIN
                            CLEAR(BreakdownLabel);
                            CLEAR(BreakdownAmt);
                        END;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    TempSalesLine.RESET;
                    TempSalesLine.DELETEALL;
                    TempSalesLineAsm.RESET;
                    TempSalesLineAsm.DELETEALL;
                end;
            }
            /*  BC Upgrade No need show any comment line in report===================
            dataitem("Sales Comment Line"; "Sales Comment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.")
                                    WHERE("Document Type" = CONST(Order),
                                          //"Print On Order Confirmation"=CONST(Yes), BC Upgrade
                                          "Document Line No." = CONST(0));

                trigger OnAfterGetRecord()
                begin
                    TempSalesLine.INIT;
                    TempSalesLine."Document Type" := "Sales Header"."Document Type";
                    TempSalesLine."Document No." := "Sales Header"."No.";
                    TempSalesLine."Line No." := HighestLineNo + 1000;
                    HighestLineNo := TempSalesLine."Line No.";

                    IF STRLEN(Comment) <= MAXSTRLEN(TempSalesLine.Description) THEN BEGIN
                        TempSalesLine.Description := Comment;
                        TempSalesLine."Description 2" := '';
                    END ELSE BEGIN
                        SpacePointer := MAXSTRLEN(TempSalesLine.Description) + 1;
                        WHILE (SpacePointer > 1) AND (Comment[SpacePointer] <> ' ') DO
                            SpacePointer := SpacePointer - 1;
                        IF SpacePointer = 1 THEN
                            SpacePointer := MAXSTRLEN(TempSalesLine.Description) + 1;
                        TempSalesLine.Description := COPYSTR(Comment, 1, SpacePointer - 1);
                        TempSalesLine."Description 2" := COPYSTR(COPYSTR(Comment, SpacePointer + 1), 1, MAXSTRLEN(TempSalesLine."Description 2"));
                    END;
                    TempSalesLine.INSERT;
                end;

                trigger OnPreDataItem()
                begin
                    //>> NF1.00:CIS.NU  09-15-15
                    //WITH TempSalesLine DO BEGIN
                    //  INIT;
                    //  "Document Type" := "Sales Header"."Document Type";
                    //  "Document No." := "Sales Header"."No.";
                    //  "Line No." := HighestLineNo + 1000;
                    //  HighestLineNo := "Line No.";
                    //END;
                    //TempSalesLine.INSERT;
                    //<< NF1.00:CIS.NU  09-15-15
                end;
            } */
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(CompanyInfo2Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo1Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInfoPicture; CompanyInfo3.Picture)
                    {
                    }
                    column(DocumentLogo_CompanyInfo; CompanyInformation.Picture)//"Document Logo")
                    {
                    }
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
                    column(CopyTxt; CopyTxt)
                    {
                    }
                    column(BillToAddress1; BillToAddress[1])
                    {
                    }
                    column(BillToAddress2; BillToAddress[2])
                    {
                    }
                    column(BillToAddress3; BillToAddress[3])
                    {
                    }
                    column(BillToAddress4; BillToAddress[4])
                    {
                    }
                    column(BillToAddress5; BillToAddress[5])
                    {
                    }
                    column(BillToAddress6; BillToAddress[6])
                    {
                    }
                    column(BillToAddress7; BillToAddress[7])
                    {
                    }
                    column(No__SalesHeader; '*' + "Sales Header"."No." + '*')
                    {
                        //DecimalPlaces = 2 : 2;
                    }
                    column(ShptDate_SalesHeader; "Sales Header"."Shipment Date")
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
                    column(BilltoCustNo_SalesHeader; "Sales Header"."Bill-to Customer No.")
                    {
                    }
                    column(YourRef_SalesHeader; "Sales Header"."Your Reference")
                    {
                    }
                    column(ExternalDocNo_SalesHeader; "Sales Header"."External Document No.")
                    {
                    }
                    column(ShipToCode_SalesHeader; "Sales Header"."Ship-to Code")
                    {
                    }
                    column(SellToCustomerNo_SalesHeader; "Sales Header"."Sell-to Customer No.")
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(OrderDate_SalesHeader; "Sales Header"."Order Date")
                    {
                    }
                    column(CompanyAddress7; CompanyAddress[7])
                    {
                    }
                    column(CompanyAddress8; CompanyAddress[8])
                    {
                    }
                    column(BillToAddress8; BillToAddress[8])
                    {
                    }
                    column(ShipToAddress8; ShipToAddress[8])
                    {
                    }
                    column(ShipmentMethodDesc; ShipmentMethod.Description)
                    {
                    }
                    column(PaymentTermsDesc; PaymentTerms.Description)
                    {
                    }
                    column(TaxRegLabel; TaxRegLabel)
                    {
                    }
                    column(TaxRegNo; TaxRegNo)
                    {
                    }
                    column(CopyNo; CopyNo)
                    {
                    }
                    column(CustTaxIdentificationType; FORMAT(Cust."Tax Identification Type"))
                    {
                    }
                    column(SoldCaption; SoldCaptionLbl)
                    {
                    }
                    column(ToCaption; ToCaptionLbl)
                    {
                    }
                    column(ShipDateCaption; ShipDateCaptionLbl)
                    {
                    }
                    column(CustomerIDCaption; CustomerIDCaptionLbl)
                    {
                    }
                    column(PONumberCaption; PONumberCaptionLbl)
                    {
                    }
                    column(SalesPersonCaption; SalesPersonCaptionLbl)
                    {
                    }
                    column(ShipCaption; ShipCaptionLbl)
                    {
                    }
                    column(SalesOrderCaption; SalesOrderCaptionLbl)
                    {
                    }
                    column(SalesOrderNumberCaption; SalesOrderNumberCaptionLbl)
                    {
                    }
                    column(SalesOrderDateCaption; SalesOrderDateCaptionLbl)
                    {
                    }
                    column(PageCaption; PageCaptionLbl)
                    {
                    }
                    column(ShipViaCaption; ShipViaCaptionLbl)
                    {
                    }
                    column(PODateCaption; PODateCaptionLbl)
                    {
                    }
                    column(TaxIdentTypeCaption; TaxIdentTypeCaptionLbl)
                    {
                    }
                    column(FreightTerms_Description; FreightTerms.Description)
                    {
                    }
                    column(ShippingAgent_Name; ShippingAgent.Name)
                    {
                    }
                    column(ASNValue; ASNValue)
                    {
                    }
                    column(ASNCaption; ASNCaption)
                    {
                    }
                    column(ReferenceCaption; ReferenceCaptionLbl)
                    {
                    }
                    column(ShippingAgentCaption; Shipping_AgentCaptionLbl)
                    {
                    }
                    column(PaymentTermsCaption; Payment_TermsCaptionLbl)
                    {
                    }
                    column(FreightTermsCaption; Freight_TermsCaptionLbl)
                    {
                    }
                    column(ShipmentMethodCaption; Shipment_MethodCaptionLbl)
                    {
                    }
                    dataitem(SalesLine; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(PrintFooter; PrintFooter)
                        {
                        }
                        column(AmountExclInvDisc; AmountExclInvDisc)
                        {
                        }
                        column(Cross_Reference_No_______UseCrossRef; 'Cross-Reference No.: ' + UseCrossRef)
                        {
                        }
                        column(TempSalesLineNo; TempSalesLine."No.")
                        {
                        }
                        column(TempSalesLineUOM; TempSalesLine."Unit of Measure")
                        {
                        }
                        column(TempSalesLineQuantity; TempSalesLine.Quantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(UnitPriceToPrint; UnitPriceToPrint)
                        {
                            DecimalPlaces = 2 : 5;
                        }
                        column(TempSalesLineDesc; TempSalesLine.Description + ' ' + TempSalesLine."Description 2")
                        {
                        }
                        column(TempSalesLineDocumentNo; TempSalesLine."Document No.")
                        {
                        }
                        column(TempSalesLineLineNo; TempSalesLine."Line No.")
                        {
                        }
                        column(AsmInfoExistsForLine; AsmInfoExistsForLine)
                        {
                        }
                        column(TaxLiable; TaxLiable)
                        {
                        }
                        column(TempSalesLineLineAmtTaxLiable; TempSalesLine."Line Amount" - TaxLiable)
                        {
                        }
                        column(TempSalesLineInvDiscAmt; TempSalesLine."Inv. Discount Amount")
                        {
                        }
                        column(TaxAmount; TaxAmount)
                        {
                        }
                        column(TempSalesLineLineAmtTaxAmtInvDiscAmt; TempSalesLine."Line Amount" + TaxAmount - TempSalesLine."Inv. Discount Amount")
                        {
                        }
                        column(AmountSubjectToSalesTax; AmountSubjectToSalesTax)
                        {
                        }
                        column(AmountExemptFromSalesTax; AmountExemptFromSalesTax)
                        {
                        }
                        column(SubTotal; SubTotal)
                        {
                        }
                        column(InvoiceDiscount; InvoiceDiscount)
                        {
                        }
                        column(TotalTax; TotalTax)
                        {
                        }
                        column(Total; Total)
                        {
                        }
                        column(BreakdownTitle; BreakdownTitle)
                        {
                        }
                        column(BreakdownLabel1; BreakdownLabel[1])
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
                        column(AmtSubjecttoSalesTaxCptn; AmtSubjecttoSalesTaxCptnLbl)
                        {
                        }
                        column(AmtExemptfromSalesTaxCptn; AmtExemptfromSalesTaxCptnLbl)
                        {
                        }
                        column(UseCrossRef; UseCrossRef)
                        {
                        }
                        dataitem("Sales Line Comment Line"; "Sales Comment Line")
                        {
                            DataItemTableView = SORTING("Document Type", "No.", "Line No.", Date)
                                                WHERE("Document Type" = CONST(Order));//,"Print On Order Confirmation"=CONST(Yes)); BC Upgrade
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
                                SETRANGE("No.", TempSalesLine."Document No.");
                                //SETRANGE("Doc. Line No.",TempSalesLine."Line No.");  //NF1.00:CIS.CM 09-29-15-O
                                SETRANGE("Document Line No.", TempSalesLine."Line No.");  //NF1.00:CIS.CM 09-29-15-N

                                SETRANGE("Document Line No.", -11);//BC Upgrade Skip all comment lines
                            end;
                        }
                        dataitem(AsmLoop; Integer)
                        {
                            DataItemTableView = SORTING(Number);
                            column(AsmLineUnitOfMeasureText; GetUnitOfMeasureDescr(AsmLine."Unit of Measure Code"))
                            {
                            }
                            column(Number_AsmLoop; AsmLoop.Number)
                            {
                            }
                            column(AsmLineQuantity; AsmLine.Quantity)
                            {
                            }
                            column(AsmLineDescription; BlanksForIndent + AsmLine.Description)
                            {
                            }
                            column(AsmLineNo; BlanksForIndent + AsmLine."No.")
                            {
                            }
                            column(AsmLineType; AsmLine.Type)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN
                                    AsmLine.FINDSET
                                ELSE BEGIN
                                    AsmLine.NEXT;
                                    TaxLiable := 0;
                                    TaxAmount := 0;
                                    AmountExclInvDisc := 0;
                                    TempSalesLine."Line Amount" := 0;
                                    TempSalesLine."Inv. Discount Amount" := 0;
                                END;
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT DisplayAssemblyInformation THEN
                                    CurrReport.BREAK;
                                IF NOT AsmInfoExistsForLine THEN
                                    CurrReport.BREAK;
                                AsmLine.SETRANGE("Document Type", AsmHeader."Document Type");
                                AsmLine.SETRANGE("Document No.", AsmHeader."No.");
                                SETRANGE(Number, 1, AsmLine.COUNT);
                            end;
                        }

                        trigger OnAfterGetRecord()
                        var
                            SalesLine: Record "Sales Line";
                        begin
                            OnLineNumber := OnLineNumber + 1;

                            IF OnLineNumber = 1 THEN
                                TempSalesLine.FIND('-')
                            ELSE
                                TempSalesLine.NEXT;

                            IF TempSalesLine.Type = TempSalesLine.Type::" " THEN BEGIN
                                TempSalesLine."No." := '';
                                TempSalesLine."Unit of Measure" := '';
                                TempSalesLine."Line Amount" := 0;
                                TempSalesLine."Inv. Discount Amount" := 0;
                                TempSalesLine.Quantity := 0;
                            END ELSE
                                IF TempSalesLine.Type = TempSalesLine.Type::"G/L Account" THEN
                                    TempSalesLine."No." := '';

                            IF TempSalesLine."Tax Area Code" <> '' THEN
                                TaxAmount := TempSalesLine."Amount Including VAT" - TempSalesLine.Amount
                            ELSE
                                TaxAmount := 0;

                            IF TaxAmount <> 0 THEN
                                TaxLiable := TempSalesLine.Amount
                            ELSE
                                TaxLiable := 0;

                            AmountExclInvDisc := TempSalesLine."Line Amount";

                            //>>NIF
                            AmountSubjectToSalesTax += TaxLiable;
                            AmountExemptFromSalesTax += (TempSalesLine."Line Amount" - TaxLiable);
                            SubTotal += AmountExclInvDisc;
                            InvoiceDiscount += TempSalesLine."Inv. Discount Amount";
                            TotalTax += TaxAmount;
                            Total += ((TempSalesLine."Line Amount" + TaxAmount - TempSalesLine."Inv. Discount Amount"));
                            //<<NIF

                            IF TempSalesLine.Quantity = 0 THEN
                                UnitPriceToPrint := 0 // so it won't print
                            ELSE
                                UnitPriceToPrint := TempSalesLine."Unit Price";
                            //UnitPriceToPrint := ROUND(AmountExclInvDisc / Quantity,0.00001);
                            //>> 12-08-05
                            CLEAR(UseCrossRef);
                            IF (TempSalesLine.Type = TempSalesLine.Type::Item) AND (TempSalesLine."No." <> '') THEN BEGIN
                                IF TempSalesLine."Item Reference No." <> '' THEN //BC Upgrade
                                    UseCrossRef := TempSalesLine."Item Reference No."
                                ELSE BEGIN
                                    ItemCrossRef.SETRANGE("Item No.", TempSalesLine."No.");
                                    ItemCrossRef.SETRANGE("Variant Code", TempSalesLine."Variant Code");
                                    ItemCrossRef.SETRANGE("Reference Type", ItemCrossRef."Reference Type"::Customer);
                                    ItemCrossRef.SETRANGE("Reference Type No.", TempSalesLine."Sell-to Customer No.");
                                    IF ItemCrossRef.FIND('-') THEN
                                        UseCrossRef := ItemCrossRef."Reference No.";
                                END;
                            END;
                            //<< 12-08-05

                            IF DisplayAssemblyInformation THEN BEGIN
                                AsmInfoExistsForLine := FALSE;
                                IF TempSalesLineAsm.GET(TempSalesLine."Document Type", TempSalesLine."Document No.", TempSalesLine."Line No.") THEN BEGIN
                                    SalesLine.GET(TempSalesLine."Document Type", TempSalesLine."Document No.", TempSalesLine."Line No.");
                                    AsmInfoExistsForLine := SalesLine.AsmToOrderExists(AsmHeader);
                                END;
                            END;

                            IF OnLineNumber = NumberOfLines THEN
                                PrintFooter := TRUE;
                        end;

                        trigger OnPreDataItem()
                        begin
                            //CurrReport.CREATETOTALS(TaxLiable, TaxAmount, AmountExclInvDisc, TempSalesLine."Line Amount", TempSalesLine."Inv. Discount Amount");BC Upgrade
                            NumberOfLines := TempSalesLine.COUNT;
                            SETRANGE(Number, 1, NumberOfLines);
                            OnLineNumber := 0;
                            PrintFooter := FALSE;
                            //>>NIF
                            AmountSubjectToSalesTax := 0;
                            AmountExemptFromSalesTax := 0;
                            SubTotal := 0;
                            InvoiceDiscount := 0;
                            TotalTax := 0;
                            Total := 0;
                            //<<NIF
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    //CurrReport.PAGENO := 1;BC Upgrade

                    IF CopyNo = NoLoops THEN BEGIN
                        IF NOT CurrReport.PREVIEW THEN
                            SalesPrinted.RUN("Sales Header");
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
            var
                tempSalesHdr: Record "Sales Header";
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

                //>>NIF 052506 RTT
                PackingRule.GetPackingRule(0, "Sell-to Customer No.", "Ship-to Code");  //0=customer
                IF (PackingRule."ASN Summary Type" <> PackingRule."ASN Summary Type"::" ") AND ("EDI Control No." <> '') THEN BEGIN
                    ASNCaption := "Sales Header".FIELDNAME("EDI Control No.");
                    ASNValue := "EDI Control No."
                END ELSE BEGIN
                    ASNCaption := '';
                    ASNValue := '';
                END;
                //<<NIF 052606 RTT

                IF "Salesperson Code" = '' THEN
                    CLEAR(SalesPurchPerson)
                ELSE
                    SalesPurchPerson.GET("Salesperson Code");

                IF "Inside Salesperson Code" = '' THEN
                    CLEAR(SalesPurchPerson2)
                ELSE
                    SalesPurchPerson2.GET("Inside Salesperson Code");

                IF "Payment Terms Code" = '' THEN
                    CLEAR(PaymentTerms)
                ELSE
                    PaymentTerms.GET("Payment Terms Code");

                //>> NIF 12-08-05
                IF NOT FreightTerms.GET("Freight Code") THEN
                    CLEAR(FreightTerms);
                IF NOT ShippingAgent.GET("Shipping Agent Code") THEN
                    CLEAR(ShippingAgent);
                //<< NIF 12-08-05
                //<< NIF 09-20-05

                IF "Shipment Method Code" = '' THEN
                    CLEAR(ShipmentMethod)
                ELSE
                    ShipmentMethod.GET("Shipment Method Code");

                IF NOT Cust.GET("Sell-to Customer No.") THEN
                    CLEAR(Cust);

                tempSalesHdr := "Sales Header";
                tempSalesHdr."Sell-to Contact" := '';
                tempSalesHdr."Ship-to Contact" := '';
                FormatAddress.SalesHeaderSellTo(BillToAddress, tempSalesHdr);//"Sales Header");
                FormatAddress.SalesHeaderShipTo(ShipToAddress, BillToAddress, tempSalesHdr);//"Sales Header");//BC Upgrade

                IF NOT CurrReport.PREVIEW THEN BEGIN
                    IF ArchiveDocument THEN
                        ArchiveManagement.StoreSalesDocument("Sales Header", LogInteraction);

                    IF LogInteraction THEN BEGIN
                        CALCFIELDS("No. of Archived Versions");
                        IF "Bill-to Contact No." <> '' THEN
                            SegManagement.LogDocument(
                              3, "No.", "Doc. No. Occurrence",
                              "No. of Archived Versions", DATABASE::Contact, "Bill-to Contact No."
                              , "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.")
                        ELSE
                            SegManagement.LogDocument(
                              3, "No.", "Doc. No. Occurrence",
                              "No. of Archived Versions", DATABASE::Customer, "Bill-to Customer No.",
                              "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.");
                    END;
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
                    UseExternalTaxEngine := TaxArea."Use External Tax Engine";
                    SalesTaxCalc.StartSalesTaxCalculation;
                END;

                IF "Posting Date" <> 0D THEN
                    UseDate := "Posting Date"
                ELSE
                    UseDate := WORKDATE;
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
                        ApplicationArea = All;
                        Caption = 'Number of Copies';
                    }
                    field(PrintCompanyAddress; PrintCompany)
                    {
                        ApplicationArea = All;
                        Caption = 'Print Company Address';
                    }
                    field(ArchiveDocument; ArchiveDocument)
                    {
                        ApplicationArea = All;
                        Caption = 'Archive Document';
                        Enabled = ArchiveDocumentEnable;

                        trigger OnValidate()
                        begin
                            IF NOT ArchiveDocument THEN
                                LogInteraction := FALSE;
                        end;
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = All;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;

                        trigger OnValidate()
                        begin
                            IF LogInteraction THEN
                                ArchiveDocument := ArchiveDocumentEnable;
                        end;
                    }
                    field("Display Assembly information"; DisplayAssemblyInformation)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Assembly Components';
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
            ArchiveDocumentEnable := TRUE;
        end;

        trigger OnOpenPage()
        begin
            ArchiveDocument := ArchiveManagement.SalesDocArchiveGranule;
            LogInteraction := SegManagement.FindInteractionTemplateCode("Interaction Log Entry Document Type"::"Sales Ord. Cnfrmn.") <> ''; //FindInteractTmplCode(3) <> ''; BC Upgrade

            ArchiveDocumentEnable := ArchiveDocument;
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        PrintCompany := TRUE;
    end;

    trigger OnPreReport()
    begin
        CompanyInformation.GET;
        SalesSetup.GET;

        CASE SalesSetup."Logo Position on Documents" OF
            SalesSetup."Logo Position on Documents"::"No Logo":
                ;
            SalesSetup."Logo Position on Documents"::Left:
                BEGIN
                    CompanyInfo3.GET;
                    CompanyInfo3.CALCFIELDS(Picture);
                END;
            SalesSetup."Logo Position on Documents"::Center:
                BEGIN
                    CompanyInfo1.GET;
                    CompanyInfo1.CALCFIELDS(Picture);
                END;
            SalesSetup."Logo Position on Documents"::Right:
                BEGIN
                    CompanyInfo2.GET;
                    CompanyInfo2.CALCFIELDS(Picture);
                END;
        END;
        CompanyInformation.CALCFIELDS("Document Logo");
        CompanyInformation.CALCFIELDS(Picture);
        IF PrintCompany THEN BEGIN
            FormatAddress.Company(CompanyAddress, CompanyInformation)
        END ELSE
            CLEAR(CompanyAddress);
    end;

    var
        TaxLiable: Decimal;
        UnitPriceToPrint: Decimal;
        AmountExclInvDisc: Decimal;
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        SalesPurchPerson2: Record "Salesperson/Purchaser";
        CompanyInformation: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        TempSalesLine: Record "Sales Line" temporary;
        TempSalesLineAsm: Record "Sales Line" temporary;
        RespCenter: Record "Responsibility Center";
        Language_T: Record Language;
        TempSalesTaxAmtLine: Record "Sales Tax Amount Line" temporary;
        TaxArea: Record "Tax Area";
        Cust: Record Customer;
        AsmHeader: Record "Assembly Header";
        AsmLine: Record "Assembly Line";
        PackingRule: Record "Packing Rule"; //"14000715"; BC Upgrade
        FreightTerms: Record "Freight Code";
        ShippingAgent: Record "Shipping Agent";
        ItemCrossRef: Record "Item Reference"; //"Item Cross Reference";
        CompanyAddress: array[8] of Text[50];
        UseCrossRef: Text[30];
        ASNValue: Code[20];
        ASNCaption: Text[30];
        BillToAddress: array[8] of Text[50];
        ShipToAddress: array[8] of Text[50];
        CopyTxt: Text[10];
        PrintCompany: Boolean;
        PrintFooter: Boolean;
        NoCopies: Integer;
        NoLoops: Integer;
        CopyNo: Integer;
        NumberOfLines: Integer;
        OnLineNumber: Integer;
        HighestLineNo: Integer;
        SpacePointer: Integer;
        SalesPrinted: Codeunit "Sales-Printed";
        FormatAddress: Codeunit "Format Address";
        SalesTaxCalc: Codeunit "Sales Tax Calculate";
        TaxAmount: Decimal;
        SegManagement: Codeunit SegManagement;
        ArchiveManagement: Codeunit ArchiveManagement;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        Text000: Label 'COPY';
        Text003: Label 'Sales Tax Breakdown:';
        Text004: Label 'Other Taxes';
        Text005: Label 'Total Sales Tax:';
        Text006: Label 'Tax Breakdown:';
        Text007: Label 'Total Tax:';
        Text008: Label 'Tax:';
        TaxRegNo: Text[30];
        TaxRegLabel: Text[30];
        TotalTaxLabel: Text[30];
        BreakdownTitle: Text[30];
        BreakdownLabel: array[4] of Text[30];
        BreakdownAmt: array[4] of Decimal;
        BrkIdx: Integer;
        PrevPrintOrder: Integer;
        PrevTaxPercent: Decimal;
        UseDate: Date;
        UseExternalTaxEngine: Boolean;
        //[InDataSet]BC Upgrade
        ArchiveDocumentEnable: Boolean;
        //[InDataSet]BC Upgrade
        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        AsmInfoExistsForLine: Boolean;
        SoldCaptionLbl: Label 'Sold';
        ToCaptionLbl: Label 'To:';
        ShipDateCaptionLbl: Label 'Ship Date';
        CustomerIDCaptionLbl: Label 'Customer ID';
        PONumberCaptionLbl: Label 'P.O. Number';
        SalesPersonCaptionLbl: Label 'SalesPerson';
        ShipCaptionLbl: Label 'Ship';
        SalesOrderCaptionLbl: Label 'SALES ORDER';
        SalesOrderNumberCaptionLbl: Label 'Sales Order Number:';
        SalesOrderDateCaptionLbl: Label 'Sales Order Date:';
        PageCaptionLbl: Label 'Page:';
        ShipViaCaptionLbl: Label 'Ship Via';
        TermsCaptionLbl: Label 'Terms';
        PODateCaptionLbl: Label 'P.O. Date';
        TaxIdentTypeCaptionLbl: Label 'Tax Ident. Type';
        ItemNoCaptionLbl: Label 'Item No.';
        UnitCaptionLbl: Label 'Unit';
        DescriptionCaptionLbl: Label 'Description';
        QuantityCaptionLbl: Label 'Quantity';
        UnitPriceCaptionLbl: Label 'Unit Price';
        TotalPriceCaptionLbl: Label 'Total Price';
        SubtotalCaptionLbl: Label 'Subtotal:';
        InvoiceDiscountCaptionLbl: Label 'Invoice Discount:';
        TotalCaptionLbl: Label 'Total:';
        AmtSubjecttoSalesTaxCptnLbl: Label 'Amount Subject to Sales Tax';
        AmtExemptfromSalesTaxCptnLbl: Label 'Amount Exempt from Sales Tax';
        ReferenceCaptionLbl: Label 'Reference';
        Shipping_AgentCaptionLbl: Label 'Shipping Agent';
        Shipment_MethodCaptionLbl: Label 'Shipment Method';
        Payment_TermsCaptionLbl: Label 'Payment Terms';
        Freight_TermsCaptionLbl: Label 'Freight Terms';
        ">>NIF": Integer;
        SubTotal: Decimal;
        AmountSubjectToSalesTax: Decimal;
        AmountExemptFromSalesTax: Decimal;
        InvoiceDiscount: Decimal;
        TotalTax: Decimal;
        Total: Decimal;

    procedure GetUnitOfMeasureDescr(UOMCode: Code[10]): Text[10]
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        IF NOT UnitOfMeasure.GET(UOMCode) THEN
            EXIT(UOMCode);
        EXIT(UnitOfMeasure.Description);
    end;

    procedure BlanksForIndent(): Text[10]
    begin
        EXIT(PADSTR('', 2, ' '));
    end;
}

