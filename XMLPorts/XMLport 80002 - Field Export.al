xmlport 80002 "Field Export"
{
    Direction = Export;
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Field; Field)
            {
                XmlName = 'FieldRoot';
                fieldelement(a; Field.TableNo)
                {
                }
                fieldelement(aa; Field."No.")
                {
                }
                fieldelement(aaaaa; Field.FieldName)
                {
                }
                fieldelement(aaa; Field.Type)
                {
                }
                fieldelement(aaaa; Field.Len)
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

