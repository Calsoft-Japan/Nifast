pageextension 50046 SalesOrderSubformExt extends "Sales Order Subform"
{
    // version NAVW18.00,NAVNA8.00,SE0.54.10,NV4.35,NIF1.050,NMX1.000,NIF.N15.C9IN.001

    layout
    {
        addafter("No.")
        {
            field("Revision No."; Rec."Revision No.")
            {
                Visible = false;
                ToolTip = 'Specifies the value of the Revision No. field.';
            }
            field(National; Rec.National)
            {
                ToolTip = 'Specifies the value of the National field.';
            }
        }
        addafter("Unit Price")
        {
            field("Units per Parcels"; Rec."Units per Parcel")
            {
                BlankZero = true;
                Editable = false;
                ToolTip = 'Specifies the value of the Units per Parcel field.';
            }
            field("Total Parcels"; Rec."Total Parcels")
            {
                BlankZero = true;
                Editable = false;
                ToolTip = 'Specifies the value of the Total Parcels field.';
            }
        }
        modify("Line Amount")
        {
            Editable = false;
            ToolTip = 'Specifies the value of the Line Amount field.';
        }
        modify("Appl.-to Item Entry")
        {
            visible = true;
        }
        addafter("Substitution Available")
        {
            field("Location Qty"; LocationItem.Inventory)
            {
                Caption = 'Location Qty';
                Editable = false;
                ToolTip = 'Specifies the value of the Location Qty field.';
            }
            field("Available Qty"; LDec[2])
            {
                Caption = 'Available Qty';
                Editable = false;
                ToolTip = 'Specifies the value of the Available Qty field.';
            }
            field("Last Sale"; LDate[1])
            {
                Caption = 'Last Sale';
                Editable = false;
                ToolTip = 'Specifies the value of the Last Sale field.';
            }
        }
        moveafter("Description 2"; Nonstock, "Substitution Available")
    }
    actions
    {
        addfirst(processing)
        {
            group("&NewVision")
            {
                Caption = '&NewVision';
                action("Vendor Card")
                {
                    Caption = 'Vendor Card';
                    ToolTip = 'Executes the Vendor Card action.';
                    Image = Vendor;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #42. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.FORM.*/
                        Rec.ShowVendor();

                    end;
                }
                action("Item Vendors")
                {
                    Caption = 'Item Vendors';
                    ToolTip = 'Executes the Item Vendors action.';
                    Image = Vendor;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #42. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.FORM.*/
                        Rec.ShowItemVendor();

                    end;
                }
            }
        }
        addafter("Co&mments")
        {
            action("Purchase Order Lines")
            {
                Caption = 'Purchase Order Lines';
                ToolTip = 'Executes the Purchase Order Lines action.';
                Image = Line;

                trigger OnAction();
                begin
                    //This functionality was copied from page #42. Unsupported part was commented. Please check it.
                    /*CurrPage.SalesLines.FORM.*/
                    this._ShowPurchaseOrderLines();

                end;
            }
            action("Req. Worksheet Lines")
            {
                Caption = 'Req. Worksheet Lines';
                ToolTip = 'Executes the Req. Worksheet Lines action.';
                Image = Line;

                trigger OnAction();
                begin
                    //This functionality was copied from page #42. Unsupported part was commented. Please check it.
                    /*CurrPage.SalesLines.FORM.*/
                    this.ShowReqWorksheetLines();

                end;
            }
        }
        addafter(OrderPromising)
        {
            action("&Special Fields")
            {
                Caption = '&Special Fields';
                ToolTip = 'Executes the &Special Fields action.';
                Image = Filed;

                trigger OnAction();
                begin
                    //This functionality was copied from page #42. Unsupported part was commented. Please check it.
                    /*CurrPage.SalesLines.FORM.*/
                    this._ShowSpecialFields();

                end;
            }
        }
        addafter("Select Nonstoc&k Items")
        {
            action("Calculate &Invoice Discount")
            {
                Caption = 'Calculate &Invoice Discount';
                Image = CalculateInvoiceDiscount;
                ToolTip = 'Executes the Calculate &Invoice Discount action.';

                trigger OnAction();
                begin
                    //This functionality was copied from page #42. Unsupported part was commented. Please check it.
                    /*CurrPage.SalesLines.FORM.*/
                    this.ApproveCalcInvDisc();

                end;
            }
        }
    }

    var
        LocationItem: Record Item;
        LineItem: Record 27;
        NVM: Codeunit 50021;
        LDec: array[20] of Decimal;
        LDate: array[10] of Date;

    //Unsupported feature: CodeModification on "TypeOnAfterValidate(PROCEDURE 19069045)". Please convert manually.

    //procedure TypeOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ItemPanelVisible := Type = Type::Item;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ItemPanelVisible := Type = Type::Item;
    //>> NIF #10088 RTT 06-07-05
    HandleCommentLines;
    //<< NIF #10088 RTT 06-07-05
    */
    //end;


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
    #5..13
      AutoReserve(TRUE);
      CurrPage.UPDATE(FALSE);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    InsertExtendedText(FALSE);
    //>> NIF #10088 RTT 06-07-05
    HandleCommentLines;
    //>> NIF #10088 RTT 06-07-05

    #2..16
    */
    //end;

    procedure _ShowPurchaseOrderLines();
    begin
        Rec.ShowPurchaseOrderLines();
    end;

    procedure ShowPurchaseOrderLines();
    begin
        Rec.ShowPurchaseOrderLines();
    end;

    procedure ShowReqWorksheetLines();
    begin
        Rec.ShowRequisitionLines();
    end;

    procedure _ShowSpecialFields();
    begin
        Rec.ShowSpecialFields();
    end;

    procedure ShowSpecialFields();
    begin
        Rec.ShowSpecialFields();
    end;

    procedure HandleCommentLines();
    begin
        IF ((Rec."No." <> xRec."No.") OR (Rec."Line No." = 0)) AND
              ((Rec.Type = Rec.Type::Item) OR (xRec.Type = Rec.Type::Item)) THEN BEGIN
            IF Rec.CheckIfLineComments() THEN
                CurrPage.SAVERECORD();
            Rec.DeleteLineComments();
            Rec.InsertLineComments();
        END;
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

