page 50153 "Electronic Accouting Setup"
{
    Caption = 'Electronic Accouting Setup';
    SourceTable = Table50035;

    layout
    {
        area(content)
        {
            group("General Setup")
            {
                Caption = 'General Setup';
                field("EA Sales - Chk VAT Em";"EA Sales - Chk VAT Em")
                {
                }
                field("EA Sales - Chk VAT Rc";"EA Sales - Chk VAT Rc")
                {
                }
                field("EA Purch - Chk VAT Em";"EA Purch - Chk VAT Em")
                {
                }
                field("EA Purch - Chk VAT Rc";"EA Purch - Chk VAT Rc")
                {
                }
                field("EA Validate Date";"EA Validate Date")
                {
                }
                field("EA Chk Amount";"EA Chk Amount")
                {
                }
                field("EA Variant Amount";"EA Variant Amount")
                {
                }
                field("EA Chk UUID";"EA Chk UUID")
                {
                }
            }
            group("XML Generation")
            {
                Caption = 'XML Generation Setup';
                field("SAT XML Path";"SAT XML Path")
                {
                }
                field("Check Element Code";"Check Element Code")
                {
                }
                field("Transfer Element Code";"Transfer Element Code")
                {
                }
                field("Nationals Operations Code";"Nationals Operations Code")
                {
                }
                field("Foreign Operations Code";"Foreign Operations Code")
                {
                }
            }
        }
    }

    actions
    {
    }
}

