permissionset 50211 "LEG0112"
{
    Assignable = true;
    Caption = '101-2 GL UPDATE';
    Permissions =
        tabledata "Detailed Cust. Ledg. Entry" = RIMD,
        tabledata "Detailed Vendor Ledg. Entry" = RIMD,
        tabledata "G/L Entry" = IMD,
        tabledata "G/L Register" = IMD,
        tabledata "Item Register" = RIMD,
        tabledata "Value Entry" = RIMD;
}
