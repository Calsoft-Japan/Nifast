table 50005 "Label Fields"
{
    LookupPageID = 50050;
    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            // cleaned
        }
        field(7; "Data Type"; Option)
        {
            OptionMembers = "Integer",Text,"Code",Decimal,Option,Boolean,Date,Time;
        }
        field(12; "Test Print Value"; Text[50])
        {
            // cleaned
        }
        field(50; Receive; Boolean)
        {
            // cleaned
        }
        field(52; "Receive Line"; Boolean)
        {
            // cleaned
        }
        field(55; Package; Boolean)
        {
            // cleaned
        }
        field(57; "Package Line"; Boolean)
        {
            // cleaned
        }
        field(60; Item; Boolean)
        {
            // cleaned
        }
        field(61; Customer; Boolean)
        {
            // cleaned
        }
        field(65; Resource; Boolean)
        {
            // cleaned
        }
        field(70; "Contract Line"; Boolean)
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
}
