report 50081 "Blocked Items"
{
    // NF1.00:CIS.NU  09-15-15 Merged during upgrade
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = '.\RDLC\Blocked Items.rdlc';


    dataset
    {
        dataitem("Lot No. Information"; "Lot No. Information")
        {
            DataItemTableView = SORTING("Item No.", "Mfg. Lot No.")
                                WHERE(Blocked = const(true),//FILTER(Yes) BC Upgrade
                                      Inventory = FILTER(> 0));
            RequestFilterFields = "Item No.";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; 1)//CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(Lot_No__Information__Lot_No__Information__Inventory; "Lot No. Information".Inventory)
            {
                DecimalPlaces = 0 : 0;
            }
            column(Lot_No__Information__Lot_No__Information___Mfg__Lot_No__; "Lot No. Information"."Mfg. Lot No.")
            {
            }
            column(Lot_No__Information__Lot_No__Information___Lot_Creation_Date_; "Lot No. Information"."Lot Creation Date")
            {
            }
            column(Lot_No__Information__Lot_No__Information__Blocked; "Lot No. Information".Blocked)
            {
            }
            column(Lot_No__Information__Lot_No__Information___Lot_No__; "Lot No. Information"."Lot No.")
            {
            }
            column(Lot_No__Information__Lot_No__Information___Item_No__; "Lot No. Information"."Item No.")
            {
            }
            column(Lot_No__Information__Lot_No__Information___Inspection_Comments_; "Lot No. Information"."Inspection Comments")
            {
            }
            column(Value_Entry___Cost_Amount__Actual__; "Value Entry"."Cost Amount (Actual)")
            {
            }
            column(Blocked_ItemsCaption; Blocked_ItemsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Item_No_Caption; Item_No_CaptionLbl)
            {
            }
            column(Div_Caption; Div_CaptionLbl)
            {
            }
            column(Lot_No_Caption; Lot_No_CaptionLbl)
            {
            }
            column(BlockedCaption; BlockedCaptionLbl)
            {
            }
            column(Creation_DateCaption; Creation_DateCaptionLbl)
            {
            }
            column(Mfg__Lot_No_Caption; Mfg__Lot_No_CaptionLbl)
            {
            }
            column(Inspection_CommentsCaption; Inspection_CommentsCaptionLbl)
            {
            }
            column(CostCaption; CostCaptionLbl)
            {
            }
            column(ValueCaption; ValueCaptionLbl)
            {
            }
            column(InventoryCaption; InventoryCaptionLbl)
            {
            }
            column(Lot_No__Information_Variant_Code; "Variant Code")
            {
            }
            column(FilterString; FilterString)
            {
            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Item No." = FIELD("Item No."),
                               "Lot No." = FIELD("Lot No.");
                DataItemTableView = SORTING("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date", "Expiration Date", "Lot No.", "Serial No.");//, "QC Hold"); BC Upgrade
                column(Item_Ledger_Entry__Global_Dimension_1_Code_; "Global Dimension 1 Code")
                {
                }
                column(Item_Ledger_Entry_Entry_No_; "Entry No.")
                {
                }
                column(Item_Ledger_Entry_Item_No_; "Item No.")
                {
                }
                column(Item_Ledger_Entry_Lot_No_; "Lot No.")
                {
                }
                dataitem("Value Entry"; "Value Entry")
                {
                    DataItemLink = "Item Ledger Entry No." = FIELD("Entry No.");
                    DataItemTableView = SORTING("Item No.", "Item Ledger Entry Type", "Posting Date", "Location Code", "Source No.");
                    column(Value_Entry__Cost_Amount__Actual__; "Cost Amount (Actual)")
                    {
                    }
                    column(Value_Entry_Entry_No_; "Entry No.")
                    {
                    }
                    column(Value_Entry_Item_Ledger_Entry_No_; "Item Ledger Entry No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        TotalCostValueEntry += "Cost Amount (Actual)";  // NF1.00:CIS.NU 09-15-15
                    end;

                    trigger OnPostDataItem()
                    begin
                        CLEAR("Cost per Unit");

                        //>> NF1.00:CIS.NU 09-15-15
                        IF TotalCostValueEntry <> 0 THEN BEGIN
                            ExcelBuf.NewRow;
                            ExcelBuf.AddColumn("Item Ledger Entry"."Global Dimension 1 Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
                            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                            ExcelBuf.AddColumn(TotalCostValueEntry, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                            ExcelBuf.NewRow;
                        END;
                        //<< NF1.00:CIS.NU 09-15-15
                    end;

                    trigger OnPreDataItem()
                    begin
                        //IF "Item Ledger Entry".Quantity>0 THEN BEGIN
                        //Cost:="Value Entry"."Cost Amount (Actual)";
                        //Cost:="Lot No."

                        //END;
                        //CurrReport.CREATETOTALS("Cost Amount (Actual)");BC Upgrade


                        // Cost:="Value Entry"."Cost per Unit";
                        TotalCostValueEntry := 0;  // NF1.00:CIS.NU 09-15-15
                    end;
                }

                trigger OnPostDataItem()
                begin
                    Cost := "Value Entry"."Cost per Unit";
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Div1 := "Item Ledger Entry"."Global Dimension 1 Code";
                //>> NF1.00:CIS.NU 09-15-15
                IF ExportToExcel THEN
                    MakeExcelDataBody;
                //<< NF1.00:CIS.NU 09-15-15
            end;

            trigger OnPostDataItem()
            begin
                //>> NF1.00:CIS.NU 09-15-15
                IF ExportToExcel THEN
                    CreateExcelWorkBook;
                //<< NF1.00:CIS.NU 09-15-15
            end;

            trigger OnPreDataItem()
            begin
                //CLEAR ("Value Entry"."Cost per Unit");

                LastFieldNo := FIELDNO("Item No.");
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
                    Caption = 'Options';
                    field(ExportToExcel; ExportToExcel)
                    {
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
    }

    trigger OnPreReport()
    begin
        MainTitle := 'Blocked Items Report';
        //>> NF1.00:CIS.NU 09-15-15
        FilterString := "Lot No. Information".GETFILTERS;
        IF ExportToExcel THEN
            MakeExcelDataInfo;
        //<< NF1.00:CIS.NU 09-15-15
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        ExcelBuf: Record "Excel Buffer" temporary;
        ExportToExcel: Boolean;
        MainTitle: Text[30];
        Cost: Decimal;
        Div1: Code[10];
        Blocked_ItemsCaptionLbl: Label 'Blocked Items';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Item_No_CaptionLbl: Label 'Item No.';
        Div_CaptionLbl: Label 'Div.';
        Lot_No_CaptionLbl: Label 'Lot No.';
        BlockedCaptionLbl: Label 'Blocked';
        Creation_DateCaptionLbl: Label 'Creation Date';
        Mfg__Lot_No_CaptionLbl: Label 'Mfg. Lot No.';
        Inspection_CommentsCaptionLbl: Label 'Inspection Comments';
        CostCaptionLbl: Label 'Cost';
        ValueCaptionLbl: Label 'Value';
        InventoryCaptionLbl: Label 'Inventory';
        Text50000: Label 'Company Name';
        Text50001: Label 'Report No.';
        Text50002: Label 'Report Name';
        Text50003: Label 'User';
        Text50004: Label 'Date/Time';
        Text50005: Label 'Filters';
        FilterString: Text;
        Text50006: Label 'Active (Yes or No)';
        Text50007: Label 'Current Diposition Status';
        TotalCostValueEntry: Decimal;

    local procedure MakeExcelDataInfo()
    begin
        //>> NF1.00:CIS.NU 09-15-15
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(FORMAT(Text50000), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(COMPANYNAME, FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text50001), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(REPORT::"Blocked Items", FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text50002), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(Blocked_ItemsCaptionLbl, FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text50003), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(USERID, FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text50004), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(TODAY, FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(TIME, FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text50005), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FilterString, FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
        //<< NF1.00:CIS.NU 09-15-15
    end;

    local procedure MakeExcelDataHeader()
    begin
        //>> NF1.00:CIS.NU 09-15-15
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Div_CaptionLbl, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Lot No. Information".FIELDCAPTION("Item No."), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Lot No. Information".FIELDCAPTION("Lot No."), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Lot No. Information".FIELDCAPTION(Blocked), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Lot No. Information".FIELDCAPTION("Lot Creation Date"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Lot No. Information".FIELDCAPTION("Mfg. Lot No."), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Lot No. Information".FIELDCAPTION(Inventory), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(CostCaptionLbl, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ValueCaptionLbl, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Text50006, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Text50007, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Lot No. Information".FIELDCAPTION("Inspection Comments"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        //<< NF1.00:CIS.NU 09-15-15
    end;

    local procedure MakeExcelDataBody()
    begin
        //>> NF1.00:CIS.NU 09-15-15
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn("Item Ledger Entry"."Global Dimension 1 Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Lot No. Information"."Item No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Lot No. Information"."Lot No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Lot No. Information".Blocked, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Lot No. Information"."Lot Creation Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddColumn("Lot No. Information"."Mfg. Lot No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Lot No. Information".Inventory, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Lot No. Information"."Inspection Comments", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        //<< NF1.00:CIS.NU 09-15-15
    end;

    local procedure CreateExcelWorkBook()
    begin
        //>> NF1.00:CIS.NU 09-15-15
        // ExcelBuf.CreateBookAndOpenExcel(Text50000, Text50002, COMPANYNAME, USERID); BC Upgrade
        ExcelBuf.CreateNewBook(Text50000);
        ExcelBuf.WriteSheet(Text50002, COMPANYNAME, USERID);
        ExcelBuf.CloseBook();
        ExcelBuf.OpenExcel();
        ERROR('');
        //<< NF1.00:CIS.NU 09-15-15
    end;
}

