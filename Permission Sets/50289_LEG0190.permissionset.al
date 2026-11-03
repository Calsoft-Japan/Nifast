permissionset 50289 "LEG0190"
{
    Assignable = true;
    Caption = '513 TRANSF ORD UD';
    Permissions =
        tabledata "Change Log Setup" = R,
        tabledata "Default Dimension" = R,
        tabledata "Gen. Product Posting Group" = R,
        tabledata "Inventory Posting Group" = R,
        tabledata "Item Tracking Code" = R,
        tabledata "Reason Code" = R,
        tabledata "Report Selections" = R,
        tabledata "Shipment Method" = R,
        tabledata "Transfer Header" = RIM,
        tabledata "Transfer Line" = RIM,
        tabledata "Transfer Route" = R,
        tabledata "Unit of Measure" = R,
        tabledata "Warehouse Request" = RIM;
}
