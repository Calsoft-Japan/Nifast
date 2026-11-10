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
                field("SPS Serial E-Mail Subject Text"; Rec."SPS Serial E-Mail Subject Text")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the SPS Serial Subject Text field.', Comment = '%';
                }
                field("SPS Partial E-Mail Subject Text"; Rec."SPS Partial E-Mail Subject Text")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SPS Partial Subject Text field.', Comment = '%';
                }
                field("SPS Serial E-Mail Body Text"; Rec."SPS Serial E-Mail Body Text")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the SPS Serial E-Mail Body Text field.', Comment = '%';
                }
                field("SPS Partial E-Mail Body Text"; Rec."SPS Partial E-Mail Body Text")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the SPS Partial E-Mail Body Text field.', Comment = '%';
                }
            }
        }
    }
}
