codeunit 50001 "Process EDI XML File JRR"
{
    // NF1.00:CIS.NG    10/05/15 Merge the (AP6) Functionality object provided by Jagdish
    // NF1.00:CIS.NG    10/15/15 XMLport Development - EDI Sales Order Import
    // NF1.00:CIS.NG    10/30/15 XMLport Development - Added code send email status after import files
    // NF1.00:CIS.JR    12/03/15 XMLport Development - Added emails for Don/Shimpei
    // NF1.00:CIS.JR    07/17/16 XMLport Development - Added conditional emails for USA,Canada,Rome
    // NF1.00:CIS.NG    07/28/16 Change the Data Type of field - DocNos: Code 1000 --> Text Unlimited
    // 
    // DMS0001 TJB 05/10/10:
    //   - Created codeunit to process one single EDI XML document
    // 10/10/16:JRR: Demo Don / Shimpei on how to add / remove edi address
    // 
    // 11/22/21 CIS.Ram
    //   Removed: brahmbhatt.k@nifast.com
    //   Added: insisiengmay.p@nifast.com and ozeki.a@nifast.com

    TableNo = 472;

    trigger OnRun()
    begin
        pString := UPPERCASE(Rec."Parameter String");
        ProcessAll(FALSE);
    end;

    var
        EDISetup: Record 14002367;
        MyFile: Record 2000000022;
        FileMgt: Codeunit "File Management";
        TempBlobg: codeunit "Temp Blob";
        ImportEDISalesOrder: XMLport 50000;
        //ImportEDIForecast: XMLport 50001;
        pString: Code[30];
        Window: Dialog;
        SourceFile: File;
        Ins: InStream;
        ErrorCount: Integer;
        LastUsedLineNo: Integer;
        SuccessCount: Integer;
        BCCEmail: Label '';
        CCEmail: Label '';
        CONFIRM_MSG: Label 'Do you want to import/update order?';
        DIALOG_TEXT1: Label 'Import Files....\';
        DIALOG_TEXT2: Label 'File Name #1################', Comment = '%1';
        EMAIL_TEXT2: Label 'Error Notification';
        EMAIL_TEXT3: Label 'Regards,';
        EMAIL_TEXT4: Label '%1 - Systems Auto Alert', Comment = '%1';
        EMAIL_TEXT6: Label 'Order Processed : %1', Comment = '%1';
        EMAIL_TEXT7: Label 'Order Failed : %1', Comment = '%1';
        //FOLDER_NOT_FOUND: Label 'Could not find folder %1', Comment = '%1';
        NOTHING_MSG: Label 'There is nothing to import.';
        STATUS_MSG: Label 'Orders Created: %1 (%2)\Orders Failed: %3', Comment = '%1 %2 %3';
        SUPPORTUSER: Label 'Nifast Support';
        To_NC1: Label 'bell.a@nifast.com;muraoka.s@nifast.com;traficanti.s@nifast.com;cecchin.d@nifast.com;';
        To_NC2: Label 'cecchin.d@nifast.com';
        To_NUSA: Label 'kamiuchi.s@nifast.com;leonido.m@nifast.com;insisiengmay.p@nifast.com;ozeki.a@nifast.com;muraoka.s@nifast.com;traficanti.s@nifast.com;shimizu.k@nifast.com';
        ToEmail: Label 'muraoka.s@nifast.com';
        Outstreamg: OutStream;
        DocNos: Text;
        BackSlashstr: Text[1];
        Errorpath: Text[250];
        Sourcepath: Text[250];
        Successpath: Text[250];

    procedure ProcessAll(parShowMsg: Boolean)
    var
        EDISalesOrderImportLog: Record 50031;
    begin
        IF GUIALLOWED THEN
            IF NOT CONFIRM(CONFIRM_MSG, TRUE) THEN
                EXIT;
        CLEAR(Sourcepath);
        CLEAR(Errorpath);
        CLEAR(Successpath);

        CheckSetup();

        MyFile.RESET();
        //MyFile.SETRANGE(Path,EDISetup."XML Source Document Folder");
        MyFile.SETRANGE(Path, Sourcepath);
        MyFile.SETRANGE("Is a file", TRUE);
        MyFile.SETFILTER(Name, '@*.xml');
        IF MyFile.FINDSET() THEN BEGIN
            IF GUIALLOWED THEN
                Window.OPEN(DIALOG_TEXT1 + DIALOG_TEXT2);


            EDISalesOrderImportLog.RESET();
            IF EDISalesOrderImportLog.FINDLAST() THEN
                LastUsedLineNo := EDISalesOrderImportLog."Entry No.";

            REPEAT
                IF pString = 'SALESORDER' THEN       //jrr
                    ProcessEDISalesOrderIn()       // ***************()       // ***************
                ELSE
                    ProcessEDIForecastIn();
            UNTIL MyFile.NEXT() = 0;

            IF GUIALLOWED THEN
                Window.CLOSE();

            SendStatusEmail();
            IF parShowMsg THEN
                ShowMessage();
        END ELSE
            IF GUIALLOWED THEN
                MESSAGE(NOTHING_MSG);
    end;

    procedure CheckSetup()
    var
        Frompos: Integer;
    begin
        // check EDI setup
        CLEAR(Sourcepath);
        CLEAR(Errorpath);
        CLEAR(Successpath);
        EDISetup.GET();
        //jrr start
        IF pString = 'SALESORDER' THEN BEGIN
            //EDISetup.TESTFIELD("XML Source Document Folder");//TODO
            Sourcepath := EDISetup."XML Source Document Folder";
            BackSlashstr := COPYSTR(Sourcepath, STRLEN(Sourcepath), 1);   //'\');
            IF BackSlashstr <> '\' THEN
                Sourcepath := Sourcepath + '\';
            Frompos := STRPOS(Sourcepath, 'Source');
            Errorpath := DELSTR(Sourcepath, Frompos, 6);
            Errorpath := INSSTR(Errorpath, 'Error', Frompos);
            Successpath := DELSTR(Sourcepath, Frompos, 6);
            Successpath := INSSTR(Successpath, 'Success', Frompos);
        END ELSE BEGIN
            // EDISetup.TESTFIELD("XML Forecast Folder"); //TODO    //("XML Error Folder");
            Sourcepath := EDISetup."XML Forecast Folder";
            BackSlashstr := COPYSTR(Sourcepath, STRLEN(Sourcepath), 1);   //'\');
            IF BackSlashstr <> '\' THEN
                Sourcepath := Sourcepath + '\';
            Frompos := STRPOS(Sourcepath, 'Forecast');
            Errorpath := DELSTR(Sourcepath, Frompos, 8);
            Errorpath := INSSTR(Errorpath, 'Error', Frompos);
            Successpath := DELSTR(Sourcepath, Frompos, 8);
            Successpath := INSSTR(Successpath, 'Success', Frompos);
        END;

        IF Sourcepath = '' THEN
            ERROR('Sourcepath is blank. Checkit');

        /*
        IF NOT EDISetup."Delete XML on Success" THEN
          EDISetup.TESTFIELD("XML Success Folder");
        */
        //jrr end

        // check folders         //jrr
        // IF NOT ValidateDirectoryPath(Errorpath) THEN   //EDISetup."XML Error Folder") THEN
        //     ERROR(FOLDER_NOT_FOUND, Errorpath);  //EDISetup."XML Error Folder");
        // IF NOT ValidateDirectoryPath(Sourcepath) THEN   //EDISetup."XML Source Document Folder") THEN
        //     ERROR(FOLDER_NOT_FOUND, Sourcepath);  //EDISetup."XML Source Document Folder");
        // IF NOT EDISetup."Delete XML on Success" THEN
        //     IF NOT ValidateDirectoryPath(Successpath) THEN   //EDISetup."XML Success Folder") THEN
        //         ERROR(FOLDER_NOT_FOUND, Successpath);   //EDISetup."XML Success Folder");

    end;

    procedure AddToDocNos(parDocNo: Code[20])
    begin
        IF DocNos = '' THEN
            DocNos := parDocNo
        ELSE
            DocNos += '|' + parDocNo;
    end;

    procedure ShowMessage()
    begin
        IF DocNos = '' THEN
            DocNos := '***';
        IF GUIALLOWED THEN
            MESSAGE(STATUS_MSG, FORMAT(SuccessCount), DocNos, FORMAT(ErrorCount));
    end;

    procedure ProcessEDISalesOrderIn()
    var
        EDISalesOrderImportLog: Record 50031;
        LastDocNo_lCod: Code[250];

    begin
        // refresh the instream and import the XML into the EDI Sales Order tables
        CLEARLASTERROR();
        CLEAR(Ins);
        CLEAR(SourceFile);

        IF GUIALLOWED THEN
            Window.UPDATE(1, MyFile.Name);

        // SourceFile.TEXTMODE(TRUE);
        // SourceFile.OPEN(MyFile.Path + MyFile.Name);
        // SourceFile.CREATEINSTREAM(Ins);
        // CLEAR(ImportEDISalesOrder);
        // ImportEDISalesOrder.SETSOURCE(Ins);
        // IF ImportEDISalesOrder.IMPORT() THEN BEGIN
        //     SuccessCount += 1;
        //     LastDocNo_lCod := ImportEDISalesOrder.GetOrderNo();
        //     AddToDocNos(LastDocNo_lCod);
        //     IF EDISetup."Delete XML on Success" THEN BEGIN
        //         SourceFile.CLOSE;
        //         ERASE(MyFile.Path + MyFile.Name);
        //     END ELSE BEGIN
        //         SourceFile.CLOSE;
        //         FILE.COPY(MyFile.Path + MyFile.Name, EDISetup."XML Success Folder" + MyFile.Name);
        //         ERASE(MyFile.Path + MyFile.Name);
        //     END;
        if not UploadIntoStream('Select EDI XML File', '', '', MyFile.Name, InS) then
            exit;

        Clear(ImportEDISalesOrder);
        ImportEDISalesOrder.SetSource(InS);

        if ImportEDISalesOrder.Import() then begin
            SuccessCount += 1;
            LastDocNo_lCod := ImportEDISalesOrder.GetOrderNo();
            AddToDocNos(LastDocNo_lCod);
            TempBlobg.CreateOutStream(Outstreamg);
            CopyStream(Outstreamg, InS);
            FileMgt.BLOBExport(TempBlobg, EDISetup."XML Success Folder" + MyFile.Name, true);


            EDISalesOrderImportLog.RESET();
            CLEAR(EDISalesOrderImportLog);
            EDISalesOrderImportLog."Entry No." := GetLastEntryNo();
            EDISalesOrderImportLog."File Name" := MyFile.Name;
            EDISalesOrderImportLog."Import Date" := TODAY;
            EDISalesOrderImportLog."Import Time" := TIME;
            EDISalesOrderImportLog."Import By" := USERID;
            EDISalesOrderImportLog.Status := EDISalesOrderImportLog.Status::Success;
            EDISalesOrderImportLog."Sales Orders" := COPYSTR(LastDocNo_lCod, 1, 250);
            EDISalesOrderImportLog.INSERT();

            COMMIT(); // to retain all good values, in case other files fail
        END ELSE BEGIN
            ErrorCount += 1;

            // SourceFile.CLOSE;
            // FILE.COPY(MyFile.Path + MyFile.Name, Errorpath + MyFile.Name); //EDISetup."XML Error Folder"
            // ERASE(MyFile.Path + MyFile.Name);

            EDISalesOrderImportLog.RESET();
            CLEAR(EDISalesOrderImportLog);
            EDISalesOrderImportLog."Entry No." := GetLastEntryNo();
            EDISalesOrderImportLog."File Name" := MyFile.Name;
            EDISalesOrderImportLog."Import Date" := TODAY;
            EDISalesOrderImportLog."Import Time" := TIME;
            EDISalesOrderImportLog."Import By" := USERID;
            EDISalesOrderImportLog.Status := EDISalesOrderImportLog.Status::Error;
            EDISalesOrderImportLog."Sales Orders" := COPYSTR(LastDocNo_lCod, 1, 250);
            EDISalesOrderImportLog."Error Detail" := COPYSTR(GETLASTERRORTEXT, 1, 250);
            EDISalesOrderImportLog.INSERT();
            SendErrorEmail(EDISalesOrderImportLog);
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

    local procedure GetLastEntryNo(): Integer
    var
        EDISalesOrderImportLog: Record 50031;
    begin
        EDISalesOrderImportLog.RESET();
        IF EDISalesOrderImportLog.FINDLAST() THEN
            EXIT(EDISalesOrderImportLog."Entry No." + 1)
        ELSE
            EXIT(1);
    end;

    // local procedure SendErrorEmail(EDISalesOrderImportLog: Record 50031)
    // var
    //     SMTPMail: Codeunit 400;
    //     SMTPMailSetup: Record 409;
    //     EmailTo: Text[1024];
    //     EmailCC: Text[1024];
    //     EmailBCC: Text[1024];
    // begin
    //     IF NOT EDISetup."Send Email on Error" THEN
    //       EXIT;

    //     EDISetup.TESTFIELD("Email Title");
    //     EDISetup.TESTFIELD("Email Subject");

    //     SMTPMailSetup.GET;
    //     IF SMTPMailSetup.Authentication = SMTPMailSetup.Authentication::Basic THEN
    //       SMTPMailSetup.TESTFIELD("User ID");

    //     GetEmailAddress('SalesOrder_EDI',EmailTo,EmailCC,EmailBCC);

    //     SMTPMail.CreateMessage(EDISetup."Email Title",SMTPMailSetup."User ID",EmailTo,EDISetup."Email Subject",EMAIL_TEXT1,TRUE);

    //     IF EmailCC <> '' THEN
    //       SMTPMail.AddCC(EmailCC);

    //     IF EmailBCC <> '' THEN
    //       SMTPMail.AddBCC(EmailBCC);

    //     SMTPMail.AppendBody('<BR/>');

    //     SMTPMail.AppendBody('<H4 Style="color:Blue">');
    //     SMTPMail.AppendBody(EMAIL_TEXT2);
    //     SMTPMail.AppendBody('</H4>');

    //     SMTPMail.AppendBody('<table width="100%"><tr><td>');
    //     SMTPMail.AppendBody('<table cellpadding="0" cellspacing="0" style="border:0.3px solid black;" align="left" width="100%">');

    //     TableBodyAppend(SMTPMail,EDISalesOrderImportLog.FIELDCAPTION("Entry No."),FORMAT(EDISalesOrderImportLog."Entry No."));
    //     TableBodyAppend(SMTPMail,EDISalesOrderImportLog.FIELDCAPTION("File Name"),EDISalesOrderImportLog."File Name");
    //     TableBodyAppend(SMTPMail,EDISalesOrderImportLog.FIELDCAPTION("Import Date"),FORMAT(EDISalesOrderImportLog."Import Date"));
    //     TableBodyAppend(SMTPMail,EDISalesOrderImportLog.FIELDCAPTION("Import Time"),FORMAT(EDISalesOrderImportLog."Import Time"));
    //     IF GUIALLOWED THEN
    //       TableBodyAppend(SMTPMail,EDISalesOrderImportLog.FIELDCAPTION("Import By"),EDISalesOrderImportLog."Import By")
    //     ELSE
    //       TableBodyAppend(SMTPMail,EDISalesOrderImportLog.FIELDCAPTION("Import By"),SUPPORTUSER);

    //     TableBodyAppend(SMTPMail,EDISalesOrderImportLog.FIELDCAPTION(Status),FORMAT(EDISalesOrderImportLog.Status));
    //     TableBodyAppend(SMTPMail,EDISalesOrderImportLog.FIELDCAPTION("Error Detail"),EDISalesOrderImportLog."Error Detail");
    //     SMTPMail.AppendBody('</table>');

    //     SMTPMail.AppendBody('<BR/>');
    //     SMTPMail.AppendBody('<BR/>');

    //     SMTPMail.AppendBody('<table><tr><td>');
    //     SMTPMail.AppendBody(EMAIL_TEXT3);
    //     SMTPMail.AppendBody('</td></tr><tr><td>');
    //     SMTPMail.AppendBody(STRSUBSTNO(EMAIL_TEXT4,COMPANYNAME));
    //     SMTPMail.AppendBody('</td></tr></table></td></tr></table>');

    //     SMTPMail.Send;
    // end;

    // local procedure SendStatusEmail()
    // var
    //     SMTPMail: Codeunit 400;
    //     SMTPMailSetup: Record 409;
    //     EmailTo: Text[1024];
    //     EmailCC: Text[1024];
    //     EmailBCC: Text[1024];
    //     EDISalesOrderImportLog: Record 50031;
    //     FileCount: Integer;
    // begin
    //     IF NOT EDISetup."Send Email on Error" THEN
    //       EXIT;

    //     IF SuccessCount = 0 THEN
    //       EXIT;

    //     IF SuccessCount + ErrorCount = 0 THEN
    //       EXIT;

    //     EDISetup.TESTFIELD("Email Title");
    //     EDISetup.TESTFIELD("Email Subject");

    //     SMTPMailSetup.GET;
    //     IF SMTPMailSetup.Authentication = SMTPMailSetup.Authentication::Basic THEN
    //       SMTPMailSetup.TESTFIELD("User ID");

    //     GetEmailAddress('StatusEmail_EDI',EmailTo,EmailCC,EmailBCC);

    //     SMTPMail.CreateMessage(EDISetup."Email Title",SMTPMailSetup."User ID",EmailTo,EDISetup."Email Subject",EMAIL_TEXT1,TRUE);

    //     IF EmailCC <> '' THEN
    //       SMTPMail.AddCC(EmailCC);

    //     IF EmailBCC <> '' THEN
    //       SMTPMail.AddBCC(EmailBCC);

    //     SMTPMail.AppendBody('<BR/>');

    //     SMTPMail.AppendBody('<H4 Style="color:Blue">');
    //     SMTPMail.AppendBody(STRSUBSTNO(EMAIL_TEXT6,FORMAT(SuccessCount)));
    //     SMTPMail.AppendBody('<BR/>');
    //     SMTPMail.AppendBody(STRSUBSTNO(EMAIL_TEXT7,FORMAT(ErrorCount)));
    //     SMTPMail.AppendBody('</H4>');

    //     SMTPMail.AppendBody('<table width="100%"><tr><td>');
    //     SMTPMail.AppendBody('<table cellpadding="0" cellspacing="0" style="border:0.3px solid black;" align="left" width="100%">');

    //     FileCount := 0;
    //     EDISalesOrderImportLog.RESET;
    //     EDISalesOrderImportLog.SETFILTER("Entry No.",'>%1',LastUsedLineNo);
    //     IF EDISalesOrderImportLog.FINDSET THEN BEGIN
    //       TableBodyAppendResultHdr(SMTPMail);
    //       REPEAT
    //         FileCount += 1;
    //         TableBodyAppendResult(SMTPMail,FileCount,EDISalesOrderImportLog."File Name",FORMAT(EDISalesOrderImportLog.Status),EDISalesOrderImportLog."Sales Orders");
    //       UNTIL EDISalesOrderImportLog.NEXT = 0;
    //     END;

    //     SMTPMail.AppendBody('</table>');

    //     SMTPMail.AppendBody('<BR/>');
    //     SMTPMail.AppendBody('<BR/>');

    //     SMTPMail.AppendBody('<table><tr><td>');
    //     SMTPMail.AppendBody(EMAIL_TEXT3);
    //     SMTPMail.AppendBody('</td></tr><tr><td>');
    //     SMTPMail.AppendBody(STRSUBSTNO(EMAIL_TEXT4,COMPANYNAME));
    //     SMTPMail.AppendBody('</td></tr></table></td></tr></table>');

    //     SMTPMail.Send;
    // end;

    // local procedure TableBodyAppend(var SMTP_vCdu: Codeunit 400;Caption_iTxt: Text;Value_iTxt: Text)
    // begin
    //     SMTP_vCdu.AppendBody('<tr><td align="left" Style="border:0.3px solid black;font-weight:bold;padding:0px 0px 0px 10px"  Width="30%">'+ Caption_iTxt +'</td>');
    //     SMTP_vCdu.AppendBody('<td Style="border:0.3px solid Black;padding:0px 0px 0px 10px" align="left" Width="70%">' + Value_iTxt +'</td></TR>');
    // end;

    // local procedure TableBodyAppendResultHdr(var SMTP_vCdu: Codeunit 400)
    // begin
    //     SMTP_vCdu.AppendBody('<tr><td align="left" Style="border:0.3px solid black;font-weight:bold;padding:0px 0px 0px 10px"  Width="5%">'+ 'Sr No.' +'</td>');
    //     SMTP_vCdu.AppendBody('<td align="left" Style="border:0.3px solid black;font-weight:bold;padding:0px 0px 0px 10px"  Width="65%">'+ 'File Name' +'</td>');
    //     SMTP_vCdu.AppendBody('<td align="left" Style="border:0.3px solid black;font-weight:bold;padding:0px 0px 0px 10px"  Width="15%">'+ 'Status' +'</td>');
    //     SMTP_vCdu.AppendBody('<td Style="border:0.3px solid Black;font-weight:bold;padding:0px 0px 0px 10px" align="left" Width="15%">' + 'Sales Order' +'</td></TR>');
    // end;

    // local procedure TableBodyAppendResult(var SMTP_vCdu: Codeunit 400;SrNo_iInt: Integer;FileName_iTxt: Text;Status_iTxt: Text;SalesOrder_iTxt: Text)
    // begin
    //     SMTP_vCdu.AppendBody('<tr><td align="left" Style="border:0.3px solid black;font-weight:bold;padding:0px 0px 0px 10px"  Width="5%">'+ FORMAT(SrNo_iInt) +'</td>');
    //     SMTP_vCdu.AppendBody('<td align="left" Style="border:0.3px solid black;padding:0px 0px 0px 10px"  Width="65%">'+ FileName_iTxt +'</td>');
    //     SMTP_vCdu.AppendBody('<td align="left" Style="border:0.3px solid black;padding:0px 0px 0px 10px"  Width="15%">'+ Status_iTxt +'</td>');
    //     SMTP_vCdu.AppendBody('<td Style="border:0.3px solid Black;padding:0px 0px 0px 10px" align="left" Width="15%">' + SalesOrder_iTxt +'</td></TR>');
    // end;

    local procedure SendErrorEmail(EDISalesOrderImportLog: Record 50031)
    var
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        CompanyNameTxt: Text;
        EmailBCC: Text[1024];
        EmailCC: Text[1024];
        EmailTo: Text[1024];
        BodyBuilder: TextBuilder;
    begin
        if not EDISetup."Send Email on Error" then
            exit;
        //TODO
        // EDISetup.TestField("Email Title");
        // EDISetup.TestField("Email Subject");

        GetEmailAddress('SalesOrder_EDI', EmailTo, EmailCC, EmailBCC);

        // Build HTML body
        BodyBuilder.Append('<html><body>');
        BodyBuilder.Append('<h4 style="color:Blue;">');
        BodyBuilder.Append(EMAIL_TEXT2);
        BodyBuilder.Append('</h4><br/>');
        BodyBuilder.Append('<table width="100%" style="border-collapse: collapse;">');
        BodyBuilder.Append('<tr><th style="border:1px solid black;">Field</th><th style="border:1px solid black;">Value</th></tr>');

        TableBodyAppend(BodyBuilder, EDISalesOrderImportLog.FieldCaption("Entry No."), Format(EDISalesOrderImportLog."Entry No."));
        TableBodyAppend(BodyBuilder, EDISalesOrderImportLog.FieldCaption("File Name"), EDISalesOrderImportLog."File Name");
        TableBodyAppend(BodyBuilder, EDISalesOrderImportLog.FieldCaption("Import Date"), Format(EDISalesOrderImportLog."Import Date"));
        TableBodyAppend(BodyBuilder, EDISalesOrderImportLog.FieldCaption("Import Time"), Format(EDISalesOrderImportLog."Import Time"));
        if GUIAllowed then
            TableBodyAppend(BodyBuilder, EDISalesOrderImportLog.FieldCaption("Import By"), EDISalesOrderImportLog."Import By")
        else
            TableBodyAppend(BodyBuilder, EDISalesOrderImportLog.FieldCaption("Import By"), SUPPORTUSER);

        TableBodyAppend(BodyBuilder, EDISalesOrderImportLog.FieldCaption(Status), Format(EDISalesOrderImportLog.Status));
        TableBodyAppend(BodyBuilder, EDISalesOrderImportLog.FieldCaption("Error Detail"), EDISalesOrderImportLog."Error Detail");

        BodyBuilder.Append('</table><br/><br/>');
        BodyBuilder.Append(EMAIL_TEXT3 + '<br/>');
        CompanyNameTxt := CompanyName;
        BodyBuilder.Append(StrSubstNo(EMAIL_TEXT4, CompanyNameTxt));
        BodyBuilder.Append('</body></html>');

        //  Create message with To, CC, and BCC
        EmailMessage.Create(
            EDISetup."Email Subject",
            EmailTo,
            EmailCC,
            EmailBCC,
            BodyBuilder.ToText(),
            true
        );

        // Send using configured account/scenario
        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
    end;


    local procedure SendStatusEmail()
    var
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";

        EDISalesOrderImportLog: Record 50031;
        FileCount: Integer;
        CompanyNameTxt: Text;
        EmailBCC: Text[1024];
        EmailCC: Text[1024];
        EmailTo: Text[1024];
        BodyBuilder: TextBuilder;
    begin
        if not EDISetup."Send Email on Error" then
            exit;

        if (SuccessCount = 0) or (SuccessCount + ErrorCount = 0) then
            exit;

        EDISetup.TestField("Email Title");
        EDISetup.TestField("Email Subject");

        GetEmailAddress('StatusEmail_EDI', EmailTo, EmailCC, EmailBCC);

        // Build HTML Body
        BodyBuilder.Append('<html><body>');
        BodyBuilder.Append('<h4 style="color:Blue;">');
        BodyBuilder.Append(StrSubstNo(EMAIL_TEXT6, Format(SuccessCount)) + '<br/>');
        BodyBuilder.Append(StrSubstNo(EMAIL_TEXT7, Format(ErrorCount)));
        BodyBuilder.Append('</h4><br/>');
        BodyBuilder.Append('<table width="100%" style="border-collapse: collapse;">');
        BodyBuilder.Append('<tr><th style="border:1px solid black;">Sr No.</th><th style="border:1px solid black;">File Name</th><th style="border:1px solid black;">Status</th><th style="border:1px solid black;">Sales Order</th></tr>');

        FileCount := 0;

        EDISalesOrderImportLog.Reset();
        EDISalesOrderImportLog.SetFilter("Entry No.", '>%1', LastUsedLineNo);
        if EDISalesOrderImportLog.FindSet() then
            repeat
                FileCount += 1;
                TableBodyAppendResult(BodyBuilder, FileCount, EDISalesOrderImportLog."File Name", Format(EDISalesOrderImportLog.Status), EDISalesOrderImportLog."Sales Orders");
            until EDISalesOrderImportLog.Next() = 0;

        BodyBuilder.Append('</table><br/><br/>');
        BodyBuilder.Append(EMAIL_TEXT3 + '<br/>');
        CompanyNameTxt := CompanyName;
        BodyBuilder.Append(StrSubstNo(EMAIL_TEXT4, CompanyNameTxt));
        BodyBuilder.Append('</body></html>');

        //  Create message with To, CC, and BCC
        EmailMessage.Create(
            EDISetup."Email Subject",
            EmailTo,
            EmailCC,
            EmailBCC,
            BodyBuilder.ToText(),
            true
        );

        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
    end;


    // ---------- Helper Methods ----------

    local procedure TableBodyAppend(var BodyBuilder: TextBuilder; CaptionTxt: Text; ValueTxt: Text)
    begin
        BodyBuilder.Append('<tr><td style="border:1px solid black;font-weight:bold;padding:5px;">' + CaptionTxt + '</td>');
        BodyBuilder.Append('<td style="border:1px solid black;padding:5px;">' + ValueTxt + '</td></tr>');
    end;

    local procedure TableBodyAppendResult(var BodyBuilder: TextBuilder; SrNo: Integer; FileName: Text; Status: Text; SalesOrder: Text)
    begin
        BodyBuilder.Append('<tr><td style="border:1px solid black;padding:5px;">' + Format(SrNo) + '</td>');
        BodyBuilder.Append('<td style="border:1px solid black;padding:5px;">' + FileName + '</td>');
        BodyBuilder.Append('<td style="border:1px solid black;padding:5px;">' + Status + '</td>');
        BodyBuilder.Append('<td style="border:1px solid black;padding:5px;">' + SalesOrder + '</td></tr>');
    end;


    // local procedure FormatMailDate(Date_iDte: Date): Text
    // begin
    //     EXIT(FORMAT(Date_iDte, 0, '<Day,2>/<Month,2>/<Year>'));
    // end;

    procedure GetEmailAddress(ReportName: Text[30]; var pTo: Text[1024]; var pCC: Text[1024]; var pBCC: Text[1024])
    begin
        IF ReportName = '' THEN
            ERROR('You must specify Report Name!');

        CLEAR(pTo);
        CLEAR(pCC);
        CLEAR(pBCC);

        //jrr 071716

        IF STRPOS(COMPANYNAME, 'CORPORATION') > 0 THEN
            pTo := To_NUSA
        ELSE
            if STRPOS(COMPANYNAME, 'Canada') > 0 THEN
                pTo := To_NC1 + To_NC2
            ELSE
                pTo := ToEmail;

        //jrr 071716

        CASE ReportName OF
            'SalesOrder_EDI':
                BEGIN
                    //        pTo  := ToEmail;
                    pCC := CCEmail;
                    pBCC := BCCEmail;
                END;
            'StatusEmail_EDI':
                BEGIN
                    //        pTo  := ToEmail;
                    pCC := CCEmail;
                    pBCC := BCCEmail;
                END;
            ELSE
                ERROR('Report Name %1 does not find in switch case', ReportName);
        END;
    end;

    procedure ProcessEDIForecastIn()
    var
        EDISalesOrderImportLog: Record 50031;
        LastDocNo_lCod: Code[250];
    begin
        // refresh the instream and import the XML into the EDI Sales Order tables
        CLEARLASTERROR();
        CLEAR(Ins);
        CLEAR(SourceFile);

        IF GUIALLOWED THEN
            Window.UPDATE(1, MyFile.Name);

        if not UploadIntoStream('Select EDI XML File', '', '', MyFile.Name, InS) then
            exit;

        Clear(ImportEDISalesOrder);
        ImportEDISalesOrder.SetSource(InS);

        if ImportEDISalesOrder.Import() then begin
            SuccessCount += 1;
            LastDocNo_lCod := ImportEDISalesOrder.GetOrderNo();
            AddToDocNos(LastDocNo_lCod);
            TempBlobg.CreateOutStream(Outstreamg);
            CopyStream(Outstreamg, InS);
            DownloadFromStream(ins, '', '', '', EDISetup."XML Success Folder");
            //FileMgt.BLOBExport(TempBlobg, EDISetup."XML Success Folder" + MyFile.Name, true);


            EDISalesOrderImportLog.RESET();
            CLEAR(EDISalesOrderImportLog);
            EDISalesOrderImportLog."Entry No." := GetLastEntryNo();
            EDISalesOrderImportLog."File Name" := MyFile.Name;
            EDISalesOrderImportLog."Import Date" := TODAY;
            EDISalesOrderImportLog."Import Time" := TIME;
            EDISalesOrderImportLog."Import By" := USERID;
            EDISalesOrderImportLog.Status := EDISalesOrderImportLog.Status::Success;
            EDISalesOrderImportLog."Sales Orders" := COPYSTR(LastDocNo_lCod, 1, 250);
            EDISalesOrderImportLog.INSERT();

            COMMIT(); // to retain all good values, in case other files fail
        END ELSE BEGIN
            ErrorCount += 1;

            // SourceFile.CLOSE;
            // FILE.COPY(MyFile.Path + MyFile.Name, Errorpath + MyFile.Name);  //EDISetup."XML Error Folder"
            // ERASE(MyFile.Path + MyFile.Name);

            EDISalesOrderImportLog.RESET();
            CLEAR(EDISalesOrderImportLog);
            EDISalesOrderImportLog."Entry No." := GetLastEntryNo();
            EDISalesOrderImportLog."File Name" := MyFile.Name;
            EDISalesOrderImportLog."Import Date" := TODAY;
            EDISalesOrderImportLog."Import Time" := TIME;
            EDISalesOrderImportLog."Import By" := USERID;
            EDISalesOrderImportLog.Status := EDISalesOrderImportLog.Status::Error;
            EDISalesOrderImportLog."Sales Orders" := COPYSTR(LastDocNo_lCod, 1, 250);
            EDISalesOrderImportLog."Error Detail" := COPYSTR(GETLASTERRORTEXT, 1, 250);
            EDISalesOrderImportLog.INSERT();
            SendErrorEmail(EDISalesOrderImportLog);
        END;
    end;
}

