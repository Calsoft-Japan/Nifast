codeunit 50000 "Not used"
{
    // NF1.00:CIS.NG    10/05/15 Merge the (AP6) Functionality object provided by Jagdish
    // NF1.00:CIS.NG    10/15/15 XMLport Development - EDI Sales Order Import
    // NF1.00:CIS.NG    10/30/15 XMLport Development - Added code send email status after import files
    // DMS0001 TJB 05/10/10:
    //   - Created codeunit to process one single EDI XML document


    trigger OnRun()
    begin
        ProcessAll(FALSE);
    end;

    var
        SalesHeader: Record 36;
        EDISetup: Record "14002367";
        MyFile: Record 2000000022;
        SourceFile: File;
        Ins: InStream;
        ImportEDISalesOrder: XMLport "50000";
        FOLDER_NOT_FOUND: Label 'Could not find folder %1';
        DOCNAME: Label '%1.XML';
        INVALID_XML_DOCTYPE: Label 'The DOCTYPE element in the XML document returned an invalid value';
        EDI_ORDER_REJECTED: Label 'The EDI Sales Order number %1 was rejected';
        IMPORT_FAILED: Label 'Failed to import %1 with the following error message:\%2';
        STATUS_MSG: Label 'Orders Created: %1 (%2)\Orders Failed: %3';
        SuccessCount: Integer;
        ErrorCount: Integer;
        DocNos: Code[50];
        FirstNo: Code[20];
        LastNo: Code[20];
        NOTHING_MSG: Label 'There is nothing to import.';
        CONFIRM_MSG: Label 'Do you want to import/update order?';
        EMAIL_TEXT1: Label 'Dear User,';
        EMAIL_TEXT2: Label 'Error Notification';
        EMAIL_TEXT3: Label 'Regards,';
        EMAIL_TEXT4: Label '%1 - Systems Auto Alert';
        EMAIL_TEXT5: Label 'File Detail - %1';
        EMAIL_TEXT6: Label 'Order Processed : %1';
        EMAIL_TEXT7: Label 'Order Failed : %1';
        DIALOG_TEXT1: Label 'Import Files....\';
        DIALOG_TEXT2: Label 'File Name #1################';
        Window: Dialog;
        ToEmail: Label 'venug@cloud9infosystems.com;Karyn.Young@datamasons.com';
        CCEmail: Label 'jagr@cloud9infosystems.com';
        BCCEmail: ;
        LastUsedLineNo: Integer;
        SUPPORTUSER: Label 'Nifast Support';

    procedure ProcessAll(parShowMsg: Boolean)
    var
        EDISalesOrderImportLog: Record "50031";
    begin
        IF GUIALLOWED THEN BEGIN
            IF NOT CONFIRM(CONFIRM_MSG, TRUE) THEN
                EXIT;
        END;

        CheckSetup;

        MyFile.RESET;
        MyFile.SETRANGE(Path, EDISetup."XML Source Document Folder");
        MyFile.SETRANGE("Is a file", TRUE);
        MyFile.SETFILTER(Name, '@*.xml');
        IF MyFile.FINDSET THEN BEGIN
            IF GUIALLOWED THEN
                Window.OPEN(DIALOG_TEXT1 + DIALOG_TEXT2);


            EDISalesOrderImportLog.RESET;
            IF EDISalesOrderImportLog.FINDLAST THEN
                LastUsedLineNo := EDISalesOrderImportLog."Entry No.";

            REPEAT
                ProcessEDISalesOrderIn;
            UNTIL MyFile.NEXT = 0;

            IF GUIALLOWED THEN
                Window.CLOSE;

            SendStatusEmail;
            IF parShowMsg THEN
                ShowMessage();
        END ELSE BEGIN
            IF GUIALLOWED THEN
                MESSAGE(NOTHING_MSG);
        END;
    end;

    procedure CheckSetup()
    begin
        // check EDI setup
        EDISetup.GET;
        EDISetup.TESTFIELD("XML Source Document Folder");
        EDISetup.TESTFIELD("XML Error Folder");
        IF NOT EDISetup."Delete XML on Success" THEN
            EDISetup.TESTFIELD("XML Success Folder");

        // check folders
        IF NOT ValidateDirectoryPath(EDISetup."XML Error Folder") THEN
            ERROR(FOLDER_NOT_FOUND, EDISetup."XML Error Folder");
        IF NOT ValidateDirectoryPath(EDISetup."XML Source Document Folder") THEN
            ERROR(FOLDER_NOT_FOUND, EDISetup."XML Source Document Folder");
        IF NOT EDISetup."Delete XML on Success" THEN BEGIN
            IF NOT ValidateDirectoryPath(EDISetup."XML Success Folder") THEN
                ERROR(FOLDER_NOT_FOUND, EDISetup."XML Success Folder");
        END;
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
        EDISalesOrderImportLog: Record "50031";
        LastDocNo_lCod: Code[250];
    begin
        // refresh the instream and import the XML into the EDI Sales Order tables
        CLEARLASTERROR;
        CLEAR(Ins);
        CLEAR(SourceFile);

        IF GUIALLOWED THEN
            Window.UPDATE(1, MyFile.Name);

        SourceFile.TEXTMODE(TRUE);
        SourceFile.OPEN(MyFile.Path + MyFile.Name);
        SourceFile.CREATEINSTREAM(Ins);
        CLEAR(ImportEDISalesOrder);
        ImportEDISalesOrder.SETSOURCE(Ins);
        IF ImportEDISalesOrder.IMPORT THEN BEGIN
            SuccessCount += 1;
            LastDocNo_lCod := ImportEDISalesOrder.GetOrderNo;
            AddToDocNos(LastDocNo_lCod);
            IF EDISetup."Delete XML on Success" THEN BEGIN
                SourceFile.CLOSE;
                ERASE(MyFile.Path + MyFile.Name);
            END ELSE BEGIN
                SourceFile.CLOSE;
                FILE.COPY(MyFile.Path + MyFile.Name, EDISetup."XML Success Folder" + MyFile.Name);
                ERASE(MyFile.Path + MyFile.Name);
            END;

            EDISalesOrderImportLog.RESET;
            CLEAR(EDISalesOrderImportLog);
            EDISalesOrderImportLog."Entry No." := GetLastEntryNo;
            EDISalesOrderImportLog."File Name" := MyFile.Name;
            EDISalesOrderImportLog."Import Date" := TODAY;
            EDISalesOrderImportLog."Import Time" := TIME;
            EDISalesOrderImportLog."Import By" := USERID;
            EDISalesOrderImportLog.Status := EDISalesOrderImportLog.Status::Success;
            EDISalesOrderImportLog."Sales Orders" := COPYSTR(LastDocNo_lCod, 1, 250);
            EDISalesOrderImportLog.INSERT;

            COMMIT; // to retain all good values, in case other files fail
        END ELSE BEGIN
            ErrorCount += 1;

            SourceFile.CLOSE;
            FILE.COPY(MyFile.Path + MyFile.Name, EDISetup."XML Error Folder" + MyFile.Name);
            ERASE(MyFile.Path + MyFile.Name);

            EDISalesOrderImportLog.RESET;
            CLEAR(EDISalesOrderImportLog);
            EDISalesOrderImportLog."Entry No." := GetLastEntryNo;
            EDISalesOrderImportLog."File Name" := MyFile.Name;
            EDISalesOrderImportLog."Import Date" := TODAY;
            EDISalesOrderImportLog."Import Time" := TIME;
            EDISalesOrderImportLog."Import By" := USERID;
            EDISalesOrderImportLog.Status := EDISalesOrderImportLog.Status::Error;
            EDISalesOrderImportLog."Sales Orders" := COPYSTR(LastDocNo_lCod, 1, 250);
            EDISalesOrderImportLog."Error Detail" := COPYSTR(GETLASTERRORTEXT, 1, 250);
            EDISalesOrderImportLog.INSERT;
            SendErrorEmail(EDISalesOrderImportLog);
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

    local procedure GetLastEntryNo(): Integer
    var
        EDISalesOrderImportLog: Record "50031";
    begin
        EDISalesOrderImportLog.RESET;
        IF EDISalesOrderImportLog.FINDLAST THEN
            EXIT(EDISalesOrderImportLog."Entry No." + 1)
        ELSE
            EXIT(1);
    end;

    local procedure SendErrorEmail(EDISalesOrderImportLog: Record "50031")
    var
        SMTPMail: Codeunit "400";
        SMTPMailSetup: Record "409";
        EmailTo: Text[1024];
        EmailCC: Text[1024];
        EmailBCC: Text[1024];
    begin
        IF NOT EDISetup."Send Email on Error" THEN
            EXIT;

        EDISetup.TESTFIELD("Email Title");
        EDISetup.TESTFIELD("Email Subject");

        SMTPMailSetup.GET;
        IF SMTPMailSetup.Authentication = SMTPMailSetup.Authentication::Basic THEN
            SMTPMailSetup.TESTFIELD("User ID");

        GetEmailAddress('SalesOrder_EDI', EmailTo, EmailCC, EmailBCC);

        SMTPMail.CreateMessage(EDISetup."Email Title", SMTPMailSetup."User ID", EmailTo, EDISetup."Email Subject", EMAIL_TEXT1, TRUE);

        IF EmailCC <> '' THEN
            SMTPMail.AddCC(EmailCC);

        IF EmailBCC <> '' THEN
            SMTPMail.AddBCC(EmailBCC);

        SMTPMail.AppendBody('<BR/>');

        SMTPMail.AppendBody('<H4 Style="color:Blue">');
        SMTPMail.AppendBody(EMAIL_TEXT2);
        SMTPMail.AppendBody('</H4>');

        SMTPMail.AppendBody('<table width="100%"><tr><td>');
        SMTPMail.AppendBody('<table cellpadding="0" cellspacing="0" style="border:0.3px solid black;" align="left" width="100%">');

        TableBodyAppend(SMTPMail, EDISalesOrderImportLog.FIELDCAPTION("Entry No."), FORMAT(EDISalesOrderImportLog."Entry No."));
        TableBodyAppend(SMTPMail, EDISalesOrderImportLog.FIELDCAPTION("File Name"), EDISalesOrderImportLog."File Name");
        TableBodyAppend(SMTPMail, EDISalesOrderImportLog.FIELDCAPTION("Import Date"), FORMAT(EDISalesOrderImportLog."Import Date"));
        TableBodyAppend(SMTPMail, EDISalesOrderImportLog.FIELDCAPTION("Import Time"), FORMAT(EDISalesOrderImportLog."Import Time"));
        IF GUIALLOWED THEN
            TableBodyAppend(SMTPMail, EDISalesOrderImportLog.FIELDCAPTION("Import By"), EDISalesOrderImportLog."Import By")
        ELSE
            TableBodyAppend(SMTPMail, EDISalesOrderImportLog.FIELDCAPTION("Import By"), SUPPORTUSER);

        TableBodyAppend(SMTPMail, EDISalesOrderImportLog.FIELDCAPTION(Status), FORMAT(EDISalesOrderImportLog.Status));
        TableBodyAppend(SMTPMail, EDISalesOrderImportLog.FIELDCAPTION("Error Detail"), EDISalesOrderImportLog."Error Detail");
        SMTPMail.AppendBody('</table>');

        SMTPMail.AppendBody('<BR/>');
        SMTPMail.AppendBody('<BR/>');

        SMTPMail.AppendBody('<table><tr><td>');
        SMTPMail.AppendBody(EMAIL_TEXT3);
        SMTPMail.AppendBody('</td></tr><tr><td>');
        SMTPMail.AppendBody(STRSUBSTNO(EMAIL_TEXT4, COMPANYNAME));
        SMTPMail.AppendBody('</td></tr></table></td></tr></table>');

        SMTPMail.Send;
    end;

    local procedure SendStatusEmail()
    var
        SMTPMail: Codeunit "400";
        SMTPMailSetup: Record "409";
        EmailTo: Text[1024];
        EmailCC: Text[1024];
        EmailBCC: Text[1024];
        EDISalesOrderImportLog: Record "50031";
        FileCount: Integer;
    begin
        IF NOT EDISetup."Send Email on Error" THEN
            EXIT;

        IF SuccessCount = 0 THEN
            EXIT;

        IF SuccessCount + ErrorCount = 0 THEN
            EXIT;

        EDISetup.TESTFIELD("Email Title");
        EDISetup.TESTFIELD("Email Subject");

        SMTPMailSetup.GET;
        IF SMTPMailSetup.Authentication = SMTPMailSetup.Authentication::Basic THEN
            SMTPMailSetup.TESTFIELD("User ID");

        GetEmailAddress('StatusEmail_EDI', EmailTo, EmailCC, EmailBCC);

        SMTPMail.CreateMessage(EDISetup."Email Title", SMTPMailSetup."User ID", EmailTo, EDISetup."Email Subject", EMAIL_TEXT1, TRUE);

        IF EmailCC <> '' THEN
            SMTPMail.AddCC(EmailCC);

        IF EmailBCC <> '' THEN
            SMTPMail.AddBCC(EmailBCC);

        SMTPMail.AppendBody('<BR/>');

        SMTPMail.AppendBody('<H4 Style="color:Blue">');
        SMTPMail.AppendBody(STRSUBSTNO(EMAIL_TEXT6, FORMAT(SuccessCount)));
        SMTPMail.AppendBody('<BR/>');
        SMTPMail.AppendBody(STRSUBSTNO(EMAIL_TEXT7, FORMAT(ErrorCount)));
        SMTPMail.AppendBody('</H4>');

        SMTPMail.AppendBody('<table width="100%"><tr><td>');
        SMTPMail.AppendBody('<table cellpadding="0" cellspacing="0" style="border:0.3px solid black;" align="left" width="100%">');

        FileCount := 0;
        EDISalesOrderImportLog.RESET;
        EDISalesOrderImportLog.SETFILTER("Entry No.", '>%1', LastUsedLineNo);
        IF EDISalesOrderImportLog.FINDSET THEN BEGIN
            TableBodyAppendResultHdr(SMTPMail);
            REPEAT
                FileCount += 1;
                TableBodyAppendResult(SMTPMail, FileCount, EDISalesOrderImportLog."File Name", FORMAT(EDISalesOrderImportLog.Status), EDISalesOrderImportLog."Sales Orders");
            UNTIL EDISalesOrderImportLog.NEXT = 0;
        END;

        SMTPMail.AppendBody('</table>');

        SMTPMail.AppendBody('<BR/>');
        SMTPMail.AppendBody('<BR/>');

        SMTPMail.AppendBody('<table><tr><td>');
        SMTPMail.AppendBody(EMAIL_TEXT3);
        SMTPMail.AppendBody('</td></tr><tr><td>');
        SMTPMail.AppendBody(STRSUBSTNO(EMAIL_TEXT4, COMPANYNAME));
        SMTPMail.AppendBody('</td></tr></table></td></tr></table>');

        SMTPMail.Send;
    end;

    local procedure TableBodyAppend(var SMTP_vCdu: Codeunit "400"; Caption_iTxt: Text; Value_iTxt: Text)
    begin
        SMTP_vCdu.AppendBody('<tr><td align="left" Style="border:0.3px solid black;font-weight:bold;padding:0px 0px 0px 10px"  Width="30%">' + Caption_iTxt + '</td>');
        SMTP_vCdu.AppendBody('<td Style="border:0.3px solid Black;padding:0px 0px 0px 10px" align="left" Width="70%">' + Value_iTxt + '</td></TR>');
    end;

    local procedure TableBodyAppendResultHdr(var SMTP_vCdu: Codeunit "400")
    begin
        SMTP_vCdu.AppendBody('<tr><td align="left" Style="border:0.3px solid black;font-weight:bold;padding:0px 0px 0px 10px"  Width="5%">' + 'Sr No.' + '</td>');
        SMTP_vCdu.AppendBody('<td align="left" Style="border:0.3px solid black;font-weight:bold;padding:0px 0px 0px 10px"  Width="65%">' + 'File Name' + '</td>');
        SMTP_vCdu.AppendBody('<td align="left" Style="border:0.3px solid black;font-weight:bold;padding:0px 0px 0px 10px"  Width="15%">' + 'Status' + '</td>');
        SMTP_vCdu.AppendBody('<td Style="border:0.3px solid Black;font-weight:bold;padding:0px 0px 0px 10px" align="left" Width="15%">' + 'Sales Order' + '</td></TR>');
    end;

    local procedure TableBodyAppendResult(var SMTP_vCdu: Codeunit "400"; SrNo_iInt: Integer; FileName_iTxt: Text; Status_iTxt: Text; SalesOrder_iTxt: Text)
    begin
        SMTP_vCdu.AppendBody('<tr><td align="left" Style="border:0.3px solid black;font-weight:bold;padding:0px 0px 0px 10px"  Width="5%">' + FORMAT(SrNo_iInt) + '</td>');
        SMTP_vCdu.AppendBody('<td align="left" Style="border:0.3px solid black;padding:0px 0px 0px 10px"  Width="65%">' + FileName_iTxt + '</td>');
        SMTP_vCdu.AppendBody('<td align="left" Style="border:0.3px solid black;padding:0px 0px 0px 10px"  Width="15%">' + Status_iTxt + '</td>');
        SMTP_vCdu.AppendBody('<td Style="border:0.3px solid Black;padding:0px 0px 0px 10px" align="left" Width="15%">' + SalesOrder_iTxt + '</td></TR>');
    end;

    local procedure FormatMailDate(Date_iDte: Date): Text
    begin
        EXIT(FORMAT(Date_iDte, 0, '<Day,2>/<Month,2>/<Year>'));
    end;

    procedure GetEmailAddress(ReportName: Text[30]; var pTo: Text[1024]; var pCC: Text[1024]; var pBCC: Text[1024])
    begin
        IF ReportName = '' THEN
            ERROR('You must specify Report Name!');

        CLEAR(pTo);
        CLEAR(pCC);
        CLEAR(pBCC);

        CASE ReportName OF
            'SalesOrder_EDI':
                BEGIN
                    pTo := ToEmail;
                    pCC := CCEmail;
                    pBCC := BCCEmail;
                END;
            'StatusEmail_EDI':
                BEGIN
                    pTo := ToEmail;
                    pCC := CCEmail;
                    pBCC := BCCEmail;
                END;
            ELSE
                ERROR('Report Name %1 does not find in switch case', ReportName);
        END;
    end;
}

