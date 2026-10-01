pageextension 71004 LAXReceiveRule_NF extends "LAX Receive Rule"
{
    layout
    {
        addafter("Automatic Print Label")
        {
            field("QC Label Code"; Rec."QC Label Code")
            {
                ApplicationArea = All;
            }
            field("Production Label Code"; Rec."Production Label Code")
            {
                ApplicationArea = All;
            }

        }
    }
}
