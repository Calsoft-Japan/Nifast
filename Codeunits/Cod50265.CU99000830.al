codeunit 50265 CU_99000830
{
    [EventSubscriber(ObjectType::Codeunit, 99000830, 'OnCreateEntryOnBeforeSurplusCondition', '', True, false)]
    local procedure OnCreateEntryOnBeforeSurplusCondition(var ReservEntry: Record "Reservation Entry"; QtyToHandleAndInvoiceIsSet: Boolean; var InsertReservEntry: Record "Reservation Entry")
    begin
        // NF2.00:CIS.RAM >>>
        //ReservEntry.Description := Description;
        //ReservEntry.Description := COPYSTR(Description,1,STRPOS(Description,'~')-1);
        IF STRPOS(InsertReservEntry.Description, '~') > 0 THEN BEGIN
            IF STRLEN(COPYSTR(InsertReservEntry.Description, 1, STRPOS(InsertReservEntry.Description, '~') - 1)) > 50 THEN
                ReservEntry.Description := COPYSTR(InsertReservEntry.Description, 1, 50)
            ELSE
                ReservEntry.Description := COPYSTR(InsertReservEntry.Description, 1, STRPOS(InsertReservEntry.Description, '~') - 1);
            ReservEntry."Mfg. Lot No." := COPYSTR(InsertReservEntry.Description, STRPOS(InsertReservEntry.Description, '~') + 1, STRLEN(InsertReservEntry.Description));
        END ELSE
            ReservEntry.Description := COPYSTR(InsertReservEntry.Description, 1, 50);
        // NF2.00:CIS.RAM <<<

    end;

}
