tableextension 70002 LAXEDIReceiveDocumentHdr_NF extends "LAX EDI Receive Document Hdr."
{
    fields
    {
        field(14017880; "Document Created"; Option)
        {
            Description = 'EE';
            Editable = false;
            OptionMembers = " ","Planning Schedule","Vendor Availability","Sales Invoice","Sales Credit Memo","Cash Recp. Jrn.","General Message","Ship Auth.","Delivery Schedule";
        }
        field(14017881; "Created Date"; Date)
        {
            Description = 'EE';
            Editable = false;
        }
        field(14017882; "Created Time"; Time)
        {
            Description = 'EE';
            Editable = false;
        }
    }
}
