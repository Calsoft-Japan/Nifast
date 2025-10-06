page 50133 "FB Setup"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)

    PageType = Card;
    SourceTable = Table50133;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Order Nos.";"Order Nos.")
                {
                }
                field("Tag Nos.";"Tag Nos.")
                {
                }
                field("Import Data Log Nos.";"Import Data Log Nos.")
                {
                }
                field("Req. Worksheet Template";"Req. Worksheet Template")
                {
                }
                field("Req. Worksheet Name";"Req. Worksheet Name")
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        Path: Text[250];
}

