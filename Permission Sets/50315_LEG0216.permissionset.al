permissionset 50315 "LEG0216"
{
    Assignable = true;
    Caption = '901 AD SALES UPDATE';
    Permissions =
        tabledata "BOM Component" = R,
        tabledata "Change Log Setup" = R,
        tabledata "Currency" = R,
        tabledata "Item Substitution" = R,


        tabledata "Purchase Line" = R,
        tabledata "Purchasing" = R,
        tabledata "Requisition Line" = R,
        tabledata "Sales Header" = IM,
        tabledata "Sales Line" = IM,
        tabledata "Transfer Line" = R;
}
