tableextension 70015 LAXPostedPackage_NF extends "LAX Posted Package"
{
    procedure GetTotalParcels() TotalParcels: Decimal
    var
        PostedPackageLine: Record "LAX Posted Package Line";
        Item: Record Item;
    begin

        PostedPackageLine.SETRANGE("Package No.", "No.");
        PostedPackageLine.SETRANGE(Type, PostedPackageLine.Type::Item);

        IF PostedPackageLine.FIND('-') THEN
            REPEAT
                IF NOT Item.GET(PostedPackageLine."No.") THEN
                    CLEAR(Item);
                IF Item."Units per Parcel" <> 0 THEN
                    TotalParcels := TotalParcels + ROUND((PostedPackageLine."Quantity (Base)" / Item."Units per Parcel"), 1, '>');
            UNTIL PostedPackageLine.NEXT = 0;
    end;
}
