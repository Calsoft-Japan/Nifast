permissionset 50254 "LEG0155"
{
    Assignable = true;
    Caption = '228 SALES JNL READ';
    Permissions =
        tabledata "Gen. Jnl. Allocation" = R,
        tabledata "Gen. Journal Batch" = R,
        tabledata "Gen. Journal Line" = R,
        tabledata "Gen. Journal Template" = R;
}
