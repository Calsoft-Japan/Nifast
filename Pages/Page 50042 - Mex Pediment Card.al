page 50042 "Mex Pediment Card"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    PageType = Card;
    SourceTable = Table50022;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Pedimento Virtual No.";"Pedimento Virtual No.")
                {
                }
                field("Start Date";"Start Date")
                {
                }
                field("End Date";"End Date")
                {
                }
                field("Customer No.";"Customer No.")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;
}

