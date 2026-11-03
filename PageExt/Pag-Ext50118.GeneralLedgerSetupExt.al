pageextension 50118 GeneralLedgerSetupExt extends "General Ledger Setup"
{
    layout
    {
        addlast(General)
        {
            group("SPS E-Mail Setup")
            {
                field("SPS E-Mail"; Rec."SPS E-Mail")
                {
                    ApplicationArea = All;
                }
                field("SPS E-Mail Subject Text"; Rec."SPS E-Mail Subject Text")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the SPS Subject Text field.', Comment = '%';
                }
                field("SPS E-Mail Body Text"; Rec."SPS E-Mail Body Text")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the SPS Body Text field.', Comment = '%';
                }
            }
        }
    }
}
