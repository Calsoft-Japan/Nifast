report 50071 "Receiving Report"
{
    // NF1.00:CIS.CM  09-09-15 Merged during upgrade
    // NF1.00:CIS.NG  07-25-16 Update Report to show MFG Lot No. in Report
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = '.\RDLC\Receiving Report.rdlc';

    Caption = 'Receiving Report';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {
            RequestFilterFields = "No.", "Order No.", "Buy-from Vendor No.", "Posting Date";
            column(EmptyString; '')
            {
            }
            column(EmptyString_Control1000000019; '')
            {
            }
            column(USERID; USERID)
            {
            }
            column(CurrReport_PAGENO; 1)//CurrReport.PAGENO)
            {
            }
            column(TIME; TIME)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(Buy_from_Vendor_No_____________Buy_from_Vendor_Name_; "Buy-from Vendor No." + ' - ' + "Buy-from Vendor Name")
            {
            }
            column(Purch__Rcpt__Header__No__; "No.")
            {
            }
            column(Purch__Rcpt__Header__Vessel_Name_; "Vessel Name")
            {
            }
            column(Purch__Rcpt__Header__Posting_Date_; FORMAT("Posting Date"))
            {
            }
            column(Purch__Rcpt__Header__Location_Code_; "Location Code")
            {
            }
            column(REC__Caption; REC__CaptionLbl)
            {
            }
            column(ManufacturerCaption; ManufacturerCaptionLbl)
            {
            }
            column(Receiving_ReportCaption; Receiving_ReportCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(VendorCaption; VendorCaptionLbl)
            {
            }
            column(Purch__Rcpt__Header__No__Caption; Purch__Rcpt__Header__No__CaptionLbl)
            {
            }
            column(Purch__Rcpt__Header__Vessel_Name_Caption; FIELDCAPTION("Vessel Name"))
            {
            }
            column(Purch__Rcpt__Header__Posting_Date_Caption; FIELDCAPTION("Posting Date"))
            {
            }
            column(Purch__Rcpt__Header__Location_Code_Caption; FIELDCAPTION("Location Code"))
            {
            }
            dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Quantity = FILTER(<> 0));
                column(Purch__Rcpt__Line__No__; "No.")
                {
                }
                column(Purch__Rcpt__Line__Units_per_Parcel_; "Units per Parcel")
                {
                }
                column(TotalParcels; TotalParcels)
                {
                    DecimalPlaces = 0 : 2;
                }
                column(Purch__Rcpt__Line__Order_No__; "Order No.")
                {
                }
                column(EmptyString_Control1000000012; '__________')
                {
                }
                column(EmptyString_Control1000000013; '________________________')
                {
                }
                column(EmptyString_Control1000000014; '________________')
                {
                }
                column(EmptyString_Control1102623000; '_____________________')
                {
                }
                column(Purch__Rcpt__Line_Description; Description)
                {
                }
                column(Purch__Rcpt__Line__Description_2_; "Description 2")
                {
                }
                column(Nifast_Lot_No_Caption; Nifast_Lot_No_CaptionLbl)
                {
                }
                column(Bin_CodeCaption; Bin_CodeCaptionLbl)
                {
                }
                column(Mfg__Lot_No_Caption; Mfg__Lot_No_CaptionLbl)
                {
                }
                column(CtnsCaption; CtnsCaptionLbl)
                {
                }
                column(Order_No_Caption; Order_No_CaptionLbl)
                {
                }
                column(Total_CtnsCaption; Total_CtnsCaptionLbl)
                {
                }
                column(SNPCaption; SNPCaptionLbl)
                {
                }
                column(No_Caption; No_CaptionLbl)
                {
                }
                column(Purch__Rcpt__Line_Document_No_; "Document No.")
                {
                }
                column(Purch__Rcpt__Line_Line_No_; "Line No.")
                {
                }
                column(Purch__Rcpt__Line_Buy_from_Vendor_No_; "Buy-from Vendor No.")
                {
                }
                column(Item_Category_Code; "Purch. Rcpt. Line"."Item Category Code")
                {
                }
                dataitem("Item Ledger Entry"; "Item Ledger Entry")
                {
                    DataItemLink = "Item No." = FIELD("No."),
                                   "Document No." = FIELD("Document No."),
                                   "Source No." = FIELD("Buy-from Vendor No.");
                    DataItemTableView = SORTING("Source Type", "Source No.", "Entry Type", "Item No.", "Variant Code", "Posting Date")//, "QC Hold") BC Upgrade
                    ORDER(Ascending);
                    column(Item_Ledger_Entry__Mfg__Lot_No__; "Mfg. Lot No.")
                    {
                    }
                    column(Item_Ledger_Entry__Lot_No__; "Lot No.")
                    {
                    }
                    column(Item_Ledger_Entry_Quantity; Quantity)
                    {
                    }
                    column(Qty_Caption; Qty_CaptionLbl)
                    {
                    }
                    column(Item_Ledger_Entry_Entry_No_; "Entry No.")
                    {
                    }
                    column(Item_Ledger_Entry_Item_No_; "Item No.")
                    {
                    }
                    column(Item_Ledger_Entry_Document_No_; "Document No.")
                    {
                    }
                    column(Item_Ledger_Entry_Source_No_; "Source No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        //>>NF1.00:CIS.NG  07-25-16
                        //  //>>NIF MAK 083005
                        //CALCFIELDS("Mfg. Lot No.");BC Upgrade
                        //  IF "Mfg. Lot No." = '' THEN
                        //    CurrReport.SKIP;
                        //  //<<NIF MAK 083005
                        //<<NF1.00:CIS.NG  07-25-16
                    end;
                }
                dataitem(LineFiller; Integer)
                {
                    DataItemTableView = SORTING(Number);
                    column(EmptyString_Control1000000015; '__________')
                    {
                    }
                    column(EmptyString_Control1000000016; '________________________')
                    {
                    }
                    column(EmptyString_Control1000000017; '________________')
                    {
                    }
                    column(EmptyString_Control1102623002; '_____________________')
                    {
                    }
                    column(LineFiller_Number; Number)
                    {
                    }

                    trigger OnPreDataItem()
                    begin
                        SETRANGE(Number, 1, BlankLines);
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    IF "Units per Parcel" <> 0 THEN
                        TotalParcels := "Quantity (Base)" / "Units per Parcel"
                    ELSE
                        TotalParcels := 0;

                    BlankLines := 5;    //Was 3
                end;
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

    labels
    {
    }

    var
        TotalParcels: Decimal;
        BlankLines: Integer;
        REC__CaptionLbl: Label 'REC #';
        ManufacturerCaptionLbl: Label 'Manufacturer';
        Receiving_ReportCaptionLbl: Label 'Receiving Report';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        VendorCaptionLbl: Label 'Vendor';
        Purch__Rcpt__Header__No__CaptionLbl: Label 'Receipt No.';
        Nifast_Lot_No_CaptionLbl: Label 'Nifast Lot No.';
        Bin_CodeCaptionLbl: Label 'Bin Code';
        Mfg__Lot_No_CaptionLbl: Label 'Mfg. Lot No.';
        CtnsCaptionLbl: Label 'Ctns';
        Order_No_CaptionLbl: Label 'Order No.';
        Total_CtnsCaptionLbl: Label 'Total Ctns';
        SNPCaptionLbl: Label 'SNP';
        No_CaptionLbl: Label 'No.';
        Qty_CaptionLbl: Label 'Qty:';
}

