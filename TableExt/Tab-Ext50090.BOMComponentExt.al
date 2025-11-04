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
        field(70000; "No;Line Comment"; Boolean)
        {
            FieldClass = FlowField;
            Description = 'NF1.00:CIS.NG 10-10-15';
            Editable = false;
        }
        field(70001; "Vendor No."; Code[20])
        {
            TableRelation = Vendor;
        }
        field(70002; "Vendor Item No."; Text[20])
        {
        }
        field(70003; "Purchasing Code"; Code[10])
        {
            TableRelation = Purchasing;
        }
        field(70004; "Unit Cost "; Decimal)
        {
            DecimalPlaces = 2 : 5;
        }
    }
    keys
    {
        key(Key50000; "Parent Item No.", Type, "No.")
        {
        }
    }
}
