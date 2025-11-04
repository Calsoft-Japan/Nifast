table 50038 "Sales Invoice/Cr. Memo Export"
{
    // AKK1612.01    21/12/2016    KALPIT  --> Create a table to enter the Sales Invoice / Cr Memo Lines as per given structure to Export data into Txt file
    // AKK1612.02    28/07/2016    OR      --> Added field 5
    fields
    {
        field(1; SLInes; Integer)
        {
            Description = 'AKK1612.01';
        }
        field(2; Details1; Text[250])
        {
            Description = 'AKK1612.01';
        }
        field(3; Details2; Text[250])
        {
            Description = 'AKK1612.01';
        }
        field(4; "Document No."; Code[20])
        {
            Description = 'AKK1612.01';
        }
    }
    keys
    {
        key(Key1; SLInes)
        {
        }
    }

    fieldgroups
    {
    }
}
