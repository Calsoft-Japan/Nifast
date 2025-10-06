page 50033 "4X Contract List"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    CardPageID = "4X Contract";
    Editable = false;
    PageType = List;
    SourceTable = Table50011;
    SourceTableView = SORTING(No.)
                      WHERE(Closed=CONST(No));

    layout
    {
        area(content)
        {
            repeater()
            {
                field("No.";"No.")
                {
                }
                field("Contract Note No.";"Contract Note No.")
                {
                }
                field(Total;Total)
                {
                    Editable = false;
                }
                field("Division Code";"Division Code")
                {
                }
                field("Date Created";"Date Created")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Line)
            {
                Caption = 'Line';
                action("Contract Card")
                {
                    Caption = 'Contract Card';
                    RunObject = Page 50026;
                    RunPageLink = No.=FIELD(No.);
                }
            }
        }
    }
}

