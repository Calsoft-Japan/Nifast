permissionset 50274 "LEG0175"
{
    Assignable = true;
    Caption = '420 REGISTER READ';
    Permissions =
        tabledata "Bank Account Ledger Entry" = R,
        tabledata "Cust. Ledger Entry" = R,
        tabledata "Detailed Cust. Ledg. Entry" = R,
        tabledata "G/L Account" = R,
        tabledata "G/L Entry" = R,
        tabledata "G/L Register" = R,
        tabledata "Reminder/Fin. Charge Entry" = R;
}
