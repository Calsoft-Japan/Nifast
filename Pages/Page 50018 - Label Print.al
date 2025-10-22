page 50018 "Label Print"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Item Entry Relation";
    SourceTableView = SORTING("Source ID", "Source Type", "Source Subtype", "Source Ref. No.", "Source Prod. Order Line", "Source Batch Name");

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; PurchRcptHdr."No.")
                {
                    Caption = 'Purch. Rcpt. No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Purch. Rcpt. No. field.';
                }
                field("Order No."; PurchRcptHdr."Order No.")
                {
                    Caption = 'Order No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Order No. field.';
                }
                field("Buy-from Vendor No."; PurchRcptHdr."Buy-from Vendor No.")
                {
                    Caption = 'Vendor No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Vendor No. field.';
                }
                field("Buy-from Vendor Name"; PurchRcptHdr."Buy-from Vendor Name")
                {
                    Caption = 'Vendor Name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Vendor Name field.';
                }
            }
            group(Generals)
            {
                Editable = false;
                field("Item No."; ItemLedgEntry."Item No.")
                {
                    Caption = 'Item No.';
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field(Description; PurchRcptLine.Description)
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ToolTip = 'Specifies the value of the Lot No. field.';
                }
                field("Mfg. Lot No."; ItemLedgEntry."Mfg. Lot No.")
                {
                    Caption = 'Mfg. Lot No.';
                    ToolTip = 'Specifies the value of the Mfg. Lot No. field.';
                }
                field(Quantity; ItemLedgEntry.Quantity)
                {
                    Caption = 'Quantity';
                    DecimalPlaces = 0 : 2;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Units per Parcel"; PurchRcptLine."Units per Parcel")
                {
                    BlankZero = true;
                    Caption = 'Units per Parcel';
                    //DecimalPlaces = 0 : 2;
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Units per Parcel field.';
                }
                field(Packs; Packs)
                {
                    BlankZero = true;
                    Caption = 'Packs';
                    DecimalPlaces = 0 : 2;
                    ToolTip = 'Specifies the value of the Packs field.';
                }
                field("Order Line No."; Rec."Order Line No.")
                {
                    ToolTip = 'Specifies the value of the Order Line No. field.';
                }
                field("Source Ref. No."; Rec."Source Ref. No.")
                {
                    Caption = 'Line No.';
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Print Label")
            {
                Caption = '&Print Label';
                Promoted = true;
                Image = Print;
                PromotedOnly = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the &Print Label action.';

                trigger OnAction()
                begin
                    CASE Rec."Source Type" OF
                        DATABASE::"Purch. Rcpt. Line":
                            PrintReceivingLabel();
                        ELSE
                            ERROR('Source Type %1 not supported.', Rec."Source Type");
                    END;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF NOT ItemLedgEntry.GET(Rec."Item Entry No.") THEN
            CLEAR(ItemLedgEntry)
        ELSE
            ItemLedgEntry.CALCFIELDS("Mfg. Lot No.");

        IF NOT PurchRcptHdr.GET(Rec."Source ID") THEN
            CLEAR(PurchRcptHdr);

        IF NOT PurchRcptLine.GET(Rec."Source ID", Rec."Source Ref. No.") THEN
            CLEAR(PurchRcptLine);

        IF PurchRcptLine."Units per Parcel" <> 0 THEN
            Packs := ItemLedgEntry.Quantity / PurchRcptLine."Units per Parcel"
        ELSE
            Packs := 0;
    end;

    var
        ItemLedgEntry: Record "Item Ledger Entry";
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        Packs: Decimal;

    procedure PrintReceivingLabel()
    var
        Receive: Record "LAX Receive";
        ReceiveLine: Record "LAX Receive Line";
        Item: Record Item;
        ItemLedgEntry2: Record "Item Ledger Entry";
        LotNoInfo: Record "Lot No. Information";
        PurchRcptLineLRec: Record "Purch. Rcpt. Line";
        LabelMgt: Codeunit "Label Mgmt NIF";
        UseReceiveNo: Code[20];
    begin
        //get source line for supporting info
        IF NOT PurchRcptLineLRec.GET(Rec."Source ID", Rec."Source Ref. No.") THEN
            ERROR('Information could not be retrieved.');

        //get lot info for mfg. lot no rec
        IF NOT LotNoInfo.GET(PurchRcptLineLRec."No.", '', Rec."Lot No.") THEN
            CLEAR(LotNoInfo);

        //get ILE entry info
        IF NOT ItemLedgEntry2.GET(Rec."Item Entry No.") THEN
            CLEAR(ItemLedgEntry2);

        //get item info
        Item.GET(PurchRcptLineLRec."No.");

        //now print
        UseReceiveNo := USERID + 'RPRT';
        IF Receive.GET(UseReceiveNo) THEN
            Receive.DELETE(TRUE);

        Receive.INIT();
        Receive."No." := UseReceiveNo;
        //Receive."Purchase Order No." := PurchRcptLine."Order No.";
        Receive.INSERT();

        ReceiveLine.INIT();
        ReceiveLine."Receive No." := Receive."No.";
        ReceiveLine.Type := ReceiveLine.Type::Item;
        ReceiveLine."No." := PurchRcptLineLRec."No.";
        ReceiveLine.Description := Item.Description;
        ReceiveLine.Quantity := ItemLedgEntry2.Quantity;
        ReceiveLine."Quantity (Base)" := ItemLedgEntry2.Quantity;
        ReceiveLine."Lot No." := Rec."Lot No.";
        //ReceiveLine."Purchase Order No." := PurchRcptLine."Order No.";
        ReceiveLine."Mfg. Lot No." := LotNoInfo."Mfg. Lot No.";
        ReceiveLine.INSERT();

        LabelMgt.PromptReceiveLineLabel(ReceiveLine, ReceiveLine.Quantity, ReceiveLine.Quantity, TRUE);

        Receive.DELETE(TRUE);
    end;
}

