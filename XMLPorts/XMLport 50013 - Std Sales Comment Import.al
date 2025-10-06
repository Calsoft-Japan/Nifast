xmlport 50013 "Std Sales Comment Import"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Table44;Table44)
            {
                AutoSave = true;
                AutoUpdate = false;
                XmlName = 'StdSalesCmntImp';
                UseTemporary = false;
                fieldelement(DocType;"Sales Comment Line"."Document Type")
                {
                }
                fieldelement(Numb;"Sales Comment Line"."No.")
                {
                }
                fieldelement(DocLnNo;"Sales Comment Line"."Document Line No.")
                {
                }
                fieldelement(LineNo;"Sales Comment Line"."Line No.")
                {
                }
                fieldelement(Date;"Sales Comment Line".Date)
                {
                }
                fieldelement(Comment;"Sales Comment Line".Comment)
                {
                }
                fieldelement(PrintOnQuote;"Sales Comment Line"."Print On Quote")
                {
                }
                fieldelement(PrintOnPickTic;"Sales Comment Line"."Print On Pick Ticket")
                {
                }
                fieldelement(PrintOnOrdConf;"Sales Comment Line"."Print On Order Confirmation")
                {
                }
                fieldelement(PrintOnShipment;"Sales Comment Line"."Print On Shipment")
                {
                }
                fieldelement(PrintOnInv;"Sales Comment Line"."Print On Invoice")
                {
                }
                fieldelement(PrintOnCM;"Sales Comment Line"."Print On Credit Memo")
                {
                }
                fieldelement(PrintOnWS;"Sales Comment Line"."Print On Return Authorization")
                {
                }
                fieldelement(PrintOnBlanket;"Sales Comment Line"."Print On Return Receipt")
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

