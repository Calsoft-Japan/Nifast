tableextension 50317 "Payable Vendor Ledger Entry Ex" extends "Payable Vendor Ledger Entry"
{
    fields
    {
        field(50000; "Contract Note No."; Code[20])
        {
            // cleaned
            TableRelation = "4X Contract"."No.";
        }
        field(50001; "Exchange Contract No."; Code[20])
        {
            // cleaned
        }
        field(50002; "USD Value"; Decimal)
        {
            Description = 'Forex';
        }
    }
}
