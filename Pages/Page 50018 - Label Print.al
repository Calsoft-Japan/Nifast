page 50018 "Label Print"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = Table6507;
    SourceTableView = SORTING(Source ID,Source Type,Source Subtype,Source Ref. No.,Source Prod. Order Line,Source Batch Name);

    layout
    {
        area(content)
        {
            group()
            {
                field(PurchRcptHdr."No.";PurchRcptHdr."No.")
                {
                    Caption = 'Purch. Rcpt. No.';
                    Editable = false;
                }
                field(PurchRcptHdr."Order No.";PurchRcptHdr."Order No.")
                {
                    Caption = 'Order No.';
                    Editable = false;
                }
                field(PurchRcptHdr."Buy-from Vendor No.";PurchRcptHdr."Buy-from Vendor No.")
                {
                    Caption = 'Vendor No.';
                    Editable = false;
                }
                field(PurchRcptHdr."Buy-from Vendor Name";PurchRcptHdr."Buy-from Vendor Name")
                {
                    Caption = 'Vendor Name';
                    Editable = false;
                }
            }
            repeater()
            {
                Editable = false;
                field(ItemLedgEntry."Item No.";ItemLedgEntry."Item No.")
                {
                    Caption = 'Item No.';
                }
                field(PurchRcptLine.Description;PurchRcptLine.Description)
                {
                    Caption = 'Description';
                }
                field("Lot No.";"Lot No.")
                {
                }
                field(ItemLedgEntry."Mfg. Lot No.";ItemLedgEntry."Mfg. Lot No.")
                {
                    Caption = 'Mfg. Lot No.';
                }
                field(ItemLedgEntry.Quantity;ItemLedgEntry.Quantity)
                {
                    Caption = 'Quantity';
                    DecimalPlaces = 0:2;
                }
                field(PurchRcptLine."Units per Parcel";PurchRcptLine."Units per Parcel")
                {
                    BlankZero = true;
                    Caption = 'Units per Parcel';
                    DecimalPlaces = 0:2;
                    MultiLine = true;
                }
                field(Packs;Packs)
                {
                    BlankZero = true;
                    Caption = 'Packs';
                    DecimalPlaces = 0:2;
                }
                field("Order Line No.";"Order Line No.")
                {
                }
                field("Source Ref. No.";"Source Ref. No.")
                {
                    Caption = 'Line No.';
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
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    CASE "Source Type" OF
                      DATABASE::"Purch. Rcpt. Line" :
                        PrintReceivingLabel;
                      ELSE ERROR('Source Type %1 not supported.',"Source Type");
                    END;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF NOT ItemLedgEntry.GET("Item Entry No.") THEN
          CLEAR(ItemLedgEntry)
        ELSE
          ItemLedgEntry.CALCFIELDS("Mfg. Lot No.");

        IF NOT PurchRcptHdr.GET("Source ID") THEN
          CLEAR(PurchRcptHdr);

        IF NOT PurchRcptLine.GET("Source ID","Source Ref. No.") THEN
          CLEAR(PurchRcptLine);

        IF PurchRcptLine."Units per Parcel"<> 0 THEN
          Packs := ItemLedgEntry.Quantity/PurchRcptLine."Units per Parcel"
        ELSE
          Packs := 0;
    end;

    var
        ItemLedgEntry: Record "32";
        PurchRcptHdr: Record "120";
        PurchRcptLine: Record "121";
        Packs: Decimal;

    procedure PrintReceivingLabel()
    var
        Receive: Record "14000601";
        ReceiveLine: Record "14000602";
        UseReceiveNo: Code[20];
        Item: Record "27";
        NoSeriesMgt: Codeunit "396";
        LabelMgt: Codeunit "50017";
        PurchRcptLine: Record "121";
        LotNoInfo: Record "6505";
        ItemLedgEntry2: Record "32";
    begin
        //get source line for supporting info
        IF NOT PurchRcptLine.GET("Source ID","Source Ref. No.") THEN
          ERROR('Information could not be retrieved.');

        //get lot info for mfg. lot no rec
        IF NOT LotNoInfo.GET(PurchRcptLine."No.",'',"Lot No.") THEN
          CLEAR(LotNoInfo);

        //get ILE entry info
        IF NOT ItemLedgEntry2.GET("Item Entry No.") THEN
          CLEAR(ItemLedgEntry2);

        //get item info
        Item.GET(PurchRcptLine."No.");

        //now print
        UseReceiveNo := USERID + 'RPRT';
        IF Receive.GET(UseReceiveNo) THEN
          Receive.DELETE(TRUE);

        Receive.INIT;
        Receive."No." := UseReceiveNo;
        //Receive."Purchase Order No." := PurchRcptLine."Order No.";
        Receive.INSERT;

        ReceiveLine.INIT;
        ReceiveLine."Receive No." := Receive."No.";
        ReceiveLine.Type := ReceiveLine.Type::Item;
        ReceiveLine."No." := PurchRcptLine."No.";
        ReceiveLine.Description := Item.Description;
        ReceiveLine.Quantity := ItemLedgEntry2.Quantity;
        ReceiveLine."Quantity (Base)" := ItemLedgEntry2.Quantity;
        ReceiveLine."Lot No." := "Lot No.";
        //ReceiveLine."Purchase Order No." := PurchRcptLine."Order No.";
        ReceiveLine."Mfg. Lot No." := LotNoInfo."Mfg. Lot No.";
        ReceiveLine.INSERT;

        LabelMgt.PromptReceiveLineLabel(ReceiveLine,ReceiveLine.Quantity,ReceiveLine.Quantity,TRUE);

        Receive.DELETE(TRUE);
    end;
}

