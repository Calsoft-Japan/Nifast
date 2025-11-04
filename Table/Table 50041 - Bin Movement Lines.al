table 50041 "Bin Movement Lines"
{
    // NF2.00:CIS.RAM 02/22/17 Created to store data related to Bin movements

    fields
    {
        field(1; "From Location"; Code[20])
        {
            // cleaned
        }
        field(2; "From Bin"; Code[20])
        {
            // cleaned
        }
        field(3; "Item Lot No."; Code[20])
        {
            // cleaned
        }
        field(4; Bins; Code[20])
        {
            // cleaned
        }
        field(5; Quantity; Decimal)
        {
            // cleaned
        }
        field(6; UOM; Code[20])
        {
            // cleaned
        }
        field(7; "Location Code"; Code[20])
        {
            // cleaned
        }
        field(8; "Line No."; Integer)
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; "From Location", "From Bin", "Item Lot No.", "Line No.")
        {
        }
    }
}
