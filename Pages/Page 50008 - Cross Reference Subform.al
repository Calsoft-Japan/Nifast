page 50008 "Cross Reference Subform"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    PageType = ListPart;
    UsageCategory = Lists;
    ApplicationArea = All;
    //SourceTable = 5717;
    SourceTable = "Item Reference";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cross-Reference Type No."; Rec."Reference Type No.")
                {
                    ToolTip = 'Specifies the value of the Reference Type No. field.';
                }
                field("Cross-Reference No."; Rec."Reference No.")
                {
                    ToolTip = 'Specifies the value of the Reference No. field.';
                }
                field(CrossRefName; Rec.CrossRefName())
                {
                    Caption = 'Cross-Reference Name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Cross-Reference Name field.';
                }
                field(OEM; Rec.OEM)
                {
                    ToolTip = 'Specifies the value of the OEM field.';
                }
                field(Model; Rec.Model)
                {
                    ToolTip = 'Specifies the value of the Model field.';
                }
                field(EMU; Rec.EMU)
                {
                    DecimalPlaces = 0 : 0;
                    ToolTip = 'Specifies the value of the EMU field.';
                }
                field("Pieces/Vehicle"; Rec."Pieces/Vehicle")
                {
                    DecimalPlaces = 0 : 0;
                    ToolTip = 'Specifies the value of the Pieces/Vehicle field.';
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
                field(Division; Rec.Division)
                {
                    ToolTip = 'Specifies the value of the Division field.';
                }
                field("AFC Stam"; Rec."AFC Stam")
                {
                    ToolTip = 'Specifies the value of the AFC Stam field.';
                }
                field("ECI No."; Rec."ECI No.")
                {
                    ToolTip = 'Specifies the value of the ECI No. field.';
                }
                field(Application; Rec.Application)
                {
                    ToolTip = 'Specifies the value of the Application field.';
                }
                field(Manter; Rec.Manter)
                {
                    ToolTip = 'Specifies the value of the Manter field.';
                }
            }
        }
    }

    actions
    {
    }
}

