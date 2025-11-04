table 99802 "TEMP- Fix Kit Entry"
{
    Caption = 'TEMP - Fix ILE Blank Dims';
    fields
    {
        field(1; "Entry No."; Integer)
        {
            // cleaned
        }
        field(5; "Item No."; Code[20])
        {
            // cleaned
        }
        field(6; "Lot No."; Code[20])
        {
            // cleaned
        }
        field(7; "Location Code"; Code[20])
        {
            // cleaned
        }
        field(8; "Posting Date"; Date)
        {
            // cleaned
        }
        field(9; "Prod Kit. No."; Code[20])
        {
            // cleaned
        }
        field(20; Quantity; Decimal)
        {
            // cleaned
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Item No.", "Lot No.", "Location Code")
        {
            SumIndexFields = Quantity;
        }
    }

    fieldgroups
    {
    }
}
