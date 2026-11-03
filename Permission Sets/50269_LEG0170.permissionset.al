permissionset 50269 "LEG0170"
{
    Assignable = true;
    Caption = '411 PUR INVOICE UD';
    Permissions =
        tabledata "BOM Component" = R,
        tabledata "Change Log Setup" = R,
        tabledata "Currency Exchange Rate" = R,
        tabledata "Cust./Item Drawing2" = R,
        tabledata "Default Dimension" = R,
        tabledata "Interaction Template Setup" = R,
        tabledata "Item Charge Assignment (Purch)" = RIMD,
        tabledata "Item Reference" = R,
        tabledata "Item Substitution" = R,
        tabledata "Item Tracking Code" = R,
        tabledata "Item Unit of Measure" = R,
        tabledata "Item Vendor" = R,
        tabledata "Location" = R,
        tabledata "Payment Method" = R,
        tabledata "Payment Terms" = R,
        tabledata "Purch. Inv. Header" = RIMD,
        tabledata "Purch. Inv. Line" = RIMD,
        tabledata "Purch. Rcpt. Header" = RIMD,
        tabledata "Purch. Rcpt. Line" = RIMD,
        tabledata "Purchase Header" = IMD,
        tabledata "Purchase Line" = IMD,
        tabledata "Purchase Price" = R,
        tabledata "Responsibility Center" = R,
        tabledata "Salesperson/Purchaser" = R,
        tabledata "Stockkeeping Unit" = R,
        tabledata "Tax Group" = R,
        tabledata "Tracking Specification" = R,
        tabledata "Unit of Measure" = R,
        tabledata "Vendor Invoice Disc." = RIMD,
        tabledata "Vendor Ledger Entry" = RIMD,

        tabledata "Warehouse Activity Line" = R;
}
