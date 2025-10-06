codeunit 50011 "Batch Purch. Quotes to Orders"
{
    // >> IST
    // Date     Init  SCR    Description
    // 04-11-05 DPC   #9806  New Codeunit to handle "4X Contracts"
    //                #9806   - batch process all related PQ to an Master Quote. Create Orders from Qoutes and check for mandatory fields
    // 
    // << IST

    TableNo = 50011;

    trigger OnRun()
    begin
        TESTFIELD("Authorized By");

        PurchHeader.SETRANGE("Document Type", PurchHeader."Document Type"::Quote);
        PurchHeader.SETRANGE("Contract Note No.", Rec."No.");

        IF PurchHeader.FIND('-') THEN
          REPEAT
            PurchOrderToQuote.RUN(PurchHeader);
          UNTIL PurchHeader.NEXT = 0;
    end;

    var
        PurchOrderToQuote: Codeunit "96";
        PurchHeader: Record "38";
}

