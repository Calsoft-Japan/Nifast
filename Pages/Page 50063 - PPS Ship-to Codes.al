page 50063 "PPS Ship-to Codes"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    PageType = List;
    SourceTable = Table50024;

    layout
    {
        area(content)
        {
            repeater()
            {
                field(Code;Code)
                {
                }
                field("Ship-to Code";"Ship-to Code")
                {
                }
                field(Description;Description)
                {
                }
            }
        }
    }

    actions
    {
    }
}

