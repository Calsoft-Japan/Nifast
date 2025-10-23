codeunit 50202 Tab27Subscriber
{
    [EventSubscriber(ObjectType::Table, Database::Item, OnBeforeOnInsert, '', false, false)]
    local procedure OnBeforeOnInsert(var Item: Record Item; var IsHandled: Boolean; xRecItem: Record Item)
    begin
        //>> NIF 06-08-05 RTT
        GetInvtSetup();
        Item.VALIDATE("Item Tracking Code", InventorySetup."Def. Item Tracking Code");
        Item.VALIDATE("Lot Nos.", InventorySetup."Def. Lot Nos.");
        //TODO
        //Item.VALIDATE("E-Ship Tracking Code", InventorySetup."Def. E-ship Tracking Code");
        //TODO
        //<< NIF 06-08-05 RTT
    end;

    local procedure GetInvtSetup()
    begin
        if not HasInvtSetup then begin
            InventorySetup.Get();
            HasInvtSetup := true;
        end;
    end;

    var
        InventorySetup: Record "Inventory Setup";
        HasInvtSetup: Boolean;
}