page 50008 "Cross Reference Subform"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    PageType = ListPart;
    SourceTable = Table5717;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Cross-Reference Type No.";"Cross-Reference Type No.")
                {
                }
                field("Cross-Reference No.";"Cross-Reference No.")
                {
                }
                field(CrossRefName;CrossRefName)
                {
                    Caption = 'Cross-Reference Name';
                    Editable = false;
                }
                field(OEM;OEM)
                {
                }
                field(Model;Model)
                {
                }
                field(EMU;EMU)
                {
                    DecimalPlaces = 0:0;
                }
                field("Pieces/Vehicle";"Pieces/Vehicle")
                {
                    DecimalPlaces = 0:0;
                }
                field(SOP;SOP)
                {
                }
                field(EOP;EOP)
                {
                }
                field(Remarks;Remarks)
                {
                }
                field(Division;Division)
                {
                }
                field("AFC Stam";"AFC Stam")
                {
                }
                field("ECI No.";"ECI No.")
                {
                }
                field(Application;Application)
                {
                }
                field(Manter;Manter)
                {
                }
            }
        }
    }

    actions
    {
    }
}

