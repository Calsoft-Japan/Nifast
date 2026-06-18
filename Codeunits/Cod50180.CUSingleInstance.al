codeunit 50180 CUSingleInstance
{
    SingleInstance = true;
    procedure MakeRemoveFilter(RemoveFilterLVar: Boolean)
    begin
        RemoveFilter := RemoveFilterLVar;
    end;

    [EventSubscriber(ObjectType::Table, Database::"LAX Packing Control", pubOnAfterSetSalesLineFilterCalcTotalVal, '', false, false)]
    local procedure "LAX Packing Control_pubOnAfterSetSalesLineFilterCalcTotalVal"(var SalesLine: Record "Sales Line")
    begin
        if RemoveFilter then
            SalesLine.SetRange("Outstanding Quantity");
        RemoveFilter := false;
    end;

    var
        RemoveFilter: Boolean;
}
