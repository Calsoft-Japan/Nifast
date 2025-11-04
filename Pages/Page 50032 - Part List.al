page 50032 "Part List"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade
    // SM.001 - 09-21-16 ADDED PPAP Approved
    // SM.001 - 10-25-16 ADDED REVISION NO.

    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Vehicle Production";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.';
                }
                field("Div Code"; Rec."Div Code")
                {
                    Caption = 'Div Code';
                    ToolTip = 'Specifies the value of the Div Code field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Cross Reference No."; Rec."Cross Reference No.")
                {
                    ToolTip = 'Specifies the value of the Cross Reference No. field.';
                }
                field("EC Level"; Rec."EC Level")
                {
                    ToolTip = 'Specifies the value of the EC Level field.';
                }
                field("Applicable Std"; Rec."Applicable Std")
                {
                    ToolTip = 'Specifies the value of the Applicable Std field.';
                }
                field(EMU; Rec.EMU)
                {
                    DecimalPlaces = 0 : 0;
                    ToolTip = 'Specifies the value of the EMU field.';
                }
                field(OEM; Rec.OEM)
                {
                    ToolTip = 'Specifies the value of the OEM field.';
                }
                field(Model; Rec.Model)
                {
                    ToolTip = 'Specifies the value of the Model field.';
                }
                field("Final Customer"; Rec."Final Customer")
                {
                    ToolTip = 'Specifies the value of the Final Customer field.';
                }
                field("Pieces Per Vehicle"; Rec."Pieces Per Vehicle")
                {
                    DecimalPlaces = 2 : 2;
                    ToolTip = 'Specifies the value of the Pieces Per Vehicle field.';
                }
                field(Per; Rec.Per)
                {
                    ToolTip = 'Specifies the value of the Per field.';
                }
                field(SOP; Rec.SOP)
                {
                    ToolTip = 'Specifies the value of the SOP field.';
                }
                field(EOP; Rec.EOP)
                {
                    ToolTip = 'Specifies the value of the EOP field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field(Active; Rec.Active)
                {
                    Caption = 'Inactive';
                    ToolTip = 'Specifies the value of the Inactive field.';
                }
                field(SNP; Rec.SNP)
                {
                    DecimalPlaces = 0 : 0;
                    ToolTip = 'Specifies the value of the SNP field.';
                }
                field(Selling; Rec.Selling)
                {
                    DecimalPlaces = 4 : 4;
                    ToolTip = 'Specifies the value of the Selling field.';
                }
                field(Buying; Rec.Buying)
                {
                    DecimalPlaces = 4 : 4;
                    ToolTip = 'Specifies the value of the Buying field.';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ToolTip = 'Specifies the value of the Vendor No. field.';
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ToolTip = 'Specifies the value of the Vendor Name field.';
                }
                field(Manufacturer; Rec.Manufacturer)
                {
                    ToolTip = 'Specifies the value of the Manufacturer field.';
                }
                field("Flow Item"; Rec."Flow Item")
                {
                    ToolTip = 'Specifies the value of the Flow Item field.';
                }
                field("Remark-2"; Rec."Remark-2")
                {
                    ToolTip = 'Specifies the value of the Remark-2 field.';
                }
                field("PPAP Approved"; Rec."PPAP Approved")
                {
                    ToolTip = 'Specifies the value of the PPAP Approved field.';
                }
                field("Revision No."; Rec."Revision No.")
                {
                    ToolTip = 'Specifies the value of the Revision No. field.';
                }
                field("PPAP Approved Date"; Rec."PPAP Approved Date")
                {
                    ToolTip = 'Specifies the value of the PPAP Approved Date field.';
                }
            }
        }
    }

    actions
    {
    }
}

