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
        field(14017612; "NV Posting Date"; Date)
        {
        }
        field(14017613; "Purchaser Code"; code[10])
        {
            TableRelation = "Salesperson/Purchaser" where(Purchase = const(true));
        }
        field(14017614; "Vendor Shipment No."; Code[20])
        {
        }
        field(14017615; "Vendor Invoice No."; Code[20])
        {
        }
        field(14017616; "Vendor Cr. Memo No."; Code[20])
        {
        }
        field(14017633; "No;Line Comment"; Boolean)
        {
            FieldClass = FlowField;
            Description = 'NF1.00:CIS.CM 09-29-15';
            Editable = false;
        }
        field(14017640; "Ship-to PO No."; Code[20])
        {
        }
        field(14017650; "Resource Group No."; Code[20])
        {
            TableRelation = "Resource Group";
        }
        field(14017750; "Line Gross Weight"; Decimal)
        {
        }
        field(14017751; "Line Net Weight"; Decimal)
        {
        }
        field(14017756; "Item Group Code"; Code[10])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
        }
        field(14017790; "Container No."; Code[20])
        {
        }
        field(14017930; "Rework No."; Code[20])
        {
        }
        field(14017931; "Rework Line No."; Integer)
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
