tableextension 50051 "Purchase Price Ext" extends "Purchase Price"
{
    // Version NAVW17.00,NV4.35;
    fields
    {
        field(14017614; "Alt. Price"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            Editable = false;

            trigger OnValidate()
            var
                ItemUOMRec2: Record "Item Unit of Measure";
            begin
        
            end;
        }

        field(14017615; "Alt. Price UOM"; Code[10])
        {
            Editable = false;
        }

        modify("Direct Unit Cost")
        {
            trigger OnBeforeValidate()
            begin
                // >> NV
                GetAltUOM();
                // << NV
            end;
        }
    }

    PROCEDURE GetAltUOM();
    VAR
        ItemUOM: Record 5404;
    BEGIN
        ItemUOM.RESET;
        ItemUOM.SETRANGE("Item No.", "Item No.");
        ItemUOM.SETRANGE("Purchase Qty Alt.", TRUE);
        IF ItemUOM.FIND('-') THEN BEGIN
            "Alt. Price UOM" := ItemUOM."Purchase Price Per Alt.";
            IF ItemUOM."Purchase Price Per Alt." <> '' THEN BEGIN
                ItemUOM.RESET;
                ItemUOM.GET("Item No.", ItemUOM."Purchase Price Per Alt.");
                "Alt. Price" := "Direct Unit Cost" * ItemUOM."Qty. per Unit of Measure";
            END;
        END;
    END;
}