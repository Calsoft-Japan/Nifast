tableextension 50032 "Item Ledger Entry Ext" extends "Item Ledger Entry"
{
    fields
    {
        field(50000; "Inspected Parts"; Boolean)
        {
            Description = 'NIF';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Lot No. Information"."Passed Inspection" WHERE("Item No." = FIELD("Item No."),
                                                                                                                       "Lot No." = FIELD("Lot No.")));
        }
        field(50001; "Forecast on/off"; Boolean)
        {
            Description = 'NIF';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup(Item."Forecast on/off" WHERE("No." = FIELD("Item No.")));
        }
        field(50002; "Kitting Final Product"; Code[20])
        {
            Description = 'NIF';
            FieldClass = FlowField;
            CalcFormula = Lookup("BOM Component"."Parent Item No." WHERE("Parent Item No." = FIELD("Item No.")));
        }
        field(50005; "Mfg. Lot No."; Text[30])
        {
            Description = 'NIF';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Lot No. Information"."Mfg. Lot No." WHERE("Item No." = FIELD("Item No."),
                                                                                                                  "Lot No." = FIELD("Lot No.")));
        }
        field(50007; "Revision No."; Code[20])
        {
            Description = 'NIF';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Lot No. Information"."Revision No." WHERE("Item No." = FIELD("Item No."),
                                                                                                                  "Lot No." = FIELD("Lot No.")));
        }
        field(50800; "Entry/Exit Date"; Date)
        {
            Caption = 'Entry/Exit Date';
            DataClassification = ToBeClassified;
            Description = 'AKK1606.01';
        }
        field(50801; "Entry/Exit No."; Code[20])
        {
            Caption = 'Entry/Exit No.';
            DataClassification = ToBeClassified;
            Description = 'AKK1606.01';
        }
        field(60000; "Patente Original"; Code[10])
        {
            Description = 'NIF-Custom Agent License No.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Lot No. Information"."Patente Original" WHERE("Item No." = FIELD("Item No."),
                                                                                                                      "Lot No." = FIELD("Lot No.")));
        }
        field(60002; "Aduana E/S"; Code[10])
        {
            Description = 'NIF-Customer Agent E/S';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Lot No. Information"."Aduana E/S" WHERE("Item No." = FIELD("Item No."),
                                                                                                                "Lot No." = FIELD("Lot No.")));
        }
        field(60010; "Pediment No."; Code[10])
        {
            Description = 'NIF-Summary Entry No.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Lot No. Information"."Pediment No." WHERE("Item No." = FIELD("Item No."),
                                                                                                                  "Lot No." = FIELD("Lot No.")));
        }
        field(60012; "CVE Pedimento"; Code[10])
        {
            Description = 'NIF-Summary Entry Code';
            Editable = false;

        }
        field(60015; "Fecha de entrada"; Date)
        {
            Description = 'NIF-Date of Entry';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Lot No. Information"."Fecha de entrada" WHERE("Item No." = FIELD("Item No."),
                                                                                                                      "Lot No." = FIELD("Lot No.")));
        }
        field(14017612; "Order Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'NV';
        }
        field(14017645; "Contract No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NV';
        }
        field(14017671; "Tag No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NV';
        }
        field(14017672; "Customer Bin"; tEXT[12])
        {
            DataClassification = ToBeClassified;
            Description = 'NV';
        }
        field(14017931; "Rework No"; cODE[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NV';
        }
        field(14017932; "Rework line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'NV';
        }
        field(14018050; "No Cr. Mgmt. Comment"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'NV';
            Editable = false;
        }
        field(14018070; "QC Hold"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'NV';
        }
        field(14018071; "QC Hold Reason Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'NV';
        }
        field(37015330; "FB Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NV';
        }
        field(37015331; "FB Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'NV';
        }
        field(37015332; "FB Tag No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NV';
        }
        field(37015333; "FB Customer Bin"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NV';
        }
    }

    keys
    {
        key(RPTSort; "Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date", "Expiration Date", "Lot No.", "Serial No.")
        {


        }
    }
}
