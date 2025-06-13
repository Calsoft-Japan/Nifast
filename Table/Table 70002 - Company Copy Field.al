table 70002 "Company Copy Field"
{
    fields
    {
        field(1;"Template Name";Code[10])
        {
            NotBlank = true;
        }
        field(2;"Table No.";Integer)
        {
            NotBlank = true;
        }
        field(3;"Field No.";Integer)
        {
            NotBlank = true;
            
        }
        field(4;Name;Text[30])
        {
            Editable = false;
        }
        field(5;"Validate Field";Boolean)
        {
            // cleaned
        }
        field(6;"Table Relation";Integer)
        {
            Editable = false;
            
        }
        field(7;"Table Relation Name";Text[30])
        {
            Editable = false;
        }
    }
}
