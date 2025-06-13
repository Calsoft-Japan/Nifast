table 50012 "Delivery Schedule Header"
{
    fields
    {
        field(1;"Delivery Schedule Batch No.";Code[20])
        {
            // cleaned
        }
        field(2;"Customer No.";Code[20])
        {
            // cleaned
        }
        field(3;"No.";Code[20])
        {
            // cleaned
        }
        field(10;"Item No.";Code[20])
        {
            
        }
        field(11;"Cross-Reference No.";Code[30])
        {
            Caption = 'Cross-Reference No.';
            
            
        }
        field(12;"Cross-Reference Type";Option)
        {
            Caption = 'Cross-Reference Type';
            OptionCaption = ' ,Customer,Vendor,Bar Code';
            OptionMembers = " ",Customer,Vendor,"Bar Code";
        }
        field(13;"Cross-Reference Type No.";Code[30])
        {
            Caption = 'Cross-Reference Type No.';
        }
        field(14;"Location Code";Code[20])
        {
            // cleaned
        }
        field(15;"Model Year";Code[10])
        {
            // cleaned
        }
        field(16;"Release Number";Code[10])
        {
            // cleaned
        }
        field(17;"Receiving Dock Code";Code[10])
        {
            // cleaned
        }
        field(18;"Stockman Code";Code[10])
        {
            // cleaned
        }
        field(19;"Order Reference No.";Code[20])
        {
            // cleaned
        }
        field(20;"Quantity CYTD";Integer)
        {
            // cleaned
        }
        field(21;"Unit of Measure CYTD";Text[10])
        {
            // cleaned
        }
        field(22;"Start Date CYTD";Date)
        {
            // cleaned
        }
        field(23;"End Date CYTD";Date)
        {
            // cleaned
        }
        field(24;"Quantity Shipped CYTD";Integer)
        {
            // cleaned
        }
        field(25;"Unit of Measure Shipped CYTD";Text[10])
        {
            // cleaned
        }
        field(26;"Start Date Shipped CYTD";Date)
        {
            // cleaned
        }
        field(27;"End Date Shipped CYTD";Date)
        {
            // cleaned
        }
        field(28;Description;Text[50])
        {
            // cleaned
        }
        field(200;"No. Series";Code[10])
        {
            // cleaned
        }
        field(5000;"EDI Item Cross Ref.";Code[20])
        {
            // cleaned
        }
        field(5001;"EDI Unit of Measure";Code[2])
        {
            // cleaned
        }
        field(5002;"Item Not Found";Boolean)
        {
            Editable = false;
        }
        field(5003;"Cross-Reference No. Not Found";Boolean)
        {
            Editable = false;
        }
    }
}
