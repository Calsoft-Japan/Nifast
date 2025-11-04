table 50003 "Certifcation Results"
{
    DrillDownPageID = 50010;
    LookupPageID = 50010;

    fields
    {
        field(10; "Lot No."; Code[20])
        {
            NotBlank = true;
        }
        field(20; "Item No."; Code[20])
        {
            NotBlank = true;
        }
        field(30; "Line No."; Integer)
        {
            NotBlank = true;
        }
        field(40; "Certification No."; Code[20])
        {
            NotBlank = true;
        }
        field(50; "Certification Type"; Option)
        {
            OptionMembers = " ",Internal,Vendor,Manufacturer;
        }
        field(55; "Certification Scope"; Option)
        {
            OptionMembers = " ","Visual Only",Sample,Full;
        }
        field(60; "Passed Certification"; Boolean)
        {
            // cleaned
        }
        field(70; "Certification Comments"; Text[100])
        {
            // cleaned
        }
        field(80; "Quantity Tested"; Decimal)
        {
            // cleaned
        }
        field(90; "Tested By"; Code[10])
        {
            // cleaned
        }
        field(100; "Tested Date"; Date)
        {
            // cleaned
        }
        field(110; "Tested Time"; Time)
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; "Lot No.", "Item No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}
