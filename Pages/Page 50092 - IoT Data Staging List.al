page 50092 "IoT Data Staging List"
{
    // CIS.IoT 07/22/22 RAM Created new Object

    PageType = List;
    SourceTable = Table50042;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No.";"Entry No.")
                {
                }
                field("Document Type";"Document Type")
                {
                }
                field("Document No.";"Document No.")
                {
                }
                field("Line No.";"Line No.")
                {
                }
                field("Table No.";"Table No.")
                {
                }
                field("Item No.";"Item No.")
                {
                }
                field("Lot No.";"Lot No.")
                {
                }
                field(Quantity;Quantity)
                {
                }
                field("Location From";"Location From")
                {
                }
                field("Location To";"Location To")
                {
                }
                field("RFID Gate No.";"RFID Gate No.")
                {
                }
                field("Record Status";"Record Status")
                {
                }
                field("Date Processed On";"Date Processed On")
                {
                }
                field("Email Notification Sent";"Email Notification Sent")
                {
                }
                field("Email Notifications Sent On";"Email Notifications Sent On")
                {
                }
                field("Resend Email Notfication";"Resend Email Notfication")
                {
                }
                field("Email Notifications Sent On 2";"Email Notifications Sent On 2")
                {
                }
                field("Email Recipients";"Email Recipients")
                {
                }
                field("Error Message";"Error Message")
                {
                }
                field("Output Document Type";"Output Document Type")
                {
                }
                field("Output Document No.";"Output Document No.")
                {
                }
                field("Output Invt. Pick Type";"Output Invt. Pick Type")
                {
                }
                field("Output Pick No.";"Output Pick No.")
                {
                }
                field("File Name";"File Name")
                {
                }
                field("Date Imported";"Date Imported")
                {
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

                trigger OnAction()
                var
                    IoTSendEmails: Codeunit "50004";
                begin
                    CLEAR(IoTSendEmails);
                    IoTSendEmails.RUN;
                end;
            }
        }
    }
}

