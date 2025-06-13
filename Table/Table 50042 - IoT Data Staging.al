table 50042 "IoT Data Staging"
{
    fields
    {
        field(1;"Entry No.";Integer)
        {
            AutoIncrement = true;
            Description = 'PK';
        }
        field(2;"Document Type";Option)
        {
            OptionCaption = ' ,Invt. Pick,Trans. Rcpt.,Sales Ship';
            OptionMembers = " ","Invt. Pick","Trans. Rcpt.","Sales Ship";
        }
        field(3;"Document No.";Code[20])
        {
            Description = 'Whse. Activity Tbl No. field';
        }
        field(4;"Line No.";Integer)
        {
            Description = 'Whse. Activity Tbl Line No. field';
        }
        field(5;"Table No.";Integer)
        {
            // cleaned
        }
        field(6;"Item No.";Code[20])
        {
            // cleaned
        }
        field(7;"Lot No.";Code[20])
        {
            // cleaned
        }
        field(8;Quantity;Decimal)
        {
            Description = 'In Boxes';
        }
        field(9;"Location From";Code[20])
        {
            // cleaned
        }
        field(10;"Location To";Code[20])
        {
            // cleaned
        }
        field(11;"RFID Gate No.";Code[10])
        {
            // cleaned
        }
        field(20;"Record Status";Option)
        {
            OptionCaption = 'Pending,Error,Processed';
            OptionMembers = Pending,Error,Processed;
            
        }
        field(21;"Email Notification Sent";Boolean)
        {
            // cleaned
        }
        field(22;"Email Recipients";Text[150])
        {
            // cleaned
        }
        field(23;"Resend Email Notfication";Boolean)
        {
            // cleaned
        }
        field(24;"Error Message";Text[250])
        {
            // cleaned
        }
        field(25;"Email Notifications Sent On";DateTime)
        {
            // cleaned
        }
        field(26;"Email Notifications Sent On 2";DateTime)
        {
            // cleaned
        }
        field(27;"Date Processed On";Date)
        {
            // cleaned
        }
        field(28;"Output Document Type";Option)
        {
            Description = ' ,Sales Order,Invt. Pick';
            OptionCaption = ' ,Sales Order,Invt. Pick';
            OptionMembers = " ","Sales Order","Invt. Pick";
        }
        field(29;"Output Document No.";Code[20])
        {
            // cleaned
        }
        field(30;"Output Invt. Pick Type";Option)
        {
            Description = 'Invt. Pick';
            OptionCaption = ' ,Sales Order,Invt. Pick';
            OptionMembers = " ","Sales Order","Invt. Pick";
        }
        field(31;"Output Pick No.";Code[20])
        {
            // cleaned
        }
        field(32;"File Name";Text[250])
        {
            // cleaned
        }
        field(33;"Date Imported";Date)
        {
            // cleaned
        }
    }
}
