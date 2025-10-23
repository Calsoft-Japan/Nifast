table 60001 "Invalid Vendor PO"
{
    fields
    {
        field(1; "Location Code"; Code[10])
        {
            // cleaned
        }
        field(2; "Order No"; Code[20])
        {
            // cleaned
        }
        field(3; "Vendor No."; Code[20])
        {
            // cleaned
        }
        field(4; "Vendor Name"; Text[50])
        {
            // cleaned
        }
        field(5; Addr1; Text[50])
        {
            // cleaned
        }
        field(6; Addr2; Text[50])
        {
            // cleaned
        }
        field(7; Addr3; Text[50])
        {
            // cleaned
        }
        field(8; CityStateZip; Text[100])
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; "Location Code", "Order No")
        {
        }
    }

    fieldgroups
    {
    }
}
