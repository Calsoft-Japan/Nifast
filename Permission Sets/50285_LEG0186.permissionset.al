permissionset 50285 "LEG0186"
{
    Assignable = true;
    Caption = '505 STOCKKEEP UPDATE';
    Permissions =
        tabledata "Change Log Setup" = R,
        tabledata "Item Variant" = R,
        tabledata "Stockkeeping Unit" = RIMD,
        tabledata "Stockkeeping Unit Comment Line" = RIMD;
}
