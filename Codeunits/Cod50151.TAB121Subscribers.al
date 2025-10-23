codeunit 50151 TAB121Subscribers
{
    [EventSubscriber(ObjectType::Table, Database::"Purch. Rcpt. Line", OnBeforeInsertInvLineFromRcptLineBeforeInsertTextLine, '', false, false)]
    local procedure "Purch. Rcpt. Line_OnBeforeInsertInvLineFromRcptLineBeforeInsertTextLine"(var PurchRcptLine: Record "Purch. Rcpt. Line"; var PurchLine: Record "Purchase Line"; var NextLineNo: Integer; var Handled: Boolean)
    var
        PurchInvHeader: Record "Purchase Header";
    begin
        if PurchInvHeader.Get(PurchLine."Document Type", PurchLine."Document No.") then
            // NF2.00:CIS.RAM >>>
            PurchLine."Pay-to Vendor No." := PurchInvHeader."Pay-to Vendor No.";
        // NF2.00:CIS.RAM <<<
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purch. Rcpt. Line", OnAfterInsertInvLineFromRcptLine, '', false, false)]
    local procedure "Purch. Rcpt. Line_OnAfterInsertInvLineFromRcptLine"(var PurchLine: Record "Purchase Line"; PurchOrderLine: Record "Purchase Line"; var NextLineNo: Integer; PurchRcptLine: Record "Purch. Rcpt. Line")
    var
        PurchCalcDiscount: Codeunit "Purch.-Calc.Discount";
    begin
        PurchCalcDiscount.CalculateInvoiceDiscountOnLine(PurchLine);
    end;

}
