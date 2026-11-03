permissionset 50252 "LEG0153"
{
    Assignable = true;
    Caption = '226 SETUP READ';
    Permissions =
        tabledata "Customer Price Group" = R,
        tabledata "Finance Charge Terms" = R,
        tabledata "Item Charge" = R,
        tabledata "Payment Method" = R,
        tabledata "Reminder Terms" = R,
        tabledata "Return Reason" = R,
        tabledata "Shipment Method" = R;
}
