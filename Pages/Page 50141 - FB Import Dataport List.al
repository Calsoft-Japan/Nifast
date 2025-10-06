page 50141 "FB Import Dataport List"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)
    // NF1.00:CIS.NG    10/26/15 Fill-Bill Functionality (Added message after file import completed)

    PageType = List;
    SourceTable = Table50139;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Customer No.";"Customer No.")
                {
                }
                field("Ship-to Code";"Ship-to Code")
                {
                }
                field("Location Code";"Location Code")
                {
                }
                field("Dataport ID";"Dataport ID")
                {
                }
                field("Import File Path";"Import File Path")
                {

                    trigger OnAssistEdit()
                    begin
                        Path := GetFolder;
                        IF Path <> '' THEN
                          VALIDATE("Import File Path",Path);
                    end;
                }
                field(Description;Description)
                {
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
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        VALIDATE("User ID",USERID);
                        MODIFY;
                        COMMIT;
                        ProcessImport;
                        VALIDATE("User ID",'');
                        TempFileName := '';
                        MODIFY;
                        COMMIT;
                    end;
                }
            }
        }
    }

    var
        Path: Text[250];
        Text000: Label 'There is nothing to import.';
        Text001: Label 'File import completed successfully.\\Total File: %1\Success Import: %2\Skip Import: %3';

    procedure GetFolder(): Text[250]
    begin
    end;

    procedure ProcessImport()
    var
        FileSys: Record "2000000022";
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

        FileSys.SETRANGE(Path,"Import File Path");
        FileSys.SETRANGE("Is a file",TRUE);
        IF FileSys.FIND('-') THEN BEGIN
          REPEAT
            TotalImport += 1;  //NF1.00:CIS.NG 10/26/15
            IF STRPOS(FileSys.Name,'.FBX') = 0 THEN BEGIN
              OldFileName := FileSys.Path + '\' + FileSys.Name;
              TempFileName := OldFileName;
              MODIFY;
              COMMIT;
              NewFileName := OldFileName + '.FBX';
              IF (NOT FILE.EXISTS(NewFileName)) THEN BEGIN
                IF FILE.COPY(OldFileName,NewFileName) THEN BEGIN
                  //>> NF1.00:CIS.NG 09/28/15
                  //XMLPORT.RUN("Dataport ID",FALSE);
                  CLEAR(InFile);
                  CLEAR(InputStream);
                  InFile.OPEN(TempFileName);
                  InFile.CREATEINSTREAM(InputStream);
                  XMLPORT.IMPORT("Dataport ID",InputStream);
                  InFile.CLOSE;
                  //<< NF1.00:CIS.NG 09/28/15
                  FILE.ERASE(OldFileName);
                  SuccessImport += 1;  //NF1.00:CIS.NG 10/26/15
                END;
              END;
            END;
          UNTIL FileSys.NEXT = 0;
        //>> NF1.00:CIS.NG 10/26/15
          MESSAGE(Text001,TotalImport,SuccessImport,TotalImport - SuccessImport);
        END ELSE
          MESSAGE(Text000);
        //<< NF1.00:CIS.NG 10/26/15
    end;
}

