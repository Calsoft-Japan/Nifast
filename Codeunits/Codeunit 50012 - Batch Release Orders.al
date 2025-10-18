codeunit 50012 "Batch Release Orders"
{
    // >> IST
    // Date     Init  SCR    Description
    // 04-11-05 DPC   #9806  New Codeunit to handle "4X Contracts" - batch process all related PO to an Master order and Release Orders.
    // << IST

    TableNo = 50011;

    trigger OnRun()
    begin
        PurchHeader.SETRANGE("Document Type", PurchHeader."Document Type"::Order);
        PurchHeader.SETRANGE("Contract Note No.", Rec."No.");
        PurchHeader.SETRANGE(Status, PurchHeader.Status::Open);

        IF PurchHeader.FIND('-') THEN BEGIN
            REPEAT
                BatchRelease.RUN(PurchHeader);
            UNTIL PurchHeader.NEXT() = 0;
            MESSAGE(TEXT001);
        END ELSE
            MESSAGE(TEXT002);
    end;

    var
        PurchHeader: Record 38;
        BatchRelease: Codeunit 415;
        TEXT001: Label 'All Purchase Orders Released';
        TEXT002: Label 'Nothing to Release';
}

