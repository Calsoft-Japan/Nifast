xmlport 50015 "Purchase Order Import"
{
    Direction = Import;
    Format = VariableText;
    PreserveWhiteSpace = true;

    schema
    {
        textelement(Root)
        {
            tableelement(Table39;Table39)
            {
                AutoSave = true;
                AutoUpdate = false;
                XmlName = 'PurchLine';
                UseTemporary = false;
                fieldelement(DocType;"Purchase Line"."Document Type")
                {
                }
                fieldelement(DocNo;"Purchase Line"."Document No.")
                {
                }
                fieldelement(LineNo;"Purchase Line"."Line No.")
                {
                }
                fieldelement(Type;"Purchase Line".Type)
                {
                }
                fieldelement(Numb;"Purchase Line"."No.")
                {
                }
                fieldelement(Qty;"Purchase Line".Quantity)
                {
                }
                fieldelement(UOMCd;"Purchase Line"."Unit of Measure Code")
                {
                }
                fieldelement(ExptdRecvDt;"Purchase Line"."Expected Receipt Date")
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

    trigger OnPreXmlPort()
    begin
          MESSAGE('OK');
    end;
}

