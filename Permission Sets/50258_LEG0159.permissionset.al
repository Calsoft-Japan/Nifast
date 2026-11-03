permissionset 50258 "LEG0159"
{
    Assignable = true;
    Caption = '232 POSTED DOCS READ';
    Permissions =
        tabledata "Sales Invoice Header" = R,
        tabledata "Sales Invoice Line" = R,
        tabledata "Sales Shipment Header" = R,
        tabledata "Sales Shipment Line" = R;
}
