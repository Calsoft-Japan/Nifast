permissionset 50301 "LEG0202"
{
    Assignable = true;
    Caption = '601 RESOURCES UPDATE';
    Permissions =
        tabledata "Change Log Setup" = R,
        tabledata "Comment Line" = RIM,
        tabledata "Default Dimension" = RIM,
        tabledata "Purchasing" = R,
        tabledata "Res. Ledger Entry" = RIMD,
        tabledata "Resource" = RIMD,
        tabledata "Resource Register" = RIMD,
        tabledata "Resource Unit of Measure" = RIMD,
        tabledata "Unit of Measure" = R;
}
