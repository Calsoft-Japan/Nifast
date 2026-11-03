permissionset 50217 "LEG0118"
{
    Assignable = true;
    Caption = '111 GEN JNL UPDATE';
    Permissions =
        table "Gen. Journal Template" = X,
        tabledata "Change Log Setup" = R,
        tabledata "Cust. Ledger Entry" = RIM,
        tabledata "Default Dimension" = R,
        tabledata "Gen. Jnl. Allocation" = R,
        tabledata "Gen. Journal Line" = RIMD,
        tabledata "Gen. Journal Template" = R;
}
