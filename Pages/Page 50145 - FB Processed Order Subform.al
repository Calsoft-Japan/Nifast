page 50145 "FB Processed Order Subform"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)
    // NIF 01-12-06 added "Replenishment Method" to the lines

    Editable = false;
    PageType = ListPart;
    SourceTable = Table50137;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Tag No.";"Tag No.")
                {
                }
                field("Item No.";"Item No.")
                {
                }
                field("Variant Code";"Variant Code")
                {
                    Visible = false;
                }
                field(Quantity;Quantity)
                {
                }
                field("Unit of Measure Code";"Unit of Measure Code")
                {
                }
                field("Lot No.";"Lot No.")
                {
                }
                field("External Document No.";"External Document No.")
                {
                }
                field("Customer Bin";"Customer Bin")
                {
                }
                field("Replenishment Method";"Replenishment Method")
                {
                }
                field(Status;Status)
                {
                }
                field("Cross-Reference No.";"Cross-Reference No.")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
        }
    }

    var
        FBManagement: Codeunit "50133";
}

