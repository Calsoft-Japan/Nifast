codeunit 50098 "Printer Check"
{

    trigger OnRun()
    begin
        UpdatedPrinterName_gTxt := GetPrintName_gFnc('Bullzip PDF Printer (redirected 2)');
        MESSAGE(UpdatedPrinterName_gTxt);
    end;

    var
        UpdatedPrinterName_gTxt: Text;

    local procedure GetPrintName_gFnc(PrinterName_iTxt: Text): Text
    var
        Printer_lRec: Record 2000000039;
        RedirectedPos_lInt: Integer;
        SliptPrinterName_lTxt: Text;
    begin
        Printer_lRec.RESET();
        Printer_lRec.SETFILTER(Name, '%1', '@' + PrinterName_iTxt);
        IF Printer_lRec.FINDFIRST() THEN
            EXIT(Printer_lRec.Name);

        IF STRPOS(PrinterName_iTxt, '(redirected') = 0 THEN
            ERROR('Printer not found - %1', PrinterName_iTxt);

        RedirectedPos_lInt := STRPOS(PrinterName_iTxt, '(redirected');
        SliptPrinterName_lTxt := COPYSTR(PrinterName_iTxt, 1, RedirectedPos_lInt);

        Printer_lRec.RESET();
        Printer_lRec.SETFILTER(Name, '%1', '@*' + SliptPrinterName_lTxt + '*');
        IF Printer_lRec.FINDFIRST() THEN
            EXIT(Printer_lRec.Name);

        ERROR('Printer name was not found - %1', PrinterName_iTxt);

    end;
}

