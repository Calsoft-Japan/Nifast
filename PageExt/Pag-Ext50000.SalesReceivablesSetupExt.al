pageextension 50000 "Sales & Receivables Setup Ext" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Update Document Date When Posting Date Is Modified")
        {
            field("Remit-To Description"; Rec."Remit-To Description")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Remit-To Description field.';
            }
            field("Remit-To Line 1"; Rec."Remit-To Line 1")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Remit-To Line 1 field.';
            }
            field("Remit-To Line 2"; Rec."Remit-To Line 1")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Remit-To Line 1 field.';
            }
            field("Remit-To Line 3"; Rec."Remit-To Line 3")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Remit-To Line 3 field.';
            }
            field("Remit-To Line 4"; Rec."Remit-To Line 4")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Remit-To Line 4 field.';
            }
            field("Enable Shipping - Picks"; Rec."Enable Shipping - Picks")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Enable Shipping - Picks field.';
            }
            field("Shipment Authorization Nos."; Rec."Shipment Authorization Nos.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shipment Authorization Nos. field.';
            }
            field("Delivery Schedule Batch Nos."; Rec."Delivery Schedule Batch Nos.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Delivery Schedule Batch Nos. field.';
            }
            field("Delivery Schedule Nos."; Rec."Delivery Schedule Nos.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Delivery Schedule Nos. field.';
            }
            field("Inbound PPS Directory"; Rec."Inbound PPS Directory")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Inbound PPS Directory field.';
            }
            field("Archive PPS Directory"; Rec."Archive PPS Directory")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Archive PPS Directory field.';
            }
            field("Use PPS XML format"; Rec."Use PPS XML format")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Use PPS XML format field.';
            }
            field("Planning Schedule Nos."; Rec."Planning Schedule Nos.")
            {
                ApplicationArea = All;
                Caption = 'CIS.001 - Added to resolve the conflict on table 14017885';
                ToolTip = 'Specifies the value of the CIS.001 - Added to resolve the conflict on table 14017885 field.';
            }
            field("Export Sales Inv/Cr/Memo Path"; Rec."Export Sales Inv/Cr/Memo Path")
            {
                ApplicationArea = All;
                Caption = 'Export Sales Inv/Cr/Memo Path';
                Description = 'AKK1612.01';
                ToolTip = 'Specifies the value of the Export Sales Inv/Cr/Memo Path field.';
            }
            field("Create Pack & Enable Ship"; Rec."Create Pack & Enable Ship")
            {
                ApplicationArea = All;
                Caption = 'Create Pack & Enable Ship';
                ToolTip = 'Specifies the value of the Create Pack & Enable Ship field.';
            }
        }
        addafter("LAX EDI Software Version")
        {
            field("EDI Control Nos."; Rec."EDI Control Nos.")
            {
                ApplicationArea = All;
                Caption = 'EDI Control No.';
                ToolTip = 'Specifies the value of the EDI Control Nos. field.';
            }
        }
    }
}
