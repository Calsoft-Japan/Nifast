report 50048 "MEX Virtual Invoice"
{
    // NF1.00:CIS.SP  09-04-15 Merged during upgrade
    // >>NF1
    // Export To Excel as per requirement
    // <<NF1
    // 
    // SM 8/8/16
    // 1. Changed the caption of the Legend.
    // 2. Changed the caption on Global C/L (the Legend)
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = '.\RDLC\MEX Virtual Invoice.rdlc';

    Caption = 'MEX Virtual Invoice';

    dataset
    {
        dataitem(Customer; Customer)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Date Filter";
            column(Customer_No_; "No.")
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyAddress_2___________CompanyAddress_3_; CompanyAddress[2] + '   ' + CompanyAddress[3])
            {
            }
            column(CompanyAddress_4___________CompanyAddress_8_; CompanyAddress[4] + '   ' + CompanyAddress[8])
            {
            }
            column(CompanyAddress_6___________CompanyAddress_7_; CompanyAddress[6] + '   ' + CompanyAddress[7])
            {
            }
            column(PeriodText; PeriodText)
            {
            }
            column(InvoiceDateArray_1_; FORMAT(InvoiceDateArray[1]))
            {
            }
            column(InvoiceDateArray_2_; FORMAT(InvoiceDateArray[2]))
            {
            }
            column(InvoiceDateArray_3_; FORMAT(InvoiceDateArray[3]))
            {
            }
            column(InvoiceDateArray_5_; FORMAT(InvoiceDateArray[5]))
            {
            }
            column(InvoiceDateArray_4_; FORMAT(InvoiceDateArray[4]))
            {
            }
            column(InvoiceNoArray_1_; InvoiceNoArray[1])
            {
            }
            column(InvoiceNoArray_2_; InvoiceNoArray[2])
            {
            }
            column(InvoiceNoArray_3_; InvoiceNoArray[3])
            {
            }
            column(InvoiceNoArray_4_; InvoiceNoArray[4])
            {
            }
            column(InvoiceNoArray_5_; InvoiceNoArray[5])
            {
            }
            column(CompanyInfo__Maquila_Registration_No__; CompanyInfo."Maquila Registration No.")
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
            column(NiMexCustomer__Pitex_Maquila_No__; NiMexCustomer."Pitex/Maquila No.")
            {
            }
            column(InvoiceDateArray_7_; FORMAT(InvoiceDateArray[7]))
            {
            }
            column(InvoiceNoArray_7_; InvoiceNoArray[7])
            {
            }
            column(InvoiceDateArray_6_; FORMAT(InvoiceDateArray[6]))
            {
            }
            column(InvoiceNoArray_6_; InvoiceNoArray[6])
            {
            }
            column(Customer__Export_Pediment_No__; Customer."Export Pediment No.")
            {
            }
            column(InvoiceDateArray_8_; FORMAT(InvoiceDateArray[8]))
            {
            }
            column(InvoiceNoArray_8_; InvoiceNoArray[8])
            {
            }
            column(InvoiceDateArray_9_; FORMAT(InvoiceDateArray[9]))
            {
            }
            column(InvoiceNoArray_9_; InvoiceNoArray[9])
            {
            }
            column(InvoiceDateArray_10_; FORMAT(InvoiceDateArray[10]))
            {
            }
            column(InvoiceNoArray_10_; InvoiceNoArray[10])
            {
            }
            column(InvoiceDateArray_11_; FORMAT(InvoiceDateArray[11]))
            {
            }
            column(InvoiceNoArray_11_; InvoiceNoArray[11])
            {
            }
            column(InvoiceDateArray_12_; FORMAT(InvoiceDateArray[12]))
            {
            }
            column(InvoiceNoArray_12_; InvoiceNoArray[12])
            {
            }
            column(InvoiceDateArray_13_; FORMAT(InvoiceDateArray[13]))
            {
            }
            column(InvoiceNoArray_13_; InvoiceNoArray[13])
            {
            }
            column(InvoiceDateArray_14_; FORMAT(InvoiceDateArray[14]))
            {
            }
            column(InvoiceNoArray_14_; InvoiceNoArray[14])
            {
            }
            column(InvoiceDateArray_15_; FORMAT(InvoiceDateArray[15]))
            {
            }
            column(InvoiceNoArray_15_; InvoiceNoArray[15])
            {
            }
            column(InvoiceDateArray_16_; FORMAT(InvoiceDateArray[16]))
            {
            }
            column(InvoiceNoArray_16_; InvoiceNoArray[16])
            {
            }
            column(InvoiceDateArray_17_; FORMAT(InvoiceDateArray[17]))
            {
            }
            column(InvoiceNoArray_17_; InvoiceNoArray[17])
            {
            }
            column(InvoiceDateArray_18_; FORMAT(InvoiceDateArray[18]))
            {
            }
            column(InvoiceNoArray_18_; InvoiceNoArray[18])
            {
            }
            column(InvoiceDateArray_19_; FORMAT(InvoiceDateArray[19]))
            {
            }
            column(InvoiceNoArray_19_; InvoiceNoArray[19])
            {
            }
            column(InvoiceDateArray_20_; FORMAT(InvoiceDateArray[20]))
            {
            }
            column(InvoiceNoArray_20_; InvoiceNoArray[20])
            {
            }
            column(InvoiceDateArray_21_; FORMAT(InvoiceDateArray[21]))
            {
            }
            column(InvoiceNoArray_21_; InvoiceNoArray[21])
            {
            }
            column(InvoiceDateArray_22_; FORMAT(InvoiceDateArray[22]))
            {
            }
            column(InvoiceNoArray_22_; InvoiceNoArray[22])
            {
            }
            column(InvoiceDateArray_23_; FORMAT(InvoiceDateArray[23]))
            {
            }
            column(InvoiceNoArray_23_; InvoiceNoArray[23])
            {
            }
            column(InvoiceDateArray_24_; FORMAT(InvoiceDateArray[24]))
            {
            }
            column(InvoiceNoArray_24_; InvoiceNoArray[24])
            {
            }
            column(InvoiceDateArray_25_; FORMAT(InvoiceDateArray[25]))
            {
            }
            column(InvoiceNoArray_25_; InvoiceNoArray[25])
            {
            }
            column(TotalLineAmt; TotalLineAmt)
            {
            }
            column(TotalTax; TotalTax)
            {
            }
            column(TotalAmtInclTax; TotalAmtInclTax)
            {
            }
            column(Customer__Port_of_Discharge_; Customer."Port of Discharge")
            {
            }
            column(CompanyInfo__Port_of_Loading_; CompanyInfo."Port of Loading")
            {
            }
            column(CUSTOMER_____Customer__No__; 'CUSTOMER ' + Customer."No.")
            {
            }
            column(InvoiceVisible8; InvoiceVisible8)
            {
            }
            column(InvoiceVisible9; InvoiceVisible9)
            {
            }
            column(InvoiceVisible10; InvoiceVisible10)
            {
            }
            column(InvoiceVisible11; InvoiceVisible11)
            {
            }
            column(InvoiceVisible12; InvoiceVisible12)
            {
            }
            column(InvoiceVisible13; InvoiceVisible13)
            {
            }
            column(InvoiceVisible14; InvoiceVisible14)
            {
            }
            column(InvoiceVisible15; InvoiceVisible15)
            {
            }
            column(InvoiceVisible16; InvoiceVisible16)
            {
            }
            column(InvoiceVisible17; InvoiceVisible17)
            {
            }
            column(InvoiceVisible18; InvoiceVisible18)
            {
            }
            column(InvoiceVisible19; InvoiceVisible19)
            {
            }
            column(InvoiceVisible20; InvoiceVisible20)
            {
            }
            column(InvoiceVisible21; InvoiceVisible21)
            {
            }
            column(InvoiceVisible22; InvoiceVisible22)
            {
            }
            column(InvoiceVisible23; InvoiceVisible23)
            {
            }
            column(InvoiceVisible24; InvoiceVisible24)
            {
            }
            column(InvoiceVisible25; InvoiceVisible25)
            {
            }
            dataitem("Commercial Invoice MEX"; "Commercial Invoice MEX")
            {
                DataItemTableView = SORTING("Virtural Operation No.", "Country of Origin", "Custom Agent License No.", "Customer Agent E/S", "Date of Entry", "Summary Entry No.", "Summary Entry Code");
                column(Commercial_Invoice_MEX__Virtural_Operation_No__; "Virtural Operation No.")
                {
                }
                column(HSTariffCode_Description; HSTariffCode.Description)
                {
                }
                column(Commercial_Invoice_MEX__Country_of_Origin_; "Country of Origin")
                {
                }
                column(Commercial_Invoice_MEX__Item_No__; "Item No.")
                {
                }
                column(Commercial_Invoice_MEX__Custom_Agent_License_No__; "Custom Agent License No.")
                {
                }
                column(Commercial_Invoice_MEX__Customer_Agent_E_S_; "Customer Agent E/S")
                {
                }
                column(Commercial_Invoice_MEX__Summary_Entry_Code_; "Summary Entry Code")
                {
                }
                column(Commercial_Invoice_MEX__Date_of_Entry_; FORMAT("Date of Entry"))
                {
                }
                column(Commercial_Invoice_MEX_Quantity; Quantity)
                {
                    DecimalPlaces = 0 : 2;
                }
                column(Commercial_Invoice_MEX_Weight; Weight)
                {
                }
                column(Commercial_Invoice_MEX__Line_Amount_; "Line Amount")
                {
                }
                column(Commercial_Invoice_MEX__Summary_Entry_No__; "Summary Entry No.")
                {
                }
                column(CalcUnitPrice; CalcUnitPrice)
                {
                    DecimalPlaces = 0 : 5;
                }
                column(Country_of_Origin______SUBTOTAL_; "Country of Origin" + ' SUBTOTAL')
                {
                }
                column(Virtural_Operation_No_______TOTAL_; "Virtural Operation No." + ' TOTAL')
                {
                }
                column(Commercial_Invoice_MEX_Entry_No_; "Entry No.")
                {
                }
                column(Text001_gCtx; Text001)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //>>NIF MAK 060506
                    CLEAR(NiMexCustomer);
                    NiMexCustomer.GET("Customer No.");
                    //<<NIF MAK 060506

                    IF NOT HSTariffCode.GET("Commercial Invoice MEX"."Virtural Operation No.") THEN
                        CLEAR(HSTariffCode);

                    IF "Commercial Invoice MEX".Quantity <> 0 THEN
                        CalcUnitPrice := ROUND("Commercial Invoice MEX"."Line Amount" / "Commercial Invoice MEX".Quantity, 0.00001)
                    ELSE
                        CalcUnitPrice := 0;

                    //>> NF1.00:CIS.SP 09-04-15
                    IF (ExportToExcel) AND (IsCustomerHavingInnerDetails) THEN BEGIN
                        IF Counter > 1 THEN BEGIN
                            IF PrevCountryOfOrigin <> "Country of Origin" THEN
                                MakeExcelDataFooterCommercialInvoiceMEXCountryOfOrigin;
                            IF PrevVirtualOperationNo <> "Virtural Operation No." THEN
                                MakeExcelDataFooterCommercialInvoiceMEXVirtualOperationNo;
                        END;

                        IF Counter = 1 THEN BEGIN
                            MakeExcelDataHeaderCommercialInvoiceMEXVirtualOperationNo;
                            MakeExcelDataHeaderCommercialInvoiceMEXCountryOfOrigin;
                        END ELSE BEGIN
                            IF PrevVirtualOperationNo <> "Virtural Operation No." THEN
                                MakeExcelDataHeaderCommercialInvoiceMEXVirtualOperationNo;
                            IF PrevCountryOfOrigin <> "Country of Origin" THEN
                                MakeExcelDataHeaderCommercialInvoiceMEXCountryOfOrigin;
                        END;

                        MakeExcelDataBody;

                        TotalQuantityCountryOfOrigin += Quantity;
                        TotalWeightCountryOfOrigin += Weight;
                        TotalLineAmountCountryOfOrigin += "Line Amount";

                        Counter += 1;
                        PrevVirtualOperationNo := "Commercial Invoice MEX"."Virtural Operation No.";
                        PrevCountryOfOrigin := "Commercial Invoice MEX"."Country of Origin";
                    END;
                    //<< NF1.00:CIS.SP 09-04-15
                end;

                trigger OnPostDataItem()
                begin
                    //>> NF1.00:CIS.SP 09-04-15
                    IF (ExportToExcel) AND (IsCustomerHavingInnerDetails) THEN BEGIN
                        IF Counter = 1 THEN BEGIN
                            MakeExcelDataHeaderCommercialInvoiceMEXVirtualOperationNo;
                            MakeExcelDataHeaderCommercialInvoiceMEXCountryOfOrigin;
                            MakeExcelDataFooterCommercialInvoiceMEXCountryOfOrigin;
                            MakeExcelDataFooterCommercialInvoiceMEXVirtualOperationNo;
                        END ELSE BEGIN
                            IF (NOT IsVirtualOperationNoHeader) THEN
                                MakeExcelDataHeaderCommercialInvoiceMEXVirtualOperationNo;

                            IF (NOT IsCountryOfOriginHeader) THEN
                                MakeExcelDataHeaderCommercialInvoiceMEXCountryOfOrigin;

                            IF (NOT IsCountryOfOriginFooter) THEN
                                MakeExcelDataFooterCommercialInvoiceMEXCountryOfOrigin;

                            IF (NOT IsVirtualOperationNoFooter) THEN
                                MakeExcelDataFooterCommercialInvoiceMEXVirtualOperationNo;
                        END;

                        MakeExcelDataFooter;
                    END;
                    //<< NF1.00:CIS.SP 09-04-15
                end;

                trigger OnPreDataItem()
                begin
                    LastFieldNo := FIELDNO("Summary Entry Code");
                    SETRANGE("Customer No.", Customer."No.");
                end;
            }
            dataitem("Mex Export Pediment"; "Mex Export Pediment")
            {
                DataItemLink = "Customer No." = FIELD("No.");
                DataItemTableView = SORTING("Pedimento Entry No.", "Pedimento Virtual No.");
                RequestFilterFields = "Start Date";
                column(Mex_Export_Pediment__Pedimento_Virtual_No__; "Pedimento Virtual No.")
                {
                }
                column(Mex_Export_Pediment_Pedimento_Entry_No_; "Pedimento Entry No.")
                {
                }
                column(Mex_Export_Pediment_Customer_No_; "Customer No.")
                {
                }
                column(Text002_gCtx; Text002)
                {
                }
                column(Show; Show)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //>> NF1.00:CIS.SP 09-04-15
                    IF (ExportToExcel) AND (IsCustomerHavingInnerDetails) THEN
                        MakeExcelDataBodyMexExportPediment;
                    //<< NF1.00:CIS.SP 09-04-15
                end;
            }

            trigger OnAfterGetRecord()
            var
                CommercialInvoiceMEX: Record "Commercial Invoice MEX";
                MexExportPediment: Record "Mex Export Pediment";
            begin
                CLEAR(InvoiceNoArray);
                CLEAR(InvoiceDateArray);
                TempSalesHdr.DELETEALL;
                CLEAR(i);

                //CurrReport.PAGENO := 1;BC Upgrade
                "Commercial Invoice MEX".GetInfo(Customer."No.", Customer.GETFILTER("Date Filter"), TRUE, TempSalesHdr);
                "Commercial Invoice MEX".CALCSUMS("Line Amount", "Tax Amount", "Amount Incl Tax");
                TotalLineAmt := "Commercial Invoice MEX"."Line Amount";
                TotalTax := "Commercial Invoice MEX"."Tax Amount";
                TotalAmtInclTax := "Commercial Invoice MEX"."Amount Incl Tax";



                IF TempSalesHdr.FIND('-') THEN
                    REPEAT
                        i := i + 1;
                        InvoiceNoArray[i] := TempSalesHdr."Mex. Factura No.";
                        InvoiceDateArray[i] := TempSalesHdr."Posting Date";
                    UNTIL TempSalesHdr.NEXT = 0;


                FormatAddr.Customer(BillToAddress, Customer);
                IF Customer."Pitex/Maquila No." <> '' THEN BEGIN
                    BillToAddress[8] := 'PITEX/' + Customer."Pitex/Maquila No.";
                    COMPRESSARRAY(BillToAddress);
                END;

                //<< NF1.00:CIS.SP 09-04-15
                ClearInvoiceVisibleVariables;
                IF (InvoiceNoArray[8] <> '') OR (InvoiceDateArray[8] <> 0D) THEN
                    InvoiceVisible8 := TRUE;

                IF (InvoiceNoArray[9] <> '') OR (InvoiceDateArray[9] <> 0D) THEN
                    InvoiceVisible9 := TRUE;

                IF (InvoiceNoArray[10] <> '') OR (InvoiceDateArray[10] <> 0D) THEN
                    InvoiceVisible10 := TRUE;

                IF (InvoiceNoArray[11] <> '') OR (InvoiceDateArray[11] <> 0D) THEN
                    InvoiceVisible11 := TRUE;

                IF (InvoiceNoArray[12] <> '') OR (InvoiceDateArray[12] <> 0D) THEN
                    InvoiceVisible12 := TRUE;

                IF (InvoiceNoArray[13] <> '') OR (InvoiceDateArray[13] <> 0D) THEN
                    InvoiceVisible13 := TRUE;

                IF (InvoiceNoArray[14] <> '') OR (InvoiceDateArray[14] <> 0D) THEN
                    InvoiceVisible14 := TRUE;

                IF (InvoiceNoArray[15] <> '') OR (InvoiceDateArray[15] <> 0D) THEN
                    InvoiceVisible15 := TRUE;

                IF (InvoiceNoArray[16] <> '') OR (InvoiceDateArray[16] <> 0D) THEN
                    InvoiceVisible16 := TRUE;

                IF (InvoiceNoArray[17] <> '') OR (InvoiceDateArray[17] <> 0D) THEN
                    InvoiceVisible17 := TRUE;

                IF (InvoiceNoArray[18] <> '') OR (InvoiceDateArray[18] <> 0D) THEN
                    InvoiceVisible18 := TRUE;

                IF (InvoiceNoArray[19] <> '') OR (InvoiceDateArray[19] <> 0D) THEN
                    InvoiceVisible19 := TRUE;

                IF (InvoiceNoArray[20] <> '') OR (InvoiceDateArray[20] <> 0D) THEN
                    InvoiceVisible20 := TRUE;

                IF (InvoiceNoArray[21] <> '') OR (InvoiceDateArray[21] <> 0D) THEN
                    InvoiceVisible21 := TRUE;

                IF (InvoiceNoArray[22] <> '') OR (InvoiceDateArray[22] <> 0D) THEN
                    InvoiceVisible22 := TRUE;

                IF (InvoiceNoArray[23] <> '') OR (InvoiceDateArray[23] <> 0D) THEN
                    InvoiceVisible23 := TRUE;

                IF (InvoiceNoArray[24] <> '') OR (InvoiceDateArray[24] <> 0D) THEN
                    InvoiceVisible24 := TRUE;

                IF (InvoiceNoArray[25] <> '') OR (InvoiceDateArray[25] <> 0D) THEN
                    InvoiceVisible25 := TRUE;

                IF ExportToExcel THEN BEGIN
                    CommercialInvoiceMEX.RESET;
                    CommercialInvoiceMEX.SETRANGE("Customer No.", Customer."No.");

                    MexExportPediment.RESET;
                    MexExportPediment.SETRANGE("Customer No.", Customer."No.");

                    IsCustomerHavingInnerDetails := FALSE;
                    IF (CommercialInvoiceMEX.FINDSET) OR (MexExportPediment.FINDSET) THEN BEGIN
                        MakeExcelDataHeader;
                        CustomerCounter += 1;
                        Counter := 1;
                        PrevVirtualOperationNo := '';
                        PrevCountryOfOrigin := '';
                        IsVirtualOperationNoHeader := FALSE;
                        IsCountryOfOriginHeader := FALSE;
                        IsVirtualOperationNoFooter := FALSE;
                        IsCountryOfOriginFooter := FALSE;
                        IsCustomerHavingInnerDetails := TRUE;
                    END;
                END;
                //<< NF1.00:CIS.SP 09-04-15
            end;

            trigger OnPreDataItem()
            begin
                "Commercial Invoice MEX".LOCKTABLE;
                "Commercial Invoice MEX".DELETEALL;


                CompanyInformation.GET('');
                //FormatAddr.NifastMexCompanySlsDocs(CompanyAddress, CompanyInformation);//BC Upgrade
                FormatAddr.Company(CompanyAddress, CompanyInformation);//BC Upgrade

                //>> NF1.00:CIS.SP 09-04-15
                IF ExportToExcel THEN BEGIN
                    MakeExcelInfo;
                    CustomerCounter := 1;
                    IsCustomerHavingInnerDetails := FALSE;
                END;
                //<< NF1.00:CIS.SP 09-04-15
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
                    field("Export To Excel"; ExportToExcel)
                    {
                        ApplicationArea = All;
                        Caption = 'Export To Excel';
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
        TotalFor = 'Total for';
        CurrReport_PAGENOCaption = 'Page';
        INVOICE__OPERACION_VIRTUAL_Caption = 'INVOICE (OPERACION VIRTUAL)';
        PeriodTextCaption = 'PERIOD';
        InvoiceDateCaption = 'InvoiceDate';
        InvoiceNoArray_1_Caption = 'Invoice No.';
        REGISTRO_MAQUILACaption = 'REGISTRO MAQUILA';
        Sold___Ship_to_Caption = 'Sold & Ship to:';
        PITEX_MAQUILACaption = 'PITEX/MAQUILA';
        Pedimento_Virtual__Caption = 'Pedimento Virtual #';
        OPERACION_REALIZADA__DE_CONFORMIDAD_CON_LO_ESTABLECIDO_ENCaption = 'OPERACION REALIZADA  DE CONFORMIDAD CON LO ESTABLECIDO EN';
        TOTALCaption = 'TOTAL';
        IVACaption = 'IVA';
        G__TOTALCaption = 'G. TOTAL';
        Puerto_de_Desembarque__port_of_discharge_Caption = 'Puerto de Desembarque (port of discharge)';
        MATERIAS_PRIMAS__PARTES__COMPONENTES_Y_EMPAQUES_Caption = 'MATERIAS PRIMAS, PARTES, COMPONENTES Y EMPAQUES';
        Puerto_de_Embarque__port_of_loading__Caption = 'Puerto de Embarque (port of loading):';
        LAS___REGLAS__1_6_16__5_2_3_FRACCION_I__5_2_4_Y_4_3_22___DE_LAS__REGLASCaption = 'LAS   REGLAS  1.6.16, 5.2.7 FRACCION I, 5.2.8 Y 4.3.19   DE LAS  REGLAS';
        GENERALES__DE_COMERCIO_EXTERIOR_VIGENTES_Caption = 'GENERALES  DE COMERCIO EXTERIOR VIGENTES';
        EN_RELACION_CON_EL_ART_9_FRACCION_XI_Y__29_FRACCION_I_DE_LA_LEY_DEL_IVACaption = 'EN RELACION CON EL ART.9 FRACCION XI Y  29 FRACCION I DE LA LEY DEL IVA';
        FRACCIONCaption = 'FRACCION';
        DESCRIPCIONCaption = 'DESCRIPCION';
        ORIGINCaption = 'ORIGIN';
        PART_NO_Caption = 'PART NO.';
        PATENTE_ORIGINALCaption = 'PATENTE ORIGINAL';
        ADUANA_E_SCaption = 'ADUANA E/S';
        CVE_PEDIMENTOCaption = 'CVE PEDIMENTO';
        PEDIMENT_NO_Caption = 'PEDIMENT NO.';
        Fecha_de_entradaCaption = 'Fecha de entrada';
        PIECESCaption = 'PIECES';
        WEIGHT__KG_Caption = 'WEIGHT (KG)';
        SALES__US__Caption = 'SALES (US$)';
        Control1102622103Caption = 'UNIT PRC (/PC)';
        USDollarCaption = 'US$';
        TOTALCaptionMain = 'TOTAL';
    }

    trigger OnPostReport()
    begin
        //>> NF1.00:CIS.SP 09-04-15
        IF ExportToExcel THEN
            CreateExcelbook;
        //<< NF1.00:CIS.SP 09-04-15
    end;

    trigger OnPreReport()
    begin
        CompanyInfo.GET;
        PeriodBeginDate := Customer.GETRANGEMAX("Date Filter");
        PeriodText := FORMAT(PeriodBeginDate, 9, '<Month Text,3> <Year4>');

        IF ExportToExcel THEN BEGIN
            ExcelBuf.DELETEALL;
            MainTitle := 'Nifast Mexicana, SA de CV';
        END;
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        HSTariffCode: Record "HS Tariff Code";
        CommInvMex: Record "Commercial Invoice MEX";
        CalcUnitPrice: Decimal;
        CompanyInfo: Record "Company Information";
        BillToAddress: array[8] of Text[50];
        FormatAddr: Codeunit "Format Address";
        InvoiceNoArray: array[500] of Code[20];
        InvoiceDateArray: array[500] of Date;
        PeriodText: Text[50];
        PeriodBeginDate: Date;
        SalesInvHdr: Record "Sales Invoice Header";
        SalesCrMemoHdr: Record "Sales Cr.Memo Header";
        i: Integer;
        TotalLineAmt: Decimal;
        TotalTax: Decimal;
        TotalAmtInclTax: Decimal;
        TempSalesHdr: Record "Sales Header" temporary;
        CompanyAddress: array[8] of Text[50];
        CompanyInformation: Record "Company Information";
        NIMEX: Integer;
        NiMexCustomer: Record Customer;
        ExportToExcel: Boolean;
        ExcelBuf: Record "Excel Buffer" temporary;
        RowNo: Integer;
        ColumnNo: Integer;
        MainTitle: Text[30];
        Show: Boolean;
        Text001: Label 'Commercial Invoice MEX';
        Text002: Label 'Mex Export Pediment';
        InvoiceVisible8: Boolean;
        InvoiceVisible9: Boolean;
        InvoiceVisible10: Boolean;
        InvoiceVisible11: Boolean;
        InvoiceVisible12: Boolean;
        InvoiceVisible13: Boolean;
        InvoiceVisible14: Boolean;
        InvoiceVisible15: Boolean;
        InvoiceVisible16: Boolean;
        InvoiceVisible17: Boolean;
        InvoiceVisible18: Boolean;
        InvoiceVisible19: Boolean;
        InvoiceVisible20: Boolean;
        InvoiceVisible21: Boolean;
        InvoiceVisible22: Boolean;
        InvoiceVisible23: Boolean;
        InvoiceVisible24: Boolean;
        InvoiceVisible25: Boolean;
        Text004: Label 'Main Title';
        Text005: Label 'Company Name';
        Text006: Label 'Report No.';
        Text007: Label 'Report Name';
        Text008: Label 'User ID';
        Text009: Label 'Date';
        Text012: Label 'MEX Virtual Invoice';
        Text011: Label 'Customer Filters';
        Text020: Label 'Nifast Mexicana, SA de CV';
        Text021: Label 'INVOICE (OPERACION VIRTUAL)';
        Text022: Label 'Sold & Ship to:';
        Text023: Label 'REGISTRO MAQUILA';
        Text024: Label 'PITEX/MAQUILA';
        Text025: Label 'Invoice No.';
        Text026: Label 'Invoice Date';
        Text027: Label 'PERIOD';
        Text028: Label 'Pedimento Virtual #';
        I_Loop: Integer;
        Text029: Label 'Puerto de EMBARQUE (port of loading):';
        Text030: Label 'Puerto de Desembarque (port of discharge)';
        Text031: Label 'TOTAL';
        Text032: Label 'IVA';
        Text033: Label 'G. TOTAL';
        Text034: Label 'US$';
        Text035: Label 'MATERIAS PRIMAS, PARTES,COMPONENTES Y EMPAQUES';
        Text036: Label 'OPERACIÓN REALIZADA  DE CONFORMIDAD CON LO ESTABLECIDO EN';
        Text037: Label 'LAS   REGLAS  1.6.17 , 5.2.6 FRACCION  I , 5.2.7 Y 4.3.21    DE LAS  REGLAS';
        Text038: Label 'GENERALES  DE  COMERCIO EXTERIOR VIGENTES';
        Text039: Label 'EN RELACION CON EL ART. 8 DEL DECRETO IMMEX  Y ART. 9 FRACCION I DE LA LEY DEL IVA';
        Text040: Label 'CUSTOMER ';
        Text041: Label 'PATENTE';
        Text042: Label 'ADUAN';
        Text043: Label 'Fecha de';
        Text044: Label 'CVE';
        Text045: Label 'PEDIMENT';
        Text046: Label 'UNIT PRC';
        Text047: Label 'FRACCION';
        Text048: Label 'DESCRIPCIO';
        Text049: Label 'ORIGIN';
        Text050: Label 'PART NO.';
        Text051: Label 'ORIGINAL';
        Text052: Label 'E/S';
        Text053: Label 'Entrada';
        Text054: Label 'PEDIMENTO';
        Text055: Label 'NO.';
        Text056: Label '(/PC)';
        Text057: Label 'PRICES';
        Text058: Label 'WEIGHT(KG)';
        Text059: Label 'SALES(US$)';
        Text060: Label ' SUBTOTAL';
        Text061: Label ' TOTAL';
        TotalQuantity: Decimal;
        TotalWeight: Decimal;
        TotalLineAmount: Decimal;
        TotalQuantityCountryOfOrigin: Decimal;
        TotalWeightCountryOfOrigin: Decimal;
        TotalLineAmountCountryOfOrigin: Decimal;
        TotalQuantityVirtualOperationNo: Decimal;
        TotalWeightVirtualOperationNo: Decimal;
        TotalLineAmountVirtualOperationNo: Decimal;
        Counter: Integer;
        PrevVirtualOperationNo: Code[10];
        PrevCountryOfOrigin: Code[10];
        IsVirtualOperationNoHeader: Boolean;
        IsCountryOfOriginHeader: Boolean;
        IsVirtualOperationNoFooter: Boolean;
        IsCountryOfOriginFooter: Boolean;
        CustomerCounter: Integer;
        IsCustomerHavingInnerDetails: Boolean;

    local procedure ClearInvoiceVisibleVariables()
    begin
        //>> NF1.00:CIS.SP 09-04-15
        InvoiceVisible8 := FALSE;
        InvoiceVisible9 := FALSE;
        InvoiceVisible10 := FALSE;
        InvoiceVisible11 := FALSE;
        InvoiceVisible12 := FALSE;
        InvoiceVisible13 := FALSE;
        InvoiceVisible14 := FALSE;
        InvoiceVisible15 := FALSE;
        InvoiceVisible16 := FALSE;
        InvoiceVisible17 := FALSE;
        InvoiceVisible18 := FALSE;
        InvoiceVisible19 := FALSE;
        InvoiceVisible20 := FALSE;
        InvoiceVisible21 := FALSE;
        InvoiceVisible22 := FALSE;
        InvoiceVisible23 := FALSE;
        InvoiceVisible24 := FALSE;
        InvoiceVisible25 := FALSE;
        //<< NF1.00:CIS.SP 09-04-15
    end;

    local procedure MakeExcelInfo()
    begin
        //>> NF1.00:CIS.SP 09-04-15
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(FORMAT(Text005), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(COMPANYNAME, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text006), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(REPORT::"MEX Virtual Invoice", FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text007), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FORMAT(Text012), FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text008), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(USERID, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text009), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(TODAY, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text004), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(MainTitle, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text011), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(COPYSTR(Customer.GETFILTERS, 1, 250), FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.ClearNewRow;
        //<< NF1.00:CIS.SP 09-04-15
    end;

    local procedure MakeExcelDataHeader()
    begin
        //>> NF1.00:CIS.SP 09-04-15
        IF CustomerCounter > 1 THEN BEGIN
            ExcelBuf.NewRow; //Extra1
            ExcelBuf.NewRow; //Extra2
        END;

        ExcelBuf.NewRow; //Row1
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col1
        ExcelBuf.AddColumn(Text020, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col2
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col3
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col4
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col5
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col6
        ExcelBuf.AddColumn(CompanyAddress[2] + '   ' + CompanyAddress[3], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col7


        ExcelBuf.NewRow; //Row2
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col1
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col2
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col3
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col4
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col5
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col6
        ExcelBuf.AddColumn(CompanyAddress[4] + '   ' + CompanyAddress[8], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col7

        ExcelBuf.NewRow; //Row3
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col1
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col2
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col3
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col4
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col5
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col6
        ExcelBuf.AddColumn(CompanyAddress[6] + '   ' + CompanyAddress[7], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col7

        ExcelBuf.NewRow; //Row4

        ExcelBuf.NewRow; //Row5
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col1
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col2
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col3
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col4
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col5
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col6
        ExcelBuf.AddColumn(Text021, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col7

        ExcelBuf.NewRow; //Row6

        ExcelBuf.NewRow; //Row7

        ExcelBuf.NewRow; //Row8
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col1
        ExcelBuf.AddColumn(Text022, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col2
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col3
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col4
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col5
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col6
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col7
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col8
        ExcelBuf.AddColumn(Text023, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col9
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col10
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col11
        ExcelBuf.AddColumn(Text025, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col12
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col13
        ExcelBuf.AddColumn(Text026, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col14
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col15
        ExcelBuf.AddColumn(Text027, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col16

        ExcelBuf.NewRow; //Row9
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col1
        ExcelBuf.AddColumn(BillToAddress[1], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col2
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col3
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col4
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col5
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col6
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col7
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col8
        ExcelBuf.AddColumn(CompanyInfo."Maquila Registration No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col9
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col10
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col11
        ExcelBuf.AddColumn(InvoiceNoArray[1], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col12
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col13
        ExcelBuf.AddColumn(InvoiceDateArray[1], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date); //Col14
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col15
        ExcelBuf.AddColumn(PeriodText, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col16

        ExcelBuf.NewRow; //Row10
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col1
        ExcelBuf.AddColumn(BillToAddress[2], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col2
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col3
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col4
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col5
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col6
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col7
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col8
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col9
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col10
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col11
        ExcelBuf.AddColumn(InvoiceNoArray[2], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col12
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col13
        ExcelBuf.AddColumn(InvoiceDateArray[2], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date); //Col14

        ExcelBuf.NewRow; //Row11
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col1
        ExcelBuf.AddColumn(BillToAddress[3], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col2
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col3
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col4
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col5
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col6
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col7
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col8
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col9
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col10
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col11
        ExcelBuf.AddColumn(InvoiceNoArray[3], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col12
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col13
        ExcelBuf.AddColumn(InvoiceDateArray[3], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date); //Col14

        ExcelBuf.NewRow; //Row12
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col1
        ExcelBuf.AddColumn(BillToAddress[4], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col2
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col3
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col4
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col5
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col6
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col7
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col8
        ExcelBuf.AddColumn(Text024, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col9
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col10
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col11
        ExcelBuf.AddColumn(InvoiceNoArray[4], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col12
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col13
        ExcelBuf.AddColumn(InvoiceDateArray[4], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date); //Col14
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col15
        ExcelBuf.AddColumn(Text028, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col16

        ExcelBuf.NewRow; //Row13
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col1
        ExcelBuf.AddColumn(BillToAddress[5], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col2
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col3
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col4
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col5
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col6
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col7
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col8
        ExcelBuf.AddColumn(NiMexCustomer."Pitex/Maquila No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col9
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col10
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col11
        ExcelBuf.AddColumn(InvoiceNoArray[5], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col12
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col13
        ExcelBuf.AddColumn(InvoiceDateArray[5], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date); //Col14

        ExcelBuf.NewRow; //Row14
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col1
        ExcelBuf.AddColumn(BillToAddress[6], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col2
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col3
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col4
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col5
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col6
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col7
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col8
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col9
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col10
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col11
        ExcelBuf.AddColumn(InvoiceNoArray[6], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col12
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col13
        ExcelBuf.AddColumn(InvoiceDateArray[6], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date); //Col14

        ExcelBuf.NewRow; //Row15
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col1
        ExcelBuf.AddColumn(BillToAddress[7], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col2
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col3
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col4
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col5
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col6
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col7
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col8
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col9
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col10
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col11
        ExcelBuf.AddColumn(InvoiceNoArray[7], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col12
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col13
        ExcelBuf.AddColumn(InvoiceDateArray[7], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date); //Col14

        ExcelBuf.NewRow; //Row16
        ExcelBuf.NewRow; //Row17

        FOR I_Loop := 8 TO 25 DO BEGIN
            IF (InvoiceNoArray[I_Loop] <> '') OR (InvoiceDateArray[I_Loop] <> 0D) THEN BEGIN
                ExcelBuf.NewRow; //Rowi or depends
                ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col1
                ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col2
                ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col3
                ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col4
                ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col5
                ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col6
                ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col7
                ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col8
                ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col9
                ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col10
                ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col11
                ExcelBuf.AddColumn(InvoiceNoArray[I_Loop], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col12
                ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col13
                ExcelBuf.AddColumn(InvoiceDateArray[I_Loop], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date); //Col14
            END;
        END;

        ExcelBuf.NewRow; //Row18
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col1
        ExcelBuf.AddColumn(Text029, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col2
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col3
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col4
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col5
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col6
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col7
        ExcelBuf.AddColumn(Text030, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col8
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col9
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col10
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col11
        ExcelBuf.AddColumn(Text031, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col12
        ExcelBuf.AddColumn(Text034, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col13
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col14
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col15
        IF STRPOS(FORMAT(TotalLineAmt), '.') = 0 THEN
            ExcelBuf.AddColumn(TotalLineAmt, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number)
        ELSE
            ExcelBuf.AddColumn(TotalLineAmt, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number); //Col16

        ExcelBuf.NewRow; //Row19
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col1
        ExcelBuf.AddColumn(CompanyInfo."Port of Loading", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col2
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col3
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col4
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col5
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col6
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col7
        ExcelBuf.AddColumn(Customer."Port of Discharge", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col8
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col9
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col10
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col11
        ExcelBuf.AddColumn(Text032, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col12
        ExcelBuf.AddColumn(Text034, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col13
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col14
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col15
        IF STRPOS(FORMAT(TotalTax), '.') = 0 THEN
            ExcelBuf.AddColumn(TotalTax, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number)
        ELSE
            ExcelBuf.AddColumn(TotalTax, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number); //Col16

        ExcelBuf.NewRow; //Row20
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col1
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col2
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col3
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col4
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col5
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col6
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col7
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col8
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col9
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col10
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col11
        ExcelBuf.AddColumn(Text033, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col12
        ExcelBuf.AddColumn(Text034, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col13
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col14
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col15
        IF STRPOS(FORMAT(TotalAmtInclTax), '.') = 0 THEN
            ExcelBuf.AddColumn(TotalAmtInclTax, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number)
        ELSE
            ExcelBuf.AddColumn(TotalAmtInclTax, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number); //Col16

        ExcelBuf.NewRow; //Row21

        ExcelBuf.NewRow; //Row22

        ExcelBuf.NewRow; //Row23

        ExcelBuf.NewRow; //Row24

        ExcelBuf.NewRow; //Row25
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col1
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col2
        ExcelBuf.AddColumn(Text035, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col3
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col4
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col5
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col6
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col7
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col8
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col9
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col10
        ExcelBuf.AddColumn(Text036, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col11

        ExcelBuf.NewRow; //Row26
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col1
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col2
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col3
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col4
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col5
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col6
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col7
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col8
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col9
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col10
        ExcelBuf.AddColumn(Text037, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col11

        ExcelBuf.NewRow; //Row27
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col1
        ExcelBuf.AddColumn(Text040 + Customer."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col2
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col3
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col4
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col5
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col6
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col7
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col8
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col9
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col10
        ExcelBuf.AddColumn(Text038, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col11

        ExcelBuf.NewRow; //Row28
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col1
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col2
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col3
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col4
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col5
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col6
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col7
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col8
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col9
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col10
        ExcelBuf.AddColumn(Text039, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col11

        ExcelBuf.NewRow; //Row29
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col1
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col2
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col3
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col4
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col5
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col6
        ExcelBuf.AddColumn(Text041, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col7
        ExcelBuf.AddColumn(Text042, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col8
        ExcelBuf.AddColumn(Text043, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col9
        ExcelBuf.AddColumn(Text044, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col10
        ExcelBuf.AddColumn(Text045, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col11
        ExcelBuf.AddColumn(Text046, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col12

        ExcelBuf.NewRow; //Row30
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col1
        ExcelBuf.AddColumn(Text047, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col2
        ExcelBuf.AddColumn(Text048, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col3
        ExcelBuf.AddColumn(Text049, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col4
        ExcelBuf.AddColumn(Text040, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col5
        ExcelBuf.AddColumn(Text050, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col6
        ExcelBuf.AddColumn(Text051, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col7
        ExcelBuf.AddColumn(Text052, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col8
        ExcelBuf.AddColumn(Text053, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col9
        ExcelBuf.AddColumn(Text054, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col10
        ExcelBuf.AddColumn(Text055, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col11
        ExcelBuf.AddColumn(Text056, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col12
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col13
        ExcelBuf.AddColumn(Text057, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col14
        ExcelBuf.AddColumn(Text058, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col15
        ExcelBuf.AddColumn(Text059, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col16
        //<< NF1.00:CIS.SP 09-04-15
    end;

    local procedure MakeExcelDataHeaderCommercialInvoiceMEXVirtualOperationNo()
    begin
        //>> NF1.00:CIS.SP 09-04-15
        ExcelBuf.NewRow; //Row31
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col1
        ExcelBuf.AddColumn("Commercial Invoice MEX"."Virtural Operation No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col2
        ExcelBuf.AddColumn(HSTariffCode.Description, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col3

        IsVirtualOperationNoHeader := TRUE;
        IsVirtualOperationNoFooter := FALSE;
        //<< NF1.00:CIS.SP 09-04-15
    end;

    local procedure MakeExcelDataHeaderCommercialInvoiceMEXCountryOfOrigin()
    begin
        //>> NF1.00:CIS.SP 09-04-15
        ExcelBuf.NewRow; //Row32
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col1
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col2
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col3
        ExcelBuf.AddColumn("Commercial Invoice MEX"."Country of Origin", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col4

        IsCountryOfOriginHeader := TRUE;
        IsCountryOfOriginFooter := FALSE;
        //<< NF1.00:CIS.SP 09-04-15
    end;

    local procedure MakeExcelDataBody()
    begin
        //>> NF1.00:CIS.SP 09-04-15
        ExcelBuf.NewRow; //Row33
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col1
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col2
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col3
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col4
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col5
        ExcelBuf.AddColumn(FORMAT("Commercial Invoice MEX"."Item No."), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col6
        ExcelBuf.AddColumn(FORMAT("Commercial Invoice MEX"."Custom Agent License No."), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col7
        ExcelBuf.AddColumn(FORMAT("Commercial Invoice MEX"."Customer Agent E/S"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col8
        ExcelBuf.AddColumn("Commercial Invoice MEX"."Date of Entry", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date); //Col9
        ExcelBuf.AddColumn(FORMAT("Commercial Invoice MEX"."Summary Entry No."), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col10
        ExcelBuf.AddColumn(FORMAT("Commercial Invoice MEX"."Summary Entry Code"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col11
        ExcelBuf.AddColumn(CalcUnitPrice, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number); //Col12
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col13
        ExcelBuf.AddColumn("Commercial Invoice MEX".Quantity, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number); //Col14
        ExcelBuf.AddColumn("Commercial Invoice MEX".Weight, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number); //Col15
        ExcelBuf.AddColumn("Commercial Invoice MEX"."Line Amount", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number); //Col16
        //<< NF1.00:CIS.SP 09-04-15
    end;

    local procedure MakeExcelDataFooterCommercialInvoiceMEXCountryOfOrigin()
    begin
        //>> NF1.00:CIS.SP 09-04-15
        TotalQuantityVirtualOperationNo += TotalQuantityCountryOfOrigin;
        TotalWeightVirtualOperationNo += TotalWeightCountryOfOrigin;
        TotalLineAmountVirtualOperationNo += TotalLineAmountCountryOfOrigin;

        ExcelBuf.NewRow; //Row34

        ExcelBuf.NewRow; //Row35
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col1
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col2
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col3
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col4
        ExcelBuf.AddColumn(PrevCountryOfOrigin + Text060, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col5
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col6
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col7
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col8
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col9
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col10
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col11
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col12
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col13
        ExcelBuf.AddColumn(TotalQuantityCountryOfOrigin, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number); //Col14
        ExcelBuf.AddColumn(TotalWeightCountryOfOrigin, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number); //Col15
        ExcelBuf.AddColumn(TotalLineAmountCountryOfOrigin, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number); //Col16

        ExcelBuf.NewRow; //Row36

        TotalQuantityCountryOfOrigin := 0;
        TotalWeightCountryOfOrigin := 0;
        TotalLineAmountCountryOfOrigin := 0;

        IsCountryOfOriginFooter := TRUE;
        IsCountryOfOriginHeader := FALSE;
        //<< NF1.00:CIS.SP 09-04-15
    end;

    local procedure MakeExcelDataFooterCommercialInvoiceMEXVirtualOperationNo()
    begin
        //>> NF1.00:CIS.SP 09-04-15
        TotalQuantity += TotalQuantityVirtualOperationNo;
        TotalWeight += TotalWeightVirtualOperationNo;
        TotalLineAmount += TotalLineAmountVirtualOperationNo;

        ExcelBuf.NewRow; //Row37

        ExcelBuf.NewRow; //Row38
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col1
        ExcelBuf.AddColumn(PrevVirtualOperationNo + Text061, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col2
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col3
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col4
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col5
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col6
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col7
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col8
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col9
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col10
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col11
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col12
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col13
        ExcelBuf.AddColumn(TotalQuantityVirtualOperationNo, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number); //Col14
        ExcelBuf.AddColumn(TotalWeightVirtualOperationNo, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number); //Col15
        ExcelBuf.AddColumn(TotalLineAmountVirtualOperationNo, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number); //Col16

        ExcelBuf.NewRow; //Row39

        TotalQuantityVirtualOperationNo := 0;
        TotalWeightVirtualOperationNo := 0;
        TotalLineAmountVirtualOperationNo := 0;

        IsVirtualOperationNoFooter := TRUE;
        IsVirtualOperationNoHeader := FALSE;
        //<< NF1.00:CIS.SP 09-04-15
    end;

    local procedure MakeExcelDataFooter()
    begin
        //>> NF1.00:CIS.SP 09-04-15
        ExcelBuf.NewRow; //Row40
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col1
        ExcelBuf.AddColumn(Text061, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col2
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col3
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col4
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col5
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col6
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col7
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col8
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col9
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col10
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col11
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col12
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col13
        ExcelBuf.AddColumn(TotalQuantity, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number); //Col14
        ExcelBuf.AddColumn(TotalWeight, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number); //Col15
        ExcelBuf.AddColumn(TotalLineAmount, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number); //Col16

        TotalQuantity := 0;
        TotalWeight := 0;
        TotalLineAmount := 0;
        //<< NF1.00:CIS.SP 09-04-15
    end;

    local procedure MakeExcelDataBodyMexExportPediment()
    begin
        //>> NF1.00:CIS.SP 09-04-15
        ExcelBuf.NewRow; //Row41
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col1
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col2
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col3
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col4
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col5
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col6
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col7
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col8
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col9
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col10
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col11
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col12
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col13
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col14
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col15
        ExcelBuf.AddColumn("Mex Export Pediment"."Pedimento Virtual No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Col16
        //<< NF1.00:CIS.SP 09-04-15
    end;

    local procedure CreateExcelbook()
    begin
        //>> NF1.00:CIS.SP 09-04-15
        //ExcelBuf.CreateBookAndOpenExcel(MainTitle, MainTitle, COMPANYNAME, USERID); BC Upgrade
        ExcelBuf.CreateNewBook(MainTitle);
        ExcelBuf.WriteSheet(MainTitle, COMPANYNAME, USERID);
        ExcelBuf.CloseBook();
        ExcelBuf.OpenExcel();
        ERROR('');
        //<< NF1.00:CIS.SP 09-04-15
    end;
}

