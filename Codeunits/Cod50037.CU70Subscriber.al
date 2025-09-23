codeunit 50037 CU70Subscriber
{
    var
        PurchLine: Record "Purchase Line";
        PurchCalcDiscountCU: Codeunit "Purch.-Calc.Discount";
        UpdateHeader: Boolean;

    PROCEDURE CalculateInvoiceDiscountOnLine(VAR PurchLineToUpdate: Record 39);
    VAR
        PurchHeaderTemp: Record 38;
    BEGIN
        //added by JRR 06-23-16
        PurchLine.COPY(PurchLineToUpdate);

        PurchHeaderTemp.GET(PurchLineToUpdate."Document Type", PurchLineToUpdate."Document No.");
        UpdateHeader := TRUE;
        PurchCalcDiscountCU.CalculateInvoiceDiscount(PurchHeaderTemp, PurchLineToUpdate);

        PurchLineToUpdate.COPY(PurchLine);
    END;
}