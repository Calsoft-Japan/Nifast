codeunit 50264 CU_7319
{
    [EventSubscriber(ObjectType::Codeunit, 7319, 'OnBinCreateOnBeforeInsertBinContent', '', True, false)]
    local procedure OnBinCreateOnBeforeInsertBinContent(var BinContent: Record "Bin Content"; BinCreateLine2: Record "Bin Creation Worksheet Line")
    begin
        //>>PFC
        BinContent."Pick Bin Ranking" := BinCreateLine2."Pick Bin Ranking";
        BinContent."Staging Bin" := BinCreateLine2."Staging Bin";
        //<<PFC

    end;
}
