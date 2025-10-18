xmlport 50029 "Import Sales Prices"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement("<root>")
        {
            XmlName = 'Root';
            tableelement("Sales Price"; "Sales Price")
            {
                XmlName = 'SalesPrice';
                fieldelement(ContractNo; "Sales Price"."Contract No.")
                {
                }
                fieldelement(ItemNo; "Sales Price"."Item No.")
                {
                }
                fieldelement(UnitPrice; "Sales Price"."Unit Price")
                {
                }
                //TODO
                /* fieldelement(ContractShiptoCode; "Sales Price"."Contract Ship-to Code")
                {
                }
                fieldelement(AltPrice; "Sales Price"."Alt. Price")
                {
                }
                fieldelement(AltPriceUOM; "Sales Price"."Alt. Price UOM")
                {
                } */
                //TODO
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

