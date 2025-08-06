pageextension 55404 "Item Units of Measure Ext" extends "Item Units of Measure"
{
    //Version NAVW17.10,SE0.54.10,NV4.35,SE0.22,NIF1.022,NIF.N15.C9IN.001;
    trigger OnDeleteRecord(): Boolean
    begin
        //>> NIF 07-27-05 RTT
        CheckEntriesForDeletion;
        //<< NIF 07-27-05 RTT
    end;

    PROCEDURE ">>NV_LV"();
    BEGIN
    END;

    PROCEDURE CheckEntriesForDeletion();
    VAR
        SalesLine: Record 37;
        PurchLine: Record 39;
        WhseEntry: Record 7312;
        TransferLine: Record 5741;
    BEGIN
        SalesLine.SETCURRENTKEY(Type, "No.");
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        SalesLine.SETRANGE("No.", Rec."Item No.");
        SalesLine.SETRANGE("Unit of Measure Code", Rec.Code);
        IF SalesLine.FIND('-') THEN
            ERROR('Sales Orders exist for Item %1 unit of measure %2', Rec."Item No.", Rec.Code);

        PurchLine.SETCURRENTKEY(Type, "No.");
        PurchLine.SETRANGE(Type, PurchLine.Type::Item);
        PurchLine.SETRANGE("No.", Rec."Item No.");
        PurchLine.SETRANGE("Unit of Measure Code", Rec.Code);
        IF PurchLine.FIND('-') THEN
            ERROR('Purchase Orders exist for Item %1 unit of measure %2', Rec."Item No.", Rec.Code);

        TransferLine.SETCURRENTKEY("Item No.");
        TransferLine.SETRANGE("Item No.", Rec."Item No.");
        TransferLine.SETRANGE("Unit of Measure Code", Rec.Code);
        IF TransferLine.FIND('-') THEN
            ERROR('Transfer Orders exist for Item %1 unit of measure %2', Rec."Item No.", Rec.Code);

        WhseEntry.SETCURRENTKEY("Item No.", Open);
        WhseEntry.SETRANGE("Item No.", Rec."Item No.");
        WhseEntry.SETRANGE(Open, TRUE);
        WhseEntry.SETRANGE("Unit of Measure Code", Rec.Code);
        IF WhseEntry.FIND('-') THEN
            ERROR('Open Whse Entries exist for Item %1, Unit of Measure %2', Rec."Item No.", Rec.Code);
    END;
}