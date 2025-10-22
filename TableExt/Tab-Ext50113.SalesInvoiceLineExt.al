tableextension 50113 "Sales Invoice Line Ext" extends "Sales Invoice Line"
{
    fields
    {
        field(50001; "EDI Control No."; Code[20])
        {
            // cleaned
            CalcFormula = Lookup("Cust. Ledger Entry"."EDI Control No." WHERE("Document No." = FIELD("Document No.")));
            FieldClass = FlowField;
        }
        field(50003; "Ship-to Code"; Code[10])
        {
            // cleaned
            CalcFormula = Lookup("Sales Invoice Header"."Ship-to Code" WHERE("No." = FIELD("Document No.")));
            FieldClass = FlowField;
        }
        field(50005; "Certificate No."; Code[30])
        {
            // cleaned
        }
        field(50010; "Drawing No."; Code[30])
        {
            // cleaned
        }
        field(50020; "Revision No."; Code[20])
        {
            // cleaned
        }
        field(50025; "Revision Date"; Date)
        {
            // cleaned
        }
        field(50027; "Revision No. (Label Only)"; Code[20])
        {
            // cleaned
        }
        field(50030; "Total Parcels"; Decimal)
        {
            DecimalPlaces = 0 : 2;
            Description = '#10069';
        }
        field(50100; "Storage Location"; Code[10])
        {
            // cleaned
        }
        field(50105; "Line Supply Location"; Code[10])
        {
            // cleaned
        }
        field(50110; "Deliver To"; Code[10])
        {
            // cleaned
        }
        field(50115; "Receiving Area"; Code[10])
        {
            // cleaned
        }
        field(50120; "Ran No."; Code[20])
        {
            // cleaned
        }
        field(50125; "Container No."; Code[20])
        {
            // cleaned
        }
        field(50130; "Kanban No."; Code[20])
        {
            // cleaned
        }
        field(50135; "Res. Mfg."; Code[20])
        {
            // cleaned
        }
        field(50140; "Release No."; Code[20])
        {
            // cleaned
        }
        field(50145; "Mfg. Date"; Date)
        {
            // cleaned
        }
        field(50150; "Man No."; Code[20])
        {
            // cleaned
        }
        field(50155; "Delivery Order No."; Code[20])
        {
            // cleaned
        }
        field(50160; "Dock Code"; Code[10])
        {
            // cleaned
        }
        field(50165; "Box Weight"; Decimal)
        {
            // cleaned
        }
        field(50170; "Store Address"; Text[50])
        {
            // cleaned
        }
        field(50175; "FRS No."; Code[10])
        {
            // cleaned
        }
        field(50180; "Main Route"; Code[10])
        {
            // cleaned
        }
        field(50185; "Line Side Address"; Text[50])
        {
            // cleaned
        }
        field(50190; "Sub Route Number"; Code[10])
        {
            // cleaned
        }
        field(50195; "Special Markings"; Text[30])
        {
            // cleaned
        }
        field(50200; "Eng. Change No."; Code[20])
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
        field(14017611; "Order Date"; Date)
        {
            Description = 'NV-FB';
        }
        field(14017612; "Manufacturer Code"; code[10])
        {
            TableRelation = Manufacturer.Code;
        }
        field(14017614; "Tool Repair Tech"; code[10])
        {
            TableRelation = "Salesperson/Purchaser".Code WHERE("Repair Tech" = CONST(true));
        }
        field(14017615; "Salesperson Code"; code[10])
        {
            TableRelation = "Salesperson/Purchaser".Code WHERE(Sales = CONST(true));
            Description = 'NV-FB';
        }
        field(14017616; "Inside Salesperson Code"; code[10])
        {
            TableRelation = "Salesperson/Purchaser".Code WHERE("Inside Sales" = CONST(true));
            Description = 'NV-FB';
        }
        field(14017617; "NV Posting Date"; Date)
        {
        }
        field(14017618; "External Document No."; code[20])
        {
            Description = 'NV-FB';
        }
        field(14017621; "List Price"; Decimal)
        {
        }
        field(14017624; "Alt. Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(14017625; "Alt. Qty. UOM"; code[10])
        {
            Editable = false;
        }
        field(14017626; "Alt. Price"; Decimal)
        {
            DecimalPlaces = 2 : 5;
            trigger OnValidate()
            var
                ItemUOMRec2: Record "Item Unit of Measure";
            begin
            end;
        }
        field(14017627; "Alt. Price UOM"; code[10])
        {
            Editable = false;
        }
        field(14017628; "Alt. Sales Cost"; Decimal)
        {
            DecimalPlaces = 2 : 5;
            Editable = false;
        }
        field(14017631; "Net Unit Price"; Decimal)
        {
            DecimalPlaces = 2 : 5;
            Editable = false;
        }
        field(14017633; "No;Line Comment"; Boolean)
        {
            FieldClass = FlowField;
            Description = 'NF1.00:CIS.CM 09-29-15';
            Editable = false;
        }
        field(14017640; "Ship-to PO No."; code[20])
        {
        }
        field(14017641; "Shipping Advice"; Option)
        {
            OptionCaptionML = ENU = 'Partial,Complete';
            OptionMembers = Partial,Complete;
        }
        field(14017645; "Contract No."; code[20])
        {
            TableRelation = "Price Contract" WHERE("Customer No." = FIELD("Sell-to Customer No."));
            Description = 'NV-FB';
        }
        field(14017650; "Resource Group No."; code[20])
        {
            TableRelation = "Resource Group";
        }
        field(14017660; "Order Outstanding Qty. (Base)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(14017661; "Order Quantity (Base)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(14017671; "Tag No."; code[20])
        {
        }
        field(14017672; "Customer Bin"; text[12])
        {
        }
        field(14017750; "Line Gross Weight"; Decimal)
        {
        }
        field(14017751; "Line Net Weight"; Decimal)
        {
        }
        field(14017752; "Ship-to Code NV"; code[10])
        {
            Description = 'NV-FB';
        }
        field(14017753; "Line Cost"; Decimal)
        {
            Editable = false;
        }
        field(14017756; "Item Group Code"; code[10])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
        }
        field(14017757; "Vendor No."; code[20])
        {
        }
        field(14017758; "Vendor Item No."; text[20])
        {
        }
        field(14017903; "BOM Item"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("BOM Component" WHERE("Parent Item No." = FIELD("No.")));
            Editable = false;
        }
        field(14017904; "Prod. Order No."; Code[20])
        {
        }
        field(37015330; "FB Order No."; Code[20])
        {
            Description = 'NV-FB';
        }
        field(37015331; "FB Line No."; Integer)
        {
            Description = 'NV-FB';
        }
        field(37015332; "FB Tag No."; code[20])
        {
            Description = 'NV-FB';
        }
        field(37015333; "FB Customer Bin"; code[20])
        {
            Description = 'NV-FB';
        }
    }
    keys
    {
        key(Key50000; "No.", "Location Code", "Variant Code", "Posting Date", "Sell-to Customer No.")
        {
        }
    }
}
