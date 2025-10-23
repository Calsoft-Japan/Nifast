page 50019 "Lot Bin Content Bin Lookup"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade
    // >> RHO
    // Fields Added:
    //   External Lot No.
    // 
    // Date     Init   Proj   Description
    // 01-11-05 RTT    9488   new field "External Lot No."
    // << RHO

    Caption = 'Lot Bin Content Lookup';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SaveValues = false;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Lot Bin Content";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Editable = false;
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ToolTip = 'Specifies the value of the Creation Date field.';
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Expiration Date field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ToolTip = 'Specifies the value of the Lot No. field.';
                }
                field("CVE Pediment No."; Rec."CVE Pediment No.")
                {
                    DrillDown = false;
                    ToolTip = 'Specifies the value of the CVE Pediment No. field.';
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ToolTip = 'Specifies the value of the Bin Code field.';
                }
                field("Inspected Parts"; Rec."Inspected Parts")
                {
                    ToolTip = 'Specifies the value of the Inspected Parts field.';
                }
                field("Block Movement"; Rec."Block Movement")
                {
                    ToolTip = 'Specifies the value of the Block Movement field.';
                }
                field(CalcAvailQty; CalcAvailQtys())
                {
                    Caption = 'Qty. Available';
                    DecimalPlaces = 0 : 2;
                    ToolTip = 'Specifies the value of the Qty. Available field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Pick Qty."; Rec."Pick Qty.")
                {
                    ToolTip = 'Specifies the value of the Pick Qty. field.';
                }
                field("Neg. Adjmt. Qty."; Rec."Neg. Adjmt. Qty.")
                {
                    ToolTip = 'Specifies the value of the Neg. Adjmt. Qty. field.';
                }
                field("Put-away Qty."; Rec."Put-away Qty.")
                {
                    ToolTip = 'Specifies the value of the Put-away Qty. field.';
                }
                field("Pos. Adjmt. Qty."; Rec."Pos. Adjmt. Qty.")
                {
                    ToolTip = 'Specifies the value of the Pos. Adjmt. Qty. field.';
                }
                field("Revision No."; Rec."Revision No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Revision No. field.';
                }
                field("External Lot No."; Rec."External Lot No.")
                {
                    ToolTip = 'Specifies the value of the External Lot No. field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnClosePage()
    begin
        TempLotBinContent := Rec;
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        TempLotBinContent.SETVIEW('GETVIEW');
        TempLotBinContent := Rec;
        IF NOT TempLotBinContent.FIND(Which) THEN
            EXIT(FALSE);
        Rec := TempLotBinContent;
        CalcAvailQtys();
        EXIT(TRUE);
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    var
        CurrentSteps: Integer;
    begin
        TempLotBinContent := Rec;
        CurrentSteps := TempLotBinContent.NEXT(Steps);
        IF CurrentSteps <> 0 THEN
            Rec := TempLotBinContent;
        CalcAvailQtys();
        EXIT(CurrentSteps);
    end;

    trigger OnOpenPage()
    begin
        Rec.SETRANGE("Lot No.");
        Rec.SETRANGE("Item No.");
    end;

    var
        TempLotBinContent: Record "Lot Bin Content" temporary;

    procedure SetSources(var LotBinContent: Record "Lot Bin Content")
    begin
        TempLotBinContent.RESET();
        TempLotBinContent.DELETEALL();
        IF LotBinContent.FIND('-') THEN
            REPEAT
                TempLotBinContent := LotBinContent;
                TempLotBinContent.INSERT();
            UNTIL LotBinContent.NEXT() = 0;
    end;

    procedure CalcAvailQtys(): Decimal
    begin
        EXIT(Rec.Quantity - Rec."Pick Qty." - Rec."Neg. Adjmt. Qty.");
    end;
}

