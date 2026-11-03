permissionset 50273 "LEG0174"
{
    Assignable = true;
    Caption = '418 POSTED READ';
    Permissions =
        tabledata "Purch. Cr. Memo Hdr." = R,
        tabledata "Purch. Cr. Memo Line" = R,
        tabledata "Purch. Inv. Header" = R,
        tabledata "Purch. Inv. Line" = R,
        tabledata "Return Shipment Header" = R,
        tabledata "Return Shipment Line" = R;
}
