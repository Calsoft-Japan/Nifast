codeunit 50002 TAB5766Subscribers
{
    [EventSubscriber(ObjectType::Table, Database::"Warehouse Activity Header", OnBeforeSortWhseDoc, '', false, false)]
    local procedure "Warehouse Activity Header_OnBeforeSortWhseDoc"(var WarehouseActivityHeader: Record "Warehouse Activity Header"; var IsHandled: Boolean)
    begin
        case WarehouseActivityHeader."Sorting Method" of
            WarehouseActivityHeader."Sorting Method"::"Shelf or Bin":
                if ((WarehouseActivityHeader.Type <> WarehouseActivityHeader.Type::"Invt. Put-away") and (WarehouseActivityHeader.Type <> WarehouseActivityHeader.Type::"Invt. Pick")) then
                    IsHandled := true;
        end;
    end;

}
