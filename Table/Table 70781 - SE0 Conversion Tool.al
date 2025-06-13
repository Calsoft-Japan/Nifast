table 70781 "SE0 Conversion Tool"
{
    fields
    {
        field(1;"Entry No.";Integer)
        {
            Caption = 'Entry No.';
        }
        field(2;"Tool Name";Code[30])
        {
            Caption = 'Tool Name';
        }
        field(3;"Action";Option)
        {
            Caption = 'Action';
            OptionCaption = 'Start,Finish';
            OptionMembers = Start,Finish;
        }
        field(4;"Modified By";Text[30])
        {
            Caption = 'Modified By';
        }
        field(5;"Date Modified";Date)
        {
            Caption = 'Date Modified';
        }
        field(6;"Time Modified";Time)
        {
            Caption = 'Time Modified';
        }
        field(7;"Company Name";Text[100])
        {
            Caption = 'Company Name';
        }
        field(8;Nav2013;Boolean)
        {
            // cleaned
        }
    }
}
