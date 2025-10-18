table 90003 "Table Import Init Value"
{
    DataPerCompany = false;
    fields
    {
        field(1; "Table Import Code"; Code[10])
        {
            // cleaned
            TableRelation = "Table Import";
        }
        field(2; "Navision Field No."; Integer)
        {
            NotBlank = true;
        }
        field(3; Value; Text[250])
        {
            // cleaned
           TableRelation = IF (Type=CONST("No. Serie")) "No. Series";
        }
        field(4; "Validate Field"; Boolean)
        {
            InitValue = true;
        }
        field(5; Type; Option)
        {
            OptionMembers = " ","No. Serie";
        }
        field(6; "Special Table Customer"; Option)
        {
            OptionMembers = " ","Ship-To Address";
        }
        field(7; "Special Table Vendor"; Option)
        {
            OptionMembers = " ","Order Address";
        }
        field(8; Sequence; Integer)
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; "Table Import Code", "Special Table Customer", "Special Table Vendor", "Navision Field No.")
        {
        }
        key(Key2; Sequence)
        {
        }
    }

    fieldgroups
    {
    }

    var
      /*   TableImport: Record 90000;
        "Field": Record 2000000041; */

    procedure TableNo(): Integer
    begin
    end;
}
