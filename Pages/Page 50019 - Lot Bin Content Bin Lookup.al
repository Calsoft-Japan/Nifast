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
    SourceTable = Table50001;

    layout
    {
        area(content)
        {
            repeater()
            {
                Editable = false;
                field("Location Code";"Location Code")
                {
                }
                field("Creation Date";"Creation Date")
                {
                }
                field("Expiration Date";"Expiration Date")
                {
                    Visible = false;
                }
                field("Item No.";"Item No.")
                {
                }
                field("Lot No.";"Lot No.")
                {
                }
                field("CVE Pediment No.";"CVE Pediment No.")
                {
                    DrillDown = false;
                }
                field("Bin Code";"Bin Code")
                {
                }
                field("Inspected Parts";"Inspected Parts")
                {
                }
                field("Block Movement";"Block Movement")
                {
                }
                field(CalcAvailQty;CalcAvailQty)
                {
                    Caption = 'Qty. Available';
                    DecimalPlaces = 0:2;
                }
                field(Quantity;Quantity)
                {
                }
                field("Pick Qty.";"Pick Qty.")
                {
                }
                field("Neg. Adjmt. Qty.";"Neg. Adjmt. Qty.")
                {
                }
                field("Put-away Qty.";"Put-away Qty.")
                {
                }
                field("Pos. Adjmt. Qty.";"Pos. Adjmt. Qty.")
                {
                }
                field("Revision No.";"Revision No.")
                {
                    Visible = false;
                }
                field("External Lot No.";"External Lot No.")
                {
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
        TempLotBinContent.SETVIEW(GETVIEW);
        TempLotBinContent := Rec;
        IF NOT TempLotBinContent.FIND(Which) THEN
          EXIT(FALSE);
        Rec := TempLotBinContent;
        CalcAvailQty;
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
        CalcAvailQty;
        EXIT(CurrentSteps);
    end;

    trigger OnOpenPage()
    begin
        SETRANGE("Lot No.");
        SETRANGE("Item No.");
    end;

    var
        TempLotBinContent: Record "50001" temporary;

    procedure SetSources(var LotBinContent: Record "50001")
    begin
        TempLotBinContent.RESET;
        TempLotBinContent.DELETEALL;
        IF LotBinContent.FIND('-') THEN REPEAT
          TempLotBinContent := LotBinContent;
          TempLotBinContent.INSERT;
        UNTIL LotBinContent.NEXT = 0;
    end;

    procedure CalcAvailQty(): Decimal
    begin
        EXIT(Quantity - "Pick Qty." - "Neg. Adjmt. Qty.");
    end;
}

