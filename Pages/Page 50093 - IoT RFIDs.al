page 50093 "IoT RFIDs"
{
    // CIS.IoT 07/22/22 RAM Created new Object

    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "IoT RFIDs";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(RFID; Rec.RFID)
                {
                    ToolTip = 'Specifies the value of the RFID field.';
                    Caption = 'RFID';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                    Caption = 'Location Code';
                }
                field("Customer Code"; Rec."Customer Code")
                {
                    ToolTip = 'Specifies the value of the Customer Code field.';
                    Caption = 'Customer Code';
                }
            }
        }
    }

    actions
    {
    }
}

