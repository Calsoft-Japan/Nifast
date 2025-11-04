tableextension 57302 BinContentExt extends "Bin Content"
{
    fields
    {
        field(70000; "Wksh. Pos. Adjmt. Qty."; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Whse. Worksheet Line"."Qty. Outstanding (Base)" WHERE("Location Code" = FIELD("Location Code"),
                                                                                                                           "To Bin Code" = FIELD("Bin Code"),
                                                                                                                           "Item No." = FIELD("Item No."),
                                                                                                                           "Variant Code" = FIELD("Variant Code"),
                                                                                                                           "Unit of Measure Code" = FIELD("Unit of Measure Code")));
            DecimalPlaces = 0 : 5;
            Description = 'NV';
            Editable = false;
        }
        field(70001; "Min. Replenishment Qty."; Decimal)
        {
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(70002; "Max. Replenishment Qty."; Decimal)
        {
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(70003; "Replenishment Multiple"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(70004; "Break Pick when Qty. on Hand"; Option)
        {
            OptionMembers = " ",">= Min. Qty. (no split pick)","= Max. Qty. (allow split pick)";
        }
        field(70005; "Pick Bin Ranking"; Integer)
        {
        }
        field(70006; "Staging Bin"; Boolean)
        {
        }
        field(70007; "License Plate No. Filter"; code[20])
        {
            FieldClass = FlowFilter;
        }
        field(70008; "Pick Qty. To Handle"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Warehouse Activity Line"."License Qty. to Handle" WHERE("Location Code" = FIELD("Location Code"),
                                                                                                                             "Bin Code" = FIELD("Bin Code"),
                                                                                                                             "Item No." = FIELD("Item No."),
                                                                                                                             "Variant Code" = FIELD("Variant Code"),
                                                                                                                             "Unit of Measure Code" = FIELD("Unit of Measure Code"),
                                                                                                                             "Action Type" = CONST(Take),
                                                                                                                             "Lot No." = FIELD("Lot No. Filter"),
                                                                                                                             "Serial No." = FIELD("Serial No. Filter"),
                                                                                                                             "License Plate No." = FIELD("License Plate No. Filter")));
            CaptionML = ENU = 'Pick Qty. To Handle';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(70009; "QC Bin"; Boolean)
        {
        }
    }
    procedure GetCartonInfo(var SNP: Decimal; var CartonQty: Decimal);
    var
        Item: Record Item;
    begin
        if (Item.GET("Item No.")) and (Item."Units per Parcel" <> 0) then
            SNP := Item."Units per Parcel"
        else
            SNP := 0;

        if SNP <> 0 then begin
            Rec.CalcFields(Quantity);
            CartonQty := Round(Quantity / SNP, 0.01);
        end else
            CartonQty := 0;
    end;

}
