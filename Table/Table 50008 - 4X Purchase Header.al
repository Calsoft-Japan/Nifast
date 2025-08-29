table 50008 "4X Purchase Header"
{
    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(2; "Buy-from Vendor No."; Code[20])
        {
            Caption = 'Buy-from Vendor No.';
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'No.';
        }
        field(4; Amount; Decimal)
        {
            // cleaned
        }
        field(5; "Contract Note No."; Code[20])
        {
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(6; "Exchange Contract No."; Code[20])
        {
            // cleaned
        }
        field(7; "Location Code"; Code[10])
        {
            // cleaned
        }
        field(8; "Division No."; Code[10])
        {
            // cleaned
        }
        field(9; "Line No."; Integer)
        {
            // cleaned
        }
        field(10; Posted; Boolean)
        {
            // cleaned
        }
        field(100; "Document Line No."; Integer)
        {
            // cleaned
        }
        field(110; "Item No."; Code[20])
        {
            // cleaned
        }
        field(115; "Item Description"; Text[50])
        {
            // cleaned
        }
        field(120; Quantity; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(130; "Direct Unit Cost"; Decimal)
        {
            DecimalPlaces = 2 : 5;
        }
        field(140; "Ext. Cost"; Decimal)
        {
            // cleaned
        }
        field(200; "4X Contract No."; Code[20])
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; "Document Type", "Document No.", "Document Line No.")
        {
            SumIndexFields = Amount, "Ext. Cost";
        }
        key(Key2; "Contract Note No.")
        {
            SumIndexFields = Amount, "Ext. Cost";
        }
        key(Key3; "Exchange Contract No.")
        {
            SumIndexFields = Amount, "Ext. Cost";
        }
    }
}
