table 50021 "Commercial Invoice MEX"
{
    fields
    {
        field(1;"Entry No.";Integer)
        {
            // cleaned
        }
        field(2;"Virtural Operation No.";Code[10])
        {
            // cleaned
        }
        field(6;"Customer No.";Code[20])
        {
            // cleaned
        }
        field(7;"Country of Origin";Code[10])
        {
            // cleaned
        }
        field(10;"Item No.";Code[20])
        {
            // cleaned
        }
        field(20;"Custom Agent License No.";Code[10])
        {
            Description = 'Patente Orignal';
        }
        field(23;"Customer Agent E/S";Code[10])
        {
            Description = 'Aduana E/S';
        }
        field(26;"Summary Entry No.";Code[10])
        {
            Description = 'Pediment No.';
        }
        field(29;"Summary Entry Code";Code[10])
        {
            Description = 'CVE Pedimento';
        }
        field(32;"Date of Entry";Date)
        {
            Description = 'Fecha de entrada';
        }
        field(35;Quantity;Decimal)
        {
            // cleaned
        }
        field(38;Weight;Decimal)
        {
            // cleaned
        }
        field(50;"Line Amount";Decimal)
        {
            // cleaned
        }
        field(52;"Tax Amount";Decimal)
        {
            // cleaned
        }
        field(55;"Amount Incl Tax";Decimal)
        {
            // cleaned
        }
        field(70;"Doc No";Code[20])
        {
            // cleaned
        }
        field(71;"Doc Line No";Integer)
        {
            // cleaned
        }
        field(50001;"Invoice No";Code[20])
        {
            // cleaned
        }
    }
}
