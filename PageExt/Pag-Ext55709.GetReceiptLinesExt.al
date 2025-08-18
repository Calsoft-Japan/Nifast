pageextension 55709 GetReceiptLinesExt extends "Get Receipt Lines"
{
    // version NAVW18.00,4x,NIF1.033,NIF.N15.C9IN.001

    layout
    {
        addfirst(Control1)
        {
            field("Contract Note No."; Rec."Contract Note No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Contract Note No. field.';
            }
        }
        addafter("Buy-from Vendor No.")
        {
            field("Vessel Name"; Rec."Vessel Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vessel Name field.';
            }
            field("Order No."; Rec."Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Order No. field.';
            }
        }
        addafter("No.")
        {
            field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Gen. Prod. Posting Group field.';
            }
        }
    }
}

