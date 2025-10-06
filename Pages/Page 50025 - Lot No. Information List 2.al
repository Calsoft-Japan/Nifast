page 50025 "Lot No. Information List 2"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade
    // NF1.00:CIS.NG  09-28-15 Update for New Vision Removal Task (Lot Entry Functionality)
    // >> ISD
    // Columns added:
    //   50050 Slab Block No.
    // 
    // Date     Init  SCR    Description
    // 01-17-04 MV    #9443  Added column 50050 "Slab Block No."
    // << ISD
    // 
    // 03-21-17 Added Country of Origin SM001

    Caption = 'Lot No. Information List';
    Editable = false;
    PageType = List;
    SourceTable = Table6505;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Item No.";"Item No.")
                {
                }
                field("Lot No.";"Lot No.")
                {
                }
                field("Source Location";"Source Location")
                {
                }
                field(Inventory;Inventory)
                {
                    BlankZero = true;
                }
                field(LotValue;LotValue)
                {
                    BlankZero = true;
                    Caption = 'Inventory Value';
                    DecimalPlaces = 2:2;
                    Editable = false;
                }
                field("Mfg. Lot No.";"Mfg. Lot No.")
                {
                }
                field("Vendor No.";"Vendor No.")
                {
                }
                field("Lot Creation Date";"Lot Creation Date")
                {
                }
                field("Passed Inspection";"Passed Inspection")
                {
                }
                field(Blocked;Blocked)
                {
                }
                field(Comment;Comment)
                {
                }
                field(InLocationBinGross;InLocationBinGross)
                {
                    Caption = 'Location-Bin';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        ShowBinContentBufferGross;
                    end;
                }
                field("Revision No.";"Revision No.")
                {
                }
                field("Country of Origin";"Country of Origin")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Lot No. Info")
            {
                Caption = 'Lot No. Info';
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page 6505;
                    RunPageOnRec = true;
                    ShortCutKey = 'Shift+F7';
                }
            }
        }
    }

    procedure ">>"()
    begin
    end;

    procedure LotValue() InvtValue: Decimal
    var
        ItemLedgEntry: Record "32";
        UnitCost: Decimal;
    begin
        ItemLedgEntry.SETCURRENTKEY("Item No.","Variant Code",Open,Positive,"Location Code","Posting Date","Expiration Date","Lot No.");
        ItemLedgEntry.SETRANGE("Item No.","Item No.");
        ItemLedgEntry.SETFILTER("Location Code",GETFILTER("Location Filter"));
        ItemLedgEntry.SETRANGE("Lot No.","Lot No.");

        IF ItemLedgEntry.FIND('-') THEN
          REPEAT
            AdjustItemLedgEntryToAsOfDate(ItemLedgEntry,TODAY);
            CalcUnitCost(UnitCost,ItemLedgEntry);
            InvtValue :=  InvtValue + (UnitCost * ItemLedgEntry."Remaining Quantity");
          UNTIL ItemLedgEntry.NEXT=0;
    end;

    local procedure AdjustItemLedgEntryToAsOfDate(var ItemLedgEntry: Record "32";AsOfDate: Date)
    var
        ItemApplnEntry: Record "339";
        ValueEntry: Record "5802";
        ItemLedgEntry2: Record "32";
        InvoicedValue: Decimal;
        InvoicedValueACY: Decimal;
        InvoicedQty: Decimal;
        ExpectedValue: Decimal;
        ExpectedValueACY: Decimal;
        ValuedQty: Decimal;
    begin
        WITH ItemLedgEntry DO BEGIN
          // adjust remaining quantity
          "Remaining Quantity" := Quantity;
          IF Positive THEN BEGIN
            ItemApplnEntry.RESET;
            ItemApplnEntry.SETCURRENTKEY(
              "Inbound Item Entry No.","Cost Application","Outbound Item Entry No.");
            ItemApplnEntry.SETRANGE("Inbound Item Entry No.","Entry No.");
            ItemApplnEntry.SETRANGE("Posting Date",0D,AsOfDate);
            ItemApplnEntry.SETFILTER("Outbound Item Entry No.",'<>%1',0);
            ItemApplnEntry.SETFILTER("Item Ledger Entry No.",'<>%1',"Entry No.");
            IF ItemApplnEntry.FIND('-') THEN
              REPEAT
                IF ItemLedgEntry2.GET(ItemApplnEntry."Item Ledger Entry No.") AND
                   (ItemLedgEntry2."Posting Date" <= AsOfDate)
                THEN
                  "Remaining Quantity" := "Remaining Quantity" + ItemApplnEntry.Quantity;
              UNTIL ItemApplnEntry.NEXT = 0;
          END ELSE BEGIN
            ItemApplnEntry.RESET;
            ItemApplnEntry.SETCURRENTKEY("Item Ledger Entry No.","Outbound Item Entry No.","Cost Application");
            ItemApplnEntry.SETRANGE("Item Ledger Entry No.","Entry No.");
            ItemApplnEntry.SETRANGE("Outbound Item Entry No.","Entry No.");
            ItemApplnEntry.SETRANGE("Posting Date",0D,AsOfDate);
            IF ItemApplnEntry.FIND('-') THEN
              REPEAT
                IF ItemLedgEntry2.GET(ItemApplnEntry."Inbound Item Entry No.") AND
                   (ItemLedgEntry2."Posting Date" <= AsOfDate)
                THEN
                  "Remaining Quantity" := "Remaining Quantity" - ItemApplnEntry.Quantity;
              UNTIL ItemApplnEntry.NEXT = 0;
          END;

          // calculate adjusted cost of entry
          ValueEntry.RESET;
          ValueEntry.SETCURRENTKEY(
            "Item Ledger Entry No.","Expected Cost","Document No.","Partial Revaluation","Entry Type","Variance Type");
          ValueEntry.SETRANGE("Item Ledger Entry No.","Entry No.");
          ValueEntry.SETRANGE("Posting Date",0D,AsOfDate);
          IF ValueEntry.FIND('-') THEN
            REPEAT
              IF ValueEntry."Expected Cost" THEN BEGIN
                ExpectedValue := ExpectedValue + ValueEntry."Cost Amount (Expected)";
                ExpectedValueACY := ExpectedValueACY + ValueEntry."Cost Amount (Expected) (ACY)";
                IF ValuedQty = 0 THEN
                  ValuedQty := ValueEntry."Valued Quantity";
              END ELSE BEGIN
                InvoicedQty := InvoicedQty + ValueEntry."Invoiced Quantity";
                InvoicedValue := InvoicedValue + ValueEntry."Cost Amount (Actual)";
                InvoicedValueACY := InvoicedValueACY + ValueEntry."Cost Amount (Actual) (ACY)";
              END;
            UNTIL ValueEntry.NEXT = 0;
          IF ValuedQty = 0 THEN BEGIN
            ValuedQty := InvoicedQty;
            ExpectedValue := 0;
            ExpectedValueACY := 0;
          END ELSE BEGIN
            ExpectedValue := ExpectedValue * (ValuedQty - InvoicedQty) / ValuedQty;
            ExpectedValueACY := ExpectedValueACY * (ValuedQty - InvoicedQty) / ValuedQty;
          END;
          "Cost Amount (Actual)" := ROUND(InvoicedValue + ExpectedValue);
          //x"Cost Amount (Actual) (ACY)" := ROUND(InvoicedValueACY + ExpectedValueACY,Currency."Amount Rounding Precision");
        END;
    end;

    procedure CalcUnitCost(var UnitCost: Decimal;"Item Ledger Entry": Record "32")
    begin
        WITH "Item Ledger Entry" DO BEGIN
          CALCFIELDS("Cost Amount (Expected)","Cost Amount (Actual)");
          IF "Invoiced Quantity" <> Quantity THEN
            UnitCost := "Cost Amount (Expected)" / Quantity
          ELSE
            UnitCost := "Cost Amount (Actual)" / "Invoiced Quantity";
        END;
    end;
}

