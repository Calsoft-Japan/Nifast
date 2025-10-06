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
    DataCaptionExpression = DataCaption;
    InsertAllowed = false;
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = Table50001;

    layout
    {
        area(content)
        {
            group(Options)
            {
                Caption = 'Options';
                field(LocationCode;LocationCode)
                {
                    Caption = 'Location Filter';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Location.RESET;
                        Location.SETRANGE("Bin Mandatory",TRUE);
                        IF LocationCode <> '' THEN
                          Location.Code := LocationCode;
                        IF PAGE.RUNMODAL(7347,Location) = ACTION::LookupOK THEN BEGIN
                          Location.TESTFIELD("Bin Mandatory",TRUE);
                          LocationCode := Location.Code;
                          DefFilter;
                        END;
                        CurrPage.UPDATE(TRUE);
                    end;

                    trigger OnValidate()
                    begin
                        ZoneCode := '';
                        IF LocationCode <> '' THEN BEGIN
                          IF WMSMgt.LocationIsAllowed(LocationCode) THEN BEGIN
                            Location.GET(LocationCode);
                            Location.TESTFIELD("Bin Mandatory",TRUE);
                          END ELSE
                            ERROR(Text000,USERID);
                        END;
                        DefFilter;
                          LocationCodeOnAfterValidate;
                    end;
                }
                field(ZoneCode;ZoneCode)
                {
                    Caption = 'Zone Filter';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Zone.RESET;
                        IF ZoneCode <> '' THEN
                          Zone.Code := ZoneCode;
                        IF LocationCode <> '' THEN
                          Zone.SETRANGE("Location Code",LocationCode);
                        IF PAGE.RUNMODAL(0,Zone) = ACTION::LookupOK THEN BEGIN
                          ZoneCode := Zone.Code;
                          LocationCode := Zone."Location Code";
                          DefFilter;
                        END;
                        CurrPage.UPDATE(TRUE);
                    end;

                    trigger OnValidate()
                    begin
                        DefFilter;
                          ZoneCodeOnAfterValidate;
                    end;
                }
            }
            repeater()
            {
                Editable = false;
                field("Location Code";"Location Code")
                {
                    Visible = false;
                }
                field("Zone Code";"Zone Code")
                {
                    Visible = false;
                }
                field("Bin Code";"Bin Code")
                {

                    trigger OnValidate()
                    begin
                        CheckQty;
                    end;
                }
                field("Item No.";"Item No.")
                {

                    trigger OnValidate()
                    begin
                        CheckQty;
                    end;
                }
                field("Expiration Date";"Expiration Date")
                {
                }
                field("Lot No.";"Lot No.")
                {
                }
                field("Variant Code";"Variant Code")
                {
                    Visible = false;

                    trigger OnValidate()
                    begin
                        CheckQty;
                    end;
                }
                field("Block Movement";"Block Movement")
                {
                }
                field("Unit of Measure Code";"Unit of Measure Code")
                {
                }
                field("Qty. per Unit of Measure";"Qty. per Unit of Measure")
                {
                    Visible = false;

                    trigger OnValidate()
                    begin
                        CheckQty;
                    end;
                }
                field("Warehouse Class Code";"Warehouse Class Code")
                {
                }
                field("Bin Type Code";"Bin Type Code")
                {
                }
                field("Bin Ranking";"Bin Ranking")
                {
                }
                field(BlockMovement;"Block Movement")
                {
                }
                field("Min. Qty.";"Min. Qty.")
                {
                }
                field("Max. Qty.";"Max. Qty.")
                {
                }
                field(Quantity;Quantity)
                {
                }
                field("Pick Qty.";"Pick Qty.")
                {
                }
                field("Neg. Adjmt. Qty.";"Neg. Adjmt. Qty.")
                {
                    Visible = false;
                }
                field("Put-away Qty.";"Put-away Qty.")
                {
                }
                field("Pos. Adjmt. Qty.";"Pos. Adjmt. Qty.")
                {
                    Visible = false;
                }
                field("Wksh. Pos. Adjmt. Qty.";"Wksh. Pos. Adjmt. Qty.")
                {
                    Visible = false;
                }
                field(CalcAvailQty;CalcAvailQty)
                {
                    Caption = 'Available Qty. to Take';
                    DecimalPlaces = 0:5;
                    Editable = false;
                }
                field(Fixed;Fixed)
                {
                }
                field("Cross-Dock Bin";"Cross-Dock Bin")
                {
                }
            }
            group()
            {
            }
            group()
            {
                fixed()
                {
                    group("Item Description")
                    {
                        Caption = 'Item Description';
                        field(ItemDescription;ItemDescription)
                        {
                            Editable = false;
                        }
                    }
                    group("Qty. on Adjustment Bin")
                    {
                        Caption = 'Qty. on Adjustment Bin';
                        field(CalcQtyonAdjmtBin;CalcQtyonAdjmtBin)
                        {
                            DecimalPlaces = 0:5;
                            Editable = false;

                            trigger OnDrillDown()
                            var
                                WhseEntry: Record "7312";
                                WhseEntries: Page "7318";
                            begin
                                LocationGet("Location Code");
                                WhseEntry.SETCURRENTKEY(
                                  "Item No.","Bin Code","Location Code","Variant Code","Unit of Measure Code");
                                WhseEntry.SETRANGE("Item No.","Item No.");
                                WhseEntry.SETRANGE("Bin Code",AdjmtLocation."Adjustment Bin Code");
                                WhseEntry.SETRANGE("Location Code","Location Code");
                                WhseEntry.SETRANGE("Variant Code","Variant Code");
                                WhseEntry.SETRANGE("Unit of Measure Code","Unit of Measure Code");
                                WhseEntries.SETTABLEVIEW(WhseEntry);
                                WhseEntries.RUNMODAL;
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
                    RunObject = Page 7318;
                    RunPageLink = Location Code=FIELD(Location Code),
                                  Bin Code=FIELD(Bin Code),
                                  Variant Code=FIELD(Variant Code);
                    RunPageView = SORTING(Item No.,Bin Code,Location Code,Variant Code);
                }
                action("Lot No. Info Card")
                {
                    Caption = 'Lot No. Info Card';
                    RunObject = Page 6508;
                    RunPageLink = Item No.=FIELD(Item No.),
                                  Lot No.=FIELD(Lot No.);
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin
        ItemDescription := '';
        IF NOT Location.GET(LocationCode) THEN
          CLEAR(LocationCode);

        GetWhseLocation(LocationCode,ZoneCode);
    end;

    var
        Location: Record "14";
        AdjmtLocation: Record "14";
        Zone: Record "7300";
        WMSMgt: Codeunit "7302";
        LocationCode: Code[10];
        ZoneCode: Code[10];
        DataCaption: Text[80];
        ItemDescription: Text[50];
        Text000: Label 'Location code is not allowed for user %1.';
        LocFilter: Text[250];

    procedure DefFilter()
    begin
        FILTERGROUP := 2;
        IF LocationCode <> '' THEN
          SETRANGE("Location Code",LocationCode)
        ELSE BEGIN
          CLEAR(LocFilter);
          CLEAR(Location);
          Location.SETRANGE("Bin Mandatory",TRUE);
          IF Location.FIND('-') THEN
            REPEAT
              IF WMSMgt.LocationIsAllowed(Location.Code) THEN
                LocFilter := LocFilter + Location.Code + '|';
            UNTIL Location.NEXT = 0;
          IF STRLEN(LocFilter) <> 0 THEN
            LocFilter := COPYSTR(LocFilter,1,(STRLEN(LocFilter) - 1));
          SETFILTER("Location Code",LocFilter);
        END;
        IF ZoneCode <> '' THEN
          SETRANGE("Zone Code",ZoneCode)
        ELSE
          SETRANGE("Zone Code");
        FILTERGROUP := 0;
    end;

    procedure CheckQty()
    begin
        TESTFIELD(Quantity,0);
        TESTFIELD("Pick Qty.",0);
        TESTFIELD("Put-away Qty.",0);
        TESTFIELD("Pos. Adjmt. Qty.",0);
        TESTFIELD("Neg. Adjmt. Qty.",0);
    end;

    procedure CalcAvailQty(): Decimal
    begin
        EXIT(Quantity - "Pick Qty." - "Neg. Adjmt. Qty.");
    end;

    procedure LocationGet(LocationCode: Code[10])
    begin
        IF AdjmtLocation.Code <> LocationCode THEN
          AdjmtLocation.GET(LocationCode);
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
        GetItemDescr("Item No.","Variant Code",ItemDescription);
        DataCaption := STRSUBSTNO('%1 ',"Bin Code");
    end;
}

