xmlport 50007 "Forecast Log Import"
{
    Direction = Import;
    Format = VariableText;
    PreserveWhiteSpace = true;

    schema
    {
        textelement(Root)
        {
            tableelement(Table50026;Table50026)
            {
                AutoSave = true;
                AutoUpdate = false;
                XmlName = 'ForecastLogFile';
                UseTemporary = false;
                fieldelement(ItemNo;"Forecast Log File"."Item No.")
                {
                }
                fieldelement(CustNo;"Forecast Log File"."Customer No.")
                {
                }
                fieldelement(Quantity;"Forecast Log File".Quantity)
                {
                }
                fieldelement(GenDate;"Forecast Log File"."Generation Date")
                {
                }
                fieldelement(ForecastMo;"Forecast Log File"."Forecast Month")
                {
                }
                fieldelement(DivCode;"Forecast Log File"."Div Code")
                {
                }

                trigger OnBeforeInsertRecord()
                var
                    PermissionSet_lRec: Record "2000000005";
                begin
                end;
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

