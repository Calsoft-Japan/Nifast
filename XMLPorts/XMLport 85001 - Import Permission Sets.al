xmlport 85001 "Import Permission Sets"
{
    Caption = 'Import/Export Permission Sets';
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Table2000000004;Table2000000004)
            {
                XmlName = 'UserRole';
                UseTemporary = true;
                textelement(RoleID)
                {
                }
                textelement(Name)
                {
                }

                trigger OnAfterInsertRecord()
                var
                    PermissionSet_lRec: Record "2000000004";
                begin
                end;

                trigger OnBeforeInsertRecord()
                var
                    PermissionSet_lRec: Record "2000000004";
                begin
                    IF PermissionSet_lRec.GET(RoleID) THEN
                      currXMLport.SKIP;

                    PermissionSet_lRec.RESET;
                    PermissionSet_lRec.INIT;
                    PermissionSet_lRec."Role ID" := RoleID;
                    PermissionSet_lRec.Name := Name;
                    PermissionSet_lRec.TESTFIELD("Role ID");
                    PermissionSet_lRec.INSERT;
                    Count_gInt += 1;
                    currXMLport.SKIP;
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
        MESSAGE('%1 - Role imported Successfully',Count_gInt);
    end;

    var
        Count_gInt: Integer;
}

