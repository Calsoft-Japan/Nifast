pageextension 71001 LAXPackingRule_NF extends "LAX Packing Rule"
{
    layout
    {
        addafter("Resource Label Code")
        {
            field("Automatic Print Label"; Rec."Automatic Print Label")
            {
                ApplicationArea = all;
                Visible = true;
            }
            field("Package Line Label Code"; Rec."Package Line Label Code")
            {
                ApplicationArea = all;
                Visible = true;
            }
            field("No. of Labels"; Rec."No. of Labels")
            {
                ApplicationArea = all;
                Visible = true;
            }
            field("Std. Package Label Code 2"; Rec."Std. Package Label Code 2")
            {
                ApplicationArea = all;
                Visible = true;
            }
        }
    }
}
