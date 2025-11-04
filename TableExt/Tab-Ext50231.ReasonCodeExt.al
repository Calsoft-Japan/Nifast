tableextension 50231 "Reason Code Ext" extends "Reason Code"
{
    fields
    {
        field(70000; Type; Option)
        {
            OptionMembers = ,"Lost Sale",QC,"QC Incident";
        }
    }
}