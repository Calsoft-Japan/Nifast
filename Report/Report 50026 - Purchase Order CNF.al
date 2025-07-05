report 50026 "Purchase Order CNF"
{
    // NF1.00:CIS.CM  08-28-15 Merged during upgrade
    // NF1.00:CIS.CM    09/29/15 Update for New Vision Removal Task
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = '.\RDLC\Purchase Order CNF.rdlc';

    Caption = 'Purchase Order CNF';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST(Order));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Buy-from Vendor No.", "Pay-to Vendor No.", "No. Printed";
            column(POAuthority_User; UserSetup."PO Authority")
            {
            }
            column(CompanyInformation__Document_Logo_; CompanyInformation."Document Logo")
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
            column(CompanyAddress_7_; CompanyAddress[7])
            {
            }
            column(CompanyAddress_8_; CompanyAddress[8])
            {
            }
            column(Purchase_Header___No________; '*' + "Purchase Header"."No." + '*')
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
            column(BuyFromAddress_5_; BuyFromAddress[5])
            {
            }
            column(ShipToAddress_5_; ShipToAddress[5])
            {
            }
            column(BuyFromAddress_6_; BuyFromAddress[6])
            {
            }
            column(ShipToAddress_6_; ShipToAddress[6])
            {
            }
            column(BuyFromAddress_7_; BuyFromAddress[7])
            {
            }
            column(ShipToAddress_7_; ShipToAddress[7])
            {
            }
            column(Purchase_Header__Purchase_Header___Your_Reference_; "Purchase Header"."Your Reference")
            {
            }
            column(ShipmentMethod_Code; ShipmentMethod.Code)
            {
            }
            column(SalesPurchPerson_Name; SalesPurchPerson.Name)
            {
            }
            column(ShippingAgent_Name; ShippingAgent.Name)
            {
            }
            column(Purchase_Header__Purchase_Header___Expected_Receipt_Date_; FORMAT("Purchase Header"."Expected Receipt Date"))
            {
            }
            column(CompanyInformation__Phone_No__; CompanyInformation."Phone No.")
            {
            }
            column(NotReleased; NotReleased)
            {
            }
            column(CopyTxt; CopyTxt)
            {
            }
            column(Purchase_Header__Purchase_Header___Buy_from_Vendor_No__; "Purchase Header"."Buy-from Vendor No.")
            {
            }
            column(PaymentTerms_Description; PaymentTerms.Description)
            {
            }
            column(Purchase_Header__Purchase_Header___No__; "Purchase Header"."No.")
            {
            }
            column(Purchase_Header__Purchase_Header___Order_Date_; FORMAT("Purchase Header"."Order Date"))
            {
            }
            column(CurrReport_PAGENO; 1)//CurrReport.PAGENO)
            {
            }
            column(Purchase_Header__Purchase_Header___Requested_Receipt_Date_; FORMAT("Purchase Header"."Requested Receipt Date"))
            {
            }
            column(Purchase_Header__Purchase_Header___Sail_on_Date_; FORMAT("Purchase Header"."Sail-on Date"))
            {
            }
            column(To_Caption; To_CaptionLbl)
            {
            }
            column(ShipCaption; ShipCaptionLbl)
            {
            }
            column(To_Caption_Control1102622015; To_Caption_Control1102622015Lbl)
            {
            }
            column(Purchase_Order_Number_Caption; Purchase_Order_Number_CaptionLbl)
            {
            }
            column(PURCHASE_ORDERCaption; PURCHASE_ORDERCaptionLbl)
            {
            }
            column(Purchase_Order_Date_Caption; Purchase_Order_Date_CaptionLbl)
            {
            }
            column(Confirm_ToCaption; Confirm_ToCaptionLbl)
            {
            }
            column(Shipment_MethodCaption; Shipment_MethodCaptionLbl)
            {
            }
            column(BuyerCaption; BuyerCaptionLbl)
            {
            }
            column(Ship_ViaCaption; Ship_ViaCaptionLbl)
            {
            }
            column(Receive_ByCaption; Receive_ByCaptionLbl)
            {
            }
            column(Phone_No_Caption; Phone_No_CaptionLbl)
            {
            }
            column(Page_Caption; Page_CaptionLbl)
            {
            }
            column(Vendor_IDCaption; Vendor_IDCaptionLbl)
            {
            }
            column(Payment_TermsCaption; Payment_TermsCaptionLbl)
            {
            }
            column(Ship_DateCaption; Ship_DateCaptionLbl)
            {
            }
            column(Delivery_DateCaption; Delivery_DateCaptionLbl)
            {
            }
            column(Total_PriceCaption; Total_PriceCaptionLbl)
            {
            }
            column(Unit_PriceCaption; Unit_PriceCaptionLbl)
            {
            }
            column(QuantityCaption; QuantityCaptionLbl)
            {
            }
            column(UnitCaption; UnitCaptionLbl)
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
            column(Item_No_Caption; Item_No_CaptionLbl)
            {
            }
            column(Purchase_Header_Document_Type; "Document Type")
            {
            }
            column(UserName_User; UserSetup."User ID")//User."User Name")  BC Upgrad 2025-06-23
            {
            }
            column(E_Signature_User; UserSetup."E-Signature")
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
            dataitem(DataItem1102622002; "Purch. Comment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.")
                                    WHERE("Document Type" = CONST(Order));//, "Print On Order" = CONST(Yes)); Remove in Upgrade 2025-06-23

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
                    //>>NIF 071105
                    //
                    cntPurchCommentLine.SETRANGE("Document Type", cntPurchCommentLine."Document Type"::Order);
                    cntPurchCommentLine.SETRANGE("No.", "Purchase Header"."No.");
                    IF cntPurchCommentLine.COUNT > 0 THEN BEGIN
                        TempPurchLine.INIT;
                        TempPurchLine."Document Type" := "Purchase Header"."Document Type";
                        TempPurchLine."Document No." := "Purchase Header"."No.";
                        TempPurchLine."Line No." := HighestLineNo + 1000;
                        HighestLineNo := TempPurchLine."Line No.";
                        TempPurchLine.Description := '';
                        TempPurchLine.INSERT;
                    END;
                    //<<NIF
                end;
            }
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
                        column(Transferred_to_page_____FORMAT_CurrReport_PAGENO___1_; 'Transferred to page ')// + FORMAT(CurrReport.PAGENO + 1))
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
                        column(Revision_No_Caption; Revision_No_CaptionLbl)
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
                        dataitem(PurchLineCommentLine; "Purch. Comment Line")
                        {
                            DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.");
                            //WHERE("Print On Order" = CONST(Yes));  Remove in Upgrade 2025-06-23
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

                            IF TempPurchLine.Quantity = 0 THEN
                                UnitPriceToPrint := 0  // so it won't print
                            ELSE
                                UnitPriceToPrint := ROUND(AmountExclInvDisc / TempPurchLine.Quantity, 0.00001);


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
            begin
                //>> IST 06-21-05
                IF PrintCompany THEN BEGIN
                    IF RespCenter.GET("Responsibility Center") THEN BEGIN
                        FormatAddress.RespCenter(CompanyAddress, RespCenter);
                        //>> IST 09-21-05
                        //CompanyInformation."Phone No." := RespCenter."Phone No.";
                        //CompanyInformation."Fax No." := RespCenter."Fax No.";
                        CompanyAddress[7] := RespCenter."Phone No.";
                        CompanyAddress[8] := RespCenter."Fax No.";
                        COMPRESSARRAY(CompanyAddress);
                        //<< IST 09-21-05
                    END;
                END;

                IF NOT ShippingAgent.GET("Shipping Agent Code") THEN
                    CLEAR(ShippingAgent)
                ELSE
                    ShippingAgent.GET("Shipping Agent Code");

                //<< IST 06-21-05
                //ShippingAgent.GET("Shipping Agent Code");

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

                FormatAddress.PurchHeaderBuyFrom(BuyFromAddress, "Purchase Header");
                //>> IST 09-21-05
                FormatAddress.PurchHeaderShipTo(ShipToAddress, "Purchase Header");
                IF (Vend.GET("Purchase Header"."Buy-from Vendor No.")) AND (BuyFromAddress[8] = '') THEN BEGIN
                    BuyFromAddress[8] := Vend."Fax No.";
                    COMPRESSARRAY(BuyFromAddress);
                END;
                //<< IST 09-21-05
            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.GET('');
                CompanyInformation.CALCFIELDS("Document Logo");
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
            LogInteraction := SegManagement.FindInteractionTemplateCode("Interaction Log Entry Document Type"::"Purch. Ord.") <> ''; //SegManagement.FindInteractTmplCode(13) <> ''; BC Upgrade 2025-06-23

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
        CompanyInformation.GET();
        //>> NF1.00:CIS.CM 08-28-15
        //User.SETRANGE("User Name", USERID);//BC Upgrad 2025-06-23
        UserSetup.SETRANGE("User ID", USERID);//BC Upgrad 2025-06-23
        IF UserSetup.FINDFIRST THEN
            UserSetup.CALCFIELDS("E-Signature");
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
        To_CaptionLbl: Label 'To:';
        Receive_ByCaptionLbl: Label 'Receive By';
        Vendor_IDCaptionLbl: Label 'Vendor ID';
        Confirm_ToCaptionLbl: Label 'Confirm To';
        BuyerCaptionLbl: Label 'Buyer';
        ShipCaptionLbl: Label 'Ship';
        To_Caption_Control1102622015Lbl: Label 'To:';
        PURCHASE_ORDERCaptionLbl: Label 'PURCHASE ORDER';
        Purchase_Order_Number_CaptionLbl: Label 'Purchase Order Number:';
        Purchase_Order_Date_CaptionLbl: Label 'Purchase Order Date:';
        Page_CaptionLbl: Label 'Page:';
        Ship_ViaCaptionLbl: Label 'Ship Via';
        TermsCaptionLbl: Label 'Terms';
        Phone_No_CaptionLbl: Label 'Phone No.';
        TaxIdentTypeCaptionLbl: Label 'Tax Ident. Type';
        Item_No_CaptionLbl: Label 'Item No.';
        UnitCaptionLbl: Label 'Unit';
        DescriptionCaptionLbl: Label 'Description';
        QuantityCaptionLbl: Label 'Quantity';
        Unit_PriceCaptionLbl: Label 'Unit Price';
        Total_PriceCaptionLbl: Label 'Total Price';
        Subtotal_CaptionLbl: Label 'Subtotal:';
        Invoice_Discount_CaptionLbl: Label 'Invoice Discount:';
        TotalCaptionLbl: Label 'Total:';
        ID: Code[50];
        TempPurchLine: Record "Purchase Line" temporary;
        HighestLineNo: Integer;
        SpacePointer: Integer;
        ShippingAgent: Record "Shipping Agent";
        TaxLiable: Decimal;
        TaxFlag: Boolean;
        NotReleased: Text[30];
        Shipment_MethodCaptionLbl: Label 'Shipment Method';
        Payment_TermsCaptionLbl: Label 'Payment Terms';
        Ship_DateCaptionLbl: Label 'Ship Date';
        Delivery_DateCaptionLbl: Label 'Delivery Date';
        PacksCaptionLbl: Label 'Packs';
        SNPCaptionLbl: Label 'SNP';
        Packs: Decimal;
        Revision_No_CaptionLbl: Label 'Revision No.';
        Sales_Tax_CaptionLbl: Label 'Sales Tax:';
        Total_CaptionLbl: Label 'Total:';
        Amount_Exempt_from_Sales_TaxCaptionLbl: Label 'Amount Exempt from Sales Tax';
        Amount_Subject_to_Sales_TaxCaptionLbl: Label 'Amount Subject to Sales Tax';
        Confirmed_By_CaptionLbl: Label 'Confirmed By:';
        Date_CaptionLbl: Label 'Date:';
        NIFAST_SignatureCaptionLbl: Label 'NIFAST Signature';
        UserSetup: Record "User Setup"; //User; BC Upgrade 2025-06-23
}

