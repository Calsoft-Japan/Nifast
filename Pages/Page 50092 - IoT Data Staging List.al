page 50092 "IoT Data Staging List"
{
    // CIS.IoT 07/22/22 RAM Created new Object

    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "IoT Data Staging";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    Caption = 'Document Type';
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    Caption = 'Document No.';
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Line No."; Rec."Line No.")
                {
                    Caption = 'Line No.';
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Table No."; Rec."Table No.")
                {
                    Caption = 'Table No.';
                    ToolTip = 'Specifies the value of the Table No. field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    Caption = 'Item No.';
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Lot No."; Rec."Lot No.")
                {
                    Caption = 'Lot No.';
                    ToolTip = 'Specifies the value of the Lot No. field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Location From"; Rec."Location From")
                {
                    Caption = 'Location From';
                    ToolTip = 'Specifies the value of the Location From field.';
                }
                field("Location To"; Rec."Location To")
                {
                    Caption = 'Location To';
                    ToolTip = 'Specifies the value of the Location To field.';
                }
                field("RFID Gate No."; Rec."RFID Gate No.")
                {
                    Caption = 'RFID Gate No.';
                    ToolTip = 'Specifies the value of the RFID Gate No. field.';
                }
                field("Record Status"; Rec."Record Status")
                {
                    Caption = 'Record Status';
                    ToolTip = 'Specifies the value of the Record Status field.';
                }
                field("Date Processed On"; Rec."Date Processed On")
                {
                    Caption = 'Date Processed On';
                    ToolTip = 'Specifies the value of the Date Processed On field.';
                }
                field("Email Notification Sent"; Rec."Email Notification Sent")
                {
                    Caption = 'Email Notification Sent';
                    ToolTip = 'Specifies the value of the Email Notification Sent field.';
                }
                field("Email Notifications Sent On"; Rec."Email Notifications Sent On")
                {
                    Caption = 'Email Notifications Sent On';
                    ToolTip = 'Specifies the value of the Email Notifications Sent On field.';
                }
                field("Resend Email Notfication"; Rec."Resend Email Notfication")
                {
                    Caption = 'Resend Email Notfication';
                    ToolTip = 'Specifies the value of the Resend Email Notfication field.';
                }
                field("Email Notifications Sent On 2"; Rec."Email Notifications Sent On 2")
                {
                    Caption = 'Email Notifications Sent On 2';
                    ToolTip = 'Specifies the value of the Email Notifications Sent On 2 field.';
                }
                field("Email Recipients"; Rec."Email Recipients")
                {
                    Caption = 'Email Recipients';
                    ToolTip = 'Specifies the value of the Email Recipients field.';
                }
                field("Error Message"; Rec."Error Message")
                {
                    Caption = 'Error Message';
                    ToolTip = 'Specifies the value of the Error Message field.';
                }
                field("Output Document Type"; Rec."Output Document Type")
                {
                    Caption = 'Output Document Type';
                    ToolTip = 'Specifies the value of the Output Document Type field.';
                }
                field("Output Document No."; Rec."Output Document No.")
                {
                    Caption = 'Output Document No.';
                    ToolTip = 'Specifies the value of the Output Document No. field.';
                }
                field("Output Invt. Pick Type"; Rec."Output Invt. Pick Type")
                {
                    Caption = 'Output Invt. Pick Type';
                    ToolTip = 'Specifies the value of the Output Invt. Pick Type field.';
                }
                field("Output Pick No."; Rec."Output Pick No.")
                {
                    Caption = 'Output Pick No.';
                    ToolTip = 'Specifies the value of the Output Pick No. field.';
                }
                field("File Name"; Rec."File Name")
                {
                    Caption = 'File Name';
                    ToolTip = 'Specifies the value of the File Name field.';
                }
                field("Date Imported"; Rec."Date Imported")
                {
                    Caption = 'Date Imported';
                    ToolTip = 'Specifies the value of the Date Imported field.';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Send Emails")
            {
                ToolTip = 'Executes the Send Emails action.';
                Image = SendMail;
                trigger OnAction()
                var
                    IoTSendEmails: Codeunit "IoT Email Notifications";
                begin
                    CLEAR(IoTSendEmails);
                    IoTSendEmails.RUN();
                end;
            }
        }
    }
}

