codeunit 50163 CU7318Subscriber
{
    //Version List=NAVW17.00,NV4.35;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Bin Create", OnBeforeBinInsert, '', false, false)]
    local procedure OnBeforeBinInsert(var Bin: Record Bin; BinCreationWorksheetLine: Record "Bin Creation Worksheet Line")
    var
    //BinType: Record 7303;
    begin
        //TODO
        /*  // >> PFC
         CLEAR(BinType);
         if BinType.GET(BinCreationWorksheetLine."Bin Type Code") then
             Bin."License Plate Enabled" := BinType."License Plate Enabled";
         // << PFC

         // >> NV - 08/14/03 MV
         Bin."Bin Size Code" := BinCreationWorksheetLine."Bin Size Code";
         Bin."Pick Bin Ranking" := BinCreationWorksheetLine."Pick Bin Ranking";
         Bin."Staging Bin" := BinCreationWorksheetLine."Staging Bin";
         // << NV - 08/14/03 MV */
        //TODO
    end;

}