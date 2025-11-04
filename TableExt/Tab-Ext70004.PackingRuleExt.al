Tableextension 70104 "Packing Rule Ext" extends "Lax Packing Rule"
{
    fields
    {
        field(50000; "Automatic Print Label"; Boolean)
        {
            trigger OnValidate()
            begin
                IF "Automatic Print Label" THEN
                    TESTFIELD("Package Line Label Code");
            end;
        }
        field(50010; "Package Line Label Code"; Code[10])
        {
            TableRelation = "Label Header" WHERE("Label Usage" = CONST("Package Line"));
        }
        field(50020; "No. of Labels"; Option)
        {
            OptionMembers = Quantity,"Quantity (Base)","One per Scan";
        }
        field(50030; "Std. Package Label Code 2"; Code[10])
        {
            TableRelation = "Label Header" WHERE("Label Usage" = CONST(Package));
        }
    }
}