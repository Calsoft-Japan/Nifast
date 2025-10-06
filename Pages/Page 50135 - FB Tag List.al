page 50135 "FB Tag List"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)

    CardPageID = "FB Tag Card";
    Editable = false;
    PageType = List;
    SourceTable = Table50134;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("No.";"No.")
                {
                }
                field("Location Code";"Location Code")
                {
                }
                field("Customer No.";"Customer No.")
                {
                }
                field("Ship-to Code";"Ship-to Code")
                {
                }
                field("Item No.";"Item No.")
                {
                }
                field("Variant Code";"Variant Code")
                {
                    Visible = false;
                }
                field("Unit of Measure Code";"Unit of Measure Code")
                {
                }
                field("Customer Bin";"Customer Bin")
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

