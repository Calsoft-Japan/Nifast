tableextension 50051 "Purchase Price Ext" extends "Purchase Price"
{
    // Version NAVW17.00,NV4.35;
    fields
    {
        modify("Direct Unit Cost")
        {
            trigger OnBeforeValidate()
            begin
                //TODO
                /*   // >> NV
                  GetAltUOM;
                  // << NV */
                //TODO
            end;
        }
    }

    //TODO
    /*  PROCEDURE GetAltUOM();
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
     END; */
    //TODO
}