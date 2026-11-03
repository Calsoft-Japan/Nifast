permissionset 50209 "LEG0110"
{
    Assignable = true;
    Caption = '100 G/L READ';
    Permissions =
        tabledata "4X Bank Exchange Contract" = R,
        tabledata "4X Purchase Header" = R,
        tabledata "Acc. Schedule Line" = R,
        tabledata "Acc. Schedule Name" = R,
        tabledata "Bank Account" = R,
        tabledata "Bank Account Ledger Entry" = R,
        tabledata "Column Layout" = R,
        tabledata "Column Layout Name" = R,
        tabledata "Comment Line" = R,
        tabledata "Currency" = R,
        tabledata "Customer" = R,
        tabledata "Dimension Code Buffer" = R,
        tabledata "G/L Account" = R,
        tabledata "G/L Budget Entry" = R,
        tabledata "G/L Budget Name" = R,
        tabledata "G/L Entry" = R,
        tabledata "Vendor" = R;
}
