xmlport 50050 "Temp Item Export"
{
    Direction = Export;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Table27;Table27)
            {
                XmlName = 'Item';
                fieldelement(No;Item."No.")
                {
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }
}

