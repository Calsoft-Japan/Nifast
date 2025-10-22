page 50007 "Sales Shpt. Line Spec. Fields"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    UsageCategory = None;
    Permissions = TableData 111 = rm;
    SourceTable = "Sales Shipment Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(""; '')
                {
                    CaptionClass = FORMAT('Posted Shipment ' + Rec."Document No.");
                    Editable = false;
                    ToolTip = 'Specifies the value of the '''' field.';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Sell-to Customer No. field.';
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Box Weight"; Rec."Box Weight")
                {
                    ToolTip = 'Specifies the value of the Box Weight field.';
                }
                field("Certificate No."; Rec."Certificate No.")
                {
                    ToolTip = 'Specifies the value of the Certificate No. field.';
                }
                field("Container No."; Rec."Container No.")
                {
                    ToolTip = 'Specifies the value of the Container No. field.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    Caption = 'Customer P.O. No.';
                    ToolTip = 'Specifies the value of the Customer P.O. No. field.';
                }
                field("Dock Code"; Rec."Dock Code")
                {
                    ToolTip = 'Specifies the value of the Dock Code field.';
                }
                field("Deliver To"; Rec."Deliver To")
                {
                    ToolTip = 'Specifies the value of the Deliver To field.';
                }
                field("Delivery Order No."; Rec."Delivery Order No.")
                {
                    ToolTip = 'Specifies the value of the Delivery Order No. field.';
                }
                field("Eng. Change No."; Rec."Eng. Change No.")
                {
                    ToolTip = 'Specifies the value of the Eng. Change No. field.';
                }
                field("FRS No."; Rec."FRS No.")
                {
                    ToolTip = 'Specifies the value of the FRS No. field.';
                }
                field("Group Code"; Rec."Group Code")
                {
                    ToolTip = 'Specifies the value of the Group Code field.';
                }
                field("Kanban No."; Rec."Kanban No.")
                {
                    ToolTip = 'Specifies the value of the Kanban No. field.';
                }
                field("Line Side Address"; Rec."Line Side Address")
                {
                    ToolTip = 'Specifies the value of the Line Side Address field.';
                }
                field("Line Supply Location"; Rec."Line Supply Location")
                {
                    ToolTip = 'Specifies the value of the Line Supply Location field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Unit of Measure field.';
                }
                field("Main Route"; Rec."Main Route")
                {
                    ToolTip = 'Specifies the value of the Main Route field.';
                }
                field("Man No."; Rec."Man No.")
                {
                    ToolTip = 'Specifies the value of the Man No. field.';
                }
                field("Mfg. Date"; Rec."Mfg. Date")
                {
                    ToolTip = 'Specifies the value of the Mfg. Date field.';
                }
                field("Model Year"; Rec."Model Year")
                {
                    ToolTip = 'Specifies the value of the Model Year field.';
                }
                field("Plant Code"; Rec."Plant Code")
                {
                    ToolTip = 'Specifies the value of the Plant Code field.';
                }
                field("Ran No."; Rec."Ran No.")
                {
                    ToolTip = 'Specifies the value of the Ran No. field.';
                }
                field("Receiving Area"; Rec."Receiving Area")
                {
                    ToolTip = 'Specifies the value of the Receiving Area field.';
                }
                field("Release No."; Rec."Release No.")
                {
                    ToolTip = 'Specifies the value of the Release No. field.';
                }
                field("Res. Mfg."; Rec."Res. Mfg.")
                {
                    ToolTip = 'Specifies the value of the Res. Mfg. field.';
                }
                field("Revision No. (Label Only)"; Rec."Revision No. (Label Only)")
                {
                    ToolTip = 'Specifies the value of the Revision No. (Label Only) field.';
                }
                field("Special Markings"; Rec."Special Markings")
                {
                    ToolTip = 'Specifies the value of the Special Markings field.';
                }
                field("Storage Location"; Rec."Storage Location")
                {
                    ToolTip = 'Specifies the value of the Storage Location field.';
                }
                field("Store Address"; Rec."Store Address")
                {
                    ToolTip = 'Specifies the value of the Store Address field.';
                }
                field("Sub Route Number"; Rec."Sub Route Number")
                {
                    ToolTip = 'Specifies the value of the Sub Route Number field.';
                }
            }
        }
    }

    actions
    {
    }
}

