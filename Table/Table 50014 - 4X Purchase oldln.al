table 50014 "4X Purchase oldln"
{
    fields
    {
        field(1; "Document No."; Code[20])
        {
            // cleaned
        }
        field(2; Description; Text[50])
        {
            // cleaned
        }
        field(3; "Unit of Measure"; Text[10])
        {
            // cleaned
        }
        field(4; Quantity; Decimal)
        {
            // cleaned
        }
        field(5; Amount; Decimal)
        {
            // cleaned
        }
        field(6; "Amount Including VAT"; Decimal)
        {
            // cleaned
        }
        field(7; "Unit Price (LCY)"; Decimal)
        {
            // cleaned
        }
        field(8; "Shortcut Dimension 1 Code"; Code[20])
        {
            // cleaned
        }
        field(9; "Requested Reciept Date"; Date)
        {
            // cleaned
        }
        field(10; "Line No."; Integer)
        {
            // cleaned
        }
        field(11; "Exchange Contract No."; Code[10])
        {
            // cleaned
        }
        field(12; "Item No."; Code[10])
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
        key(Key2; "Exchange Contract No.")
        {
        }
    }

    fieldgroups
    {
    }
}
