xmlport 50033 "Import Production Schedule"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Table50044;Table50044)
            {
                XmlName = 'ProductionSchedule';
                fieldelement(CustomerNo;"Production Schedule"."Customer No.")
                {
                }
                fieldelement(ItemNo;"Production Schedule"."Item No.")
                {
                }
                fieldelement(ShippingDate;"Production Schedule"."Shipping Date")
                {
                }
                fieldelement(Quantity;"Production Schedule".Quantity)
                {
                }
                fieldelement(EntryDate;"Production Schedule"."Entry Date")
                {
                }
                fieldelement(Description;"Production Schedule".Description)
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

