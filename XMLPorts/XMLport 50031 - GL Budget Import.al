xmlport 50031 "GL Budget Import"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement(Table96;Table96)
            {
                XmlName = 'GLBudgetEntry';
                fieldelement(BudgetName;"G/L Budget Entry"."Budget Name")
                {
                }
                fieldelement(AccountCode;"G/L Budget Entry"."G/L Account No.")
                {
                }
                fieldelement(Date;"G/L Budget Entry".Date)
                {
                }
                fieldelement(DivCode;"G/L Budget Entry"."Global Dimension 1 Code")
                {
                }
                fieldelement(Amount;"G/L Budget Entry".Amount)
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

