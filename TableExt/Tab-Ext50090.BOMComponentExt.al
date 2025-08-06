tableextension 50090 "BOM Component Ext" extends "BOM Component"
{
    fields
    {
        field(50001; "Div Code"; Code[20])
        {
            CalcFormula = lookup(Item."Global Dimension 1 Code" where("No." = field("Parent Item No.")));
            FieldClass = FlowField;
            Editable = false;
        }
    }
    keys
    {
        key(Key50000; "Parent Item No.", Type, "No.")
        {
        }
    }
}
