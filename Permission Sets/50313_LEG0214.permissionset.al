permissionset 50313 "LEG0214"
{
    Assignable = true;
    Caption = '800 CANADA EDI READ';
    Permissions =
        tabledata "Customer" = R,
        tabledata "Delivery Schedule Batch" = RIMD,
        tabledata "Delivery Schedule Header" = RIMD,
        tabledata "Delivery Schedule Line" = RIMD,
        tabledata "LAX EDI Conditional" = RIMD,
        tabledata "LAX EDI Cust. Cross Reference" = RIMD,
        tabledata "LAX EDI Document" = RIMD,
        tabledata "LAX EDI Element" = RIMD,
        tabledata "LAX EDI Fields" = RIMD,
        tabledata "LAX EDI Receive Document Field" = RIMD,
        tabledata "LAX EDI Receive Document Hdr." = RIMD,
        tabledata "LAX EDI Segment" = RIMD,
        tabledata "LAX EDI Send Document Field" = RIMD,
        tabledata "LAX EDI Send Document Hdr." = RIMD,
        tabledata "LAX EDI Setup" = RIMD,
        tabledata "LAX EDI Template" = RIMD,
        tabledata "LAX EDI Total Fields" = RIMD,
        tabledata "LAX EDI Trade Partner" = RIMD,
        tabledata "LAX EDI Trade Partner Item" = RIMD,
        tabledata "LAX EDI Trade Partner UOM" = RIMD,
        tabledata "LAX EDI Vend. Cross Reference" = RIMD,
        tabledata "Vendor" = R;
}
