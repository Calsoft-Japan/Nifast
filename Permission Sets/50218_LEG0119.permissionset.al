permissionset 50218 "LEG0119"
{
    Assignable = true;
    Caption = '113 DEPOSIT UD';
    Permissions =
        tabledata "Bank Acc. Reconciliation" = R,
        tabledata "Bank Acc. Reconciliation Line" = R,
        tabledata "Bank Account Ledger Entry" = RIMD,
        tabledata "Bank Account Posting Group" = R,
        tabledata "Bank Account Statement" = R,
        tabledata "Bank Account Statement Line" = R,
        tabledata "Bank Comment Line" = R,
        tabledata "Currency Exchange Rate" = R,
        tabledata "Posted Deposit Header" = RIMD,
        tabledata "Posted Deposit Line" = RIMD;
}
