table 80002 "Dup NV Pur. Line"
{
    Caption = 'Dup NV Pur. Line';
    DrillDownPageID = 518;
    LookupPageID = 518;
    PasteIsValid = false;

    fields
    {
        field(1; "Document Type"; Code[10])
        {
            // cleaned
        }
        field(2; "Buy-from Vendor No."; Code[20])
        {
            Caption = 'Buy-from Vendor No.';
            TableRelation = Vendor;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(5; Type; Code[10])
        {
            Description = 'NV3.60';
        }
        field(6; "No."; Code[20])
        {
            Description = 'NV3.60';
            TableRelation = IF (Type = CONST()) "Standard Text" ELSE IF (Type = CONST('G/L ACCOUNT')) "G/L Account"
            ELSE IF (Type = CONST('ITEM')) Item
            ELSE IF (Type = CONST('RESOURCE')) Resource
            ELSE IF (Type = CONST('FIXED ASSET')) "Fixed Asset"
            ELSE IF (Type = CONST('CHARGE (ITEM)')) "Item Charge";
        }
        field(7; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
        }
        field(10; "Expected Receipt Date"; Date)
        {
            Caption = 'Expected Receipt Date';
            trigger OnValidate()
            var
            //CheckDateConflict: Codeunit 99000815;
            begin
            end;
        }
        field(11; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(12; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
        }
        field(15; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(22; "Direct Unit Cost"; Decimal)
        {
            Caption = 'Direct Unit Cost';
        }
        field(23; "Unit Cost (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost ($)';
        }
        field(25; "VAT %"; Decimal)
        {
            Caption = 'Tax %';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(26; "Qty Disc %"; Decimal)
        {
            // cleaned
        }
        field(27; "Line Discount %"; Decimal)
        {
            Caption = 'Line Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(28; "Line Discount Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Line Discount Amount';
        }
        field(29; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';
            Editable = false;
        }
        field(30; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Including Tax';
            Editable = false;
        }
        field(31; "Unit Price (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price ($)';
        }
        field(32; "Allow Invoice Disc."; Boolean)
        {
            Caption = 'Allow Invoice Disc.';
            InitValue = true;
        }
        field(34; "Gross Weight"; Decimal)
        {
            Caption = 'Gross Weight';
            DecimalPlaces = 0 : 5;
        }
        field(35; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight';
            DecimalPlaces = 0 : 5;
        }
        field(36; "Units per Parcel"; Decimal)
        {
            Caption = 'Units per Parcel';
            DecimalPlaces = 0 : 5;
        }
        field(37; "Unit Volume"; Decimal)
        {
            Caption = 'Unit Volume';
            DecimalPlaces = 0 : 5;
        }
        field(40; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(41; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(45; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
        }
        field(47; "Phase Code"; Code[10])
        {
            Caption = 'Phase Code';
             
            TableRelation = Table161;
             
        }
        field(48; "Task Code"; Code[10])
        {
            Caption = 'Task Code';
             
            TableRelation = Table162;
             
        }
        field(49; "Step Code"; Code[10])
        {
            Caption = 'Step Code';
             
            TableRelation = Table163;
             
        }
        field(54; "Indirect Cost %"; Decimal)
        {
            Caption = 'Indirect Cost %';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(68; "Pay-to Vendor No."; Code[20])
        {
            Caption = 'Pay-to Vendor No.';
            Editable = false;
            TableRelation = Vendor;
        }
        field(69; "Inv. Discount Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Inv. Discount Amount';
            Editable = false;
        }
        field(70; "Vendor Item No."; Text[20])
        {
            Caption = 'Vendor Item No.';
        }
        field(71; "Sales Order No."; Code[20])
        {
            Caption = 'Sales Order No.';
            Editable = false;
            TableRelation = IF ("Drop Shipment" = CONST(true)) "Sales Header"."No." WHERE("Document Type" = CONST(Order));
        }
        field(72; "Sales Order Line No."; Integer)
        {
            Caption = 'Sales Order Line No.';
            Editable = false;
            TableRelation = IF ("Drop Shipment" = CONST(true)) "Sales Line"."Line No." WHERE("Document Type" = CONST(Order),
                                                                                         "Document No." = FIELD("Sales Order No."));
        }
        field(73; "Drop Shipment"; Boolean)
        {
            Caption = 'Drop Shipment';
            Editable = false;
        }
        field(77; "VAT Calculation Type"; Code[10])
        {
            Editable = false;
        }
        field(80; "Attached to Line No."; Integer)
        {
            Caption = 'Attached to Line No.';
            Editable = false;
             
            TableRelation = "Purchase Line"."Line No." WHERE("Document Type" = FIELD("Document Type"),
                                                                "Document No." = FIELD("Document No."));
             
        }
        field(85; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(86; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
            Editable = false;
        }
        field(87; "Tax Group Code"; Code[10])
        {
            Caption = 'Tax Group Code';
            TableRelation = "Tax Group";
        }
        field(91; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = false;
            TableRelation = Currency;
        }
        field(100; "Unit Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Cost';
            Editable = false;
        }
        field(103; "Line Amount"; Decimal)
        {
            Caption = 'Line Amount';
        }
        field(5402; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = IF (Type = CONST('ITEM')) "Item Variant".Code WHERE("Item No." = FIELD("No."));
        }
        field(5407; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = IF (Type = CONST('ITEM')) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."))
            ELSE
            "Unit of Measure";

            trigger OnValidate()
            var
            //   UnitOfMeasureTranslation: Record 5402;
            begin
            end;
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Editable = false;
            TableRelation = "Responsibility Center";
        }
        field(5705; "Cross-Reference No."; Code[20])
        {
            Caption = 'Cross-Reference No.';
            trigger OnLookup()
            var
            // ItemCrossReference: Record 5717;
            begin
            end;

            trigger OnValidate()
            var
            // ReturnedCrossRef: Record 5717;
            begin
            end;

        }
        field(5706; "Unit of Measure (Cross Ref.)"; Code[10])
        {
            Caption = 'Unit of Measure (Cross Ref.)';
            TableRelation = IF (Type = CONST('ITEM')) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."));
        }
        field(5707; "Cross-Reference Type"; Code[10])
        {
            // cleaned
        }
        field(5708; "Cross-Reference Type No."; Code[30])
        {
            Caption = 'Cross-Reference Type No.';
        }
        field(5709; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            TableRelation = IF (Type = CONST('ITEM')) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."));
        }
        field(5710; Nonstock; Boolean)
        {
            Caption = 'Nonstock';
        }
        field(5711; "Purchasing Code"; Code[10])
        {
            Caption = 'Purchasing Code';
            TableRelation = Purchasing;
        }
        field(5712; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            // TableRelation = "Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
            TableRelation = "Item Category".Code WHERE(Code = FIELD("Item Category Code"));
        }
        field(5713; "Special Order"; Boolean)
        {
            Caption = 'Special Order';
        }
        field(5714; "Special Order Sales No."; Code[20])
        {
            Caption = 'Special Order Sales No.';
            TableRelation = IF ("Special Order" = CONST(true)) "Sales Header"."No." WHERE("Document Type" = CONST(Order));
        }
        field(5715; "Special Order Sales Line No."; Integer)
        {
            Caption = 'Special Order Sales Line No.';
            TableRelation = IF ("Special Order" = CONST(true)) "Sales Line"."Line No." WHERE("Document Type" = CONST(Order),
                                                                                         "Document No." = FIELD("Special Order Sales No."));
        }
        field(5790; "Requested Receipt Date"; Date)
        {
            Caption = 'Requested Receipt Date';
        }
        field(5791; "Promised Receipt Date"; Date)
        {
            Caption = 'Promised Receipt Date';
        }
        field(5794; "Planned Receipt Date"; Date)
        {
            Caption = 'Planned Receipt Date';
        }
        field(5795; "Order Date"; Date)
        {
            Caption = 'Order Date';
        }
        field(10022; "1099 Liable"; Boolean)
        {
            Caption = '1099 Liable';
        }
    }
    keys
    {
        key(Key1; "Document Type", "Document No.", "Line No.")
        {
            MaintainSIFTIndex = false;
        }
    }

    fieldgroups
    {
    }
}
