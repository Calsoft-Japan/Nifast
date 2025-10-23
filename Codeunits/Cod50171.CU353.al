codeunit 50171 CU_353
{
    [EventSubscriber(ObjectType::Codeunit, 353, 'OnAfterCalcItemPlanningFields', '', True, false)]
    local procedure OnAfterCalcItemPlanningFields(var Item: Record Item)
    begin
        //>> NIF 07-08-05
        Item.CalcFields("Qty. on Blanket SO");
        Item.CalcFields("Qty. on Blanket PO");
        //<< NIF 07-08-05

    end;


}
