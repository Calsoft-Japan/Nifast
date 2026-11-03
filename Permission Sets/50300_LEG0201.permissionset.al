permissionset 50300 "LEG0201"
{
    Assignable = true;
    Caption = '600 RESOURCES READ';
    Permissions =
        tabledata "Comment Line" = R,
        tabledata "Default Dimension" = R,
        tabledata "G/L Account" = R,
        tabledata "Res. Ledger Entry" = R,
        tabledata "Resource" = R,
        tabledata "Resource Group" = R,
        tabledata "Resource Register" = R;
}
