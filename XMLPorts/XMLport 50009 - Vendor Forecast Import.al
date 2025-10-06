xmlport 50009 "Vendor Forecast Import"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Table50028;Table50028)
            {
                AutoSave = true;
                AutoUpdate = false;
                XmlName = 'VendorFLE';
                UseTemporary = false;
                fieldelement(ItemNo;"Vendor Forecast Ledger Entry"."Item No.")
                {
                }
                fieldelement(VendNo;"Vendor Forecast Ledger Entry"."Vendor No.")
                {
                }
                fieldelement(DivCode;"Vendor Forecast Ledger Entry"."Div Code")
                {
                }
                fieldelement(ForecastQtyForVen;"Vendor Forecast Ledger Entry"."Forecast Qty for Vendor")
                {
                }
                fieldelement(RecvDate;"Vendor Forecast Ledger Entry"."Receive Date")
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

    trigger OnPostXmlPort()
    begin
         MESSAGE('Import Completed');
    end;
}

