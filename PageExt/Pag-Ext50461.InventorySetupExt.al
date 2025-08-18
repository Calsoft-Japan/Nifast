pageextension 50461 InventorySetupExt extends "Inventory Setup"
{
    // version NAVW17.10,SE0.54.10,NV4.35,NIF1.000,NIF.N15.C9IN.001,CIS.IoT

    layout
    {
        addafter("Inbound Whse. Handling Time")
        {
            field("Def. Item Tracking Code"; Rec."Def. Item Tracking Code")
            {
                ToolTip = 'Specifies the value of the Def. Item Tracking Code field.';
                ApplicationArea = All;
            }
            field("Def. E-ship Tracking Code"; Rec."Def. E-ship Tracking Code")
            {
                ToolTip = 'Specifies the value of the Def. E-ship Tracking Code field.';
                ApplicationArea = All;
            }
            field("Def. Lot Nos."; Rec."Def. Lot Nos.")
            {
                ToolTip = 'Specifies the value of the Def. Lot Nos. field.';
                ApplicationArea = All;
            }
        }
        addafter("Internal Movement Nos.")
        {
            group(Nifast)
            {
                Caption = 'Nifast';
                field("Auto. Transfer Order Nos."; Rec."Auto. Transfer Order Nos.")
                {
                    ToolTip = 'Specifies the value of the Auto. Transfer Order Nos. field.';
                    ApplicationArea = All;
                }
                field("Default In-Transit Location"; Rec."Default In-Transit Location")
                {
                    ToolTip = 'Specifies the value of the Default In-Transit Location field.';
                    ApplicationArea = All;
                }
            }
            group("IoT Data")
            {
                Caption = 'IoT Data';
                field("IoT Create Invt. Pick"; Rec."IoT Create Invt. Pick")
                {
                    ToolTip = 'Specifies the value of the IoT Create Invt. Pick field.';
                    ApplicationArea = All;
                }
                field("IoT Admin. Email"; Rec."IoT Admin. Email")
                {
                    ToolTip = 'Specifies the value of the IoT Admin. Email field.';
                    ApplicationArea = All;
                }
                field("IoT Admin. CC Email"; Rec."IoT Admin. CC Email")
                {
                    ToolTip = 'Specifies the value of the IoT Admin. CC Email field.';
                    ApplicationArea = All;
                }
                field("IoT Trans. Order Email"; Rec."IoT Trans. Order Email")
                {
                    ToolTip = 'Specifies the value of the IoT Trans. Order Email field.';
                    ApplicationArea = All;
                }
                field("IoT Trans Order CC Email"; Rec."IoT Trans Order CC Email")
                {
                    ToolTip = 'Specifies the value of the IoT Trans Order CC Email field.';
                    ApplicationArea = All;
                }
                field("IoT Sales Email"; Rec."IoT Sales Email")
                {
                    ToolTip = 'Specifies the value of the IoT Sales Email field.';
                    ApplicationArea = All;
                }
                field("IoT Sales CC Email"; Rec."IoT Sales CC Email")
                {
                    ToolTip = 'Specifies the value of the IoT Sales CC Email field.';
                    ApplicationArea = All;
                }
                field("Send Email Notifications"; Rec."Send Email Notifications")
                {
                    ToolTip = 'Specifies the value of the Send Email Notifications field.';
                    ApplicationArea = All;
                }
                field("Send Email CC to Admin"; Rec."Send Email CC to Admin")
                {
                    ToolTip = 'Specifies the value of the Send Email CC to Admin field.';
                    ApplicationArea = All;
                }
                field("Delete IoT File on Success"; Rec."Delete IoT File on Success")
                {
                    ToolTip = 'Specifies the value of the Delete IoT File on Success field.';
                    ApplicationArea = All;
                }
                field("Invt. Pick File Path"; Rec."Invt. Pick File Path")
                {
                    ToolTip = 'Specifies the value of the Invt. Pick File Path field.';
                    ApplicationArea = All;
                }
                field("Tras. Rcpt. File Path"; Rec."Tras. Rcpt. File Path")
                {
                    ToolTip = 'Specifies the value of the Tras. Rcpt. File Path field.';
                    ApplicationArea = All;
                }
                field("Sales Ship. File Path"; Rec."Sales Ship. File Path")
                {
                    ToolTip = 'Specifies the value of the Sales Ship. File Path field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}

