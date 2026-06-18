codeunit 50072 SingleInstance
{
    SingleInstance = true;

    var
        ItemLegderEntryG: Record "Item Ledger Entry";
        WarehouseActivityHeaderG: Record "Warehouse Activity Header";
        PostedWhseReceiptLineG: Record "Posted Whse. Receipt Line";
        SalesLineCurrentFieldNo, InboundItemEntryG, OutboundItemEntryG : Integer;
        RemoveFilter: Boolean;

    procedure SetSalesLineCurrentFieldNo(CurrFieldNo: Integer)
    begin
        SalesLineCurrentFieldNo := CurrFieldNo;
    end;

    procedure GetSalesLineCurrentFieldNo(Var CurrFieldNo: Integer)
    begin
        CurrFieldNo := SalesLineCurrentFieldNo;
    end;

    procedure SetItemLedgerEntry(ItemLedgerEntry: Record "Item Ledger Entry")
    begin
        ItemLegderEntryG := ItemLedgerEntry;
    end;

    procedure GetItemLedgerEntry(Var ItemLedgerEntry: Record "Item Ledger Entry")
    begin
        ItemLedgerEntry := ItemLegderEntryG;
    end;

    procedure SetInboundandOutboundItemEntry(InboundItemEntry: Integer; OutboundItemEntry: Integer)
    begin
        InboundItemEntryG := InboundItemEntry;
        OutboundItemEntryG := OutboundItemEntry;
    end;

    procedure GetInboundandOutboundItemEntry(var InboundItemEntry: Integer; var OutboundItemEntry: Integer)
    begin
        InboundItemEntry := InboundItemEntryG;
        OutboundItemEntry := OutboundItemEntryG;
    end;

    procedure SetWarehouseActivityHeader(WarehouseActivityHeader: Record "Warehouse Activity Header")
    begin
        WarehouseActivityHeaderG := WarehouseActivityHeader;
    end;

    procedure GetWarehouseActivityHeader(Var WarehouseActivityHeader: Record "Warehouse Activity Header")
    begin
        WarehouseActivityHeader := WarehouseActivityHeaderG;
    end;

    procedure SetPostedWhseReceiptLine(PostedWhseReceiptLine: Record "Posted Whse. Receipt Line")
    begin
        PostedWhseReceiptLineG := PostedWhseReceiptLine;
    end;

    procedure GetPostedWhseReceiptLine(Var PostedWhseReceiptLine: Record "Posted Whse. Receipt Line")
    begin
        PostedWhseReceiptLine := PostedWhseReceiptLineG;
    end;

    procedure MakeRemoveFilter(RemoveFilterLVar: Boolean)
    begin
        RemoveFilter := RemoveFilterLVar;
    end;

    [EventSubscriber(ObjectType::Table, Database::"LAX Packing Control", pubOnAfterSetSalesLineFilterCalcTotalVal, '', false, false)]
    local procedure "LAX Packing Control_pubOnAfterSetSalesLineFilterCalcTotalVal"(var SalesLine: Record "Sales Line")
    begin
        if RemoveFilter then
            SalesLine.SetRange("Outstanding Quantity");
        RemoveFilter := false;
    end;

}