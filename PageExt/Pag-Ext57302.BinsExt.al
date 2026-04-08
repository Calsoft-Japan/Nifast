namespace Nifast.Nifast;

using Microsoft.Warehouse.Structure;

pageextension 57302 BinsExt extends Bins
{
    layout
    {
        addafter(Description)
        {
            field("Bin Size Code"; Rec."Bin Size Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Bin Size Code field.', Comment = '%';
            }
            field("QC Bin"; Rec."QC Bin")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the QC Bin field.', Comment = '%';
            }
            field("Pick Bin Ranking"; Rec."Pick Bin Ranking")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Pick Bin Ranking field.', Comment = '%';
            }
            field("Staging Bin"; Rec."Staging Bin")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Staging Bin field.', Comment = '%';
            }
            field("License Plate Enabled"; Rec."License Plate Enabled")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the License Plate Enabled field.', Comment = '%';
            }
            field("Location Name"; Rec."Location Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Location Name field.', Comment = '%';
            }
        }
    }
}
