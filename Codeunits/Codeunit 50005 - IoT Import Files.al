codeunit 50005 "IoT Import Files"
{
    // CIS.IoT 07/22/22 RAM Created new Object


    trigger OnRun()
    var
        IoTFileImportLog: Record 50045;
    begin
        pString := DocType1;
        ProcessAll(FALSE);

        pString := DocType2;
        ProcessAll(FALSE);

        pString := DocType3;
        ProcessAll(FALSE);

        IoTFileImportLog.RESET();
        //IoTFileImportLog.SETRANGE("Import Date",TODAY);
        IoTFileImportLog.SETRANGE(Status, IoTFileImportLog.Status::Error);
        IF IoTFileImportLog.FINDSET() THEN
            SendStatusEmail();
    end;

    var
        InvtSetup: Record 313;
        MyFile: Record 2000000022;
        FileMgt: Codeunit "File Management";
        TempBlobg: codeunit "Temp Blob";
        //  ImportIoTInvtPickData: XMLport 50002;
        ImportIoTTransRcptData: XMLport 50003;
        //ImportIoTSalesShipData: XMLport 50035;
        pString: Code[30];
        Window: Dialog;
        SourceFile: File;
        Ins: InStream;
        ErrorCount: Integer;
        LastUsedLineNo: Integer;
        SuccessCount: Integer;
        CONFIRM_MSG: Label 'Do you want to import/update order?';
        DIALOG_TEXT1: Label 'Import Files....\';
        DIALOG_TEXT2: Label 'File Name #1################', Comment = '%1';
        DocType1: Label 'Invt. Pick.';
        DocType2: Label 'Trans. Rcpt.';
        DocType3: Label 'Sales Ship';
        FOLDER_NOT_FOUND: Label 'Could not find folder %1', Comment = '%1';
        NOTHING_MSG: Label 'There is nothing to import.';
        STATUS_MSG: Label 'Files Imported: %1\Orders Failed: %2', Comment = '%1 %2';
        Outstreamg: OutStream;
        BackSlashstr: Text[1];
        Errorpath: Text[250];
        Sourcepath: Text[250];
        Successpath: Text[250];

    procedure ProcessAll(parShowMsg: Boolean)
    var
        IoTFileImportLog: Record 50045;
    begin
        IF GUIALLOWED THEN
            IF NOT CONFIRM(CONFIRM_MSG, TRUE) THEN
                EXIT;

        CLEAR(Sourcepath);
        CLEAR(Errorpath);
        CLEAR(Successpath);

        CheckSetup();

        MyFile.RESET();

        MyFile.SETRANGE(Path, Sourcepath);
        MyFile.SETRANGE("Is a file", TRUE);
        MyFile.SETFILTER(Name, '@*.csv');
        IF MyFile.FINDSET() THEN BEGIN
            IF GUIALLOWED THEN
                Window.OPEN(DIALOG_TEXT1 + DIALOG_TEXT2);


            IoTFileImportLog.RESET();
            IF IoTFileImportLog.FINDLAST() THEN
                LastUsedLineNo := IoTFileImportLog."Entry No.";

            REPEAT
                CASE TRUE OF
                    pString = UPPERCASE(DocType1):
                        ProcessInvtPickFiles();
                    pString = UPPERCASE(DocType2):
                        ProcessInvtTransRcptFiles();
                    pString = UPPERCASE(DocType3):
                        ProcessInvtSalesShipFiles();
                END;
            UNTIL MyFile.NEXT() = 0;

            IF GUIALLOWED THEN
                Window.CLOSE();

            IF parShowMsg THEN
                ShowMessage();
        END ELSE
            IF GUIALLOWED THEN
                MESSAGE(NOTHING_MSG);
    end;

    procedure CheckSetup()
    begin
        CLEAR(Sourcepath);
        CLEAR(Errorpath);
        CLEAR(Successpath);
        InvtSetup.GET();

        CASE TRUE OF
            pString = UPPERCASE(DocType1):
                BEGIN
                    InvtSetup.TESTFIELD("Invt. Pick File Path");
                    Sourcepath := InvtSetup."Invt. Pick File Path";
                    BackSlashstr := COPYSTR(Sourcepath, STRLEN(Sourcepath), 1);
                    IF BackSlashstr <> '\' THEN
                        Sourcepath := Sourcepath + '\';
                    Errorpath := Sourcepath + 'Error\';
                    Successpath := Sourcepath + 'Archive\';
                END;
            pString = UPPERCASE(DocType2):
                BEGIN
                    InvtSetup.TESTFIELD("Tras. Rcpt. File Path");
                    Sourcepath := InvtSetup."Tras. Rcpt. File Path";
                    BackSlashstr := COPYSTR(Sourcepath, STRLEN(Sourcepath), 1);
                    IF BackSlashstr <> '\' THEN
                        Sourcepath := Sourcepath + '\';
                    Errorpath := Sourcepath + 'Error\';
                    Successpath := Sourcepath + 'Archive\';
                END;
            pString = UPPERCASE(DocType3):
                BEGIN
                    InvtSetup.TESTFIELD("Sales Ship. File Path");
                    Sourcepath := InvtSetup."Sales Ship. File Path";
                    BackSlashstr := COPYSTR(Sourcepath, STRLEN(Sourcepath), 1);
                    IF BackSlashstr <> '\' THEN
                        Sourcepath := Sourcepath + '\';
                    Errorpath := Sourcepath + 'Error\';
                    Successpath := Sourcepath + 'Archive\';
                END;
        END;

        IF Sourcepath = '' THEN
            ERROR('Sourcepath is blank. Checkit');

        //check folders
        // IF NOT ValidateDirectoryPath(Errorpath) THEN
        //     ERROR(FOLDER_NOT_FOUND, Errorpath);
        // IF NOT ValidateDirectoryPath(Sourcepath) THEN
        //     ERROR(FOLDER_NOT_FOUND, Sourcepath);
        // IF NOT InvtSetup."Delete IoT File on Success" THEN
        //     IF NOT ValidateDirectoryPath(Successpath) THEN
        //         ERROR(FOLDER_NOT_FOUND, Successpath);
    end;

    procedure ShowMessage()
    begin
        IF GUIALLOWED THEN
            MESSAGE(STATUS_MSG, FORMAT(SuccessCount), FORMAT(ErrorCount));
    end;

    procedure ProcessInvtPickFiles()
    var
        IoTFileImportLog: Record 50045;
    begin
        CLEARLASTERROR();
        CLEAR(Ins);
        CLEAR(SourceFile);

        IF GUIALLOWED THEN
            Window.UPDATE(1, MyFile.Name);

        // SourceFile.TEXTMODE(TRUE);
        // SourceFile.OPEN(MyFile.Path + MyFile.Name);
        // SourceFile.CREATEINSTREAM(Ins);
        // CLEAR(ImportIoTInvtPickData);
        // ImportIoTInvtPickData.SetFileName(MyFile.Name);
        // ImportIoTInvtPickData.SETSOURCE(Ins);
        // IF ImportIoTInvtPickData.IMPORT() THEN BEGIN
        //     SuccessCount += 1;
        //     IF InvtSetup."Delete IoT File on Success" THEN BEGIN
        //         SourceFile.CLOSE;
        //         ERASE(MyFile.Path + MyFile.Name);
        //     END ELSE BEGIN
        //         SourceFile.CLOSE;
        //         FILE.COPY(MyFile.Path + MyFile.Name, Successpath + MyFile.Name);
        //         ERASE(MyFile.Path + MyFile.Name);
        //     END;
        if not UploadIntoStream('Select EDI XML File', '', '', MyFile.Name, InS) then
            exit;

        Clear(ImportIoTTransRcptData);
        ImportIoTTransRcptData.SetSource(InS);

        if ImportIoTTransRcptData.Import() then begin
            SuccessCount += 1;
            // LastDocNo_lCod := ImportIoTTransRcptData.GetOrderNo();
            //AddToDocNos(LastDocNo_lCod);
            TempBlobg.CreateOutStream(Outstreamg);
            CopyStream(Outstreamg, InS);
            //FileMgt.BLOBExport(TempBlobg, EDISetup."XML Success Folder" + MyFile.Name, true);


            IoTFileImportLog.RESET();
            CLEAR(IoTFileImportLog);
            IoTFileImportLog."File Name" := MyFile.Name;
            IoTFileImportLog."Import Date" := TODAY;
            IoTFileImportLog."Import Time" := TIME;
            IoTFileImportLog."Import By" := USERID;
            IoTFileImportLog.Status := IoTFileImportLog.Status::Success;
            IoTFileImportLog.INSERT(TRUE);

            COMMIT(); // to retain all good values, in case other files fail
        END ELSE BEGIN
            ErrorCount += 1;

            //  SourceFile.CLOSE;
            //FILE.COPY(MyFile.Path + MyFile.Name, Errorpath + MyFile.Name);
            //ERASE(MyFile.Path + MyFile.Name);

            IoTFileImportLog.RESET();
            CLEAR(IoTFileImportLog);
            IoTFileImportLog."File Name" := MyFile.Name;
            IoTFileImportLog."Import Date" := TODAY;
            IoTFileImportLog."Import Time" := TIME;
            IoTFileImportLog."Import By" := USERID;
            IoTFileImportLog.Status := IoTFileImportLog.Status::Error;
            IoTFileImportLog."Error Text" := COPYSTR(GETLASTERRORTEXT, 1, 250);
            IoTFileImportLog.INSERT(TRUE);
            COMMIT();
        END;
    end;

    procedure ProcessInvtTransRcptFiles()
    var
        IoTFileImportLog: Record 50045;
    begin
        CLEARLASTERROR();
        CLEAR(Ins);
        CLEAR(SourceFile);

        IF GUIALLOWED THEN
            Window.UPDATE(1, MyFile.Name);

        // SourceFile.TEXTMODE(TRUE);
        // SourceFile.OPEN(MyFile.Path + MyFile.Name);
        // SourceFile.CREATEINSTREAM(Ins);
        // CLEAR(ImportIoTInvtPickData);
        // ImportIoTInvtPickData.SetFileName(MyFile.Name);
        // ImportIoTTransRcptData.SETSOURCE(Ins);
        // IF ImportIoTTransRcptData.IMPORT() THEN BEGIN
        //     SuccessCount += 1;
        //     IF InvtSetup."Delete IoT File on Success" THEN BEGIN
        //         SourceFile.CLOSE;
        //         ERASE(MyFile.Path + MyFile.Name);
        //     END ELSE BEGIN
        //         SourceFile.CLOSE;
        //         FILE.COPY(MyFile.Path + MyFile.Name, Successpath + MyFile.Name);
        //         ERASE(MyFile.Path + MyFile.Name);
        //     END;
        if not UploadIntoStream('Select EDI XML File', '', '', MyFile.Name, InS) then
            exit;

        Clear(ImportIoTTransRcptData);
        ImportIoTTransRcptData.SetSource(InS);

        if ImportIoTTransRcptData.Import() then begin
            SuccessCount += 1;
            // LastDocNo_lCod := ImportIoTTransRcptData.GetOrderNo();
            //AddToDocNos(LastDocNo_lCod);
            TempBlobg.CreateOutStream(Outstreamg);
            CopyStream(Outstreamg, InS);
            FileMgt.BLOBExport(TempBlobg, EDISetup."XML Success Folder" + MyFile.Name, true);


            IoTFileImportLog.RESET();
            CLEAR(IoTFileImportLog);
            IoTFileImportLog."File Name" := MyFile.Name;
            IoTFileImportLog."Import Date" := TODAY;
            IoTFileImportLog."Import Time" := TIME;
            IoTFileImportLog."Import By" := USERID;
            IoTFileImportLog.Status := IoTFileImportLog.Status::Success;
            IoTFileImportLog.INSERT(TRUE);

            COMMIT(); // to retain all good values, in case other files fail
        END ELSE BEGIN
            ErrorCount += 1;

            //  SourceFile.CLOSE;
            //FILE.COPY(MyFile.Path + MyFile.Name, Errorpath + MyFile.Name);
            //ERASE(MyFile.Path + MyFile.Name);

            IoTFileImportLog.RESET();
            CLEAR(IoTFileImportLog);
            IoTFileImportLog."File Name" := MyFile.Name;
            IoTFileImportLog."Import Date" := TODAY;
            IoTFileImportLog."Import Time" := TIME;
            IoTFileImportLog."Import By" := USERID;
            IoTFileImportLog.Status := IoTFileImportLog.Status::Error;
            IoTFileImportLog."Error Text" := COPYSTR(GETLASTERRORTEXT, 1, 250);
            IoTFileImportLog.INSERT(TRUE);
            COMMIT();
        END;
    end;

    procedure ProcessInvtSalesShipFiles()
    var
        IoTFileImportLog: Record 50045;
    begin
        CLEARLASTERROR();
        CLEAR(Ins);
        CLEAR(SourceFile);

        IF GUIALLOWED THEN
            Window.UPDATE(1, MyFile.Name);

        // SourceFile.TEXTMODE(TRUE);
        // SourceFile.OPEN(MyFile.Path + MyFile.Name);
        // SourceFile.CREATEINSTREAM(Ins);
        // CLEAR(ImportIoTInvtPickData);
        // ImportIoTSalesShipData.SetFileName(MyFile.Name);
        // ImportIoTSalesShipData.SETSOURCE(Ins);
        // IF ImportIoTSalesShipData.IMPORT() THEN BEGIN
        //     SuccessCount += 1;
        //     IF InvtSetup."Delete IoT File on Success" THEN BEGIN
        //         SourceFile.CLOSE;
        //         ERASE(MyFile.Path + MyFile.Name);
        //     END ELSE BEGIN
        //         SourceFile.CLOSE;
        //         FILE.COPY(MyFile.Path + MyFile.Name, Successpath + MyFile.Name);
        //         ERASE(MyFile.Path + MyFile.Name);
        //     END;
        if not UploadIntoStream('Select EDI XML File', '', '', MyFile.Name, InS) then
            exit;

        Clear(ImportIoTTransRcptData);
        ImportIoTTransRcptData.SetSource(InS);

        if ImportIoTTransRcptData.Import() then begin
            SuccessCount += 1;
            // LastDocNo_lCod := ImportIoTTransRcptData.GetOrderNo();
            //AddToDocNos(LastDocNo_lCod);
            TempBlobg.CreateOutStream(Outstreamg);
            CopyStream(Outstreamg, InS);
            DownloadFromStream(Ins, '', '', '', EDISetup."XML Success Folder");
            // FileMgt.BLOBExport(TempBlobg, EDISetup."XML Success Folder" + MyFile.Name, true);


            IoTFileImportLog.RESET();
            CLEAR(IoTFileImportLog);
            IoTFileImportLog."File Name" := MyFile.Name;
            IoTFileImportLog."Import Date" := TODAY;
            IoTFileImportLog."Import Time" := TIME;
            IoTFileImportLog."Import By" := USERID;
            IoTFileImportLog.Status := IoTFileImportLog.Status::Success;
            IoTFileImportLog.INSERT(TRUE);

            COMMIT(); // to retain all good values, in case other files fail
        END ELSE BEGIN
            ErrorCount += 1;

            // SourceFile.CLOSE;
            //FILE.COPY(MyFile.Path + MyFile.Name, Errorpath + MyFile.Name);
            //ERASE(MyFile.Path + MyFile.Name);

            IoTFileImportLog.RESET();
            CLEAR(IoTFileImportLog);
            IoTFileImportLog."File Name" := MyFile.Name;
            IoTFileImportLog."Import Date" := TODAY;
            IoTFileImportLog."Import Time" := TIME;
            IoTFileImportLog."Import By" := USERID;
            IoTFileImportLog.Status := IoTFileImportLog.Status::Error;
            IoTFileImportLog."Error Text" := COPYSTR(GETLASTERRORTEXT, 1, 250);
            IoTFileImportLog.INSERT(TRUE);
            COMMIT();
        END;
    end;

    // local procedure ValidateDirectoryPath(FileDirectory_iTxt: Text[250]): Boolean
    // var
    //     SystemDirectoryServer_lDnt: DotNet Directory0;
    // begin
    //     IF SystemDirectoryServer_lDnt.Exists(FileDirectory_iTxt) THEN
    //         EXIT(TRUE)
    //     ELSE
    //         EXIT(FALSE);
    // end;

    // local procedure SendStatusEmail()
    // var
    //     SMTPMailSetup: Record 409;
    //     IoTFileImportLog: Record 50045;
    //     IoTFileImportLogM: Record 50045;
    //     SMTPMail: Codeunit 400;
    //     EmailTo: Text[1024];
    //     EmailCC: Text[1024];
    //     EmailBCC: Text[1024];
    //     FileCount: Integer;
    //     j: Integer;
    //     Recipients: Text[250];
    // begin
    //     IF NOT InvtSetup."Send Email Notifications" THEN
    //       EXIT;

    //     IoTFileImportLog.RESET;
    //     IoTFileImportLog.SETRANGE(Status,IoTFileImportLog.Status::Error);
    //     IF IoTFileImportLog.FINDSET THEN BEGIN
    //       SMTPMailSetup.GET;
    //       IF SMTPMailSetup.Authentication = SMTPMailSetup.Authentication::Basic THEN
    //         SMTPMailSetup.TESTFIELD("User ID");

    //       GetEmailAddress(EmailTo,EmailCC,EmailBCC);
    //       Recipients := '';
    //       Recipients := EmailTo + '|' + EmailCC + '|' + EmailBCC;
    //       SMTPMail.CreateMessage('IoT File Import Error',SMTPMailSetup."User ID",EmailTo,'IoT File Import Error',EMAIL_TEXT1,TRUE);


    //       j := 0;
    //       REPEAT
    //         IF (((IoTFileImportLog."Email Notification Sent") AND
    //             (IoTFileImportLog."Resend Email Notfication")) OR
    //            (NOT IoTFileImportLog."Email Notification Sent"))
    //         THEN BEGIN
    //           j += 1;
    //           SMTPMail.AppendBody('<BR/>');
    //           IF j = 1 THEN BEGIN
    //             SMTPMail.AppendBody('<table style="width:100%">');
    //             SMTPMail.AppendBody('<tr><td align ="left">File Name</td><td align ="left">Status</td><td align ="left">Error Text</td><td align ="left">Date Processed</td></tr>');
    //             SMTPMail.AppendBody('<BR/>');
    //             SMTPMail.AppendBody('</table>');
    //             SMTPMail.AppendBody('<hr>');
    //             SMTPMail.AppendBody('<BR/>');
    //           END;

    //           SMTPMail.AppendBody('<table style="width:100%">');
    //           SMTPMail.AppendBody('<tr><td align ="left">' + FORMAT(IoTFileImportLog."File Name") + '</td><td align ="left">' + FORMAT(IoTFileImportLog.Status) + '</td><td align ="left">' + FORMAT(IoTFileImportLog."Error Text") +
    //              '</td><td align ="left"> ' + FORMAT(IoTFileImportLog."Date Processed On") + '</td></tr>');
    //           SMTPMail.AppendBody('<BR/>');
    //           SMTPMail.AppendBody('</table>');

    //           IoTFileImportLogM.RESET;
    //           IoTFileImportLogM.GET(IoTFileImportLog."Entry No.");
    //           IoTFileImportLogM."Email Notification Sent" := TRUE;
    //           IoTFileImportLogM."Resend Email Notfication" := FALSE;
    //           IoTFileImportLogM."Email Recipients" := Recipients;
    //           IF IoTFileImportLogM."Resend Email Notfication" THEN

    //             IoTFileImportLogM."Email Notifications Sent On 2" := CURRENTDATETIME
    //           ELSE
    //             IoTFileImportLogM."Email Notifications Sent On" := CURRENTDATETIME;
    //           IoTFileImportLogM.MODIFY;
    //         END;
    //       UNTIL IoTFileImportLog.NEXT = 0;
    //       SMTPMail.AppendBody('<BR/>');
    //       SMTPMail.AppendBody(EMAIL_TEXT3);
    //       SMTPMail.AppendBody('<BR/>');
    //       SMTPMail.AppendBody(EMAIL_TEXT4);
    //       SMTPMail.Send;
    //     END;
    // end;
    local procedure SendStatusEmail()
    var
        IoTFileImportLog: Record 50045;
        IoTFileImportLogM: Record 50045;
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        j: Integer;
        EMAIL_TEXT1: Label 'Dear User,';
        EMAIL_TEXT3: Label 'Regards,';
        EMAIL_TEXT4: Label 'Systems Auto Alert';
        TEXT001: Label '<tr><td>%1</td><td>%2</td><td>%3</td><td>%4</td></tr>', Comment = '%1 %2 %3 %4';
        BCCRecipients: List of [Text];
        CCRecipients: List of [Text];
        ToRecipients: List of [Text];
        Recipients: Text[250];
        EmailBCC: Text[1024];
        EmailCC: Text[1024];
        EmailTo: Text[1024];
        EmailBody: TextBuilder;
    begin
        if not InvtSetup."Send Email Notifications" then
            exit;

        IoTFileImportLog.Reset();
        IoTFileImportLog.SetRange(Status, IoTFileImportLog.Status::Error);

        if IoTFileImportLog.FindSet() then begin
            // Get recipients (assuming existing helper procedure)
            GetEmailAddress(EmailTo, EmailCC, EmailBCC);

            // Prepare recipient lists
            Clear(ToRecipients);
            Clear(CCRecipients);
            Clear(BCCRecipients);

            if EmailTo <> '' then
                ToRecipients.Add(EmailTo);
            if EmailCC <> '' then
                CCRecipients.Add(EmailCC);
            if EmailBCC <> '' then
                BCCRecipients.Add(EmailBCC);

            Recipients := EmailTo + '|' + EmailCC + '|' + EmailBCC;

            // Build email body
            EmailBody.Clear();
            EmailBody.AppendLine(EMAIL_TEXT1);
            EmailBody.AppendLine('<br/><hr/>');
            EmailBody.AppendLine('<table style="width:100%">');
            EmailBody.AppendLine('<tr><th align="left">File Name</th><th align="left">Status</th><th align="left">Error Text</th><th align="left">Date Processed</th></tr>');

            j := 0;
            repeat
                if (((IoTFileImportLog."Email Notification Sent") and
                     (IoTFileImportLog."Resend Email Notfication")) or
                    (not IoTFileImportLog."Email Notification Sent"))
                then begin
                    j += 1;

                    EmailBody.AppendLine(
                        StrSubstNo(
                            TEXT001,
                            IoTFileImportLog."File Name",
                            Format(IoTFileImportLog.Status),
                            IoTFileImportLog."Error Text",
                            Format(IoTFileImportLog."Date Processed On")
                        ));

                    IoTFileImportLogM.Get(IoTFileImportLog."Entry No.");
                    IoTFileImportLogM."Email Notification Sent" := true;
                    IoTFileImportLogM."Resend Email Notfication" := false;
                    IoTFileImportLogM."Email Recipients" := Recipients;
                    if IoTFileImportLogM."Resend Email Notfication" then
                        IoTFileImportLogM."Email Notifications Sent On 2" := CurrentDateTime
                    else
                        IoTFileImportLogM."Email Notifications Sent On" := CurrentDateTime;
                    IoTFileImportLogM.Modify();
                end;
            until IoTFileImportLog.Next() = 0;

            EmailBody.AppendLine('</table><br/><hr/>');
            EmailBody.AppendLine(EMAIL_TEXT3);
            EmailBody.AppendLine('<br/>');
            EmailBody.AppendLine(EMAIL_TEXT4);

            // Create and send email
            EmailMessage.Create(
                ToRecipients,
                'IoT File Import Error',
                EmailBody.ToText(),
                true);

            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
        end;
    end;

    procedure GetEmailAddress(var pTo: Text[1024]; var pCC: Text[1024]; var pBCC: Text[1024])
    begin
        CLEAR(pTo);
        CLEAR(pCC);
        CLEAR(pBCC);

        pTo := InvtSetup."IoT Admin. Email";
        pCC := InvtSetup."IoT Admin. CC Email";
    end;
}

