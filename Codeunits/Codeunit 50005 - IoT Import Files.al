codeunit 50005 "IoT Import Files"
{
    // CIS.IoT 07/22/22 RAM Created new Object


    trigger OnRun()
    var
        IoTFileImportLog: Record "50045";
    begin
        pString := DocType1;
        ProcessAll(FALSE);

        pString := DocType2;
        ProcessAll(FALSE);

        pString := DocType3;
        ProcessAll(FALSE);

        IoTFileImportLog.RESET;
        //IoTFileImportLog.SETRANGE("Import Date",TODAY);
        IoTFileImportLog.SETRANGE(Status,IoTFileImportLog.Status::Error);
        IF IoTFileImportLog.FINDSET THEN
          SendStatusEmail;
    end;

    var
        InvtSetup: Record "313";
        MyFile: Record "2000000022";
        SourceFile: File;
        Ins: InStream;
        DocType1: Label 'Invt. Pick.';
        DocType2: Label 'Trans. Rcpt.';
        DocType3: Label 'Sales Ship';
        FOLDER_NOT_FOUND: Label 'Could not find folder %1';
        DOCNAME: Label '%1.XML';
        INVALID_XML_DOCTYPE: Label 'The DOCTYPE element in the XML document returned an invalid value';
        EDI_ORDER_REJECTED: Label 'The EDI Sales Order number %1 was rejected';
        STATUS_MSG: Label 'Files Imported: %1\Orders Failed: %2';
        SuccessCount: Integer;
        ErrorCount: Integer;
        NOTHING_MSG: Label 'There is nothing to import.';
        CONFIRM_MSG: Label 'Do you want to import/update order?';
        EMAIL_TEXT1: Label 'Dear User,';
        EMAIL_TEXT2: Label 'Error Notification';
        EMAIL_TEXT3: Label 'Regards,';
        EMAIL_TEXT4: Label 'Systems Auto Alert';
        EMAIL_TEXT5: Label 'File Detail - %1';
        EMAIL_TEXT7: Label 'Files Failed : %1';
        DIALOG_TEXT1: Label 'Import Files....\';
        DIALOG_TEXT2: Label 'File Name #1################';
        Window: Dialog;
        LastUsedLineNo: Integer;
        JobQueueEnt: Record "472";
        ImportIoTInvtPickData: XMLport "50002";
        ImportIoTTransRcptData: XMLport "50003";
        ImportIoTSalesShipData: XMLport "50035";
        Sourcepath: Text[250];
        Errorpath: Text[250];
        Successpath: Text[250];
        pString: Code[30];
        BackSlashstr: Text[1];

    procedure ProcessAll(parShowMsg: Boolean)
    var
        IoTFileImportLog: Record "50045";
    begin
        IF GUIALLOWED THEN BEGIN
          IF NOT CONFIRM(CONFIRM_MSG,TRUE) THEN
            EXIT;
        END;

        CLEAR(Sourcepath);
        CLEAR(Errorpath);
        CLEAR(Successpath);

        CheckSetup;

        MyFile.RESET;

        MyFile.SETRANGE(Path,Sourcepath);
        MyFile.SETRANGE("Is a file",TRUE);
        MyFile.SETFILTER(Name,'@*.csv');
        IF MyFile.FINDSET THEN BEGIN
          IF GUIALLOWED THEN
            Window.OPEN(DIALOG_TEXT1 + DIALOG_TEXT2);


          IoTFileImportLog.RESET;
          IF IoTFileImportLog.FINDLAST THEN
            LastUsedLineNo := IoTFileImportLog."Entry No.";

          REPEAT
            CASE TRUE OF
              pString = UPPERCASE(DocType1): ProcessInvtPickFiles();
              pString = UPPERCASE(DocType2): ProcessInvtTransRcptFiles();
              pString = UPPERCASE(DocType3): ProcessInvtSalesShipFiles();
            END;
          UNTIL MyFile.NEXT = 0;

          IF GUIALLOWED THEN
            Window.CLOSE;

          IF parShowMsg THEN
            ShowMessage();
        END ELSE BEGIN
          IF GUIALLOWED THEN
            MESSAGE(NOTHING_MSG);
        END;
    end;

    procedure CheckSetup()
    begin
        CLEAR(Sourcepath);
        CLEAR(Errorpath);
        CLEAR(Successpath);
        InvtSetup.GET;

        CASE TRUE OF
          pString = UPPERCASE(DocType1):
            BEGIN
              InvtSetup.TESTFIELD("Invt. Pick File Path");
              Sourcepath :=InvtSetup."Invt. Pick File Path";
              BackSlashstr := COPYSTR(Sourcepath,STRLEN(Sourcepath),1);
              IF BackSlashstr <> '\' THEN
                 Sourcepath := Sourcepath + '\';
              Errorpath := Sourcepath + 'Error\';
              Successpath := Sourcepath + 'Archive\';
            END;
          pString = UPPERCASE(DocType2):
            BEGIN
              InvtSetup.TESTFIELD("Tras. Rcpt. File Path");
              Sourcepath :=InvtSetup."Tras. Rcpt. File Path";
              BackSlashstr := COPYSTR(Sourcepath,STRLEN(Sourcepath),1);
              IF BackSlashstr <> '\' THEN
                 Sourcepath := Sourcepath + '\';
              Errorpath := Sourcepath + 'Error\';
              Successpath := Sourcepath + 'Archive\';
            END;
          pString = UPPERCASE(DocType3):
            BEGIN
              InvtSetup.TESTFIELD("Sales Ship. File Path");
              Sourcepath :=InvtSetup."Sales Ship. File Path";
              BackSlashstr := COPYSTR(Sourcepath,STRLEN(Sourcepath),1);
              IF BackSlashstr <> '\' THEN
                 Sourcepath := Sourcepath + '\';
              Errorpath := Sourcepath + 'Error\';
              Successpath := Sourcepath + 'Archive\';
            END;
        END;

        IF Sourcepath = '' THEN
           ERROR('Sourcepath is blank. Checkit');

        //check folders
        IF NOT ValidateDirectoryPath(Errorpath) THEN
          ERROR(FOLDER_NOT_FOUND,Errorpath);
        IF NOT ValidateDirectoryPath(Sourcepath) THEN
          ERROR(FOLDER_NOT_FOUND,Sourcepath);
        IF NOT InvtSetup."Delete IoT File on Success" THEN BEGIN
          IF NOT ValidateDirectoryPath(Successpath) THEN
            ERROR(FOLDER_NOT_FOUND,Successpath);
        END;
    end;

    procedure ShowMessage()
    begin
        IF GUIALLOWED THEN
          MESSAGE(STATUS_MSG,FORMAT(SuccessCount),FORMAT(ErrorCount));
    end;

    procedure ProcessInvtPickFiles()
    var
        IoTFileImportLog: Record "50045";
        LastDocNo_lCod: Code[250];
    begin
        CLEARLASTERROR;
        CLEAR(Ins);
        CLEAR(SourceFile);

        IF GUIALLOWED THEN
          Window.UPDATE(1,MyFile.Name);

        SourceFile.TEXTMODE(TRUE);
        SourceFile.OPEN(MyFile.Path + MyFile.Name);
        SourceFile.CREATEINSTREAM(Ins);
        CLEAR(ImportIoTInvtPickData);
        ImportIoTInvtPickData.SetFileName(MyFile.Name);
        ImportIoTInvtPickData.SETSOURCE(Ins);
        IF ImportIoTInvtPickData.IMPORT THEN BEGIN
          SuccessCount += 1;
          IF InvtSetup."Delete IoT File on Success" THEN BEGIN
            SourceFile.CLOSE;
            ERASE(MyFile.Path + MyFile.Name);
          END ELSE BEGIN
            SourceFile.CLOSE;
            FILE.COPY(MyFile.Path + MyFile.Name, Successpath + MyFile.Name);
            ERASE(MyFile.Path + MyFile.Name);
          END;

          IoTFileImportLog.RESET;
          CLEAR(IoTFileImportLog);
          IoTFileImportLog."File Name" := MyFile.Name;
          IoTFileImportLog."Import Date" := TODAY;
          IoTFileImportLog."Import Time" := TIME;
          IoTFileImportLog."Import By" := USERID;
          IoTFileImportLog.Status := IoTFileImportLog.Status::Success;
          IoTFileImportLog.INSERT(TRUE);

          COMMIT; // to retain all good values, in case other files fail
        END ELSE BEGIN
          ErrorCount += 1;

          SourceFile.CLOSE;
          FILE.COPY(MyFile.Path + MyFile.Name, Errorpath + MyFile.Name);
          ERASE(MyFile.Path + MyFile.Name);

          IoTFileImportLog.RESET;
          CLEAR(IoTFileImportLog);
          IoTFileImportLog."File Name" := MyFile.Name;
          IoTFileImportLog."Import Date" := TODAY;
          IoTFileImportLog."Import Time" := TIME;
          IoTFileImportLog."Import By" := USERID;
          IoTFileImportLog.Status := IoTFileImportLog.Status::Error;
          IoTFileImportLog."Error Text" := COPYSTR(GETLASTERRORTEXT,1,250);
          IoTFileImportLog.INSERT(TRUE);
          COMMIT;
        END;
    end;

    procedure ProcessInvtTransRcptFiles()
    var
        IoTFileImportLog: Record "50045";
        LastDocNo_lCod: Code[250];
    begin
        CLEARLASTERROR;
        CLEAR(Ins);
        CLEAR(SourceFile);

        IF GUIALLOWED THEN
          Window.UPDATE(1,MyFile.Name);

        SourceFile.TEXTMODE(TRUE);
        SourceFile.OPEN(MyFile.Path + MyFile.Name);
        SourceFile.CREATEINSTREAM(Ins);
        CLEAR(ImportIoTInvtPickData);
        ImportIoTInvtPickData.SetFileName(MyFile.Name);
        ImportIoTTransRcptData.SETSOURCE(Ins);
        IF ImportIoTTransRcptData.IMPORT THEN BEGIN
          SuccessCount += 1;
          IF InvtSetup."Delete IoT File on Success" THEN BEGIN
            SourceFile.CLOSE;
            ERASE(MyFile.Path + MyFile.Name);
          END ELSE BEGIN
            SourceFile.CLOSE;
            FILE.COPY(MyFile.Path + MyFile.Name, Successpath + MyFile.Name);
            ERASE(MyFile.Path + MyFile.Name);
          END;

          IoTFileImportLog.RESET;
          CLEAR(IoTFileImportLog);
          IoTFileImportLog."File Name" := MyFile.Name;
          IoTFileImportLog."Import Date" := TODAY;
          IoTFileImportLog."Import Time" := TIME;
          IoTFileImportLog."Import By" := USERID;
          IoTFileImportLog.Status := IoTFileImportLog.Status::Success;
          IoTFileImportLog.INSERT(TRUE);

          COMMIT; // to retain all good values, in case other files fail
        END ELSE BEGIN
          ErrorCount += 1;

          SourceFile.CLOSE;
          FILE.COPY(MyFile.Path + MyFile.Name,Errorpath + MyFile.Name);
          ERASE(MyFile.Path + MyFile.Name);

          IoTFileImportLog.RESET;
          CLEAR(IoTFileImportLog);
          IoTFileImportLog."File Name" := MyFile.Name;
          IoTFileImportLog."Import Date" := TODAY;
          IoTFileImportLog."Import Time" := TIME;
          IoTFileImportLog."Import By" := USERID;
          IoTFileImportLog.Status := IoTFileImportLog.Status::Error;
          IoTFileImportLog."Error Text" := COPYSTR(GETLASTERRORTEXT,1,250);
          IoTFileImportLog.INSERT(TRUE);
          COMMIT;
        END;
    end;

    procedure ProcessInvtSalesShipFiles()
    var
        IoTFileImportLog: Record "50045";
        LastDocNo_lCod: Code[250];
    begin
        CLEARLASTERROR;
        CLEAR(Ins);
        CLEAR(SourceFile);

        IF GUIALLOWED THEN
          Window.UPDATE(1,MyFile.Name);

        SourceFile.TEXTMODE(TRUE);
        SourceFile.OPEN(MyFile.Path + MyFile.Name);
        SourceFile.CREATEINSTREAM(Ins);
        CLEAR(ImportIoTInvtPickData);
        ImportIoTSalesShipData.SetFileName(MyFile.Name);
        ImportIoTSalesShipData.SETSOURCE(Ins);
        IF ImportIoTSalesShipData.IMPORT THEN BEGIN
          SuccessCount += 1;
          IF InvtSetup."Delete IoT File on Success" THEN BEGIN
            SourceFile.CLOSE;
            ERASE(MyFile.Path + MyFile.Name);
          END ELSE BEGIN
            SourceFile.CLOSE;
            FILE.COPY(MyFile.Path + MyFile.Name, Successpath + MyFile.Name);
            ERASE(MyFile.Path + MyFile.Name);
          END;

          IoTFileImportLog.RESET;
          CLEAR(IoTFileImportLog);
          IoTFileImportLog."File Name" := MyFile.Name;
          IoTFileImportLog."Import Date" := TODAY;
          IoTFileImportLog."Import Time" := TIME;
          IoTFileImportLog."Import By" := USERID;
          IoTFileImportLog.Status := IoTFileImportLog.Status::Success;
          IoTFileImportLog.INSERT(TRUE);

          COMMIT; // to retain all good values, in case other files fail
        END ELSE BEGIN
          ErrorCount += 1;

          SourceFile.CLOSE;
          FILE.COPY(MyFile.Path + MyFile.Name,Errorpath + MyFile.Name);
          ERASE(MyFile.Path + MyFile.Name);

          IoTFileImportLog.RESET;
          CLEAR(IoTFileImportLog);
          IoTFileImportLog."File Name" := MyFile.Name;
          IoTFileImportLog."Import Date" := TODAY;
          IoTFileImportLog."Import Time" := TIME;
          IoTFileImportLog."Import By" := USERID;
          IoTFileImportLog.Status := IoTFileImportLog.Status::Error;
          IoTFileImportLog."Error Text" := COPYSTR(GETLASTERRORTEXT,1,250);
          IoTFileImportLog.INSERT(TRUE);
          COMMIT;
        END;
    end;

    local procedure ValidateDirectoryPath(FileDirectory_iTxt: Text[250]): Boolean
    var
        SystemDirectoryServer_lDnt: DotNet Directory0;
    begin
        IF SystemDirectoryServer_lDnt.Exists(FileDirectory_iTxt) THEN
          EXIT(TRUE)
        ELSE
          EXIT(FALSE);
    end;

    local procedure SendStatusEmail()
    var
        SMTPMailSetup: Record "409";
        IoTFileImportLog: Record "50045";
        IoTFileImportLogM: Record "50045";
        SMTPMail: Codeunit "400";
        EmailTo: Text[1024];
        EmailCC: Text[1024];
        EmailBCC: Text[1024];
        FileCount: Integer;
        j: Integer;
        Recipients: Text[250];
    begin
        IF NOT InvtSetup."Send Email Notifications" THEN
          EXIT;

        IoTFileImportLog.RESET;
        IoTFileImportLog.SETRANGE(Status,IoTFileImportLog.Status::Error);
        IF IoTFileImportLog.FINDSET THEN BEGIN
          SMTPMailSetup.GET;
          IF SMTPMailSetup.Authentication = SMTPMailSetup.Authentication::Basic THEN
            SMTPMailSetup.TESTFIELD("User ID");

          GetEmailAddress(EmailTo,EmailCC,EmailBCC);
          Recipients := '';
          Recipients := EmailTo + '|' + EmailCC + '|' + EmailBCC;
          SMTPMail.CreateMessage('IoT File Import Error',SMTPMailSetup."User ID",EmailTo,'IoT File Import Error',EMAIL_TEXT1,TRUE);


          j := 0;
          REPEAT
            IF (((IoTFileImportLog."Email Notification Sent") AND
                (IoTFileImportLog."Resend Email Notfication")) OR
               (NOT IoTFileImportLog."Email Notification Sent"))
            THEN BEGIN
              j += 1;
              SMTPMail.AppendBody('<BR/>');
              IF j = 1 THEN BEGIN
                SMTPMail.AppendBody('<table style="width:100%">');
                SMTPMail.AppendBody('<tr><td align ="left">File Name</td><td align ="left">Status</td><td align ="left">Error Text</td><td align ="left">Date Processed</td></tr>');
                SMTPMail.AppendBody('<BR/>');
                SMTPMail.AppendBody('</table>');
                SMTPMail.AppendBody('<hr>');
                SMTPMail.AppendBody('<BR/>');
              END;

              SMTPMail.AppendBody('<table style="width:100%">');
              SMTPMail.AppendBody('<tr><td align ="left">' + FORMAT(IoTFileImportLog."File Name") + '</td><td align ="left">' + FORMAT(IoTFileImportLog.Status) + '</td><td align ="left">' + FORMAT(IoTFileImportLog."Error Text") +
                 '</td><td align ="left"> ' + FORMAT(IoTFileImportLog."Date Processed On") + '</td></tr>');
              SMTPMail.AppendBody('<BR/>');
              SMTPMail.AppendBody('</table>');

              IoTFileImportLogM.RESET;
              IoTFileImportLogM.GET(IoTFileImportLog."Entry No.");
              IoTFileImportLogM."Email Notification Sent" := TRUE;
              IoTFileImportLogM."Resend Email Notfication" := FALSE;
              IoTFileImportLogM."Email Recipients" := Recipients;
              IF IoTFileImportLogM."Resend Email Notfication" THEN
                IoTFileImportLogM."Email Notifications Sent On 2" := CURRENTDATETIME
              ELSE
                IoTFileImportLogM."Email Notifications Sent On" := CURRENTDATETIME;
              IoTFileImportLogM.MODIFY;
            END;
          UNTIL IoTFileImportLog.NEXT = 0;
          SMTPMail.AppendBody('<BR/>');
          SMTPMail.AppendBody(EMAIL_TEXT3);
          SMTPMail.AppendBody('<BR/>');
          SMTPMail.AppendBody(EMAIL_TEXT4);
          SMTPMail.Send;
        END;
    end;

    procedure GetEmailAddress(var pTo: Text[1024];var pCC: Text[1024];var pBCC: Text[1024])
    begin
        CLEAR(pTo);
        CLEAR(pCC);
        CLEAR(pBCC);

        pTo := InvtSetup."IoT Admin. Email";
        pCC := InvtSetup."IoT Admin. CC Email";
    end;
}

