page 50009 "Customer Model Year"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    PageType = List;
    SaveValues = true;
    SourceTable = Table50017;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Customer No.";"Customer No.")
                {
                }
                field(Code;Code)
                {
                }
                field(Description;Description)
                {
                }
                field(Default;Default)
                {
                }
            }
        }
    }

    actions
    {
    }
}

