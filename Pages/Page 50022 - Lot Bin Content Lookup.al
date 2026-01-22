page 50022 "Lot Bin Content Lookup"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade
    // NF1.00:CIS.NG  11-24-15 Added code to calculate some calcfields
    // NF1.00:CIS.NG  12-04-15 Added code to calculate remaining calcfields
    // >> RHO
    // Fields Added:
    //   External Lot No.
    // 
    // Date     Init   Proj   Description
    // 01-11-05 RTT    9488   new field "External Lot No."
    // << RHO
    // 22-Jul-16:JRR  Added column Item to page

    Caption = 'Lot Bin Content Lookup';
    DeleteAllowed = false;
    InsertAllowed = false;
    ApplicationArea = All;
    UsageCategory = Lists;
    PageType = List;
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
                field("Lot No."; Rec."Lot No.")
                {
                    ToolTip = 'Specifies the value of the Lot No. field.';
                }
                field("Revision No."; Rec."Revision No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Revision No. field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("CVE Pediment No."; Rec."CVE Pediment No.")
                {
                    DrillDown = false;
                    Lookup = false;
                    Visible = "CVE Pediment No.Visible";
                    ToolTip = 'Specifies the value of the CVE Pediment No. field.';
                }
                field("External Lot No."; Rec."External Lot No.")
                {
                    ToolTip = 'Specifies the value of the External Lot No. field.';
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ToolTip = 'Specifies the value of the Bin Code field.';
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
                field("Inspected Parts"; Rec."Inspected Parts")
                {
                    ToolTip = 'Specifies the value of the Inspected Parts field.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Specifies the value of the Blocked field.';
                }
                field("Block Movement"; Rec."Block Movement")
                {
                    ToolTip = 'Specifies the value of the Block Movement field.';
                }
                field("Country of Origin"; Rec."Country of Origin")
                {
                    ToolTip = 'Specifies the value of the Country of Origin field.';
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
        TempLotBinContent.SETVIEW(Rec.GETVIEW);
        TempLotBinContent := Rec;
        IF NOT TempLotBinContent.FIND(Which) THEN
            EXIT(FALSE);
        Rec := TempLotBinContent;
        CalcAvailQtys();
        EXIT(TRUE);
    end;

    trigger OnInit()
    begin
        "CVE Pediment No.Visible" := TRUE;
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
        //>>NIF 051206 RTT #10775
        IF STRPOS(COMPANYNAME, 'Mexi') = 0 THEN
            "CVE Pediment No.Visible" := FALSE;
        //<<NIF 051206 RTT #10775
    end;

    var
        TempLotBinContent: Record "Lot Bin Content" temporary;
        "CVE Pediment No.Visible": Boolean;

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
        Rec.CALCFIELDS(Quantity, "Pick Qty.", "Neg. Adjmt. Qty.", "Inspected Parts", "Put-away Qty.", "Pos. Adjmt. Qty.", Blocked, "Revision No.", "Country of Origin", "CVE Pediment No.", "Wksh. Pos. Adjmt. Qty.");  //NF1.00:CIS.NG  11-24-15
        EXIT(Rec.Quantity - Rec."Pick Qty." - Rec."Neg. Adjmt. Qty.");
    end;
}

