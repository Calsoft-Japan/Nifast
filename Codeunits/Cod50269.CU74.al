codeunit 50269 CU_74
{
    [EventSubscriber(ObjectType::Codeunit, 74, 'OnAfterPurchRcptLineSetFilters', '', True, false)]

    local procedure OnAfterPurchRcptLineSetFilters(var PurchRcptLine: Record "Purch. Rcpt. Line"; PurchaseHeader: Record "Purchase Header")
    var
        CheckDate: Date;
    begin
        //>> IST 030308 JWW  $12701 #12701 Purchase Receipt/Invoice date check
        //                             Added Local Variable: CheckDate
        IF PurchaseHeader."Posting Date" = 0D THEN
            CheckDate := CALCDATE('=CM', TODAY)
        ELSE
            CheckDate := CALCDATE('=CM', PurchaseHeader."Posting Date");
        PurchRcptLine.SETRANGE(PurchRcptLine."Posting Date", 0D, CheckDate);
        //<< IST 030308 JWW  $12701 #12701 Purchase Receipt/Invoice date check

    end;


}
