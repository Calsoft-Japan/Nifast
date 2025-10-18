table 50029 "Vehicle Production"
{
    //  SM.001 - 09/21/16 - ADDED PPAP Approved
    fields
    {
        field(1; "Customer No."; Code[20])
        {
            // cleaned
            TableRelation = Customer."No.";
        }
        field(2; "Item No."; Code[20])
        {
            // cleaned
            TableRelation = Item."No.";
        }
        field(3; Model; Code[50])
        {
            // cleaned
        }
        field(4; "EC Level"; Code[30])
        {
            // cleaned
        }
        field(5; "Applicable Std"; Text[50])
        {
            // cleaned
        }
        field(6; EMU; Decimal)
        {
            // cleaned
        }
        field(7; OEM; Code[20])
        {
            // cleaned
        }
        field(8; "Final Customer"; Text[30])
        {
            // cleaned
        }
        field(9; "Pieces Per Vehicle"; Decimal)
        {
            // cleaned
        }
        field(10; Per; Text[30])
        {
            // cleaned
        }
        field(11; SOP; Date)
        {
            // cleaned
        }
        field(12; EOP; Date)
        {
            // cleaned
        }
        field(13; Remarks; Text[250])
        {
            // cleaned
        }
        field(14; SNP; Decimal)
        {
            // cleaned
            CalcFormula = Lookup(Item."Units per Parcel" WHERE("No." = FIELD("Item No.")));
            FieldClass = FlowField;
        }
        field(15; Manufacturer; Code[50])
        {
            // cleaned
            CalcFormula = Lookup(Item."Manufacturer Code" WHERE("No." = FIELD("Item No.")));
            FieldClass = FlowField;
        }
        field(16; "Customer Name"; Text[100])
        {
            // cleaned
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Customer No.")));
            FieldClass = FlowField;
        }
        field(17; "Cross Reference No."; Code[30])
        {
            // cleaned
            CalcFormula = Lookup("Item Reference"."Reference No." WHERE("Item No." = FIELD("Item No."),
                                                                                     "Reference Type No." = FIELD("Customer No."),
                                                                                     "Reference Type" = CONST(Customer)));
            FieldClass = FlowField;
        }
        field(18; "Flow Item"; Code[20])
        {
            // cleaned
            CalcFormula = Lookup(Item."No." WHERE("No." = FIELD("Item No.")));
            FieldClass = FlowField;
        }
        field(19; "Div Code"; Code[20])
        {
            // cleaned
            CalcFormula = Lookup(Item."Global Dimension 1 Code" WHERE("No." = FIELD("Item No.")));
            FieldClass = FlowField;
        }
        field(20; Active; Boolean)
        {
            // cleaned
        }
        field(21; Selling; Decimal)
        {
            // cleaned
            CalcFormula = Lookup("Sales Price"."Unit Price" WHERE("Item No." = FIELD("Item No."),
                                                                   "Sales Code" = FIELD("Customer No."),
                                                                   "Ending Date" = FILTER(> '01/21/09')));
            FieldClass = FlowField;
        }
        field(22; Buying; Decimal)
        {
            // cleaned
            CalcFormula = Lookup(Item."Unit Cost" WHERE("No." = FIELD("Item No.")));
            FieldClass = FlowField;
        }
        field(23; "Vendor No."; Code[20])
        {
            // cleaned
            CalcFormula = Lookup(Item."Vendor No." WHERE("No." = FIELD("Item No.")));
            FieldClass = FlowField;
        }
        field(24; "Vendor Name"; Text[50])
        {
            // cleaned
            CalcFormula = Lookup(Vendor.Name WHERE("No." = FIELD("Vendor No.")));
            FieldClass = FlowField;
        }
        field(25; "Remark-2"; Text[250])
        {
            // cleaned
        }
        field(26; "PPAP Approved"; Boolean)
        {
            // cleaned
        }
        field(27; "Revision No."; Code[20])
        {
            // cleaned
            CalcFormula = Lookup("Cust./Item Drawing2"."Revision No." WHERE("Item No." = FIELD("Item No.")));
            FieldClass = FlowField;
        }
        field(28; "PPAP Approved Date"; Date)
        {
            // cleaned
        }
    }

    keys
    {
        key(PK; "Customer No.", "Item No.", Model, EMU, Per)
        {
            Clustered = true;
        }
        key(RPTSort; "Customer No.", "Active", "Item No.", Model, "EMU", "Per")
        { }
    }
}
