xmlport 50011 "Export Sales CrMemo to Txt"
{
    // AKK1612.01    21/12/2016    KALPIT  --> Create an XMLPort to export the Sales Cr. Memo into a Txt file

    Direction = Export;
    Format = FixedText;
    RecordSeparator = '<NewLine>';
    TableSeparator = '<NewLine>';
    TextEncoding = UTF16;
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement("sales cr. memo header"; "Sales Cr.Memo Header")
            {
                RequestFilterFields = "No.";
                XmlName = 'SIHeader';
                textattribute(E01)
                {
                    Width = 3;

                    trigger OnBeforePassVariable()
                    begin
                        E01 := 'E01';
                    end;
                }
                fieldattribute(FolioInterno; "Sales Cr. Memo Header"."No.")
                {
                    Width = 20;
                }
                textattribute(Fecha)
                {
                    Width = 19;

                    trigger OnBeforePassVariable()
                    begin
                        Fecha := FORMAT("Sales Cr. Memo Header"."Posting Date", 0, '<Year4>-<Month,2>-<Day,2> ') +
                        FORMAT('00:00:00');
                    end;
                }
                fieldattribute(CondicionesDePago; "Sales Cr. Memo Header"."Payment Terms Code")
                {
                    Width = 150;
                }
                textattribute(Subtotal)
                {
                    Width = 14;

                    trigger OnBeforePassVariable()
                    begin
                        "Sales Cr. Memo Header".CALCFIELDS(Amount);
                        Subtotal := FORMAT(ROUND("Sales Cr. Memo Header".Amount, 0.01));
                        Subtotal := DELCHR(Subtotal, '=', ','); //-AKK1612++ CACLETXT170816
                        IF STRLEN(Subtotal) < 14 THEN
                            Subtotal := AddToPrnString(Subtotal, ' ', STRLEN(Subtotal), (14 - STRLEN(Subtotal)), Justification::Right, ' ', '1');
                    end;
                }
                textattribute(Descuento)
                {
                    Width = 14;

                    trigger OnBeforePassVariable()
                    begin
                        "Sales Cr. Memo Header".CALCFIELDS("Invoice Discount Amount");
                        //-AKK1612-- CACLETXT280716
                        //Descuento := FORMAT(ROUND("Sales Cr. Memo Header"."Invoice Discount Amount",0.01));
                        SIL.RESET();
                        SIL.SETRANGE("Document No.", "Sales Cr. Memo Header"."No.");
                        SIL.SETFILTER(Quantity, '<>0');
                        IF SIL.FINDSET() THEN
                            REPEAT
                                Dscto := Dscto + SIL."Line Discount Amount" + SIL."Inv. Discount Amount";
                            UNTIL SIL.NEXT() = 0;
                        Descuento := FORMAT(ROUND(Dscto, 0.01));
                        Descuento := DELCHR(Descuento, '=', ','); //-AKK1612++ CACLETXT170816
                        IF STRLEN(Descuento) < 14 THEN
                            Descuento := AddToPrnString(Descuento, ' ', STRLEN(Descuento), (14 - STRLEN(Descuento)), Justification::Right, ' ', '1');
                        //+AKK1612++ CACLETXT280716
                    end;
                }
                textattribute(MotivoDescuento)
                {
                    Width = 150;
                }
                textattribute(Total)
                {
                    Width = 14;

                    trigger OnBeforePassVariable()
                    begin
                        "Sales Cr. Memo Header".CALCFIELDS("Amount Including VAT");
                        Total := FORMAT(ROUND("Sales Cr. Memo Header"."Amount Including VAT", 0.01));
                        Total := DELCHR(Total, '=', ','); //-AKK1612++ CACLETXT170816
                        IF STRLEN(Total) < 14 THEN
                            Total := AddToPrnString(Total, ' ', STRLEN(Total), (14 - STRLEN(Total)), Justification::Right, ' ', '1');
                    end;
                }
                fieldattribute(MetodoDePago; "Sales Cr. Memo Header"."Payment Method Code")
                {
                    Width = 30;
                }
                textattribute(TipoDeComprobante)
                {
                    Width = 2;

                    trigger OnBeforePassVariable()
                    begin
                        TipoDeComprobante := '02';
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    SalesCrMemoLineTemp_gRec.DELETEALL();
                    Cnt := 0;
                    SalesCrMemoLine_gRec.RESET();
                    SalesCrMemoLine_gRec.SETRANGE("Document No.", "Sales Cr. Memo Header"."No.");
                    SalesCrMemoLine_gRec.SETFILTER(Type, '<>%1', SalesCrMemoLine_gRec.Type::" ");
                    IF SalesCrMemoLine_gRec.FINDFIRST() THEN
                        REPEAT
                            InsertSalesCrMemoLineTemp_lFnc(SalesCrMemoLine_gRec);
                        UNTIL SalesCrMemoLine_gRec.NEXT() = 0;
                end;

                trigger OnPreXmlItem()
                begin
                    "Sales Cr. Memo Header".SETRANGE("No.", SalCrMemoNo_gCod);
                    "Sales Cr. Memo Header".CALCFIELDS("Sales Cr. Memo Header"."Amount Including VAT", "Sales Cr. Memo Header"."Invoice Discount Amount", "Sales Cr. Memo Header".Amount);
                end;
            }
            tableelement("<siheader2>"; "Sales Cr.Memo Header")
            {
                LinkFields = "Bill-to Customer No." = FIELD("Bill-to Customer No."),
                             "No." = FIELD("No.");
                LinkTable = "Sales Cr. Memo Header";
                XmlName = 'SIHeader2';
                textattribute(E02)
                {
                    Width = 3;

                    trigger OnBeforePassVariable()
                    begin
                        E02 := 'E02';
                    end;
                }
                fieldattribute(No_Cliente; "<SIHeader2>"."Bill-to Customer No.")
                {
                    Width = 20;
                }
                fieldattribute(RFC; "<SIHeader2>"."VAT Registration No.")
                {
                    Width = 13;
                }
                fieldattribute(Nombre; "<SIHeader2>"."Bill-to Name")
                {
                    Width = 150;
                }
            }
            tableelement("<siheader3>"; "Sales Cr.Memo Header")
            {
                LinkFields = "Bill-to Customer No." = FIELD("Bill-to Customer No."),
                             "No." = FIELD("No.");
                LinkTable = "Sales Cr. Memo Header";
                XmlName = 'SIHeader3';
                textattribute(E03)
                {
                    Width = 3;

                    trigger OnBeforePassVariable()
                    begin
                        E03 := 'E03';
                    end;
                }
                fieldattribute(Calle; "<SIHeader3>"."Bill-to Address")
                {
                    Width = 50;
                }
                textattribute(NoExterior)
                {
                    Width = 20;
                }
                textattribute(NoInterior)
                {
                    Width = 50;
                }
                fieldattribute(Colonia; "<SIHeader3>"."Bill-to Address 2")
                {
                    Width = 50;
                }
                textattribute(Localidad)
                {
                    Width = 50;
                }
                textattribute(Referencia)
                {
                    Width = 50;
                }
                fieldattribute(Municipio; "<SIHeader3>"."Bill-to City")
                {
                    Width = 50;
                }
                fieldattribute(Estado; "<SIHeader3>"."Bill-to County")
                {
                    Width = 50;
                }
                fieldattribute(Pais; "<SIHeader3>"."Bill-to Country/Region Code")
                {
                    Width = 50;
                }
                fieldattribute(CodigoPostal; "<SIHeader3>"."Bill-to Post Code")
                {
                    Width = 5;
                }
            }
            tableelement("<siheader6>"; "Sales Cr.Memo Header")
            {
                LinkFields = "Bill-to Customer No." = FIELD("Bill-to Customer No."),
                             "No." = FIELD("No.");
                LinkTable = "Sales Cr. Memo Header";
                XmlName = 'SIHeader6';
                textattribute(E06)
                {
                    Width = 3;

                    trigger OnBeforePassVariable()
                    begin
                        E06 := 'E06';
                    end;
                }
                textattribute(TipoImpuesto)
                {
                    Width = 5;

                    trigger OnBeforePassVariable()
                    begin
                        TipoImpuesto := 'IVA';
                    end;
                }
                textattribute(PorcentajeImpuesto2)
                {
                    Width = 14;

                    trigger OnBeforePassVariable()
                    var
                        SalesInvLines_lRec: Record "Sales Cr.Memo Line";
                    begin
                        //-AKK1612-- CACLETXT280716
                        /*
                        SalesInvLines_lRec.RESET;
                        SalesInvLines_lRec.SETRANGE("Document No.","<SIHeader6>"."No.");
                        SalesInvLines_lRec.SETRANGE("Sell-to Customer No.","<SIHeader6>"."Sell-to Customer No.");
                        SalesInvLines_lRec.SETFILTER("VAT Prod. Posting Group",'<>%1','');
                        IF SalesInvLines_lRec.FINDFIRST THEN BEGIN
                          VatPosting_lRec.RESET;
                          VatPosting_lRec.SETCURRENTKEY("VAT Bus. Posting Group","VAT Prod. Posting Group");
                          VatPosting_lRec.SETRANGE("VAT Bus. Posting Group","<SIHeader6>"."VAT Bus. Posting Group");
                          VatPosting_lRec.SETRANGE("VAT Prod. Posting Group",SalesInvLines_lRec."VAT Prod. Posting Group");
                          IF VatPosting_lRec.FINDLAST THEN
                            PorcentajeImpuesto2 := FORMAT(ROUND(VatPosting_lRec."VAT %",0.01))
                          ELSE
                            PorcentajeImpuesto2 := '';
                        END ELSE
                          PorcentajeImpuesto2 := '';
                        */

                        SalesInvLines_lRec.RESET();
                        SalesInvLines_lRec.SETRANGE("Document No.", "<SIHeader6>"."No.");
                        SalesInvLines_lRec.SETRANGE("Sell-to Customer No.", "<SIHeader6>"."Sell-to Customer No.");
                        SalesInvLines_lRec.SETFILTER(Quantity, '<>0');
                        IF SalesInvLines_lRec.FINDFIRST() THEN
                            PorcentajeImpuesto2 := FORMAT(ROUND(SalesInvLines_lRec."VAT %", 0.01))
                        ELSE
                            PorcentajeImpuesto2 := '';
                        //+AKK1612++ CACLETXT280716

                    end;
                }
                textattribute(MontoImpuesto2)
                {
                    Width = 14;

                    trigger OnBeforePassVariable()
                    begin
                        "<SIHeader6>".CALCFIELDS("Amount Including VAT");
                        MontoImpuesto2 := FORMAT(ROUND(("<SIHeader6>"."Amount Including VAT" - "<SIHeader6>".Amount), 0.01));
                        MontoImpuesto2 := DELCHR(MontoImpuesto2, '=', ','); //-AKK1612++ CACLETXT170816
                        IF STRLEN(MontoImpuesto2) < 14 THEN
                            MontoImpuesto2 := AddToPrnString(MontoImpuesto2, ' ', STRLEN(MontoImpuesto2), (14 - STRLEN(MontoImpuesto2)), Justification::Right, ' ', '1');
                    end;
                }
            }
            tableelement("<siheader8>"; "Sales Cr.Memo Header")
            {
                LinkFields = "Bill-to Customer No." = FIELD("Bill-to Customer No."),
                             "No." = FIELD("No.");
                LinkTable = "Sales Cr. Memo Header";
                XmlName = 'SIHeader8';
                textattribute(EA1)
                {
                    Width = 3;

                    trigger OnBeforePassVariable()
                    begin
                        EA1 := 'EA1';
                    end;
                }
                textattribute(DiasVencimiento)
                {
                    Width = 3;
                }
                textattribute(Moneda)
                {
                    Width = 3;
                }
                textattribute(TipoCambio)
                {
                    Width = 14;

                    trigger OnBeforePassVariable()
                    begin
                        //-AKK1612-- CACLETXT280716
                        //TipoCambio := FORMAT(ROUND("<SIHeader8>"."Currency Factor",0.0001));
                        IF "<SIHeader8>"."Currency Code" = '' THEN
                            TC := 1
                        ELSE
                            TC := 1 / "<SIHeader8>"."Currency Factor";
                        TipoCambio := FORMAT(ROUND(TC, 0.0001));
                        //+AKK1612++ CACLETXT280716
                    end;
                }
                textattribute(NTECBH)
                {
                    Width = 254;
                }
            }
            tableelement("Sales Invoice/Cr. Memo Export"; "Sales Invoice/Cr. Memo Export")
            {
                LinkFields = "Document No." = FIELD("No.");
                LinkTable = "Sales Cr. Memo Header";
                LinkTableForceInsert = false;
                XmlName = 'SILine';
                UseTemporary = false;
                fieldattribute(Details1; "Sales Invoice/Cr. Memo Export".Details1)
                {
                    Width = 250;
                }
                fieldattribute(Details2; "Sales Invoice/Cr. Memo Export".Details2)
                {
                    Width = 250;
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    var
        ILE_gRec: Record "Item Ledger Entry";
        SalesCrMemoLine_gRec: Record "Sales Cr.Memo Line";
        SIL: Record "Sales Cr.Memo Line";
        SalesCrMemoLineTemp_gRec: Record "Sales Invoice/Cr. Memo Export";
        SalCrMemoNo_gCod: Code[20];
        Dscto: Decimal;
        TC: Decimal;
        Cnt: Integer;
        Justification: Option Left,Right;

    local procedure InsertSalesCrMemoLineTemp_lFnc(var SalesCrMemoLine_vRec: Record "Sales Cr.Memo Line")
    begin
        InsertCrMemoLineTemp_lFnc(SalesCrMemoLine_vRec);
        InsertDO2Lines_lFnc(SalesCrMemoLine_vRec);
        InsertDA6Lines_lFnc(SalesCrMemoLine_vRec);
        //-AKK1612-- CACLETXT280716
        /*
        InsertDA1Lines_lFnc(SalesCrMemoLine_vRec);
        InsertDA2Lines_lFnc(SalesCrMemoLine_vRec);
        InsertDA3Lines_lFnc(SalesCrMemoLine_vRec);
        InsertDA4Lines_lFnc(SalesCrMemoLine_vRec);
        InsertDA5Lines_lFnc(SalesCrMemoLine_vRec);
        InsertDA7Lines_lFnc(SalesCrMemoLine_vRec);
        InsertDA8Lines_lFnc(SalesCrMemoLine_vRec);
        InsertDC3Lines_lFnc(SalesCrMemoLine_vRec);
        InsertDC4Lines_lFnc(SalesCrMemoLine_vRec);
        InsertDC5Lines_lFnc(SalesCrMemoLine_vRec);
        InsertDC6Lines_lFnc(SalesCrMemoLine_vRec);
        InsertDC7Lines_lFnc(SalesCrMemoLine_vRec);
        InsertDC8Lines_lFnc(SalesCrMemoLine_vRec);
        */
        //+AKK1612++ CACLETXT280716

    end;

    local procedure InsertCrMemoLineTemp_lFnc(var SalesCrMemoLine_vRec: Record "Sales Cr.Memo Line")
    var
        Unidad: Text[5];
        Cantidad: Text[14];
        Importe: Text[14];
        ValorUnitario: Text[14];
        ClientIdentification: Text[20];
        CuentaPredial: Text[20];
        NoIdentificacion: Text[20];
        Descripcion: Text[150];
        Details_lTxt: Text[250];
    begin
        Cantidad := FORMAT(ROUND(SalesCrMemoLine_vRec.Quantity, 0.0001));
        Cantidad := PADSTR(Cantidad, 14, ' ');
        Cantidad := DELCHR(Cantidad, '=', ','); //-CACLETXT250816++
        IF STRLEN(Cantidad) < 14 THEN
            Cantidad := AddToPrnString(Cantidad, ' ', STRLEN(Cantidad), (14 - STRLEN(Cantidad)), Justification::Right, ' ', '1');

        Unidad := FORMAT(PADSTR(SalesCrMemoLine_vRec."Unit of Measure", 5, ' '));
        NoIdentificacion := FORMAT(PADSTR(SalesCrMemoLine_vRec."No.", 20, ' '));
        //ClientIdentification := FORMAT(PADSTR(ClientIdentification,20,' '));
        ClientIdentification := FORMAT(PADSTR(SalesCrMemoLine_vRec."Item Reference No.", 20, ' ')); //-AKK1612++
        Descripcion := FORMAT(PADSTR(SalesCrMemoLine_vRec.Description, 150, ' '));
        ValorUnitario := FORMAT(ROUND(SalesCrMemoLine_vRec."Unit Price", 0.0001));
        ValorUnitario := PADSTR(ValorUnitario, 14, ' ');
        ValorUnitario := DELCHR(ValorUnitario, '=', ','); //-CACLETXT250816++
        IF STRLEN(ValorUnitario) < 14 THEN
            ValorUnitario := AddToPrnString(ValorUnitario, ' ', STRLEN(ValorUnitario), (14 - STRLEN(ValorUnitario)), Justification::Right, ' ', '1');

        Importe := FORMAT(ROUND((SalesCrMemoLine_vRec.Quantity * SalesCrMemoLine_vRec."Unit Price"), 0.0001));
        Importe := PADSTR(Importe, 14, ' ');
        Importe := DELCHR(Importe, '=', ','); //-CACLETXT250816++
        IF STRLEN(Importe) < 14 THEN
            Importe := AddToPrnString(Importe, ' ', STRLEN(Importe), (14 - STRLEN(Importe)), Justification::Right, ' ', '1');

        CuentaPredial := FORMAT(PADSTR(CuentaPredial, 20, ' '));
        SalesCrMemoLineTemp_gRec.INIT();
        Cnt := Cnt + 1;
        SalesCrMemoLineTemp_gRec.SLInes := Cnt;
        SalesCrMemoLineTemp_gRec."Document No." := "Sales Cr. Memo Header"."No.";
        Details_lTxt := PADSTR('D01' + Cantidad + Unidad + NoIdentificacion + ClientIdentification + Descripcion + ValorUnitario + Importe, 240, ' ');

        SalesCrMemoLineTemp_gRec.Details1 := Details_lTxt;
        SalesCrMemoLineTemp_gRec.Details2 := CuentaPredial;
        SalesCrMemoLineTemp_gRec.INSERT();
    end;

    local procedure InsertDO2Lines_lFnc(var SalesCrMemoLine_vRec: Record "Sales Cr.Memo Line")
    var
        ItemApplEntry_lRec: Record "Item Application Entry";
        ILE_lRec: Record "Item Ledger Entry";
        ValueEntry_lRec: Record "Value Entry";
        Consecutivo: Text[2];
        FechaPedimento: Text[10];
        Pedimento: Text[20];
        Aduana: Text[50];
        Details_lTxt: Text[250];
    begin
        ValueEntry_lRec.RESET();
        ValueEntry_lRec.SETRANGE("Document No.", SalesCrMemoLine_vRec."Document No.");
        ValueEntry_lRec.SETRANGE("Item No.", SalesCrMemoLine_vRec."No.");
        IF ValueEntry_lRec.findset() THEN
            REPEAT
                ItemApplEntry_lRec.RESET();
                ItemApplEntry_lRec.SETRANGE("Outbound Item Entry No.", ValueEntry_lRec."Item Ledger Entry No.");
                IF ItemApplEntry_lRec.FINDFIRST() THEN BEGIN
                    ILE_lRec.GET(ValueEntry_lRec."Item Ledger Entry No.");
                    ILE_lRec.CALCFIELDS("CVE Pedimento", ILE_lRec."Aduana E/S");
                    Consecutivo := PADSTR(ILE_gRec."CVE Pedimento", 2, ' ');
                    Pedimento := PADSTR(ItemApplEntry_lRec."Entry/Exit No.", 20, ' ');
                    FechaPedimento := PADSTR(FORMAT(ItemApplEntry_lRec."Entry/Exit Date", 0, '<Year4>-<Month,2>-<Day,2>'), 10, ' ');
                    Aduana := PADSTR(ILE_gRec."Aduana E/S", 50, ' ');
                    SalesCrMemoLineTemp_gRec.INIT();
                    Cnt := Cnt + 1;
                    SalesCrMemoLineTemp_gRec.SLInes := Cnt;
                    SalesCrMemoLineTemp_gRec."Document No." := "Sales Cr. Memo Header"."No.";
                    Details_lTxt := PADSTR('D02' + Consecutivo + Pedimento + FechaPedimento + Aduana, 240, ' ');
                    SalesCrMemoLineTemp_gRec.Details1 := Details_lTxt;
                    SalesCrMemoLineTemp_gRec.INSERT();
                END;
            UNTIL ValueEntry_lRec.NEXT() = 0;
    end;

    /*  local procedure InsertDA1Lines_lFnc(var SalesCrMemoLine_vRec: Record "Sales Cr.Memo Line")
     var
         FechadelaOrdendeCompra2: Date;
         UnidadMedidaPeso: Text[5];
         FechadelaOrdendeCompra: Text[10];
         Peso: Text[14];
         OrdendeCompra: Text[20];
         Details_lTxt: Text[250];
     begin
         OrdendeCompra := PADSTR(OrdendeCompra, 20, ' ');
         FechadelaOrdendeCompra := PADSTR(FORMAT((FechadelaOrdendeCompra2), 0, '<Year4>-<Month,2>-<Day,2>'), 10, ' ');
         Peso := PADSTR(Peso, 14, ' ');
         UnidadMedidaPeso := PADSTR(UnidadMedidaPeso, 5, ' ');
         SalesCrMemoLineTemp_gRec.INIT();
         Cnt := Cnt + 1;
         SalesCrMemoLineTemp_gRec.SLInes := Cnt;
         SalesCrMemoLineTemp_gRec."Document No." := "Sales Cr. Memo Header"."No.";
         Details_lTxt := PADSTR('DA1' + OrdendeCompra + FechadelaOrdendeCompra + Peso + UnidadMedidaPeso, 240, ' ');
         SalesCrMemoLineTemp_gRec.Details1 := Details_lTxt;
         SalesCrMemoLineTemp_gRec.INSERT();
     end;

     local procedure InsertDA2Lines_lFnc(var SalesCrMemoLine_vRec: Record "Sales Cr.Memo Line")
     var
         "Fecha Envio2": Date;
         TipoFlete: Text[1];
         ammendment: Text[3];
         "Fecha Envio": Text[10];
         PesoNeto: Text[10];
         BillOfLading: Text[20];
         NoRealese: Text[20];
         packingList: Text[20];
         Details_lTxt: Text[250];
     begin
         NoRealese := PADSTR(NoRealese, 20, ' ');
         "Fecha Envio" := PADSTR(FORMAT("Fecha Envio2", 0, '<Year4>-<Month,2>-<Day,2>'), 10, ' ');
         BillOfLading := PADSTR(BillOfLading, 20, ' ');
         packingList := PADSTR(packingList, 20, ' ');
         TipoFlete := PADSTR(TipoFlete, 1, ' ');
         ammendment := PADSTR(ammendment, 3, ' ');
         PesoNeto := PADSTR(PesoNeto, 10, ' ');
         SalesCrMemoLineTemp_gRec.INIT();
         Cnt := Cnt + 1;
         SalesCrMemoLineTemp_gRec.SLInes := Cnt;
         SalesCrMemoLineTemp_gRec."Document No." := "Sales Cr. Memo Header"."No.";
         Details_lTxt := PADSTR('   ' + NoRealese + "Fecha Envio" + BillOfLading + packingList + TipoFlete + ammendment + PesoNeto, 240, ' ');
         SalesCrMemoLineTemp_gRec.Details1 := Details_lTxt;
         SalesCrMemoLineTemp_gRec.INSERT();
     end;

     local procedure InsertDA3Lines_lFnc(var SalesCrMemoLine_vRec: Record "Sales Cr.Memo Line")
     var
         Secuencia: Text[3];
         Nota: Text[200];
         Details_lTxt: Text[250];
     begin
         Secuencia := PADSTR(Secuencia, 3, ' ');
         Nota := PADSTR(Nota, 200, ' ');
         SalesCrMemoLineTemp_gRec.INIT();
         Cnt := Cnt + 1;
         SalesCrMemoLineTemp_gRec.SLInes := Cnt;
         SalesCrMemoLineTemp_gRec."Document No." := "Sales Cr. Memo Header"."No.";
         Details_lTxt := PADSTR('   ' + Secuencia + Nota, 240, ' ');
         SalesCrMemoLineTemp_gRec.Details1 := Details_lTxt;
         SalesCrMemoLineTemp_gRec.INSERT();
     end;

     local procedure InsertDA4Lines_lFnc(var SalesCrMemoLine_vRec: Record "Sales Cr.Memo Line")
     var
         Porcentaje: Text[7];
         Codigo: Text[10];
         Importe: Text[14];
         Descripcion: Text[80];
         Details_lTxt: Text[250];
     begin
         Codigo := PADSTR(Codigo, 10, ' ');
         Porcentaje := PADSTR(Porcentaje, 7, ' ');
         Descripcion := PADSTR(Descripcion, 80, ' ');
         Importe := PADSTR(Importe, 14, ' ');
         SalesCrMemoLineTemp_gRec.INIT();
         Cnt := Cnt + 1;
         SalesCrMemoLineTemp_gRec.SLInes := Cnt;
         SalesCrMemoLineTemp_gRec."Document No." := "Sales Cr. Memo Header"."No.";
         Details_lTxt := PADSTR('   ' + Codigo + Porcentaje + Descripcion + Importe, 240, ' ');
         SalesCrMemoLineTemp_gRec.Details1 := Details_lTxt;
         SalesCrMemoLineTemp_gRec.INSERT();
     end;

     local procedure InsertDA5Lines_lFnc(var SalesCrMemoLine_vRec: Record "Sales Cr.Memo Line")
     var
         TipoCantidadAdicional: Text[20];
         CantidadAdicional: Text[80];
         Details_lTxt: Text[250];
     begin
         TipoCantidadAdicional := PADSTR(TipoCantidadAdicional, 20, ' ');
         CantidadAdicional := PADSTR(CantidadAdicional, 80, ' ');
         SalesCrMemoLineTemp_gRec.INIT();
         Cnt := Cnt + 1;
         SalesCrMemoLineTemp_gRec.SLInes := Cnt;
         SalesCrMemoLineTemp_gRec."Document No." := "Sales Cr. Memo Header"."No.";
         Details_lTxt := PADSTR('   ' + TipoCantidadAdicional + CantidadAdicional, 240, ' ');
         SalesCrMemoLineTemp_gRec.Details1 := Details_lTxt;
         SalesCrMemoLineTemp_gRec.INSERT();
     end; */

    local procedure InsertDA6Lines_lFnc(var SalesCrMemoLine_vRec: Record "Sales Cr.Memo Line")
    var
        Impuesto: Text[5];
        Importe: Text[14];
        Tasa: Text[14];
        Details_lTxt: Text[250];
    begin
        //-AKK1612-- CACLETXT280716
        //Impuesto := PADSTR(SalesCrMemoLine_vRec."VAT Identifier",5,' ');
        //Importe := PADSTR(FORMAT(ROUND(SalesCrMemoLine_vRec.Amount,0.01)),14,' ');
        Impuesto := PADSTR('IVA', 5, ' ');
        Importe := PADSTR(FORMAT(ROUND(SalesCrMemoLine_vRec."Amount Including VAT" - SalesCrMemoLine_vRec.Amount, 0.01)), 14, ' ');
        //+AKK1612++ CACLETXT280716
        Tasa := PADSTR(FORMAT(ROUND(SalesCrMemoLine_vRec."VAT %", 0.01)), 14, ' ');
        SalesCrMemoLineTemp_gRec.INIT();
        Cnt := Cnt + 1;
        SalesCrMemoLineTemp_gRec.SLInes := Cnt;
        SalesCrMemoLineTemp_gRec."Document No." := "Sales Cr. Memo Header"."No.";
        Details_lTxt := PADSTR('DA6' + Impuesto + Importe + Tasa, 240, ' ');
        SalesCrMemoLineTemp_gRec.Details1 := Details_lTxt;
        SalesCrMemoLineTemp_gRec.INSERT();
    end;

    /* local procedure InsertDA7Lines_lFnc(var SalesCrMemoLine_vRec: Record "Sales Cr.Memo Line")
    var
        Fecha2: Date;
        Fecha: Text[10];
        ContraRecibo: Text[20];
        Details_lTxt: Text[250];
    begin
        ContraRecibo := PADSTR(ContraRecibo, 20, ' ');
        Fecha := PADSTR(FORMAT(Fecha2, 0, '<Year4>-<Month,2>-<Day,2>'), 10, ' ');
        SalesCrMemoLineTemp_gRec.INIT();
        Cnt := Cnt + 1;
        SalesCrMemoLineTemp_gRec.SLInes := Cnt;
        SalesCrMemoLineTemp_gRec."Document No." := "Sales Cr. Memo Header"."No.";
        Details_lTxt := PADSTR('   ' + ContraRecibo + Fecha, 240, ' ');
        SalesCrMemoLineTemp_gRec.Details1 := Details_lTxt;
        SalesCrMemoLineTemp_gRec.INSERT();
    end;

    local procedure InsertDA8Lines_lFnc(var SalesCrMemoLine_vRec: Record "Sales Cr.Memo Line")
    var
        Porcentaje: Text[7];
        Codigo: Text[10];
        Importe: Text[14];
        Descripcion: Text[80];
        Details_lTxt: Text[250];
    begin
        Codigo := PADSTR(Codigo, 10, ' ');
        Porcentaje := PADSTR(Porcentaje, 7, ' ');
        Descripcion := PADSTR(Descripcion, 80, ' ');
        Importe := PADSTR(Importe, 14, ' ');
        SalesCrMemoLineTemp_gRec.INIT();
        Cnt := Cnt + 1;
        SalesCrMemoLineTemp_gRec.SLInes := Cnt;
        SalesCrMemoLineTemp_gRec."Document No." := "Sales Cr. Memo Header"."No.";
        Details_lTxt := PADSTR('   ' + Codigo + Porcentaje + Descripcion + Importe, 240, ' ');
        SalesCrMemoLineTemp_gRec.Details1 := Details_lTxt;
        SalesCrMemoLineTemp_gRec.INSERT();
    end;

    local procedure InsertDC3Lines_lFnc(var SalesCrMemoLine_vRec: Record "Sales Cr.Memo Line")
    var
        CustomField03: Text[250];
        Details_lTxt: Text[250];
    begin
        CustomField03 := PADSTR(CustomField03, 250, ' ');
        SalesCrMemoLineTemp_gRec.INIT();
        Cnt := Cnt + 1;
        SalesCrMemoLineTemp_gRec.SLInes := Cnt;
        SalesCrMemoLineTemp_gRec."Document No." := "Sales Cr. Memo Header"."No.";
        Details_lTxt := PADSTR('   ' + CustomField03, 250, ' ');
        SalesCrMemoLineTemp_gRec.Details1 := Details_lTxt;
        SalesCrMemoLineTemp_gRec.INSERT();
    end;

    local procedure InsertDC4Lines_lFnc(var SalesCrMemoLine_vRec: Record "Sales Cr.Memo Line")
    var
        CustomField04: Text[250];
        Details_lTxt: Text[250];
    begin
        CustomField04 := PADSTR(CustomField04, 250, ' ');
        SalesCrMemoLineTemp_gRec.INIT();
        Cnt := Cnt + 1;
        SalesCrMemoLineTemp_gRec.SLInes := Cnt;
        SalesCrMemoLineTemp_gRec."Document No." := "Sales Cr. Memo Header"."No.";
        Details_lTxt := PADSTR('   ' + CustomField04, 250, ' ');
        SalesCrMemoLineTemp_gRec.Details1 := Details_lTxt;
        SalesCrMemoLineTemp_gRec.INSERT();
    end;

    local procedure InsertDC5Lines_lFnc(var SalesCrMemoLine_vRec: Record "Sales Cr.Memo Line")
    var
        CustomField05: Text[250];
        Details_lTxt: Text[250];
    begin
        CustomField05 := PADSTR(CustomField05, 250, ' ');
        SalesCrMemoLineTemp_gRec.INIT();
        Cnt := Cnt + 1;
        SalesCrMemoLineTemp_gRec.SLInes := Cnt;
        SalesCrMemoLineTemp_gRec."Document No." := "Sales Cr. Memo Header"."No.";
        Details_lTxt := PADSTR('   ' + CustomField05, 250, ' ');
        SalesCrMemoLineTemp_gRec.Details1 := Details_lTxt;
        SalesCrMemoLineTemp_gRec.INSERT();
    end;

    local procedure InsertDC6Lines_lFnc(var SalesCrMemoLine_vRec: Record "Sales Cr.Memo Line")
    var
        CustomField06: Text[250];
        Details_lTxt: Text[250];
    begin
        CustomField06 := PADSTR(CustomField06, 250, ' ');
        SalesCrMemoLineTemp_gRec.INIT();
        Cnt := Cnt + 1;
        SalesCrMemoLineTemp_gRec.SLInes := Cnt;
        SalesCrMemoLineTemp_gRec."Document No." := "Sales Cr. Memo Header"."No.";
        Details_lTxt := PADSTR('   ' + CustomField06, 250, ' ');
        SalesCrMemoLineTemp_gRec.Details1 := Details_lTxt;
        SalesCrMemoLineTemp_gRec.INSERT();
    end;

    local procedure InsertDC7Lines_lFnc(var SalesCrMemoLine_vRec: Record "Sales Cr.Memo Line")
    var
        CustomField07: Text[250];
        Details_lTxt: Text[250];
    begin
        CustomField07 := PADSTR(CustomField07, 250, ' ');
        SalesCrMemoLineTemp_gRec.INIT();
        Cnt := Cnt + 1;
        SalesCrMemoLineTemp_gRec.SLInes := Cnt;
        SalesCrMemoLineTemp_gRec."Document No." := "Sales Cr. Memo Header"."No.";
        Details_lTxt := PADSTR('   ' + CustomField07, 250, ' ');
        SalesCrMemoLineTemp_gRec.Details1 := Details_lTxt;
        SalesCrMemoLineTemp_gRec.INSERT();
    end;

    local procedure InsertDC8Lines_lFnc(var SalesCrMemoLine_vRec: Record "Sales Cr.Memo Line")
    var
        CustomField08: Text[250];
        Details_lTxt: Text[250];
    begin
        CustomField08 := PADSTR(CustomField08, 250, ' ');
        SalesCrMemoLineTemp_gRec.INIT();
        Cnt := Cnt + 1;
        SalesCrMemoLineTemp_gRec.SLInes := Cnt;
        SalesCrMemoLineTemp_gRec."Document No." := "Sales Cr. Memo Header"."No.";
        Details_lTxt := PADSTR('   ' + CustomField08, 250, ' ');
        SalesCrMemoLineTemp_gRec.Details1 := Details_lTxt;
        SalesCrMemoLineTemp_gRec.INSERT();
    end; */

    procedure GetCrMemoNo_gFnc(var CrMemoNo_vCod: Code[20])
    begin
        SalCrMemoNo_gCod := CrMemoNo_vCod;
    end;

    /*  local procedure "//"()
     begin
     end; */

    local procedure AddToPrnString(var PrnString: Text[422]; SubString: Text[345]; StartPos: Integer; Length: Integer; JustificationLVar: Option Left,Right; Filler: Text[1]; Type: Text[1]): Text[50]
    var
        I: Integer;
        SubStrLen: Integer;
    begin
        SubString := UPPERCASE(DELCHR(SubString, '<>', ' '));
        SubStrLen := STRLEN(SubString);

        IF SubStrLen > Length THEN BEGIN
            SubString := COPYSTR(SubString, 1, Length);
            SubStrLen := Length;
        END;

        IF JustificationLVar = JustificationLVar::Right THEN
            FOR I := 1 TO (Length - SubStrLen) DO
                SubString := Filler + SubString
        ELSE
            FOR I := SubStrLen + 1 TO Length DO
                SubString := SubString + Filler;

        IF STRLEN(PrnString) >= StartPos THEN
            IF StartPos > 1 THEN
                PrnString := COPYSTR(PrnString, 1, StartPos - 1) + SubString + COPYSTR(PrnString, StartPos)
            ELSE
                PrnString := SubString + PrnString
        ELSE BEGIN
            FOR I := STRLEN(PrnString) + 1 TO StartPos - 1 DO
                PrnString := PrnString + ' ';
            PrnString := PrnString + SubString;
        END;

        IF Type = '1' THEN
            PrnString := COPYSTR(PrnString, 1, 14); //Descuento
        EXIT(PrnString);
    end;
}

