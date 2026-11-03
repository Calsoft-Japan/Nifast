permissionset 50320 "LEG0221"
{
    Assignable = true;
    Caption = '906 AD PURCH D READ';
    Permissions =
        tabledata "Currency" = R,
        tabledata "Item" = R,
        tabledata "Item Ledger Entry" = R,
        tabledata "Purchase Header" = R,
        tabledata "Purchase Line" = R,
        tabledata "Req. Wksh. Template" = R,
        tabledata "Requisition Line" = R,
        tabledata "Requisition Wksh. Name" = R,
        tabledata "Sales Header" = R,
        tabledata "Sales Line" = R,
        tabledata "Transfer Header" = R,
        tabledata "Transfer Line" = R,
        tabledata "Value Entry" = R,
        tabledata "Vendor" = R;
}
