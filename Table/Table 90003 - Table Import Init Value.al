table 90003 "Table Import Init Value"
{
    fields
    {
        field(1;"Table Import Code";Code[10])
        {
            // cleaned
        }
        field(2;"Navision Field No.";Integer)
        {
            NotBlank = true;
        }
        field(3;Value;Text[250])
        {
            // cleaned
        }
        field(4;"Validate Field";Boolean)
        {
            InitValue = true;
        }
        field(5;Type;Option)
        {
            OptionMembers = " ","No. Serie";
        }
        field(6;"Special Table Customer";Option)
        {
            OptionMembers = " ","Ship-To Address";
        }
        field(7;"Special Table Vendor";Option)
        {
            OptionMembers = " ","Order Address";
        }
        field(8;Sequence;Integer)
        {
            // cleaned
        }
    }
}
