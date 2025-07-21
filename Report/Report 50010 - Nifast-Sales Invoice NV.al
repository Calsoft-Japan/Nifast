report 50010 "Nifast-Sales Invoice NV"
{
    // NF1.00:CIS.NG 08-22-15 Merged during upgrade
    // NF1.00:CIS.CM    09/29/15 Update for New Vision Removal Task
    // >> NIF
    // Functions Added:
    //   GetCrossRefNo
    // Code Modified:
    //   SalesInvLine - OnAfterGetRecord
    // 
    // Date      Init     Proj     Description
    // 06-30-05  RTT               added code and fcn to get customer cross reference no.
    // 09-22-05  RTT               added ReleaseNoText to show release no.
    // 12-07-05  RTT               code at Sales Comment Line - OnAfterGetRecord
    // 02/14/06 RTT           code at SalesInvLine-OnAfterGetRecord() to use unit price if no discount
    // << NIF
    // 10/19/22 SM Added Curency on the header
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = '.\RDLC\Nifast-Sales Invoice NV.rdlc';

    Caption = 'Sales - Invoice';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Sell-to Customer No.", "Bill-to Customer No.", "Ship-to Code", "No. Printed";
            RequestFilterHeading = 'Sales Invoice';
            column(No_SalesInvHeader; "No.")
            {
            }
            column(No_SalesShipHdr; SalesShipmentHeader."No.")
            {
            }
            column(PostingDate_SalesShipHdr; FORMAT(SalesShipmentHeader."Posting Date"))
            {
            }
            column(OrderNo_SalesShipHdr; SalesShipmentHeader."Order No.")
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");
                dataitem(SalesLineComments; "Sales Comment Line")
                {
                    DataItemLink = "No." = FIELD("Document No."),
                                   "Document Line No." = FIELD("Line No.");
                    DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.")
                                        WHERE("Document Type" = CONST("Posted Invoice"));//, "Print On Invoice" = CONST(Yes)); Remove in Upgrade 2025-06-23

                    trigger OnAfterGetRecord()
                    begin
                        //>> NF1.00:CIS.NG 08-22-15
                        //WITH TempSalesInvoiceLine DO BEGIN
                        //  INIT;
                        //  "Document No." := "Sales Invoice Header"."No.";
                        //  "Line No." := HighestLineNo + 10;
                        //  HighestLineNo := "Line No.";
                        //END;
                        //IF STRLEN(Comment) <= MAXSTRLEN(TempSalesInvoiceLine.Description) THEN BEGIN
                        //  TempSalesInvoiceLine.Description := Comment;
                        //  TempSalesInvoiceLine."Description 2" := '';
                        //END ELSE BEGIN
                        //  SpacePointer := MAXSTRLEN(TempSalesInvoiceLine.Description) + 1;
                        //  WHILE (SpacePointer > 1) AND (Comment[SpacePointer] <> ' ') DO
                        //    SpacePointer := SpacePointer - 1;
                        //  IF SpacePointer = 1 THEN
                        //    SpacePointer := MAXSTRLEN(TempSalesInvoiceLine.Description) + 1;
                        //  TempSalesInvoiceLine.Description := COPYSTR(Comment,1,SpacePointer - 1);
                        //  TempSalesInvoiceLine."Description 2" :=
                        //    COPYSTR(COPYSTR(Comment,SpacePointer + 1),1,MAXSTRLEN(TempSalesInvoiceLine."Description 2"));
                        //END;
                        //TempSalesInvoiceLine.INSERT;
                        //<< NF1.00:CIS.NG 08-22-15
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    TempSalesInvoiceLine := "Sales Invoice Line";
                    TempSalesInvoiceLine.INSERT;
                    TempSalesInvoiceLineAsm := "Sales Invoice Line";
                    TempSalesInvoiceLineAsm.INSERT;

                    HighestLineNo := "Line No.";
                end;

                trigger OnPreDataItem()
                begin
                    TempSalesInvoiceLine.RESET;
                    TempSalesInvoiceLine.DELETEALL;
                    TempSalesInvoiceLineAsm.RESET;
                    TempSalesInvoiceLineAsm.DELETEALL;
                end;
            }
            /* Comment out to hide comment lines in the report.
            dataitem(DataItem8541; "Sales Comment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.")
                                    WHERE("Document Type" = CONST("Posted Invoice"),
                                          //"Print On Invoice" = CONST(Yes), Remove in Upgrade 2025-06-23
                                          "Document Line No." = CONST(0));

                trigger OnAfterGetRecord()
                begin
                    TempSalesInvoiceLine.INIT;
                    TempSalesInvoiceLine."Document No." := "Sales Invoice Header"."No.";
                    TempSalesInvoiceLine."Line No." := HighestLineNo + 1000;
                    HighestLineNo := TempSalesInvoiceLine."Line No.";

                    IF STRLEN(Comment) <= MAXSTRLEN(TempSalesInvoiceLine.Description) THEN BEGIN
                        TempSalesInvoiceLine.Description := Comment;
                        TempSalesInvoiceLine."Description 2" := '';
                    END ELSE BEGIN
                        SpacePointer := MAXSTRLEN(TempSalesInvoiceLine.Description) + 1;
                        WHILE (SpacePointer > 1) AND (Comment[SpacePointer] <> ' ') DO
                            SpacePointer := SpacePointer - 1;
                        IF SpacePointer = 1 THEN
                            SpacePointer := MAXSTRLEN(TempSalesInvoiceLine.Description) + 1;
                        TempSalesInvoiceLine.Description := COPYSTR(Comment, 1, SpacePointer - 1);
                        TempSalesInvoiceLine."Description 2" :=
                          COPYSTR(COPYSTR(Comment, SpacePointer + 1), 1, MAXSTRLEN(TempSalesInvoiceLine."Description 2"));
                    END;
                    //>> NIF 12-07-05
                    TempSalesInvoiceLine.Type := TempSalesInvoiceLine.Type::" ";//0;
                    TempSalesInvoiceLine."No." := '';
                    //<< NIF 12-07-05
                    TempSalesInvoiceLine.INSERT;
                end;

                trigger OnPreDataItem()
                begin
                    TempSalesInvoiceLine.INIT;
                    TempSalesInvoiceLine."Document No." := "Sales Invoice Header"."No.";
                    TempSalesInvoiceLine."Line No." := HighestLineNo + 1000;
                    HighestLineNo := TempSalesInvoiceLine."Line No.";

                    TempSalesInvoiceLine.INSERT;
                end;
            } */
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(CopyNo; CopyNo)
                    {
                    }
                    column(CompanyAddress_1_; CompanyAddress[1])
                    {
                    }
                    column(CompanyAddress_2_; CompanyAddress[2])
                    {
                    }
                    column(CompanyAddress_3_; CompanyAddress[3])
                    {
                    }
                    column(CompanyAddress_4_; CompanyAddress[4])
                    {
                    }
                    column(CompanyAddress_5_; CompanyAddress[5])
                    {
                    }
                    column(CompanyAddress_6_; CompanyAddress[6])
                    {
                    }
                    column(CopyTxt; CopyTxt)
                    {
                    }
                    column(BillToAddress_1_; BillToAddress[1])
                    {
                    }
                    column(BillToAddress_2_; BillToAddress[2])
                    {
                    }
                    column(BillToAddress_3_; BillToAddress[3])
                    {
                    }
                    column(BillToAddress_4_; BillToAddress[4])
                    {
                    }
                    column(BillToAddress_5_; BillToAddress[5])
                    {
                    }
                    column(BillToAddress_6_; BillToAddress[6])
                    {
                    }
                    column(BillToAddress_7_; BillToAddress[7])
                    {
                    }
                    column(ShipmentMethod_Description; ShipmentMethod.Description)
                    {
                    }
                    column(PaymentTerms_Description; PaymentTerms.Description)
                    {
                    }
                    column(ShipToAddress_1_; ShipToAddress[1])
                    {
                    }
                    column(ShipToAddress_2_; ShipToAddress[2])
                    {
                    }
                    column(ShipToAddress_3_; ShipToAddress[3])
                    {
                    }
                    column(ShipToAddress_4_; ShipToAddress[4])
                    {
                    }
                    column(ShipToAddress_5_; ShipToAddress[5])
                    {
                    }
                    column(ShipToAddress_6_; ShipToAddress[6])
                    {
                    }
                    column(ShipToAddress_7_; ShipToAddress[7])
                    {
                    }
                    column(Sales_Invoice_Header___Sell_to_Customer_No__; "Sales Invoice Header"."Sell-to Customer No.")
                    {
                    }
                    column(Sales_Invoice_Header___External_Document_No__; "Sales Invoice Header"."External Document No.")
                    {
                    }
                    column(Sales_Invoice_Header___Order_Date_; FORMAT("Sales Invoice Header"."Order Date"))
                    {
                    }
                    column(Sales_Invoice_Header___Order_No__; "Sales Invoice Header"."Order No.")
                    {
                    }
                    column(SalesPurchPerson_Name; SalesPurchPerson.Name)
                    {
                    }
                    column(Sales_Invoice_Header___No__; "Sales Invoice Header"."No.")
                    {
                    }
                    column(Sales_Invoice_Header___Posting_Date_; FORMAT("Sales Invoice Header"."Posting Date"))
                    {
                    }
                    column(CurrReport_PAGENO; 1)//CurrReport.PAGENO)
                    {
                    }
                    column(CompanyAddress_7_; 'Phone: ' + CompanyInformation."Phone No.")//CompanyAddress[7])
                    {
                    }
                    column(CompanyAddress_8_; 'Fax: ' + CompanyInformation."Fax No.")//CompanyAddress[8])
                    {
                    }
                    column(BillToAddress_8_; BillToAddress[8])
                    {
                    }
                    column(ShipToAddress_8_; ShipToAddress[8])
                    {
                    }
                    column(Sales_Invoice_Header___Bill_to_Customer_No__; "Sales Invoice Header"."Bill-to Customer No.")
                    {
                    }
                    column(Sales_Invoice_Header___Ship_to_Code_; "Sales Invoice Header"."Ship-to Code")
                    {
                    }
                    column(Sales_Invoice_Header___Your_Reference_; "Sales Invoice Header"."Your Reference")
                    {
                    }
                    column(SalesPurchPerson2_Name; SalesPurchPerson2.Name)
                    {
                    }
                    column(TaxRegNo; TaxRegNo)
                    {
                    }
                    column(TaxRegLabel; TaxRegLabel)
                    {
                    }
                    column(SalesSetup__Remit_To_Line_1_; SalesSetup."Remit-To Line 1")
                    {
                    }
                    column(SalesSetup__Remit_To_Line_2_; SalesSetup."Remit-To Line 2")
                    {
                    }
                    column(SalesSetup__Remit_To_Line_3_; SalesSetup."Remit-To Line 3")
                    {
                    }
                    column(SalesSetup__Remit_To_Line_4_; SalesSetup."Remit-To Line 4")
                    {
                    }
                    column(SalesSetup__Remit_To_Description_; SalesSetup."Remit-To Description")
                    {
                    }
                    column(CompanyInformation__Document_Logo_; CompanyInformation."Document Logo")
                    {
                    }
                    column(BillCaption; BillCaptionLbl)
                    {
                    }
                    column(To_Caption; To_CaptionLbl)
                    {
                    }
                    column(Ship_ViaCaption; Ship_ViaCaptionLbl)
                    {
                    }
                    column(TermsCaption; TermsCaptionLbl)
                    {
                    }
                    column(Customer_IDCaption; Customer_IDCaptionLbl)
                    {
                    }
                    column(P_O__NumberCaption; P_O__NumberCaptionLbl)
                    {
                    }
                    column(P_O__DateCaption; P_O__DateCaptionLbl)
                    {
                    }
                    column(Our_Order_No_Caption; Our_Order_No_CaptionLbl)
                    {
                    }
                    column(SalesPersonCaption; SalesPersonCaptionLbl)
                    {
                    }
                    column(ShipCaption; ShipCaptionLbl)
                    {
                    }
                    column(To_Caption_Control89; To_CaptionLbl)
                    {
                    }
                    column(INVOICECaption; INVOICECaptionLbl)
                    {
                    }
                    column(Invoice_Number_Caption; Invoice_Number_CaptionLbl)
                    {
                    }
                    column(Invoice_Date_Caption; Invoice_Date_CaptionLbl)
                    {
                    }
                    column(Page_Caption; Page_CaptionLbl)
                    {
                    }
                    column(ReferenceCaption; ReferenceCaptionLbl)
                    {
                    }
                    column(Inside_SalesPersonCaption; Inside_SalesPersonCaptionLbl)
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    column(Currency_Code; "Sales Invoice Header"."Currency Code")
                    {
                    }
                    dataitem(SalesInvLine; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(PrintFooter; PrintFooter)
                        {
                        }
                        column(AmountExclInvDisc; AmountExclInvDisc)
                        {
                        }
                        column(TempSalesInvoiceLineNo; TempSalesInvoiceLine."No.")
                        {
                        }
                        column(TempSalesInvoiceLineUOM; TempSalesInvoiceLine."Unit of Measure")
                        {
                        }
                        column(OrderedQuantity; OrderedQuantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(TempSalesInvoiceLineQty; TempSalesInvoiceLine.Quantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(UnitPriceToPrint; UnitPriceToPrint)
                        {
                            DecimalPlaces = 2 : 5;
                        }
                        column(LowDescriptionToPrint; LowDescriptionToPrint)
                        {
                        }
                        column(HighDescriptionToPrint; HighDescriptionToPrint)
                        {
                        }
                        column(TempSalesInvoiceLineDocNo; TempSalesInvoiceLine."Document No.")
                        {
                        }
                        column(TempSalesInvoiceLineLineNo; TempSalesInvoiceLine."Line No.")
                        {
                        }
                        column(TaxLiable; TaxLiable)
                        {
                        }
                        column(TempSalesInvoiceLineAmtTaxLiable; TempSalesInvoiceLine.Amount - TaxLiable)
                        {
                        }
                        column(TempSalesInvoiceLineAmtAmtExclInvDisc; TempSalesInvoiceLine.Amount - AmountExclInvDisc)
                        {
                        }
                        column(TempSalesInvoiceLineAmtInclVATAmount; TempSalesInvoiceLine."Amount Including VAT" - TempSalesInvoiceLine.Amount)
                        {
                        }
                        column(TempSalesInvoiceLineAmtInclVAT; TempSalesInvoiceLine."Amount Including VAT")
                        {
                        }
                        column(CrossRefText; CrossRefText)
                        {
                        }
                        column(ReleaseNoText; ReleaseNoText)
                        {
                        }
                        column(TotalTaxLabel; TotalTaxLabel)
                        {
                        }
                        column(BreakdownTitle; BreakdownTitle)
                        {
                        }
                        column(BreakdownLabel1; BreakdownLabel[1])
                        {
                        }
                        column(BreakdownAmt1; BreakdownAmt[1])
                        {
                        }
                        column(BreakdownAmt2; BreakdownAmt[2])
                        {
                        }
                        column(BreakdownLabel2; BreakdownLabel[2])
                        {
                        }
                        column(BreakdownAmt3; BreakdownAmt[3])
                        {
                        }
                        column(BreakdownLabel3; BreakdownLabel[3])
                        {
                        }
                        column(BreakdownAmt4; BreakdownAmt[4])
                        {
                        }
                        column(BreakdownLabel4; BreakdownLabel[4])
                        {
                        }
                        column(SalesLineCommentsText; SalesLineCommentsText)
                        {
                        }
                        column(ItemDescriptionCaption; ItemDescriptionCaptionLbl)
                        {
                        }
                        column(UnitCaption; UnitCaptionLbl)
                        {
                        }
                        column(OrderQtyCaption; OrderQtyCaptionLbl)
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
                        column(AmountSubjecttoSalesTaxCaption; AmountSubjecttoSalesTaxCaptionLbl)
                        {
                        }
                        column(AmountExemptfromSalesTaxCaption; AmountExemptfromSalesTaxCaptionLbl)
                        {
                        }
                        dataitem(AsmLoop; Integer)
                        {
                            DataItemTableView = SORTING(Number);
                            column(TempPostedAsmLineUOMCode; GetUOMText(TempPostedAsmLine."Unit of Measure Code"))
                            {
                                //DecimalPlaces = 0 : 5;
                            }
                            column(TempPostedAsmLineQuantity; TempPostedAsmLine.Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(TempPostedAsmLineDesc; BlanksForIndent + TempPostedAsmLine.Description)
                            {
                            }
                            column(TempPostedAsmLineNo; BlanksForIndent + TempPostedAsmLine."No.")
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN
                                    TempPostedAsmLine.FINDSET
                                ELSE BEGIN
                                    TempPostedAsmLine.NEXT;
                                    TaxLiable := 0;
                                    AmountExclInvDisc := 0;
                                    TempSalesInvoiceLine.Amount := 0;
                                    TempSalesInvoiceLine."Amount Including VAT" := 0;
                                END;
                            end;

                            trigger OnPreDataItem()
                            begin
                                CLEAR(TempPostedAsmLine);
                                SETRANGE(Number, 1, TempPostedAsmLine.COUNT);
                            end;
                        }

                        trigger OnAfterGetRecord()
                        var
                            SalesLineCommentLine: Record "Sales Comment Line";
                        begin
                            OnLineNumber := OnLineNumber + 1;

                            IF OnLineNumber = 1 THEN
                                TempSalesInvoiceLine.FIND('-')
                            ELSE
                                TempSalesInvoiceLine.NEXT;

                            //>> NIF 06-30-05 RTT
                            CLEAR(CrossRefText);
                            IF (TempSalesInvoiceLine.Type = TempSalesInvoiceLine.Type::Item) AND (TempSalesInvoiceLine."No." <> '') THEN
                                CrossRefText := GetCrossRefNo(TempSalesInvoiceLine);
                            //<< NIF 06-30-05 RTT
                            //>> NIF 09-22-05 RTT
                            CLEAR(ReleaseNoText);
                            IF (TempSalesInvoiceLine."Release No." <> '') THEN
                                ReleaseNoText := 'Release No.: ' + TempSalesInvoiceLine."Release No.";
                            //<< NIF 09-22-05 RTT

                            OrderedQuantity := 0;
                            IF "Sales Invoice Header"."Order No." = '' THEN
                                OrderedQuantity := TempSalesInvoiceLine.Quantity
                            ELSE
                                IF OrderLine.GET(1, "Sales Invoice Header"."Order No.", TempSalesInvoiceLine."Line No.") THEN
                                    OrderedQuantity := OrderLine.Quantity
                                ELSE BEGIN
                                    ShipmentLine.SETRANGE("Order No.", "Sales Invoice Header"."Order No.");
                                    ShipmentLine.SETRANGE("Order Line No.", TempSalesInvoiceLine."Line No.");
                                    IF ShipmentLine.FIND('-') THEN;
                                    REPEAT
                                        OrderedQuantity := OrderedQuantity + ShipmentLine.Quantity;
                                    UNTIL 0 = ShipmentLine.NEXT;
                                END;

                            DescriptionToPrint := TempSalesInvoiceLine.Description + ' ' + TempSalesInvoiceLine."Description 2";
                            IF TempSalesInvoiceLine.Type = TempSalesInvoiceLine.Type::" " THEN BEGIN
                                IF OnLineNumber < NumberOfLines THEN BEGIN
                                    TempSalesInvoiceLine.NEXT;
                                    IF TempSalesInvoiceLine.Type = TempSalesInvoiceLine.Type::" " THEN BEGIN
                                        DescriptionToPrint :=
                                          COPYSTR(DescriptionToPrint + ' ' + TempSalesInvoiceLine.Description + ' ' + TempSalesInvoiceLine."Description 2", 1, MAXSTRLEN(DescriptionToPrint));
                                        OnLineNumber := OnLineNumber + 1;
                                        SalesInvLine.NEXT;
                                    END ELSE
                                        TempSalesInvoiceLine.NEXT(-1);
                                END;
                                TempSalesInvoiceLine."No." := '';
                                TempSalesInvoiceLine."Unit of Measure" := '';
                                TempSalesInvoiceLine.Amount := 0;
                                TempSalesInvoiceLine."Amount Including VAT" := 0;
                                TempSalesInvoiceLine."Inv. Discount Amount" := 0;
                                TempSalesInvoiceLine.Quantity := 0;
                                //>> NIF 12-07-05
                                OrderedQuantity := 0;
                                //<< NIF 12-07-05
                            END ELSE
                                IF TempSalesInvoiceLine.Type = TempSalesInvoiceLine.Type::"G/L Account" THEN
                                    TempSalesInvoiceLine."No." := '';

                            IF TempSalesInvoiceLine."No." = '' THEN BEGIN
                                HighDescriptionToPrint := DescriptionToPrint;
                                LowDescriptionToPrint := '';
                            END ELSE BEGIN
                                HighDescriptionToPrint := '';
                                LowDescriptionToPrint := DescriptionToPrint;
                            END;

                            IF TempSalesInvoiceLine.Amount <> TempSalesInvoiceLine."Amount Including VAT" THEN
                                TaxLiable := TempSalesInvoiceLine.Amount
                            ELSE
                                TaxLiable := 0;

                            AmountExclInvDisc := TempSalesInvoiceLine.Amount + TempSalesInvoiceLine."Inv. Discount Amount";

                            IF TempSalesInvoiceLine.Quantity = 0 THEN
                                UnitPriceToPrint := 0 // so it won't print
                                                      //>>NIF 02/14/06 RTT
                            ELSE IF TempSalesInvoiceLine."Line Discount Amount" = 0 THEN
                                UnitPriceToPrint := TempSalesInvoiceLine."Unit Price"
                            //<<NIF 02/14/06 RTT
                            ELSE
                                UnitPriceToPrint := ROUND(AmountExclInvDisc / TempSalesInvoiceLine.Quantity, 0.00001);


                            IF OnLineNumber = NumberOfLines THEN
                                PrintFooter := TRUE;
                            CollectAsmInformation(TempSalesInvoiceLine);

                            //>> NF1.00:CIS.NG 08-22-15
                            CLEAR(SalesLineComments);
                            CLEAR(SalesLineCommentsText);
                            SalesLineCommentLine.RESET;
                            SalesLineCommentLine.SETRANGE("Document Type", SalesLineCommentLine."Document Type"::"Posted Invoice");
                            SalesLineCommentLine.SETRANGE("Print On Invoice", TRUE);
                            SalesLineCommentLine.SETRANGE("No.", TempSalesInvoiceLine."Document No.");
                            //SalesLineCommentLine.SETRANGE("Doc. Line No.",TempSalesInvoiceLine."Line No.");  //NF1.00:CIS.CM 09-29-15-O
                            SalesLineCommentLine.SETRANGE("Document Line No.", TempSalesInvoiceLine."Line No.");  //NF1.00:CIS.CM 09-29-15-N
                            IF SalesLineCommentLine.FINDSET THEN BEGIN
                                REPEAT
                                    IF SalesLineCommentsText <> '' THEN
                                        SalesLineCommentsText += Text50000 + SalesLineCommentLine.Comment
                                    ELSE
                                        SalesLineCommentsText := SalesLineCommentLine.Comment;
                                UNTIL SalesLineCommentLine.NEXT = 0;
                            END;
                            //<< NF1.00:CIS.NG 08-22-15
                        end;

                        trigger OnPreDataItem()
                        begin
                            //CurrReport.CREATETOTALS(TaxLiable, AmountExclInvDisc, TempSalesInvoiceLine.Amount, TempSalesInvoiceLine."Amount Including VAT");BC Upgrade
                            NumberOfLines := TempSalesInvoiceLine.COUNT;
                            SETRANGE(Number, 1, NumberOfLines);
                            OnLineNumber := 0;
                            PrintFooter := FALSE;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    //CurrReport.PAGENO := 1; BC Upgrade

                    IF CopyNo = NoLoops THEN BEGIN
                        IF NOT CurrReport.PREVIEW THEN
                            SalesInvPrinted.RUN("Sales Invoice Header");
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
                    NoLoops := 1 + ABS(NoCopies) + Customer."Invoice Copies";
                    IF NoLoops <= 0 THEN
                        NoLoops := 1;
                    CopyNo := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF PrintCompany THEN
                    IF RespCenter.GET("Responsibility Center") THEN BEGIN
                        //>>NIF MAK 061405
                        //FormatAddress.RespCenter(CompanyAddress,RespCenter);   //Original Line
                        FormatAddress.GetCompanyAddr(RespCenter.Code, RespCenter, CompanyInformation, CompanyAddress);//RespCenterPhoneFax(CompanyAddress, RespCenter); BC Upgrade 2025-06-23
                        //CompanyInformation."Phone No." := RespCenter."Phone No.";
                        //CompanyInformation."Fax No." := RespCenter."Fax No.";
                        //<<NIF
                    END;

                /* Language_T.Reset();//BC Upgrade 2025-06-23
                Language_T.Get("Language Code");//BC Upgrade 2025-06-23
                CurrReport.LANGUAGE := Language_T."Windows Language ID"; //Language.GetLanguageID("Language Code"); BC Upgrade 2025-06-23 */

                IF "Salesperson Code" = '' THEN
                    CLEAR(SalesPurchPerson)
                ELSE
                    SalesPurchPerson.GET("Salesperson Code");

                IF "Inside Salesperson Code" = '' THEN
                    CLEAR(SalesPurchPerson2)
                ELSE
                    SalesPurchPerson2.GET("Inside Salesperson Code");

                IF NOT Customer.GET("Bill-to Customer No.") THEN BEGIN
                    CLEAR(Customer);
                    "Bill-to Name" := Text009;
                    "Ship-to Name" := Text009;
                END;
                DocumentText := USText000;
                IF "Prepayment Invoice" THEN
                    DocumentText := USText001;

                FormatAddress.SalesInvBillTo(BillToAddress, "Sales Invoice Header");
                FormatAddress.SalesInvShipTo(ShipToAddress, ShipToAddress, "Sales Invoice Header");//ShipToAddress BC Upgrade

                IF "Payment Terms Code" = '' THEN
                    CLEAR(PaymentTerms)
                ELSE
                    PaymentTerms.GET("Payment Terms Code");

                IF "Shipment Method Code" = '' THEN
                    CLEAR(ShipmentMethod)
                ELSE
                    ShipmentMethod.GET("Shipment Method Code");

                IF LogInteraction THEN
                    IF NOT CurrReport.PREVIEW THEN BEGIN
                        IF "Bill-to Contact No." <> '' THEN
                            SegManagement.LogDocument(
                              4, "No.", 0, 0, DATABASE::Contact, "Bill-to Contact No.", "Salesperson Code",
                              "Campaign No.", "Posting Description", '')
                        ELSE
                            SegManagement.LogDocument(
                              4, "No.", 0, 0, DATABASE::Customer, "Bill-to Customer No.", "Salesperson Code",
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
                        SalesTaxCalc.CallExternalTaxEngineForDoc(DATABASE::"Sales Invoice Header", 0, "No.")
                    ELSE BEGIN
                        SalesTaxCalc.AddSalesInvoiceLines("No.");
                        SalesTaxCalc.EndSalesTaxCalculation("Posting Date");
                    END;
                    SalesTaxCalc.GetSummarizedSalesTaxTable(TempSalesTaxAmtLine);
                    BrkIdx := 0;
                    PrevPrintOrder := 0;
                    PrevTaxPercent := 0;

                    TempSalesTaxAmtLine.RESET;
                    TempSalesTaxAmtLine.SETCURRENTKEY(TempSalesTaxAmtLine."Print Order", TempSalesTaxAmtLine."Tax Area Code for Key", TempSalesTaxAmtLine."Tax Jurisdiction Code");
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

                //>> NF1.00:CIS.NG 08-22-15
                CLEAR(SalesShipmentHeader);
                SalesShipmentHeader.RESET;
                SalesShipmentHeader.SETRANGE("Order No.", "Order No.");
                IF SalesShipmentHeader.FINDFIRST THEN;
                //<< NF1.00:CIS.NG 08-22-15
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
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = All;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                    }
                    field(DisplayAsmInfo; DisplayAssemblyInformation)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Assembly Components';
                    }
                    field("Show the PSH Numbers"; ShowDetails)
                    {
                        ApplicationArea = All;
                        Caption = 'Show the PSH Numbers';
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
            InitLogInteraction;
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
        ShipmentNoLbl = 'Shipment No.';
        ShipDateLbl = 'Ship Date';
    }

    trigger OnInitReport()
    begin
        PrintCompany := TRUE;
    end;

    trigger OnPreReport()
    begin
        ShipmentLine.SETCURRENTKEY("Order No.", "Order Line No.");
        IF NOT CurrReport.USEREQUESTPAGE THEN
            InitLogInteraction;

        CompanyInformation.GET;
        CompanyInformation.CALCFIELDS("Document Logo");
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

        IF PrintCompany THEN
            FormatAddress.Company(CompanyAddress, CompanyInformation)
        ELSE
            CLEAR(CompanyAddress);
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
        CompanyInfo3: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        Customer: Record Customer;
        OrderLine: Record "Sales Line";
        ShipmentLine: Record "Sales Shipment Line";
        TempSalesInvoiceLine: Record "Sales Invoice Line" temporary;
        TempSalesInvoiceLineAsm: Record "Sales Invoice Line" temporary;
        RespCenter: Record "Responsibility Center";
        Language_T: Record Language;
        TempSalesTaxAmtLine: Record "Sales Tax Amount Line" temporary;
        TaxArea: Record "Tax Area";
        Cust: Record Customer;
        TempPostedAsmLine: Record "Posted Assembly Line" temporary;
        CompanyAddress: array[8] of Text[50];
        BillToAddress: array[8] of Text[50];
        ShipToAddress: array[8] of Text[50];
        CopyTxt: Text[10];
        DescriptionToPrint: Text[210];
        HighDescriptionToPrint: Text[210];
        LowDescriptionToPrint: Text[210];
        PrintCompany: Boolean;
        PrintFooter: Boolean;
        NoCopies: Integer;
        NoLoops: Integer;
        CopyNo: Integer;
        NumberOfLines: Integer;
        OnLineNumber: Integer;
        HighestLineNo: Integer;
        SpacePointer: Integer;
        SalesInvPrinted: Codeunit "Sales Inv.-Printed";
        FormatAddress: Codeunit "Format Address";
        SalesTaxCalc: Codeunit "Sales Tax Calculate";
        SegManagement: Codeunit SegManagement;
        LogInteraction: Boolean;
        Text000: Label 'COPY';
        TaxRegNo: Text[30];
        TaxRegLabel: Text[30];
        TotalTaxLabel: Text[30];
        BreakdownTitle: Text[30];
        BreakdownLabel: array[4] of Text[30];
        BreakdownAmt: array[4] of Decimal;
        Text003: Label 'Sales Tax Breakdown:';
        Text004: Label 'Other Taxes';
        BrkIdx: Integer;
        PrevPrintOrder: Integer;
        PrevTaxPercent: Decimal;
        Text005: Label 'Total Sales Tax:';
        Text006: Label 'Tax Breakdown:';
        Text007: Label 'Total Tax:';
        Text008: Label 'Tax:';
        Text009: Label 'VOID INVOICE';
        DocumentText: Text[20];
        USText000: Label 'INVOICE';
        USText001: Label 'PREPAYMENT REQUEST';
        //[InDataSet] BC Upgrade
        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        BillCaptionLbl: Label 'Bill';
        ToCaptionLbl: Label 'To:';
        ShipViaCaptionLbl: Label 'Ship Via';
        ShipDateCaptionLbl: Label 'Ship Date';
        DueDateCaptionLbl: Label 'Due Date';
        TermsCaptionLbl: Label 'Terms';
        CustomerIDCaptionLbl: Label 'Customer ID';
        PONumberCaptionLbl: Label 'P.O. Number';
        PODateCaptionLbl: Label 'P.O. Date';
        OurOrderNoCaptionLbl: Label 'Our Order No.';
        SalesPersonCaptionLbl: Label 'SalesPerson';
        ShipCaptionLbl: Label 'Ship';
        InvoiceNumberCaptionLbl: Label 'Invoice Number:';
        InvoiceDateCaptionLbl: Label 'Invoice Date:';
        PageCaptionLbl: Label 'Page:';
        TaxIdentTypeCaptionLbl: Label 'Tax Ident. Type';
        ItemDescriptionCaptionLbl: Label 'Item/Description';
        UnitCaptionLbl: Label 'Unit';
        OrderQtyCaptionLbl: Label 'Order Qty';
        QuantityCaptionLbl: Label 'Quantity';
        UnitPriceCaptionLbl: Label 'Unit Price';
        TotalPriceCaptionLbl: Label 'Total Price';
        SubtotalCaptionLbl: Label 'Subtotal:';
        InvoiceDiscountCaptionLbl: Label 'Invoice Discount:';
        TotalCaptionLbl: Label 'Total:';
        AmountSubjecttoSalesTaxCaptionLbl: Label 'Amount Subject to Sales Tax';
        AmountExemptfromSalesTaxCaptionLbl: Label 'Amount Exempt from Sales Tax';
        ">>NIF_GV": Integer;
        SalesPurchPerson2: Record "Salesperson/Purchaser";
        CrossRefText: Text[200];
        ReleaseNoText: Text[100];
        ShowDetails: Boolean;
        To_CaptionLbl: Label 'To:';
        Ship_ViaCaptionLbl: Label 'Ship Via';
        Customer_IDCaptionLbl: Label 'Customer ID';
        P_O__NumberCaptionLbl: Label 'P.O. Number';
        P_O__DateCaptionLbl: Label 'P.O. Date';
        Our_Order_No_CaptionLbl: Label 'Our Order No.';
        INVOICECaptionLbl: Label 'INVOICE';
        Invoice_Number_CaptionLbl: Label 'Invoice Number:';
        Invoice_Date_CaptionLbl: Label 'Invoice Date:';
        Page_CaptionLbl: Label 'Page:';
        ReferenceCaptionLbl: Label 'Reference';
        Inside_SalesPersonCaptionLbl: Label 'Inside SalesPerson';
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesLineCommentsText: Text;
        Text50000: Label '<BR/>';

    procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractionTemplateCode("Interaction Log Entry Document Type"::"Sales Inv.") <> ''; //SegManagement.FindInteractTmplCode(4) <> ''; BC Upgrade 2025-06-23
    end;

    procedure CollectAsmInformation(TempSalesInvoiceLine: Record "Sales Invoice Line" temporary)
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        PostedAsmHeader: Record "Posted Assembly Header";
        PostedAsmLine: Record "Posted Assembly Line";
        SalesShipmentLine: Record "Sales Shipment Line";
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        TempPostedAsmLine.DELETEALL;
        IF NOT DisplayAssemblyInformation THEN
            EXIT;
        IF NOT TempSalesInvoiceLineAsm.GET(TempSalesInvoiceLine."Document No.", TempSalesInvoiceLine."Line No.") THEN
            EXIT;
        SalesInvoiceLine.GET(TempSalesInvoiceLineAsm."Document No.", TempSalesInvoiceLineAsm."Line No.");
        IF SalesInvoiceLine.Type <> SalesInvoiceLine.Type::Item THEN
            EXIT;

        ValueEntry.SETCURRENTKEY("Document No.");
        ValueEntry.SETRANGE("Document No.", SalesInvoiceLine."Document No.");
        ValueEntry.SETRANGE("Document Type", ValueEntry."Document Type"::"Sales Invoice");
        ValueEntry.SETRANGE("Document Line No.", SalesInvoiceLine."Line No.");
        IF NOT ValueEntry.FINDSET THEN
            EXIT;

        REPEAT
            IF ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.") THEN
                IF ItemLedgerEntry."Document Type" = ItemLedgerEntry."Document Type"::"Sales Shipment" THEN BEGIN
                    SalesShipmentLine.GET(ItemLedgerEntry."Document No.", ItemLedgerEntry."Document Line No.");
                    IF SalesShipmentLine.AsmToShipmentExists(PostedAsmHeader) THEN BEGIN
                        PostedAsmLine.SETRANGE("Document No.", PostedAsmHeader."No.");
                        IF PostedAsmLine.FINDSET THEN
                            REPEAT
                                TreatAsmLineBuffer(PostedAsmLine);
                            UNTIL PostedAsmLine.NEXT = 0;
                    END;
                END;
        UNTIL ValueEntry.NEXT = 0;
    end;

    procedure TreatAsmLineBuffer(PostedAsmLine: Record "Posted Assembly Line")
    begin
        CLEAR(TempPostedAsmLine);
        TempPostedAsmLine.SETRANGE(Type, PostedAsmLine.Type);
        TempPostedAsmLine.SETRANGE("No.", PostedAsmLine."No.");
        TempPostedAsmLine.SETRANGE("Variant Code", PostedAsmLine."Variant Code");
        TempPostedAsmLine.SETRANGE(Description, PostedAsmLine.Description);
        TempPostedAsmLine.SETRANGE("Unit of Measure Code", PostedAsmLine."Unit of Measure Code");
        IF TempPostedAsmLine.FINDFIRST THEN BEGIN
            TempPostedAsmLine.Quantity += PostedAsmLine.Quantity;
            TempPostedAsmLine.MODIFY;
        END ELSE BEGIN
            CLEAR(TempPostedAsmLine);
            TempPostedAsmLine := PostedAsmLine;
            TempPostedAsmLine.INSERT;
        END;
    end;

    procedure GetUOMText(UOMCode: Code[10]): Text[10]
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

    procedure ">>NIF_fcn"()
    begin
    end;

    procedure GetCrossRefNo(SalesInvLine: Record "Sales Invoice Line"): Text[100]
    var
        ItemCrossRef: Record "Item Reference";//"Item Cross Reference"; Upgrade 2025-06-23
    begin
        ItemCrossRef.SETRANGE("Item No.", SalesInvLine."No.");
        ItemCrossRef.SETRANGE("Variant Code", SalesInvLine."Variant Code");
        ItemCrossRef.SETRANGE("Unit of Measure", SalesInvLine."Unit of Measure Code");

        ItemCrossRef.SETRANGE("Reference Type", ItemCrossRef."Reference Type"::Customer);//Upgrade 2025-06-23
        ItemCrossRef.SETRANGE("Reference Type No.", SalesInvLine."Sell-to Customer No.");//Upgrade 2025-06-23
        // ItemCrossRef.SETRANGE("Cross-Reference Type", ItemCrossRef."Cross-Reference Type"::Customer);Upgrade 2025-06-23
        // ItemCrossRef.SETRANGE("Cross-Reference Type No.", SalesInvLine."Sell-to Customer No.");Upgrade 2025-06-23

        IF NOT ItemCrossRef.FIND('-') THEN
            ItemCrossRef.SETRANGE("Unit of Measure");

        IF NOT ItemCrossRef.FIND('-') THEN
            CLEAR(ItemCrossRef);

        //IF ItemCrossRef."Cross-Reference No." <> '' THEN Upgrade 2025-06-23//Upgrade 2025-06-23
        //    EXIT('Customer P/N: ' + ItemCrossRef."Cross-Reference No.");//Upgrade 2025-06-23
        IF ItemCrossRef."Reference No." <> '' THEN//Upgrade 2025-06-23
            EXIT('Customer P/N: ' + ItemCrossRef."Reference No.");//Upgrade 2025-06-23
    end;
}

