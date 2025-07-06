report 50045 "Picking List - IST"
{
    // NF1.00:CIS.NG  11/30/15 Update the report to NAV 3.7 to NAV 2015
    // NF1.00:CIS.NG  07-19-16 Fix the Date Format Issue - Make it MM/dd/yy
    // 
    // istrtt 091803 7993 new req fields for whse. header Created by,Creation Date
    // 
    // >>NIF
    // MAK  061505  ??????  Added "Blanket Order No." to print on header of pick ticket
    // RTT  070605          code at WhseActLine to Sort pick by Bin Code
    // RTT  082905          added functionality for Transfer Lines
    //                      - new DataItem "Transfer Line" (for possible future use)
    //                      - code at "Warehouse Activity Header" - OnAfterGetRecord
    //                      - new section Integer - Header(5)
    //                      - new DateItem and sections for "Inventory Comment Line"
    // MAK  082905  GOLIVE  Added new globals "ReqDelDAteText", SalesHeader
    //                      Added code in WarehouseActivityHeader.OnAFterGetRecord to populate a text
    //                        field with Req/Promised Delivery Dates
    // MAK  083005  GOLIVE  Changed "SetFilter" to "SetRange" in SalesLine.OnAFterGetRecord.  SetFilter
    //                        was causing a problem with Item No.'s that had "special characters" in them.
    // RTT  091905          Added Ship-to Code
    // RTT  120805          New vars SNPText1,SNPText2, and ShowSNP: cod
    //                      -code at "Warehouse Activity Header"-OnAfterGetRecord to determine ShowSNP and assign SNPText
    //                      -code at WhseActLine-OnAfterGetRecord() to zero out SNP info if applicable
    // RTT  121405          Added CrossRefText,BinText and RevisionText
    //                      - code at WhseActLine-OnAfterGetRecord
    // RTT  052506          new vars ASNValue and ASNCaption
    //                      -added to Header section
    //                      -code at Warehouse Activity Header - OnAfterGetRecord()
    // 
    // SM.001- 8/24/16 swapped Ship to and Sold to on Purchase Return Orders
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = '.\RDLC\Picking List - IST.rdlc';

    Caption = 'Picking List';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Warehouse Activity Header"; "Warehouse Activity Header")
        {
            DataItemTableView = SORTING(Type, "No.")
                                WHERE(Type = FILTER(Pick | "Invt. Pick"));
            RequestFilterFields = "No.", "No. Printed", "Blanket Order No.";//, Field50005; BC Upgrade
            column(Warehouse_Activity_Header_Type; Type)
            {
            }
            column(Warehouse_Activity_Header_No_; "No.")
            {
            }
            column(SourceType_WhseActLine2; WhseActLine2."Source Type")
            {
            }
            column(Locatio_BinMandatory; Location."Bin Mandatory")
            {
            }
            column(InvtPick; InvtPick)
            {
            }
            column(SumUpLines; SumUpLines)
            {
            }
            dataitem(DataItem5444; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                column(USERID; USERID)
                {
                }
                column(COMPANYNAME; COMPANYNAME)
                {
                }
                column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
                {
                }
                column(TIME; TIME)
                {
                }
                column(Warehouse_Activity_Header___No__; "Warehouse Activity Header"."No.")
                {
                }
                column(HeaderText; HeaderText)
                {
                }
                column(Sales_Header___No________; '*' + "Sales Header"."No." + '*')
                {
                }
                column(Sales_Header___No__; "Sales Header"."No.")
                {
                }
                column(ShipToAddress_1_; ShipToAddress[1])
                {
                }
                column(ShipToAddress_2_; ShipToAddress[2])
                {
                }
                column(ShipToAddress_3_; ShipToAddress[3])
                {
                }
                column(ShipToAddress_4_; ShipToAddress[4])
                {
                }
                column(ShipToAddress_5_; ShipToAddress[5])
                {
                }
                column(ShipToAddress_6_; ShipToAddress[6])
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
                column(Sales_Header___External_Document_No__; "Sales Header"."External Document No.")
                {
                }
                column(Sales_Header___Sell_to_Customer_No__; "Sales Header"."Sell-to Customer No.")
                {
                }
                column(Sales_Header___Shipment_Method_Code_; "Sales Header"."Shipment Method Code")
                {
                }
                column(Sales_Header___Shipping_Agent_Code_; "Sales Header"."Shipping Agent Code")
                {
                }
                column(Warehouse_Activity_Header___Location_Code_; "Warehouse Activity Header"."Location Code")
                {
                }
                column(FreightTerms_Description; FreightTerms.Description)
                {
                }
                column(Sales_Header___Third_Party_Ship__Account_No__; "Sales Header"."Third Party Ship. Account No.")
                {
                }
                column(Warehouse_Activity_Header___Blanket_Order_No__; "Warehouse Activity Header"."Blanket Order No.")
                {
                }
                column(ReqDelDateLabel; ReqDelDateLabel)
                {
                }
                column(Sales_Header___Ship_to_Code_; "Sales Header"."Ship-to Code")
                {
                }
                column(ReqDelDateText; ReqDelDateText)
                {
                }
                column(ASNValue; ASNValue)
                {
                }
                column(ASNCaption; ASNCaption)
                {
                }
                column(Purchase_Header___No________; '*' + "Purchase Header"."No." + '*')
                {
                }
                column(Purchase_Header___Shipment_Method_Code_; "Purchase Header"."Shipment Method Code")
                {
                }
                column(Purchase_Header___No__; "Purchase Header"."No.")
                {
                }
                column(Purchase_Header___Buy_from_Vendor_No__; "Purchase Header"."Buy-from Vendor No.")
                {
                }
                column(Purchase_Header___Vendor_Authorization_No__; "Purchase Header"."Vendor Authorization No.")
                {
                }
                column(Purchase_Header___Shipping_Agent_Code_; "Purchase Header"."Shipping Agent Code")
                {
                }
                column(Transfer_Header___Shipment_Method_Code_; "Transfer Header"."Shipment Method Code")
                {
                }
                column(Transfer_Header___No________; '*' + "Transfer Header"."No." + '*')
                {
                }
                column(Transfer_Header___No__; "Transfer Header"."No.")
                {
                }
                column(Transfer_Header___Transfer_from_Code_; "Transfer Header"."Transfer-from Code")
                {
                }
                column(Transfer_Header___Transfer_to_Code_; "Transfer Header"."Transfer-to Code")
                {
                }
                column(VesselName; VesselName)
                {
                }
                column(SailOnDate; SailOnDate)
                {
                }
                column(SNPText1; SNPText1)
                {
                }
                column(SNPText2; SNPText2)
                {
                }
                column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                {
                }
                column(Warehouse_Activity_Header___No__Caption; "Warehouse Activity Header".FIELDCAPTION("No."))
                {
                }
                column(Sales_Order_Number_Caption; Sales_Order_Number_CaptionLbl)
                {
                }
                column(ShipCaption; ShipCaptionLbl)
                {
                }
                column(To_Caption; To_CaptionLbl)
                {
                }
                column(SoldCaption; SoldCaptionLbl)
                {
                }
                column(Customer_PO_Caption; Customer_PO_CaptionLbl)
                {
                }
                column(Customer_ID_Caption; Customer_ID_CaptionLbl)
                {
                }
                column(Shipment_Method_Caption; Shipment_Method_CaptionLbl)
                {
                }
                column(Shipping_Agent_Caption; Shipping_Agent_CaptionLbl)
                {
                }
                column(Warehouse_Activity_Header___Location_Code_Caption; Warehouse_Activity_Header___Location_Code_CaptionLbl)
                {
                }
                column(Freight_Terms_Caption; Freight_Terms_CaptionLbl)
                {
                }
                column(Shipping_Acct_No__Caption; Shipping_Acct_No__CaptionLbl)
                {
                }
                column(Warehouse_Activity_Header___Blanket_Order_No__Caption; Warehouse_Activity_Header___Blanket_Order_No__CaptionLbl)
                {
                }
                column(Ship_to_Code_Caption; Ship_to_Code_CaptionLbl)
                {
                }
                column(Return_Order_Number_Caption; Return_Order_Number_CaptionLbl)
                {
                }
                column(Vendor_ID_Caption; Vendor_ID_CaptionLbl)
                {
                }
                column(Vendor_Auth_No__Caption; Vendor_Auth_No__CaptionLbl)
                {
                }
                column(Transfer_Order_No__Caption; Transfer_Order_No__CaptionLbl)
                {
                }
                column(From_Caption; From_CaptionLbl)
                {
                }
                column(Transfer_fromCaption; Transfer_fromCaptionLbl)
                {
                }
                column(Transfer_to_Caption; Transfer_to_CaptionLbl)
                {
                }
                column(WhseActLine__Qty__to_Handle_Caption; WhseActLine.FIELDCAPTION("Qty. to Handle"))
                {
                }
                column(Ship_DateCaption; Ship_DateCaptionLbl)
                {
                }
                column(WhseActLine__Shelf_No__Caption; WhseActLine.FIELDCAPTION("Shelf No."))
                {
                }
                column(WhseActLine__Lot_No__Caption; WhseActLine.FIELDCAPTION("Lot No."))
                {
                }
                column(WhseActLine_DescriptionCaption; WhseActLine.FIELDCAPTION(Description))
                {
                }
                column(WhseActLine__Item_No__Caption; WhseActLine.FIELDCAPTION("Item No."))
                {
                }
                column(Qty__HandledCaption; Qty__HandledCaptionLbl)
                {
                }
                column(WhseActLine__Zone_Code_Caption; WhseActLine.FIELDCAPTION("Zone Code"))
                {
                }
                column(WhseActLine__Bin_Code_Caption; WhseActLine.FIELDCAPTION("Bin Code"))
                {
                }
                column(Mfg__Lot_No_Caption; Mfg__Lot_No_CaptionLbl)
                {
                }
                column(Integer_Number; Number)
                {
                }
                dataitem("Warehouse Activity Line"; "Warehouse Activity Line")
                {
                    DataItemLink = "Activity Type" = FIELD(Type),
                                   "No." = FIELD("No.");
                    DataItemLinkReference = "Warehouse Activity Header";
                    DataItemTableView = SORTING("Activity Type", "No.", "Sorting Sequence No.")
                                        WHERE("Action Type" = CONST(Take));

                    trigger OnAfterGetRecord()
                    begin
                        IF SumUpLines AND
                           ("Warehouse Activity Header"."Sorting Method" <>
                            "Warehouse Activity Header"."Sorting Method"::Document)
                        THEN BEGIN
                            IF TmpWhseActLine."No." = '' THEN BEGIN
                                TmpWhseActLine := "Warehouse Activity Line";
                                TmpWhseActLine.INSERT;
                                MARK(TRUE);
                            END ELSE BEGIN
                                TmpWhseActLine.SETCURRENTKEY("Activity Type", "No.", "Bin Code", "Breakbulk No.", "Action Type");
                                TmpWhseActLine.SETRANGE("Activity Type", "Activity Type");
                                TmpWhseActLine.SETRANGE("No.", "No.");
                                //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                //XTmpWhseActLine.SETRANGE("Bin Code","Bin Code");
                                //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                                TmpWhseActLine.SETRANGE("Item No.", "Item No.");
                                TmpWhseActLine.SETRANGE("Action Type", "Action Type");
                                TmpWhseActLine.SETRANGE("Variant Code", "Variant Code");
                                TmpWhseActLine.SETRANGE("Unit of Measure Code", "Unit of Measure Code");
                                //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                //XTmpWhseActLine.SETRANGE("Due Date","Due Date");
                                //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                                IF "Warehouse Activity Header"."Sorting Method" =
                                   "Warehouse Activity Header"."Sorting Method"::"Ship-To"
                                THEN BEGIN
                                    TmpWhseActLine.SETRANGE("Destination Type", "Destination Type");
                                    TmpWhseActLine.SETRANGE("Destination No.", "Destination No.")
                                END;
                                IF TmpWhseActLine.FINDFIRST THEN BEGIN
                                    TmpWhseActLine."Qty. (Base)" := TmpWhseActLine."Qty. (Base)" + "Qty. (Base)";
                                    TmpWhseActLine."Qty. to Handle" := TmpWhseActLine."Qty. to Handle" + "Qty. to Handle";
                                    TmpWhseActLine."Source No." := '';
                                    IF "Warehouse Activity Header"."Sorting Method" <>
                                       "Warehouse Activity Header"."Sorting Method"::"Ship-To"
                                    THEN BEGIN
                                        TmpWhseActLine."Destination Type" := TmpWhseActLine."Destination Type"::" ";
                                        TmpWhseActLine."Destination No." := '';
                                    END;
                                    TmpWhseActLine.MODIFY;
                                END ELSE BEGIN
                                    TmpWhseActLine := "Warehouse Activity Line";
                                    TmpWhseActLine.INSERT;
                                    MARK(TRUE);
                                END;
                            END;
                        END ELSE
                            MARK(TRUE);
                    end;

                    trigger OnPostDataItem()
                    begin
                        MARKEDONLY(TRUE);
                    end;

                    trigger OnPreDataItem()
                    begin
                        TmpWhseActLine.SETRANGE("Activity Type", "Warehouse Activity Header".Type);
                        TmpWhseActLine.SETRANGE("No.", "Warehouse Activity Header"."No.");
                        TmpWhseActLine.DELETEALL;
                        IF BreakbulkFilter THEN
                            TmpWhseActLine.SETRANGE("Original Breakbulk", FALSE);
                        CLEAR(TmpWhseActLine);
                    end;
                }
                dataitem(WhseActLine; "Warehouse Activity Line")
                {
                    DataItemLink = "Activity Type" = FIELD(Type),
                                   "No." = FIELD("No.");
                    DataItemLinkReference = "Warehouse Activity Header";
                    DataItemTableView = SORTING("Activity Type", "No.", "Item No.", "Variant Code", "Action Type", "Bin Code")
                                        WHERE("Action Type" = CONST(Take));
                    column(WhseActLine__Shelf_No__; "Shelf No.")
                    {
                    }
                    column(WhseActLine__Item_No__; "Item No.")
                    {
                    }
                    column(WhseActLine_Description; Description)
                    {
                    }
                    column(WhseActLine__Lot_No__; "Lot No.")
                    {
                    }
                    column(WhseActLine__Unit_of_Measure_Code_; "Unit of Measure Code")
                    {
                    }
                    column(WhseActLine__Due_Date_; "Due Date")
                    {
                    }
                    column(WhseActLine__Qty__to_Handle_; "Qty. to Handle")
                    {
                    }
                    column(WhseActLine__Total_Parcels_; "Total Parcels")
                    {
                    }
                    column(WhseActLine__Units_per_Parcel_; "Units per Parcel")
                    {
                    }
                    column(WhseActLine__Zone_Code_; "Zone Code")
                    {
                    }
                    column(WhseActLine__Bin_Code_; "Bin Code")
                    {
                    }
                    column(LotBarCode; LotBarCode)
                    {
                    }
                    column(MfgLotNo; MfgLotNo)
                    {
                    }
                    column(CrossRefText; CrossRefText)
                    {
                    }
                    column(WhseActLine_WhseActLine__Qty__to_Handle_; WhseActLine."Qty. to Handle")
                    {
                    }
                    column(Totals_; ' Totals')
                    {
                    }
                    column(WhseActLine_WhseActLine__Total_Parcels_; WhseActLine."Total Parcels")
                    {
                    }
                    column(WhsLineTotalParcels; WhsLineTotalParcels)
                    {
                    }
                    column(WhsLineTotalQtyToHandle; WhsLineTotalQtyToHandle)
                    {
                    }
                    column(EmptyStringCaption; EmptyStringCaptionLbl)
                    {
                    }
                    column(WhseActLine_Activity_Type; "Activity Type")
                    {
                    }
                    column(WhseActLine_No_; "No.")
                    {
                    }
                    column(WhseActLine_Line_No_; "Line No.")
                    {
                    }
                    column(WhseActLine_Source_No_; "Source No.")
                    {
                    }
                    column(WhseActLine_Source_Line_No_; "Source Line No.")
                    {
                    }
                    dataitem("Sales Line"; "Sales Line")
                    {
                        DataItemLink = "Document No." = FIELD("Source No."),
                                       "Line No." = FIELD("Source Line No.");
                        DataItemLinkReference = WhseActLine;
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                            WHERE("Document Type" = CONST(Order));
                        column(Sales_Line__Cross_Reference_No__; "Item Reference No.")//BC Upgrade
                        {
                        }
                        column(Sales_Line__Revision_No__; "Revision No.")
                        {
                        }
                        column(EmptyString; '')
                        {
                        }
                        column(Cross_Reference_No_Caption; Cross_Reference_No_CaptionLbl)
                        {
                        }
                        column(Sales_Line__Revision_No__Caption; FIELDCAPTION("Revision No."))
                        {
                        }
                        column(Sales_Line_Document_Type; "Document Type")
                        {
                        }
                        column(Sales_Line_Document_No_; "Document No.")
                        {
                        }
                        column(Sales_Line_Line_No_; "Line No.")
                        {
                        }
                        dataitem(SalesLineCommentLine; "Sales Comment Line")
                        {
                            DataItemLink = "Document Type" = FIELD("Document Type"),
                                           "No." = FIELD("Document No."),
                                           "Document Line No." = FIELD("Line No.");
                            DataItemLinkReference = "Sales Line";
                            DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.");
                            //WHERE("Print On Pick Ticket" = CONST(Yes)); Remove BC Upgrade
                            column(Sales_Line_Comment_Line_Comment; Comment)
                            {
                            }
                            column(Sales_Line_Comment_Line_CommentCaption; FIELDCAPTION(Comment))
                            {
                            }
                            column(Sales_Line_Comment_Line_Document_Type; "Document Type")
                            {
                            }
                            column(Sales_Line_Comment_Line_No_; "No.")
                            {
                            }
                            column(Sales_Line_Comment_Line_Doc__Line_No_; "Document Line No.")
                            {
                            }
                            column(Sales_Line_Comment_Line_Line_No_; "Line No.")
                            {
                            }
                        }

                        trigger OnAfterGetRecord()
                        var
                            loptCustomerType: Option " ",Customer,Vendor,"Bar Code";
                        begin

                            recItemXref.SETRANGE("Item No.", "No.");    //NIF MAK GOLIVE  083005
                            ////recItemXref.SETFILTER("Item No.","No.");
                            recItemXref.SETFILTER("Reference Type", FORMAT(loptCustomerType::Customer));//Cross- BC Upgrade
                            recItemXref.SETFILTER("Reference Type No.", "Sell-to Customer No.");//Cross- BC Upgrade
                            IF recItemXref.FIND('-') THEN
                                gtPkgInstructions := recItemXref."Packaging Instructions"
                            ELSE
                                gtPkgInstructions := '';

                            //>> 12-14-05
                            //<< 12-14-05
                        end;
                    }
                    dataitem("Transfer Line"; "Transfer Line")
                    {
                        DataItemLink = "Document No." = FIELD("Source No."),
                                       "Line No." = FIELD("Source Line No.");
                        DataItemTableView = SORTING("Document No.", "Line No.");
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF SumUpLines THEN BEGIN
                            TmpWhseActLine.GET("Activity Type", "No.", "Line No.");
                            "Qty. (Base)" := TmpWhseActLine."Qty. (Base)";
                            "Qty. to Handle" := TmpWhseActLine."Qty. to Handle";
                            "Total Parcels" := TmpWhseActLine."Total Parcels";
                        END;

                        //>> NIF 12-08-05
                        IF (NOT ShowSNP) THEN BEGIN
                            WhseActLine."Units per Parcel" := 0;
                            WhseActLine."Total Parcels" := 0;
                        END;
                        //<< NIF 12-08-05

                        //>> 12-14-05 RTT
                        CLEAR(CrossRefText);
                        CLEAR(RevisionText);

                        CASE "Source Type" OF
                            DATABASE::"Transfer Line":
                                IF TransferLine.GET("Source No.", "Source Line No.") THEN
                                    IF TransferLine."FB Order No." <> '' THEN
                                        IF FBHeader.GET(TransferLine."FB Order No.") THEN
                                            IF FBHeader."Contract No." <> '' THEN BEGIN
                                                ContractLine.SETRANGE("Item No.", "Item No.");
                                                ContractLine.SETRANGE("Sales Type", ContractLine."Sales Type"::Customer);
                                                ContractLine.SETRANGE("Sales Code", FBHeader."Sell-to Customer No.");
                                                ContractLine.SETRANGE("Unit of Measure Code", TransferLine."Unit of Measure Code");
                                                ContractLine.SETRANGE("Contract No.", FBHeader."Contract No.");
                                                IF ContractLine.FIND('-') THEN BEGIN
                                                    IF ContractLine."Customer Bin" <> '' THEN
                                                        CrossRefText := 'Customer Bin: ' + ContractLine."Customer Bin";
                                                    ContractLine.CALCFIELDS("Customer Cross Ref No.");
                                                    IF ContractLine."Customer Cross Ref No." <> '' THEN BEGIN
                                                        IF CrossRefText <> '' THEN
                                                            CrossRefText := CrossRefText + ', ';
                                                        CrossRefText := CrossRefText + 'Cross Reference: ' + ContractLine."Customer Cross Ref No.";
                                                    END;
                                                END;  //end IF ContractLine.FIND
                                            END;  //end IF FBHeader."Contract"<>''
                        END;  //end CASE
                        //<< 12-14-05 RTT


                        IF "Lot No." <> '' THEN
                            LotBarCode := '*' + "Lot No." + '*'
                        ELSE
                            LotBarCode := '';

                        IF "Mfg. Lot No." <> '' THEN
                            MfgLotNo := "Mfg. Lot No."
                        ELSE IF LotNoInfo.GET("Item No.", '', "Lot No.") THEN
                            MfgLotNo := LotNoInfo."Mfg. Lot No."
                        ELSE
                            MfgLotNo := '';

                        //>> NF1.00:CIS.NG  11/30/15
                        WhsLineTotalParcels += "Total Parcels";
                        WhsLineTotalQtyToHandle += "Qty. to Handle";
                        //<< NF1.00:CIS.NG  11/30/15
                    end;

                    trigger OnPreDataItem()
                    begin
                        //>>>ist
                        COPY("Warehouse Activity Line");
                        //CurrReport.CREATETOTALS("Qty. (Base)", "Qty. to Handle", "Total Parcels");BC Upgrade
                        //<<
                        //>> NIF 07-06-05
                        IF STRPOS(COMPANYNAME, 'Canada') <> 0 THEN
                            WhseActLine.SETCURRENTKEY("Activity Type", "No.", "Bin Code");
                        //<< NIF 07-06-05


                        Counter := COUNT;
                        IF Counter = 0 THEN
                            CurrReport.BREAK;

                        IF BreakbulkFilter THEN
                            SETRANGE("Original Breakbulk", FALSE);

                        //>> NF1.00:CIS.NG  11/30/15
                        WhsLineTotalParcels := 0;
                        WhsLineTotalQtyToHandle := 0;
                        //<< NF1.00:CIS.NG  11/30/15
                    end;
                }
            }
            dataitem("Sales Comment Line"; "Sales Comment Line")
            {
                DataItemTableView = SORTING("Document Type", "No.", "Line No.");
                //WHERE("Print On Pick Ticket"=CONST(Yes)); BC Upgrade
                column(Sales_Comment_Line_Comment; Comment)
                {
                }
                column(Order_CommentsCaption; Order_CommentsCaptionLbl)
                {
                }
                column(Sales_Comment_Line_Document_Type; "Document Type")
                {
                }
                column(Sales_Comment_Line_No_; "No.")
                {
                }
                column(DocumentLineNo_SalesCommentLine; "Document Line No.")
                {
                }
                column(Sales_Comment_Line_Line_No_; "Line No.")
                {
                }

                trigger OnPreDataItem()
                begin
                    "Sales Comment Line".SETRANGE("Document Type", "Sales Header"."Document Type");
                    "Sales Comment Line".SETRANGE("No.", "Sales Header"."No.");
                end;
            }
            dataitem("Inventory Comment Line"; "Inventory Comment Line")
            {
                DataItemTableView = SORTING("Document Type", "No.", "Line No.")
                                    WHERE("Document Type" = CONST("Transfer Order"));
                column(Inventory_Comment_Line_Comment; Comment)
                {
                }
                column(Transfer_CommentsCaption; Transfer_CommentsCaptionLbl)
                {
                }
                column(Inventory_Comment_Line_Document_Type; "Document Type")
                {
                }
                column(Inventory_Comment_Line_No_; "No.")
                {
                }
                column(Inventory_Comment_Line_Line_No_; "Line No.")
                {
                }

                trigger OnPreDataItem()
                begin
                    SETRANGE("No.", "Transfer Header"."No.");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //>> default value
                "Warehouse Activity Header"."Sorting Method" := "Warehouse Activity Header"."Sorting Method"::Item;
                "Warehouse Activity Header".MODIFY;
                COMMIT;

                WhseActLine2.SETRANGE("Activity Type", "Warehouse Activity Header".Type);
                WhseActLine2.SETRANGE("No.", "Warehouse Activity Header"."No.");
                IF NOT WhseActLine2.FIND('-') THEN BEGIN
                    CLEAR("Sales Header");
                    CLEAR("Purchase Header");
                END
                ELSE BEGIN
                    CASE WhseActLine2."Source Type" OF
                        DATABASE::"Sales Line":
                            BEGIN
                                IF "Sales Header".GET("Sales Header"."Document Type"::Order, WhseActLine2."Source No.") THEN BEGIN
                                    FormatAddress.SalesHeaderShipTo(ShipToAddress, ShipToAddress, "Sales Header"); //CB Upgrade
                                    FormatAddress.SalesHeaderSellTo(BillToAddress, "Sales Header");
                                    //>>09-20-05
                                    IF NOT FreightTerms.GET("Sales Header"."Freight Code") THEN
                                        CLEAR(FreightTerms);
                                    //<<09-20-05
                                    //>>12-08-05
                                    ShowSNP := TRUE;
                                    IF "Sales Header"."Responsibility Center" <> '' THEN
                                        IF COPYSTR("Sales Header"."Responsibility Center", 1, 3) = 'HOA' THEN
                                            ShowSNP := FALSE;
                                    //<<12-08-05
                                    //>>NIF 052506 RTT
                                    PackingRule.GetPackingRule(0, "Sales Header"."Sell-to Customer No.", "Sales Header"."Ship-to Code");  //0=customer
                                    IF (PackingRule."ASN Summary Type" <> PackingRule."ASN Summary Type"::" ") AND
                                          ("Sales Header"."EDI Control No." <> '') THEN BEGIN
                                        ASNCaption := "Sales Header".FIELDNAME("EDI Control No.");
                                        ASNValue := "Sales Header"."EDI Control No."
                                    END ELSE BEGIN
                                        ASNCaption := '';
                                        ASNValue := '';
                                    END;
                                    //<<NIF 052606 RTT
                                END;
                                HeaderText := 'Picking List';
                            END;
                        DATABASE::"Purchase Line":
                            BEGIN
                                IF "Purchase Header".GET("Purchase Header"."Document Type"::"Return Order", WhseActLine2."Source No.") THEN BEGIN
                                    FormatAddress.PurchHeaderShipTo(ShipToAddress, "Purchase Header");
                                    FormatAddress.PurchHeaderBuyFrom(BillToAddress, "Purchase Header");
                                END;
                                HeaderText := 'Return to Vendor - Pick';
                            END;
                        //>> 08-29-05 rtt
                        DATABASE::"Transfer Line":
                            BEGIN
                                IF "Transfer Header".GET(WhseActLine2."Source No.") THEN BEGIN
                                    FormatAddress.TransferHeaderTransferTo(ShipToAddress, "Transfer Header");
                                    FormatAddress.TransferHeaderTransferFrom(BillToAddress, "Transfer Header");
                                END;
                                //>>12-08-05
                                ShowSNP := TRUE;
                                IF ("Transfer Header"."Transfer-from Code" <> '') THEN
                                    IF (COPYSTR("Transfer Header"."Transfer-from Code", 1, 3) = 'HOA') THEN
                                        ShowSNP := FALSE;
                                //<<12-08-05
                                HeaderText := 'Transfer - Pick';
                            END;
                    //<< 08-29-05 rtt
                    END;

                END;

                //for multi-print
                //CurrReport.PAGENO := 1;BC Upgrade

                //<<

                GetLocation("Location Code");
                InvtPick := Type = Type::"Invt. Pick";

                IF NOT CurrReport.PREVIEW THEN
                    WhseCountPrinted.RUN("Warehouse Activity Header");

                //>>NIF MAK 082905 GOLIVE
                CLEAR(ReqDelDateText);
                CLEAR(ReqDelDateLabel);
                IF Type = Type::"Invt. Pick" THEN
                    IF "Source Document" = "Source Document"::"Sales Order" THEN BEGIN
                        SalesHeader.GET(SalesHeader."Document Type"::Order, "Source No.");
                        IF SalesHeader."Requested Delivery Date" <> 0D THEN BEGIN
                            ReqDelDateLabel := 'Req. Del. Date:';
                            ReqDelDateText := FORMAT(SalesHeader."Requested Delivery Date");
                        END ELSE IF SalesHeader."Promised Delivery Date" <> 0D THEN BEGIN
                            ReqDelDateLabel := 'Prom. Del. Date:';
                            ReqDelDateText := FORMAT(SalesHeader."Promised Delivery Date");
                        END;
                    END;
                //<<NIF MAK 082905 GOLIVE

                //>>NIF MAK 092305
                CLEAR(VesselName);
                CLEAR(SailOnDate);
                IF Type = Type::"Invt. Pick" THEN
                    IF "Source Document" = "Source Document"::"Outbound Transfer" THEN BEGIN
                        TransfHdr.GET("Source No.");
                        IF TransfHdr."Vessel Name" <> '' THEN VesselName := 'Vessel:' + FORMAT(TransfHdr."Vessel Name");
                        IF TransfHdr."Sail-On Date" <> 0D THEN SailOnDate := 'Sailing Date:' + FORMAT(TransfHdr."Sail-On Date");
                    END;
                //<<NIF MAK 092305

                //>>12-08-05
                IF ShowSNP THEN BEGIN
                    SNPText1 := 'Packs';
                    SNPText2 := 'SNP';
                END ELSE BEGIN
                    SNPText1 := '';
                    SNPText2 := '';
                END;
                //<<12-08-05
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
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

    trigger OnPreReport()
    begin
        PickFilter := "Warehouse Activity Header".GETFILTERS;
    end;

    var
        Location: Record Location;
        TmpWhseActLine: Record "Warehouse Activity Line" temporary;
        WhseCountPrinted: Codeunit "Whse.-Printed";
        PickFilter: Text;
        BreakbulkFilter: Boolean;
        SumUpLines: Boolean;
        HideOptions: Boolean;
        InvtPick: Boolean;
        Counter: Integer;
        "<<ist>>": Integer;
        "Sales Header": Record "Sales Header";
        "Purchase Header": Record "Purchase Header";
        WhseActLine2: Record "Warehouse Activity Line";
        FormatAddress: Codeunit "Format Address";
        BillToAddress: array[8] of Text[50];
        ShipToAddress: array[8] of Text[50];
        HeaderText: Text[100];
        gtPkgInstructions: Text[100];
        recItemXref: Record "Item Reference";
        LotBarCode: Text[30];
        MfgLotNo: Text[30];
        LotNoInfo: Record "Lot No. Information";
        SalesLine: Record "Sales Line";
        "Transfer Header": Record "Transfer Header";
        ReqDelDateText: Text[40];
        ReqDelDateLabel: Text[40];
        SalesHeader: Record "Sales Header";
        ">>NIF": Integer;
        FreightTerms: Record "Freight Code";
        VesselName: Text[80];
        SailOnDate: Text[50];
        TransfHdr: Record "Transfer Header";
        SNPText1: Text[30];
        SNPText2: Text[30];
        ShowSNP: Boolean;
        CrossRefText: Text[250];
        RevisionText: Text[100];
        TransferLine: Record "Transfer Line";
        FBHeader: Record "FB Header";
        ContractLine: Record "Sales Price";
        ASNValue: Code[20];
        ASNCaption: Text[30];
        PackingRule: Record "Packing Rule";
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Sales_Order_Number_CaptionLbl: Label 'Sales Order Number:';
        ShipCaptionLbl: Label 'Ship';
        To_CaptionLbl: Label 'To:';
        SoldCaptionLbl: Label 'Sold';
        Customer_PO_CaptionLbl: Label 'Customer PO:';
        Customer_ID_CaptionLbl: Label 'Customer ID:';
        Shipment_Method_CaptionLbl: Label 'Shipment Method:';
        Shipping_Agent_CaptionLbl: Label 'Shipping Agent:';
        Warehouse_Activity_Header___Location_Code_CaptionLbl: Label 'Location Code:';
        Freight_Terms_CaptionLbl: Label 'Freight Terms:';
        Shipping_Acct_No__CaptionLbl: Label 'Shipping Acct No.:';
        Warehouse_Activity_Header___Blanket_Order_No__CaptionLbl: Label 'Blanket Order No:';
        Ship_to_Code_CaptionLbl: Label 'Ship-to Code:';
        Return_Order_Number_CaptionLbl: Label 'Return Order Number:';
        Vendor_ID_CaptionLbl: Label 'Vendor ID:';
        Vendor_Auth_No__CaptionLbl: Label 'Vendor Auth No.:';
        Transfer_Order_No__CaptionLbl: Label 'Transfer Order No.:';
        From_CaptionLbl: Label 'From:';
        Transfer_fromCaptionLbl: Label 'Transfer-from';
        Transfer_to_CaptionLbl: Label 'Transfer-to:';
        Ship_DateCaptionLbl: Label 'Ship Date';
        Qty__HandledCaptionLbl: Label 'Qty. Handled';
        Mfg__Lot_No_CaptionLbl: Label 'Mfg. Lot No.';
        EmptyStringCaptionLbl: Label '____________';
        Cross_Reference_No_CaptionLbl: Label 'Cross-Reference No.';
        Order_CommentsCaptionLbl: Label 'Order Comments';
        Transfer_CommentsCaptionLbl: Label 'Transfer Comments';
        WhsLineTotalParcels: Decimal;
        WhsLineTotalQtyToHandle: Decimal;

    local procedure GetLocation(LocationCode: Code[10])
    begin
        IF LocationCode = '' THEN
            Location.INIT
        ELSE
            IF Location.Code <> LocationCode THEN
                Location.GET(LocationCode);
    end;

    procedure SetBreakbulkFilter(BreakbulkFilter2: Boolean)
    begin
        BreakbulkFilter := BreakbulkFilter2;
    end;

    procedure SetInventory(SetHideOptions: Boolean)
    begin
        HideOptions := SetHideOptions;
    end;
}

