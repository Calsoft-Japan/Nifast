pageextension 71005 LAXManifest_NF extends "LAX Manifest"
{
    layout
    {
        addafter("Location Code")
        {
            field("Total Cartons"; Rec."Total Cartons")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Total Cartons field.', Comment = '%';
            }
        }
        addafter("Shipping Charge")
        {
            group(destination)
            {
                Caption = 'Destination';
                field("Destination Type"; Rec."Destination Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Destination Type field.';
                }
                field("Destination Code"; Rec."Destination Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Destination Code field.';
                }
                field("Destination Name"; Rec."Destination Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Destination Name field.';
                }
                field("Destination Address"; Rec."Destination Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Destination Address field.', Comment = '%';
                }
                field("Destination Address 2"; Rec."Destination Address 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Destination Address 2 field.', Comment = '%';
                }
                field("Destination City"; Rec."Destination City")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Destination City field.', Comment = '%';
                }
                field("Destination State"; Rec."Destination State")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Destination State field.', Comment = '%';
                }
                field("Destination ZIP Code"; Rec."Destination ZIP Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Destination ZIP Code field.', Comment = '%';
                }
                field("Destination Contact"; Rec."Destination Contact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Destination Contact field.', Comment = '%';
                }
            }
        }
    }
}
