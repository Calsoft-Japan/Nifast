permissionset 50306 "LEG0207"
{
    Assignable = true;
    Caption = '700 SHIP $ REC READ';
    Permissions =
        tabledata "LAX Bill of Lading" = R,
        tabledata "LAX Bill of Lading Line" = R,
        tabledata "LAX Bill of Lading Type" = R,
        tabledata "Bin Content" = R,
        tabledata "Item" = R,
        tabledata "Location" = R,
        tabledata "LAX Package" = R,
        tabledata "LAX Package Line" = R,
        tabledata "LAX Packing Station" = R,
        tabledata "LAX Posted Package" = R,
        tabledata "LAX Posted Package Line" = R,
        tabledata "Purch. Comment Line" = R,
        tabledata "Purch. Rcpt. Header" = R,
        tabledata "Purch. Rcpt. Line" = R,
        tabledata "Purchase Header" = R,
        tabledata "Purchase Line" = R,
        tabledata "Reservation Entry" = R,
        tabledata "Sales Comment Line" = R,
        tabledata "Sales Header" = R,
        tabledata "Sales Line" = R,
        tabledata "Sales Shipment Header" = R,
        tabledata "Sales Shipment Line" = R,
        tabledata "LAX Shipping Comment Line" = R,
        tabledata "LAX Shipping Setup" = R,
        tabledata "Warehouse Activity Header" = R,
        tabledata "Warehouse Activity Line" = R,
        tabledata "Warehouse Employee" = R,
        tabledata "Warehouse Entry" = R,
        tabledata "Whse. Worksheet Line" = R;
}
