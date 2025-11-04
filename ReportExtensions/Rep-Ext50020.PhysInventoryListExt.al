reportextension 50020 "Phys. Inventory List Ext" extends "Phys. Inventory List"
{
    dataset
    {
        add(PageLoop)
        {
            column(Format_Today; FORMAT(TODAY, 0, 4))
            {
            }
            column(Time; TIME)
            {
            }
        }
        modify("Item Journal Line")
        {
            trigger OnBeforeAfterGetRecord()
            begin
                //>> NIF
                IF NOT Item.GET("Item No.") THEN
                    CLEAR(Item);
                LotString := GetLotString;

                //>> NF1.00:CIS.NG  08/03/16
                IF LotString = '' THEN
                    LotString := "PIJ Lot No.";
                //<< NF1.00:CIS.NG  08/03/16

                //<< NIF
            end;
        }
        add("Item Journal Line")
        {
            column(UnitsPerParcel_Item; Item."Units per Parcel")
            {
                DecimalPlaces = 0 : 2;
            }
            column(LotString; LotString)
            {
            }
        }
    }

    requestpage
    {
        layout
        {
            modify(ShowCalculatedQty)
            {
                Visible = false;
            }
            modify(ShowSerialLotNumber)
            {
                Visible = false;
            }
        }
    }
    rendering
    {
        layout(MyRDLCLayout)
        {
            Type = RDLC;
            Caption = 'Phys. Inventory List';
            LayoutFile = '.\RDLC\PhysInventoryList.rdlc';
        }
    }
    labels
    {
        SNPLbl = 'SNP';
        LotNoLbl = 'Lot No.';
    }
    
    var
        Item: Record Item;
        ">>NIF_GV": Integer;
        LotString: Text[1024];

    PROCEDURE ">>NIF_fcn"();
    BEGIN
    END;

    PROCEDURE GetLotString(): Text[1024];
    VAR
        ReservEntry: Record "Reservation Entry";
        Counter: Integer;
        LotText: Text[1024];
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
