table 50141 "FB Tag Journal Line"
{
    fields
    {
        field(1; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(20; "Document No."; Code[20])
        {
            // cleaned
        }
        field(30; "Customer No."; Code[20])
        {
            // cleaned
        }
        field(40; "Contract No."; Code[20])
        {
            // cleaned
        }
        field(50; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
        }
        field(60; "Ship-to Code"; Code[10])
        {
            // cleaned
        }
        field(70; "Item No."; Code[20])
        {
            Caption = 'Item No.';


            // Item.TESTFIELD(Blocked,FALSE);

        }
        field(80; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';
        }
        field(90; "Tag No."; Code[20])
        {

        }
        field(95; "Cross-Reference No."; Code[20])
        {
            // cleaned
        }
        field(100; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
        }
        field(110; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(120; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
        }
        field(140; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
        }
        field(150; "Order Date"; Date)
        {
            Caption = 'Order Date';
        }
        field(160; "Order Time"; Time)
        {
            // cleaned
        }
        field(170; "Salesperson Code"; Code[10])
        {
            Caption = 'Salespers./Purch. Code';
        }
        field(175; "Inside Salesperson Code"; Code[10])
        {
            // cleaned
        }
        field(180; "Required Date"; Date)
        {
            // cleaned
        }
        field(190; "Customer Bin"; Code[20])
        {
            Caption = 'Customer Bin';
        }
        field(200; "Purchase Price"; Decimal)
        {
            DecimalPlaces = 2 : 5;
        }
        field(210; "Sale Price"; Decimal)
        {
            DecimalPlaces = 2 : 5;
        }
        field(350; "Quantity Type"; Option)
        {
            OptionCaption = 'Order,Usage,Count';
            OptionMembers = "Order",Usage,"Count";
        }
        field(400; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
        }
    }
}
