tableextension 55802 "Value Entry Ext" extends "Value Entry"
{
    fields
    {
        field(50001; "ASN #"; Code[20])
        {
            NotBlank = true;
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Shipment Header"."EDI Control No." WHERE("Order No." = FIELD("Order No.")));
        }
        field(50002; "NV Order No."; Code[20])
        {
            // cleaned
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Invoice Header"."Order No." WHERE("No." = FIELD("Document No.")));
        }
    }
}
