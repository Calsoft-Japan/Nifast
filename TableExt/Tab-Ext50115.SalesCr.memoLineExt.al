tableextension 50115 "Sales Cr.Memo Line Ext" extends "Sales Cr.Memo Line"
{
    // version NAVW18.00,NAVNA8.00,SE0.55.08,NV4.29,NIF1.050,NIF.N15.C9IN.001,AKK1606.01
    fields
    {
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
        field(70000; "Order Date"; Date)
        {
            Description = 'NV';
        }

        field(70001; "Manufacturer Code"; Code[10])
        {
            TableRelation = Manufacturer.Code;
        }

        field(70002; "Tool Repair Tech"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser".Code WHERE("Repair Tech" = CONST(true));
        }

        field(70003; "Salesperson Code"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser".Code WHERE("Sales" = CONST(true));
            Description = 'NV';
        }

        field(70004; "Inside Salesperson Code"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser".Code WHERE("Inside Sales" = CONST(true));
            Description = 'NV';
        }

        field(70005; "NV Posting Date"; Date)
        {
        }

        field(70006; "External Document No."; Code[20])
        {
            Description = 'NV';
        }

        field(70007; "List Price"; Decimal)
        {
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

        field(70010; "Alt. Price"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            trigger OnValidate()
            var
                ItemUOMRec2: Record 5404;
            BEGIN

            END;
        }

        field(70011; "Alt. Price UOM"; Code[10])
        {
            Editable = false;
        }

        field(70012; "Alt. Sales Cost"; Decimal)
        {
            Editable = false;
        }

        field(70013; "Net Unit Price"; Decimal)
        {
            DecimalPlaces = 2 : 5;
            Editable = false;
        }

        field(70014; "Line Comment"; Boolean)
        {
            FieldClass = FlowField;
            Description = 'NF1.00:CIS.CM 09-29-15';
            Editable = false;
        }

        field(70015; "Ship-to PO No."; Code[20])
        {
        }

        field(70016; "Shipping Advice"; Option)
        {
            OptionCaptionML = ENU = 'Partial,Complete';
            OptionMembers = Partial,Complete;
        }

        field(70017; "Contract No."; Code[20])
        {
            TableRelation = "Price Contract" WHERE("Customer No." = FIELD("Sell-to Customer No."));
            Description = 'NV';
        }

        field(70018; "Resource Group No."; Code[20])
        {
            TableRelation = "Resource Group";
        }

        field(70019; "Order Outstanding Qty. (Base)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }

        field(70020; "Order Quantity (Base)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }

        field(70023; "Line Gross Weight"; Decimal)
        {
        }

        field(70024; "Line Net Weight"; Decimal)
        {
        }

        field(70025; "Ship-to Code NV"; Code[10])
        {
            Description = 'NV';
        }

        field(70026; "Line Cost"; Decimal)
        {
            Editable = false;
        }

        field(70027; "Item Group Code"; Code[10])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
        }

        field(70028; "Vendor No."; Code[20])
        {
        }

        field(70029; "Vendor Item No."; Text[20])
        {
        }

        field(70030; "BOM Item"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("BOM Component" WHERE("Parent Item No." = FIELD("No.")));
            Editable = false;
        }

        field(70031; "Prod. Order No."; Code[20])
        {
        }

    }
    keys
    {
        key(Key9; "Shipment Date")
        {
        }
    }
}
