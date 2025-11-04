codeunit 50172 CU_903
{
    [EventSubscriber(ObjectType::Codeunit, 903, 'OnBeforeReleaseAssemblyDoc', '', True, false)]
    local procedure OnBeforeReleaseAssemblyDoc(var AssemblyHeader: Record "Assembly Header")
    begin
        AssemblyHeader.TESTFIELD("Location Code");  //NF1.00:CIS.NG 10-22-15
    end;

}
