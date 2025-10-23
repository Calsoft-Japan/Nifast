tableextension 50005 "Source Code Setup Ext" extends "Source Code Setup"
{
    fields
    {
        field(14017999; "License Plate Journal"; Code[10])
        {
            TableRelation = "Source Code";
        }

    }
}
