report 50044 "MEX Sales Shipment"
{
    // NF1.00:CIS.NU 09-04-15 Merged during upgrade
    // NF1.00:CIS.CM    09/29/15 Update for New Vision Removal Task
    // >> NIF
    // 07-19-05  RTT  addded Cross-Reference No.
    // << NIF
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = '.\RDLC\MEX Sales Shipment.rdlc';

    Caption = 'MEX Sales Shipment';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Sell-to Customer No.", "Bill-to Customer No.", "Ship-to Code", "No. Printed";
            RequestFilterHeading = 'Sales Shipment';
            column(No_SalesShptHeader; "No.")
            {
            }
            dataitem("Sales Shipment Line"; "Sales Shipment Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");

                trigger OnAfterGetRecord()
                begin
                    TempSalesShipmentLine := "Sales Shipment Line";
                    TempSalesShipmentLine.INSERT;
                    TempSalesShipmentLineAsm := "Sales Shipment Line";
                    TempSalesShipmentLineAsm.INSERT;
                    HighestLineNo := "Line No.";
                end;

                trigger OnPreDataItem()
                begin
                    TempSalesShipmentLine.RESET;
                    TempSalesShipmentLine.DELETEALL;
                    TempSalesShipmentLineAsm.RESET;
                    TempSalesShipmentLineAsm.DELETEALL;
                end;
            }
            /* BC Upgrade No need show any comment line in report===================
            dataitem(SalesLineComments; "Sales Comment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.", "Line No.")
                                    WHERE("Document Type" = CONST(Shipment));//,"Print On Shipment"=CONST(Yes)); BC Upgrade

                trigger OnAfterGetRecord()
                begin
                    TempSalesShipmentLine.INIT;
                    TempSalesShipmentLine."Document No." := "Sales Shipment Header"."No.";
                    TempSalesShipmentLine."Line No." := HighestLineNo + 10;
                    HighestLineNo := TempSalesShipmentLine."Line No.";

                    IF STRLEN(Comment) <= MAXSTRLEN(TempSalesShipmentLine.Description) THEN BEGIN
                        TempSalesShipmentLine.Description := Comment;
                        TempSalesShipmentLine."Description 2" := '';
                    END ELSE BEGIN
                        SpacePointer := MAXSTRLEN(TempSalesShipmentLine.Description) + 1;
                        WHILE (SpacePointer > 1) AND (Comment[SpacePointer] <> ' ') DO
                            SpacePointer := SpacePointer - 1;
                        IF SpacePointer = 1 THEN
                            SpacePointer := MAXSTRLEN(TempSalesShipmentLine.Description) + 1;
                        TempSalesShipmentLine.Description := COPYSTR(Comment, 1, SpacePointer - 1);
                        TempSalesShipmentLine."Description 2" :=
                          COPYSTR(COPYSTR(Comment, SpacePointer + 1), 1, MAXSTRLEN(TempSalesShipmentLine."Description 2"));
                    END;
                    TempSalesShipmentLine.INSERT;
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
                    column(CompanyInfoPicture; CompanyInformation.Picture)
                    {
                    }
                    column(DocumentLogo_CompanyInformation; CompanyInformation.Picture)//"Document Logo")
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
                    column(BilltoCustNo_SalesShptHeader; "Sales Shipment Header"."Bill-to Customer No.")
                    {
                    }
                    column(YourRef_SalesShptHeader; "Sales Shipment Header"."Your Reference")
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(ShptDate_SalesShptHeader; FORMAT("Sales Shipment Header"."Shipment Date"))
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
                    column(OrderDate_SalesShptHeader; FORMAT("Sales Shipment Header"."Order Date"))
                    {
                    }
                    column(OrderNo_SalesShptHeader; "Sales Shipment Header"."Order No.")
                    {
                    }
                    column(PackageTrackingNoText; PackageTrackingNoText)
                    {
                    }
                    column(ShippingAgentCodeText; ShippingAgentCodeText)
                    {
                    }
                    column(ShippingAgentCodeLabel; ShippingAgentCodeLabel)
                    {
                    }
                    column(PackageTrackingNoLabel; PackageTrackingNoLabel)
                    {
                    }
                    column(TaxRegNo; TaxRegNo)
                    {
                    }
                    column(TaxRegLabel; TaxRegLabel)
                    {
                    }
                    column(CopyNo; CopyNo)
                    {
                    }
                    column(PageLoopNumber; Number)
                    {
                    }
                    column(BillCaption; BillCaptionLbl)
                    {
                    }
                    column(ToCaption; ToCaptionLbl)
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
                    column(ShipmentCaption; ShipmentCaptionLbl)
                    {
                    }
                    column(ShipmentNumberCaption; ShipmentNumberCaptionLbl)
                    {
                    }
                    column(ShipmentDateCaption; ShipmentDateCaptionLbl)
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
                    column(OurOrderNoCaption; OurOrderNoCaptionLbl)
                    {
                    }
                    column(PostingDate_SalesShipmentHeader; FORMAT("Sales Shipment Header"."Posting Date"))
                    {
                    }
                    column(PostingDateCap; PostingDateCap)
                    {
                    }
                    column(RequestedDeliveryDate_SalesShipmentHeader; FORMAT("Sales Shipment Header"."Requested Delivery Date"))
                    {
                    }
                    column(ShipToCode_SalesShipmentHeader; "Sales Shipment Header"."Ship-to Code")
                    {
                    }
                    column(R_E_M_I_S_I_O_NCap; R_E_M_I_S_I_O_NCaptionLbl)
                    {
                    }
                    dataitem(SalesShptLine; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(SalesShptLineNumber; Number)
                        {
                        }
                        column(TempSalesShptLineNo; TempSalesShipmentLine."No.")
                        {
                        }
                        column(TempSalesShptLineUOM; TempSalesShipmentLine."Unit of Measure")
                        {
                        }
                        column(TempSalesShptLineQy; TempSalesShipmentLine.Quantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(TempSalesShptLineDesc; TempSalesShipmentLine.Description + ' ' + TempSalesShipmentLine."Description 2")
                        {
                        }
                        column(CrossRefNo_TempSalesShptLine; TempSalesShipmentLine."Item Reference No.")//Cross- BC Upgrade
                        {
                        }
                        column(AsmHeaderExists; AsmHeaderExists)
                        {
                        }
                        column(PrintFooter; PrintFooter)
                        {
                        }
                        column(LineCounterText; LineCounterText)
                        {
                        }
                        column(TotalQuantity; TotalQuantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(NumCartonsText; NumCartonsText)
                        {
                        }
                        column(TotalNumCartonsText; TotalNumCartonsText)
                        {
                            //DecimalPlaces = 0 : 5;
                        }
                        column(PARTIDA; PARTIDAcaptionLbl)
                        {
                        }
                        column(DescriptionCaption; DescriptionCaptionLbl)
                        {
                        }
                        column(CANTIDAD; CANTIDADCaptionLbl)
                        {
                        }
                        column(UNIDAD; UNIDADCaptionLbl)
                        {
                        }
                        column(TOTALBOXES; TOTAL_BOXESCaptionLbl)
                        {
                        }
                        column(Prepared_ByCaption; Prepared_ByCaptionLbl)
                        {
                        }
                        column(Authorized_ByCaption; Authorized_ByCaptionLbl)
                        {
                        }
                        column(TOTAL_; 'TOTAL')
                        {
                            // DecimalPlaces = 0 : 5;
                        }
                        dataitem("Item Entry Relation"; "Item Entry Relation")
                        {
                            DataItemTableView = SORTING("Source ID", "Source Type", "Source Subtype", "Source Ref. No.", "Source Prod. Order Line", "Source Batch Name")
                                                WHERE("Source Type" = CONST(111));
                            column(LOT_NO_______Lot_No__; 'LOT NO. ' + "Lot No.")
                            {
                                //DecimalPlaces = 0 : 5;
                            }
                            column(UseCrossRef; UseCrossRef)
                            {
                            }
                            column(Item_Entry_Relation_Item_Entry_No_; "Item Entry No.")
                            {
                            }
                            column(Text50000; Text50000)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                i := i + 1;

                                IF i = 1 THEN
                                    UseCrossRef := TempSalesShipmentLine."Item Reference No."//Cross- BC Upgrade
                                ELSE
                                    UseCrossRef := '';
                            end;

                            trigger OnPreDataItem()
                            begin
                                //>>NIF 042006 RTT
                                SETRANGE("Source ID", "Sales Shipment Header"."No.");
                                SETRANGE("Source Ref. No.", TempSalesShipmentLine."Line No.");
                                //<<NIF 042006 RTT

                                CLEAR(i);
                            end;
                        }
                        dataitem("Sales Comment Line"; "Sales Comment Line")
                        {
                            DataItemTableView = SORTING("Document Type", "No.", "Line No.", Date)
                                                WHERE("Document Type" = CONST(Shipment));//,"Print On Shipment"=CONST(Yes)); Remove by BC Upgrade
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
                            column(Text50001; Text50001)
                            {
                            }

                            trigger OnPreDataItem()
                            begin
                                SETRANGE("No.", TempSalesShipmentLine."Document No.");
                                //SETRANGE("Doc. Line No.",TempSalesShipmentLine."Line No.");  //NF1.00:CIS.CM 09-29-15-O
                                SETRANGE("Document Line No.", TempSalesShipmentLine."Line No.");  //NF1.00:CIS.CM 09-29-15-N

                                SETRANGE("Document Line No.", -11); //BC Upgrade Skip all the comment lines to avoid show up in report
                            end;
                        }
                        dataitem(AsmLoop; Integer)
                        {
                            DataItemTableView = SORTING(Number);
                            column(PostedAsmLineItemNo; BlanksForIndent + PostedAsmLine."No.")
                            {
                            }
                            column(PostedAsmLineDescription; BlanksForIndent + PostedAsmLine.Description)
                            {
                            }
                            column(PostedAsmLineQuantity; PostedAsmLine.Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(PostedAsmLineUOMCode; GetUnitOfMeasureDescr(PostedAsmLine."Unit of Measure Code"))
                            {
                                //DecimalPlaces = 0 : 5;
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN
                                    PostedAsmLine.FINDSET
                                ELSE
                                    PostedAsmLine.NEXT;
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT DisplayAssemblyInformation THEN
                                    CurrReport.BREAK;
                                IF NOT AsmHeaderExists THEN
                                    CurrReport.BREAK;
                                PostedAsmLine.SETRANGE("Document No.", PostedAsmHeader."No.");
                                SETRANGE(Number, 1, PostedAsmLine.COUNT);
                            end;
                        }

                        trigger OnAfterGetRecord()
                        var
                            SalesShipmentLine: Record "Sales Shipment Line";
                        begin
                            OnLineNumber := OnLineNumber + 1;

                            IF OnLineNumber = 1 THEN
                                TempSalesShipmentLine.FIND('-')
                            ELSE
                                TempSalesShipmentLine.NEXT;

                            //>>NIF 042006 RTT
                            LineCounter := LineCounter + 1;
                            LineCounterText := FORMAT(LineCounter);
                            IF STRLEN(LineCounterText) = 1 THEN
                                LineCounterText := '0' + LineCounterText;

                            CLEAR(NumCartonsText);
                            IF Item.GET(TempSalesShipmentLine."No.") THEN
                                IF Item."Units per Parcel" <> 0 THEN BEGIN
                                    NumCartons := TempSalesShipmentLine.Quantity / Item."Units per Parcel";
                                    NumCartonsText := FORMAT(ROUND(NumCartons)) + ' CTNS';
                                END;

                            TotalQuantity := TotalQuantity + TempSalesShipmentLine.Quantity;
                            IF TempSalesShipmentLine.Quantity <> 0 THEN  // NF1.00:CIS.NU 09-04-15
                                TotalNumCartons := TotalNumCartons + NumCartons;
                            /*
                              OrderedQuantity := 0;
                              BackOrderedQuantity := 0;
                              IF "Order No." = '' THEN
                                OrderedQuantity := Quantity
                              ELSE BEGIN
                                IF OrderLine.GET(1,"Order No.","Order Line No.") THEN BEGIN
                                  OrderedQuantity := OrderLine.Quantity;
                                  BackOrderedQuantity := OrderLine."Outstanding Quantity";
                                END ELSE BEGIN
                                  ReceiptLine.SETCURRENTKEY("Order No.","Order Line No.");
                                  ReceiptLine.SETRANGE("Order No.","Order No.");
                                  ReceiptLine.SETRANGE("Order Line No.","Order Line No.");
                                  ReceiptLine.FIND('-');
                                  REPEAT
                                    OrderedQuantity := OrderedQuantity + ReceiptLine.Quantity;
                                  UNTIL 0 = ReceiptLine.NEXT;
                                END;
                              END;
                            */
                            IF (TempSalesShipmentLine.Type = TempSalesShipmentLine.Type::Item) AND (TempSalesShipmentLine."Item Reference No." = '') THEN//Cross- BC Upgrade
                                TempSalesShipmentLine."Item Reference No." := FindCrossRef(TempSalesShipmentLine."No.", TempSalesShipmentLine."Sell-to Customer No.");//Cross- BC Upgrade
                            //<<NIF 042006 RTT

                            IF TempSalesShipmentLine.Type = TempSalesShipmentLine.Type::" " THEN BEGIN
                                OrderedQuantity := 0;
                                BackOrderedQuantity := 0;
                                TempSalesShipmentLine."No." := '';
                                TempSalesShipmentLine."Unit of Measure" := '';
                                TempSalesShipmentLine.Quantity := 0;
                            END ELSE IF TempSalesShipmentLine.Type = TempSalesShipmentLine.Type::"G/L Account" THEN
                                    TempSalesShipmentLine."No." := '';

                            PackageTrackingText := '';
                            IF (TempSalesShipmentLine."Package Tracking No." <> "Sales Shipment Header"."Package Tracking No.") AND
                               (TempSalesShipmentLine."Package Tracking No." <> '') AND (PrintPackageTrackingNos) THEN
                                PackageTrackingText := Text002 + ' ' + TempSalesShipmentLine."Package Tracking No.";

                            IF DisplayAssemblyInformation THEN
                                IF TempSalesShipmentLineAsm.GET(TempSalesShipmentLine."Document No.", TempSalesShipmentLine."Line No.") THEN BEGIN
                                    SalesShipmentLine.GET(TempSalesShipmentLine."Document No.", TempSalesShipmentLine."Line No.");
                                    AsmHeaderExists := SalesShipmentLine.AsmToShipmentExists(PostedAsmHeader);
                                END;

                            IF OnLineNumber = NumberOfLines THEN
                                PrintFooter := TRUE;

                            //>> NF1.00:CIS.NU 09-04-15
                            TotalNumCartonsText := FORMAT(ROUND(TotalNumCartons)) + ' CTNS';
                            //<< NF1.00:CIS.NU 09-04-15

                        end;

                        trigger OnPreDataItem()
                        begin
                            NumberOfLines := TempSalesShipmentLine.COUNT;
                            SETRANGE(Number, 1, NumberOfLines);
                            OnLineNumber := 0;
                            PrintFooter := FALSE;

                            //>>NIF 042006 RTT
                            CLEAR(LineCounter);
                            CLEAR(TotalNumCartons);
                            CLEAR(TotalQuantity);
                            //<<NIF 042006 RTT
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    //CurrReport.PAGENO := 1;BC Upgrade
                    IF CopyNo = NoLoops THEN BEGIN
                        IF NOT CurrReport.PREVIEW THEN
                            SalesShipmentPrinted.RUN("Sales Shipment Header");
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
                    NoLoops := 1 + ABS(NoCopies);
                    IF NoLoops <= 0 THEN
                        NoLoops := 1;
                    CopyNo := 0;
                end;
            }

            trigger OnAfterGetRecord()
            var
                tempSalesShpHdr: Record "Sales Shipment Header" temporary;
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

                IF "Salesperson Code" = '' THEN
                    CLEAR(SalesPurchPerson)
                ELSE
                    SalesPurchPerson.GET("Salesperson Code");

                IF "Inside Salesperson Code" = '' THEN
                    CLEAR(SalesPurchPerson2)
                ELSE
                    SalesPurchPerson2.GET("Inside Salesperson Code");

                //>> RTT 09-20-05
                IF NOT FreightCode.GET("Freight Code") THEN
                    CLEAR(FreightCode);
                //<< RTT 09-20-05

                IF "Shipment Method Code" = '' THEN
                    CLEAR(ShipmentMethod)
                ELSE
                    ShipmentMethod.GET("Shipment Method Code");

                IF "Sell-to Customer No." = '' THEN BEGIN
                    "Bill-to Name" := Text009;
                    "Ship-to Name" := Text009;
                END;
                IF NOT Cust.GET("Sell-to Customer No.") THEN
                    CLEAR(Cust);

                tempSalesShpHdr := "Sales Shipment Header";
                tempSalesShpHdr."Bill-to Contact" := '';
                tempSalesShpHdr."Ship-to Contact" := '';
                FormatAddress.SalesShptBillTo(BillToAddress, ShipToAddress, tempSalesShpHdr);//"Sales Shipment Header");//BC Upgarde
                FormatAddress.SalesShptShipTo(ShipToAddress, tempSalesShpHdr);//"Sales Shipment Header");

                ShippingAgentCodeLabel := '';
                ShippingAgentCodeText := '';
                PackageTrackingNoLabel := '';
                PackageTrackingNoText := '';
                IF PrintPackageTrackingNos THEN BEGIN
                    ShippingAgentCodeLabel := Text003;
                    ShippingAgentCodeText := "Sales Shipment Header"."Shipping Agent Code";
                    PackageTrackingNoLabel := Text001;
                    PackageTrackingNoText := "Sales Shipment Header"."Package Tracking No.";
                END;
                IF LogInteraction THEN
                    IF NOT CurrReport.PREVIEW THEN
                        SegManagement.LogDocument(
                          5, "No.", 0, 0, DATABASE::Customer, "Sell-to Customer No.",
                          "Salesperson Code", "Campaign No.", "Posting Description", '');
                TaxRegNo := '';
                TaxRegLabel := '';
                IF "Tax Area Code" <> '' THEN BEGIN
                    TaxArea.GET("Tax Area Code");
                    CASE TaxArea."Country/Region" OF
                        TaxArea."Country/Region"::US:
                            ;
                        TaxArea."Country/Region"::CA:
                            BEGIN
                                TaxRegNo := CompanyInformation."VAT Registration No.";
                                TaxRegLabel := CompanyInformation.FIELDCAPTION("VAT Registration No.");
                            END;
                    END;
                END;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.GET;
                CompanyInformation.CALCFIELDS("Document Logo");
                CompanyInformation.CALCFIELDS(Picture);
                IF PrintCompany THEN BEGIN
                    //FormatAddress.Company(CompanyAddress,CompanyInformation);

                    //FormatAddress.NifastMexCompanySlsDocs(CompanyAddress, CompanyInformation);//BC Upgrade
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
                        ApplicationArea = All;
                        Caption = 'Number of Copies';
                    }
                    field(PrintCompanyAddress; PrintCompany)
                    {
                        ApplicationArea = All;
                        Caption = 'Print Company Address';
                    }
                    field(PrintPackageTrackingNos; PrintPackageTrackingNos)
                    {
                        ApplicationArea = All;
                        Caption = 'Print Package Tracking Nos.';
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
    }

    trigger OnInitReport()
    begin
        PrintCompany := TRUE;
        CompanyInfo.GET;
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
    end;

    trigger OnPreReport()
    begin
        IF NOT CurrReport.USEREQUESTPAGE THEN
            InitLogInteraction;

        CompanyInformation.GET;
        SalesSetup.GET;

        CASE SalesSetup."Logo Position on Documents" OF
            SalesSetup."Logo Position on Documents"::"No Logo":
                ;
            SalesSetup."Logo Position on Documents"::Left:
                CompanyInformation.CALCFIELDS(Picture);
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
        OrderedQuantity: Decimal;
        BackOrderedQuantity: Decimal;
        ShipmentMethod: Record "Shipment Method";
        ReceiptLine: Record "Sales Shipment Line";
        OrderLine: Record "Sales Line";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInformation: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        CompanyInfo: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        TempSalesShipmentLine: Record "Sales Shipment Line" temporary;
        TempSalesShipmentLineAsm: Record "Sales Shipment Line" temporary;
        RespCenter: Record "Responsibility Center";
        Language_T: Record Language;
        TaxArea: Record "Tax Area";
        Cust: Record Customer;
        PostedAsmHeader: Record "Posted Assembly Header";
        PostedAsmLine: Record "Posted Assembly Line";
        CompanyAddress: array[8] of Text[50];
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
        SalesShipmentPrinted: Codeunit "Sales Shpt.-Printed";
        FormatAddress: Codeunit "Format Address";
        PackageTrackingText: Text[50];
        PrintPackageTrackingNos: Boolean;
        PackageTrackingNoText: Text[50];
        PackageTrackingNoLabel: Text[50];
        ShippingAgentCodeText: Text[50];
        ShippingAgentCodeLabel: Text[50];
        SegManagement: Codeunit SegManagement;
        LogInteraction: Boolean;
        Text000: Label 'COPY';
        Text001: Label 'Tracking No.';
        Text002: Label 'Specific Tracking No.';
        Text003: Label 'Shipping Agent';
        TaxRegNo: Text[30];
        TaxRegLabel: Text[30];
        Text009: Label 'VOID SHIPMENT';
        //[InDataSet]BC Upgrade
        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        AsmHeaderExists: Boolean;
        BillCaptionLbl: Label 'Bill';
        ToCaptionLbl: Label 'To:';
        CustomerIDCaptionLbl: Label 'Customer ID';
        PONumberCaptionLbl: Label 'P.O. Number';
        SalesPersonCaptionLbl: Label 'SalesPerson';
        ShipCaptionLbl: Label 'Ship';
        ShipmentCaptionLbl: Label 'SHIPMENT';
        ShipmentNumberCaptionLbl: Label 'Shipment Number:';
        R_E_M_I_S_I_O_NCaptionLbl: Label 'R E M I S I O N';
        ShipmentDateCaptionLbl: Label 'Shipment Date:';
        PageCaptionLbl: Label 'Page:';
        ShipViaCaptionLbl: Label 'Ship Via';
        PODateCaptionLbl: Label 'P.O. Date';
        OurOrderNoCaptionLbl: Label 'Our Order No.';
        PARTIDAcaptionLbl: Label 'PARTIDA';
        CANTIDADCaptionLbl: Label 'CANTIDAD';
        DescriptionCaptionLbl: Label 'DESCRIPTION';
        UNIDADCaptionLbl: Label 'UNIDAD';
        TOTAL_BOXESCaptionLbl: Label 'TOTAL BOXES';
        BackOrderedCaptionLbl: Label 'Back Ordered';
        PostingDateCap: Label 'Posting Date';
        SalesPurchPerson2: Record "Salesperson/Purchaser";
        ">>NIF": Integer;
        FreightCode: Record "Freight Code";
        NumCartons: Decimal;
        NumCartonsText: Text[30];
        LineCounter: Integer;
        LineCounterText: Text[30];
        Item: Record Item;
        TotalNumCartons: Decimal;
        TotalNumCartonsText: Text[30];
        TotalQuantity: Decimal;
        UseCrossRef: Code[20];
        i: Integer;
        TaxFlag: Boolean;
        Prepared_ByCaptionLbl: Label 'Prepared By';
        Authorized_ByCaptionLbl: Label 'Authorized By';
        Text50000: Label 'Text Constant For Filter';
        Text50001: Label 'Text Constant For Filter2';

    procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractionTemplateCode("Interaction Log Entry Document Type"::"Sales Shpt. Note") <> '';//FindInteractTmplCode(5) <> ''; BC Upgrade
    end;

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

    procedure FindCrossRef(ItemNo: Code[20]; CustNo: Code[20]): Text[30]
    var
        ItemCrossReference: Record "Item Reference";
    begin
        ItemCrossReference.RESET;
        ItemCrossReference.SETRANGE("Item No.", ItemNo);
        ItemCrossReference.SETRANGE("Reference Type", ItemCrossReference."Reference Type"::Customer); //Cross- BC Upgrade
        ItemCrossReference.SETRANGE("Reference Type No.", CustNo);//BC Upgrade
        IF NOT ItemCrossReference.FIND('-') THEN
            CLEAR(ItemCrossReference);

        EXIT(ItemCrossReference."Reference No.");//BC Upgrade
    end;

}

