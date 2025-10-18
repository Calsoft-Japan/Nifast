table 61275 "Prod. Kit Variance"
{
    fields
    {
        field(1; "Production Kit No."; Code[20])
        {
            // cleaned
        }
        field(2; "Entry No."; Integer)
        {
            // cleaned
        }
        field(3; "Parent Cost (Actual)"; Decimal)
        {
            DecimalPlaces = 5 : 5;
        }
        field(4; "Component Cost"; Decimal)
        {
            DecimalPlaces = 5 : 5;
        }
        field(5; "Labor Cost"; Decimal)
        {
            DecimalPlaces = 5 : 5;
        }
        field(6; Variance; Decimal)
        {
            DecimalPlaces = 5 : 5;
        }
        field(7; "Parent Cost (Calc.)"; Decimal)
        {
            DecimalPlaces = 5 : 5;
        }
        field(10; "No. of Lots"; Integer)
        {
            // cleaned
        }
        field(11; "Lot No."; Code[20])
        {
            // cleaned
        }
        field(12; "Lot Qty. on Hand"; Decimal)
        {
            // cleaned
        }
        field(13; "Item No."; Code[20])
        {
            // cleaned
        }
        field(14; "Item Description"; Text[50])
        {
            // cleaned
        }
        field(20; "2004 Sales Qty."; Decimal)
        {
            // cleaned
        }
        field(21; "2005 Sales Qty."; Decimal)
        {
            // cleaned
        }
        field(22; "2006 Sales Qty."; Decimal)
        {
            // cleaned
        }
        field(30; "Posting Date"; Date)
        {
            // cleaned
        }
        field(40; "Parent Qty."; Decimal)
        {
            // cleaned
        }
        field(45; "Parent Unit Cost (Actual)"; Decimal)
        {
            DecimalPlaces = 5 : 5;
        }
        field(46; "Parent Unit Cost (Calc)"; Decimal)
        {
            DecimalPlaces = 5 : 5;
        }
        field(47; "Parent Unit Cost (Variance)"; Decimal)
        {
            DecimalPlaces = 5 : 5;
        }
    }
    keys
    {
        key(Key1; "Production Kit No.", "Entry No.", "Lot No.")
        {
        }
    }

    fieldgroups
    {
    }
}
