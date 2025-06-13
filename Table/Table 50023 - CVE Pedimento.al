table 50023 "CVE Pedimento"
{
    fields
    {
        field(1;"Code";Code[10])
        {
            NotBlank = true;
        }
        field(2;Description;Text[50])
        {
            // cleaned
        }
        field(10;"Include on Virtual Invoice";Boolean)
        {
            // cleaned
        }
    }
}
