report 50093 "Purchase Order NV"
{
    // NF1.00:CIS.NG  07-18-16 Upgrade Report to NAV 2016
    // NF1.00:CIS.NG  12-09-16 Updae the Hidden formula to print amount againts G/L Lines
    // 
    // SM.001 Fixed Margin and made the report narrower.
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = '.\RDLC\Purchase Order NV.rdlc';

    Caption = 'Purchase Order NV';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST(Order));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Buy-from Vendor No.", "Pay-to Vendor No.", "No. Printed";
            column(POAuthority_User; User."PO Authority")
            {
            }
            column(E_Signature_User; User."E-Signature")
            {
            }
            column(TennOnly; TennOnly)
            {
            }
            column(Disclaimer; Disclaimer)
            {
            }
            column(PH_CurrCode; "Currency Code")
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
            column(BuyFromAddress_1_; BuyFromAddress[1])
            {
            }
            column(BuyFromAddress_2_; BuyFromAddress[2])
            {
            }
            column(BuyFromAddress_3_; BuyFromAddress[3])
            {
            }
            column(BuyFromAddress_4_; BuyFromAddress[4])
            {
            }
            column(BuyFromAddress_5_; BuyFromAddress[5])
            {
            }
            column(BuyFromAddress_6_; BuyFromAddress[6])
            {
            }
            column(BuyFromAddress_7_; BuyFromAddress[7])
            {
            }
            column(Purchase_Header___Expected_Receipt_Date_; "Expected Receipt Date")
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
            column(Purchase_Header___Buy_from_Vendor_No__; "Buy-from Vendor No.")
            {
            }
            column(SalesPurchPerson_Name; SalesPurchPerson.Name)
            {
            }
            column(Purchase_Header___No__; "No.")
            {
            }
            column(Purchase_Header___Order_Date_; "Order Date")
            {
            }
            column(CurrReport_PAGENO; 1)//CurrReport.PAGENO)
            {
            }
            column(CompanyAddress_7_; CompanyAddress[7])
            {
            }
            column(ShipmentMethod_Description; ShipmentMethod.Description)
            {
            }
            column(PaymentTerms_Description; PaymentTerms.Description)
            {
            }
            column(CompanyInformation__Phone_No__; CompanyInformation."Phone No.")
            {
            }
            column(NotReleased; NotReleased)
            {
            }
            column(Purchase_Header___No________; '*' + "No." + '*')
            {
            }
            column(CompanyInformation__Document_Logo_; CompanyInformation.Picture)// "Document Logo")
            {
            }
            column(ShippingAgent_Name; ShippingAgent.Name)
            {
            }
            column(Purchase_Header___Your_Reference_; "Your Reference")
            {
            }
            column(Purchase_Header___Requested_Receipt_Date_; "Requested Receipt Date")
            {
            }
            column(Purchase_Header___Ship_by_Date_; "Ship by Date")
            {
            }
            column(To_Caption; To_CaptionLbl)
            {
            }
            column(Receive_ByCaption; Receive_ByCaptionLbl)
            {
            }
            column(Vendor_IDCaption; Vendor_IDCaptionLbl)
            {
            }
            column(BuyerCaption; BuyerCaptionLbl)
            {
            }
            column(ShipCaption; ShipCaptionLbl)
            {
            }
            column(To_Caption_Control89; To_Caption_Control89Lbl)
            {
            }
            column(PURCHASE_ORDERCaption; PURCHASE_ORDERCaptionLbl)
            {
            }
            column(Purchase_Order_Number_Caption; Purchase_Order_Number_CaptionLbl)
            {
            }
            column(Purchase_Order_Date_Caption; Purchase_Order_Date_CaptionLbl)
            {
            }
            column(Page_Caption; Page_CaptionLbl)
            {
            }
            column(Ship_MethodCaption; Ship_MethodCaptionLbl)
            {
            }
            column(Payment_TermsCaption; Payment_TermsCaptionLbl)
            {
            }
            column(Phone_No_Caption; Phone_No_CaptionLbl)
            {
            }
            column(Ship_ViaCaption; Ship_ViaCaptionLbl)
            {
            }
            column(Confirm_ToCaption; Confirm_ToCaptionLbl)
            {
            }
            column(Delivery_DateCaption; Delivery_DateCaptionLbl)
            {
            }
            column(Ship_by_DateCaption; Ship_by_DateCaptionLbl)
            {
            }
            column(UserName_User; User."User ID")//"User Name" BC Upgrade
            {
            }
            column(Revision_No_Caption; Revision_No_CaptionLbl)
            {
            }
            column(Item_No_Caption; Item_No_CaptionLbl)
            {
            }
            column(PacksCaption; PacksCaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(SNPCaption; SNPCaptionLbl)
            {
            }
            column(Unit_PriceCaption; Unit_PriceCaptionLbl)
            {
            }
            column(QuantityCaption; QuantityCaptionLbl)
            {
            }
            column(Total_PriceCaption; Total_PriceCaptionLbl)
            {
            }
            column(UnitCaption; UnitCaptionLbl)
            {
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                    WHERE("Document Type" = CONST(Order));

                trigger OnAfterGetRecord()
                begin
                    TempPurchLine := "Purchase Line";
                    TempPurchLine.INSERT;
                    HighestLineNo := "Line No.";
                end;

                trigger OnPreDataItem()
                begin
                    TempPurchLine.RESET;
                    TempPurchLine.DELETEALL;
                end;
            }
            /* BC Upgrade No need show any comment line in report===================
            dataitem("Purch. Comment Line"; "Purch. Comment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.")
                                    WHERE("Document Type" = CONST(Order));//,"Print On Order"=CONST(Yes)); BC Upgrade

                trigger OnAfterGetRecord()
                begin
                    TempPurchLine.INIT;
                    TempPurchLine."Document Type" := "Purchase Header"."Document Type";
                    TempPurchLine."Document No." := "Purchase Header"."No.";
                    TempPurchLine."Line No." := HighestLineNo + 1000;
                    HighestLineNo := TempPurchLine."Line No.";

                    IF STRLEN(Comment) <= MAXSTRLEN(TempPurchLine.Description) THEN BEGIN
                        TempPurchLine.Description := Comment;
                        TempPurchLine."Description 2" := '';
                    END ELSE BEGIN
                        SpacePointer := MAXSTRLEN(TempPurchLine.Description) + 1;
                        WHILE (SpacePointer > 1) AND (Comment[SpacePointer] <> ' ') DO
                            SpacePointer := SpacePointer - 1;
                        IF SpacePointer = 1 THEN
                            SpacePointer := MAXSTRLEN(TempPurchLine.Description) + 1;
                        TempPurchLine.Description := COPYSTR(Comment, 1, SpacePointer - 1);
                        TempPurchLine."Description 2" := COPYSTR(COPYSTR(Comment, SpacePointer + 1), 1, MAXSTRLEN(TempPurchLine."Description 2"));
                    END;
                    TempPurchLine.INSERT;
                end;

                trigger OnPreDataItem()
                var
                    cntPurchCommentLine: Record "Purch. Comment Line";
                begin
                end;
            } */
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    dataitem(PurchLine; Integer)
                    {
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING(Number);
                        column(CopyNo; CopyNo)
                        {
                        }
                        column(Number_PurchLine; PurchLine.Number)
                        {
                        }
                        column(ItemNumberToPrint; ItemNumberToPrint)
                        {
                        }
                        column(DocumentNo_TempPurchaseLine; TempPurchLine."Document No.")
                        {
                        }
                        column(LineNo_TempPurchaseLine; TempPurchLine."Line No.")
                        {
                        }
                        column(TempPurchLine__Unit_of_Measure_; TempPurchLine."Unit of Measure")
                        {
                        }
                        column(TempPurchLine_Quantity; TempPurchLine.Quantity)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(UnitPriceToPrint; UnitPriceToPrint)
                        {
                            DecimalPlaces = 2 : 5;
                        }
                        column(AmountExclInvDisc; AmountExclInvDisc)
                        {
                        }
                        column(TempPurchLine_Description_________TempPurchLine__Description_2_; TempPurchLine.Description + ' ' + TempPurchLine."Description 2")
                        {
                        }
                        column(TempPurchLine__Units_per_Parcel_; TempPurchLine."Units per Parcel")
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(Packs; Packs)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(TempPurchLine_Description_________TempPurchLine__Description_2__Control1102623003; TempPurchLine.Description + ' ' + TempPurchLine."Description 2")
                        {
                        }
                        column(TempPurchLine__Revision_No__; TempPurchLine."Revision No.")
                        {
                        }
                        column(Transferred_to_page_____FORMAT_CurrReport_PAGENO___1_; 'Transferred to page ')// + FORMAT(CurrReport.PAGENO + 1))BC Upgrade
                        {
                        }
                        column(AmountExclInvDisc_Control79; AmountExclInvDisc)
                        {
                        }
                        column(TempPurchLine_Amount___AmountExclInvDisc; TempPurchLine.Amount - AmountExclInvDisc)
                        {
                        }
                        column(TempPurchLine__Amount_Including_VAT____TempPurchLine_Amount; TempPurchLine."Amount Including VAT" - TempPurchLine.Amount)
                        {
                        }
                        column(TempPurchLine__Amount_Including_VAT_; TempPurchLine."Amount Including VAT")
                        {
                        }
                        column(TaxLiable; TaxLiable)
                        {
                        }
                        column(TempPurchLine_Amount___TaxLiable; TempPurchLine.Amount - TaxLiable)
                        {
                        }
                        column(TempPurchLine_AltPriceUOM; TempPurchLine."Alt. Price UOM")
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
                        column(Subtotal_Caption; Subtotal_CaptionLbl)
                        {
                        }
                        column(Invoice_Discount_Caption; Invoice_Discount_CaptionLbl)
                        {
                        }
                        column(Sales_Tax_Caption; Sales_Tax_CaptionLbl)
                        {
                        }
                        column(Total_Caption; Total_CaptionLbl)
                        {
                        }
                        column(Amount_Exempt_from_Sales_TaxCaption; Amount_Exempt_from_Sales_TaxCaptionLbl)
                        {
                        }
                        column(Amount_Subject_to_Sales_TaxCaption; Amount_Subject_to_Sales_TaxCaptionLbl)
                        {
                        }
                        column(Confirmed_By_Caption; Confirmed_By_CaptionLbl)
                        {
                        }
                        column(Date_Caption; Date_CaptionLbl)
                        {
                        }
                        column(NIFAST_SignatureCaption; NIFAST_SignatureCaptionLbl)
                        {
                        }
                        column(PurchLine_Number; Number)
                        {
                        }
                        column(PrintFooter; PrintFooter)
                        {
                        }
                        column(RespCommentText_1; RespCommentText[1])
                        {
                        }
                        column(RespCommentText_2; RespCommentText[2])
                        {
                        }
                        column(RespCommentText_3; RespCommentText[3])
                        {
                        }
                        column(RespCommentText_4; RespCommentText[4])
                        {
                        }
                        column(RespCommentText_5; RespCommentText[5])
                        {
                        }
                        dataitem(PurchLineCommentLine; "Purch. Comment Line")
                        {
                            DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.");
                            //WHERE("Print On Order"=CONST(Yes)); BC Upgrade
                            column(PurchLineCommentLine_Date; Date)
                            {
                            }
                            column(PurchLineCommentLine_Comment; Comment)
                            {
                            }
                            column(PurchLineCommentLine_Document_Type; "Document Type")
                            {
                            }
                            column(PurchLineCommentLine_No_; "No.")
                            {
                            }
                            column(PurchLineCommentLine_Doc__Line_No_; "Document Line No.")
                            {
                            }
                            column(PurchLineCommentLine_Line_No_; "Line No.")
                            {
                            }

                            trigger OnPreDataItem()
                            begin
                                PurchLineCommentLine.SETRANGE("Document Type", TempPurchLine."Document Type");
                                PurchLineCommentLine.SETRANGE("No.", TempPurchLine."Document No.");
                                //PurchLineCommentLine.SETRANGE("Doc. Line No.",TempPurchLine."Line No.");  //NF1.00:CIS.CM 09-29-15-O
                                PurchLineCommentLine.SETRANGE("Document Line No.", TempPurchLine."Line No.");  //NF1.00:CIS.CM 09-29-15-N

                                PurchLineCommentLine.SETRANGE("Document Line No.", -11);//BC Upgrade Skip all comment lines
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            OnLineNumber := OnLineNumber + 1;

                            IF OnLineNumber = 1 THEN
                                TempPurchLine.FIND('-')
                            ELSE
                                TempPurchLine.NEXT;


                            IF TempPurchLine."Vendor Item No." <> '' THEN
                                ItemNumberToPrint := TempPurchLine."Vendor Item No."
                            ELSE
                                ItemNumberToPrint := TempPurchLine."No.";

                            IF TempPurchLine.Type = TempPurchLine.Type::" " THEN BEGIN
                                ItemNumberToPrint := '';
                                TempPurchLine."Unit of Measure" := '';
                                TempPurchLine.Amount := 0;
                                TempPurchLine."Amount Including VAT" := 0;
                                TempPurchLine."Inv. Discount Amount" := 0;
                                TempPurchLine.Quantity := 0;
                            END ELSE IF TempPurchLine.Type = TempPurchLine.Type::"G/L Account" THEN
                                    ItemNumberToPrint := '';

                            IF TempPurchLine.Amount <> TempPurchLine."Amount Including VAT" THEN BEGIN
                                TaxFlag := TRUE;
                                TaxLiable := TempPurchLine.Amount;
                            END ELSE BEGIN
                                TaxFlag := FALSE;
                                TaxLiable := 0;
                            END;

                            AmountExclInvDisc := TempPurchLine.Amount + TempPurchLine."Inv. Discount Amount";

                            //>>NIF
                            AmountSubjectToSalesTax += TaxLiable;
                            AmountExemptFromSalesTax += (TempPurchLine.Amount - TaxLiable);
                            SubTotal += AmountExclInvDisc;
                            InvoiceDiscount += (TempPurchLine.Amount - AmountExclInvDisc);
                            TotalTax += (TempPurchLine."Amount Including VAT" - TempPurchLine.Amount);
                            Total += TempPurchLine."Amount Including VAT";
                            //<<NIF

                            IF TempPurchLine.Quantity = 0 THEN
                                UnitPriceToPrint := 0  // so it won't print
                            ELSE
                                //>>NIF 11-01-05
                                IF (TempPurchLine."Alt. Price" <> 0) THEN
                                    UnitPriceToPrint := TempPurchLine."Alt. Price"
                                ELSE
                                    //<<NIF 11-01-05
                                    //>>NIF 10-20-05 RTT
                                    //UnitPriceToPrint := ROUND(AmountExclInvDisc / Quantity,0.00001);
                                    UnitPriceToPrint := ROUND(AmountExclInvDisc / TempPurchLine.Quantity, 0.001);
                            //<<NIF 10-20-05 RTT

                            //>> NIF
                            IF TempPurchLine."Units per Parcel" <> 0 THEN
                                Packs := TempPurchLine.Quantity / TempPurchLine."Units per Parcel"
                            ELSE
                                Packs := 0;
                            //<< NIF

                            IF OnLineNumber = NumberOfLines THEN
                                PrintFooter := TRUE;
                        end;

                        trigger OnPreDataItem()
                        begin
                            //CurrReport.CREATETOTALS(TaxLiable, AmountExclInvDisc, TempPurchLine.Amount, TempPurchLine."Amount Including VAT");BC Upgrade
                            NumberOfLines := TempPurchLine.COUNT;
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
                    IF CopyNo = NoLoops THEN BEGIN
                        IF NOT CurrReport.PREVIEW THEN
                            PurchasePrinted.RUN("Purchase Header");
                        CurrReport.BREAK;
                    END ELSE
                        CopyNo := CopyNo + 1;
                    IF CopyNo = 1 THEN // Original
                        CLEAR(CopyTxt)
                    ELSE
                        CopyTxt := 'COPY';
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
                tLastArrayUsed: Integer;
                tCurrArrayPosition: Integer;
                tempPurHdr: Record "Purchase Header" temporary;
            begin

                //>> IST 06-21-05
                IF PrintCompany THEN BEGIN
                    IF RespCenter.GET("Responsibility Center") THEN BEGIN
                        FormatAddress.RespCenter(CompanyAddress, RespCenter);
                        CompanyInformation."Phone No." := RespCenter."Phone No.";
                        CompanyInformation."Fax No." := RespCenter."Fax No.";
                    END;
                END;





                //>> RTT 09-21-05
                IF RespCenter.GET("Responsibility Center") THEN
                    GetRespComments;
                //<< RTT 09-21-05


                //>>NIF MAK 082905 GOLIVE
                CLEAR(tLastArrayUsed);
                FOR tCurrArrayPosition := 1 TO ARRAYLEN(CompanyAddress) DO BEGIN
                    IF STRLEN(FORMAT(CompanyAddress[tCurrArrayPosition])) > 0 THEN
                        tLastArrayUsed := tCurrArrayPosition;
                END;
                IF tLastArrayUsed <= 5 THEN BEGIN
                    CompanyAddress[tLastArrayUsed + 2] := 'Phone No.: ' + CompanyInformation."Phone No.";
                    CompanyAddress[tLastArrayUsed + 3] := 'Fax No.: ' + CompanyInformation."Fax No.";
                END
                ELSE BEGIN
                    CompanyAddress[tLastArrayUsed + 1] := 'Phone No.: ' + CompanyInformation."Phone No.";
                    CompanyAddress[tLastArrayUsed + 2] := 'Fax No.: ' + CompanyInformation."Fax No.";
                END;
                //<<NIF MAK 082905 GOLIVE


                IF NOT ShippingAgent.GET("Shipping Agent Code") THEN
                    CLEAR(ShippingAgent);
                //<< IST 06-21-05


                IF "Purchaser Code" = '' THEN
                    CLEAR(SalesPurchPerson)
                ELSE
                    SalesPurchPerson.GET("Purchaser Code");

                IF "Payment Terms Code" = '' THEN
                    CLEAR(PaymentTerms)
                ELSE
                    PaymentTerms.GET("Payment Terms Code");

                IF "Shipment Method Code" = '' THEN
                    CLEAR(ShipmentMethod)
                ELSE
                    ShipmentMethod.GET("Shipment Method Code");

                tempPurHdr := "Purchase Header";
                tempPurHdr."Buy-from Contact" := '';
                tempPurHdr."Ship-to Contact" := '';
                FormatAddress.PurchHeaderBuyFrom(BuyFromAddress, tempPurHdr);//"Purchase Header"); BC Upgrade
                FormatAddress.PurchHeaderShipTo(ShipToAddress, tempPurHdr);//"Purchase Header");
                //>> RTT 09-21-05
                IF (Vend.GET("Purchase Header"."Buy-from Vendor No.")) THEN
                    IF Vend."Fax No." <> '' THEN BEGIN
                        BuyFromAddress[8] := 'Fax No.: ' + Vend."Fax No.";
                        COMPRESSARRAY(BuyFromAddress);
                    END;
                //<< RTT 09-21-05
            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.GET('');
                CompanyInformation.CALCFIELDS("Document Logo");
                CompanyInformation.CALCFIELDS(Picture);//BC Upgrade
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
                    field(Disclaimer; Disclaimer)
                    {
                        ApplicationArea = All;
                        Caption = 'Disclaimer';
                    }
                    field("Shipment Term"; TennOnly)
                    {
                        ApplicationArea = All;
                        Caption = 'Shipment Term';
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
            ArchiveDocument := ArchiveManagement.PurchaseDocArchiveGranule;
            LogInteraction := SegManagement.FindInteractionTemplateCode("Interaction Log Entry Document Type"::"Purch. Ord.") <> ''; //FindInteractTmplCode(13) <> ''; BC Upgrade

            ArchiveDocumentEnable := ArchiveDocument;
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
        Cartons_Lbl = 'Cartons';
        Quantity_Lbl = 'Quantity';
        UnitPrice_Lbl = 'Unit Price';
        PricePer_Lbl = 'Price Per';
    }

    trigger OnInitReport()
    begin
        PrintCompany := TRUE;
    end;

    trigger OnPreReport()
    begin
        CompanyInformation.GET('');
        //>> NF1.00:CIS.CM 08-28-15
        User.SETRANGE("User ID", USERID);//"User Name" BC Upgrade
        IF User.FINDFIRST THEN
            User.CALCFIELDS("E-Signature");
        //<< NF1.00:CIS.CM 08-28-15
    end;

    var
        UnitPriceToPrint: Decimal;
        AmountExclInvDisc: Decimal;
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
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
        PurchasePrinted: Codeunit "Purch.Header-Printed";
        FormatAddress: Codeunit "Format Address";
        SalesTaxCalc: Codeunit "Sales Tax Calculate";
        ArchiveManagement: Codeunit ArchiveManagement;
        SegManagement: Codeunit SegManagement;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        TaxAmount: Decimal;
        TotalTaxLabel: Text[30];
        BreakdownTitle: Text[30];
        BreakdownLabel: array[4] of Text[30];
        BreakdownAmt: array[4] of Decimal;
        BrkIdx: Integer;
        PrevPrintOrder: Integer;
        PrevTaxPercent: Decimal;
        UseDate: Date;
        Text000: Label 'COPY';
        Text003: Label 'Sales Tax Breakdown:';
        Text004: Label 'Other Taxes';
        Text005: Label 'Total Sales Tax:';
        Text006: Label 'Tax Breakdown:';
        Text007: Label 'Total Tax:';
        Text008: Label 'Tax:';
        UseExternalTaxEngine: Boolean;
        //[InDataSet]BC Upgrade
        ArchiveDocumentEnable: Boolean;
        //[InDataSet]BC Upgrade
        LogInteractionEnable: Boolean;
        ID: Code[50];
        TempPurchLine: Record "Purchase Line" temporary;
        HighestLineNo: Integer;
        SpacePointer: Integer;
        ShippingAgent: Record "Shipping Agent";
        TaxLiable: Decimal;
        TaxFlag: Boolean;
        NotReleased: Text[30];
        Packs: Decimal;
        User: Record "User Setup"; //User BC Upgrade
        RespCommentText: array[100] of Text[100];
        Disclaimer: Boolean;
        TennOnly: Boolean;
        To_CaptionLbl: Label 'To:';
        Receive_ByCaptionLbl: Label 'Receive By';
        Vendor_IDCaptionLbl: Label 'Vendor ID';
        BuyerCaptionLbl: Label 'Buyer';
        ShipCaptionLbl: Label 'Ship';
        To_Caption_Control89Lbl: Label 'To:';
        PURCHASE_ORDERCaptionLbl: Label 'PURCHASE ORDER';
        Purchase_Order_Number_CaptionLbl: Label 'Purchase Order Number:';
        Purchase_Order_Date_CaptionLbl: Label 'Purchase Order Date:';
        Page_CaptionLbl: Label 'Page:';
        Ship_MethodCaptionLbl: Label 'Ship Method';
        Payment_TermsCaptionLbl: Label 'Payment Terms';
        Phone_No_CaptionLbl: Label 'Phone No.';
        Ship_ViaCaptionLbl: Label 'Ship Via';
        Confirm_ToCaptionLbl: Label 'Confirm To';
        Delivery_DateCaptionLbl: Label 'Delivery Date';
        Ship_by_DateCaptionLbl: Label 'Ship by Date';
        QuantityCaptionLbl: Label 'Quantity';
        Unit_PriceCaptionLbl: Label 'Unit Price';
        Total_PriceCaptionLbl: Label 'Total Price';
        CartonsCaptionLbl: Label 'Cartons';
        SNPCaptionLbl: Label 'SNP';
        Item_No_CaptionLbl: Label 'Item No.';
        DescriptionCaptionLbl: Label 'Description';
        Price_perCaptionLbl: Label 'Price per';
        Subtotal_CaptionLbl: Label 'Subtotal:';
        Invoice_Discount_CaptionLbl: Label 'Invoice Discount:';
        Sales_Tax_CaptionLbl: Label 'Sales Tax:';
        Amount_Exempt_from_Sales_TaxCaptionLbl: Label 'Amount Exempt from Sales Tax';
        Amount_Subject_to_Sales_TaxCaptionLbl: Label 'Amount Subject to Sales Tax';

        /* BC Upgrade Comment out no use in BC
        The__product__identified__herein__represents__the__product__that__Nifast_intends_to_purchase__No_substitutions_are_acceptableLbl: Label 'The  product  identified  herein  represents  the  product  that  Nifast intends to purchase. No substitutions are acceptable unless authorized by';
        Nifast__Partial_shipments_can_only_be_made_with_Nifast_authorization__Acceptance_of_this_order_constitutes_acceptance_of_its_Lbl: Label 'Nifast. Partial shipments can only be made with Nifast authorization. Acceptance of this order constitutes acceptance of its terms,  conditions,';
        and_specifications___Please_confirm_this_purchase_order_with__your_signature_and_return_it__on_this_form_or_separate_correspoLbl: Label 'and specifications.  Please confirm this purchase order with  your signature and return it  on this form or separate correspondence.  Lack  of  a';
        confirming__within_3_business_days_constitutes_acceptance_of_these_terms_CaptionLbl: Label '"confirming" within 3 business days constitutes acceptance of these terms.';
        Nifast_requires_100__on_time_delivery__Any_additional_freight_costs_incurred__for_shipment_to_Nifast_or_shipments_from_NifastLbl: Label 'Nifast requires 100% on time delivery. Any additional freight costs incurred, for shipment to Nifast or shipments from Nifast to Nifast customers, due to delayed shipments or partial shipments of this purchase order will be the responsibility of the supplier.';
        In_the_event_that_there_are_multiple_purchase_orders_scheduled_to_ship_within_a_15_day_period_of_each_other__please_contact_NLbl: Label ' In the event that there are multiple purchase orders scheduled to ship within a 15 day period of each other, please contact Nifast for shipping instructions.   Shipments of multiple purchase orders on the same day must be shipped on a single bill of lading. Failure to do so may result in the additional freight costs being charged back to the supplier.';
 */
        Total_CaptionLbl: Label 'Total:';
        Date_CaptionLbl: Label 'Date:';
        Confirmed_By_CaptionLbl: Label 'Confirmed By:';
        NIFAST_SignatureCaptionLbl: Label 'NIFAST Signature';
        Revision_No_CaptionLbl: Label 'Revision No.';
        PacksCaptionLbl: Label 'Packs';
        UnitCaptionLbl: Label 'Unit';
        ">>NIF": Integer;
        SubTotal: Decimal;
        AmountSubjectToSalesTax: Decimal;
        AmountExemptFromSalesTax: Decimal;
        InvoiceDiscount: Decimal;
        TotalTax: Decimal;
        Total: Decimal;

    procedure ">>NIF_fcn"()
    begin
    end;

    procedure GetRespComments()
    var
        RespCommentLine: Record "Comment Line";
        i: Integer;
    begin
        CLEAR(RespCommentText);
        CLEAR(i);
        /* BC Upgrade comment out can not find comment line function for "Responsibility Center"
        RespCommentLine.RESET;
        RespCommentLine.SETRANGE("Table Name", RespCommentLine."Table Name"::"Responsibility Center");
        RespCommentLine.SETRANGE("No.", "Purchase Header"."Responsibility Center");
        RespCommentLine.SETRANGE("Print On Purch. Order", TRUE);
        IF RespCommentLine.FIND('-') THEN
            REPEAT
                i := i + 1;
                RespCommentText[i] := RespCommentLine.Comment;
            UNTIL RespCommentLine.NEXT = 0; */
    end;
}

