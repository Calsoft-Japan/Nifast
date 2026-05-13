pageextension 71007 LAXManifestSubform_NF extends "LAX Manifest Subform"
{
    layout
    {
        addafter("Shipping Agent Service")
        {
            field("Bill of Lading No."; Rec."Bill of Lading No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Bill of Lading No. field.';
            }
            field("ASN Order"; Rec."ASN Order")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the ASN Order field.';
            }
            field("ASN Generated"; Rec."ASN Generated")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the ASN Generated field.';
            }
            field("Cartons"; Rec.Cartons)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Cartons field.';
            }
        }
    }
}