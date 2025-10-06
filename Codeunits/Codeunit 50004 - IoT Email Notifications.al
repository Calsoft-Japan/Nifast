codeunit 50004 "IoT Email Notifications"
{
    // CIS.IoT 07/22/22 RAM Created new Object


    trigger OnRun()
    var
        IoTDataStaging: Record "50042";
        IoTDataStagingM: Record "50042";
        SMTPMailSetup: Record "409";
        InventorySetup: Record "313";
        Mail: Codeunit "397";
        SMTPMail: Codeunit "400";
        AttachmentFilename: Text[20];
        EmailTo: Text[1024];
        EmailCC: Text[1024];
        EmailBCC: Text[1024];
        EmailTitle: Text[80];
        FileCount: Integer;
        EMAIL_TEXT1: Label 'Dear User,';
        EMAIL_TEXT3: Label 'Regards,';
        i: Integer;
        j: Integer;
        EMAIL_TEXT4: Label 'Systems Auto Alert';
    begin
        FOR i := 1 TO 3 DO BEGIN
          IoTDataStaging.RESET;
          CASE TRUE OF
            i = 1:
              BEGIN
                IoTDataStaging.SETRANGE("Document Type",IoTDataStaging."Document Type"::"Invt. Pick");
                IoTDataStaging.SETRANGE("Record Status",IoTDataStaging."Record Status"::Error);
              END;
            i = 2:
              BEGIN
                IoTDataStaging.SETRANGE("Document Type",IoTDataStaging."Document Type"::"Trans. Rcpt.");
                IoTDataStaging.SETRANGE("Record Status",IoTDataStaging."Record Status"::Pending);
              END;
            i = 3:
              BEGIN
                IoTDataStaging.SETRANGE("Document Type",IoTDataStaging."Document Type"::"Sales Ship");
                IoTDataStaging.SETRANGE("Record Status",IoTDataStaging."Record Status"::Error);
              END;
          END;

          IF IoTDataStaging.FINDSET THEN BEGIN
            InventorySetup.RESET;
            InventorySetup.GET();
            InventorySetup.TESTFIELD("IoT Admin. Email");

            SMTPMailSetup.GET;
            IF SMTPMailSetup.Authentication = SMTPMailSetup.Authentication::Basic THEN
              SMTPMailSetup.TESTFIELD("User ID");

            EmailTo := '';
            EmailCC := '';

            CASE TRUE OF
              i = 1:
                BEGIN
                  EmailTo := InventorySetup."IoT Trans. Order Email";
                  EmailCC := InventorySetup."IoT Trans Order CC Email";
                  EmailTitle := 'IoT Invt. Pick Data Error';
                  //SMTPMail.CreateMessage(EmailTitle,SMTPMailSetup."User ID",EmailTo,'IoT Invt. Pick Data Error',EMAIL_TEXT1,TRUE);
                  SMTPMail.CreateMessage(EmailTitle,'EDISupport@nifast.com',EmailTo,'IoT Invt. Pick Data Error',EMAIL_TEXT1,TRUE);
                  IF EmailCC <> '' THEN
                    SMTPMail.AddCC(EmailCC);
                END;
              i = 2:
                BEGIN
                  EmailTo := InventorySetup."IoT Trans. Order Email";
                  EmailCC := InventorySetup."IoT Trans Order CC Email";
                  EmailTitle := 'IoT Trans Receipt Data Posting';
                  SMTPMail.CreateMessage(EmailTitle,SMTPMailSetup."User ID",EmailTo,'IoT Trans Receipt Data Posting',EMAIL_TEXT1,TRUE);
                  IF EmailCC <> '' THEN
                    SMTPMail.AddCC(EmailCC);
                END;
              i = 3:
                BEGIN
                  EmailTo := InventorySetup."IoT Sales Email";
                  EmailCC := InventorySetup."IoT Sales CC Email";
                  EmailTitle := 'IoT Sales Shipment Data Error';
                  SMTPMail.CreateMessage(EmailTitle,SMTPMailSetup."User ID",EmailTo,'IoT Sales Shipment Data Error',EMAIL_TEXT1,TRUE);
                  IF EmailCC <> '' THEN
                    SMTPMail.AddCC(EmailCC);
                END;
            END;

            IF InventorySetup."Send Email CC to Admin" THEN BEGIN
              IF InventorySetup."IoT Admin. Email" <> '' THEN
                SMTPMail.AddCC(InventorySetup."IoT Admin. Email");
              IF InventorySetup."IoT Admin. CC Email" <> '' THEN
                SMTPMail.AddCC(InventorySetup."IoT Admin. CC Email");
            END;
            j := 0;
            REPEAT
              IF (((IoTDataStaging."Email Notification Sent") AND
                  (IoTDataStaging."Resend Email Notfication")) OR
                 (NOT IoTDataStaging."Email Notification Sent"))
              THEN BEGIN
                j += 1;
                SMTPMail.AppendBody('<BR/>');
                IF j = 1 THEN BEGIN
                  SMTPMail.AppendBody(EMAIL_TEXT1);
                  SMTPMail.AppendBody('<BR/>');
                  SMTPMail.AppendBody('<table style="width:100%">');
                  SMTPMail.AppendBody('<tr><td align ="left">Doc. Type</td><td align ="left">Doc. No.</td><td align ="left">Status</td><td align ="left">Error</td></tr>');
                  SMTPMail.AppendBody('<BR/>');
                  SMTPMail.AppendBody('</table>');
                  SMTPMail.AppendBody('<hr>');
                  SMTPMail.AppendBody('<BR/>');
                END;

                SMTPMail.AppendBody('<table style="width:100%">');
                SMTPMail.AppendBody('<tr><td align ="left">' + FORMAT(IoTDataStaging."Document Type") + '</td><td align ="left">' + FORMAT(IoTDataStaging."Document No.") + '</td><td align ="left">' + FORMAT(IoTDataStaging."Record Status") +
                   '</td><td align ="left"> ' + IoTDataStaging."Error Message" + '</td></tr>');
                SMTPMail.AppendBody('<BR/>');
                SMTPMail.AppendBody('</table>');

                IoTDataStagingM.RESET;
                IoTDataStagingM.GET(IoTDataStaging."Entry No.");
                IoTDataStagingM."Email Notification Sent" := TRUE;
                IoTDataStagingM."Resend Email Notfication" := FALSE;
                IoTDataStagingM."Email Recipients" := '';
                IF IoTDataStagingM."Resend Email Notfication" THEN
                  IoTDataStagingM."Email Notifications Sent On 2" := CURRENTDATETIME
                ELSE
                  IoTDataStagingM."Email Notifications Sent On" := CURRENTDATETIME;
                IoTDataStagingM.MODIFY;
              END;
            UNTIL IoTDataStaging.NEXT = 0;
            SMTPMail.AppendBody('<BR/>');
            SMTPMail.AppendBody(EMAIL_TEXT3);
            SMTPMail.AppendBody('<BR/>');
            SMTPMail.AppendBody(EMAIL_TEXT4);
            SMTPMail.Send;
          END;
        END;
    end;
}

