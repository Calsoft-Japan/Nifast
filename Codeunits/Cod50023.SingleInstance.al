codeunit 50023 SingleInstance
{
    SingleInstance = true;

    var
        SalesLineCurrentFieldNo: Integer;

    procedure SetSalesLineCurrentFieldNo(CurrFieldNo: Integer)
    begin
        SalesLineCurrentFieldNo := CurrFieldNo;
    end;

    procedure GetSalesLineCurrentFieldNo(Var CurrFieldNo: Integer)
    begin
        CurrFieldNo := SalesLineCurrentFieldNo;
    end;
}