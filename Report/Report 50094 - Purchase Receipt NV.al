report 50094 "Purchase Receipt NV"
{
    // NF1.00:CIS.NG  07-18-16 Upgrade Report to NAV 2016
    // SM.001 10/20/16 Changed Margin to 1cm on the left side
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = '.\RDLC\Purchase Receipt NV.rdlc';

    Caption = 'Purchase Receipt NV';

    dataset
    {
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Buy-from Vendor No.", "Pay-to Vendor No.", "No. Printed";
            RequestFilterHeading = 'Purchase Receipt';
            column(No_PurchRcptHeader; "No.")
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(CompanyAddr1; CompanyAddress[1])
                    {
                    }
                    column(CompanyAddr2; CompanyAddress[2])
                    {
                    }
                    column(CompanyAddr3; CompanyAddress[3])
                    {
                    }
                    column(CompanyAddr4; CompanyAddress[4])
                    {
                    }
                    column(CompanyAddr5; CompanyAddress[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddress[6])
                    {
                    }
                    column(DocLogo_CompanyInformation; CompanyInformation."Document Logo")
                    {
                    }
                    column(CopyTxt; CopyTxt)
                    {
                    }
                    column(BuyFromAddr1; BuyFromAddress[1])
                    {
                    }
                    column(BuyFromAddr2; BuyFromAddress[2])
                    {
                    }
                    column(BuyFromAddr3; BuyFromAddress[3])
                    {
                    }
                    column(BuyFromAddr4; BuyFromAddress[4])
                    {
                    }
                    column(BuyFromAddr5; BuyFromAddress[5])
                    {
                    }
                    column(BuyFromAddr6; BuyFromAddress[6])
                    {
                    }
                    column(BuyFromAddr7; BuyFromAddress[7])
                    {
                    }
                    column(ExpRcptDate_PurchRcptHeader; "Purch. Rcpt. Header"."Expected Receipt Date")
                    {
                    }
                    column(ShipToAddr1; ShipToAddress[1])
                    {
                    }
                    column(ShipToAddr2; ShipToAddress[2])
                    {
                    }
                    column(ShipToAddr3; ShipToAddress[3])
                    {
                    }
                    column(ShipToAddr4; ShipToAddress[4])
                    {
                    }
                    column(ShipToAddr5; ShipToAddress[5])
                    {
                    }
                    column(ShipToAddr6; ShipToAddress[6])
                    {
                    }
                    column(ShipToAddr7; ShipToAddress[7])
                    {
                    }
                    column(BuyfrmVendNo_PurchRcptHeader; "Purch. Rcpt. Header"."Buy-from Vendor No.")
                    {
                    }
                    column(YourRef_PurchRcptHeader; "Purch. Rcpt. Header"."Your Reference")
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(No1_PurchRcptHeader; "Purch. Rcpt. Header"."No.")
                    {
                    }
                    column(DocDate_PurchRcptHeader; "Purch. Rcpt. Header"."Document Date")
                    {
                    }
                    column(PostingDate_PurchRcptHeader; "Purch. Rcpt. Header"."Posting Date")
                    {
                    }
                    column(CompanyAddr7; CompanyAddress[7])
                    {
                    }
                    column(CompanyAddr8; CompanyAddress[8])
                    {
                    }
                    column(BuyFromAddr8; BuyFromAddress[8])
                    {
                    }
                    column(ShipToAddr8; ShipToAddress[8])
                    {
                    }
                    column(ShipmentMethodDesc; ShipmentMethod.Description)
                    {
                    }
                    column(OrderNo_PurchRcptHeader; "Purch. Rcpt. Header"."Order No.")
                    {
                    }
                    column(OrderDate_PurchRcptHeader; "Purch. Rcpt. Header"."Order Date")
                    {
                    }
                    column(myCopyNo; CopyNo)
                    {
                    }
                    column(FromCaption; FromCaptionLbl)
                    {
                    }
                    column(ReceiveByCaption; ReceiveByCaptionLbl)
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
                    column(ToCaption; ToCaptionLbl)
                    {
                    }
                    column(PurchaseReceiptCaption; PurchaseReceiptCaptionLbl)
                    {
                    }
                    column(PurchaseReceiptNumberCaption; PurchaseReceiptNumberCaptionLbl)
                    {
                    }
                    column(PurchaseReceiptDateCaption; PurchaseReceiptDateCaptionLbl)
                    {
                    }
                    column(PageCaption; PageCaptionLbl)
                    {
                    }
                    column(ShipViaCaption; ShipViaCaptionLbl)
                    {
                    }
                    column(PONumberCaption; PONumberCaptionLbl)
                    {
                    }
                    column(PurchaseCaption; PurchaseCaptionLbl)
                    {
                    }
                    column(PODateCaption; PODateCaptionLbl)
                    {
                    }
                    dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purch. Rcpt. Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(ItemNumberToPrint_PurchRcptLine; ItemNumberToPrint)
                        {
                        }
                        column(DocumentNo_PurchRcptLine; "Document No.")
                        {
                        }
                        column(UnitofMeasure_PurchRcptLine; "Unit of Measure")
                        {
                        }
                        column(Qty_PurchRcptLine; Quantity)
                        {
                        }
                        column(OrderedQty_PurchRcptLine; OrderedQuantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(BackOrderedQty_PurchRcptLine; BackOrderedQuantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(Desc_1_2_PurchRcptLine; Description + ' ' + "Description 2")
                        {
                        }
                        column(PrintFooter_PurchRcptLine; PrintFooter)
                        {
                        }
                        column(LineNo_PurchRcptLine; "Line No.")
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
                        column(ReceivedCaption; ReceivedCaptionLbl)
                        {
                        }
                        column(OrderedCaption; OrderedCaptionLbl)
                        {
                        }
                        column(BackOrderedCaption; BackOrderedCaptionLbl)
                        {
                        }
                        dataitem("Purch. Comment Line"; "Purch. Comment Line")
                        {
                            DataItemLink = "No." = FIELD("Document No."),
                                           "Document Line No." = FIELD("Line No.");
                            DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.")
                                                WHERE("Document Type" = CONST(Receipt));//,"Print On Receipt"=CONST(Yes)); BC Upgrade
                            column(Date_PurchCommentLine; Date)
                            {
                            }
                            column(Comment_PurchCommentLine; Comment)
                            {
                            }
                            column(DocumentType_PurchCommentLine; "Document Type")
                            {
                            }
                            column(No_PurchCommentLine; "No.")
                            {
                            }
                            column(LineNo_PurchCommentLine; "Line No.")
                            {
                            }
                            column(DocumentLineNo_PurchCommentLine; "Document Line No.")
                            {
                            }
                        }

                        trigger OnAfterGetRecord()
                        begin
                            OnLineNumber := OnLineNumber + 1;

                            OrderedQuantity := 0;
                            BackOrderedQuantity := 0;
                            IF "Order No." = '' THEN
                                OrderedQuantity := Quantity
                            ELSE
                                //IF OrderLine.GET(1,"Order No.","Order Line No.") THEN BEGIN  //>>NIF-O
                                IF OrderLine.GET(1, "Order No.", "Line No.") THEN BEGIN          //>>NIF-N
                                    OrderedQuantity := OrderLine.Quantity;
                                    BackOrderedQuantity := OrderLine."Outstanding Quantity";
                                END ELSE BEGIN
                                    ReceiptLine.SETCURRENTKEY("Order No.", "Order Line No.");
                                    ReceiptLine.SETRANGE("Order No.", "Order No.");
                                    //ReceiptLine.SETRANGE("Order Line No.","Order Line No.");   //>>NIF-O
                                    ReceiptLine.SETRANGE("Order Line No.", "Line No.");           //>>NIF-N
                                                                                                  //>> 09-21-05 RTT fix Navision bug
                                                                                                  //ReceiptLine.FIND('-');
                                    IF NOT ReceiptLine.FIND('-') THEN
                                        OrderedQuantity := 0
                                    ELSE
                                        //<< 09-21-05 RTT
                                        REPEAT
                                            OrderedQuantity := OrderedQuantity + ReceiptLine.Quantity;
                                        UNTIL 0 = ReceiptLine.NEXT;
                                END;

                            IF Type = Type::" " THEN BEGIN
                                ItemNumberToPrint := '';
                                "Unit of Measure" := '';
                                OrderedQuantity := 0;
                                BackOrderedQuantity := 0;
                                Quantity := 0;
                            END ELSE
                                IF Type = Type::"G/L Account" THEN
                                    ItemNumberToPrint := "Vendor Item No."
                                ELSE
                                    ItemNumberToPrint := "No.";

                            IF OnLineNumber = NumberOfLines THEN
                                PrintFooter := TRUE;
                        end;

                        trigger OnPreDataItem()
                        begin
                            NumberOfLines := COUNT;
                            OnLineNumber := 0;
                            PrintFooter := FALSE;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    //CurrReport.PAGENO := 1;BC Upgrade

                    IF CopyNo = NoLoops THEN BEGIN
                        IF NOT CurrReport.PREVIEW THEN
                            PurchaseRcptPrinted.RUN("Purch. Rcpt. Header");
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

                /* Language_t.Reset();//BC Upgrade 2025-06-23
                Language_t.Get("Language Code");//BC Upgrade 2025-06-23
                CurrReport.LANGUAGE := Language_t."Windows Language ID";//BC Upgrade 2025-06-23
                //Language.GetLanguageID("Language Code"); BC Upgrade 2025-06-23 */


                IF "Purchaser Code" = '' THEN
                    CLEAR(SalesPurchPerson)
                ELSE
                    SalesPurchPerson.GET("Purchaser Code");

                IF "Shipment Method Code" = '' THEN
                    CLEAR(ShipmentMethod)
                ELSE
                    ShipmentMethod.GET("Shipment Method Code");

                IF "Buy-from Vendor No." = '' THEN BEGIN
                    "Buy-from Vendor Name" := Text009;
                    "Ship-to Name" := Text009;
                END;

                FormatAddress.PurchRcptBuyFrom(BuyFromAddress, "Purch. Rcpt. Header");
                FormatAddress.PurchRcptShipTo(ShipToAddress, "Purch. Rcpt. Header");

                IF LogInteraction THEN
                    IF NOT CurrReport.PREVIEW THEN
                        SegManagement.LogDocument(
                          15, "No.", 0, 0, DATABASE::Vendor, "Buy-from Vendor No.", "Purchaser Code", '', "Posting Description", '');
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
            LogInteraction := SegManagement.FindInteractionTemplateCode("Interaction Log Entry Document Type"::"Purch. Rcpt.") <> ''; //FindInteractTmplCode(15) <> ''; BC Upgrade
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
        CompanyInformation.GET('');
        CompanyInformation.CALCFIELDS("Document Logo");  //>>NIF
    end;

    var
        ShipmentMethod: Record "Shipment Method";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInformation: Record "Company Information";
        ReceiptLine: Record "Purch. Rcpt. Line";
        OrderLine: Record "Purchase Line";
        RespCenter: Record "Responsibility Center";
        Language_t: Record Language;
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
        PurchaseRcptPrinted: Codeunit "Purch.Rcpt.-Printed";
        FormatAddress: Codeunit "Format Address";
        OrderedQuantity: Decimal;
        BackOrderedQuantity: Decimal;
        Text000: Label 'COPY';
        Text009: Label 'VOID RECEIPT';
        FromCaptionLbl: Label 'From:';
        ReceiveByCaptionLbl: Label 'Receive By';
        VendorIDCaptionLbl: Label 'Vendor ID';
        ConfirmToCaptionLbl: Label 'Confirm To';
        BuyerCaptionLbl: Label 'Buyer';
        ShipCaptionLbl: Label 'Ship';
        ToCaptionLbl: Label 'To:';
        PurchaseReceiptCaptionLbl: Label 'PURCHASE RECEIPT';
        PurchaseReceiptNumberCaptionLbl: Label 'Purchase Receipt Number:';
        PurchaseReceiptDateCaptionLbl: Label 'Purchase Receipt Date:';
        PageCaptionLbl: Label 'Page:';
        ShipViaCaptionLbl: Label 'Ship Via';
        PONumberCaptionLbl: Label 'P.O. Number';
        PurchaseCaptionLbl: Label 'Purchase';
        PODateCaptionLbl: Label 'P.O. Date';
        ItemNoCaptionLbl: Label 'Item No.';
        UnitCaptionLbl: Label 'Unit';
        DescriptionCaptionLbl: Label 'Description';
        ReceivedCaptionLbl: Label 'Received';
        OrderedCaptionLbl: Label 'Ordered';
        BackOrderedCaptionLbl: Label 'Back Ordered';
        SegManagement: Codeunit SegManagement;
        LogInteraction: Boolean;
        //[InDataSet]BC Upgrade
        LogInteractionEnable: Boolean;
}

