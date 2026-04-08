pageextension 50054 PurchaseOrderSubformExt extends "Purchase Order Subform"
{
    // version NAVW18.00,NAVNA8.00,SE0.55.08,NV4.35,NIF1.060,NMX1.000,NIF.N15.C9IN.001,FOREX

    layout
    {

        //Unsupported feature: Change Editable on "Control 28". Please convert manually.

        addafter("No.")
        {
            field("Revision No."; Rec."Revision No.")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Revision No. field.';
                Caption = 'Revision No.';
            }
        }
        modify("Units per Parcel")
        {
            Visible = true;
        }
        addafter(Nonstock)
        {
            field(National; Rec.National)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the National field.';
                Caption = 'National';
            }
        }
        addafter("VAT Prod. Posting Group")
        {
            field("Contract Note No."; Rec."Contract Note No.")
            {
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Contract Note No. field.';
                Caption = 'Contract Note No.';
            }
            field("Exchange Contract No."; Rec."Exchange Contract No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Exchange Contract No. field.';
                Caption = 'Exchange Contract No.';
            }
        }
        addafter(Description)
        {
            field("Country of Origin Code"; Rec."Country of Origin Code")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Country of Origin Code field.';
                Caption = 'Country of Origin Code';
            }
            field(Manufacturer; Rec.Manufacturer)
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Manufacturer field.';
                Caption = 'Manufacturer';
            }
            field("Purchasing Code"; Rec."Purchasing Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Purchasing Code field.';
                Caption = 'Purchasing Code';
            }
            field("Vessel Name"; Rec."Vessel Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vessel Name field.', Comment = '%';
            }
            field("Sail-on Date"; Rec."Sail-on Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sail-on Date field.', Comment = '%';
            }
            field("Alt. Price"; Rec."Alt. Price")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Alt. Price field.', Comment = '%';
            }
            field("Alt. Qty. UOM"; Rec."Alt. Qty. UOM")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Alt. Qty. UOM field.', Comment = '%';
            }
            field("Alt. Quantity"; Rec."Alt. Quantity")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Alt. Quantity field.', Comment = '%';
            }
            field("Alt. Price UOM"; Rec."Alt. Price UOM")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Alt. Price UOM field.', Comment = '%';
            }
        }
        modify("Indirect Cost %")
        {
            Editable = false;
        }
        addafter("Line Discount Amount")
        {
            field("USD Value"; Rec."USD Value")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the USD Value field.';
                Caption = 'USD Value';
            }
        }
    }


    //Unsupported feature: CodeModification on "NoOnAfterValidate(PROCEDURE 19066594)". Please convert manually.

    //procedure NoOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    InsertExtendedText(FALSE);
    IF (Type = Type::"Charge (Item)") AND ("No." <> xRec."No.") AND
       (xRec."No." <> '')
    THEN
      CurrPage.SAVERECORD;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //>> NIF #10088 RTT 06-07-05
    HandleCommentLines;
    //>> NIF #10088 RTT 06-07-05

    #1..5
    */
    //end;

    procedure HandleCommentLines();
    begin
        if ((Rec."No." <> xRec."No.") or (Rec."Line No." = 0)) and
              ((Rec.Type = Rec.Type::Item) or (xRec.Type = Rec.Type::Item)) then begin
            if Rec.CheckIfLineComments() then
                CurrPage.SAVERECORD();
            Rec.DeleteLineComments();
            Rec.InsertLineComments();
        end;
    end;

}

