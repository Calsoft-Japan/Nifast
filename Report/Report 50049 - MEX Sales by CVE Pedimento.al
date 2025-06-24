report 50049 "MEX Sales by CVE Pedimento"
{
    // NF1.00:CIS.NG  09-09-15 Merged during upgrade
    // CurrReport.SHOWOUTPUT(PrintDetail);
    DefaultLayout = RDLC;
    RDLCLayout = '.\RDLC\MEX Sales by CVE Pedimento.rdlc';


    dataset
    {
        dataitem(CVELoop; Integer)
        {
            DataItemTableView = SORTING(Number);
            PrintOnlyIfDetail = true;
            column(TIME; TIME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(USERID; USERID)
            {
            }
            column(FilterText; FilterText)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(SalesAmountText; SalesAmountText)
            {
            }
            column(TempCVEPedimento_Description; TempCVEPedimento.Description)
            {
            }
            column(TempCVEPedimento_Code; TempCVEPedimento.Code)
            {
            }
            column(SalesAmount; SalesAmount)
            {
            }
            column(Total_; 'Total')
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Sales_by_CVE_PedimentoCaption; Sales_by_CVE_PedimentoCaptionLbl)
            {
            }
            column(HS_CodeCaption; HS_CodeCaptionLbl)
            {
            }
            column(HS_DescriptionCaption; HS_DescriptionCaptionLbl)
            {
            }
            column(CVELoop_Number; Number)
            {
            }
            column(PrintDetail; PrintDetail)
            {
            }
            dataitem(Item; Item)
            {
                DataItemTableView = SORTING("No.");
                PrintOnlyIfDetail = true;
                column(SalesAmountText_Control1000000010; SalesAmountText)
                {
                }
                column(SalesAmount_Control1102623008; SalesAmount)
                {
                }
                column(TempCVEPedimento_Description_Control1102623010; TempCVEPedimento.Description)
                {
                }
                column(TempCVEPedimento_Code_Control1102623012; TempCVEPedimento.Code)
                {
                }
                column(TempCVEPedimento_Description___Totals_; TempCVEPedimento.Description + ' Totals')
                {
                }
                column(Item_DescriptionCaption; Item_DescriptionCaptionLbl)
                {
                }
                column(Item_No_Caption; Item_No_CaptionLbl)
                {
                }
                column(Item_No_; "No.")
                {
                }
                dataitem("Item Ledger Entry"; "Item Ledger Entry")
                {
                    DataItemLink = "Item No." = FIELD("No.");
                    DataItemTableView = SORTING("Item No.", "Variant Code", "Drop Shipment", "Location Code", "Posting Date")//, "QC Hold" BC Upgrade
                                        WHERE("Entry Type" = FILTER(Sale),
                                              "Sales Amount (Actual)" = FILTER(<> 0));
                    RequestFilterFields = "Item No.", "Posting Date", "CVE Pedimento", "Source No.";
                    column(Item__No__; Item."No.")
                    {
                    }
                    column(Item_Description; Item.Description)
                    {
                    }
                    column(Item_Ledger_Entry_Entry_No_; "Entry No.")
                    {
                    }
                    column(Item_Ledger_Entry_Item_No_; "Item No.")
                    {
                    }
                    column(Item_Ledger_Entry_Sales_Amt_Actual; "Item Ledger Entry"."Sales Amount (Actual)")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        "Item Ledger Entry".CALCFIELDS("Sales Amount (Actual)");
                        SalesAmount := "Item Ledger Entry"."Sales Amount (Actual)";
                    end;

                    trigger OnPreDataItem()
                    begin
                        CurrReport.CREATETOTALS(SalesAmount);
                        "Item Ledger Entry".SETRANGE("CVE Pedimento", TempCVEPedimento.Code);
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    d.UPDATE(2, Item."No.");
                end;

                trigger OnPreDataItem()
                begin
                    CurrReport.CREATETOTALS(SalesAmount);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF Number = 1 THEN
                    TempCVEPedimento.FIND('-')
                ELSE
                    TempCVEPedimento.NEXT;
                d.UPDATE(1, TempCVEPedimento.Code);
            end;

            trigger OnPreDataItem()
            begin

                SETRANGE(Number, 1, TempCVEPedimento.COUNT);
                d.OPEN('Now reading #1### #2#########');
                CurrReport.CREATETOTALS(SalesAmount);
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
                    field(PrintDetail; PrintDetail)
                    {
                        Caption = 'Print Detail';
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
        FilterText := "Item Ledger Entry".GETFILTERS;

        IF CVEPedimento.FIND('-') THEN
            REPEAT
                TempCVEPedimento.INIT;
                TempCVEPedimento.TRANSFERFIELDS(CVEPedimento);
                TempCVEPedimento.INSERT;
            UNTIL CVEPedimento.NEXT = 0;

        TempCVEPedimento.INIT;
        TempCVEPedimento.Code := '';
        TempCVEPedimento.Description := '<No Code>';
        IF NOT TempCVEPedimento.INSERT THEN;

        CompanyInformation.GET;

        GLSetup.GET;
        SalesAmountText := 'Sales (' + GLSetup."LCY Code" + ')';
    end;

    var
        TempCVEPedimento: Record "CVE Pedimento" temporary;
        CVEPedimento: Record "CVE Pedimento";
        FilterText: Text[250];
        CompanyInformation: Record "Company Information";
        PrintDetail: Boolean;
        d: Dialog;
        SalesAmount: Decimal;
        SalesAmountText: Text[30];
        GLSetup: Record "General Ledger Setup";
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Sales_by_CVE_PedimentoCaptionLbl: Label 'Sales by CVE Pedimento';
        HS_CodeCaptionLbl: Label 'HS Code';
        HS_DescriptionCaptionLbl: Label 'HS Description';
        Item_DescriptionCaptionLbl: Label 'Item Description';
        Item_No_CaptionLbl: Label 'Item No.';
}

