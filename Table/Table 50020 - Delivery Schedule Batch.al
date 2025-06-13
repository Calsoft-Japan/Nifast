table 50020 "Delivery Schedule Batch"
{
    fields
    {
        field(1;"No.";Code[20])
        {
            // cleaned
        }
        field(2;"Customer No.";Code[20])
        {
            // cleaned
        }
        field(10;"Release No.";Code[20])
        {
            // cleaned
        }
        field(11;"Document Function";Option)
        {
            OptionMembers = " ",Replacing,Original;
        }
        field(12;"Expected Delivery Date";Date)
        {
            // cleaned
        }
        field(13;"Horizon Start Date";Date)
        {
            // cleaned
        }
        field(14;"Horizon End Date";Date)
        {
            // cleaned
        }
        field(20;"Material Issuer No.";Code[20])
        {
            // cleaned
        }
        field(21;"Material Issuer Name";Text[50])
        {
            // cleaned
        }
        field(22;"Material Issuer Name 2";Text[50])
        {
            // cleaned
        }
        field(23;"Material Issuer Address";Text[30])
        {
            // cleaned
        }
        field(24;"Material Issuer Address 2";Text[30])
        {
            // cleaned
        }
        field(25;"Material Issuer City";Text[30])
        {
            // cleaned
        }
        field(26;"Material Issuer State";Text[30])
        {
            // cleaned
        }
        field(27;"Material Issuer Postal Code";Code[20])
        {
            // cleaned
        }
        field(28;"Material Issuer Country Code";Text[30])
        {
            // cleaned
        }
        field(30;"Supplier No.";Code[20])
        {
            // cleaned
        }
        field(31;"Supplier Name";Text[50])
        {
            // cleaned
        }
        field(32;"Supplier Name 2";Text[50])
        {
            // cleaned
        }
        field(33;"Supplier Address";Text[30])
        {
            // cleaned
        }
        field(34;"Supplier Address 2";Text[30])
        {
            // cleaned
        }
        field(35;"Supplier City";Text[30])
        {
            // cleaned
        }
        field(36;"Supplier State";Text[30])
        {
            // cleaned
        }
        field(37;"Supplier Postal Code";Code[20])
        {
            // cleaned
        }
        field(38;"Supplier Country Code";Text[30])
        {
            // cleaned
        }
        field(200;"No. Series";Code[10])
        {
            // cleaned
        }
        field(1011;"Document Function Code";Integer)
        {
            
        }
        field(50000;"EDI Trade Partner";Code[20])
        {
            // cleaned
        }
        field(50010;"EDI Internal Doc. No.";Code[10])
        {
            // cleaned
        }
        field(50020;"Model Year";Code[10])
        {
            Description = 'Delivery Schedule Batch No.=FIELD(No.)';
        }
    }
}
