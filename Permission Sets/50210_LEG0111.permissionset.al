permissionset 50210 "LEG0111"
{
    Assignable = true;
    Caption = '101 G/L CHA O ACC UD';
    Permissions =
        tabledata "Change Log Setup" = R,
        tabledata "Comment Line" = RIM,
        tabledata "Default Dimension" = R,
        tabledata "Detailed Cust. Ledg. Entry" = R,
        tabledata "Extended Text Line" = R,
        tabledata "G/L Account" = RM;
}
