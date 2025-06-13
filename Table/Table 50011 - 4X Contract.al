table 50011 "4X Contract"
{
    fields
    {
        field(1; "No."; Code[20])
        {

        }
        field(2; "No. Series"; Code[10])
        {
            // cleaned
        }
        field(3; "Contract Note No."; Code[20])
        {

            //<< NIF 07-22-05 RTT
        }
        field(4; Closed; Boolean)
        {
            // cleaned
        }
        field(5; "Date Created"; Date)
        {
            // cleaned
        }
        field(6; "Division Code"; Code[10])
        {
            // cleaned
        }
        field(7; Total; Decimal)
        {
            // cleaned
        }
        field(8; "Requested By"; Code[10])
        {
            // cleaned
        }
        field(9; "Authorized By"; Code[10])
        {

            // MESSAGE('Purchase Order Lines Updated with Contract Note No. %1', "Contract Note No.");
        }
        field(10; "Foreign Exchange Requested"; Date)
        {
            // cleaned
        }
        field(11; "Window From"; Date)
        {
            // cleaned
        }
        field(12; "Window To"; Date)
        {
            // cleaned
        }
        field(13; Posted; Boolean)
        {
            // cleaned
        }
    }
}
