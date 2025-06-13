table 50142 "Cust./Item Drawing2"
{
    fields
    {
        field(1;"Item No.";Code[20])
        {
            // cleaned
        }
        field(2;"Customer No.";Code[20])
        {
            // cleaned
        }
        field(3;"Drawing No.";Code[30])
        {
            // cleaned
        }
        field(4;"Revision No.";Code[20])
        {
            NotBlank = true;
        }
        field(5;"Revision Date";Date)
        {
            // cleaned
        }
        field(6;Active;Boolean)
        {
            
        }
        field(7;"Drawing Type";Option)
        {
            OptionMembers = " ",Customer,Internal,Supplier,"None","Standard Part";
        }
        field(10;Components;Boolean)
        {
            Editable = false;
        }
        field(11;"PPAP Approval";Boolean)
        {
            // cleaned
        }
        field(12;"First Article Approval";Boolean)
        {
            // cleaned
        }
        field(13;"First Article Waiver";Boolean)
        {
            // cleaned
        }
    }
}
