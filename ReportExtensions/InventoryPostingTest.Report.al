report 50015 "Inventory Posting - Test New"
{
    // NF1.00:CIS.NG  07/30/15 Merged during upgrade
    // NIF 12-14-05 added Lot No.
    //              -changed Right Margin from 2000 to 150
    //              -new var LotString
    //              -new fcn GetLotString
    //              -code at Item Journal Line - OnAfterGetRecord
    DefaultLayout = RDLC;
    RDLCLayout = '.\RDLC\InventoryPostingTest.rdlc';

    Caption = 'Inventory Posting - Test New';
    ApplicationArea=all;
    UsageCategory=ReportsAndAnalysis;

    dataset
    {
        dataitem("Item Journal Batch"; "Item Journal Batch")
        {
            DataItemTableView = SORTING("Journal Template Name", Name);
            RequestFilterFields = "Journal Template Name", Name;
            column(Item_Journal_Batch_Journal_Template_Name; "Journal Template Name")
            {
            }
            column(Item_Journal_Batch_Name; Name)
            {
            }
            column(Format_Today; FORMAT(TODAY, 0, 4))
            {
            }
            column(TIME; TIME)
            {
            }
            dataitem("Item Journal Line"; "Item Journal Line")
            {
                DataItemLink = "Journal Template Name" = FIELD("Journal Template Name"),
                               "Journal Batch Name" = FIELD(Name);
                DataItemTableView = SORTING("Journal Template Name", "Journal Batch Name", "Line No.");
                RequestFilterFields = "Posting Date";
                column(COMPANYNAME; COMPANYNAME)
                {
                }
                column(CurrReport_PAGENO; CurrReport.PAGENO())
                {
                }
                column(Item_Journal_Line__Journal_Template_Name_; "Journal Template Name")
                {
                }
                column(Item_Journal_Line__Journal_Batch_Name_; "Journal Batch Name")
                {
                }
                column(Item_Journal_Line__TABLECAPTION__________ItemJnlLineFilter; TABLECAPTION + ': ' + ItemJnlLineFilter)
                {
                }
                column(ItemJnlLineFilter; ItemJnlLineFilter)
                {
                }
                column(ItemLineEntryType; ItemLineEntryType)
                {
                }
                column(JnlTemplateType; JnlTemplateType)
                {
                }
                column(Item_Journal_Line__Item_Journal_Line___Line_No__; "Line No.")
                {
                }
                column(TotalCostAm1; TotalCostAm1)
                {
                }
                column(TotalCostAm2; TotalCostAm2)
                {
                }
                column(TotalCostAm3; TotalCostAm3)
                {
                }
                column(TotalCostAm4; TotalCostAm4)
                {
                }
                column(TotalCostAm5; TotalCostAm5)
                {
                }
                column(TotalAm1; TotalAm1)
                {
                }
                column(TotalAm2; TotalAm2)
                {
                }
                column(TotalAm3; TotalAm3)
                {
                }
                column(TotalAm4; TotalAm4)
                {
                }
                column(TotalAm5; TotalAm5)
                {
                }
                column(Item_Journal_Line__Posting_Date_; FORMAT("Posting Date"))
                {
                }
                column(Item_Journal_Line__Entry_Type_; "Entry Type")
                {
                }
                column(Item_Journal_Line__Item_No__; "Item No.")
                {
                }
                column(Item_Journal_Line_Description; Description)
                {
                }
                column(Item_Journal_Line_Quantity; Quantity)
                {
                }
                column(Item_Journal_Line__Invoiced_Quantity_; "Invoiced Quantity")
                {
                }
                column(Item_Journal_Line__Unit_Amount_; "Unit Amount")
                {
                }
                column(Item_Journal_Line_Amount; Amount)
                {
                }
                column(CostAmount; CostAmount)
                {
                    AutoFormatType = 1;
                }
                column(Item_Journal_Line__Unit_Cost_; "Unit Cost")
                {
                }
                column(Item_Journal_Line_Quantity_Control68; Quantity)
                {
                }
                column(Item_Journal_Line_Description_Control69; Description)
                {
                }
                column(Item_Journal_Line__Source_No__; "Source No.")
                {
                }
                column(Item_Journal_Line__Item_No___Control71; "Item No.")
                {
                }
                column(Item_Journal_Line__Prod__Order_No__; "Order No.")
                {
                }
                column(Item_Journal_Line__Document_No__; "Document No.")
                {
                }
                column(Item_Journal_Line__Output_Quantity_; "Output Quantity")
                {
                }
                column(Item_Journal_Line__Run_Time_; "Run Time")
                {
                }
                column(Item_Journal_Line__Setup_Time_; "Setup Time")
                {
                }
                column(Item_Journal_Line_Description_Control59; Description)
                {
                }
                column(Item_Journal_Line__No__; "No.")
                {
                }
                column(Item_Journal_Line_Type; Type)
                {
                }
                column(Item_Journal_Line__Operation_No__; "Operation No.")
                {
                }
                column(Item_Journal_Line__Unit_Cost__Control99; "Unit Cost")
                {
                }
                column(Item_Journal_Line__Stop_Code_; "Stop Code")
                {
                }
                column(Item_Journal_Line__Scrap_Code_; "Scrap Code")
                {
                }
                column(Item_Journal_Line__Stop_Time_; "Stop Time")
                {
                }
                column(NoOfEntries_5_; NoOfEntries[5])
                {
                }
                column(NoOfEntries_4_; NoOfEntries[4])
                {
                }
                column(NoOfEntries_3_; NoOfEntries[3])
                {
                }
                column(NoOfEntries_2_; NoOfEntries[2])
                {
                }
                column(NoOfEntries_1_; NoOfEntries[1])
                {
                }
                column(EntryTypeDescription_1_; EntryTypeDescription[1])
                {
                }
                column(TotalCostAmounts_1_; TotalCostAmounts[1])
                {
                    AutoFormatType = 1;
                }
                column(EntryTypeDescription_2_; EntryTypeDescription[2])
                {
                }
                column(TotalCostAmounts_2_; TotalCostAmounts[2])
                {
                    AutoFormatType = 1;
                }
                column(EntryTypeDescription_3_; EntryTypeDescription[3])
                {
                }
                column(TotalCostAmounts_3_; TotalCostAmounts[3])
                {
                    AutoFormatType = 1;
                }
                column(EntryTypeDescription_4_; EntryTypeDescription[4])
                {
                }
                column(TotalCostAmounts_4_; TotalCostAmounts[4])
                {
                    AutoFormatType = 1;
                }
                column(EntryTypeDescription_5_; EntryTypeDescription[5])
                {
                }
                column(TotalCostAmounts_5_; TotalCostAmounts[5])
                {
                    AutoFormatType = 1;
                }
                column(TotalAmount; TotalAmount)
                {
                    AutoFormatType = 1;
                }
                column(TotalCostAmount; TotalCostAmount)
                {
                    AutoFormatType = 1;
                }
                column(LotString; LotString)
                {
                }
                column(Inventory_Posting___TestCaption; Inventory_Posting___TestCaptionLbl)
                {
                }
                column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                {
                }
                column(Item_Journal_Line__Journal_Template_Name_Caption; FIELDCAPTION("Journal Template Name"))
                {
                }
                column(Item_Journal_Line__Journal_Batch_Name_Caption; FIELDCAPTION("Journal Batch Name"))
                {
                }
                column(Item_Journal_Line__Posting_Date_Caption; Item_Journal_Line__Posting_Date_CaptionLbl)
                {
                }
                column(Item_Journal_Line__Entry_Type_Caption; Item_Journal_Line__Entry_Type_CaptionLbl)
                {
                }
                column(Item_Journal_Line__Item_No__Caption; FIELDCAPTION("Item No."))
                {
                }
                column(Item_Journal_Line_DescriptionCaption; FIELDCAPTION(Description))
                {
                }
                column(Item_Journal_Line_QuantityCaption; FIELDCAPTION(Quantity))
                {
                }
                column(Item_Journal_Line__Invoiced_Quantity_Caption; FIELDCAPTION("Invoiced Quantity"))
                {
                }
                column(Item_Journal_Line__Unit_Amount_Caption; FIELDCAPTION("Unit Amount"))
                {
                }
                column(Item_Journal_Line_AmountCaption; FIELDCAPTION(Amount))
                {
                }
                column(CostAmountCaption; CostAmountCaptionLbl)
                {
                }
                column(Item_Journal_Line__Unit_Cost_Caption; FIELDCAPTION("Unit Cost"))
                {
                }
                column(Item_Journal_Line_Quantity_Control68Caption; FIELDCAPTION(Quantity))
                {
                }
                column(Item_Journal_Line_Description_Control69Caption; FIELDCAPTION(Description))
                {
                }
                column(Item_Journal_Line__Source_No__Caption; FIELDCAPTION("Source No."))
                {
                }
                column(Item_Journal_Line__Item_No___Control71Caption; FIELDCAPTION("Item No."))
                {
                }
                column(Item_Journal_Line__Prod__Order_No__Caption; FIELDCAPTION("Order No."))
                {
                }
                column(Item_Journal_Line__Document_No__Caption; FIELDCAPTION("Document No."))
                {
                }
                column(Item_Journal_Line__Operation_No__Caption; FIELDCAPTION("Operation No."))
                {
                }
                column(Item_Journal_Line_TypeCaption; FIELDCAPTION(Type))
                {
                }
                column(Item_Journal_Line__No__Caption; FIELDCAPTION("No."))
                {
                }
                column(Item_Journal_Line_Description_Control59Caption; FIELDCAPTION(Description))
                {
                }
                column(Item_Journal_Line__Setup_Time_Caption; FIELDCAPTION("Setup Time"))
                {
                }
                column(Item_Journal_Line__Run_Time_Caption; FIELDCAPTION("Run Time"))
                {
                }
                column(Item_Journal_Line__Output_Quantity_Caption; FIELDCAPTION("Output Quantity"))
                {
                }
                column(Item_Journal_Line__Unit_Cost__Control99Caption; FIELDCAPTION("Unit Cost"))
                {
                }
                column(Item_Journal_Line__Stop_Time_Caption; FIELDCAPTION("Stop Time"))
                {
                }
                column(Item_Journal_Line__Scrap_Code_Caption; FIELDCAPTION("Scrap Code"))
                {
                }
                column(Item_Journal_Line__Stop_Code_Caption; FIELDCAPTION("Stop Code"))
                {
                }
                column(TotalAmountCaption; TotalAmountCaptionLbl)
                {
                }
                dataitem(DimensionLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = FILTER(1 ..));
                    column(DimText; DimText)
                    {
                    }
                    column(DimensionLoop_Number; Number)
                    {
                    }
                    column(DimensionsCaption; DimensionsCaptionLbl)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF Number = 1 THEN BEGIN
                            IF NOT DimSetEntry.FINDSET() THEN
                                CurrReport.BREAK();
                        END ELSE
                            IF NOT Continue THEN
                                CurrReport.BREAK();

                        CLEAR(DimText);
                        Continue := FALSE;
                        REPEAT
                            OldDimText := DimText;
                            IF DimText = '' THEN
                                DimText := STRSUBSTNO('%1 - %2', DimSetEntry."Dimension Code", DimSetEntry."Dimension Value Code")
                            ELSE
                                DimText :=
                                  STRSUBSTNO(
                                    '%1; %2 - %3', DimText, DimSetEntry."Dimension Code", DimSetEntry."Dimension Value Code");
                            IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                DimText := OldDimText;
                                Continue := TRUE;
                                EXIT;
                            END;
                        UNTIL DimSetEntry.NEXT() = 0;
                    end;

                    trigger OnPreDataItem()
                    begin
                        IF NOT ShowDim THEN
                            CurrReport.BREAK();
                        DimSetEntry.SETRANGE("Dimension Set ID", "Item Journal Line"."Dimension Set ID");
                    end;
                }
                dataitem(ErrorLoop; Integer)
                {
                    DataItemTableView = SORTING(Number);
                    column(ErrorText_Number_; ErrorText[Number])
                    {
                    }
                    column(ErrorText_Number_Caption; ErrorText_Number_CaptionLbl)
                    {
                    }

                    trigger OnPostDataItem()
                    begin
                        ErrorCounter := 0;
                    end;

                    trigger OnPreDataItem()
                    begin
                        SETRANGE(Number, 1, ErrorCounter);
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    ItemJnlLine2: Record "Item Journal Line";
                    ItemJnlLine3: Record "Item Journal Line";
                    ItemJnlLine4: Record "Item Journal Line";
                    InvtPeriodEndDate: Date;
                    QtyToPostBase: Decimal;
                begin
                    //>> NIF
                    IF NOT Item.GET("Item No.") THEN
                        CLEAR(Item);
                    LotString := GetLotString();
                    //<< NIF

                    NoOfEntries["Entry Type" + 1] := 1;
                    TotalAmounts["Entry Type" + 1] := Amount;

                    CostAmount := "Unit Cost" * Quantity;
                    TotalCostAmounts["Entry Type" + 1] := CostAmount;

                    IF "Entry Type" IN
                       ["Entry Type"::Purchase,
                        "Entry Type"::"Positive Adjmt.",
                        "Entry Type"::Output]
                    THEN BEGIN
                        TotalAmount := TotalAmount + Amount;
                        TotalCostAmount := TotalCostAmount + CostAmount;
                    END ELSE BEGIN
                        TotalAmount := TotalAmount - Amount;
                        TotalCostAmount := TotalCostAmount - CostAmount;
                    END;

                    IF ("Item No." = '') AND (Quantity = 0) THEN
                        EXIT;

                    QtyError := FALSE;

                    MakeRecurringTexts("Item Journal Line");

                    IF EmptyLine() THEN BEGIN
                        IF NOT IsValueEntryForDeletedItem() THEN
                            AddError(STRSUBSTNO(Text001, FIELDCAPTION("Item No.")))
                    END ELSE
                        IF NOT Item.GET("Item No.") THEN
                            AddError(
                              STRSUBSTNO(
                                Text002,
                                Item.TABLECAPTION, "Item No."))
                        ELSE BEGIN
                            IF Item.Blocked THEN
                                AddError(
                                  STRSUBSTNO(
                                    Text003,
                                    Item.FIELDCAPTION(Blocked), FALSE, Item.TABLECAPTION, "Item No."));
                        END;

                    CheckRecurringLine("Item Journal Line");

                    IF "Posting Date" = 0D THEN
                        AddError(STRSUBSTNO(Text001, FIELDCAPTION("Posting Date")))
                    ELSE BEGIN
                        IF "Posting Date" <> NORMALDATE("Posting Date") THEN
                            AddError(STRSUBSTNO(Text005, FIELDCAPTION("Posting Date")));

                        IF "Item Journal Batch"."No. Series" <> '' THEN
                            IF NoSeries."Date Order" AND ("Posting Date" < LastPostingDate) THEN
                                AddError(Text006);
                        LastPostingDate := "Posting Date";

                        IF (AllowPostingFrom = 0D) AND (AllowPostingTo = 0D) THEN BEGIN
                            IF USERID <> '' THEN
                                IF UserSetup.GET(USERID) THEN BEGIN
                                    AllowPostingFrom := UserSetup."Allow Posting From";
                                    AllowPostingTo := UserSetup."Allow Posting To";
                                END;
                            IF (AllowPostingFrom = 0D) AND (AllowPostingTo = 0D) THEN BEGIN
                                AllowPostingFrom := GLSetup."Allow Posting From";
                                AllowPostingTo := GLSetup."Allow Posting To";
                            END;
                            IF AllowPostingTo = 0D THEN
                                AllowPostingTo := 99991231D;
                        END;

                        IF ("Posting Date" < AllowPostingFrom) OR ("Posting Date" > AllowPostingTo) THEN
                            AddError(
                              STRSUBSTNO(
                                Text007, FORMAT("Posting Date")))
                        ELSE BEGIN
                            InvtPeriodEndDate := "Posting Date";
                            IF NOT InvtPeriod.IsValidDate(InvtPeriodEndDate) THEN
                                AddError(
                                  STRSUBSTNO(
                                    Text007, FORMAT("Posting Date")))
                        END;
                    END;

                    IF "Document Date" <> 0D THEN
                        IF "Document Date" <> NORMALDATE("Document Date") THEN
                            AddError(STRSUBSTNO(Text005, FIELDCAPTION("Document Date")));

                    IF "Gen. Prod. Posting Group" = '' THEN
                        AddError(STRSUBSTNO(Text001, FIELDCAPTION("Gen. Prod. Posting Group")))
                    ELSE
                        IF NOT GenPostingSetup.GET("Gen. Bus. Posting Group", "Gen. Prod. Posting Group") THEN
                            AddError(
                              STRSUBSTNO(
                                Text008, GenPostingSetup.TABLECAPTION,
                                "Gen. Bus. Posting Group", "Gen. Prod. Posting Group"));

                    IF InvtSetup."Location Mandatory" THEN BEGIN
                        IF "Location Code" = '' THEN
                            AddError(STRSUBSTNO(Text001, FIELDCAPTION("Location Code")));
                        IF "Entry Type" = "Entry Type"::Transfer THEN
                            IF "New Location Code" = '' THEN
                                AddError(STRSUBSTNO(Text001, FIELDCAPTION("New Location Code")));
                    END;

                    IF "Entry Type" IN ["Entry Type"::"Positive Adjmt.", "Entry Type"::"Negative Adjmt."] THEN
                        IF "Discount Amount" <> 0 THEN
                            AddError(STRSUBSTNO(Text009, FIELDCAPTION("Discount Amount")));

                    IF "Entry Type" = "Entry Type"::Transfer THEN BEGIN
                        IF Amount <> 0 THEN
                            AddError(
                              STRSUBSTNO(
                                Text011,
                                FIELDCAPTION(Amount), FIELDCAPTION("Entry Type"), FORMAT("Entry Type")));
                        IF "Discount Amount" <> 0 THEN
                            AddError(
                              STRSUBSTNO(
                                Text011,
                                FIELDCAPTION("Discount Amount"), FIELDCAPTION("Entry Type"), FORMAT("Entry Type")));
                        IF Quantity < 0 THEN
                            AddError(
                              STRSUBSTNO(
                                Text012,
                                FIELDCAPTION(Quantity), FIELDCAPTION("Entry Type"), FORMAT("Entry Type")));
                        IF Quantity <> "Invoiced Quantity" THEN
                            AddError(
                              STRSUBSTNO(
                                Text013,
                                FIELDCAPTION("Invoiced Quantity"), FIELDCAPTION(Quantity),
                                FIELDCAPTION("Entry Type"), FORMAT("Entry Type")));
                    END;

                    IF NOT "Phys. Inventory" THEN BEGIN
                        IF "Qty. (Calculated)" <> 0 THEN
                            AddError(
                              STRSUBSTNO(
                                Text011,
                                FIELDCAPTION("Qty. (Calculated)"), FIELDCAPTION("Phys. Inventory"), FORMAT("Phys. Inventory")));
                        IF "Qty. (Phys. Inventory)" <> 0 THEN
                            AddError(
                              STRSUBSTNO(
                                Text011,
                                FIELDCAPTION("Qty. (Phys. Inventory)"), FIELDCAPTION("Phys. Inventory"), FORMAT("Phys. Inventory")));
                    END ELSE BEGIN
                        IF NOT ("Entry Type" IN ["Entry Type"::"Positive Adjmt.", "Entry Type"::"Negative Adjmt."]) THEN BEGIN
                            ItemJnlLine2."Entry Type" := ItemJnlLine2."Entry Type"::"Positive Adjmt.";
                            ItemJnlLine3."Entry Type" := ItemJnlLine3."Entry Type"::"Negative Adjmt.";
                            AddError(
                              STRSUBSTNO(
                                Text014,
                                FIELDCAPTION("Entry Type"),
                                FORMAT(ItemJnlLine2."Entry Type"),
                                FORMAT(ItemJnlLine3."Entry Type"),
                                FIELDCAPTION("Phys. Inventory"),
                                TRUE));
                        END;
                        IF ("Entry Type" = "Entry Type"::"Positive Adjmt.") AND
                           ("Qty. (Phys. Inventory)" - "Qty. (Calculated)" <> Quantity)
                        THEN
                            AddError(
                              STRSUBSTNO(
                                Text015,
                                FIELDCAPTION(Quantity),
                                FIELDCAPTION("Qty. (Phys. Inventory)"),
                                FIELDCAPTION("Qty. (Calculated)"),
                                FIELDCAPTION("Entry Type"),
                                FORMAT("Entry Type"),
                                FIELDCAPTION("Phys. Inventory"),
                                TRUE));
                        IF ("Entry Type" = "Entry Type"::"Negative Adjmt.") AND
                           ("Qty. (Calculated)" - "Qty. (Phys. Inventory)" <> Quantity)
                        THEN
                            AddError(
                              STRSUBSTNO(
                                Text015,
                                FIELDCAPTION(Quantity),
                                FIELDCAPTION("Qty. (Calculated)"),
                                FIELDCAPTION("Qty. (Phys. Inventory)"),
                                FIELDCAPTION("Entry Type"),
                                FORMAT("Entry Type"),
                                FIELDCAPTION("Phys. Inventory"),
                                TRUE));
                    END;

                    IF ("Entry Type" IN ["Entry Type"::Output, "Entry Type"::Consumption]) AND ("Order Type" = "Order Type"::Production) AND
                       NOT OnlyStopTime()
                    THEN BEGIN
                        IF "Order No." = '' THEN
                            AddError(STRSUBSTNO(Text001, FIELDCAPTION("Order No.")));
                        IF "Order Line No." = 0 THEN
                            AddError(STRSUBSTNO(Text001, FIELDCAPTION("Order Line No.")));

                        IF "Entry Type" = "Entry Type"::Output THEN
                            IF (("Run Time" = 0) AND ("Setup Time" = 0) AND ("Output Quantity" = 0) AND
                                ("Scrap Quantity" = 0)) AND NOT QtyError
                            THEN BEGIN
                                QtyError := TRUE;
                                AddError(
                                  STRSUBSTNO(Text019,
                                    FIELDCAPTION("Setup Time"),
                                    FIELDCAPTION("Run Time"),
                                    FIELDCAPTION("Output Quantity"), FIELDCAPTION("Scrap Quantity")));
                            END;
                    END;

                    IF "Entry Type" <> "Entry Type"::Output THEN BEGIN
                        IF "Setup Time" <> 0 THEN
                            AddError(STRSUBSTNO(Text009, FIELDCAPTION("Setup Time")));
                        IF "Run Time" <> 0 THEN
                            AddError(STRSUBSTNO(Text009, FIELDCAPTION("Run Time")));
                        IF "Stop Time" <> 0 THEN
                            AddError(STRSUBSTNO(Text009, FIELDCAPTION("Stop Time")));
                        IF "Output Quantity" <> 0 THEN
                            AddError(STRSUBSTNO(Text009, FIELDCAPTION("Output Quantity")));
                        IF "Scrap Quantity" <> 0 THEN
                            AddError(STRSUBSTNO(Text009, FIELDCAPTION("Scrap Quantity")));
                        IF "Concurrent Capacity" <> 0 THEN
                            AddError(STRSUBSTNO(Text009, FIELDCAPTION("Concurrent Capacity")));
                    END;

                    IF (Quantity = 0) AND ("Invoiced Quantity" <> 0) THEN BEGIN
                        IF "Item Shpt. Entry No." = 0 THEN
                            AddError(STRSUBSTNO(Text001, FIELDCAPTION("Item Shpt. Entry No.")));
                    END ELSE BEGIN
                        IF Quantity <> "Invoiced Quantity" THEN
                            IF ("Invoiced Quantity" <> 0) AND NOT QtyError THEN BEGIN
                                QtyError := TRUE;
                                AddError(STRSUBSTNO(Text009, FIELDCAPTION("Invoiced Quantity")));
                            END;
                        IF "Item Shpt. Entry No." <> 0 THEN
                            AddError(STRSUBSTNO(Text016, FIELDCAPTION("Item Shpt. Entry No.")));
                    END;

                    IF "Item Journal Batch"."No. Series" <> '' THEN BEGIN
                        IF LastDocNo <> '' THEN
                            IF ("Document No." <> LastDocNo) AND ("Document No." <> INCSTR(LastDocNo)) THEN
                                AddError(Text017);
                        LastDocNo := "Document No.";
                    END;

                    DimSetEntry.SETRANGE("Dimension Set ID", "Dimension Set ID");
                    IF NOT DimMgt.CheckDimIDComb("Dimension Set ID") THEN
                        AddError(DimMgt.GetDimCombErr());

                    TableID[1] := DATABASE::Item;
                    No[1] := "Item No.";
                    TableID[2] := DATABASE::"Salesperson/Purchaser";
                    No[2] := "Salespers./Purch. Code";
                    IF NOT DimMgt.CheckDimValuePosting(TableID, No, "Dimension Set ID") THEN
                        AddError(DimMgt.GetDimValuePostingErr());

                    IF (ItemJnlTemplate.Type IN
                        [ItemJnlTemplate.Type::Consumption, ItemJnlTemplate.Type::Transfer]) OR
                       ((ItemJnlTemplate.Type = ItemJnlTemplate.Type::"Prod. Order") AND
                        ("Entry Type" = "Entry Type"::Consumption))
                    THEN BEGIN
                        ItemJnlLine4.RESET();
                        ItemJnlLine4.SETRANGE("Journal Template Name", "Journal Template Name");
                        ItemJnlLine4.SETRANGE("Journal Batch Name", "Journal Batch Name");
                        ItemJnlLine4.SETRANGE("Item No.", "Item No.");
                        ItemJnlLine4.SETRANGE("Location Code", "Location Code");

                        IF ItemJnlLine4.FIND('-') THEN BEGIN
                            QtyToPostBase := 0;
                            REPEAT
                                QtyToPostBase -= ItemJnlLine4.Signed(ItemJnlLine4."Quantity (Base)")
                            UNTIL ItemJnlLine4.NEXT() = 0;

                            Item.GET("Item No.");
                            IF "Location Code" <> '' THEN
                                Item.SETRANGE("Location Filter", "Location Code")
                            ELSE
                                Item.SETFILTER("Location Filter", '%1', '');
                            Item.CALCFIELDS(Inventory);

                            IF Item.Inventory - QtyToPostBase < 0 THEN
                                IF "Location Code" <> '' THEN
                                    AddError(
                                      STRSUBSTNO(
                                        Text020,
                                        Item.TABLECAPTION,
                                        Item."No.",
                                        Location.TABLECAPTION,
                                        "Location Code"))
                                ELSE
                                    AddError(
                                      STRSUBSTNO(
                                        Text021,
                                        Item.TABLECAPTION,
                                        Item."No."));
                        END;
                    END;
                    GetLocation("Location Code");
                    IF Location."Bin Mandatory" AND ("Bin Code" = '') AND
                       NOT Location."Directed Put-away and Pick"
                    THEN
                        AddError(
                          STRSUBSTNO(
                            Text001,
                            FIELDCAPTION("Bin Code")));

                    IF "Entry Type" = "Entry Type"::Transfer THEN BEGIN
                        GetLocation("New Location Code");
                        IF Location."Bin Mandatory" AND ("New Bin Code" = '') AND
                           NOT Location."Directed Put-away and Pick"
                        THEN
                            AddError(
                              STRSUBSTNO(
                                Text001,
                                FIELDCAPTION("New Bin Code")));
                    END;

                    JnlTemplateType := ItemJnlTemplate.Type;
                    ItemLineEntryType := "Entry Type";

                    CASE "Entry Type" + 1 OF
                        1:
                            BEGIN
                                TotalAm1 := TotalAm1 + Amount;
                                TotalCostAm1 := TotalCostAm1 + CostAmount;
                            END;
                        2:
                            BEGIN
                                TotalAm2 := TotalAm2 + Amount;
                                TotalCostAm2 := TotalCostAm2 + CostAmount;
                            END;
                        3:
                            BEGIN
                                TotalAm3 := TotalAm3 + Amount;
                                TotalCostAm3 := TotalCostAm3 + CostAmount;
                            END;
                        4:
                            BEGIN
                                TotalAm4 := TotalAm4 + Amount;
                                TotalCostAm4 := TotalCostAm4 + CostAmount;
                            END;
                        5:
                            BEGIN
                                TotalAm5 := TotalAm5 + Amount;
                                TotalCostAm5 := TotalCostAm5 + CostAmount;
                            END;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    ItemJnlTemplate.GET("Item Journal Batch"."Journal Template Name");
                    IF ItemJnlTemplate.Recurring THEN BEGIN
                        IF GETFILTER("Posting Date") <> '' THEN
                            AddError(STRSUBSTNO(Text000, FIELDCAPTION("Posting Date")));
                        SETRANGE("Posting Date", 0D, WORKDATE());
                        IF GETFILTER("Expiration Date") <> '' THEN
                            AddError(
                              STRSUBSTNO(
                                Text000,
                                FIELDCAPTION("Expiration Date")));
                        SETFILTER("Expiration Date", '%1 | %2..', 0D, WORKDATE());
                    END;
                    //CurrReport.CREATETOTALS(NoOfEntries, TotalAmounts, TotalCostAmounts);
                    IF "Item Journal Batch"."No. Series" <> '' THEN
                        NoSeries.GET("Item Journal Batch"."No. Series");
                    LastPostingDate := 0D;
                    LastDocNo := '';
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.PAGENO := 1;
            end;

            trigger OnPreDataItem()
            begin
                FOR i := 1 TO ARRAYLEN(EntryTypeDescription) DO BEGIN
                    "Item Journal Line"."Entry Type" := i - 1;
                    EntryTypeDescription[i] := FORMAT("Item Journal Line"."Entry Type");
                END;
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
                    Caption = 'Options';
                    field(ShowDim; ShowDim)
                    {
                        Caption = 'Show Dimensions';
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
        LotNoLbl = 'Lot No.';
    }

    trigger OnPreReport()
    begin
        ItemJnlLineFilter := "Item Journal Line".GETFILTERS;
        GLSetup.GET();
        InvtSetup.GET();
    end;

    var
        AccountingPeriod: Record "Accounting Period";
        DimSetEntry: Record "Dimension Set Entry";
        GLSetup: Record "General Ledger Setup";
        GenPostingSetup: Record "General Posting Setup";
        InvtPeriod: Record "Inventory Period";
        InvtSetup: Record "Inventory Setup";
        Item: Record Item;
        ItemJnlTemplate: Record "Item Journal Template";
        Location: Record Location;
        NoSeries: Record "No. Series";
        UserSetup: Record "User Setup";
        DimMgt: Codeunit DimensionManagement;
        Continue: Boolean;
        QtyError: Boolean;
        ShowDim: Boolean;
        LastDocNo: Code[20];
        No: array[10] of Code[20];
        AllowPostingFrom: Date;
        AllowPostingTo: Date;
        LastPostingDate: Date;
        CostAmount: Decimal;
        NoOfEntries: array[7] of Decimal;
        TotalAm1: Decimal;
        TotalAm2: Decimal;
        TotalAm3: Decimal;
        TotalAm4: Decimal;
        TotalAm5: Decimal;
        TotalAmount: Decimal;
        TotalAmounts: array[7] of Decimal;
        TotalCostAm1: Decimal;
        TotalCostAm2: Decimal;
        TotalCostAm3: Decimal;
        TotalCostAm4: Decimal;
        TotalCostAm5: Decimal;
        TotalCostAmount: Decimal;
        TotalCostAmounts: array[7] of Decimal;
        Day: Integer;
        ErrorCounter: Integer;
        i: Integer;
        ItemLineEntryType: Integer;
        JnlTemplateType: Integer;
        Month: Integer;
        TableID: array[10] of Integer;
        Week: Integer;
        CostAmountCaptionLbl: Label 'Cost Amount';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        DimensionsCaptionLbl: Label 'Dimensions';
        ErrorText_Number_CaptionLbl: Label 'Warning!';
        Inventory_Posting___TestCaptionLbl: Label 'Inventory Posting - Test';
        Item_Journal_Line__Entry_Type_CaptionLbl: Label 'Entry Type';
        Item_Journal_Line__Posting_Date_CaptionLbl: Label 'Posting Date';
        Text000: Label '%1 cannot be filtered when you post recurring journals.';
        Text001: Label '%1 must be specified.';
        Text002: Label '%1 %2 does not exist.';
        Text003: Label '%1 must be %2 for %3 %4.';
        Text005: Label '%1 must not be a closing date.';
        Text006: Label 'The lines are not listed according to Posting Date because they were not entered in that order.';
        Text007: Label '%1 is not within your allowed range of posting dates.';
        Text008: Label '%1 %2 %3 does not exist.';
        Text009: Label '%1 must be 0.';
        Text011: Label '%1 must be 0 when %2 is %3.';
        Text012: Label '%1 must not be negative when %2 is %3.';
        Text013: Label '%1 must have the same value as %2 when %3 is %4.';
        Text014: Label '%1 must be %2 or %3 when %4 is %5.';
        Text015: Label '%1 must equal %2 - %3 when %4 is %5 and %6 is %7.';
        Text016: Label '%1 cannot be specified.';
        Text017: Label 'There is a gap in the number series.';
        Text018: Label '<Month Text>';
        Text019: Label '%1,%2,%3 or %4 must be specified.';
        Text020: Label '%1 %2 is not on inventory for %3 %4.';
        Text021: Label '%1 %2 is not on inventory.';
        TotalAmountCaptionLbl: Label 'Total';
        ItemJnlLineFilter: Text;
        EntryTypeDescription: array[7] of Text[30];
        MonthText: Text[30];
        OldDimText: Text[75];
        DimText: Text[120];
        ErrorText: array[30] of Text[250];
        LotString: Text[250];

    local procedure CheckRecurringLine(ItemJnlLine2: Record "Item Journal Line")
    begin
        WITH ItemJnlLine2 DO
            IF ItemJnlTemplate.Recurring THEN BEGIN
                IF "Recurring Method" = 0 THEN
                    AddError(STRSUBSTNO(Text001, FIELDCAPTION("Recurring Method")));
                IF FORMAT("Recurring Frequency") = '' THEN
                    AddError(STRSUBSTNO(Text001, FIELDCAPTION("Recurring Frequency")));
                IF "Recurring Method" = "Recurring Method"::Variable THEN
                    IF Quantity = 0 THEN
                        AddError(STRSUBSTNO(Text001, FIELDCAPTION(Quantity)));
            END ELSE BEGIN
                IF "Recurring Method" <> 0 THEN
                    AddError(STRSUBSTNO(Text016, FIELDCAPTION("Recurring Method")));
                IF FORMAT("Recurring Frequency") <> '' THEN
                    AddError(STRSUBSTNO(Text016, FIELDCAPTION("Recurring Frequency")));
            END;
    end;

    local procedure MakeRecurringTexts(var ItemJnlLine2: Record "Item Journal Line")
    begin
        WITH ItemJnlLine2 DO
            IF ("Posting Date" <> 0D) AND ("Item No." <> '') AND ("Recurring Method" <> 0) THEN BEGIN
                Day := DATE2DMY("Posting Date", 1);
                Week := DATE2DWY("Posting Date", 2);
                Month := DATE2DMY("Posting Date", 2);
                MonthText := FORMAT("Posting Date", 0, Text018);
                AccountingPeriod.SETRANGE("Starting Date", 0D, "Posting Date");
                IF NOT AccountingPeriod.FINDLAST() THEN
                    AccountingPeriod.Name := '';
                "Document No." :=
                  DELCHR(
                    PADSTR(
                      STRSUBSTNO("Document No.", Day, Week, Month, MonthText, AccountingPeriod.Name),
                      MAXSTRLEN("Document No.")),
                    '>');
                Description :=
                  DELCHR(
                    PADSTR(
                      STRSUBSTNO(Description, Day, Week, Month, MonthText, AccountingPeriod.Name),
                      MAXSTRLEN(Description)),
                    '>');
            END;
    end;

    local procedure AddError(Text: Text[250])
    begin
        ErrorCounter := ErrorCounter + 1;
        ErrorText[ErrorCounter] := Text;
    end;

    local procedure GetLocation(LocationCode: Code[10])
    begin
        IF LocationCode = '' THEN
            CLEAR(Location)
        ELSE
            IF Location.Code <> LocationCode THEN
                Location.GET(LocationCode);
    end;

    procedure ">>NIF_fcn"()
    begin
    end;

    procedure GetLotString(): Text[250]
    var
        ReservEntry: Record "Reservation Entry";
        Counter: Integer;
        LotText: Text[250];
    begin
        CLEAR(LotText);
        CLEAR(Counter);
        ReservEntry.SETCURRENTKEY(
            "Source Type", "Source Subtype", "Source ID", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.");

        ReservEntry.SETRANGE("Source Type", DATABASE::"Item Journal Line");
        ReservEntry.SETFILTER("Source Subtype", '2|3');
        ReservEntry.SETRANGE("Source ID", "Item Journal Line"."Journal Template Name");
        ReservEntry.SETRANGE("Source Batch Name", "Item Journal Line"."Journal Batch Name");
        ReservEntry.SETRANGE("Source Ref. No.", "Item Journal Line"."Line No.");
        ReservEntry.SETFILTER("Lot No.", '<>%1', '');
        IF ReservEntry.ISEMPTY THEN
            EXIT('');

        IF ReservEntry.FIND('-') THEN
            REPEAT
                Counter := Counter + 1;
                IF Counter > 1 THEN
                    LotText := LotText + ',' + ReservEntry."Lot No."
                ELSE
                    LotText := ReservEntry."Lot No.";
            UNTIL ReservEntry.NEXT() = 0;

        EXIT(LotText);
    end;
}

