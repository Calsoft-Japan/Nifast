permissionset 50311 "LEG0212"
{
    Assignable = true;
    Caption = '706 POSTED DOC READ';
    Permissions =
        tabledata "LAX Bill of Lading" = R,
        tabledata "LAX Bill of Lading Line" = R,
        tabledata "LAX Packing Station" = R,
        tabledata "LAX Posted Package" = R,
        tabledata "LAX Posted Package Line" = R,
        tabledata "Sales Comment Line" = R,
        tabledata "Sales Header" = R,
        tabledata "Sales Shipment Header" = R,
        tabledata "Sales Shipment Line" = R,
        tabledata "LAX Shipping Comment Line" = R,
        tabledata "LAX Shipping Setup" = R;
}
