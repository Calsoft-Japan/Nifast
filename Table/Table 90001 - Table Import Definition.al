table 90001 "Table Import Definition"
{
    fields
    {
        field(1;"Table Import Code";Code[10])
        {
            // cleaned
        }
        field(2;"File Field No.";Integer)
        {
            InitValue = 1;
            MinValue = 1;
        }
        field(4;"Field Name";Text[50])
        {
            // cleaned
        }
        field(5;Type;Option)
        {
            OptionMembers = Text,Decimal;
        }
        field(6;Title;Boolean)
        {
            // cleaned
        }
        field(7;"Special Import Customer";Option)
        {
            OptionMembers = " ",Comment,"Ship-to Address","Address (City State Zip)","Ship-to Address (City State Zip)";
        }
        field(8;Startpos;Integer)
        {
            // cleaned
        }
        field(9;Length;Integer)
        {
            // cleaned
        }
        field(10;Endpos;Integer)
        {
            // cleaned
        }
        field(11;"Navision Fieldno.";Integer)
        {
            BlankZero = true;
        }
        field(12;"Call Field Validate";Boolean)
        {
            InitValue = true;
        }
        field(13;"Special Import Vendor";Option)
        {
            OptionMembers = " ",Comment,"Order Address","Address (City State Zip)","Order Address (City State Zip)";
        }
        field(14;"Special Import Item";Option)
        {
            OptionMembers = " ",Comment;
        }
        field(15;"Special Import Gen. Journal";Option)
        {
            OptionMembers = " ","Find Customer or Vendor with Name","Find Customer or Vendor with Old No";
        }
        field(16;Value;Text[250])
        {
            // cleaned
        }
        field(17;Calculation;Boolean)
        {
            // cleaned
        }
        field(18;"Dont insert if blank";Boolean)
        {
            // cleaned
        }
        field(19;"Date Format";Option)
        {
            OptionMembers = " ",YYYYMMDD,"YYYY-MM-DD";
        }
        field(20;"Add Another Decimal Field";Boolean)
        {
            // cleaned
        }
        field(21;"Other Decimal Field";Integer)
        {
            // cleaned
        }
        field(22;"Strip Alpha Characters";Boolean)
        {
            // cleaned
        }
    }
}
