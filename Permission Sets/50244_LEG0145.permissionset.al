permissionset 50244 "LEG0145"
{
    Assignable = true;
    Caption = '218 CREDIT MEMO READ';
    Permissions =
        tabledata "Sales Cr.Memo Header" = R,
        tabledata "Sales Cr.Memo Line" = R;
}
