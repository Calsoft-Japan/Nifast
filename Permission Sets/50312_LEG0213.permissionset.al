permissionset 50312 "LEG0213"
{
    Assignable = true;
    Caption = '707 SHIP REC UPDATE';
    Permissions =
        tabledata "LAX Fast Receive Line" = R,
        tabledata "G/L Entry" = R,
        tabledata "Gen. Journal Line" = R,
        tabledata "Gen. Journal Template" = R,
        tabledata "Item Journal Line" = R,
        tabledata "Item Journal Template" = R,
        tabledata "Item Register" = RIMD,
        tabledata "LAX Package" = R,
        tabledata "LAX Package Line" = R,
        tabledata "Purch. Inv. Header" = RIMD,
        tabledata "Purch. Inv. Line" = RIMD,
        tabledata "Purch. Rcpt. Header" = RIMD,
        tabledata "Purch. Rcpt. Line" = RIMD,
        tabledata "LAX Receive Comment Line" = R,
        tabledata "LAX Receive Control" = R,
        tabledata "LAX Receive Rule" = R,
        tabledata "LAX Receive Setup" = R,
        tabledata "LAX Receive Standard Opt Setup" = R,
        tabledata "LAX Receive Station" = R,
        tabledata "Reservation Entry" = IMD;
}
