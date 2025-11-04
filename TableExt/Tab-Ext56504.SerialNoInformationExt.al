tableextension 56504 "Serial No. Information Ext" extends "Serial No. Information"
{
    fields
    {
        field(70000; "QC Hold"; Boolean)
        {
        }
        field(70001; "QC Hold Reason Code"; code[10])
        {
        }
    }
}