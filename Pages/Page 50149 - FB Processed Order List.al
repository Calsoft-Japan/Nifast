page 50149 "FB Processed Order List"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)
    // 12-14-05 Added "Import Time"

    CardPageID = "FB Processed Order";
    Editable = false;
    PageType = List;
    SourceTable = Table50136;
    SourceTableView = WHERE(Status=CONST(Processed));

    layout
    {
        area(content)
        {
            repeater()
            {
                field("No.";"No.")
                {
                }
                field("Sell-to Customer No.";"Sell-to Customer No.")
                {
                }
                field("Ship-To Code";"Ship-To Code")
                {
                }
                field("Location Code";"Location Code")
                {
                }
                field("Order Date";"Order Date")
                {
                }
                field(Status;Status)
                {
                }
                field("Import Date";"Import Date")
                {
                }
                field("Import Time";"Import Time")
                {
                }
                field("Import File Name";"Import File Name")
                {
                }
                field("FB Order Type";"FB Order Type")
                {
                }
                field("External Document No.";"External Document No.")
                {
                }
                field("Salesperson Code";"Salesperson Code")
                {
                }
                field("Inside Salesperson Code";"Inside Salesperson Code")
                {
                }
                field("Contract No.";"Contract No.")
                {
                }
            }
        }
    }

    actions
    {
    }
}

