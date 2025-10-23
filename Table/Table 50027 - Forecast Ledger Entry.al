table 50027 "Forecast Ledger Entry"
{
    DrillDownPageID = 50005;
    LookupPageID = 50005;
    fields
    {
        field(1; "Item No."; Code[20])
        {
            NotBlank = true;
            TableRelation = Item;
        }
        field(2; "Enter Date"; Date)
        {
            // cleaned
        }
        field(3; "Forecast Quantity"; Decimal)
        {
            BlankNumbers = BlankZero;
            BlankZero = false;
            NotBlank = true;
        }
        field(4; "Customer No."; Code[20])
        {
            NotBlank = true;
            TableRelation = Customer."No.";
        }
        field(5; Description; Text[50])
        {
            // cleaned
        }
        field(6; "Shipping Date"; Date)
        {
            BlankNumbers = DontBlank;
            NotBlank = true;
        }
        field(7; "Pieces Per Vehicle"; Integer)
        {
            // cleaned
        }
        field(8; SOP; Date)
        {
            // cleaned
        }
        field(9; EOP; Date)
        {
            // cleaned
        }
        field(10; Model; Code[10])
        {
            // cleaned
        }
        field(11; OEM; Code[10])
        {
            // cleaned
        }
        field(12; Remark; Text[30])
        {
            // cleaned
        }
        field(13; "Entry No."; Integer)
        {
            AutoFormatType = 1;
            AutoIncrement = true;
        }
        field(14; "Division Code"; Code[10])
        {
            // cleaned
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(15; "Nifast Forecast"; Boolean)
        {
            // cleaned
        }
        field(16; "Flow Item"; Code[20])
        {
            // cleaned
            CalcFormula = Lookup(Item."No." WHERE("No." = FIELD("Item No.")));
            FieldClass = FlowField;
        }
        field(17; "Flow Forecast on/off"; Boolean)
        {
            // cleaned
            CalcFormula = Lookup(Item."Forecast on/off" WHERE("No." = FIELD("Item No.")));
            FieldClass = FlowField;
        }
        field(18; "Flow MPD Item"; Boolean)
        {
            // cleaned
            CalcFormula = Lookup(Item."MPD Item" WHERE("No." = FIELD("Item No.")));
            FieldClass = FlowField;
        }
        field(19; "Flow MPD Forecast"; Boolean)
        {
            // cleaned
            CalcFormula = Lookup(Item."MPD Forecast On/Off" WHERE("No." = FIELD("Item No.")));
            FieldClass = FlowField;
        }
        field(20; "Cross Ref. No."; Code[30])
        {
            // cleaned
            CalcFormula = Lookup("Item Reference"."Reference No." WHERE("Item No." = FIELD("Item No."),
                                                                                     "Reference Type No." = FIELD("Customer No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Entry No.", "Item No.", "Customer No.", "Shipping Date", "Forecast Quantity", "Division Code")
        {
            SumIndexFields = "Forecast Quantity";
        }
        key(Key2; "Customer No.", "Division Code")
        {
        }
    }
}
