page 50094 "IoT File Import Log"
{
    // CIS.IoT 07/22/22 RAM Created new Object

    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "IoT File Import Log";

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
                field("File Name"; Rec."File Name")
                {
                    Caption = 'File Name';
                    ToolTip = 'Specifies the value of the File Name field.';
                }
                field("Import Date"; Rec."Import Date")
                {
                    Caption = 'Import Date';
                    ToolTip = 'Specifies the value of the Import Date field.';
                }
                field("Import Time"; Rec."Import Time")
                {
                    Caption = 'Import Time';
                    ToolTip = 'Specifies the value of the Import Time field.';
                }
                field("Import By"; Rec."Import By")
                {
                    Caption = 'Import By';
                    ToolTip = 'Specifies the value of the Import By field.';
                }
                field(Status; Rec.Status)
                {
                    Caption = 'Status';
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    Caption = 'Document Type';
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field("Error Text"; Rec."Error Text")
                {
                    Caption = 'Error Text';
                    ToolTip = 'Specifies the value of the Error Text field.';
                }
                field("Email Notification Sent"; Rec."Email Notification Sent")
                {
                    Caption = 'Email Notification Sent';
                    ToolTip = 'Specifies the value of the Email Notification Sent field.';
                }
                field("Email Recipients"; Rec."Email Recipients")
                {
                    Caption = 'Email Recipients';
                    ToolTip = 'Specifies the value of the Email Recipients field.';
                }
                field("Resend Email Notfication"; Rec."Resend Email Notfication")
                {
                    Caption = 'Resend Email Notfication';
                    ToolTip = 'Specifies the value of the Resend Email Notfication field.';
                }
                field("Email Notifications Sent On"; Rec."Email Notifications Sent On")
                {
                    Caption = 'Email Notifications Sent On';
                    ToolTip = 'Specifies the value of the Email Notifications Sent On field.';
                }
                field("Email Notifications Sent On 2"; Rec."Email Notifications Sent On 2")
                {
                    Caption = 'Email Notifications Sent On 2';
                    ToolTip = 'Specifies the value of the Email Notifications Sent On 2 field.';
                }
                field("Date Processed On"; Rec."Date Processed On")
                {
                    Caption = 'Date Processed On';
                    ToolTip = 'Specifies the value of the Date Processed On field.';
                }
            }
        }
    }

    actions
    {
    }
}

