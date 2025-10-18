page 50141 "FB Import Dataport List"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)
    // NF1.00:CIS.NG    10/26/15 Fill-Bill Functionality (Added message after file import completed)

    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "FB Import Dataport";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ToolTip = 'Specifies the value of the Ship-to Code field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Dataport ID"; Rec."Dataport ID")
                {
                    ToolTip = 'Specifies the value of the Dataport ID field.';
                }
                field("Import File Path"; Rec."Import File Path")
                {
                    ToolTip = 'Specifies the value of the Import File Path field.';

                    trigger OnAssistEdit()
                    begin
                        Path := GetFolder();
                        IF Path <> '' THEN
                            Rec.VALIDATE("Import File Path", Path);
                    end;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
                Caption = 'Functions';
                action("Process Import")
                {
                    Caption = 'Process Import';
                    Image = Import;
                    PromotedOnly = true;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F9';
                    ToolTip = 'Executes the Process Import action.';

                    trigger OnAction()
                    begin
                        Rec.VALIDATE("User ID", USERID);
                        Rec.MODIFY();
                        COMMIT();
                        ProcessImport();
                        Rec.VALIDATE("User ID", '');
                        Rec.TempFileName := '';
                        Rec.MODIFY();
                        COMMIT();
                    end;
                }
            }
        }
    }

    var
        Path: Text[250];
        Text000: Label 'There is nothing to import.';
        Text001: Label 'File import completed successfully.\\Total File: %1\Success Import: %2\Skip Import: %3', Comment = '%1%2%3';

    procedure GetFolder(): Text[250]
    begin
    end;

    procedure ProcessImport()
    var
        FileSys: Record "File";
        OldFileName: Text[250];
        NewFileName: Text[250];
        InFile: File;
        InputStream: InStream;
        SuccessImport: Integer;
        TotalImport: Integer;
    begin
        //>> NF1.00:CIS.NG 10/26/15
        SuccessImport := 0;
        TotalImport := 0;
        //<< NF1.00:CIS.NG 10/26/15

        FileSys.SETRANGE(Path, Rec."Import File Path");
        FileSys.SETRANGE("Is a file", TRUE);
        IF FileSys.FIND('-') THEN BEGIN
            REPEAT
                TotalImport += 1;  //NF1.00:CIS.NG 10/26/15
                IF STRPOS(FileSys.Name, '.FBX') = 0 THEN BEGIN
                    OldFileName := FileSys.Path + '\' + FileSys.Name;
                    Rec.TempFileName := OldFileName;
                    Rec.MODIFY();
                    COMMIT();
                    NewFileName := OldFileName + '.FBX';
                    IF (NOT FILE.EXISTS(NewFileName)) THEN
                        IF FILE.COPY(OldFileName, NewFileName) THEN BEGIN
                            //>> NF1.00:CIS.NG 09/28/15
                            //XMLPORT.RUN("Dataport ID",FALSE);
                            CLEAR(InFile);
                            CLEAR(InputStream);
                            InFile.OPEN(TempFileName);
                            InFile.CREATEINSTREAM(InputStream);
                            XMLPORT.IMPORT(Rec."Dataport ID", InputStream);
                            InFile.CLOSE;
                            //<< NF1.00:CIS.NG 09/28/15
                            FILE.ERASE(OldFileName);
                            SuccessImport += 1;  //NF1.00:CIS.NG 10/26/15
                        END;
                END;
            UNTIL FileSys.NEXT() = 0;
            //>> NF1.00:CIS.NG 10/26/15
            MESSAGE(Text001, TotalImport, SuccessImport, TotalImport - SuccessImport);
        END ELSE
            MESSAGE(Text000);
        //<< NF1.00:CIS.NG 10/26/15
    end;
}

