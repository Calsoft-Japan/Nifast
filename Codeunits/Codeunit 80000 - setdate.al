codeunit 80000 setdate
{

    trigger OnRun()
    begin
        /*
        VenRec.INIT;
        VenRec.MODIFYALL("Check Date Format",1);
        VenRec.MODIFYALL("Check Date Separator",3);
        */
        Itemrec.INIT;
        Itemrec.MODIFYALL(National,TRUE);
        EXIT;

    end;

    var
        VenRec: Record "23";
        Itemrec: Record "27";
}

