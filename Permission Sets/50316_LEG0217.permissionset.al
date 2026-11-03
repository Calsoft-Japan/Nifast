permissionset 50316 "LEG0217"
{
    Assignable = true;
    Caption = '902 AD QC READ';
    Permissions =
        tabledata "BOM Component" = R,
        tabledata "Customer" = R,
        tabledata "Item" = R,
        tabledata "Sales Header" = R,
        tabledata "Sales Line" = R,
        tabledata "Vendor" = R;
}
