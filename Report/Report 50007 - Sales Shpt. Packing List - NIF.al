report 50007 "Sales Shpt. Packing List - NIF"
{
    // NF1.00:CIS.CM  08-22-15 Merged during upgrade
    // >>IST
    // Date   Init GranID SCRID  Description
    //                           Properties Modified:
    //                           Fields Added:
    //                           Fields Modified:
    //                           Globals Added:
    //                           Globals Modified:
    //                           TextConstant Added:
    //                           TextConstant Modified:
    //                           Functions Added:
    //                           Functions Modified:
    // 081808 CCL $12797 #12797    Sales Shipment Header - OnAfterGetRecord()
    //                           Keys Added:
    //                           Keys Modified:
    //                           Other:
    // istrtt 112503
    // istrtt 060705 code at SalesShipmentHeader-OnAfterGetRecord to calc PostedPkgCount according to parcels
    // istrtt 061505 code at Posted Package-OnAfterGetRecord() to skip if no package lines
    // istrtt 092205 added Release No. field
    // <<IST
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = '.\RDLC\Sales Shpt. Packing List - NIF.rdlc';


    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(CurrReport_PAGENO; 1)//CurrReport.PAGENO)
            {
            }
            column(Sales_Shipment_Header__Sales_Shipment_Header___External_Document_No__; "Sales Shipment Header"."External Document No.")
            {
            }
            column(Sales_Shipment_Header__Sales_Shipment_Header___Sell_to_Customer_No__; "Sales Shipment Header"."Sell-to Customer No.")
            {
            }
            column(Sales_Shipment_Header__Sales_Shipment_Header___Location_Code_; "Sales Shipment Header"."Location Code")
            {
            }
            column(Sales_Shipment_Header___Order_No________; '*' + "Sales Shipment Header"."Order No." + '*')
            {
            }
            column(Sales_Shipment_Header__Sales_Shipment_Header___Order_No__; "Sales Shipment Header"."Order No.")
            {
            }
            column(LocationAddress_1_; LocationAddress[1])
            {
            }
            column(LocationAddress_2_; LocationAddress[2])
            {
            }
            column(LocationAddress_3_; LocationAddress[3])
            {
            }
            column(LocationAddress_4_; LocationAddress[4])
            {
            }
            column(Sales_Shipment_Header__Sales_Shipment_Header___No__; "Sales Shipment Header"."No.")
            {
            }
            column(CompanyInformation__Document_Logo_; CompanyInformation."Document Logo")
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(O_R_D_E_R____P_A_C_K____L_I_S_TCaption; O_R_D_E_R____P_A_C_K____L_I_S_TCaptionLbl)
            {
            }
            column(Customer_PO_Caption; Customer_PO_CaptionLbl)
            {
            }
            column(Customer_ID_Caption; Customer_ID_CaptionLbl)
            {
            }
            column(Sales_Shipment_Header__Sales_Shipment_Header___Location_Code_Caption; Sales_Shipment_Header__Sales_Shipment_Header___Location_Code_CaptionLbl)
            {
            }
            column(Sales_Order_No_Caption; Sales_Order_No_CaptionLbl)
            {
            }
            column(Shipment_No__Caption; Shipment_No__CaptionLbl)
            {
            }
            dataitem("Posted Package"; "Posted Package")//Table14000704) BC Upgrade 2025-06-23
            {
                DataItemLink = "Source ID" = FIELD("Order No.");
                DataItemTableView = SORTING("Bill of Lading No.");
                RequestFilterFields = "No.";
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
                column(BillToAddress_6_; BillToAddress[6])
                {
                }
                column(ShipToAddress_6_; ShipToAddress[6])
                {
                }
                column(Posted_Package__Packing_Date_; "Packing Date")
                {
                }
                column(PostedPkgCount; PostedPkgCount)
                {
                    DecimalPlaces = 0 : 2;
                }
                column(Posted_Package__Closed_by_Packing_Station_Code_; "Closed by Packing Station Code")
                {
                }
                column(Posted_Package__External_Tracking_No__; "External Tracking No.")
                {
                }
                column(Posted_Package__Calculation_Weight_; "Calculation Weight")
                {
                }
                column(Posted_Package__Shipping_Agent_Code_; "Shipping Agent Code")
                {
                }
                column(Sales_Shipment_Header___Shipment_Method_Code_; "Sales Shipment Header"."Shipment Method Code")
                {
                }
                column(Posted_Package__No__; "No.")
                {
                }
                column(PostedPackageShow; PostedPackageShow)
                {
                }
                column(SoldCaption; SoldCaptionLbl)
                {
                }
                column(To_Caption; To_CaptionLbl)
                {
                }
                column(ShipCaption; ShipCaptionLbl)
                {
                }
                column(To_Caption_Control1000000035; To_Caption_Control1000000035Lbl)
                {
                }
                column(Posted_Package__Packing_Date_Caption; Posted_Package__Packing_Date_CaptionLbl)
                {
                }
                column(Total_Packages_Caption; Total_Packages_CaptionLbl)
                {
                }
                column(Closed_by_Packing_StationCaption; Closed_by_Packing_StationCaptionLbl)
                {
                }
                column(Posted_Package__External_Tracking_No__Caption; FIELDCAPTION("External Tracking No."))
                {
                }
                column(Posted_Package__Calculation_Weight_Caption; FIELDCAPTION("Calculation Weight"))
                {
                }
                column(Package_No_Caption; Package_No_CaptionLbl)
                {
                }
                column(Posted_Package__Shipping_Agent_Code_Caption; FIELDCAPTION("Shipping Agent Code"))
                {
                }
                column(Sales_Shipment_Header___Shipment_Method_Code_Caption; Sales_Shipment_Header___Shipment_Method_Code_CaptionLbl)
                {
                }
                column(TypeCaption; TypeCaptionLbl)
                {
                }
                column(No_Caption; No_CaptionLbl)
                {
                }
                column(DescriptionCaption; DescriptionCaptionLbl)
                {
                }
                column(UOMCaption; UOMCaptionLbl)
                {
                }
                column(QuantityCaption; QuantityCaptionLbl)
                {
                }
                column(Lot_No_Caption; Lot_No_CaptionLbl)
                {
                }
                column(PacksCaption; PacksCaptionLbl)
                {
                }
                column(SNPCaption; SNPCaptionLbl)
                {
                }
                column(Posted_Package_Source_ID; "Source ID")
                {
                }
                dataitem(DataItem4761; "Posted Package Line")//Table14000705) BC Upgrade 2025-06-23
                {
                    DataItemLink = "Package No." = FIELD("No.");
                    DataItemTableView = SORTING("Package No.", "Line No.");
                    column(Posted_Package_Line__Unit_of_Measure_Code_; "Unit of Measure Code")
                    {
                    }
                    column(Posted_Package_Line_Quantity; Quantity)
                    {
                    }
                    column(Posted_Package_Line_Description; Description)
                    {
                    }
                    column(UseNo; UseNo)
                    {
                    }
                    column(Posted_Package_Line_Type; Type)
                    {
                    }
                    column(Posted_Package_Line__Lot_No__; "Lot No.")
                    {
                    }
                    column(Packs; Packs)
                    {
                        DecimalPlaces = 0 : 2;
                    }
                    column(UnitsPerParcel; UnitsPerParcel)
                    {
                        DecimalPlaces = 0 : 2;
                    }
                    column(Posted_Package_Line__Cross_Reference_No__; "Cross Reference No.")
                    {
                    }
                    column(Posted_Package_Line__External_Document_No__; "External Document No.")
                    {
                    }
                    column(Posted_Package_Line__Mfg__Lot_No__; "Mfg. Lot No.")
                    {
                    }
                    column(Posted_Package_Line__Certificate_No__; "Certificate No.")
                    {
                    }
                    column(Posted_Package_Line__Ran_No__; "Ran No.")
                    {
                    }
                    column(Posted_Package_Line__Release_No__; "Release No.")
                    {
                    }
                    column(Posted_Package_Line__Revision_Date_; FORMAT("Revision Date"))
                    {
                    }
                    column(Posted_Package_Line__Revision_No__; "Revision No.")
                    {
                    }
                    column(Posted_Package_Line__Drawing_No__; "Drawing No.")
                    {
                    }
                    column(Cross_Reference_No__Caption; Cross_Reference_No__CaptionLbl)
                    {
                    }
                    column(Customer_PO_No_Caption; Customer_PO_No_CaptionLbl)
                    {
                    }
                    column(Posted_Package_Line__Mfg__Lot_No__Caption; FIELDCAPTION("Mfg. Lot No."))
                    {
                    }
                    column(Certificate_No_Caption; Certificate_No_CaptionLbl)
                    {
                    }
                    column(Posted_Package_Line__Ran_No__Caption; FIELDCAPTION("Ran No."))
                    {
                    }
                    column(Posted_Package_Line__Release_No__Caption; FIELDCAPTION("Release No."))
                    {
                    }
                    column(Posted_Package_Line__Revision_Date_Caption; FIELDCAPTION("Revision Date"))
                    {
                    }
                    column(Posted_Package_Line__Revision_No__Caption; FIELDCAPTION("Revision No."))
                    {
                    }
                    column(Drawing_No__Caption; Drawing_No__CaptionLbl)
                    {
                    }
                    column(Posted_Package_Line_Package_No_; "Package No.")
                    {
                    }
                    column(Posted_Package_Line_Line_No_; "Line No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    var
                        ItemCrossRef: Record "Item Reference";//"Item Cross Reference"; Upgrade 2025-06-23
                    begin
                        //>> RTT 06-14-05
                        IF "Cross Reference No." = '' THEN BEGIN
                            ItemCrossRef.RESET;
                            ItemCrossRef.SETRANGE("Reference Type", ItemCrossRef."Reference Type"::Customer);// BC Upgrade 2025-06-23
                            ItemCrossRef.SETRANGE("Reference Type No.", "Posted Package"."Ship-to No.");// BC Upgrade 2025-06-23
                            // ItemCrossRef.SETRANGE("Cross-Reference Type", ItemCrossRef."Cross-Reference Type"::Customer); BC Upgrade 2025-06-23
                            // ItemCrossRef.SETRANGE("Cross-Reference Type No.", "Posted Package"."Ship-to No."); BC Upgrade 2025-06-23
                            ItemCrossRef.SETRANGE("Item No.", "No.");
                            IF NOT ItemCrossRef.FIND('-') THEN
                                CLEAR(ItemCrossRef);
                            "Cross Reference No." := ItemCrossRef."Reference No.";//"Cross-Reference No."; BC Upgrade 2025-06-23
                        END;

                        //<< RTT 06-14-05
                        IF ("Cross Reference No." = '') THEN
                            UseNo := "No."
                        ELSE
                            UseNo := "Cross Reference No.";

                        IF (Item.GET("No.")) AND (Item."Units per Parcel" <> 0) THEN BEGIN
                            Packs := Quantity / Item."Units per Parcel";
                            UnitsPerParcel := Item."Units per Parcel";
                        END ELSE BEGIN
                            Packs := 0;
                            UnitsPerParcel := 0;
                        END;

                        IF ("Mfg. Lot No." = '') THEN
                            IF LotNoInfo.GET("No.", "Variant Code", "Lot No.") THEN
                                "Mfg. Lot No." := LotNoInfo."Mfg. Lot No.";
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    TestPackageLine.SETRANGE("Package No.", "No.");
                    IF NOT TestPackageLine.FIND('-') THEN
                        CurrReport.SKIP;

                    FormatAddress.FormatAddr(ShipToAddress, "Posted Package"."Ship-to Name", "Posted Package"."Ship-to Name 2", "Posted Package"."Ship-to Contact",//BC Upgrade 2025-06-23
                                                "Posted Package"."Ship-to Address", "Posted Package"."Ship-to Address 2", "Posted Package"."Ship-to City",//BC Upgrade 2025-06-23
                                                "Posted Package"."Ship-to ZIP Code", "Posted Package"."Ship-to State", "Posted Package"."Ship-to Country Code");//BC Upgrade 2025-06-23
                                                                                                                                                                //FormatAddress.PostedPackageShipTo(ShipToAddress, "Posted Package");//BC Upgrade 2025-06-23

                    FormatAddress.SalesShptBillTo(BillToAddress, ShipToAddress, "Sales Shipment Header");//BC Upgrade 2025-06-23

                    //>> NF1.00:CIS.CM  08-22-15
                    PostedPackageCount += 1;
                    IF PostedPackageCount > 1 THEN
                        PostedPackageShow := FALSE;
                    //<< NF1.00:CIS.CM  08-22-15
                end;
            }
            dataitem("Sales Comment Line"; "Sales Comment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                column(Sales_Comment_Line_Comment; Comment)
                {
                }
                column(Sales_Comment_Line_Document_Type; "Document Type")
                {
                }
                column(Sales_Comment_Line_No_; "No.")
                {
                }
                column(Sales_Comment_Line_Line_No_; "Line No.")
                {
                }
                column(DocumentLineNo_SalesCommentLine; "Document Line No.")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                PostedPackage2.RESET;
                //>>IST 081208 CCL $12797 #12797
                //PostedPackage2.SETCURRENTKEY("Sales Shipment No.");
                //PostedPackage2.SETRANGE("Sales Shipment No.","No.");
                PostedPackage2.SETCURRENTKEY("Source Type", "Source Subtype", "Posted Source ID");
                PostedPackage2.SETRANGE("Source Type", DATABASE::"Sales Header");
                PostedPackage2.SETRANGE("Posted Source ID", "No.");
                //<<IST 081208 CCL $12797 #12797
                //>> NIF 06/07/05
                //PostedPkgCount := PostedPackage2.COUNT;
                PostedPkgCount := 0;
                IF PostedPackage2.FIND('-') THEN
                    REPEAT
                        PostedPkgCount := PostedPkgCount + ROUND(PostedPackage2.GetTotalParcels, 1, '>');
                    UNTIL PostedPackage2.NEXT = 0;
                //<< NIF 06/07/05

                //>> NIF
                CLEAR(LocationAddress);
                IF Location.GET("Location Code") THEN BEGIN
                    LocationAddress[1] := Location.Name;
                    LocationAddress[2] := Location."Name 2";
                    LocationAddress[3] := Location.Address;
                    LocationAddress[4] := Location."Address 2";
                    LocationAddress[5] := Location.City + ',' + Location.County + ' ' + Location."Post Code";
                    LocationAddress[6] := '';
                    COMPRESSARRAY(LocationAddress);
                END;
                //<< NIF

                //>> NF1.00:CIS.CM  08-22-15
                PostedPackageShow := TRUE;
                PostedPackageCount := 0;
                //<< NF1.00:CIS.CM  08-22-15
            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.GET;
                CompanyInformation.CALCFIELDS("Document Logo");
            end;
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
        PostedPackage2: Record "Posted Package";//"14000704";//BC Upgrade 2025-06-23
        FormatAddress: Codeunit "Format Address";
        ShipToAddress: array[8] of Text[50];
        PostedPkgCount: Decimal;
        BillToAddress: array[8] of Text[50];
        CompanyInformation: Record "Company Information";
        LocationAddress: array[7] of Text[50];
        Location: Record Location;
        LotNoInfo: Record "Lot No. Information";
        Packs: Decimal;
        Item: Record Item;
        UseNo: Text[30];
        TestPackageLine: Record "Posted Package Line";//"14000705";//BC Upgrade 2025-06-23
        UnitsPerParcel: Decimal;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        O_R_D_E_R____P_A_C_K____L_I_S_TCaptionLbl: Label 'O R D E R    P A C K    L I S T';
        Customer_PO_CaptionLbl: Label 'Customer PO:';
        Customer_ID_CaptionLbl: Label 'Customer ID:';
        Sales_Shipment_Header__Sales_Shipment_Header___Location_Code_CaptionLbl: Label 'Location Code:';
        Sales_Order_No_CaptionLbl: Label 'Sales Order No.';
        Shipment_No__CaptionLbl: Label 'Shipment No.:';
        SoldCaptionLbl: Label 'Sold';
        To_CaptionLbl: Label 'To:';
        ShipCaptionLbl: Label 'Ship';
        To_Caption_Control1000000035Lbl: Label 'To:';
        Posted_Package__Packing_Date_CaptionLbl: Label 'Packing Date:';
        Total_Packages_CaptionLbl: Label 'Total Packages:';
        Closed_by_Packing_StationCaptionLbl: Label 'Closed by Packing Station';
        Package_No_CaptionLbl: Label 'Package No.';
        Sales_Shipment_Header___Shipment_Method_Code_CaptionLbl: Label 'Shipment Method';
        TypeCaptionLbl: Label 'Type';
        No_CaptionLbl: Label 'No.';
        DescriptionCaptionLbl: Label 'Description';
        UOMCaptionLbl: Label 'UOM';
        QuantityCaptionLbl: Label 'Quantity';
        Lot_No_CaptionLbl: Label 'Lot No.';
        PacksCaptionLbl: Label 'Packs';
        SNPCaptionLbl: Label 'SNP';
        Cross_Reference_No__CaptionLbl: Label 'Cross-Reference No.:';
        Customer_PO_No_CaptionLbl: Label 'Customer PO No.';
        Certificate_No_CaptionLbl: Label 'Certificate No:';
        Drawing_No__CaptionLbl: Label 'Drawing No.:';
        PostedPackageShow: Boolean;
        PostedPackageCount: Integer;
}

