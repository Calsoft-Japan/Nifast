tableextension 70102 LAXEDIReceiveDocumentHdr_NF extends "LAX EDI Receive Document Hdr."
{
    fields
    {
        field(70000; "Document Created"; Option)
        {
            Description = 'EE';
            Editable = false;
            OptionMembers = " ","Planning Schedule","Vendor Availability","Sales Invoice","Sales Credit Memo","Cash Recp. Jrn.","General Message","Ship Auth.","Delivery Schedule";
        }
        field(70001; "Created Date"; Date)
        {
            Description = 'EE';
            Editable = false;
        }
        field(70002; "Created Time"; Time)
        {
            Description = 'EE';
            Editable = false;
        }
    }
}
