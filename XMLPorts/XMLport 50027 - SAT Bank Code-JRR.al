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
            tableelement(Table50034;Table50034)
            {
                AutoSave = false;
                XmlName = 'SlsPrc';
                UseTemporary = false;
                fieldattribute(iNo;"SAT Bank Code".Code)
                {
                    Width = 20;
                }
                fieldattribute(iCrossref;"SAT Bank Code".Description)
                {
                    Width = 30;
                }
                fieldattribute(iSalesCode;"SAT Bank Code"."Bank Name")
                {
                    Width = 20;
                }

                trigger OnAfterInsertRecord()
                begin
                    BankCode.Code :="SAT Bank Code".Code;
                    BankCode.Description :="SAT Bank Code".Description;
                    BankCode."Bank Name" :=BankCode."Bank Name";
                    BankCode.INSERT;
                end;

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

    var
        Text000_gTxt: Label 'Current  #1##############';
        d: Dialog;
        RecNo: Integer;
        BankCode: Record "50034";
        RecReplace: Boolean;
}

