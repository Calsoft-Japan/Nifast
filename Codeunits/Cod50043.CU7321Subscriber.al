codeunit 50043 CU7321Subscriber
{
    //Version NAVW17.00,NV4.35,NIF.N15.C9IN.001;

    var
        CurrLocation: Record Location;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Inventory Put-away", OnBeforeNewWhseActivLineInsertFromPurchase, '', false, false)]
    local procedure OnBeforeNewWhseActivLineInsertFromPurchase(var WarehouseActivityLine: Record "Warehouse Activity Line"; PurchaseLine: Record "Purchase Line")
    var
        Item: Record Item;
        InvtSetup: Record 313;
        NVM: Codeunit 50021;
    begin
        GetLocation(PurchaseLine."Location Code");
        //TODO
        // >> NV
        //if Item is on QC Hold then assign to inbound bin
       // IF NVM.TestPermission(14018070) THEN BEGIN
            InvtSetup.GET();
            Item.GET(WarehouseActivityLine."Item No.");
            IF (Item."QC Hold") AND (CurrLocation."Bin Mandatory") AND (InvtSetup."QC Hold On Purch. Receipts") THEN
                WarehouseActivityLine."Bin Code" := CurrLocation."Inbound QC Bin Code";
        //END;
        // << NV 
        //TODO
    end;

    local procedure GetLocation(LocationCode: Code[10])
    begin
        if LocationCode = '' then
            Clear(CurrLocation)
        else
            if LocationCode <> CurrLocation.Code then
                CurrLocation.Get(LocationCode);
    end;
}
