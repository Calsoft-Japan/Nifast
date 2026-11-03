permissionset 50223 "LEG0124"
{
    Assignable = true;
    Caption = '120 G/L REGIST. READ';
    Permissions =
        tabledata "Bank Account Ledger Entry" = R,
        tabledata "Cust. Ledger Entry" = R,
        tabledata "Detailed Cust. Ledg. Entry" = R,
        tabledata "G/L Account" = R,
        tabledata "G/L Entry" = R,
        tabledata "G/L Register" = R,
        tabledata "Reminder/Fin. Charge Entry" = R;
}
