page 50056 "TEMP Shipment Method"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Vendor;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                    Enabled = true;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ToolTip = 'Specifies the value of the Shipping Agent Code field.';
                }
            }
        }
    }

    actions
    {
    }
}

