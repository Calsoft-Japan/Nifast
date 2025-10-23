page 50068 "Ship Authorization Line"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    PageType = ListPart;
    SourceTable = "Ship Authorization Line";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Qty. Type"; Rec."Qty. Type")
                {
                    ToolTip = 'Specifies the value of the Qty. Type field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Cross-Reference No."; Rec."Cross-Reference No.")
                {
                    ToolTip = 'Specifies the value of the Cross-Reference No. field.';
                }
                field("Cross-Reference Type"; Rec."Cross-Reference Type")
                {
                    ToolTip = 'Specifies the value of the Cross-Reference Type field.';
                }
                field("Cross-Reference Type No."; Rec."Cross-Reference Type No.")
                {
                    ToolTip = 'Specifies the value of the Cross-Reference Type No. field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Unit of Measure field.';
                }
                field("Ship Authorization No."; Rec."Ship Authorization No.")
                {
                    ToolTip = 'Specifies the value of the Ship Authorization No. field.';
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ToolTip = 'Specifies the value of the Requested Delivery Date field.';
                }
                field("Purchase Order Number"; Rec."Purchase Order Number")
                {
                    ToolTip = 'Specifies the value of the Purchase Order Number field.';
                }
                field("Purchase Order Line No."; Rec."Purchase Order Line No.")
                {
                    ToolTip = 'Specifies the value of the Purchase Order Line No. field.';
                }
                field("Delivery Plan"; Rec."Delivery Plan")
                {
                    ToolTip = 'Specifies the value of the Delivery Plan field.';
                }
                field("Place ID"; Rec."Place ID")
                {
                    ToolTip = 'Specifies the value of the Place ID field.';
                }
                field("Place Description"; Rec."Place Description")
                {
                    ToolTip = 'Specifies the value of the Place Description field.';
                }
            }
        }
    }

    actions
    {
    }

    procedure UpdateForm()
    begin
        CurrPage.UPDATE();
    end;
}

