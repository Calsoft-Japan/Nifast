tableextension 50121 "Purch. Rcpt. Line Ext" extends "Purch. Rcpt. Line"
{
    fields
    {
        field(50000; "Contract Note No."; Code[20])
        {
            // cleaned
            TableRelation = "4X Contract"."No.";
        }
        field(50001; "Exchange Contract No."; Code[20])
        {
            // cleaned
        }
        field(50005; "Sail-on Date"; Date)
        {
            Description = '#10044';
        }
        field(50007; "Vessel Name"; Code[50])
        {
            Description = '#10044';
        }
        field(50010; "Drawing No."; Code[30])
        {
            // cleaned
        }
        field(50011; "Revision No."; Code[20])
        {
            // cleaned
        }
        field(50012; "Revision Date"; Date)
        {
            // cleaned
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
        field(51000; Select; Boolean)
        {
            // cleaned
        }
        field(51010; "Transfer Order Created"; Boolean)
        {
            // cleaned
        }
        field(52000; "Country of Origin Code"; Code[10])
        {
            TableRelation = "Country/Region";
        }
        field(52010; Manufacturer; Code[50])
        {
            TableRelation = Manufacturer;
        }
        field(60000; "HS Tariff Code"; Code[10])
        {
            CalcFormula = Lookup(Item."HS Tariff Code" WHERE("No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "HS Tariff Code";
        }
        field(70000; "NV Posting Date"; Date)
        {
        }
        field(70001; "Purchaser Code"; code[10])
        {
            TableRelation = "Salesperson/Purchaser" where(Purchase = const(true));
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
        field(70024; "No;Line Comment"; Boolean)
        {
            FieldClass = FlowField;
            Description = 'NF1.00:CIS.CM 09-29-15';
            Editable = false;
        }
        field(70025; "Container No."; Code[20])
        {
        }
    }

    keys
    {
        key(RPTSort; Type, "No.") { }
        key(Key50000; "Document No.", Type, "Location Code", "Buy-from Vendor No.", "Order No.")
        { }
        key(Key50001; "No.", "Order No.", "Expected Receipt Date")
        { }
    }
}
