table 50045 "IoT File Import Log"
{
    fields
    {
        field(1;"Entry No.";Integer)
        {
            AutoIncrement = true;
        }
        field(2;"File Name";Text[250])
        {
            // cleaned
        }
        field(3;"Import Date";Date)
        {
            // cleaned
        }
        field(4;"Import Time";Time)
        {
            // cleaned
        }
        field(5;"Import By";Code[25])
        {
            // cleaned
        }
        field(6;Status;Option)
        {
            OptionCaption = 'Success,Error';
            OptionMembers = Success,Error;
        }
        field(7;"Document Type";Option)
        {
            OptionCaption = ' ,Invt. Pick,Trans. Rcpt.,Sales Ship';
            OptionMembers = " ","Invt. Pick","Trans. Rcpt.","Sales Ship";
        }
        field(8;"Error Text";Text[250])
        {
            // cleaned
        }
        field(9;"Email Notification Sent";Boolean)
        {
            // cleaned
        }
        field(10;"Email Recipients";Text[150])
        {
            // cleaned
        }
        field(11;"Resend Email Notfication";Boolean)
        {
            // cleaned
        }
        field(12;"Email Notifications Sent On";DateTime)
        {
            // cleaned
        }
        field(13;"Email Notifications Sent On 2";DateTime)
        {
            // cleaned
        }
        field(14;"Date Processed On";Date)
        {
            // cleaned
        }
    }
}
