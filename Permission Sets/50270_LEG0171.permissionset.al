permissionset 50270 "LEG0171"
{
    Assignable = true;
    Caption = '413 RETURN ORD UPDAT';
    Permissions =
        tabledata "Change Log Setup" = R,
        tabledata "Currency Exchange Rate" = R,
        tabledata "Default Dimension" = R,
        tabledata "Item Application Entry" = RIMD,
        tabledata "Item Application Entry History" = RIMD,
        tabledata "Location" = R,
        tabledata "Payment Method" = R,
        tabledata "Payment Terms" = R,
        tabledata "Purch. Comment Line" = RIMD,
        tabledata "Purch. Rcpt. Header" = RI,
        tabledata "Purch. Rcpt. Line" = RI,
        tabledata "Purchase Header" = RIMD,
        tabledata "Purchase Line" = RIMD,
        tabledata "Resource" = R,
        tabledata "Responsibility Center" = R,
        tabledata "Return Reason" = R,
        tabledata "Return Shipment Header" = RIM,
        tabledata "Return Shipment Line" = RIM,
        tabledata "Salesperson/Purchaser" = R,
        tabledata "Tax Area Line" = R,
        tabledata "Tracking Specification" = R,
        tabledata "Unit of Measure" = R,

        tabledata "Warehouse Activity Header" = R,
        tabledata "Warehouse Activity Line" = R,
        tabledata "Warehouse Request" = RIMD;
}
