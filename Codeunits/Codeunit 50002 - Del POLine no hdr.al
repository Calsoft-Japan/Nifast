codeunit 50002 "Del POLine no hdr"
{

    trigger OnRun()
    begin
         POline.SETFILTER(POline."Document No.",'');
         IF POline.FINDSET THEN
           POline.DELETEALL
         ELSE
         MESSAGE('No Line Found');
    end;

    var
        POline: Record 39;
}

