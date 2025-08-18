pageextension 50900 AssemblyOrderExt extends "Assembly Order"
{
    // version NAVW18.00,NIF.N15.C9IN.001

    layout
    {
        addafter("Assemble to Order")
        {
            field("Purchase Order No."; Rec."Purchase Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Purchase Order No. field.';
            }
        }
    }
}

