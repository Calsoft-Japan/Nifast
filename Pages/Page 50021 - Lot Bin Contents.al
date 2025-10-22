page 50021 "Lot Bin Contents"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade
    // >> MV
    // Added fields:
    //   Whse. Pos. Adjmt. Qty. (Visible=No)
    // 
    // Date     Init  ProjID  Description
    // 09-03-03 MV    8.1.3   Floating Bin Replenishment -- added new field Whse. Pos. Adjmt. Qty. (used in Put-away)
    // << NV

    Caption = 'Lot Bin Contents';
    //DataCaptionExpression = DataCaption;
    InsertAllowed = false;
    PageType = Worksheet;
    SaveValues = true;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Lot Bin Content";

    layout
    {
        area(content)
        {
            group(Options)
            {
                Caption = 'Options';
                field(LocationCode; LocationCode)
                {
                    Caption = 'Location Filter';
                    ToolTip = 'Specifies the value of the Location Filter field.';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Location.RESET();
                        Location.SETRANGE("Bin Mandatory", TRUE);
                        IF LocationCode <> '' THEN
                            Location.Code := LocationCode;
                        IF PAGE.RUNMODAL(7347, Location) = ACTION::LookupOK THEN BEGIN
                            Location.TESTFIELD("Bin Mandatory", TRUE);
                            LocationCode := Location.Code;
                            DefFilter();
                        END;
                        CurrPage.UPDATE(TRUE);
                    end;

                    trigger OnValidate()
                    begin
                        ZoneCode := '';
                        IF LocationCode <> '' THEN
                            IF WMSMgt.LocationIsAllowed(LocationCode) THEN BEGIN
                                Location.GET(LocationCode);
                                Location.TESTFIELD("Bin Mandatory", TRUE);
                            END ELSE
                                ERROR(Text000Lbl, USERID);
                        DefFilter();
                        LocationCodeOnAfterValidate();
                    end;
                }
                field(ZoneCode; ZoneCode)
                {
                    Caption = 'Zone Filter';
                    ToolTip = 'Specifies the value of the Zone Filter field.';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Zone.RESET();
                        IF ZoneCode <> '' THEN
                            Zone.Code := ZoneCode;
                        IF LocationCode <> '' THEN
                            Zone.SETRANGE("Location Code", LocationCode);
                        IF PAGE.RUNMODAL(0, Zone) = ACTION::LookupOK THEN BEGIN
                            ZoneCode := Zone.Code;
                            LocationCode := Zone."Location Code";
                            DefFilter();
                        END;
                        CurrPage.UPDATE(TRUE);
                    end;

                    trigger OnValidate()
                    begin
                        DefFilter();
                        ZoneCodeOnAfterValidate();
                    end;
                }
            }
            repeater(General)
            {
                Editable = false;
                field("Location Code"; Rec."Location Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Location Code field.';
                    Caption = 'Location Code';
                }
                field("Zone Code"; Rec."Zone Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Zone Code field.';
                    Caption = 'Zone Code';
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ToolTip = 'Specifies the value of the Bin Code field.';
                    Caption = 'Bin Code';

                    trigger OnValidate()
                    begin
                        CheckQty();
                    end;
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                    Caption = 'Item No.';

                    trigger OnValidate()
                    begin
                        CheckQty();
                    end;
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    ToolTip = 'Specifies the value of the Expiration Date field.';
                    Caption = 'Expiration Date';
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ToolTip = 'Specifies the value of the Lot No. field.';
                    Caption = 'Lot No.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Variant Code field.';
                    Caption = 'Variant Code';

                    trigger OnValidate()
                    begin
                        CheckQty();
                    end;
                }
                field("Block Movement"; Rec."Block Movement")
                {
                    ToolTip = 'Specifies the value of the Block Movement field.';
                    Caption = 'Block Movement';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                    Caption = 'Unit of Measure Code';
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Qty. per Unit of Measure field.';
                    Caption = 'Qty. per Unit of Measure';

                    trigger OnValidate()
                    begin
                        CheckQty();
                    end;
                }
                field("Warehouse Class Code"; Rec."Warehouse Class Code")
                {
                    ToolTip = 'Specifies the value of the Warehouse Class Code field.';
                    Caption = 'Warehouse Class Code';
                }
                field("Bin Type Code"; Rec."Bin Type Code")
                {
                    ToolTip = 'Specifies the value of the Bin Type Code field.';
                    Caption = 'Bin Type Code';
                }
                field("Bin Ranking"; Rec."Bin Ranking")
                {
                    ToolTip = 'Specifies the value of the Bin Ranking field.';
                    Caption = 'Bin Ranking';
                }
                field(BlockMovement; Rec."Block Movement")
                {
                    ToolTip = 'Specifies the value of the Block Movement field.';
                    Caption = 'Block Movement';
                }
                field("Min. Qty."; Rec."Min. Qty.")
                {
                    ToolTip = 'Specifies the value of the Min. Qty. field.';
                    Caption = 'Min. Qty.';
                }
                field("Max. Qty."; Rec."Max. Qty.")
                {
                    ToolTip = 'Specifies the value of the Max. Qty. field.';
                    Caption = 'Max. Qty.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                    Caption = 'Quantity';
                }
                field("Pick Qty."; Rec."Pick Qty.")
                {
                    ToolTip = 'Specifies the value of the Pick Qty. field.';
                    Caption = 'Pick Qty.';
                }
                field("Neg. Adjmt. Qty."; Rec."Neg. Adjmt. Qty.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Neg. Adjmt. Qty. field.';
                    Caption = 'Neg. Adjmt. Qty.';
                }
                field("Put-away Qty."; Rec."Put-away Qty.")
                {
                    ToolTip = 'Specifies the value of the Put-away Qty. field.';
                    Caption = 'Put-away Qty.';
                }
                field("Pos. Adjmt. Qty."; Rec."Pos. Adjmt. Qty.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Pos. Adjmt. Qty. field.';
                    Caption = 'Pos. Adjmt. Qty.';
                }
                field("Wksh. Pos. Adjmt. Qty."; Rec."Wksh. Pos. Adjmt. Qty.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Wksh. Pos. Adjmt. Qty. field.';
                    Caption = 'Wksh. Pos. Adjmt. Qty.';
                }
                field(CalcAvailQty; CalcAvailQtys())
                {
                    Caption = 'Available Qty. to Take';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Available Qty. to Take field.';
                }
                field(Fixed; Rec.Fixed)
                {
                    ToolTip = 'Specifies the value of the Fixed field.';
                    Caption = 'Fixed';
                }
                field("Cross-Dock Bin"; Rec."Cross-Dock Bin")
                {
                    ToolTip = 'Specifies the value of the Cross-Dock Bin field.';
                    Caption = 'Cross-Dock Bin';
                }
            }
            group(" ")
            {
            }
            group("  ")
            {
                fixed(Option)
                {
                    group("Item Description")
                    {
                        Caption = 'Item Description';
                        field(ItemDescription; ItemDescription)
                        {
                            Editable = false;
                            ToolTip = 'Specifies the value of the ItemDescription field.';
                            Caption = 'ItemDescription';
                        }
                    }
                    group("Qty. on Adjustment Bin")
                    {
                        Caption = 'Qty. on Adjustment Bin';
                        field(CalcQtyonAdjmtBin; Rec.CalcQtyonAdjmtBin)
                        {
                            //DecimalPlaces = 0 : 5;
                            Editable = false;
                            ToolTip = 'Specifies the value of the CalcQtyonAdjmtBin field.';
                            Caption = 'CalcQtyonAdjmtBin';

                            trigger OnDrillDown()
                            var
                                WhseEntry: Record "Warehouse Entry";
                                WhseEntries: Page "Warehouse Entries";
                            begin
                                LocationGet(Rec."Location Code");
                                WhseEntry.SETCURRENTKEY(
                                  "Item No.", "Bin Code", "Location Code", "Variant Code", "Unit of Measure Code");
                                WhseEntry.SETRANGE("Item No.", Rec."Item No.");
                                WhseEntry.SETRANGE("Bin Code", AdjmtLocation."Adjustment Bin Code");
                                WhseEntry.SETRANGE("Location Code", Rec."Location Code");
                                WhseEntry.SETRANGE("Variant Code", Rec."Variant Code");
                                WhseEntry.SETRANGE("Unit of Measure Code", Rec."Unit of Measure Code");
                                WhseEntries.SETTABLEVIEW(WhseEntry);
                                WhseEntries.RUNMODAL();
                            end;
                        }
                    }
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                action("Warehouse Entries")
                {
                    Caption = 'Warehouse Entries';
                    Image = BinLedger;
                    RunObject = Page "Warehouse Entries";
                    RunPageLink = "Location Code" = FIELD("Location Code"),
                                  "Bin Code" = FIELD("Bin Code"),
                                  "Variant Code" = FIELD("Variant Code");
                    RunPageView = SORTING("Item No.", "Bin Code", "Location Code", "Variant Code");
                    ToolTip = 'Executes the Warehouse Entries action.';
                }
                action("Lot No. Info Card")
                {
                    Caption = 'Lot No. Info Card';
                    Image = LotInfo;
                    RunObject = Page "Lot No. Information List";
                    RunPageLink = "Item No." = FIELD("Item No."),
                                  "Lot No." = FIELD("Lot No.");
                    ToolTip = 'Executes the Lot No. Info Card action.';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord();
    end;

    trigger OnOpenPage()
    begin
        ItemDescription := '';
        IF NOT Location.GET(LocationCode) THEN
            CLEAR(LocationCode);

        Rec.GetWhseLocation(LocationCode, ZoneCode);
    end;

    var
        AdjmtLocation: Record Location;
        Location: Record Location;
        Zone: Record Zone;
        WMSMgt: Codeunit "WMS Management";
        LocationCode: Code[10];
        ZoneCode: Code[10];
        Text000Lbl: Label 'Location code is not allowed for user %1.', Comment = '%1';
        ItemDescription: Text[50];
        DataCaption: Text[80];
        LocFilter: Text[250];

    procedure DefFilter()
    begin
        Rec.FILTERGROUP := 2;
        IF LocationCode <> '' THEN
            Rec.SETRANGE("Location Code", LocationCode)
        ELSE BEGIN
            CLEAR(LocFilter);
            CLEAR(Location);
            Location.SETRANGE("Bin Mandatory", TRUE);
            IF Location.FIND('-') THEN
                REPEAT
                    IF WMSMgt.LocationIsAllowed(Location.Code) THEN
                        LocFilter := LocFilter + Location.Code + '|';
                UNTIL Location.NEXT() = 0;
            IF STRLEN(LocFilter) <> 0 THEN
                LocFilter := COPYSTR(LocFilter, 1, (STRLEN(LocFilter) - 1));
            Rec.SETFILTER("Location Code", LocFilter);
        END;
        IF ZoneCode <> '' THEN
            Rec.SETRANGE("Zone Code", ZoneCode)
        ELSE
            Rec.SETRANGE("Zone Code");
        Rec.FILTERGROUP := 0;
    end;

    procedure CheckQty()
    begin
        Rec.TESTFIELD(Quantity, 0);
        Rec.TESTFIELD("Pick Qty.", 0);
        Rec.TESTFIELD("Put-away Qty.", 0);
        Rec.TESTFIELD("Pos. Adjmt. Qty.", 0);
        Rec.TESTFIELD("Neg. Adjmt. Qty.", 0);
    end;

    procedure CalcAvailQtys(): Decimal
    begin
        EXIT(Rec.Quantity - Rec."Pick Qty." - Rec."Neg. Adjmt. Qty.");
    end;

    procedure LocationGet(LocationCodeLVar: Code[10])
    begin
        IF AdjmtLocation.Code <> LocationCodeLVar THEN
            AdjmtLocation.GET(LocationCodeLVar);
    end;

    local procedure LocationCodeOnAfterValidate()
    begin
        CurrPage.UPDATE(TRUE);
    end;

    local procedure ZoneCodeOnAfterValidate()
    begin
        CurrPage.UPDATE(TRUE);
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        Rec.GetItemDescr(Rec."Item No.", Rec."Variant Code", ItemDescription);
        DataCaption := STRSUBSTNO('%1 ', Rec."Bin Code");
    end;
}

