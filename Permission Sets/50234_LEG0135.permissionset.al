permissionset 50234 "LEG0135"
{
    Assignable = true;
    Caption = '208 ORDERS READ ONLY';
    Permissions =
        tabledata "LAX Bill of Lading" = R,
        tabledata "BOM Component" = R,
        tabledata "Detailed Vendor Ledg. Entry" = R,
        tabledata "LAX EShip Agent Service" = R,
        tabledata "LAX Fast Pack Line" = R,
        tabledata "Item Charge Assignment (Purch)" = R,
        tabledata "Lot Entry" = R,
        tabledata "Order Address" = R,
        tabledata "LAX Package" = R,
        tabledata "LAX Package Line" = R,
        tabledata "Purch. Comment Line" = R,
        tabledata "Purch. Inv. Header" = R,
        tabledata "Purchase Header" = R,
        tabledata "Sales Header Archive" = R,
        tabledata "Sales Planning Line" = R,
        tabledata "Sales Tax Amount Difference" = R,
        tabledata "Sales Tax Amount Line" = R,
        tabledata "Standard Sales Line" = R,
        tabledata "Standard Vendor Purchase Code" = R,
        tabledata "Vendor Bank Account" = R,
        tabledata "Vendor Invoice Disc." = R,
        tabledata "Vendor Ledger Entry" = R,

        tabledata "Warehouse Activity Header" = R,
        tabledata "Warehouse Request" = R,
        tabledata "Warehouse Shipment Line" = R;
}
