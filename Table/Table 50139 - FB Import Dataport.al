table 50139 "FB Import Dataport"
{
    // NF1.00:CIS.NG    09/30/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)
    // NF1.00:CIS.NG    10/10/15 Fix the Table Relation Property for fields (Remove the relationship for non exists table)
    // rtt 12-13-05 set Customer No. to NotBlank=No

    DrillDownPageID = 50141;
    LookupPageID = 50141;
    fields
    {
        field(10; "Customer No."; Code[20])
        {
            // cleaned
            TableRelation = Customer;
        }
        field(15; "Ship-to Code"; Code[10])
        {
            // cleaned
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("Customer No."));
        }
        field(20; "Location Code"; Code[10])
        {
            // cleaned
             
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false),
                                              "Rework Location" = CONST(false));
             
        }
        field(25; "Dataport ID"; Integer)
        {
            TableRelation = AllObj."Object ID" WHERE("Object Type" = CONST(XMLport));

            trigger OnLookup()
            begin
                Object.RESET();
                Object.SETRANGE("Object Type", Object."Object Type"::XMLport);
                // Object.SETRANGE("Company Name", '');
                Object.SETRANGE("Object Name", '');
                IF PAGE.RUNMODAL(PAGE::Objects, Object) = ACTION::LookupOK THEN BEGIN
                    "Dataport ID" := Object."Object ID";
                    Description := Object."Object Name";
                END;
            end;
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
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            var
                LoginMgt: Codeunit 418;
            begin
                LoginMgt.LookupUserID("User ID");
            end;

            trigger OnValidate()
            var
                LoginMgt: Codeunit 418;
            begin  
                LoginMgt.ValidateUserID("User ID");
            end;



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

    fieldgroups
    {
    }

    var
        "Object": Record AllObj;
    //  Objects: Page 358;
}
