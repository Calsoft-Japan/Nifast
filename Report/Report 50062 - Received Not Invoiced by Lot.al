report 50062 "Received Not Invoiced by Lot"
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
    RDLCLayout = './Received Not Invoiced by Lot.rdlc';

    Caption = 'Received Not Invoiced by Lot';

    dataset
    {
        dataitem(DataItem7209;Table32)
        {
            DataItemTableView = SORTING(Source Type,Source No.,Entry Type,Item No.,Variant Code,Posting Date)
                                WHERE(Source Type=FILTER(Vendor),
                                      Entry Type=FILTER(Purchase));
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
            column(Vendor______Source_No_____________Vend_Name;'Vendor ' + "Source No." + ' - ' + Vend.Name)
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
            column(Item_Ledger_Entry__Cost_Amount__Expected__;"Cost Amount (Expected)")
            {
            }
            column(Item_Ledger_Entry__Cost_Amount__Actual__;"Cost Amount (Actual)")
            {
            }
            column(Item_Ledger_Entry__Lot_No__;"Lot No.")
            {
            }
            column(Cost_Amount__Expected______Cost_Amount__Actual__;"Cost Amount (Expected)" - "Cost Amount (Actual)")
            {
            }
            column(OrderNo;OrderNo)
            {
            }
            column(Item_Ledger_Entry__Item_No__;"Item No.")
            {
            }
            column(NetQuantity;NetQuantity)
            {
            }
            column(Item_Ledger_Entry__Global_Dimension_1_Code_;"Global Dimension 1 Code")
            {
            }
            column(VesselName;VesselName)
            {
            }
            column(Totals__Vendor______Source_No_____________Vend_Name;'Totals: Vendor ' + "Source No." + ' - ' + Vend.Name)
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
            column(Item_Ledger_Entry__Cost_Amount__Expected__Caption;FIELDCAPTION("Cost Amount (Expected)"))
            {
            }
            column(Item_Ledger_Entry__Cost_Amount__Actual__Caption;FIELDCAPTION("Cost Amount (Actual)"))
            {
            }
            column(Item_Ledger_Entry__Lot_No__Caption;FIELDCAPTION("Lot No."))
            {
            }
            column(Item_Ledger_Entry__Item_No__Caption;FIELDCAPTION("Item No."))
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
            column(Cost_Amount_Expected_ACY;"Cost Amount (Expected) (ACY)")
            {
            }
            column(Cost_Amount_Actual_ACY;"Cost Amount (Actual) (ACY)")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Window.UPDATE(1,"Source No.");

                //>>IST 082608 CCL $13051 #13051
                //IF "Item Ledger Entry".Quantity="Item Ledger Entry"."Invoiced Quantity" THEN
                //  CurrReport.SKIP;

                CLEAR(ShowAppliesToEntry);
                CLEAR(ILE);
                CLEAR(NetQuantity);

                IF "Item Ledger Entry"."Applies-to Entry" <> 0 THEN BEGIN
                  ILE.GET("Item Ledger Entry"."Applies-to Entry");
                  IF NOT (ILE.Quantity=ILE."Invoiced Quantity") THEN
                    ShowAppliesToEntry := TRUE;
                  NetQuantity := -"Invoiced Quantity";
                END ELSE
                  NetQuantity := Quantity - "Invoiced Quantity";

                IF ("Item Ledger Entry".Quantity="Item Ledger Entry"."Invoiced Quantity") AND (NOT ShowAppliesToEntry) THEN
                      CurrReport.SKIP;
                //<<IST 082608 CCL $13051 #13051

                IF NOT Item.GET("Item No.") THEN
                  CLEAR(Item);


                IF NOT PurchRcptHdr.GET("Document No.") THEN BEGIN
                 CLEAR(OrderNo);
                 CLEAR(VesselName);
                END ELSE BEGIN
                 OrderNo := PurchRcptHdr."Order No.";
                 VesselName := PurchRcptHdr."Vessel Name";
                END;

                IF NOT FooterPrinted THEN
                  LastFieldNo := CurrReport.TOTALSCAUSEDBY;
                CurrReport.SHOWOUTPUT := NOT FooterPrinted;
                FooterPrinted := TRUE;

                IF NOT Vend.GET("Source No.") THEN
                  CLEAR(Vend);

                //>> NF1.00:CIS.SP 09-09-15
                IF ExportToExcel THEN BEGIN
                  "Item Ledger Entry".CALCFIELDS("Cost Amount (Expected)","Cost Amount (Actual)","Cost Amount (Expected) (ACY)","Cost Amount (Actual) (ACY)");
                  CountItemLedgerEntry += 1;

                  IF (PrevSourceNo <> "Item Ledger Entry"."Source No.") AND ((TotalCostAmountExpected - TotalCostAmountActual) <> 0) AND ((TotalCostAmountExpectedACY - TotalCostAmountActualACY) <> 0) AND (CountItemLedgerEntry > 1) THEN BEGIN
                    MakeExcelDataGroupTotals;
                    ExcelBuf.NewRow;
                  END;

                  TotalCostAmountExpected += "Item Ledger Entry"."Cost Amount (Expected)";
                  TotalCostAmountActual += "Item Ledger Entry"."Cost Amount (Actual)";

                  //SM 001
                  TotalCostAmountExpectedACY += "Item Ledger Entry"."Cost Amount (Expected) (ACY)";
                  TotalCostAmountActualACY += "Item Ledger Entry"."Cost Amount (Actual) (ACY)";
                  //SM 001

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

                Window.OPEN('Reading Vendor #1#############');

                //>> NF1.00:CIS.SP 09-09-15
                CountItemLedgerEntry := 0;
                PrevSourceNo := '';
                //<< NF1.00:CIS.SP 09-09-15
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
        Received_Not_Invoiced_by_LotCaption = 'Received Not Invoiced by Lot';
        CurrReport_PAGENOCaption = 'Page';
        Net_Cost_AmountCaption = 'Net Cost Amount';
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
          MainTitle := 'Received Not Invoiced by Lot';

          MakeExcelInfo; //NF1.00:CIS.SP 09-09-15
        END;

        //>> NF1.00:CIS.SP 09-09-15
        GrandTotalCostAmountExpected := 0;
        GrandTotalCostAmountActual := 0;
        TotalCostAmountExpected := 0;
        TotalCostAmountActual := 0;

        //SM 001 1/18/18
        GrandTotalCostAmountExpectedACY := 0;
        GrandTotalCostAmountActualACY := 0;
        TotalCostAmountExpectedACY := 0;
        TotalCostAmountActualACY := 0;
        //SM 001 1/18/18


        //<< NF1.00:CIS.SP 09-09-15
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Vend: Record "23";
        Item: Record "27";
        Window: Dialog;
        PurchRcptHdr: Record "120";
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
        VesselName: Text[50];
        "<<NIF>>": Integer;
        ILE: Record "32";
        ShowAppliesToEntry: Boolean;
        NetQuantity: Decimal;
        Text005: Label 'Company Name';
        Text006: Label 'Report No.';
        Text007: Label 'Report Name';
        Text008: Label 'User ID';
        Text009: Label 'Date';
        Text010: Label 'Filters';
        Text011: Label 'Received Not Invoiced by Lot';
        Text012: Label 'Main Title';
        Text013: Label 'Sub Title';
        Text014: Label 'Vendor No.';
        Text015: Label 'Vendor Name';
        Text016: Label 'Item No.';
        Text017: Label 'Posting Date';
        Text018: Label 'Document No.';
        Text019: Label 'Vessel';
        Text020: Label 'Location Code';
        Text022: Label 'Lot No.';
        Text023: Label 'Order No.';
        Text024: Label 'Quantity';
        Text025: Label 'Invoiced Qty.';
        Text026: Label 'Cost (Expected)';
        Text027: Label 'Cost (Actual)';
        Text028: Label 'Net Cost Amount';
        Text029: Label 'Net Qty';
        Text030: Label 'Totals: ';
        TotalCostAmountExpected: Decimal;
        TotalCostAmountActual: Decimal;
        GrandTotalCostAmountExpected: Decimal;
        GrandTotalCostAmountActual: Decimal;
        PrevSourceNo: Code[20];
        CountItemLedgerEntry: Integer;
        Text031: Label 'Grand Totals';
        TotalCostAmountExpectedACY: Decimal;
        TotalCostAmountActualACY: Decimal;
        GrandTotalCostAmountExpectedACY: Decimal;
        GrandTotalCostAmountActualACY: Decimal;

    local procedure MakeExcelInfo()
    begin
        //>> NF1.00:CIS.SP 09-09-15
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(FORMAT(Text005),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(COMPANYNAME,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text006),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(REPORT::"Received Not Invoiced by Lot",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
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
        //ExcelBuf.AddColumn(Text019,FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Text020,FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Dim1Text,FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Text022,FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Text023,FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Text024,FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Text025,FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn('Cost Amt. Expected ARC',FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Text026,FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn('Cost Amt. Actual ARC',FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
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
        ExcelBuf.AddColumn(Vend.Name,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Item Ledger Entry"."Item No.",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Item Ledger Entry"."Posting Date",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddColumn("Item Ledger Entry"."Document No.",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn(VesselName,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Item Ledger Entry"."Location Code",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Item Ledger Entry"."Global Dimension 1 Code",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Item Ledger Entry"."Lot No.",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(OrderNo,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Item Ledger Entry".Quantity,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn("Item Ledger Entry"."Invoiced Quantity",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);

        ExcelBuf.AddColumn("Item Ledger Entry"."Cost Amount (Expected) (ACY)",FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn("Item Ledger Entry"."Cost Amount (Expected)",FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);

        ExcelBuf.AddColumn("Item Ledger Entry"."Cost Amount (Actual) (ACY)",FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn("Item Ledger Entry"."Cost Amount (Actual)",FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);

        ExcelBuf.AddColumn("Item Ledger Entry"."Cost Amount (Expected)" - "Item Ledger Entry"."Cost Amount (Actual)",FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn("Item Ledger Entry".Quantity - "Item Ledger Entry"."Invoiced Quantity",FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);
        //<< NF1.00:CIS.SP 09-09-15
    end;

    local procedure MakeExcelDataGroupTotals()
    begin
        //>> NF1.00:CIS.SP 09-09-15
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Text030 + PrevSourceNo,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Vend.Name,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddColumn(TotalCostAmountExpectedACY,FALSE,'',TRUE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(TotalCostAmountExpected,FALSE,'',TRUE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(TotalCostAmountActualACY,FALSE,'',TRUE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(TotalCostAmountActual,FALSE,'',TRUE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(TotalCostAmountExpected - TotalCostAmountActual,FALSE,'',TRUE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);

        GrandTotalCostAmountExpected += TotalCostAmountExpected;
        GrandTotalCostAmountActual += TotalCostAmountActual;
        TotalCostAmountExpected := 0;
        TotalCostAmountActual := 0;

        GrandTotalCostAmountExpectedACY += TotalCostAmountExpectedACY;
        GrandTotalCostAmountActualACY += TotalCostAmountActualACY;
        TotalCostAmountExpectedACY := 0;
        TotalCostAmountActualACY := 0;


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
        ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddColumn(GrandTotalCostAmountExpectedACY,FALSE,'',TRUE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(GrandTotalCostAmountExpected,FALSE,'',TRUE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(GrandTotalCostAmountActualACY,FALSE,'',TRUE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(GrandTotalCostAmountActual,FALSE,'',TRUE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(GrandTotalCostAmountExpected - GrandTotalCostAmountActual,FALSE,'',TRUE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);
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

