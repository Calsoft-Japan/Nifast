tableextension 50045 "G/L Register Ext" extends "G/L Register"
{
    // version NAVW17.00,NIF
    fields
    {
        field(50001; "To Transaction No."; Integer)
        {
            // cleaned
            FieldClass = FlowField;
            CalcFormula = Lookup("G/L Entry"."Transaction No." WHERE("Entry No."=FIELD("To Entry No.")));
        }
        field(50002; "From Transaction No"; Integer)
        {
            // cleaned
            FieldClass = FlowField;
            CalcFormula = Lookup("G/L Entry"."Transaction No." WHERE("Entry No."=FIELD("From Entry No.")));
        }
    }
}
