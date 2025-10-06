xmlport 85002 "Import Permissions"
{
    Caption = 'Import/Export Permissions';
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Table2000000005;Table2000000005)
            {
                XmlName = 'PermissionImport';
                UseTemporary = true;
                textelement(RoleID)
                {
                }
                textelement(RoleName)
                {
                }
                textelement(ObjectTypeImport)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        EVALUATE(ObjectType_gOpt,ObjectTypeImport);
                    end;
                }
                textelement(ObjectID)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        EVALUATE(ObjectID_gInt,ObjectID);
                    end;
                }
                textelement(ObjectName)
                {
                }
                textelement(ReadPermission)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        EVALUATE(ReadPermission_gOpt,ReadPermission);
                    end;
                }
                textelement(InsertPermission)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        EVALUATE(InsertPermission_gOpt,InsertPermission);
                    end;
                }
                textelement(ModifyPermission)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        EVALUATE(ModPermission_gOpt,ModifyPermission);
                    end;
                }
                textelement(DeletePermission)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        EVALUATE(DelPermission_gOpt,DeletePermission);
                    end;
                }
                textelement(ExecutePermission)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        EVALUATE(ExcPermission_gOpt,ExecutePermission);
                    end;
                }

                trigger OnAfterInitRecord()
                begin
                    CLEAR(ObjectTypeImport);
                    ObjectID_gInt := 0;
                    CLEAR(ReadPermission_gOpt);
                    CLEAR(InsertPermission_gOpt);
                    CLEAR(ModPermission_gOpt);
                    CLEAR(DelPermission_gOpt);
                    CLEAR(ExcPermission_gOpt);
                end;

                trigger OnBeforeInsertRecord()
                var
                    PermissionSet_lRec: Record "2000000005";
                begin
                    Counter_gInt += 1;
                    Window_gDlg.UPDATE(1,Counter_gInt);

                    IF PermissionSet_lRec.GET(RoleID,ObjectType_gOpt,ObjectID_gInt) THEN
                      currXMLport.SKIP;

                    PermissionSet_lRec.RESET;
                    PermissionSet_lRec.INIT;
                    PermissionSet_lRec."Role ID" := RoleID;
                    PermissionSet_lRec."Object Type" := ObjectType_gOpt;
                    PermissionSet_lRec."Object ID" := ObjectID_gInt;
                    PermissionSet_lRec."Read Permission" := ReadPermission_gOpt;
                    PermissionSet_lRec."Insert Permission" := InsertPermission_gOpt;
                    PermissionSet_lRec."Modify Permission" := ModPermission_gOpt;
                    PermissionSet_lRec."Delete Permission" := DelPermission_gOpt;
                    PermissionSet_lRec."Execute Permission" := ExcPermission_gOpt;
                    PermissionSet_lRec.TESTFIELD("Role ID");
                    //PermissionSet_lRec.TESTFIELD("Object Type");
                    //PermissionSet_lRec.TESTFIELD("Object ID");
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
        MESSAGE('%1 - Line Inserted, %2 - Line Process',Count_gInt,Counter_gInt);
        Window_gDlg.CLOSE;
    end;

    trigger OnPreXmlPort()
    begin
        Window_gDlg.OPEN(Text000_gTxt);
    end;

    var
        ObjectType_gOpt: Option "Table Data","Table",,"Report",,"Codeunit","XMLport",MenuSuite,"Page","Query",System;
        ObjectID_gInt: Integer;
        ReadPermission_gOpt: Option " ",Yes,Indirect;
        InsertPermission_gOpt: Option " ",Yes,Indirect;
        ModPermission_gOpt: Option " ",Yes,Indirect;
        DelPermission_gOpt: Option " ",Yes,Indirect;
        ExcPermission_gOpt: Option " ",Yes,Indirect;
        Count_gInt: Integer;
        Window_gDlg: Dialog;
        Text000_gTxt: Label 'Current  #1##############';
        Counter_gInt: Integer;
}

