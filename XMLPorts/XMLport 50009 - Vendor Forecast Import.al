xmlport 50009 "Vendor Forecast Import"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Vendor Forecast Ledger Entry"; "Vendor Forecast Ledger Entry")
            {
                AutoSave = true;
                AutoUpdate = false;
                XmlName = 'VendorFLE';
                UseTemporary = false;
                fieldelement(ItemNo; "Vendor Forecast Ledger Entry"."Item No.")
                {
                }
                fieldelement(VendNo; "Vendor Forecast Ledger Entry"."Vendor No.")
                {
                }
                fieldelement(DivCode; "Vendor Forecast Ledger Entry"."Div Code")
                {
                }
                fieldelement(ForecastQtyForVen; "Vendor Forecast Ledger Entry"."Forecast Qty for Vendor")
                {
                }
                fieldelement(RecvDate; "Vendor Forecast Ledger Entry"."Receive Date")
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

    trigger OnPostXmlPort()
    begin
        MESSAGE('Import Completed');
    end;
}

