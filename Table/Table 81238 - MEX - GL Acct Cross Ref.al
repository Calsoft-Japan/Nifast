table 81238 "MEX - G/L Acct Cross Ref"
{
    fields
    {
        field(1;"Old Acct No.";Code[30])
        {
            // cleaned
        }
        field(2;Name;Text[80])
        {
            // cleaned
        }
        field(3;"Navision Acct. No.";Code[20])
        {
            // cleaned
        }
        field(10;"Navision Acct. Exists";Boolean)
        {
            Editable = false;
        }
        field(11;"Navision Account Type";Option)
        {
            Caption = 'Account Type';
            Editable = false;
            OptionCaption = 'Posting,Heading,Total,Begin-Total,End-Total';
            OptionMembers = Posting,Heading,Total,"Begin-Total","End-Total";
            
        }
        field(12;"Navision Account Name";Text[50])
        {
            Editable = false;
        }
        field(20;Seg1;Code[10])
        {
            // cleaned
        }
        field(21;Seg2;Code[10])
        {
            // cleaned
        }
        field(22;Seg3;Code[10])
        {
            // cleaned
        }
        field(50;Comment;Text[30])
        {
            // cleaned
        }
    }
}
