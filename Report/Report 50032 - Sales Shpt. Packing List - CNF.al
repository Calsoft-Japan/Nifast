report 50032 "Sales Shpt. Packing List - CNF"
{
    // NF1.00:CIS.CM  08-25-15 Merged during upgrade
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
    // istrtt 052506 new vars ASNValue and ASNCaption
    //               -added to Header section
    //               -code at Sales Shipment Header - OnAfterGetRecord()
    // <<IST
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = '.\RDLC\Sales Shpt. Packing List - CNF.rdlc';
    Caption = 'Sales Shipment Packing List - CNF';
    UsageCategory = ReportsAndAnalysis;


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
            column(ASNCaption; ASNCaption)
            {
            }
            column(ASNValue; ASNValue)
            {
            }
            column(CompanyInfo_Name2; CompanyInformation."Name 2")
            {
            }
            dataitem("Posted Package"; "Posted Package")//Table14000704) BC Upgrade 2025-06-24
            {
                DataItemLink = "Posted Source ID" = FIELD("No.");
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
                column(Posted_Package__Packing_Date_; FORMAT("Packing Date"))
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
                dataitem(DataItem4761; "Posted Package Line")//Table14000705) BC Upgrade 2025-06-24
                {
                    DataItemLink = "Package No." = FIELD("No.");
                    DataItemTableView = SORTING("Package No.", "Line No.");

                    trigger OnAfterGetRecord()
                    var
                        ItemCrossRef: Record "Item Reference";//"Item Cross Reference"; Upgrade 2025-06-2
                    begin
                        //>> RTT 06-14-05
                        IF "Cross Reference No." = '' THEN BEGIN
                            ItemCrossRef.RESET;
                            ItemCrossRef.SETRANGE("Reference Type", ItemCrossRef."Reference Type"::Customer);// BC Upgrade 2025-06-23
                            ItemCrossRef.SETRANGE("Reference Type No.", "Posted Package"."Ship-to No.");// BC Upgrade 2025-06-23
                            //ItemCrossRef.SETRANGE("Cross-Reference Type", ItemCrossRef."Cross-Reference Type"::Customer);// BC Upgrade 2025-06-23
                            //ItemCrossRef.SETRANGE("Cross-Reference Type No.", "Posted Package"."Ship-to No.");// BC Upgrade 2025-06-23
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
                dataitem("Sales Shipment Line"; "Sales Shipment Line")
                {
                    DataItemLink = "Document No." = FIELD("Posted Source ID");
                    DataItemTableView = SORTING("Document No.", "Line No.")
                                        WHERE(Type = CONST(Item),
                                              Quantity = FILTER(<> 0));
                    column(DocumentNo_SalesShipmentLine; "Sales Shipment Line"."Document No.")
                    {
                    }
                    column(LineNo_SalesShipmentLine; "Sales Shipment Line"."Line No.")
                    {
                    }
                    column(Type_SalesShipmentLine; "Sales Shipment Line".Type)
                    {
                    }
                    column(UseNo; UseNo)
                    {
                    }
                    column(Description_SalesShipmentLine; "Sales Shipment Line".Description)
                    {
                    }
                    column(Quantity_SalesShipmentLine; "Sales Shipment Line".Quantity)
                    {
                    }
                    column(UnitofMeasureCode_SalesShipmentLine; "Sales Shipment Line"."Unit of Measure Code")
                    {
                    }
                    column(Packs; Packs)
                    {
                    }
                    column(UnitsPerParcel; UnitsPerParcel)
                    {
                    }
                    column(CrossReferenceNo_SalesShipmentLine; "Sales Shipment Line"."Item Reference No.")//"Cross-Reference No."; BC Upgrade 2025-06-23
                    {
                    }
                    column(ExternalDocumentNo_SalesShipmentLine; "Sales Shipment Header"."External Document No.")//"Sales Shipment Line"."External Document No." BC Upgrade 2025-06-23
                    {
                    }
                    column(CertificateNo_SalesShipmentLine; "Sales Shipment Line"."Certificate No.")
                    {
                    }
                    column(RanNo_SalesShipmentLine; "Sales Shipment Line"."Ran No.")
                    {
                    }
                    column(ReleaseNo_SalesShipmentLine; "Sales Shipment Line"."Release No.")
                    {
                    }
                    column(DrawingNo_SalesShipmentLine; "Sales Shipment Line"."Drawing No.")
                    {
                    }
                    column(RevisionNo_SalesShipmentLine; "Sales Shipment Line"."Revision No.")
                    {
                    }
                    column(RevisionDate_SalesShipmentLine; FORMAT("Sales Shipment Line"."Revision Date"))
                    {
                    }
                    column(Cross_Reference_No__Caption; Cross_Reference_No__CaptionLbl)
                    {
                    }
                    column(Customer_PO_No_Caption; Customer_PO_No_CaptionLbl)
                    {
                    }
                    column(Certificate_No_Caption; Certificate_No_CaptionLbl)
                    {
                    }
                    column(SalesShptLine__Ran_No__Caption; FIELDCAPTION("Ran No."))
                    {
                    }
                    column(SalesShptLine__Release_No__Caption; FIELDCAPTION("Release No."))
                    {
                    }
                    column(SalesShptLine__Revision_Date_Caption; FIELDCAPTION("Revision Date"))
                    {
                    }
                    column(SalesShptLine__Revision_No__Caption; FIELDCAPTION("Revision No."))
                    {
                    }
                    column(Drawing_No__Caption; Drawing_No__CaptionLbl)
                    {
                    }
                    column(EntryRelFound; EntryRelFound)
                    {
                    }
                    column(MfgLotNo_LotNoInfo_SalesShptLine; LotNoInfo."Mfg. Lot No.")
                    {
                    }
                    dataitem("Item Entry Relation"; "Item Entry Relation")
                    {
                        DataItemLink = "Source ID" = FIELD("Document No."),
                                       "Source Ref. No." = FIELD("Line No.");
                        DataItemTableView = SORTING("Source ID", "Source Type", "Source Subtype", "Source Ref. No.", "Source Prod. Order Line", "Source Batch Name")
                                            WHERE("Source Type" = CONST(111),
                                                  "Source Subtype" = CONST(0));
                        column(ItemEntryNo_ItemEntryRelation; "Item Entry No.")
                        {
                        }
                        column(LotNo_ItemEntryRelation; "Item Entry Relation"."Lot No.")
                        {
                        }
                        column(UseQuantity; UseQuantity)
                        {
                        }
                        column(UseDescription; UseDescription)
                        {
                        }
                        column(Mfg_Lot_No_Lbl; Mfg_Lot_No_Lbl)
                        {
                        }
                        column(MfgLotNo_LotNoInfo; LotNoInfo."Mfg. Lot No.")
                        {
                        }

                        trigger OnAfterGetRecord()
                        var
                            ItemCrossRef: Record "Item Reference";//"Item Cross Reference"; Upgrade 2025-06-23
                        begin
                            IF NOT LotNoInfo.GET("Sales Shipment Line"."No.", "Sales Shipment Line"."Variant Code", "Lot No.") THEN
                                CLEAR(LotNoInfo);

                            IF NOT ItemLedgEntry.GET("Item Entry No.") THEN
                                CLEAR(ItemLedgEntry);

                            UseQuantity := -ItemLedgEntry.Quantity;

                            ItemCrossRef.RESET;
                            ItemCrossRef.SETRANGE("Reference Type", ItemCrossRef."Reference Type"::Customer);// BC Upgrade 2025-06-23
                            ItemCrossRef.SETRANGE("Reference Type No.", "Sales Shipment Header"."Sell-to Customer No.");// BC Upgrade 2025-06-23
                            //ItemCrossRef.SETRANGE("Cross-Reference Type", ItemCrossRef."Cross-Reference Type"::Customer);// BC Upgrade 2025-06-23
                            //ItemCrossRef.SETRANGE("Cross-Reference Type No.", "Sales Shipment Header"."Sell-to Customer No.");// BC Upgrade 2025-06-23
                            ItemCrossRef.SETRANGE("Item No.", "Sales Shipment Line"."No.");
                            IF NOT ItemCrossRef.FIND('-') THEN
                                CLEAR(ItemCrossRef);
                            IF "Sales Shipment Line"."Item Reference No." = '' THEN// BC Upgrade 2025-06-23
                                "Sales Shipment Line"."Item Reference No." := ItemCrossRef."Reference No.";// BC Upgrade 2025-06-23
                            IF ItemCrossRef.Description <> '' THEN
                                UseDescription := ItemCrossRef.Description;

                            // ELSE
                            //    UseDescription := "Sales Shipment Line".Description;

                            IF ("Sales Shipment Line"."Item Reference No." = '') THEN// BC Upgrade 2025-06-23
                                UseNo := "Sales Shipment Line"."No."
                            ELSE
                                UseNo := "Sales Shipment Line"."Item Reference No.";// BC Upgrade 2025-06-23

                            IF (Item.GET("Sales Shipment Line"."No.")) AND (Item."Units per Parcel" <> 0) THEN BEGIN
                                Packs := UseQuantity / Item."Units per Parcel";
                                UnitsPerParcel := Item."Units per Parcel";
                            END ELSE BEGIN
                                Packs := 0;
                                UnitsPerParcel := 0;
                            END;
                        end;
                    }

                    trigger OnAfterGetRecord()
                    var
                        ItemCrossRef: Record "Item Reference";//"Item Cross Reference"; Upgrade 2025-06-23
                    begin
                        ItemEntryRel.SETCURRENTKEY("Source ID", "Source Type", "Source Subtype", "Source Ref. No.");
                        ItemEntryRel.SETRANGE("Source ID", "Sales Shipment Line"."Document No.");
                        ItemEntryRel.SETRANGE("Source Type", 111);
                        ItemEntryRel.SETRANGE("Source Subtype", 0);
                        ItemEntryRel.SETRANGE("Source Ref. No.", "Sales Shipment Line"."Line No.");
                        EntryRelFound := ItemEntryRel.FIND('-');

                        IF NOT EntryRelFound THEN BEGIN
                            IF "Item Reference No." = '' THEN BEGIN //"Cross-Reference No." Upgrade 2025-06-23
                                ItemCrossRef.RESET;
                                ItemCrossRef.SETRANGE("Reference Type", ItemCrossRef."Reference Type"::Customer);//"Cross-Reference No." Upgrade 2025-06-23
                                ItemCrossRef.SETRANGE("Reference Type No.", "Posted Package"."Ship-to No.");//"Cross-Reference No." Upgrade 2025-06-23
                                ItemCrossRef.SETRANGE("Item No.", "No.");
                                IF NOT ItemCrossRef.FIND('-') THEN
                                    CLEAR(ItemCrossRef);
                                "Item Reference No." := ItemCrossRef."Reference No.";//"Cross-Reference No." Upgrade 2025-06-23
                            END;

                            IF ("Item Reference No." = '') THEN//"Cross-Reference No." Upgrade 2025-06-23
                                UseNo := "No."
                            ELSE
                                UseNo := "Item Reference No.";//"Cross-Reference No." Upgrade 2025-06-23

                            IF (Item.GET("No.")) AND (Item."Units per Parcel" <> 0) THEN BEGIN
                                Packs := Quantity / Item."Units per Parcel";
                                UnitsPerParcel := Item."Units per Parcel";
                            END ELSE BEGIN
                                Packs := 0;
                                UnitsPerParcel := 0;
                            END;
                        END;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    TestPackageLine.SETRANGE("Package No.", "No.");
                    IF NOT TestPackageLine.FIND('-') THEN
                        CurrReport.SKIP;
                    //FormatAddress.PostedPackageShipTo(ShipToAddress, "Posted Package");//BC Upgrade 2025-06-23
                    FormatAddress.FormatAddr(ShipToAddress, "Posted Package"."Ship-to Name", "Posted Package"."Ship-to Name 2", "Posted Package"."Ship-to Contact",//BC Upgrade 2025-06-23
                                                "Posted Package"."Ship-to Address", "Posted Package"."Ship-to Address 2", "Posted Package"."Ship-to City",//BC Upgrade 2025-06-23
                                                "Posted Package"."Ship-to ZIP Code", "Posted Package"."Ship-to State", "Posted Package"."Ship-to Country Code");//BC Upgrade 2025-06-23

                    FormatAddress.SalesShptBillTo(BillToAddress, ShipToAddress, "Sales Shipment Header");//BC Upgrade 2025-06-23
                end;
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
                //>> NIF 052506 RTT
                PackingRule.GetPackingRule(0, "Sell-to Customer No.", "Ship-to Code");  //0=customer
                IF (PackingRule."ASN Summary Type" <> PackingRule."ASN Summary Type"::" ") AND ("EDI Control No." <> '') THEN BEGIN
                    ASNCaption := FIELDNAME("EDI Control No.");
                    ASNValue := "EDI Control No.";
                END ELSE BEGIN
                    ASNCaption := '';
                    ASNValue := '';
                END;
                //<< NIF 052606 RTT
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
        PostedPackage2: Record "Posted Package"; //"14000704"; BC Upgrade 2025-06-23
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
        TestPackageLine: Record "Posted Package Line"; //"14000705";BC Upgrade 2025-06-23
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
        PackingRule: Record "Packing Rule";//"14000715";
        ASNCaption: Text[30];
        ASNValue: Code[20];
        ItemEntryRel: Record "Item Entry Relation";
        EntryRelFound: Boolean;
        ItemLedgEntry: Record "Item Ledger Entry";
        UseQuantity: Decimal;
        UseDescription: Text[50];
        Mfg_Lot_No_Lbl: Label 'Mfg. Lot No.';
}

