page 50147 "Lot Bin Content Buffer"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Lot Entry Functionality Renumber)

    Editable = false;
    PageType = Card;
    SourceTable = Table7330;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Location Code";"Location Code")
                {
                }
                field("Zone Code";"Zone Code")
                {
                }
                field("Bin Code";"Bin Code")
                {
                }
                field("QC Bin";"QC Bin")
                {
                }
                field("Item No.";"Item No.")
                {
                }
                field("Variant Code";"Variant Code")
                {
                }
                field("Unit of Measure Code";"Unit of Measure Code")
                {
                }
                field("Qty. to Handle (Base)";"Qty. to Handle (Base)")
                {
                }
                field(Cubage;Cubage)
                {
                }
                field(Weight;Weight)
                {
                }
                field("Lot No.";"Lot No.")
                {
                }
                field("Serial No.";"Serial No.")
                {
                }
            }
        }
    }

    actions
    {
    }
}

