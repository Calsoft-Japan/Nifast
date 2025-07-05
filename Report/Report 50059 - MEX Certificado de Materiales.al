report 50059 "MEX Certificado de Materiales"
{
    // NF1.00:CIS.NG  08-19-16 Upgrade Report to NAV 2015
    // 
    // >> NIF
    // Date     Init   Proj   Desc
    // 07-10-05 RTT           new field "Revision No."
    // 07-14-05 RTT           code at SalesInvLine-OAfterTGetRecord to zero out ordered qty
    // << NIF
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = '.\RDLC\MEX Certificado de Materiales.rdlc';


    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "Bill-to Customer No.", "Ship-to Code", "No. Printed";
            RequestFilterHeading = 'Sales Invoice';
            column(Sales_Invoice_Header_No_; "No.")
            {
            }
            column(CompanyInformation__Document_Logo_; CompanyInformation."Document Logo")
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    WHERE(Type = CONST(Item));

                trigger OnAfterGetRecord()
                begin
                    TempSalesInvoiceLine := "Sales Invoice Line";
                    TempSalesInvoiceLine.INSERT;
                    HighestLineNo := "Line No.";
                end;

                trigger OnPreDataItem()
                begin
                    TempSalesInvoiceLine.RESET;
                    TempSalesInvoiceLine.DELETEALL;
                end;
            }
            dataitem("Sales Comment Line"; "Sales Comment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.", "Line No.")
                                    WHERE("Document Type" = CONST("Posted Invoice"));//,"Print On Invoice"=CONST(Yes));BC Upgrade

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
                    TempSalesInvoiceLine.INSERT;
                end;
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
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
                    column(BillToAddress_1_; BillToAddress[1])
                    {
                    }
                    column(CompanyAddress_7_; CompanyAddress[7])
                    {
                    }
                    column(CompanyAddress_8_; CompanyAddress[8])
                    {
                    }
                    column(tDayText_________tMonText_________tYrText; tDayText + '/' + tMonText + '/' + tYrText)
                    {
                    }
                    column(Sales_Invoice_Header___Mex__Factura_No__; "Sales Invoice Header"."Mex. Factura No.")
                    {
                    }
                    column(Sales_Invoice_Header___External_Document_No__; "Sales Invoice Header"."External Document No.")
                    {
                    }
                    column(FACTURA_Caption; FACTURA_CaptionLbl)
                    {
                    }
                    column(CLIENTE_Caption; CLIENTE_CaptionLbl)
                    {
                    }
                    column(ORDEN_DE_COMPRA_Caption; ORDEN_DE_COMPRA_CaptionLbl)
                    {
                    }
                    column(CERTIFICADO_DE_MATERIALESCaption; CERTIFICADO_DE_MATERIALESCaptionLbl)
                    {
                    }
                    column(CERTIFICAMOS_QUE_EL_PRODUCTO_CONTENIDO_EN_ESTE_EMBARQUECaption; CERTIFICAMOS_QUE_EL_PRODUCTO_CONTENIDO_EN_ESTE_EMBARQUECaptionLbl)
                    {
                    }
                    column(CUMPLE_CON_LOS_ESPECIFICACIONES_SOLICITADAS_POR_EL_CLIENTECaption; CUMPLE_CON_LOS_ESPECIFICACIONES_SOLICITADAS_POR_EL_CLIENTECaptionLbl)
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    dataitem(SalesInvLine; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(DocumentNo_TempSalesInvoiceLine; TempSalesInvoiceLine."Document No.")
                        {
                        }
                        column(TempSalesInvoiceLine_Description; TempSalesInvoiceLine.Description)
                        {
                        }
                        column(TempSalesInvoiceLine_Quantity; TempSalesInvoiceLine.Quantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(TempSalesInvoiceLine__No__; TempSalesInvoiceLine."No.")
                        {
                        }
                        column(TempSalesInvoiceLine__Cross_Reference_No__; TempSalesInvoiceLine."Item Reference No.")//Cross- BC Upgrade
                        {
                        }
                        column(mItem__Material_Finish_; mItem."Material Finish")
                        {
                            //DecimalPlaces = 0 : 5;
                        }
                        column(TempSalesInvoiceLine__Shipment_No__; TempSalesInvoiceLine."Shipment No.")
                        {
                        }
                        column(mItem__Material_Type_; mItem."Material Type")
                        {
                            //DecimalPlaces = 0 : 5;
                        }
                        column(NUMERO_DE_PARTE_NIFAST_Caption; NUMERO_DE_PARTE_NIFAST_CaptionLbl)
                        {
                        }
                        column(DESCRIPCION_Caption; DESCRIPCION_CaptionLbl)
                        {
                        }
                        column(CANTIDAD_Caption; CANTIDAD_CaptionLbl)
                        {
                        }
                        column(NUMERO_DE_PARTE_CLIENTE_Caption; NUMERO_DE_PARTE_CLIENTE_CaptionLbl)
                        {
                        }
                        column(ESPECIFICACIONES_DE_TERMINADO_Caption; ESPECIFICACIONES_DE_TERMINADO_CaptionLbl)
                        {
                        }
                        column(REMISION_NO__Caption; REMISION_NO__CaptionLbl)
                        {
                        }
                        column(ESPECIFICACIONES_DE_MATERIALES_UTILIZADOS_Caption; ESPECIFICACIONES_DE_MATERIALES_UTILIZADOS_CaptionLbl)
                        {
                        }
                        column(SalesInvLine_Number; Number)
                        {
                        }
                        dataitem("Item Entry Relation"; "Item Entry Relation")
                        {
                            DataItemTableView = SORTING("Source ID", "Source Type", "Source Subtype", "Source Ref. No.", "Source Prod. Order Line", "Source Batch Name")
                                                WHERE("Source Type" = CONST(111));
                            column(LOTE_______Lot_No__; 'LOTE: ' + "Lot No.")
                            {
                                //DecimalPlaces = 0 : 5;
                            }
                            column(FIRMA_Caption; FIRMA_CaptionLbl)
                            {
                            }
                            column(CARGO_Caption; CARGO_CaptionLbl)
                            {
                            }
                            column(FECHE_Caption; FECHE_CaptionLbl)
                            {
                            }
                            column(Item_Entry_Relation_Item_Entry_No_; "Item Entry No.")
                            {
                            }

                            trigger OnPreDataItem()
                            begin
                                //>>NIF 042006 RTT
                                SETRANGE("Source ID", TempSalesInvoiceLine."Shipment No.");
                                SETRANGE("Source Ref. No.", TempSalesInvoiceLine."Shipment Line No.");
                                //<<NIF 042006 RTT
                            end;
                        }
                        /* BU Upgrade skip this data item for the table can not be access, do not even know the column information in NAV
                        dataitem("Sales Line Comment Line"; "Sales Comment Line")//14017610 "Sales Line Comment Line" BC Upgrade
                        {
                            DataItemTableView = SORTING("Document Type", "No.", "Doc. Line No.", "Line No.")
                                                WHERE("Document Type" = CONST("Posted Invoice"));//,"Print On Invoice" = CONST(Yes)); BC Upgrade

                            trigger OnPreDataItem()
                            begin
                                SETRANGE("No.", TempSalesInvoiceLine."Document No.");
                                SETRANGE("Doc. Line No.", TempSalesInvoiceLine."Line No.");
                            end;
                        } */

                        trigger OnAfterGetRecord()
                        begin
                            OnLineNumber := OnLineNumber + 1;

                            //>>NIF 04/20/06 RTT
                            LineCounter := LineCounter + 1;
                            LineCounterText := FORMAT(LineCounter);
                            IF STRLEN(LineCounterText) = 1 THEN
                                LineCounterText := '0' + LineCounterText;
                            //<<NIF 04/20/06 RTT

                            IF OnLineNumber = 1 THEN
                                TempSalesInvoiceLine.FIND('-')
                            ELSE
                                TempSalesInvoiceLine.NEXT;

                            OrderedQuantity := 0;
                            IF "Sales Invoice Header"."Order No." = '' THEN
                                OrderedQuantity := TempSalesInvoiceLine.Quantity
                            ELSE BEGIN
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
                            END;

                            DescriptionToPrint := TempSalesInvoiceLine.Description + ' ' + TempSalesInvoiceLine."Description 2";
                            IF TempSalesInvoiceLine.Type = TempSalesInvoiceLine.Type::" " THEN BEGIN
                                IF OnLineNumber < NumberOfLines THEN BEGIN
                                    NEXT;
                                    IF TempSalesInvoiceLine.Type = TempSalesInvoiceLine.Type::" " THEN BEGIN
                                        DescriptionToPrint :=
                                          COPYSTR(DescriptionToPrint + ' ' + TempSalesInvoiceLine.Description + ' ' + TempSalesInvoiceLine."Description 2", 1, MAXSTRLEN(DescriptionToPrint));
                                        OnLineNumber := OnLineNumber + 1;
                                        SalesInvLine.NEXT;
                                    END ELSE
                                        NEXT(-1);
                                END;
                                TempSalesInvoiceLine."No." := '';
                                TempSalesInvoiceLine."Unit of Measure" := '';
                                TempSalesInvoiceLine.Amount := 0;
                                TempSalesInvoiceLine."Amount Including VAT" := 0;
                                TempSalesInvoiceLine."Inv. Discount Amount" := 0;
                                TempSalesInvoiceLine.Quantity := 0;
                                //>> NIF 07-14-05 RTT
                                OrderedQuantity := 0;
                                //<< NIF 07-14-05 RTT
                            END ELSE IF TempSalesInvoiceLine.Type = TempSalesInvoiceLine.Type::"G/L Account" THEN
                                    TempSalesInvoiceLine."No." := '';

                            IF TempSalesInvoiceLine."No." = '' THEN BEGIN
                                HighDescriptionToPrint := DescriptionToPrint;
                                LowDescriptionToPrint := '';
                            END ELSE BEGIN
                                HighDescriptionToPrint := '';
                                LowDescriptionToPrint := DescriptionToPrint;
                            END;

                            IF TempSalesInvoiceLine.Amount <> TempSalesInvoiceLine."Amount Including VAT" THEN BEGIN
                                TaxFlag := TRUE;
                                TaxLiable := TempSalesInvoiceLine.Amount;
                            END ELSE BEGIN
                                TaxFlag := FALSE;
                                TaxLiable := 0;
                            END;

                            AmountExclInvDisc := TempSalesInvoiceLine.Amount + TempSalesInvoiceLine."Inv. Discount Amount";

                            //>> NIF 07-14-05 RTT
                            RevisionText := '';
                            IF TempSalesInvoiceLine."Revision No." <> '' THEN
                                RevisionText := 'Revision No.: ' + TempSalesInvoiceLine."Revision No.";
                            //<< NIF 07-14-05 RTT

                            IF TempSalesInvoiceLine.Quantity = 0 THEN
                                UnitPriceToPrint := 0  // so it won't print
                            ELSE
                                UnitPriceToPrint := ROUND(AmountExclInvDisc / TempSalesInvoiceLine.Quantity, 0.00001);

                            //>>NIF MAK 050806
                            IF TempSalesInvoiceLine.Type = TempSalesInvoiceLine.Type::Item THEN
                                mItem.GET(TempSalesInvoiceLine."No.");
                            //<<NIF MAK 050806


                        end;

                        trigger OnPreDataItem()
                        begin
                            //CurrReport.CREATETOTALS(TaxLiable, AmountExclInvDisc, TempSalesInvoiceLine.Amount, TempSalesInvoiceLine."Amount Including VAT");BC Upgrade
                            NumberOfLines := TempSalesInvoiceLine.COUNT;
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
                            SalesInvPrinted.RUN("Sales Invoice Header");
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
                    NoLoops := 1 + ABS(NoCopies);    //// + Customer."Invoice Copies";
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
                /* Language_T.Reset();//BC Upgrade 2025-06-23
                Language_T.Get("Language Code");//BC Upgrade 2025-06-23
                CurrReport.LANGUAGE := Language_T."Windows Language ID";//BC Upgrade 2025-06-23
                //Language.GetLanguageID("Language Code"); BC Upgrade 2025-06-23 */

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

                FormatAddress.SalesInvBillTo(BillToAddress, "Sales Invoice Header");
                FormatAddress.SalesInvShipTo(ShipToAddress, BillToAddress, "Sales Invoice Header");//BC Upgrade

                IF "Payment Terms Code" = '' THEN
                    CLEAR(PaymentTerms)
                ELSE
                    PaymentTerms.GET("Payment Terms Code");

                IF "Shipment Method Code" = '' THEN
                    CLEAR(ShipmentMethod)
                ELSE
                    ShipmentMethod.GET("Shipment Method Code");

                Customer.GET("Bill-to Customer No.");

                //IF LogInteraction THEN
                //  IF NOT CurrReport.PREVIEW THEN BEGIN
                //    IF "Bill-to Contact No." <> '' THEN
                //      SegManagement.LogDocument(
                //        4,"No.",0,0,DATABASE::Contact,"Bill-to Contact No.",
                //        "Salesperson Code","Campaign No.","Posting Description")
                //    ELSE
                //      SegManagement.LogDocument(
                //        4,"No.",0,0,DATABASE::Customer,"Bill-to Customer No.",
                //        "Salesperson Code","Campaign No.","Posting Description");
                //  END;


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
                    SalesTaxCalc.AddSalesInvoiceLines("No.");
                    SalesTaxCalc.EndSalesTaxCalculation("Posting Date");
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

                    IF BrkIdx = 1 THEN BEGIN
                        CLEAR(BreakdownLabel);
                        CLEAR(BreakdownAmt);
                    END;
                END;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.GET;
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
                        ApplicationArea = All;
                        Caption = 'Number of Copies';
                    }
                    field(PrintCompany; PrintCompany)
                    {
                        ApplicationArea = All;
                        Caption = 'Print Company Address';
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = All;
                        Caption = 'Log Interaction';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        ReportCaption = 'CERTIFICADO DE MATERIALES';
        Header_1_Caption = 'CERTIFICAMOS QUE EL PRODUCTO CONTENIDO EN ESTE EMBARQUE';
        Header_2_Caption = 'CUMPLE CON LOS ESPECIFICACIONES SOLICITADAS POR EL CLIENTE';
        FacturaCaption = 'FACTURA:';
        ClienteCaption = 'CLIENTE:';
        OrdenDeCompraCaption = 'ORDEN DE COMPRA:';
        RemisionNoCaption = 'REMISION NO.:';
        NumeroNiFastCaption = 'NUMERO DE PARTE NIFAST:';
        NumeroClienteCaption = 'NUMERO DE PARTE CLIENTE:';
        DescriptionCaption = 'DESCRIPCION:';
        CantidadCaption = 'CANTIDAD:';
        EspecTerminadoCaption = 'ESPECIFICACIONES DE TERMINADO:';
        EspecMaterialesUtilizadosCaption = 'ESPECIFICACIONES DE MATERIALES UTILIZADOS:';
        FirmaCaption = 'FIRMA:';
        CargoCaption = 'CARGO:';
        FecheCaption = 'FECHE:';
    }

    trigger OnInitReport()
    begin
        PrintCompany := TRUE;
    end;

    trigger OnPreReport()
    begin
        ShipmentLine.SETCURRENTKEY("Order No.", "Order Line No.");
        //IF NOT CurrReport.USEREQUESTFORM THEN
        //  InitLogInteraction;
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
        TempSalesInvoiceLine: Record "Sales Invoice Line" temporary;
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
        SalesInvPrinted: Codeunit "Sales Inv.-Printed";
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
        mItem: Record Item;
        FACTURA_CaptionLbl: Label 'FACTURA:';
        CLIENTE_CaptionLbl: Label 'CLIENTE:';
        ORDEN_DE_COMPRA_CaptionLbl: Label 'ORDEN DE COMPRA:';
        CERTIFICADO_DE_MATERIALESCaptionLbl: Label 'CERTIFICADO DE MATERIALES';
        CERTIFICAMOS_QUE_EL_PRODUCTO_CONTENIDO_EN_ESTE_EMBARQUECaptionLbl: Label 'CERTIFICAMOS QUE EL PRODUCTO CONTENIDO EN ESTE EMBARQUE';
        CUMPLE_CON_LOS_ESPECIFICACIONES_SOLICITADAS_POR_EL_CLIENTECaptionLbl: Label 'CUMPLE CON LOS ESPECIFICACIONES SOLICITADAS POR EL CLIENTE';
        NUMERO_DE_PARTE_NIFAST_CaptionLbl: Label 'NUMERO DE PARTE NIFAST:';
        DESCRIPCION_CaptionLbl: Label 'DESCRIPCION:';
        CANTIDAD_CaptionLbl: Label 'CANTIDAD:';
        NUMERO_DE_PARTE_CLIENTE_CaptionLbl: Label 'NUMERO DE PARTE CLIENTE:';
        ESPECIFICACIONES_DE_TERMINADO_CaptionLbl: Label 'ESPECIFICACIONES DE TERMINADO:';
        REMISION_NO__CaptionLbl: Label 'REMISION NO.:';
        ESPECIFICACIONES_DE_MATERIALES_UTILIZADOS_CaptionLbl: Label 'ESPECIFICACIONES DE MATERIALES UTILIZADOS:';
        FIRMA_CaptionLbl: Label 'FIRMA:';
        CARGO_CaptionLbl: Label 'CARGO:';
        FECHE_CaptionLbl: Label 'FECHE:';

    procedure InitLogInteraction()
    begin
        //LogInteraction := SegManagement.FindInteractTmplCode(4) <> '';
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

        SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
        SalesInvLine.SETRANGE(Type, SalesInvLine.Type::Item);
        SalesInvLine.SETFILTER(Quantity, '<>%1', 0);
        IF SalesInvLine.FIND('-') THEN
            REPEAT
                RowText := ItemTrackingMgt.ComposeRowID(DATABASE::"Sales Invoice Line", 0,
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

