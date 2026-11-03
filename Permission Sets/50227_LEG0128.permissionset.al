permissionset 50227 "LEG0128"
{
    Assignable = true;
    Caption = '201 CUSTOMERS UPDATE';
    Permissions =
        tabledata "Change Log Setup" = R,
        tabledata "Comment Line" = RIMD,
        tabledata "Cust. Ledger Entry" = IMD,
        tabledata "Customer" = IMD,
        tabledata "Detailed Cust. Ledg. Entry" = IMD,
        tabledata "Price Contract" = RIMD,
        tabledata "Sales Line Discount" = RIMD,
        tabledata "Sales Price" = RIMD,
        tabledata "Ship-to Address" = IMD;
}
