permissionset 50268 "LEG0169"
{
    Assignable = true;
    Caption = '409 ORD REC UPDATE';
    Permissions =
        tabledata "Bin" = R,
        tabledata "Change Log Setup" = R,
        tabledata "Currency Exchange Rate" = R,
        tabledata "Item Tracking Code" = R,
        tabledata "Location" = R,
        tabledata "Purchase Line" = RM;
}
