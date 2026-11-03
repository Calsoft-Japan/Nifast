permissionset 50294 "LEG0195"
{
    Assignable = true;
    Caption = '521 RECUR JNL UPDATE';
    Permissions =
        tabledata "Change Log Setup" = R,
        tabledata "Default Dimension" = R,
        tabledata "Item Application Entry" = R,
        tabledata "Item Journal Line" = RIMD,
        tabledata "Item Variant" = R,
        tabledata "Purchase Price" = R,
        tabledata "Tracking Specification" = R;
}
