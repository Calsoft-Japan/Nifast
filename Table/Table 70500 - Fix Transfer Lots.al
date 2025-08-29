table 70500 "Fix Transfer Lots"
{
    fields
    {
        field(1; "Item Ledg Entry No."; Integer)
        {
            // cleaned
        }
        field(2; "Item No."; Code[20])
        {
            // cleaned
        }
        field(3; "Lot No."; Code[20])
        {
            // cleaned
        }
        field(4; "Bin Code"; Code[20])
        {

        }
        field(5; "Location Code"; Code[20])
        {
            // cleaned
        }
        field(10; Quantity; Decimal)
        {
            // cleaned
        }
        field(11; "Adjmt. Qty"; Decimal)
        {
            // cleaned
        }
        field(15; "Doc No."; Code[20])
        {
            // cleaned
        }
        field(16; "Doc Line No."; Integer)
        {
            // cleaned
        }
        field(20; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(50; Skip; Boolean)
        {
            // cleaned
        }
        field(70; "ILE OnHand"; Decimal)
        {
            Editable = false;
        }
        field(71; "Whse OnHand"; Decimal)
        {
            Editable = false;
        }
        field(72; "Total Adjmt. Qty"; Decimal)
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Location Code", "Item No.", "Lot No.")
        {
            SumIndexFields = "Adjmt. Qty";
        }
    }
}
