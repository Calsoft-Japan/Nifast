permissionset 50321 "LEG0222"
{
    Assignable = true;
    Caption = '907 AD PURCH D UD';
    Permissions =
        tabledata "BOM Component" = R,
        tabledata "Change Log Setup" = R,
        tabledata "Default Dimension" = R,
        tabledata "Item Substitution" = R,
        tabledata "Item Tracking Code" = R,
        tabledata "Item Unit of Measure" = R,
        tabledata "Item Vendor" = R,


        tabledata "Purchase Price" = R,
        tabledata "Requisition Line" = IM,
        tabledata "Reservation Entry" = R,
        tabledata "Stockkeeping Unit" = R;
}
