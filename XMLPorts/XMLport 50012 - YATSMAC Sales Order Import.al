xmlport 50012 "YAT/SMAC Sales Order Import"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Sales Line"; "Sales Line")
            {
                AutoSave = true;
                AutoUpdate = false;
                XmlName = 'SalesLine';
                UseTemporary = false;
                fieldelement(DocType; "Sales Line"."Document Type")
                {
                }
                fieldelement(DocNo; "Sales Line"."Document No.")
                {
                }
                fieldelement(LineNo; "Sales Line"."Line No.")
                {
                }
                fieldelement(Type; "Sales Line".Type)
                {
                }
                fieldelement(Numb; "Sales Line"."No.")
                {
                }
                fieldelement(Qty; "Sales Line".Quantity)
                {
                }
                fieldelement(UOMC; "Sales Line"."Unit of Measure Code")
                {
                }
                fieldelement(UOM; "Sales Line"."Unit of Measure")
                {
                }
                fieldelement(ExtDoc; "Sales Line"."External Document No.")
                {
                }
                fieldelement(RanNo; "Sales Line"."Ran No.")
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

