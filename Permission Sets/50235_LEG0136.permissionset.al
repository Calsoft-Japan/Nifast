permissionset 50235 "LEG0136"
{
    Assignable = true;
    Caption = '209 ORDERS UPDATE';
    Permissions =
        tabledata "Bin Content" = R,
        tabledata "Currency Exchange Rate" = R,
        tabledata "Cust. Ledger Entry" = RI,
        tabledata "Cust./Item Drawing2" = R,
        tabledata "Custom Report Selection" = R,
        tabledata "Default Dimension" = R,
        tabledata "Default Dimension Priority" = R,
        tabledata "Detailed Cust. Ledg. Entry" = RI,
        tabledata "LAX EDI Setup" = R,
        tabledata "Item Substitution" = R,
        tabledata "Item Unit of Measure" = R,
        tabledata "Lot Entry" = RIMD,
        tabledata "Payment Method" = R,
        tabledata "Payment Terms" = R,
        tabledata "Resource Unit of Measure" = R,
        tabledata "Return Reason" = R,
        tabledata "Return Receipt Header" = RIM,
        tabledata "Return Receipt Line" = RIM,
        tabledata "Return Shipment Header" = R,
        tabledata "Return Shipment Line" = R,
        tabledata "Returns-Related Document" = R,
        tabledata "Sales Cr.Memo Header" = RIM,
        tabledata "Sales Cr.Memo Line" = RIM,
        tabledata "Sales Header" = RIMD,
        tabledata "Sales Line" = RIMD,
        tabledata "Shipping Agent Services" = R,
        tabledata "Stockkeeping Unit" = R,
        tabledata "Sales Tax Amount Line" = R,
        tabledata "Tracking Specification" = R,
        tabledata "Unit of Measure" = R;
}
