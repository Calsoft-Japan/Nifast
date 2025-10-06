page 50035 "Vehicle Prodcution Form"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    PageType = List;
    SourceTable = Table50029;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Customer No.";"Customer No.")
                {
                }
                field("Item No.";"Item No.")
                {
                }
                field(Model;Model)
                {
                }
                field("EC Level";"EC Level")
                {
                }
                field("Applicable Std";"Applicable Std")
                {
                }
                field(EMU;EMU)
                {
                    Caption = 'Date';
                }
                field(OEM;OEM)
                {
                    Caption = 'EWU';
                }
                field("Final Customer";"Final Customer")
                {
                    Caption = 'PPV';
                }
                field(Per;Per)
                {
                }
            }
        }
    }

    actions
    {
    }
}

