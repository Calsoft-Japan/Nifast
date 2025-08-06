tableextension 57357 "Posted Invt. Pick Line Ext" extends "Posted Invt. Pick Line"
{
    PROCEDURE ShowRegisteredActivityDoc();
    VAR
        RegisteredWhseActivHeader: Record 5772;
        RegisteredPickCard: Page 5798;
    BEGIN
        RegisteredWhseActivHeader.SETRANGE("No.", "No.");
        RegisteredPickCard.SETTABLEVIEW(RegisteredWhseActivHeader);
        RegisteredPickCard.RUNMODAL;
    END;

    PROCEDURE ShowWhseEntries(RegisterDate: Date);
    VAR
        WhseEntry: Record 7312;
        WhseEntries: Page 7318;
    BEGIN
        WhseEntry.SETCURRENTKEY("Reference No.", "Registering Date");
        WhseEntry.SETRANGE("Reference No.", "No.");
        WhseEntry.SETRANGE("Registering Date", RegisterDate);
        WhseEntry.SETRANGE("Reference Document", WhseEntry."Reference Document"::Pick);
        WhseEntries.SETTABLEVIEW(WhseEntry);
        WhseEntries.RUNMODAL;
    END;

}