tableextension 55802 "Value Entry Ext" extends "Value Entry"
{
    fields
    {
        field(50001;"ASN #";Code[20])
        {
            NotBlank = true;
        }
        field(50002;"NV Order No.";Code[20])
        {
            // cleaned
        }
    }
}
