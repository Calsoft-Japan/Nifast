reportextension 50000 "Receive Line Label Ext" extends "LAX Receive Line Label"
{
    dataset
    {
    }

    requestpage
    {
    }
    var
        QtyToPrint: Decimal;

    procedure InitializeRequest2(NewQtyToPrint: Integer)
    begin
        QtyToPrint := NewQtyToPrint;
    end;
}