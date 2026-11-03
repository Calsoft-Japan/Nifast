permissionset 50241 "LEG0142"
{
    Assignable = true;
    Caption = '215 INVOICES UPDATE';
    Permissions =
        tabledata "Item Charge Assignment (Sales)" = RIMD,
        tabledata "Sales Invoice Header" = RIMD,
        tabledata "Sales Invoice Line" = RIMD;
}
