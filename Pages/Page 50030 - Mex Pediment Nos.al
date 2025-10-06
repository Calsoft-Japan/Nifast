page 50030 "Mex Pediment Nos"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    Editable = false;
    PageType = List;
    SourceTable = Table50022;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Pedimento Virtual No.";"Pedimento Virtual No.")
                {
                    Editable = true;
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
        area(processing)
        {
            action("Create New")
            {
                Caption = 'Create New';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 50042;
            }
            action("Calsonic|K-MEX")
            {
                Caption = 'Calsonic|K-MEX';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 50047;
            }
        }
    }
}

