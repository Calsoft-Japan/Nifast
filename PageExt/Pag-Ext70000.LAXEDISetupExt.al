namespace Nifast.Nifast;

pageextension 70500 LAXEDISetupExt extends "LAX EDI Setup"
{
    layout
    {
        addlast("No. Series.")
        {
            field("General Message Nos."; Rec."General Message Nos.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the General Message Nos. field.', Comment = '%';
            }
            field("EDI Control Nos."; Rec."EDI Control Nos.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the EDI Control Nos. field.', Comment = '%';
            }
        }
    }
}
