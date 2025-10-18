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
    }
    keys
    {
        key(Key1; "Item No.", "Sales Type", "Sales Code", "Starting Date", "Currency Code", "Variant Code", "Unit of Measure Code", "Minimum Quantity", "Item No. 2")
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
}
