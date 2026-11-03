permissionset 50233 "LEG0134"
{
    Assignable = true;
    Caption = '207 BLNKT ORD UPDATE';
    Permissions =
        tabledata "Bin Content" = R,
        tabledata "Cust./Item Drawing2" = R,
        tabledata "Default Dimension Priority" = R,
        tabledata "Item Substitution" = R,
        tabledata "Item Unit of Measure" = R,
        tabledata "Sales Line" = IM,
        tabledata "Stockkeeping Unit" = R,
        tabledata "Unit of Measure" = R;
}
