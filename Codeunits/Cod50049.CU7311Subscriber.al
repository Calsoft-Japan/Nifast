codeunit 50049 CU7311Subscriber
{
    // Version NAVW18.00,NV4.33;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse. Worksheet-Create", OnAfterFromWhseRcptLineCreateWhseWkshLine, '', false, false)]
    local procedure OnAfterFromWhseRcptLineCreateWhseWkshLine(var WhseWorksheetLine: Record "Whse. Worksheet Line"; PostedWhseReceiptLine: Record "Posted Whse. Receipt Line")
    begin
        //TODO
        // >> JDC
        WhseWorksheetLine."License Plate No." := PostedWhseReceiptLine."License Plate No.";
        // <<
        //>> NV4.33
        WhseWorksheetLine."QC Hold" := PostedWhseReceiptLine."QC Hold";
        //<< NV4.33 
        //TODO
    end;
}