page 50078 "CVE Pedimento"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    PageType = List;
    SourceTable = Table50023;

    layout
    {
        area(content)
        {
            repeater()
            {
                field(Code;Code)
                {
                }
                field(Description;Description)
                {
                }
                field("Include on Virtual Invoice";"Include on Virtual Invoice")
                {
                }
            }
        }
    }

    actions
    {
    }
}

