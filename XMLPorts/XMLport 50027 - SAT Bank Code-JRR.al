xmlport 50027 "SAT Bank Code-JRR"
{
    // 09/29/15 - JRR Dataport 50000 conversion
    // Copy of Update for New Vision Removal Task (Fill-Bill Functionality Renumber)

    Caption = 'Import/Export Permissions';
    Direction = Import;
    FieldSeparator = '<TAB>';
    Format = VariableText;
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement("SAT Bank Code"; "SAT Bank Code")
            {
                AutoSave = false;
                XmlName = 'SlsPrc';
                UseTemporary = false;
                fieldattribute(iNo; "SAT Bank Code".Code)
                {
                    Width = 20;
                }
                fieldattribute(iCrossref; "SAT Bank Code".Description)
                {
                    Width = 30;
                }
                fieldattribute(iSalesCode; "SAT Bank Code"."Bank Name")
                {
                    Width = 20;
                }

                trigger OnAfterInsertRecord()
                begin
                    BankCode.Code := "SAT Bank Code".Code;
                    BankCode.Description := "SAT Bank Code".Description;
                    BankCode."Bank Name" := BankCode."Bank Name";
                    BankCode.INSERT();
                end;

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

    var
        BankCode: Record "SAT Bank Code";
}

