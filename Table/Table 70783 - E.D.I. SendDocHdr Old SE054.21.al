table 70783 "E.D.I. SendDocHdr Old SE054.21"
{
    fields
    {
        field(1;"Internal Doc No.";Code[10])
        {
            Caption = 'Internal Doc No.';
            Editable = false;
        }
        field(2;"Navision Document";Code[10])
        {
            Caption = 'Navision Document';
            Editable = false;
        }
        field(3;"Document No.";Code[20])
        {
            Caption = 'Document No.';
            Editable = false;
        }
        field(4;Version;Integer)
        {
            Caption = 'Version';
            Editable = false;
        }
        field(11;"Trade Partner No.";Code[20])
        {
            Caption = 'Trade Partner No.';
            Editable = false;
        }
        field(12;"EDI Document No.";Code[6])
        {
            Caption = 'EDI Document No.';
            Editable = false;
        }
        field(13;"EDI Version";Code[10])
        {
            Caption = 'EDI Version';
            Editable = false;
        }
        field(14;"EDI Template Name";Code[10])
        {
            Caption = 'EDI Template Name';
            Editable = false;
        }
        field(15;"Interchange Control No.";Text[30])
        {
            Caption = 'Interchange Control No.';
            Editable = false;
        }
        field(16;"Group Control No.";Text[30])
        {
            Caption = 'Group Control No.';
            Editable = false;
        }
        field(17;"Transaction Set Control No.";Text[30])
        {
            Caption = 'Transaction Set Control No.';
            Editable = false;
        }
        field(18;"EDI Trade Partner Name";Text[40])
        {
            Caption = 'EDI Trade Partner Name';
            Editable = false;
        }
        field(19;"Funct. Ack. Required";Boolean)
        {
            Caption = 'Funct. Ack. Required';
            Editable = false;
        }
        field(20;"Funct. Group Ack. Status";Option)
        {
            Caption = 'Funct. Group Ack. Status';
            Editable = false;
            OptionCaption = ' ,Accepted,Accepted Errors,Part Accepted,Rejected';
            OptionMembers = " ",Accepted,"Accepted Errors","Part Accepted",Rejected;
        }
        field(21;"Tran. Set Funct. Ack. Status";Option)
        {
            Caption = 'Tran. Set Funct. Ack. Status';
            Editable = false;
            OptionCaption = ' ,Accepted,Accepted Errors,Part Accepted,Rejected';
            OptionMembers = " ",Accepted,"Accepted Errors","Part Accepted",Rejected;
        }
        field(22;"Data Error";Boolean)
        {
            Caption = 'Data Error';
            Editable = false;
        }
        field(23;"Created Date";Date)
        {
            Caption = 'Created Date';
            Editable = false;
        }
        field(24;"Created Time";Time)
        {
            Caption = 'Created Time';
            Editable = false;
        }
        field(25;"Sent Date";Date)
        {
            Caption = 'Sent Date';
            Editable = false;
        }
        field(26;"Sent Time";Time)
        {
            Caption = 'Sent Time';
            Editable = false;
        }
        field(27;"Document Sent";Boolean)
        {
            Caption = 'Document Sent';
        }
        field(28;"Funct. Ack. Internal Doc. No.";Code[10])
        {
            Caption = 'Funct. Ack. Internal Doc. No.';
        }
    }
}
