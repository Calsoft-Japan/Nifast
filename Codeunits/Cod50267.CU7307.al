codeunit 50267 CU_7307
{
    [EventSubscriber(ObjectType::Codeunit, 7307, 'OnBeforeWhseJnlRegisterLine', '', True, false)]

    local procedure OnBeforeWhseJnlRegisterLine(var WarehouseJournalLine: Record "Warehouse Journal Line"; WarehouseActivityLine: Record "Warehouse Activity Line")
    begin
        // >> NV - 10/02/03 JDC
        WarehouseJournalLine."License Plate Operation Type" := WarehouseJournalLine."License Plate Operation Type"::Movement;
        // << NV - 10/02/03 JDC

        if WarehouseActivityLine."Action Type" = WarehouseActivityLine."Action Type"::Take then
            // >> NV - 10/02/03 JDC
            WarehouseJournalLine."From License Plate No." := WarehouseActivityLine."License Plate No."
        // << NV - 10/02/03 JDC
        else
            // >> NV - 10/02/03 JDC
          WarehouseJournalLine."To License Plate No." := WarehouseActivityLine."License Plate No.";
        // << NV - 10/02/03 JDC
    end;


}
