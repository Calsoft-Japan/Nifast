tableextension 57302 BinContentExt extends "Bin Content"
{
    fields
    {
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
