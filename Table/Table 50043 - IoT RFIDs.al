table 50043 "IoT RFIDs"
{
    // CIS.IoT 07/22/22 RAM Created new Object

    fields
    {
        field(1; RFID; Code[10])
        {
            // cleaned
        }
        field(2; "Location Code"; Code[20])
        {
            // cleaned
        }
        field(3; "Customer Code"; Code[20])
        {
            // cleaned
        }
        field(4; Description; Text[30])
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; RFID)
        {
        }
        key(Key2; "Location Code")
        {
        }
    }

    fieldgroups
    {
    }
}
