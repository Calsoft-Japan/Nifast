xmlport 50017 "Forecast Import wo Remark"
{
    Direction = Import;
    Format = VariableText;
    PreserveWhiteSpace = true;
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement("Forecast Ledger Entry"; "Forecast Ledger Entry")
            {
                AutoSave = true;
                AutoUpdate = false;
                XmlName = 'ForecastLE';
                UseTemporary = false;
                fieldelement(ItemNo; "Forecast Ledger Entry"."Item No.")
                {
                }
                fieldelement(ForecastQty; "Forecast Ledger Entry"."Forecast Quantity")
                {
                }
                fieldelement(CustNo; "Forecast Ledger Entry"."Customer No.")
                {
                }
                fieldelement(ShippingDate; "Forecast Ledger Entry"."Shipping Date")
                {
                }
                fieldelement(DivCode; "Forecast Ledger Entry"."Division Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(EnterDate; "Forecast Ledger Entry"."Enter Date")
                {
                }

                trigger OnBeforeInsertRecord()
                var
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

