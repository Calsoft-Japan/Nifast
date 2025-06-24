report 50073 "Receiving Report - Trans Rcpt"
{
    // NF1.00:CIS.CM  09-15-15 Merged during upgrade
    DefaultLayout = RDLC;
    RDLCLayout = './Receiving Report - Trans Rcpt.rdlc';


    dataset
    {
        dataitem(DataItem4354;Table5746)
        {
            RequestFilterFields = "No.","Transfer Order No.","Posting Date";
            column(EmptyString;'')
            {
            }
            column(EmptyString_Control1000000019;'')
            {
            }
            column(USERID;USERID)
            {
            }
            column(CurrReport_PAGENO;CurrReport.PAGENO)
            {
            }
            column(TIME;TIME)
            {
            }
            column(FORMAT_TODAY_0_4_;FORMAT(TODAY,0,4))
            {
            }
            column(Transfer_Receipt_Header__No__;"No.")
            {
            }
            column(Transfer_Receipt_Header__Vessel_Name_;"Vessel Name")
            {
            }
            column(Transfer_Receipt_Header__Posting_Date_;"Posting Date")
            {
            }
            column(Transfer_Receipt_Header__Transfer_to_Code_;"Transfer-to Code")
            {
            }
            column(Transfer_Receipt_Header__Transfer_Order_No__;"Transfer Order No.")
            {
            }
            column(REC__Caption;REC__CaptionLbl)
            {
            }
            column(ManufacturerCaption;ManufacturerCaptionLbl)
            {
            }
            column(Receiving_ReportCaption;Receiving_ReportCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Transfer_Receipt_Header__No__Caption;Transfer_Receipt_Header__No__CaptionLbl)
            {
            }
            column(Transfer_Receipt_Header__Vessel_Name_Caption;FIELDCAPTION("Vessel Name"))
            {
            }
            column(Transfer_Receipt_Header__Posting_Date_Caption;FIELDCAPTION("Posting Date"))
            {
            }
            column(Transfer_Receipt_Header__Transfer_to_Code_Caption;FIELDCAPTION("Transfer-to Code"))
            {
            }
            column(Transfer_Receipt_Header__Transfer_Order_No__Caption;FIELDCAPTION("Transfer Order No."))
            {
            }
            dataitem(DataItem4146;Table5747)
            {
                DataItemLink = Document No.=FIELD(No.);
                DataItemTableView = WHERE(Quantity=FILTER(<>0));
                column(Transfer_Receipt_Line__Item_No__;"Item No.")
                {
                }
                column(Transfer_Receipt_Line__Units_per_Parcel_;"Units per Parcel")
                {
                }
                column(TotalParcels;TotalParcels)
                {
                    DecimalPlaces = 0:2;
                }
                column(EmptyString_Control1000000012;'__________')
                {
                }
                column(EmptyString_Control1000000013;'________________________')
                {
                }
                column(EmptyString_Control1000000014;'_________________')
                {
                }
                column(EmptyString_Control1102623000;'_____________________')
                {
                }
                column(Transfer_Receipt_Line__Source_PO_No__;"Source PO No.")
                {
                }
                column(Nifast_Lot_No_Caption;Nifast_Lot_No_CaptionLbl)
                {
                }
                column(Bin_CodeCaption;Bin_CodeCaptionLbl)
                {
                }
                column(Mfg__Lot_No_Caption;Mfg__Lot_No_CaptionLbl)
                {
                }
                column(CtnsCaption;CtnsCaptionLbl)
                {
                }
                column(Total_CtnsCaption;Total_CtnsCaptionLbl)
                {
                }
                column(SNPCaption;SNPCaptionLbl)
                {
                }
                column(No_Caption;No_CaptionLbl)
                {
                }
                column(Transfer_Receipt_Line__Source_PO_No__Caption;FIELDCAPTION("Source PO No."))
                {
                }
                column(Transfer_Receipt_Line_Document_No_;"Document No.")
                {
                }
                column(Transfer_Receipt_Line_Line_No_;"Line No.")
                {
                }
                dataitem(DataItem7209;Table32)
                {
                    DataItemLink = Item No.=FIELD(Item No.),
                                   Document No.=FIELD(Document No.);
                    DataItemTableView = SORTING(Source Type,Source No.,Entry Type,Item No.,Variant Code,Posting Date,QC Hold)
                                        ORDER(Ascending);
                    column(Item_Ledger_Entry__Mfg__Lot_No__;"Mfg. Lot No.")
                    {
                    }
                    column(Item_Ledger_Entry__Lot_No__;"Lot No.")
                    {
                    }
                    column(Item_Ledger_Entry_Quantity;Quantity)
                    {
                    }
                    column(Qty_Caption;Qty_CaptionLbl)
                    {
                    }
                    column(Item_Ledger_Entry_Entry_No_;"Entry No.")
                    {
                    }
                    column(Item_Ledger_Entry_Item_No_;"Item No.")
                    {
                    }
                    column(Item_Ledger_Entry_Document_No_;"Document No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        //>>NIF MAK 083005
                        CALCFIELDS("Mfg. Lot No.");
                        IF "Mfg. Lot No." = '' THEN
                          //CurrReport.SKIP;
                        //<<NIF MAK 083005
                    end;
                }
                dataitem(LineFiller;Table2000000026)
                {
                    DataItemTableView = SORTING(Number);
                    column(EmptyString_Control1000000015;'__________')
                    {
                    }
                    column(EmptyString_Control1000000016;'________________________')
                    {
                    }
                    column(EmptyString_Control1000000017;'_________________')
                    {
                    }
                    column(EmptyString_Control1102623002;'_____________________')
                    {
                    }
                    column(LineFiller_Number;Number)
                    {
                    }

                    trigger OnPreDataItem()
                    begin
                        SETRANGE(Number,1,BlankLines);
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    IF "Units per Parcel"<>0 THEN
                      TotalParcels := "Quantity (Base)"/"Units per Parcel"
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
        Transfer_Receipt_Header__No__CaptionLbl: Label 'Receipt No.';
        Nifast_Lot_No_CaptionLbl: Label 'Nifast Lot No.';
        Bin_CodeCaptionLbl: Label 'Bin Code';
        Mfg__Lot_No_CaptionLbl: Label 'Mfg. Lot No.';
        CtnsCaptionLbl: Label 'Ctns';
        Total_CtnsCaptionLbl: Label 'Total Ctns';
        SNPCaptionLbl: Label 'SNP';
        No_CaptionLbl: Label 'No.';
        Qty_CaptionLbl: Label 'Qty:';
}

