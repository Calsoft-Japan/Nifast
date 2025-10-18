xmlport 50032 "GM Contract Price Import"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Sales Price"; "Sales Price")
            {
                XmlName = 'GMContract';
                fieldelement(SalesCode; "Sales Price"."Sales Code")
                {
                }
                fieldelement(ItemNo; "Sales Price"."Item No.")
                {
                }
                fieldelement(StartingDate; "Sales Price"."Starting Date")
                {
                }
                fieldelement(UnitPrice; "Sales Price"."Unit Price")
                {
                }
                fieldelement(CurrencyCode; "Sales Price"."Currency Code")
                {
                }
                fieldelement(SalesType; "Sales Price"."Sales Type")
                {
                }
                fieldelement(VariantCode; "Sales Price"."Variant Code")
                {
                }
                fieldelement(UnitOfMeasureCode; "Sales Price"."Unit of Measure Code")
                {
                }
                fieldelement(MinimumQuantity; "Sales Price"."Minimum Quantity")
                {
                }
                fieldelement(ContractNo; "Sales Price"."Contract No.")
                {
                }
                //TODO
                /*  fieldelement(ContractCustomerNo; "Sales Price"."Contract Customer No.")
                 {
                 }
                 fieldelement(ContractShipToCode; "Sales Price"."Contract Ship-to Code")
                 {
                 }
                 fieldelement(ContractLocationCode; "Sales Price"."Contract Location Code")
                 {
                 }
                 fieldelement(ContractShipLocationCode; "Sales Price"."Contract Ship Location Code")
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

