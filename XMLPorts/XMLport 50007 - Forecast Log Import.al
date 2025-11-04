xmlport 50007 "Forecast Log Import"
{
    Direction = Import;
    Format = VariableText;
    PreserveWhiteSpace = true;

    schema
    {
        textelement(Root)
        {
            tableelement("Forecast Log File"; "Forecast Log File")
            {
                AutoSave = true;
                AutoUpdate = false;
                XmlName = 'ForecastLogFile';
                UseTemporary = false;
                fieldelement(ItemNo; "Forecast Log File"."Item No.")
                {
                }
                fieldelement(CustNo; "Forecast Log File"."Customer No.")
                {
                }
                fieldelement(Quantity; "Forecast Log File".Quantity)
                {
                }
                fieldelement(GenDate; "Forecast Log File"."Generation Date")
                {
                }
                fieldelement(ForecastMo; "Forecast Log File"."Forecast Month")
                {
                }
                fieldelement(DivCode; "Forecast Log File"."Div Code")
                {
                }

                trigger OnBeforeInsertRecord()
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

