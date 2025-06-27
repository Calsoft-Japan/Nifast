report 50047 "MEX Receiving Summary"
{
    // NF1.00:CIS.NG  09-04-15 Merged during upgrade
    DefaultLayout = RDLC;
    RDLCLayout = '.\RDLC\MEX Receiving Summary.rdlc';


    dataset
    {
        dataitem(HSLoop_Line; Integer)
        {
            DataItemTableView = SORTING(Number);
            PrintOnlyIfDetail = true;
            column(PrintDetail; PrintDetail)
            {
            }
            column(TIME; TIME)
            {
            }
            column(CurrReport_PAGENO; 1)//CurrReport.PAGENO)
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
            column(TempHSCode_Code_________TempHSCode_Description; TempHSCode.Code + ' ' + TempHSCode.Description)
            {
            }
            column(ExtCostLCY; ExtCostLCY)
            {
            }
            column(Qty; Qty)
            {
                DecimalPlaces = 0 : 2;
            }
            column(Total_; 'Total')
            {
            }
            column(Weight; Weight)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Receiving_SummaryCaption; Receiving_SummaryCaptionLbl)
            {
            }
            column(Total_Cost__LCY_Caption; Total_Cost__LCY_CaptionLbl)
            {
            }
            column(Unit_CostCaption; Unit_CostCaptionLbl)
            {
            }
            column(QuantityCaption; QuantityCaptionLbl)
            {
            }
            column(DescripcionCaption; DescripcionCaptionLbl)
            {
            }
            column(FraccionCaption; FraccionCaptionLbl)
            {
            }
            column(WeightCaption; WeightCaptionLbl)
            {
            }
            column(HSLoop_Number; Number)
            {
            }
            column(HSLoop; 'HSLoop')
            {
            }
            dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
            {
                DataItemTableView = SORTING(Type, "No.")//, "Rework No.", "Rework Line No." BC Upgrade
                                    WHERE(Type = FILTER(Item),
                                          Quantity = FILTER(<> 0));
                RequestFilterFields = "Order No.", "Document No.", "Buy-from Vendor No.";//"NV Posting Date", BC Upgrade
                column(Qty_Control1102623016; Qty)
                {
                    DecimalPlaces = 0 : 2;
                }
                column(TempHSCode_Code; TempHSCode.Code)
                {
                }
                column(CalcUnitCostLCY; CalcUnitCostLCY)
                {
                    DecimalPlaces = 0 : 5;
                }
                column(ExtCostLCY_Control1102623019; ExtCostLCY)
                {
                }
                column(TempHSCode_Description; TempHSCode.Description)
                {
                }
                column(Weight_Control1102623033; Weight)
                {
                }
                column(Purch__Rcpt__Line_Document_No_; "Document No.")
                {
                }
                column(Purch__Rcpt__Line_Line_No_; "Line No.")
                {
                }
                column(Purch__Rcpt__Line_No_; "No.")
                {
                }
                dataitem("Item Entry Relation"; "Item Entry Relation")
                {
                    DataItemLink = "Source ID" = FIELD("Document No."),
                                   "Source Ref. No." = FIELD("Line No.");
                    DataItemTableView = SORTING("Source ID", "Source Type", "Source Subtype", "Source Ref. No.", "Source Prod. Order Line", "Source Batch Name")
                                        WHERE("Source Type" = CONST(121));
                    column(Item_Entry_Relation__Lot_No__; "Lot No.")
                    {
                    }
                    column(Qty_Control1102623025; Qty)
                    {
                        DecimalPlaces = 0 : 2;
                    }
                    column(ExtCostLCY_Control1102623023; ExtCostLCY)
                    {
                    }
                    column(Purch__Rcpt__Line___No__; "Purch. Rcpt. Line"."No.")
                    {
                    }
                    column(Purch__Rcpt__Line__Description; "Purch. Rcpt. Line".Description)
                    {
                    }
                    column(CalcUnitCostLCY_Control1102623028; CalcUnitCostLCY)
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(Weight_Control1102623030; Weight)
                    {
                    }
                    column(Item_Entry_Relation_Item_Entry_No_; "Item Entry No.")
                    {
                    }
                    column(Item_Entry_Relation_Source_ID; "Source ID")
                    {
                    }
                    column(Item_Entry_Relation_Source_Ref__No_; "Source Ref. No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    var
                        ValueEntry: Record "Value Entry";
                        CostAmtEptValueEntry: Decimal;
                    begin
                        ItemLedgEntry.GET("Item Entry Relation"."Item Entry No.");
                        Qty := ItemLedgEntry.Quantity;

                        //>> NF1.00:CIS.NG 09-04-15
                        //ItemLedgEntry.CALCFIELDS("Cost Amount (Expected)","Mfg. Lot No.");
                        //ExtCostLCY := ItemLedgEntry."Cost Amount (Expected)";

                        CostAmtEptValueEntry := 0;
                        ValueEntry.RESET;
                        ValueEntry.SETRANGE("Item Ledger Entry No.", ItemLedgEntry."Entry No.");
                        ValueEntry.SETRANGE("Expected Cost", TRUE);
                        IF ValueEntry.FINDSET THEN BEGIN
                            REPEAT
                                CostAmtEptValueEntry += ValueEntry."Cost Amount (Expected)";
                            UNTIL ValueEntry.NEXT = 0;
                        END;

                        ItemLedgEntry.CALCFIELDS("Mfg. Lot No.");
                        ExtCostLCY := CostAmtEptValueEntry;
                        //<< NF1.00:CIS.NG 09-04-15


                        Weight := ROUND(ItemLedgEntry.Quantity * "Purch. Rcpt. Line"."Gross Weight", 0.01);
                    end;

                    trigger OnPreDataItem()
                    begin
                        //CurrReport.CREATETOTALS(Qty, ExtCostLCY, Weight);BC Upgrade
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    IF "Order No." <> '' THEN
                        IF NOT TempPurchHdr.GET(0, "Order No.") THEN BEGIN
                            TempPurchHdr.INIT;
                            TempPurchHdr."No." := "Order No.";
                            TempPurchHdr.INSERT;
                        END;
                end;

                trigger OnPreDataItem()
                begin
                    //CurrReport.CREATETOTALS(Qty, ExtCostLCY, Weight);BC Upgrade

                    SETRANGE("HS Tariff Code", TempHSCode.Code);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF Number = 1 THEN
                    TempHSCode.FIND('-')
                ELSE
                    TempHSCode.NEXT;
            end;

            trigger OnPreDataItem()
            begin
                //CurrReport.CREATETOTALS(Qty, ExtCostLCY, Weight);BC Upgrade

                SETRANGE(Number, 1, TempHSCode.COUNT);
                TempPurchHdr.DELETEALL;
                CompanyInformation.GET;  //NF1.00:CIS.NG  09-04-15
            end;
        }
        dataitem(FooterPrint; Integer)
        {
            DataItemTableView = SORTING(Number);
            MaxIteration = 1;
            column(Nifast_PO______OrderText; 'Nifast PO# ' + OrderText)
            {
            }
            column(ObservationsCaption; ObservationsCaptionLbl)
            {
            }
            column(FooterPrint_Number; Number)
            {
            }

            trigger OnPreDataItem()
            begin
                CLEAR(OrderText);

                IF TempPurchHdr.FIND('-') THEN
                    REPEAT
                        IF OrderText <> '' THEN
                            OrderText := OrderText + ', ' + TempPurchHdr."No."
                        ELSE
                            OrderText := TempPurchHdr."No.";
                    UNTIL TempPurchHdr.NEXT = 0;
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
        Label1 = '. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .';
    }

    trigger OnPreReport()
    begin
        FilterText := "Purch. Rcpt. Line".GETFILTERS;

        IF HSCode.FIND('-') THEN
            REPEAT
                TempHSCode.INIT;
                TempHSCode.TRANSFERFIELDS(HSCode);
                TempHSCode.INSERT;
            UNTIL HSCode.NEXT = 0;

        TempHSCode.INIT;
        TempHSCode.Code := '';
        TempHSCode.Description := '<No Code>';
        IF NOT TempHSCode.INSERT THEN;
    end;

    var
        TempHSCode: Record "HS Tariff Code" temporary;
        TempPurchHdr: Record "Purchase Header" temporary;
        HSCode: Record "HS Tariff Code";
        FilterText: Text;
        CompanyInformation: Record "Company Information";
        ExtCostLCY: Decimal;
        CalcUnitCostLCY: Decimal;
        Qty: Decimal;
        ItemLedgEntry: Record "Item Ledger Entry";
        LotNoInfo: Record "Lot No. Information";
        PrintDetail: Boolean;
        OrderText: Text;
        Weight: Decimal;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Receiving_SummaryCaptionLbl: Label 'Receiving Summary';
        Total_Cost__LCY_CaptionLbl: Label 'Total Cost (LCY)';
        Unit_CostCaptionLbl: Label 'Unit Cost';
        QuantityCaptionLbl: Label 'Quantity';
        DescripcionCaptionLbl: Label 'Descripcion';
        FraccionCaptionLbl: Label 'Fraccion';
        WeightCaptionLbl: Label 'Weight';
        ObservationsCaptionLbl: Label 'Observations';
}

