reportextension 50001 "Physical Inventory Count Ext" extends "Physical Inventory Count"
{
    //  Version List=NAVNA8.00,NIF.N15.C9IN.001;
    dataset
    {
        modify("Item Journal Line")
        {
            trigger OnAfterAfterGetRecord()
            begin
                if "Item No." <> '' then begin
                    ItemRec.Get("Item No.");
                end else
                    Clear(ItemRec);

                //>> NIF 10-06-05
                LotString := GetLotString;
                //<< NIF 10-06-05
            end;
        }
        add("Item Journal Line")
        {

            column(Item_Journal_Line_Lot_No; "Item Journal Line".FIELDCAPTION("Lot No."))
            {

            }
            column(SNPCaptionLbl; SNPCaptionLbl)
            {

            }
            column(LotString; LotString)
            {

            }
            column(Item__Units_Per_Parcel; ItemRec."Units per Parcel")
            {

            }
        }
    }
    rendering
    {
        layout(MyRDLCLayout)
        {
            Type = RDLC;
            Caption = 'Physical Inventory Count';
            LayoutFile = '.\RDLC\PhysicalInventoryCount.rdl';
        }
    }
    var
        ItemRec: Record Item;
        ">>NIF_GV": Integer;
        LotString: Text[1024];
        SNPCaptionLbl: Label 'SNP';

    PROCEDURE ">>NIF_fcn"();
    BEGIN
    END;

    PROCEDURE GetLotString(): Text[1024];
    VAR
        ReservEntry: Record 337;
        LotText: Text[1024];
        Counter: Integer;
    BEGIN
        CLEAR(LotText);
        CLEAR(Counter);
        ReservEntry.SETCURRENTKEY(
            "Source Type", "Source Subtype", "Source ID", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.");

        ReservEntry.SETRANGE("Source Type", DATABASE::"Item Journal Line");
        ReservEntry.SETFILTER("Source Subtype", '2|3');
        ReservEntry.SETRANGE("Source ID", "Item Journal Line"."Journal Template Name");
        ReservEntry.SETRANGE("Source Batch Name", "Item Journal Line"."Journal Batch Name");
        ReservEntry.SETRANGE("Source Ref. No.", "Item Journal Line"."Line No.");
        ReservEntry.SETFILTER("Lot No.", '<>%1', '');
        IF ReservEntry.ISEMPTY THEN
            EXIT('');

        IF ReservEntry.FIND('-') THEN
            REPEAT
                Counter := Counter + 1;
                IF Counter > 1 THEN
                    LotText := LotText + ',' + ReservEntry."Lot No."
                ELSE
                    LotText := ReservEntry."Lot No.";
            UNTIL (ReservEntry.NEXT = 0) OR (STRLEN(LotText) > 1000);

        EXIT(LotText);
    END;
}
