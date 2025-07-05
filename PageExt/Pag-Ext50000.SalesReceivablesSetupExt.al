pageextension 50000 "Sales & Receivables Setup Ext" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Update Document Date When Posting Date Is Modified")
        {
            field("Remit-To Description"; Rec."Remit-To Description")
            {
                ApplicationArea = All;
            }
            field("Remit-To Line 1"; Rec."Remit-To Line 1")
            {
                ApplicationArea = All;
            }
            field("Remit-To Line 2"; Rec."Remit-To Line 1")
            {
                ApplicationArea = All;
            }
            field("Remit-To Line 3"; Rec."Remit-To Line 3")
            {
                ApplicationArea = All;
            }
            field("Remit-To Line 4"; Rec."Remit-To Line 4")
            {
                ApplicationArea = All;
            }
            field("Enable Shipping - Picks"; Rec."Enable Shipping - Picks")
            {
                ApplicationArea = All;
            }
            field("Shipment Authorization Nos."; Rec."Shipment Authorization Nos.")
            {
                ApplicationArea = All;
            }
            field("Delivery Schedule Batch Nos."; Rec."Delivery Schedule Batch Nos.")
            {
                ApplicationArea = All;
            }
            field("Delivery Schedule Nos."; Rec."Delivery Schedule Nos.")
            {
                ApplicationArea = All;
            }
            field("Inbound PPS Directory"; Rec."Inbound PPS Directory")
            {
                ApplicationArea = All;
            }
            field("Archive PPS Directory"; Rec."Archive PPS Directory")
            {
                ApplicationArea = All;
            }
            field("Use PPS XML format"; Rec."Use PPS XML format")
            {
                ApplicationArea = All;
            }
            field("Planning Schedule Nos."; Rec."Planning Schedule Nos.")
            {
                ApplicationArea = All;
                Caption = 'CIS.001 - Added to resolve the conflict on table 14017885';
            }
            field("Export Sales Inv/Cr/Memo Path"; Rec."Export Sales Inv/Cr/Memo Path")
            {
                ApplicationArea = All;
                Caption = 'Export Sales Inv/Cr/Memo Path';
                Description = 'AKK1612.01';
            }
            field("Create Pack & Enable Ship"; Rec."Create Pack & Enable Ship")
            {
                ApplicationArea = All;
                Caption = 'Create Pack & Enable Ship';
            }
        }
    }
}
