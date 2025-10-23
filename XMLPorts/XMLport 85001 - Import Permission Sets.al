xmlport 85001 "Import Permission Setss"
{
    Caption = 'Import/Export Permission Sets';
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Permission Set"; "Permission Set")
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
                begin
                end;

                trigger OnBeforeInsertRecord()
                var
                    PermissionSet_lRec: Record "Permission Set";
                begin
                    IF PermissionSet_lRec.GET(RoleID) THEN
                        currXMLport.SKIP();

                    PermissionSet_lRec.RESET();
                    PermissionSet_lRec.INIT();
                    PermissionSet_lRec."Role ID" := RoleID;
                    PermissionSet_lRec.Name := Name;
                    PermissionSet_lRec.TESTFIELD("Role ID");
                    PermissionSet_lRec.INSERT();
                    Count_gInt += 1;
                    currXMLport.SKIP();
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
        MESSAGE('%1 - Role imported Successfully', Count_gInt);
    end;

    var
        Count_gInt: Integer;
}

