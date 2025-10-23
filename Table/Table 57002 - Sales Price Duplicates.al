table 57002 "Sales Price Duplicates"
{
    // NF1.00:CIS.NG    10/10/15 Fix the Table Relation Property for fields (Remove the relationship for non exists table)

    Caption = 'Sales Price Duplicates';
    LookupPageID = "Sales Prices";
    fields
    {
        field(1; "Item No."; Text[20])
        {
            Caption = 'Item No.';
            NotBlank = true;
            TableRelation = Item;
        }
        field(2; "Sales Code"; Code[20])
        {
            Caption = 'Sales Code';
            TableRelation = IF ("Sales Type" = CONST("Customer Price Group")) "Customer Price Group"
            ELSE IF ("Sales Type" = CONST(Customer)) Customer
            ELSE IF ("Sales Type" = CONST(Campaign)) Campaign;
        }
        field(3; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(4; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
        }
        field(5; "Unit Price"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Price';
            MinValue = 0;
        }
        field(6; "Item No. 2"; Text[20])
        {
            // cleaned
        }
        field(7; "Price Includes VAT"; Boolean)
        {
            Caption = 'Price Includes Tax';
        }
        field(10; "Allow Invoice Disc."; Boolean)
        {
            Caption = 'Allow Invoice Disc.';
            InitValue = true;
        }
        field(11; "VAT Bus. Posting Gr. (Price)"; Code[10])
        {
            Caption = 'Tax Bus. Posting Gr. (Price)';
            TableRelation = "VAT Business Posting Group";
        }
        field(13; "Sales Type"; Option)
        {
            Caption = 'Sales Type';
            OptionCaption = 'Customer,Customer Price Group,All Customers,Campaign';
            OptionMembers = Customer,"Customer Price Group","All Customers",Campaign;
        }
        field(14; "Minimum Quantity"; Decimal)
        {
            Caption = 'Minimum Quantity';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(15; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
        }
        field(5400; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(5700; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(7001; "Allow Line Disc."; Boolean)
        {
            Caption = 'Allow Line Disc.';
            InitValue = true;
        }
        field(14017614; "Alt. Price"; Decimal)
        {
            Description = 'NV';
            Editable = false;
        }
        field(14017615; "Alt. Price UOM"; Code[10])
        {
            Description = 'NV';
            Editable = false;
        }
        field(14017618; "External Document No."; Code[20])
        {
            Description = 'NV';
        }
        field(14017645; "Contract No."; Code[20])
        {
            Description = 'NV';
        }
        field(14017646; "Item Description"; Text[50])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item No.")));
            Description = 'NV';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14017647; "Est. Usage"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'NV';
        }
        field(14017648; Comments; Boolean)
        {
            Description = 'NV - NF1.00:CIS.NG 10-10-15';
            Editable = false;
            Enabled = false;
            FieldClass = FlowField;
        }
        field(14017649; "Contract Customer No."; Code[20])
        {
            Description = 'NV';
        }
        field(14017650; "Contract Ship-to Code"; Code[10])
        {
            Description = 'NV';
        }
        field(14017651; "Contract Location Code"; Code[10])
        {
            Description = 'NV';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false),
                                            "Rework Location" = CONST(false));
        }
        field(14017652; "Actual Usage"; Decimal)
        {
            CalcFormula = - Sum("Item Ledger Entry".Quantity WHERE("Contract No." = FIELD("Contract No."),
                                                                   "Item No." = FIELD("Item No."),
                                                                   "Entry Type" = CONST(Sale)));
            DecimalPlaces = 0 : 5;
            Description = 'NV';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14017653; "Method of Fullfillment"; Option)
        {
            Description = 'NV';
            OptionCaption = 'Standard,FillBill';
            OptionMembers = Standard,FillBill;
        }
        field(14017654; "Min. Qty. on Hand"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'NV';
        }
        field(14017655; "Initial Stocking Qty."; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'NV';
        }
        field(14017656; "Blanket Orders"; Boolean)
        {
            CalcFormula = Exist("Sales Line" WHERE("Document Type" = CONST("Blanket Order"),
                                                    "Contract No." = FIELD("Contract No."),
                                                    Type = CONST(Item),
                                                    "No." = FIELD("Item No.")));
            Description = 'NV';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14017657; "Contract Ship Location Code"; Code[10])
        {
            Description = 'NV';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false),
                                            "Rework Location" = CONST(false));
        }
        field(14017658; "Replenishment Method"; Option)
        {
            Caption = 'Replenishment Method';
            Description = 'NV';
            OptionCaption = ' ,Automatic,Manual';
            OptionMembers = " ",Automatic,Manual;
        }
        field(14017659; "Reorder Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'NV';
        }
        field(14017660; "Max. Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'NV';
        }
        field(14017661; "Min. Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'NV';
        }
        field(14017662; "Customer Bin"; Code[20])
        {
            Description = 'NV';
        }
        field(14017663; "Contract Selling Location Code"; Code[10])
        {
            Description = 'NV';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false),
                                            "Rework Location" = CONST(false));
        }
        field(37015330; "FB Tags"; Boolean)
        {
            CalcFormula = Exist("FB Tag" WHERE("Customer No." = FIELD("Contract Customer No."),
                                                "Ship-to Code" = FIELD("Contract Ship-to Code"),
                                                "Item No." = FIELD("Item No."),
                                                "Variant Code" = FIELD("Variant Code"),
                                                "Unit of Measure Code" = FIELD("Unit of Measure Code"),
                                                "Contract No." = FIELD("Contract No.")));
            Description = 'NV';
            Editable = false;
            FieldClass = FlowField;
        }
        field(37015331; "FB Order Type"; Option)
        {
            Description = 'NV';
            OptionCaption = ' ,Consigned,Non-Consigned';
            OptionMembers = " ",Consigned,"Non-Consigned";
        }
    }
    keys
    {
        key(Key1; "Item No.", "Sales Type", "Sales Code", "Starting Date", "Currency Code", "Variant Code", "Unit of Measure Code", "Minimum Quantity", "Contract No.", "Item No. 2")
        {
        }
        key(Key2; "Sales Type", "Sales Code", "Item No.", "Starting Date", "Currency Code", "Variant Code", "Unit of Measure Code", "Minimum Quantity")
        {
        }
    }
    fieldgroups
    {
    }

    var
    /*  CustPriceGr: Record 6;
     Text000: Label '%1 cannot be after %2';
     Cust: Record 18;
     Text001: Label '%1 must be blank.';
     Campaign: Record 5071;
     Item: Record 27;
     Text002: Label 'You can only change the %1 and %2 from the Campaign Card when %3 = %4';
     ">>GV_NV": Integer;
     Contract: Record 50110; */
    keys
    {
        // key(Key1; "Item No.", "Sales Type", "Sales Code", "Starting Date", "Currency Code", "Variant Code", "Unit of Measure Code", "Minimum Quantity", "Contract No.", "Item No. 2")
        // Removed add-on field (Contract No.)
        key(Key1; "Item No.", "Sales Type", "Sales Code", "Starting Date", "Currency Code", "Variant Code", "Unit of Measure Code", "Minimum Quantity", "Item No. 2")
        {
        }
        key(Key2; "Sales Type", "Sales Code", "Item No.", "Starting Date", "Currency Code", "Variant Code", "Unit of Measure Code", "Minimum Quantity")
        {
        }
    }
}
