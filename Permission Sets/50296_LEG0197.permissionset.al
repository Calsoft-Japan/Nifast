permissionset 50296 "LEG0197"
{
    Assignable = true;
    Caption = '525 INV SETUP UPDATE';
    Permissions =
        tabledata "Change Log Setup" = R,
        tabledata "Inventory Posting Group" = RIM,
        tabledata "Inventory Posting Setup" = RIM,
        tabledata "Inventory Setup" = RIM,
        tabledata "Item Category" = RIM,
        tabledata "Item Tracking Code" = RIM,
        tabledata "Location" = RIM,
        tabledata "Manufacturer" = RIM,
        tabledata "Nonstock Item Setup" = RIM,
        tabledata "Order Promising Setup" = RIM,
        tabledata "Report Selections" = RIM,
        tabledata "Rounding Method" = RIM,
        tabledata "Sales Line Discount" = R,
        tabledata "Transfer Route" = RIM,
        tabledata "Unit of Measure" = RIMD;
}
