permissionset 50308 "LEG0209"
{
    Assignable = true;
    Caption = '702 PACK LINE SCAN';
    Permissions =
        tabledata "LAX Package" = R,
        tabledata "LAX Package Line" = R,
        tabledata "LAX Packing Control" = R,
        tabledata "LAX Packing Station" = R,
        tabledata "Sales Header" = R,
        tabledata "LAX Shipping Setup" = R;
}
