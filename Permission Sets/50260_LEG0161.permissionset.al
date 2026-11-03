permissionset 50260 "LEG0161"
{
    Assignable = true;
    Caption = '234 ORD STATUS READ';
    Permissions =
        tabledata "Customer" = R,
        tabledata "Sales Header" = R,
        tabledata "Sales Line" = R;
}
