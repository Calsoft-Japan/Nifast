report 50078 "On Time Delivery"
{
    // NF1.00:CIS.NG  08-05-16 Create New Report as we have in NAV 09 R2
    // NF2.00:CIS.RAM 02/14/17 Fixed the Recpt Line DataItemLink Value
    DefaultLayout = RDLC;
    RDLCLayout = '.\RDLC\On Time Delivery.rdlc';


    dataset
    {
        dataitem(Vendor; Vendor)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(TODAY; FORMAT(TODAY))
            {
            }
            column(No_Vendor; Vendor."No.")
            {
            }
            column(Name_Vendor; Vendor.Name)
            {
            }
            dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
            {
                DataItemLink = "Pay-to Vendor No." = FIELD("No.");
                DataItemTableView = SORTING("No.");
                RequestFilterFields = "Location Code", "Posting Date";
                RequestFilterHeading = 'Receiving';
                column(OrderNo_PurchRcptHeader; "Purch. Rcpt. Header"."Order No.")
                {
                }
                column(No_PurchRcptHeader; "Purch. Rcpt. Header"."No.")
                {
                }
                dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemTableView = SORTING("Document No.", "Line No.")
                                        WHERE(Type = CONST(Item),
                                              Quantity = FILTER(<> 0));
                    column(Quantity_PurchRcptLine; "Purch. Rcpt. Line".Quantity)
                    {
                    }
                    column(No_PurchRcptLine; "Purch. Rcpt. Line"."No.")
                    {
                    }
                    column(ExpectedReceiptDate_PurchRcptLine; FORMAT("Purch. Rcpt. Line"."Expected Receipt Date"))
                    {
                    }
                    column(PostingDate_PurchRcptLine; FORMAT("Purch. Rcpt. Header"."Posting Date"))
                    {
                    }
                    column(Dif; Dif)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        Dif := "Expected Receipt Date" - "Purch. Rcpt. Header"."Posting Date";
                        IF ExportToExcel THEN
                            MakeExcelDataBody;
                    end;

                    trigger OnPreDataItem()
                    begin
                        ExcelBuf.NewRow;
                        ExcelBuf.AddColumn(Vendor."No.", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn(Vendor.Name, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                        ExcelBuf.NewRow;
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn("Purch. Rcpt. Header"."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn("Purch. Rcpt. Header"."Order No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                        ExcelBuf.NewRow;
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('Quantity', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('Expected', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('Actual Rec.', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('Diff. (Negative means DELAY)', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    end;
                }
            }

            trigger OnAfterGetRecord()
            begin
                "Purch. Rcpt. Header".RESET;
                "Purch. Rcpt. Line".RESET;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Option)
                {
                    Caption = 'Option';
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
        QuantityCaptionLbl = 'Quantity';
        ExpectedCaptionLbl = 'Expected';
        ActualRecCaptionLbl = 'Actual Rec.';
        DiffNegativemeansDELAYCaptionLbl = 'Diff. (Negative means DELAY)';
        OnTimeDeliveryReportCaptionLbl = 'On-Time Delivery Report';
    }

    trigger OnPostReport()
    begin
        IF ExportToExcel THEN
            CreateExcelbook;
    end;

    trigger OnPreReport()
    begin
        IF ExportToExcel THEN
            MakeExcelInfo;
    end;

    var
        Dif: Integer;
        DateFilter: Text[250];
        ExcelBuf: Record "Excel Buffer" temporary;
        ExportToExcel: Boolean;
        Text011: Label 'Data';
        Text012: Label 'On Time Del.';
        Text013: Label 'Company Name';
        Text014: Label 'Report No.';
        Text015: Label 'Report Name';
        Text016: Label 'User ID';
        Text017: Label 'Date';

    procedure MakeExcelInfo()
    begin
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(FORMAT(Text013), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(COMPANYNAME, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text015), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FORMAT(Text012), FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text014), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(REPORT::"On Time Delivery", FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text016), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(USERID, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text017), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(TODAY, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
    end;

    local procedure MakeExcelDataHeader()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('On Time Delivery', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(FORMAT(TODAY), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
    end;

    procedure MakeExcelDataBody()
    var
        SalesInvoiceHeader_lRec: Record "Sales Invoice Header";
        SalesCrMemoHeader_lRec: Record "Sales Cr.Memo Header";
        ServiceInvoiceHeader_lRec: Record "Service Invoice Header";
        ServiceCrMemoHeader_lRec: Record "Service Cr.Memo Header";
        CurrFactor_lDec: Decimal;
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Purch. Rcpt. Line"."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Purch. Rcpt. Line".Quantity, FALSE, '', FALSE, FALSE, FALSE, '#,##0', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(FORMAT("Purch. Rcpt. Line"."Expected Receipt Date"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddColumn(FORMAT("Purch. Rcpt. Header"."Posting Date"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddColumn(Dif, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.NewRow;
    end;

    procedure CreateExcelbook()
    begin
        //ExcelBuf.CreateBookAndOpenExcel(Text012, Text011, COMPANYNAME, USERID); BC Upgrade
        ExcelBuf.CreateNewBook(Text012);
        ExcelBuf.WriteSheet(Text011, COMPANYNAME, USERID);
        ExcelBuf.CloseBook();
        ExcelBuf.OpenExcel();
        ERROR('');
    end;
}

