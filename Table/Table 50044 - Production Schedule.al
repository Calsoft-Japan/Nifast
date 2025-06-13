table 50044 "Production Schedule"
{
    fields
    {
        field(1;"Customer No.";Code[10])
        {
            NotBlank = true;
        }
        field(2;"Item No.";Code[20])
        {
            NotBlank = true;
        }
        field(3;"Shipping Date";Date)
        {
            NotBlank = true;
        }
        field(4;Quantity;Decimal)
        {
            NotBlank = true;
        }
        field(5;"Entry Date";Date)
        {
            // cleaned
        }
        field(6;Description;Text[100])
        {
            // cleaned
        }
        field(7;"Entry No.";Integer)
        {
            AutoIncrement = true;
        }
    }
}
