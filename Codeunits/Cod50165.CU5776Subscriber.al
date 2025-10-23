codeunit 50165 CU5776Subscriber
{
    //Version List=NAVW17.00,NIF0.003,NIF.N15.C9IN.001;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Warehouse Document-Print", OnBeforePrintPickHeader, '', false, false)]
    local procedure OnBeforePrintPickHeader(var WarehouseActivityHeader: Record "Warehouse Activity Header"; var IsHandled: Boolean)
    var
        WhsePick: Report 50045;
    begin
        IsHandled := true;

        WarehouseActivityHeader.SETRANGE("No.", WarehouseActivityHeader."No.");
        WhsePick.SETTABLEVIEW(WarehouseActivityHeader);
        WhsePick.SetBreakbulkFilter(WarehouseActivityHeader."Breakbulk Filter");
        WhsePick.RUNMODAL();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Warehouse Document-Print", OnBeforePrintInvtPickHeader, '', false, false)]
    local procedure OnBeforePrintInvtPickHeader(var WarehouseActivityHeader: Record "Warehouse Activity Header"; var IsHandled: Boolean; var HideDialog: Boolean)
    var
        WhsePick: Report 50045;
    begin
        IsHandled := true;

        WarehouseActivityHeader.SETRANGE("No.", WarehouseActivityHeader."No.");
        WhsePick.SETTABLEVIEW(WarehouseActivityHeader);
        WhsePick.SetInventory(true);
        WhsePick.SetBreakbulkFilter(false);
        WhsePick.USEREQUESTPAGE(NOT HideDialog);
        WhsePick.RUNMODAL();
    end;

}