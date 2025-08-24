table 50139 "FB Import Dataport"
{
    fields
    {
        field(10; "Customer No."; Code[20])
        {
            // cleaned
        }
        field(15; "Ship-to Code"; Code[10])
        {
            // cleaned
        }
        field(20; "Location Code"; Code[10])
        {
            // cleaned
        }
        field(25; "Dataport ID"; Integer)
        {

        }
        field(30; "Import File Path"; Code[200])
        {
            // cleaned
        }
        field(40; Description; Text[50])
        {
            // cleaned
        }
        field(100; "User ID"; Code[50])
        {
            Description = '20-->50 NF1.00:CIS.NG  10-10-15';
            //This property is currently not supported
            //TestTableRelation = false;


        }
        field(110; TempFileName; Code[250])
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; "Customer No.", "Ship-to Code", "Location Code", "Dataport ID")
        {
        }
        key(Key2; "User ID")
        {
        }
    }
}
