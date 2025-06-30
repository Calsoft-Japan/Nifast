table 50027 "Forecast Ledger Entry"
{
    fields
    {
        field(1; "Item No."; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Enter Date"; Date)
        {
            // cleaned
        }
        field(3; "Forecast Quantity"; Decimal)
        {
            BlankNumbers = BlankZero;
            BlankZero = false;
            NotBlank = true;
        }
        field(4; "Customer No."; Code[20])
        {
            NotBlank = true;
        }
        field(5; Description; Text[50])
        {
            // cleaned
        }
        field(6; "Shipping Date"; Date)
        {
            BlankNumbers = DontBlank;
            NotBlank = true;
        }
        field(7; "Pieces Per Vehicle"; Integer)
        {
            // cleaned
        }
        field(8; SOP; Date)
        {
            // cleaned
        }
        field(9; EOP; Date)
        {
            // cleaned
        }
        field(10; Model; Code[10])
        {
            // cleaned
        }
        field(11; OEM; Code[10])
        {
            // cleaned
        }
        field(12; Remark; Text[30])
        {
            // cleaned
        }
        field(13; "Entry No."; Integer)
        {
            AutoFormatType = 1;
            AutoIncrement = true;
        }
        field(14; "Division Code"; Code[10])
        {
            // cleaned
        }
        field(15; "Nifast Forecast"; Boolean)
        {
            // cleaned
        }
        field(16; "Flow Item"; Code[20])
        {
            // cleaned
        }
        field(17; "Flow Forecast on/off"; Boolean)
        {
            // cleaned
        }
        field(18; "Flow MPD Item"; Boolean)
        {
            // cleaned
        }
        field(19; "Flow MPD Forecast"; Boolean)
        {
            // cleaned
        }
        field(20; "Cross Ref. No."; Code[30])
        {
            // cleaned
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(RPTSort; "Customer No.", "Division Code")
        { }
    }
}
