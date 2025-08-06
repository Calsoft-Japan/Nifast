tableextension 50313 "Inventory Setup Ext" extends "Inventory Setup"
{
    fields
    {
        field(50000; "Def. Item Tracking Code"; Code[10])
        {
            // cleaned
            TableRelation = "Item Tracking Code";
        }
        field(50001; "Def. E-ship Tracking Code"; Code[10])
        {
            // cleaned

        }
        field(50002; "Def. Lot Nos."; Code[10])
        {
            // cleaned
            TableRelation = "No. Series";
        }
        field(50010; "Auto. Transfer Order Nos."; Code[10])
        {
            // cleaned
            TableRelation = "No. Series";
        }
        field(50020; "Default In-Transit Location"; Code[10])
        {
            // cleaned
            TableRelation = Location;
        }
        field(50021; "IoT Admin. Email"; Text[80])
        {
            Description = 'CIS.IoT';
        }
        field(50022; "IoT Admin. CC Email"; Text[80])
        {
            Description = 'CIS.IoT';
        }
        field(50023; "Invt. Pick File Path"; Text[80])
        {
            Description = 'CIS.IoT';
        }
        field(50024; "Tras. Rcpt. File Path"; Text[80])
        {
            Description = 'CIS.IoT';
        }
        field(50025; "Sales Ship. File Path"; Text[80])
        {
            Description = 'CIS.IoT';
        }
        field(50026; "Delete IoT File on Success"; Boolean)
        {
            Description = 'CIS.IoT';
        }
        field(50027; "Send Email Notifications"; Boolean)
        {
            Description = 'CIS.IoT';
        }
        field(50028; "IoT Trans. Order Email"; Text[80])
        {
            Description = 'CIS.IoT';
        }
        field(50029; "IoT Trans Order CC Email"; Text[80])
        {
            Description = 'CIS.IoT';
        }
        field(50030; "IoT Sales Email"; Text[80])
        {
            Description = 'CIS.IoT';
        }
        field(50031; "IoT Sales CC Email"; Text[80])
        {
            Description = 'CIS.IoT';
        }
        field(50032; "Send Email CC to Admin"; Boolean)
        {
            Description = 'CIS.IoT';
        }
        field(50033; "IoT Create Invt. Pick"; Boolean)
        {
            Description = 'CIS.IoT';
        }
    }
}
