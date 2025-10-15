codeunit 50022 "Update Documents from Item"
{
    // NF1.00:CIS.NG  09-03-15 Merged during upgrade. Create new codeunit to move Menuitem (Update Documents from Item) code from Inventory menu
    // >> NIF
    // Menu Items Added:
    //   Lots
    //   Periodic Activities/Update Documents from Item
    // << NIF


    trigger OnRun()
    var
        ">>NIF_LV": Integer;
        Item: Record 27;
        SalesLine: Record 37;
        PurchLine: Record 39;
        d: Dialog;
    begin
        IF NOT CONFIRM('Do you want to update Sales and Purchase line\'+
                       'from Information on the Item Card?') THEN
           ERROR('Operation Canceled.');

        d.OPEN('Updating Item #1##################\'+
               'Document #2#######################');
        Item.FIND('-');
        REPEAT
         d.UPDATE(1,Item."No.");
         PurchLine.SETCURRENTKEY(Type,"No.");
         PurchLine.SETRANGE(Type,PurchLine.Type::Item);
         PurchLine.SETRANGE("No.",Item."No.");
         IF PurchLine.FIND('-') THEN
           REPEAT
             d.UPDATE(2,'Purch. ' + FORMAT(PurchLine."Document Type") + ' ' + PurchLine."Document No.");
             PurchLine."Item Category Code" := Item."Item Category Code";
             PurchLine.MODIFY;
           UNTIL PurchLine.NEXT=0;

         SalesLine.SETCURRENTKEY(Type,"No.");
         SalesLine.SETRANGE(Type,SalesLine.Type::Item);
         SalesLine.SETRANGE("No.",Item."No.");
         IF SalesLine.FIND('-') THEN
           REPEAT
             d.UPDATE(2,'Sales ' + FORMAT(PurchLine."Document Type") + ' ' + SalesLine."Document No.");
             SalesLine."Item Category Code" := Item."Item Category Code";
             SalesLine.MODIFY;
           UNTIL SalesLine.NEXT=0;

        UNTIL Item.NEXT=0;
        MESSAGE('Update complete.');
        d.CLOSE;
    end;
}

