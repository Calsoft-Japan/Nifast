page 50006 "Sales Line Special Fields"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade
    // NF1.00:CIS.NG  09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)
    // NF1.00:Nifast.IT (Scott T.) 03/31/22 Changed Caption for Sub Route Number to read 'Cust PO Line Number' for Retaining customer purchase order line number received in EDI in order to return this value later in sales process in ASN.

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Sales Line";
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
                    CaptionClass = FORMAT(FORMAT(Rec."Document Type") + ' ' + Rec."Document No.");
                    Editable = false;
                    ToolTip = 'Specifies the value of the '''' field.';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the number of the customer.';
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ToolTip = 'Specifies a description of the blanket sales order.';
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
                //TODO
                /*  field("External Document No."; Rec."External Document No.")
                 {
                     Caption = 'Customer P.O. No.';
                     ToolTip = 'Specifies the value of the Customer P.O. No. field.';
                 } */
                //TODO
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
                    ToolTip = 'Specifies the inventory location from which the items sold should be picked and where the inventory decrease is registered.';
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                    ToolTip = 'Specifies the quantity of the sales order line.';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Editable = false;
                    ToolTip = 'Specifies the name of the item or resource''s unit of measure, such as piece or hour.';
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
                    Caption = 'Country of Origin';
                    ToolTip = 'Specifies the value of the Country of Origin field.';
                }
                field("Store Address"; Rec."Store Address")
                {
                    Caption = 'ASN No.';
                    ToolTip = 'Specifies the value of the ASN No. field.';
                }
                field("Sub Route Number"; Rec."Sub Route Number")
                {
                    Caption = 'Cust PO Line Number';
                    ToolTip = 'Specifies the value of the Cust PO Line Number field.';
                }
            }
        }
    }

    actions
    {
    }
}

