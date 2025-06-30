table 50029 "Vehicle Production"
{
    fields
    {
        field(1; "Customer No."; Code[20])
        {
            // cleaned
        }
        field(2; "Item No."; Code[20])
        {
            // cleaned
        }
        field(3; Model; Code[50])
        {
            // cleaned
        }
        field(4; "EC Level"; Code[30])
        {
            // cleaned
        }
        field(5; "Applicable Std"; Text[50])
        {
            // cleaned
        }
        field(6; EMU; Decimal)
        {
            // cleaned
        }
        field(7; OEM; Code[20])
        {
            // cleaned
        }
        field(8; "Final Customer"; Text[30])
        {
            // cleaned
        }
        field(9; "Pieces Per Vehicle"; Decimal)
        {
            // cleaned
        }
        field(10; Per; Text[30])
        {
            // cleaned
        }
        field(11; SOP; Date)
        {
            // cleaned
        }
        field(12; EOP; Date)
        {
            // cleaned
        }
        field(13; Remarks; Text[250])
        {
            // cleaned
        }
        field(14; SNP; Decimal)
        {
            // cleaned
        }
        field(15; Manufacturer; Code[50])
        {
            // cleaned
        }
        field(16; "Customer Name"; Text[100])
        {
            // cleaned
        }
        field(17; "Cross Reference No."; Code[30])
        {
            // cleaned
        }
        field(18; "Flow Item"; Code[20])
        {
            // cleaned
        }
        field(19; "Div Code"; Code[20])
        {
            // cleaned
        }
        field(20; Active; Boolean)
        {
            // cleaned
        }
        field(21; Selling; Decimal)
        {
            // cleaned
        }
        field(22; Buying; Decimal)
        {
            // cleaned
        }
        field(23; "Vendor No."; Code[20])
        {
            // cleaned
        }
        field(24; "Vendor Name"; Text[50])
        {
            // cleaned
        }
        field(25; "Remark-2"; Text[250])
        {
            // cleaned
        }
        field(26; "PPAP Approved"; Boolean)
        {
            // cleaned
        }
        field(27; "Revision No."; Code[20])
        {
            // cleaned
        }
        field(28; "PPAP Approved Date"; Date)
        {
            // cleaned
        }
    }

    keys
    {
        key(PK; "Customer No.", "Item No.", Model, EMU, Per)
        {
            Clustered = true;
        }
        key(RPTSort; "Customer No.", "Active", "Item No.", Model, "EMU", "Per")
        { }
    }
}
