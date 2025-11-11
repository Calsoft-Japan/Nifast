tableextension 50123 "Purch. Inv. Line Ext" extends "Purch. Inv. Line"
{
    // version NAVW18.00,NAVNA8.00,SE0.51.20,NV4.32,4x,NIF1.086,NMX1.000,NIF.N15.C9IN.001,FOREX,AKK1606.01,AKK1607.01
    fields
    {
        modify("No.")
        {
            TableRelation = IF (Type = CONST("G/L Account")) "G/L Account"
            ELSE IF (Type = CONST(Item)) Item
            ELSE IF (Type = CONST(Resource)) Resource
            ELSE IF (Type = CONST("Fixed Asset")) "Fixed Asset"
            ELSE IF (Type = CONST("Charge (Item)")) "Item Charge";
        }
        field(50000; "Contract Note No."; Code[20])
        {
            // cleaned
            TableRelation = "4X Contract"."No.";
        }
        field(50001; "Exchange Contract No."; Code[20])
        {
            // cleaned
        }
        field(50002; "USD Value"; Decimal)
        {
            Description = 'Forex';
        }

        field(50003; "Alt. Price"; Decimal)
        {
            DecimalPlaces = 2 : 5;
            trigger OnValidate()
            var
                ItemUOMRec2: Record 5404;
            BEGIN

            END;
        }

        field(50004; "Alt. Price UOM"; Code[10])
        {
            Editable = false;
        }
        field(50800; "Entry/Exit Date"; Date)
        {
            Caption = 'Entry/Exit Date';
            Description = 'AKK1606.01';
        }
        field(50801; "Entry/Exit No."; Code[20])
        {
            Caption = 'Entry/Exit No.';
            Description = 'AKK1606.01';
        }
        field(50802; National; Boolean)
        {
            Caption = 'National';
            Description = 'AKK1606.01';
        }
        field(50803; "Is retention Line"; Boolean)
        {
            Description = 'RET1.0';
        }
        field(50804; "Is Withholding Tax"; Boolean)
        {
            Description = 'RET1.0';
        }
        field(52000; "Country of Origin Code"; Code[10])
        {
            // cleaned
            TableRelation = "Country/Region";
        }
        field(52010; Manufacturer; Code[50])
        {
            // cleaned
            TableRelation = Manufacturer;
        }

        field(70000; "NV Posting Date"; Date)
        {
        }

        field(70001; "Purchaser Code"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser" WHERE(Purchase = CONST(True));
        }

        field(70002; "Vendor Shipment No."; Code[20])
        {
        }

        field(70003; "Vendor Invoice No."; Code[20])
        {
        }

        field(70004; "Vendor Cr. Memo No."; Code[20])
        {
        }

        field(70006; "Ship-to PO No."; Code[20])
        {
        }

        field(70007; "Resource Group No."; Code[20])
        {
            TableRelation = "Resource Group";
        }

        field(70008; "Alt. Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
        }

        field(70009; "Alt. Qty. UOM"; Code[10])
        {
            Editable = false;
        }

        field(70012; "Line Gross Weight"; Decimal)
        {
        }

        field(70013; "Line Net Weight"; Decimal)
        {
        }

        field(70014; "Item Group Code"; Code[10])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
        }

        field(70015; "Rework No."; Code[20])
        {
        }

        field(70016; "Rework Line No."; Integer)
        {
        }

        field(70017; "Line Comment"; Boolean)
        {
            FieldClass = FlowField;
            Description = 'NF1.00:CIS.NG 10-10-15';
            Editable = false;
        }

    }
    keys
    {
        key(Key8; Type, "No.", "Unit Cost")
        {
        }
        key(Key9; "Exchange Contract No.")
        {
            //SumIndexFields = Amount;
        }
        key(Key10; "Posting Date", Type, "No.", "Buy-from Vendor No.")
        {
        }
    }
}
