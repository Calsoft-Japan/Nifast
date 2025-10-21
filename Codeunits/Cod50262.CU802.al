codeunit 50262 CU_802
{
    [EventSubscriber(ObjectType::Codeunit, 802, 'OnAfterValidAddress', '', True, false)]

    local procedure OnAfterValidAddress(TableID: Integer; var IsValid: Boolean)
    begin
        // (TableID IN [// >> Shipping
        //   DATABASE::Package,
        //   DATABASE::"Posted Package",
        //   DATABASE::"Packing Station"]);
        //  // DATABASE::"Rate Shop Header",
          //DATABASE::"Bill of Lading"]);
        // << Shipping]


    end;

}
