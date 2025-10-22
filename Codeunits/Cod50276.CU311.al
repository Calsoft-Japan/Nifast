codeunit 50276 CU_311
{
    PROCEDURE OrderSalesLineCheck(SalesLine: Record 37);
    var
        ITEMCHECKLINE: Codeunit 311;
        AKKText001: label 'The item code %1 is not national and is not it''s not has enough stock to relate to a Entry Point. First, it must enter the Entry/Exit Point Code, Entry Point No. and Entry Point Date in the sales line.';
    BEGIN
        //-AKK1606.01--
        IF ((ITEMCHECKLINE.SalesLineShowWarning(SalesLine)) AND (NOT SalesLine.National) AND
        ((SalesLine."Document Type" = SalesLine."Document Type"::Order) OR (SalesLine."Document Type" = SalesLine."Document Type"::Invoice)) AND
        ((SalesLine."Entry/Exit No." = '') OR (SalesLine."Entry/Exit Date" = 0D) OR (SalesLine."Exit Point" = ''))) THEN
            ERROR(AKKText001, SalesLine."No.");
        //+AKK1603++
    END;


}
