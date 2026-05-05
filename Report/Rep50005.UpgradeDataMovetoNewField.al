
report 50005 "Upgrade Data Move to Legacy"
{
    ApplicationArea = All;
    Caption = 'Upgrade Data Move to Legacy Field';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    Permissions = TableData "Purch. Rcpt. Line" = RM, TableData "Sales Shipment Line" = RM;

    dataset
    {
        dataitem(Integer; "Integer")
        {
            MaxIteration = 1;
            trigger OnAfterGetRecord()
            begin
                PurchRcptLine.Reset();
                PurchRcptLine.SetFilter("Vendor Shipment No_Legacy", '<>%1', '');
                if PurchRcptLine.FindSet() then
                    repeat
                        PurchRcptLine."Vendor Shipment No." := PurchRcptLine."Vendor Shipment No_Legacy";
                        PurchRcptLine.Modify();
                    until PurchRcptLine.Next() = 0;
                SalesshipLine.Reset();
                SalesshipLine.SetFilter("External Document No_Legacy", '<>%1', '');
                if SalesshipLine.FindSet() then
                    repeat
                        SalesshipLine."External Document No." := SalesshipLine."External Document No_Legacy";
                        SalesshipLine.Modify();
                    until SalesshipLine.Next() = 0;
            end;
        }
    }
    var
        PurchRcptLine: Record "Purch. Rcpt. Line";
        SalesshipLine: Record "Sales Shipment Line";
}
