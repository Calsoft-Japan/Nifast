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
            tableelement(Table50027;Table50027)
            {
                AutoSave = true;
                AutoUpdate = false;
                XmlName = 'ForecastLE';
                UseTemporary = false;
                fieldelement(ItemNo;"Forecast Ledger Entry"."Item No.")
                {
                }
                fieldelement(ForecastQty;"Forecast Ledger Entry"."Forecast Quantity")
                {
                }
                fieldelement(CustNo;"Forecast Ledger Entry"."Customer No.")
                {
                }
                fieldelement(ShippingDate;"Forecast Ledger Entry"."Shipping Date")
                {
                }
                fieldelement(DivCode;"Forecast Ledger Entry"."Division Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(EnterDate;"Forecast Ledger Entry"."Enter Date")
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

