page 50062 "Posted Package Lines"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    PageType = List;
    SourceTable = "LAX Posted Package Line";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Package No."; Rec."Package No.")
                {
                    ToolTip = 'Specifies the value of the Package No. field.';
                    Caption = 'Package No.';
                }
                field("Source Type"; Rec."Source Type")
                {
                    ToolTip = 'Specifies the value of the Source Type field.';
                    Caption = 'Source Type';
                }
                field("Source ID"; Rec."Source ID")
                {
                    ToolTip = 'Specifies the value of the Source ID field.';
                    Caption = 'Source ID';
                }
                field("Posted Source ID"; Rec."Posted Source ID")
                {
                    ToolTip = 'Specifies the value of the Posted Source ID field.';
                    Caption = 'Posted Source ID';
                }
                field("Carton First SrNo."; Rec."Carton First SrNo.")
                {
                    ToolTip = 'Specifies the value of the Carton First SrNo. field.';
                    Caption = 'Carton First SrNo.';
                }
                field("Carton Last SrNo."; Rec."Carton Last SrNo.")
                {
                    ToolTip = 'Specifies the value of the Carton Last SrNo. field.';
                    Caption = 'Carton Last SrNo.';
                }
                field("Master Label SrNo."; Rec."Master Label SrNo.")
                {
                    ToolTip = 'Specifies the value of the Master Label SrNo. field.';
                    Caption = 'Master Label SrNo.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                    Caption = 'Line No.';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                    Caption = 'Type';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    Caption = 'No.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                    Caption = 'Quantity';
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                    ToolTip = 'Specifies the value of the Quantity (Base) field.';
                    Caption = 'Quantity (Base)';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                    Caption = 'Unit of Measure Code';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    Caption = 'Description';
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ToolTip = 'Specifies the value of the Lot No. field.';
                    Caption = 'Lot No.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                    Caption = 'Location Code';
                }
            }
        }
    }

    actions
    {
    }
}

