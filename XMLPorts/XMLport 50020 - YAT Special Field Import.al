xmlport 50020 "YAT Special Field Import"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Table37;Table37)
            {
                AutoSave = true;
                AutoUpdate = false;
                XmlName = 'SalesLine';
                UseTemporary = false;
                fieldelement(DocType;"Sales Line"."Document Type")
                {
                }
                fieldelement(DocNo;"Sales Line"."Document No.")
                {
                }
                fieldelement(LineNo;"Sales Line"."Line No.")
                {
                }
                fieldelement(Type;"Sales Line".Type)
                {

                    trigger OnAfterAssignField()
                    begin
                        // if Type = '' then
                        //"Purchase Line".Type   CurrXMPport.skip;
                        //IF "Sales Line".Type = "Sales Line".Type::Resource THEN
                        //   currXMLport.SKIP;
                    end;
                }
                fieldelement(Numb;"Sales Line"."No.")
                {
                }
                fieldelement(Qty;"Sales Line".Quantity)
                {
                }
                fieldelement(UOMCode;"Sales Line"."Unit of Measure Code")
                {
                }
                fieldelement(UOM;"Sales Line"."Unit of Measure")
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

