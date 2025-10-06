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
    PageType = List;
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
                field("Lot No.";"Lot No.")
                {
                }
                field("Revision No.";"Revision No.")
                {
                    Visible = false;
                }
                field("Item No.";"Item No.")
                {
                }
                field("CVE Pediment No.";"CVE Pediment No.")
                {
                    DrillDown = false;
                    Lookup = false;
                    Visible = "CVE Pediment No.Visible";
                }
                field("External Lot No.";"External Lot No.")
                {
                }
                field("Bin Code";"Bin Code")
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
                field("Inspected Parts";"Inspected Parts")
                {
                }
                field(Blocked;Blocked)
                {
                }
                field("Block Movement";"Block Movement")
                {
                }
                field("Country of Origin";"Country of Origin")
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
        CalcAvailQty;
        EXIT(CurrentSteps);
    end;

    trigger OnOpenPage()
    begin
        //>>NIF 051206 RTT #10775
        IF STRPOS(COMPANYNAME,'Mexi')=0 THEN
          "CVE Pediment No.Visible" := FALSE;
        //<<NIF 051206 RTT #10775
    end;

    var
        TempLotBinContent: Record "50001" temporary;
        [InDataSet]
        "CVE Pediment No.Visible": Boolean;

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
        CALCFIELDS(Quantity,"Pick Qty.","Neg. Adjmt. Qty.","Inspected Parts","Put-away Qty.","Pos. Adjmt. Qty.",Blocked,"Revision No.","Country of Origin","CVE Pediment No.","Wksh. Pos. Adjmt. Qty.");  //NF1.00:CIS.NG  11-24-15
        EXIT(Quantity - "Pick Qty." - "Neg. Adjmt. Qty.");
    end;
}

