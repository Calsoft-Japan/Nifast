table 50040 "Cust./Item Drawing Comp"
{
    fields
    {
        field(1;"Parent Item No.";Code[20])
        {
            // cleaned
        }
        field(2;"Parent Customer No.";Code[20])
        {
            // cleaned
        }
        field(3;"Parent Drawing No.";Code[30])
        {
            NotBlank = true;
        }
        field(4;"Parent Revision No.";Code[20])
        {
            // cleaned
        }
        field(10;"Drawing No.";Code[30])
        {
            NotBlank = true;
        }
        field(20;"Revision No.";Code[20])
        {
            // cleaned
        }
        field(30;"Revision Date";Date)
        {
            // cleaned
        }
        field(35;Description;Text[50])
        {
            // cleaned
        }
        field(38;"Drawing Type";Option)
        {
            OptionMembers = " ",Customer,Internal,Supplier,"None","Standard Part";
        }
    }
}
