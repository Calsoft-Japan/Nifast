codeunit 50072 SingleInstance
{
    SingleInstance = true;

    var
        ItemLegderEntryG: Record "Item Ledger Entry";
        WarehouseActivityHeaderG: Record "Warehouse Activity Header";
        PostedWhseReceiptLineG: Record "Posted Whse. Receipt Line";
        SalesLineCurrentFieldNo, InboundItemEntryG, OutboundItemEntryG : Integer;
        SkipValidation: Boolean;

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

    procedure SkipValidationFn(Skip: Boolean)
    begin
        SkipValidation := Skip;
    end;

    [EventSubscriber(ObjectType::Table, Database::"LAX Packing Control", pubOnBeforeCalculateTotalValue, '', false, false)]
    local procedure "LAX Packing Control_pubOnBeforeCalculateTotalValue"(var Rec: Record "LAX Packing Control"; var TotalQuantityBase: Decimal; var TotalValueCostBase: Decimal; var TotalValuePriceBase: Decimal; var NewUnitOfMeasureCode: Code[10]; var MultiDocumentPackage: Boolean; var MultiDocumentNo: Code[250]; var LineType: Integer; var LineNo: Code[20]; var LineVariantCode: Code[10]; var FilterVariant: Boolean; var LineUnitOfMeasureCode: Code[10]; var FromUnitOfMeasureCode: Boolean; var SourceType: Integer; var SourceSubtype: Integer; var SourceID: Code[250]; var Handled: Boolean)
    begin
        if SkipValidation then
            Handled := true;
        SkipValidation := false;
    end;

    [EventSubscriber(ObjectType::Table, Database::"LAX Package Line", pubOnBeforeCalcValue, '', false, false)]
    local procedure "LAX Package Line_pubOnBeforeCalcValue"(var Rec: Record "LAX Package Line"; var Package: Record "LAX Package"; var FromUnitOfMeasureCode: Boolean; var FilterVariant: Boolean; var Handled: Boolean)
    begin
        if SkipValidation then
            Handled := true;
        SkipValidation := false;
    end;


}