xmlport 50025 "VPG imoprt"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Table23;Table23)
            {
                XmlName = 'Vendor';
                fieldelement(No;Vendor."No.")
                {
                }
                fieldelement(VPG;Vendor."Vendor Posting Group")
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

