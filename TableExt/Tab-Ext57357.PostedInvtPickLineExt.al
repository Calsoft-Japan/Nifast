tableextension 57357 "Posted Invt. Pick Line Ext" extends "Posted Invt. Pick Line"
{
    fields
    {
        //TODO
        /* field(14017999; "License Plate No."; Code[20])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
        } */
        //TODO
    }
    keys
    {
        //TODO
        /*   key(Key1; "License Plate No.")
          {
          } */
        //TODO
    }
    PROCEDURE ShowRegisteredActivityDoc();
    VAR
        RegisteredWhseActivHeader: Record 5772;
        RegisteredPickCard: Page 5798;
    BEGIN
        RegisteredWhseActivHeader.SETRANGE("No.", "No.");
        RegisteredPickCard.SETTABLEVIEW(RegisteredWhseActivHeader);
        RegisteredPickCard.RunModal();
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
        WhseEntries.RunModal();
    END;

}