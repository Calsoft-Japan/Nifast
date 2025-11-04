codeunit 50028 CU311Subscriber
{
    //Version NAVW18.00.00.41370,AKK1606.01;

    var
    /*    ItemCheckAvailCU: Codeunit "Item-Check Avail.";
       AKKText001: Label 'The item code %1 is not national and is not it''s not has enough stock to relate to a Entry Point. First, it must enter the Entry/Exit Point Code, Entry Point No. and Entry Point Date in the sales line.'; */


    /*   LOCAL PROCEDURE "//AKK1601.01--"();
      BEGIN
      END; */

    PROCEDURE OrderSalesLineCheck(SalesLine: Record 37);
    BEGIN
        /*   //-AKK1606.01--
          IF ((ItemCheckAvailCU.SalesLineShowWarning(SalesLine, TRUE)) AND (NOT SalesLine.National) AND
          ((SalesLine."Document Type" = SalesLine."Document Type"::Order) OR (SalesLine."Document Type" = SalesLine."Document Type"::Invoice)) AND
          ((SalesLine."Entry/Exit No." = '') OR (SalesLine."Entry/Exit Date" = 0D) OR (SalesLine."Exit Point" = ''))) THEN
              ERROR(AKKText001, SalesLine."No.");
          //+AKK1603++ */
    END;

    /*  LOCAL PROCEDURE "//AKK1601.01++"();
     BEGIN
     END; */
}