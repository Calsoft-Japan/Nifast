permissionset 50271 "LEG0172"
{
    Assignable = true;
    Caption = '415 CREDIT MEMOS UP';
    Permissions =
        tabledata "BOM Component" = R,
        tabledata "Change Log Setup" = R,
        tabledata "Currency Exchange Rate" = R,
        tabledata "Cust./Item Drawing2" = R,
        tabledata "Default Dimension" = R,
        tabledata "Interaction Template Setup" = R,
        tabledata "Item Reference" = R,
        tabledata "Item Substitution" = R,
        tabledata "Item Tracking Code" = R,
        tabledata "Item Unit of Measure" = R,
        tabledata "Item Vendor" = R,
        tabledata "Location" = R,
        tabledata "Order Address" = R,
        tabledata "Payment Terms" = R,
        tabledata "Purch. Cr. Memo Hdr." = RIMD,
        tabledata "Purch. Cr. Memo Line" = RIMD,
        tabledata "Purchase Header" = RIM,
        tabledata "Purchase Line" = RIM,
        tabledata "Purchase Price" = R,
        tabledata "Purchasing" = R,
        tabledata "Responsibility Center" = R,
        tabledata "Salesperson/Purchaser" = R,
        tabledata "Stockkeeping Unit" = R,
        tabledata "Tax Area Line" = R,
        tabledata "Tracking Specification" = R,
        tabledata "Unit of Measure" = R,

        tabledata "Warehouse Activity Line" = R;
}
