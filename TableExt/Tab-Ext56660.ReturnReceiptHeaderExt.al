tableextension 56660 "Return Receipt Header Ext" extends "Return Receipt Header"
{
    fields
    {
        field(70000; "No;Cr. Mgmt. Comment"; Boolean)
        {
            FieldClass = FlowField;
            Description = 'NF1.00:CIS.CM 09-29-15';
            Editable = false;
        }
    }
}
