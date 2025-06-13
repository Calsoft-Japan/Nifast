table 50013 "Delivery Schedule Line"
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
        field(3;"Document No.";Code[20])
        {
            // cleaned
        }
        field(4;"Line No.";Integer)
        {
            // cleaned
        }
        field(10;Type;Option)
        {
            OptionMembers = " ",Firm,"Commitment for Manufacturing","Commitment for Material",Planning;
        }
        field(11;Frequency;Option)
        {
            OptionMembers = " ",Weekly,Flexible;
        }
        field(12;"Forecast Quantity";Decimal)
        {
            // cleaned
        }
        field(13;"Expected Delivery Date";Date)
        {
            // cleaned
        }
        field(14;"Start Date";Date)
        {
            // cleaned
        }
        field(15;"End Date";Date)
        {
            // cleaned
        }
        field(1010;"Type Code";Integer)
        {
            
        }
        field(1011;"Frequency Code";Text[10])
        {
            
        }
        field(1012;"Forecast Unit of Measure";Text[10])
        {
            // cleaned
        }
        field(50000;"Item No.";Code[20])
        {
            // cleaned
        }
        field(50001;"Model Year";Code[10])
        {
            // cleaned
        }
    }
}
