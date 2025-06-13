table 50007 "NIF Cross Reference"
{
    fields
    {
        field(1;"Entry No.";Integer)
        {
            // cleaned
        }
        field(10;Type;Option)
        {
            OptionCaption = ' ,Customer,Vendor,Item,Location';
            OptionMembers = " ",Customer,Vendor,Item,Location;
        }
        field(20;"Orig. No.";Code[30])
        {
            // cleaned
        }
        field(30;"Navision No.";Code[20])
        {
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(40;Name;Text[80])
        {
            // cleaned
        }
        field(50;"Location Code";Code[20])
        {
            // cleaned
        }
        field(57;"Bin Code";Code[20])
        {
            // cleaned
        }
        field(60;"Currency Code";Code[10])
        {
            // cleaned
        }
        field(62;"Revision No.";Code[20])
        {
            // cleaned
        }
        field(63;"Active Revision";Boolean)
        {
            // cleaned
        }
        field(100;"Possible Duplicate";Boolean)
        {
            // cleaned
        }
        field(110;"NIF Alt. No.";Code[30])
        {
            // cleaned
        }
        field(900;"Base No.";Code[20])
        {
            // cleaned
        }
        field(910;StrippedNo;Code[30])
        {
            // cleaned
        }
        field(950;"Exceeds Length";Boolean)
        {
            // cleaned
        }
    }
}
