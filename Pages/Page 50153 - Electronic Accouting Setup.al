page 50153 "Electronic Accouting Setup"
{
    Caption = 'Electronic Accouting Setup';
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Electornic Accounting Setup";

    layout
    {
        area(content)
        {
            group("General Setup")
            {
                Caption = 'General Setup';
                field("EA Sales - Chk VAT Em"; Rec."EA Sales - Chk VAT Em")
                {
                    ToolTip = 'Specifies the value of the Sales - Validate VAT Registration No Emisor field.';
                }
                field("EA Sales - Chk VAT Rc"; Rec."EA Sales - Chk VAT Rc")
                {
                    ToolTip = 'Specifies the value of the Sales - Validate VAT Registration No Receptor field.';
                }
                field("EA Purch - Chk VAT Em"; Rec."EA Purch - Chk VAT Em")
                {
                    ToolTip = 'Specifies the value of the Purchase - Validate VAT Registratio No Emisor field.';
                }
                field("EA Purch - Chk VAT Rc"; Rec."EA Purch - Chk VAT Rc")
                {
                    ToolTip = 'Specifies the value of the Purchase - Validate VAT Registration No Receptor field.';
                }
                field("EA Validate Date"; Rec."EA Validate Date")
                {
                    ToolTip = 'Specifies the value of the Validate Date field.';
                }
                field("EA Chk Amount"; Rec."EA Chk Amount")
                {
                    ToolTip = 'Specifies the value of the Validate Amount field.';
                }
                field("EA Variant Amount"; Rec."EA Variant Amount")
                {
                    ToolTip = 'Specifies the value of the Variant on Amount field.';
                }
                field("EA Chk UUID"; Rec."EA Chk UUID")
                {
                    ToolTip = 'Specifies the value of the Validate UUID field.';
                }
            }
            group("XML Generation")
            {
                Caption = 'XML Generation Setup';
                field("SAT XML Path"; Rec."SAT XML Path")
                {
                    ToolTip = 'Specifies the value of the SAT XML Path field.';
                }
                field("Check Element Code"; Rec."Check Element Code")
                {
                    ToolTip = 'Specifies the value of the Check Element Code field.';
                }
                field("Transfer Element Code"; Rec."Transfer Element Code")
                {
                    ToolTip = 'Specifies the value of the Transfer Element Code field.';
                }
                field("Nationals Operations Code"; Rec."Nationals Operations Code")
                {
                    ToolTip = 'Specifies the value of the Nationals Operations Code field.';
                }
                field("Foreign Operations Code"; Rec."Foreign Operations Code")
                {
                    ToolTip = 'Specifies the value of the Foreign Operations Code field.';
                }
            }
        }
    }

    actions
    {
    }
}

