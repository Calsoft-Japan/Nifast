report 50069 "Inventory Valuation NIF"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\RDLC\Inventory Valuation NIF.rdlc';
    Caption = 'Inventory Valuation NIF';

    dataset
    {
        dataitem(Item; Item)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Inventory Posting Group", "Costing Method", "Location Filter", "Variant Filter";
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CurrReport_PAGENO; 1)//CurrReport.PAGENO)
            {
            }
            column(STRSUBSTNO_Text003_AsOfDate_; STRSUBSTNO(Text003, AsOfDate))
            {
            }
            column(ShowVariants; ShowVariants)
            {
            }
            column(ShowLocations; ShowLocations)
            {
            }
            column(ShowACY; ShowACY)
            {
            }
            column(STRSUBSTNO_Text006_Currency_Description_; STRSUBSTNO(Text006, Currency.Description))
            {
            }
            column(Item_TABLECAPTION__________ItemFilter; Item.TABLECAPTION + ': ' + ItemFilter)
            {
            }
            column(ItemFilter; ItemFilter)
            {
            }
            column(STRSUBSTNO_Text004_InvPostingGroup_TABLECAPTION_InvPostingGroup_Code_InvPostingGroup_Description_; STRSUBSTNO(Text004, InvPostingGroup.TABLECAPTION, InvPostingGroup.Code, InvPostingGroup.Description))
            {
            }
            column(Item__Inventory_Posting_Group_; "Inventory Posting Group")
            {
            }
            column(Grouping; Grouping)
            {
            }
            column(Item__No__; "No.")
            {
                IncludeCaption = true;
            }
            column(Item_Description; Description)
            {
                IncludeCaption = true;
            }
            column(Item__Base_Unit_of_Measure_; "Base Unit of Measure")
            {
                IncludeCaption = true;
            }
            column(Item__Costing_Method_; "Costing Method")
            {
                IncludeCaption = true;
            }
            column(STRSUBSTNO_Text005_InvPostingGroup_TABLECAPTION_InvPostingGroup_Code_InvPostingGroup_Description_; STRSUBSTNO(Text005, InvPostingGroup.TABLECAPTION, InvPostingGroup.Code, InvPostingGroup.Description))
            {
            }
            column(Inventory_ValuationCaption; Inventory_ValuationCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(InventoryValue_Control34Caption; InventoryValue_Control34CaptionLbl)
            {
            }
            column(Item_Ledger_Entry__Remaining_Quantity_Caption; "Item Ledger Entry".FIELDCAPTION("Remaining Quantity"))
            {
            }
            column(UnitCost_Control33Caption; UnitCost_Control33CaptionLbl)
            {
            }
            column(Total_Inventory_ValueCaption; Total_Inventory_ValueCaptionLbl)
            {
            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Item No." = FIELD("No."),
                               "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                               "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                               "Location Code" = FIELD("Location Filter"),
                               "Variant Code" = FIELD("Variant Filter");
                DataItemTableView = SORTING("Item No.", "Variant Code", "Location Code", "Posting Date");

                trigger OnAfterGetRecord()
                begin
                    AdjustItemLedgEntryToAsOfDate("Item Ledger Entry");
                    UpdateBuffer("Item Ledger Entry");
                    CurrReport.SKIP;
                end;

                trigger OnPostDataItem()
                begin
                    UpdateTempEntryBuffer;
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Posting Date", 0D, AsOfDate);
                end;
            }
            dataitem(BufferLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                column(RowLabel; TempEntryBuffer.Label)
                {
                }
                column(RemainingQty; TempEntryBuffer."Remaining Quantity")
                {
                }
                column(InventoryValue; TempEntryBuffer.Value1)
                {
                }
                column(VariantCode; TempEntryBuffer."Variant Code")
                {
                }
                column(LocationCode; TempEntryBuffer."Location Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF TempEntryBuffer.NEXT <> 1 THEN
                        CurrReport.BREAK;
                end;

                trigger OnPreDataItem()
                begin
                    CLEAR(TempEntryBuffer);
                    TempEntryBuffer.SETFILTER("Item No.", '%1', Item."No.");
                    IF Item."Location Filter" <> '' THEN
                        TempEntryBuffer.SETFILTER("Location Code", '%1', Item."Location Filter");

                    IF Item."Variant Filter" <> '' THEN
                        TempEntryBuffer.SETFILTER("Variant Code", '%1', Item."Variant Filter");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF NOT InvPostingGroup.GET("Inventory Posting Group") THEN
                    CLEAR(InvPostingGroup);
                Progress.UPDATE(1, FORMAT("No."));
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE("Date Filter", 0D, AsOfDate);
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
                    field(AsOfDate; AsOfDate)
                    {
                        Caption = 'As Of Date';
                    }
                    field(ShowVariants; ShowVariants)
                    {
                        Caption = 'Breakdown by Variants';
                    }
                    field(BreakdownByLocation; ShowLocations)
                    {
                        Caption = 'Breakdown by Location';
                    }
                    field(UseAdditionalReportingCurrency; ShowACY)
                    {
                        Caption = 'Use Additional Reporting Currency';
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

    trigger OnPostReport()
    begin
        Progress.CLOSE;
    end;

    trigger OnPreReport()
    begin
        Grouping := (Item.FIELDCAPTION("Inventory Posting Group") = Item.CURRENTKEY);

        IF AsOfDate = 0D THEN
            ERROR(Text000);
        IF ShowLocations AND NOT ShowVariants THEN
            IF NOT "Item Ledger Entry".SETCURRENTKEY("Item No.", "Location Code") THEN
                ERROR(Text001,
                  "Item Ledger Entry".TABLECAPTION,
                  "Item Ledger Entry".FIELDCAPTION("Item No."),
                  "Item Ledger Entry".FIELDCAPTION("Location Code"));
        IF Item.GETFILTER("Date Filter") <> '' THEN
            ERROR(Text002, Item.FIELDCAPTION("Date Filter"), Item.TABLECAPTION);

        CompanyInformation.GET;
        ItemFilter := Item.GETFILTERS;
        GLSetup.GET;
        IF GLSetup."Additional Reporting Currency" = '' THEN
            ShowACY := FALSE
        ELSE BEGIN
            Currency.GET(GLSetup."Additional Reporting Currency");
            Currency.TESTFIELD("Amount Rounding Precision");
            Currency.TESTFIELD("Unit-Amount Rounding Precision");
        END;
        Progress.OPEN(Item.TABLECAPTION + '  #1############');
    end;

    var
        GLSetup: Record "General Ledger Setup";
        CompanyInformation: Record "Company Information";
        InvPostingGroup: Record "Inventory Posting Group";
        Currency: Record Currency;
        Location: Record Location;
        ItemVariant: Record "Item Variant";
        ItemFilter: Text;
        ShowVariants: Boolean;
        ShowLocations: Boolean;
        ShowACY: Boolean;
        AsOfDate: Date;
        Text000: Label 'You must enter an As Of Date.';
        Text001: Label 'If you want to show Locations without also showing Variants, you must add a new key to the %1 table which starts with the %2 and %3 fields.';
        Text002: Label 'Do not set a %1 on the %2.  Use the As Of Date on the Option tab instead.';
        Text003: Label 'Quantities and Values As Of %1';
        Text004: Label '%1 %2 (%3)';
        Text005: Label '%1 %2 (%3) Total';
        Text006: Label 'All Inventory Values are shown in %1.';
        Text007: Label 'No Variant';
        Text008: Label 'No Location';
        Grouping: Boolean;
        Inventory_ValuationCaptionLbl: Label 'Inventory Valuation NIF';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        InventoryValue_Control34CaptionLbl: Label 'Inventory Value';
        UnitCost_Control33CaptionLbl: Label 'Unit Cost';
        Total_Inventory_ValueCaptionLbl: Label 'Total Inventory Value';
        LastItemNo: Code[20];
        LastLocationCode: Code[10];
        LastVariantCode: Code[10];
        TempEntryBuffer: Record "Item Location Variant Buffer" temporary;
        VariantLabel: Text[250];
        LocationLabel: Text[250];
        IsCollecting: Boolean;
        Progress: Dialog;

    local procedure AdjustItemLedgEntryToAsOfDate(var ItemLedgEntry: Record "Item Ledger Entry")
    var
        ItemApplnEntry: Record "Item Application Entry";
        ValueEntry: Record "Value Entry";
        ItemLedgEntry2: Record "Item Ledger Entry";
        InvoicedValue: Decimal;
        InvoicedValueACY: Decimal;
        ExpectedValue: Decimal;
        ExpectedValueACY: Decimal;
    begin

        // adjust remaining quantity
        ItemLedgEntry."Remaining Quantity" := ItemLedgEntry.Quantity;
        IF ItemLedgEntry.Positive THEN BEGIN
            ItemApplnEntry.RESET;
            ItemApplnEntry.SETCURRENTKEY(
              "Inbound Item Entry No.", "Item Ledger Entry No.", "Outbound Item Entry No.", "Cost Application");
            ItemApplnEntry.SETRANGE("Inbound Item Entry No.", ItemLedgEntry."Entry No.");
            ItemApplnEntry.SETRANGE("Posting Date", 0D, AsOfDate);
            ItemApplnEntry.SETFILTER("Outbound Item Entry No.", '<>%1', 0);
            ItemApplnEntry.SETFILTER("Item Ledger Entry No.", '<>%1', ItemLedgEntry."Entry No.");
            IF ItemApplnEntry.FIND('-') THEN
                REPEAT
                    IF ItemLedgEntry2.GET(ItemApplnEntry."Item Ledger Entry No.") AND
                       (ItemLedgEntry2."Posting Date" <= AsOfDate)
                    THEN
                        ItemLedgEntry."Remaining Quantity" := ItemLedgEntry."Remaining Quantity" + ItemApplnEntry.Quantity;
                UNTIL ItemApplnEntry.NEXT = 0;
        END ELSE BEGIN
            ItemApplnEntry.RESET;
            ItemApplnEntry.SETCURRENTKEY(
              "Outbound Item Entry No.", "Item Ledger Entry No.", "Cost Application", "Transferred-from Entry No.");
            ItemApplnEntry.SETRANGE("Item Ledger Entry No.", ItemLedgEntry."Entry No.");
            ItemApplnEntry.SETRANGE("Outbound Item Entry No.", ItemLedgEntry."Entry No.");
            ItemApplnEntry.SETRANGE("Posting Date", 0D, AsOfDate);
            IF ItemApplnEntry.FIND('-') THEN
                REPEAT
                    IF ItemLedgEntry2.GET(ItemApplnEntry."Inbound Item Entry No.") AND
                       (ItemLedgEntry2."Posting Date" <= AsOfDate)
                    THEN
                        ItemLedgEntry."Remaining Quantity" := ItemLedgEntry."Remaining Quantity" - ItemApplnEntry.Quantity;
                UNTIL ItemApplnEntry.NEXT = 0;
        END;

        // calculate adjusted cost of entry
        ValueEntry.RESET;
        ValueEntry.SETCURRENTKEY("Item Ledger Entry No.", "Entry Type");
        ValueEntry.SETRANGE("Item Ledger Entry No.", ItemLedgEntry."Entry No.");
        ValueEntry.SETRANGE("Posting Date", 0D, AsOfDate);
        IF ValueEntry.FIND('-') THEN
            REPEAT
                ExpectedValue := ExpectedValue + ValueEntry."Cost Amount (Expected)";
                ExpectedValueACY := ExpectedValueACY + ValueEntry."Cost Amount (Expected) (ACY)";
                InvoicedValue := InvoicedValue + ValueEntry."Cost Amount (Actual)";
                InvoicedValueACY := InvoicedValueACY + ValueEntry."Cost Amount (Actual) (ACY)";
            UNTIL ValueEntry.NEXT = 0;
        ItemLedgEntry."Cost Amount (Actual)" := ROUND(InvoicedValue + ExpectedValue);
        ItemLedgEntry."Cost Amount (Actual) (ACY)" := ROUND(InvoicedValueACY + ExpectedValueACY, Currency."Amount Rounding Precision");

    end;

    procedure UpdateBuffer(var ItemLedgEntry: Record "Item Ledger Entry")
    var
        NewRow: Boolean;
    begin
        IF ItemLedgEntry."Item No." <> LastItemNo THEN BEGIN
            ClearLastEntry;
            LastItemNo := ItemLedgEntry."Item No.";
            NewRow := TRUE
        END;

        IF ShowVariants OR ShowLocations THEN BEGIN
            IF ItemLedgEntry."Variant Code" <> LastVariantCode THEN BEGIN
                NewRow := TRUE;
                LastVariantCode := ItemLedgEntry."Variant Code";
                IF ShowVariants THEN BEGIN
                    IF (ItemLedgEntry."Variant Code" = '') OR NOT ItemVariant.GET(ItemLedgEntry."Item No.", ItemLedgEntry."Variant Code") THEN
                        VariantLabel := Text007
                    ELSE
                        VariantLabel := ItemVariant.TABLECAPTION + ' ' + ItemLedgEntry."Variant Code" + '(' + ItemVariant.Description + ')';
                END
                ELSE
                    VariantLabel := ''
            END;
            IF ItemLedgEntry."Location Code" <> LastLocationCode THEN BEGIN
                NewRow := TRUE;
                LastLocationCode := ItemLedgEntry."Location Code";
                IF ShowLocations THEN BEGIN
                    IF (ItemLedgEntry."Location Code" = '') OR NOT Location.GET(ItemLedgEntry."Location Code") THEN
                        LocationLabel := Text008
                    ELSE
                        LocationLabel := Location.TABLECAPTION + ' ' + ItemLedgEntry."Location Code" + '(' + Location.Name + ')';
                END
                ELSE
                    LocationLabel := '';
            END
        END;

        IF NewRow THEN
            UpdateTempEntryBuffer;

        TempEntryBuffer."Remaining Quantity" += ItemLedgEntry."Remaining Quantity";
        IF ShowACY THEN
            TempEntryBuffer.Value1 += ItemLedgEntry."Cost Amount (Actual) (ACY)"
        ELSE
            TempEntryBuffer.Value1 += ItemLedgEntry."Cost Amount (Actual)";

        TempEntryBuffer."Item No." := ItemLedgEntry."Item No.";
        TempEntryBuffer."Variant Code" := LastVariantCode;
        TempEntryBuffer."Location Code" := LastLocationCode;
        TempEntryBuffer.Label := COPYSTR(VariantLabel + ' ' + LocationLabel, 1, MAXSTRLEN(TempEntryBuffer.Label));

        IsCollecting := TRUE;
    end;

    procedure ClearLastEntry()
    begin
        LastItemNo := '@@@';
        LastLocationCode := '@@@';
        LastVariantCode := '@@@';
    end;

    procedure UpdateTempEntryBuffer()
    begin
        IF IsCollecting AND ((TempEntryBuffer."Remaining Quantity" <> 0) OR (TempEntryBuffer.Value1 <> 0)) THEN
            TempEntryBuffer.INSERT;
        IsCollecting := FALSE;
        CLEAR(TempEntryBuffer);
    end;
}

