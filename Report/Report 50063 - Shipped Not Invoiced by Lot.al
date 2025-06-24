report 50063 "Shipped Not Invoiced by Lot"
{
    // NF1.00:CIS.SP  09-09-15 Merged during upgrade
    // >>NF1
    // Export To Excel as per requirement
    // <<NF1
    // 
    // IF (ExportDetailToExcel OR ExportTotalsToExcel) THEN BEGIN
    // 
    // (ExportDetailToExcel OR ExportTotalsToExcel)
    // 
    // {
    // EnterCell
    // RowNo     Integer
    // ColumnNo  Integer
    // CellValue Text
    // Bold      Boolean
    // Italic    Boolean
    // UnderLine Boolean
    DefaultLayout = RDLC;
    RDLCLayout = './Shipped Not Invoiced by Lot.rdlc';


    dataset
    {
        dataitem(DataItem7209;Table32)
        {
            DataItemTableView = SORTING(Source Type,Source No.,Entry Type,Item No.,Variant Code,Posting Date)
                                WHERE(Source Type=FILTER(Customer),
                                      Entry Type=FILTER(Sale));
            RequestFilterFields = "Source Type","Source No.","Entry Type","Item No.","Global Dimension 1 Code";
            column(COMPANYNAME;COMPANYNAME)
            {
            }
            column(FilterText;FilterText)
            {
            }
            column(Dim1Text;Dim1Text)
            {
            }
            column(Customer______Source_No_____________Cust_Name;'Customer ' + "Source No." + ' - ' + Cust.Name)
            {
            }
            column(Item_Ledger_Entry__Posting_Date_;FORMAT("Posting Date"))
            {
            }
            column(Item_Ledger_Entry__Document_No__;"Document No.")
            {
            }
            column(Item_Ledger_Entry__Location_Code_;"Location Code")
            {
            }
            column(Item_Ledger_Entry_Quantity;Quantity)
            {
            }
            column(Item_Ledger_Entry__Invoiced_Quantity_;"Invoiced Quantity")
            {
            }
            column(Item_Ledger_Entry__Lot_No__;"Lot No.")
            {
            }
            column(Sales_Amount__Expected______Sales_Amount__Actual__;"Sales Amount (Expected)" - "Sales Amount (Actual)")
            {
            }
            column(OrderNo;OrderNo)
            {
            }
            column(Item_Ledger_Entry__Item_No__;"Item No.")
            {
            }
            column(Quantity____Invoiced_Quantity_;Quantity - "Invoiced Quantity")
            {
            }
            column(Item_Ledger_Entry__Global_Dimension_1_Code_;"Global Dimension 1 Code")
            {
            }
            column(Item_Ledger_Entry__Sales_Amount__Expected__;"Sales Amount (Expected)")
            {
            }
            column(Item_Ledger_Entry__Sales_Amount__Actual__;"Sales Amount (Actual)")
            {
            }
            column(Totals__Customer______Source_No_____________Cust_Name;'Totals: Customer ' + "Source No." + ' - ' + Cust.Name)
            {
            }
            column(Grand_Totals_;'Grand Totals')
            {
            }
            column(Item_Ledger_Entry__Posting_Date_Caption;FIELDCAPTION("Posting Date"))
            {
            }
            column(Item_Ledger_Entry__Document_No__Caption;FIELDCAPTION("Document No."))
            {
            }
            column(Item_Ledger_Entry__Location_Code_Caption;FIELDCAPTION("Location Code"))
            {
            }
            column(Item_Ledger_Entry_QuantityCaption;FIELDCAPTION(Quantity))
            {
            }
            column(Item_Ledger_Entry__Invoiced_Quantity_Caption;FIELDCAPTION("Invoiced Quantity"))
            {
            }
            column(Item_Ledger_Entry__Lot_No__Caption;FIELDCAPTION("Lot No."))
            {
            }
            column(Item_Ledger_Entry__Item_No__Caption;FIELDCAPTION("Item No."))
            {
            }
            column(Item_Ledger_Entry__Sales_Amount__Expected__Caption;FIELDCAPTION("Sales Amount (Expected)"))
            {
            }
            column(Item_Ledger_Entry__Sales_Amount__Actual__Caption;FIELDCAPTION("Sales Amount (Actual)"))
            {
            }
            column(Item_Ledger_Entry_Entry_No_;"Entry No.")
            {
            }
            column(Item_Ledger_Entry_Source_Type;"Source Type")
            {
            }
            column(Item_Ledger_Entry_Source_No_;"Source No.")
            {
            }
            column(Item_Ledger_Entry_Entry_Type;"Entry Type")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Window.UPDATE(1,"Source No.");

                IF "Item Ledger Entry".Quantity="Item Ledger Entry"."Invoiced Quantity" THEN
                  CurrReport.SKIP;

                IF NOT Item.GET("Item No.") THEN
                  CLEAR(Item);


                IF NOT SalesShptHdr.GET("Document No.") THEN
                 CLEAR(OrderNo)
                ELSE
                 OrderNo := SalesShptHdr."Order No.";

                IF NOT FooterPrinted THEN
                  LastFieldNo := CurrReport.TOTALSCAUSEDBY;
                CurrReport.SHOWOUTPUT := NOT FooterPrinted;
                FooterPrinted := TRUE;

                IF NOT Cust.GET("Source No.") THEN
                  CLEAR(Cust);

                //>> NF1.00:CIS.SP 09-09-15
                IF ExportToExcel THEN BEGIN
                  "Item Ledger Entry".CALCFIELDS("Sales Amount (Expected)","Sales Amount (Actual)");
                  CountItemLedgerEntry += 1;

                  IF (PrevSourceNo <> "Item Ledger Entry"."Source No.") AND ((TotalSalesAmountExpected - TotalSalesAmountActual) <> 0) AND (CountItemLedgerEntry > 1) THEN BEGIN
                    MakeExcelDataGroupTotals;
                    ExcelBuf.NewRow;
                  END;

                  TotalSalesAmountExpected += "Item Ledger Entry"."Sales Amount (Expected)";
                  TotalSalesAmountActual += "Item Ledger Entry"."Sales Amount (Actual)";

                  MakeExcelDataBody;

                  PrevSourceNo := "Item Ledger Entry"."Source No.";
                END;
                //<< NF1.00:CIS.SP 09-09-15
            end;

            trigger OnPostDataItem()
            begin
                //>> NF1.00:CIS.SP 09-09-15
                IF ExportToExcel THEN BEGIN
                  MakeExcelDataGroupTotals;
                  MakeExcelDataGrandTotals;
                END;
                //<< NF1.00:CIS.SP 09-09-15

                Window.CLOSE;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Item No.");

                Window.OPEN('Reading Customer #1#############');

                //>> NF1.00:CIS.SP 09-09-15
                CountItemLedgerEntry := 0;
                PrevSourceNo := '';
                //<< NF1.00:CIS.SP 09-09-15
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    field("Export to Excel";ExportToExcel)
                    {
                        Caption = 'Export to Excel';
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
        Received_Not_Invoiced_by_LotCaption = 'Shipped Not Invoiced by Lot';
        CurrReport_PAGENOCaption = 'Page';
        Net_Sales_AmountCaption = 'Net Sales Amount';
        Net_Qty_Caption = 'Net Qty.';
        OrderNoCaption = 'Order No.';
        VesselNameCaption = 'Vessel';
    }

    trigger OnPostReport()
    begin
        //>> NF1.00:CIS.SP 09-09-15
        IF ExportToExcel THEN
          CreateExcelbook;
        //<< NF1.00:CIS.SP 09-09-15
    end;

    trigger OnPreReport()
    begin
        FilterText := "Item Ledger Entry".GETFILTERS;

        GLSetup.GET;
        IF Dimension.GET(GLSetup."Global Dimension 1 Code") THEN
          Dim1Text := Dimension."Code Caption";

        IF ExportToExcel THEN BEGIN
          ExcelBuf.DELETEALL;
          MainTitle := 'Shipped Not Invoiced by Lot';

          MakeExcelInfo; //NF1.00:CIS.SP 09-09-15
        END;

        //>> NF1.00:CIS.SP 09-09-15
        GrandTotalSalesAmountExpected := 0;
        GrandTotalSalesAmountActual := 0;
        TotalSalesAmountExpected := 0;
        TotalSalesAmountActual := 0;
        //<< NF1.00:CIS.SP 09-09-15
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Cust: Record "18";
        Item: Record "27";
        Window: Dialog;
        SalesShptHdr: Record "110";
        OrderNo: Code[20];
        FilterText: Text[250];
        Dim1Text: Text[30];
        GLSetup: Record "98";
        Dimension: Record "348";
        "<<Excel>>": Integer;
        d: Dialog;
        ExcelBuf: Record "370" temporary;
        RowNo: Integer;
        ColumnNo: Integer;
        ExportToExcel: Boolean;
        MainTitle: Text[100];
        SubTitle: Text[100];
        Text005: Label 'Company Name';
        Text006: Label 'Report No.';
        Text007: Label 'Report Name';
        Text008: Label 'User ID';
        Text009: Label 'Date';
        Text010: Label 'Filters';
        Text011: Label 'Shipped Not Invoiced by Lot';
        Text012: Label 'Main Title';
        Text013: Label 'Sub Title';
        Text014: Label 'Vendor No.';
        Text015: Label 'Vendor Name';
        Text016: Label 'Item No.';
        Text017: Label 'Posting Date';
        Text018: Label 'Document No.';
        Text020: Label 'Location Code';
        Text022: Label 'Lot No.';
        Text023: Label 'Order No.';
        Text024: Label 'Quantity';
        Text025: Label 'Invoiced Qty.';
        Text026: Label 'Sales (Expected)';
        Text027: Label 'Sales (Actual)';
        Text028: Label 'Net Sales Amount';
        Text029: Label 'Net Qty';
        Text030: Label 'Totals: ';
        Text031: Label 'Grand Totals';
        TotalSalesAmountExpected: Decimal;
        TotalSalesAmountActual: Decimal;
        GrandTotalSalesAmountExpected: Decimal;
        GrandTotalSalesAmountActual: Decimal;
        PrevSourceNo: Code[20];
        CountItemLedgerEntry: Integer;

    local procedure MakeExcelInfo()
    begin
        //>> NF1.00:CIS.SP 09-09-15
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(FORMAT(Text005),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(COMPANYNAME,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text006),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(REPORT::"Shipped Not Invoiced by Lot",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text007),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FORMAT(Text011),FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text008),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(USERID,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text009),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(TODAY,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text012),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(MainTitle,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text013),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(SubTitle,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text010),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FilterText,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
        //<< NF1.00:CIS.SP 09-09-15
    end;

    local procedure MakeExcelDataHeader()
    begin
        //>> NF1.00:CIS.SP 09-09-15
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Text014,FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Text015,FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Text016,FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Text017,FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Text018,FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Text020,FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Dim1Text,FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Text022,FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Text023,FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Text024,FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Text025,FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Text026,FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Text027,FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Text028,FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Text029,FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
        //<< NF1.00:CIS.SP 09-09-15
    end;

    local procedure MakeExcelDataBody()
    begin
        //>> NF1.00:CIS.SP 09-09-15
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn("Item Ledger Entry"."Source No.",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Cust.Name,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Item Ledger Entry"."Item No.",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Item Ledger Entry"."Posting Date",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddColumn("Item Ledger Entry"."Document No.",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Item Ledger Entry"."Location Code",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Item Ledger Entry"."Global Dimension 1 Code",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Item Ledger Entry"."Lot No.",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(OrderNo,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Item Ledger Entry".Quantity,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn("Item Ledger Entry"."Invoiced Quantity",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn("Item Ledger Entry"."Sales Amount (Expected)",FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn("Item Ledger Entry"."Sales Amount (Actual)",FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn("Item Ledger Entry"."Sales Amount (Expected)" - "Item Ledger Entry"."Sales Amount (Actual)",FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn("Item Ledger Entry".Quantity - "Item Ledger Entry"."Invoiced Quantity",FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);
        //<< NF1.00:CIS.SP 09-09-15
    end;

    local procedure MakeExcelDataGroupTotals()
    begin
        //>> NF1.00:CIS.SP 09-09-15
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Text030 + PrevSourceNo,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Cust.Name,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddColumn(TotalSalesAmountExpected,FALSE,'',TRUE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(TotalSalesAmountActual,FALSE,'',TRUE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(TotalSalesAmountExpected - TotalSalesAmountActual,FALSE,'',TRUE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);

        GrandTotalSalesAmountExpected += TotalSalesAmountExpected;
        GrandTotalSalesAmountActual += TotalSalesAmountActual;
        TotalSalesAmountExpected := 0;
        TotalSalesAmountActual := 0;
        //<< NF1.00:CIS.SP 09-09-15
    end;

    local procedure MakeExcelDataGrandTotals()
    begin
        //>> NF1.00:CIS.SP 09-09-15
        ExcelBuf.NewRow;
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Text031,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddColumn(GrandTotalSalesAmountExpected,FALSE,'',TRUE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(GrandTotalSalesAmountActual,FALSE,'',TRUE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(GrandTotalSalesAmountExpected - TotalSalesAmountActual,FALSE,'',TRUE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);
        //<< NF1.00:CIS.SP 09-09-15
    end;

    local procedure CreateExcelbook()
    begin
        //>> NF1.00:CIS.SP 09-09-15
        ExcelBuf.CreateBookAndOpenExcel(MainTitle,MainTitle,COMPANYNAME,USERID);
        ERROR('');
        //<< NF1.00:CIS.SP 09-09-15
    end;
}

