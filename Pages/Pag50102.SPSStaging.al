namespace Nifast.Nifast;

page 50102 "SPS Staging"
{
    ApplicationArea = All;
    Caption = 'SPS Staging';
    PageType = List;
    SourceTable = "SPS Staging";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Posted Shipment No."; Rec."Posted Shipment No.")
                {
                    ToolTip = 'Specifies the value of the Posted Shipment No. field.', Comment = '%';
                }
                field("Package No."; Rec."Package No.")
                {
                    ToolTip = 'Specifies the value of the Package No. field.', Comment = '%';
                }
                field("Package Line No."; Rec."Package Line No.")
                {
                    ToolTip = 'Specifies the value of the Package Line No. field.', Comment = '%';
                }
                field("Serial Number"; Rec."Serial Number")
                {
                    ToolTip = 'Specifies the value of the Serial Number field.', Comment = '%';
                }
                field("Units per parcel"; Rec."Units per parcel")
                {
                    ToolTip = 'Specifies the value of the Units per parcel field.', Comment = '%';
                }
                field("Package Weight"; Rec."Package Weight")
                {
                    ToolTip = 'Specifies the value of the Package Weight field.', Comment = '%';
                }
                field("Line Type"; Rec."Line Type")
                {
                    ToolTip = 'Specifies the value of the Line Type field.', Comment = '%';
                }
                field("Master Serial No."; Rec."Master Serial No.")
                {
                    ToolTip = 'Specifies the value of the Master Serial No. field.', Comment = '%';
                }
            }
        }
    }
}
