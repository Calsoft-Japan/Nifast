page 50043 "Purch. Order Receipt Subform"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade
    // //NIFAST
    //   MAK 20051213  Added code in "Bin Code" OnActivate to check the Item card to ensure
    //                   that Net Weight had been entered.

    AutoSplitKey = true;
    Caption = 'Purch. Order Receipt Subform';
    DelayedInsert = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "Purchase Line";
    SourceTableView = WHERE("Document Type" = FILTER(Order),
                            "Outstanding Quantity" = FILTER(<> 0));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Type; Rec.Type)
                {
                    Editable = false;
                    ToolTip = 'Specifies the line type.';
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';

                    trigger OnValidate()
                    begin
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate();
                    end;
                }
                field("Cross-Reference No."; Rec."Item Reference No.")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the referenced item number.';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        // Item Cross Ref - start
                        IF Rec.Type = Rec.Type::Item THEN BEGIN
                            SalesHeader.GET(Rec."Document Type", Rec."Document No.");
                            ItemCrossReference.RESET();
                            ItemCrossReference.SETCURRENTKEY("Reference Type", "Reference Type No.");
                            ItemCrossReference.SETRANGE("Reference Type", ItemCrossReference."Reference Type"::Customer);
                            ItemCrossReference.SETRANGE(ItemCrossReference."Reference Type No.", SalesHeader."Sell-to Customer No.");
                            IF PAGE.RUNMODAL(PAGE::"Item Reference List", ItemCrossReference) = ACTION::LookupOK THEN BEGIN
                                Rec.VALIDATE("Item Reference No.", ItemCrossReference."Reference No.");
                                InsertExtendedText(FALSE);
                            END;
                        END;
                        // Item Cross Ref - end
                    end;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    Editable = "Variant CodeEditable";
                    Visible = false;
                    ToolTip = 'Specifies the variant of the item on the line.';
                }
                field("Purchasing Code"; Rec."Purchasing Code")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Purchasing Code field.';
                }
                field(Nonstock; Rec.Nonstock)
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies that this item is a catalog item.';
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ToolTip = 'Specifies a description of the blanket purchase order.';
                }
                field(Manufacturer; Rec.Manufacturer)
                {
                    ToolTip = 'Specifies the value of the Manufacturer field.';
                }
                field("Country of Origin Code"; Rec."Country of Origin Code")
                {
                    ToolTip = 'Specifies the value of the Country of Origin Code field.';
                }
                field("Drop Shipment"; Rec."Drop Shipment")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies if your vendor ships the items directly to your customer.';
                }
                field("Special Order"; Rec."Special Order")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Special Order field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the code for the location where the items on the line will be located.';
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ToolTip = 'Specifies the bin where the items are picked or put away.';
                }
                field(Quantity; Rec.Quantity)
                {
                    BlankZero = true;
                    Editable = false;
                    ToolTip = 'Specifies the quantity of the purchase order line.';
                }
                field("Reserved Quantity"; Rec."Reserved Quantity")
                {
                    BlankZero = true;
                    Editable = false;
                    ToolTip = 'Specifies how many item units on this line have been reserved.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the name of the item or resource''s unit of measure, such as piece or hour.';
                }
                field("Qty. to Receive"; Rec."Qty. to Receive")
                {
                    BlankZero = true;
                    Editable = "Qty. to ReceiveEditable";
                    ToolTip = 'Specifies the quantity of items that remains to be received.';

                    trigger OnValidate()
                    begin
                        QtytoReceiveOnAfterValidate();
                    end;
                }
                field(CartonsToReceive; CartonsToReceive)
                {
                    BlankZero = true;
                    Caption = 'Cartons To Receive';
                    DecimalPlaces = 0 : 2;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Cartons To Receive field.';
                }
                field("Units per Parcel"; Rec."Units per Parcel")
                {
                    Editable = false;
                    ToolTip = 'Specifies the number of units per parcel of the item. In the purchase statistics window, the number of units per parcel on the line helps to determine the total number of units for all the lines for the particular purchase document.';
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                    BlankZero = true;
                    ToolTip = 'Specifies how many units of the item on the line have been posted as received.';
                }
                field("Allow Item Charge Assignment"; Rec."Allow Item Charge Assignment")
                {
                    Editable = AllowItemChargeAssignmentEdita;
                    Visible = false;
                    ToolTip = 'Specifies that you can assign item charges to this line.';
                }
                field("Qty. to Assign"; Rec."Qty. to Assign")
                {
                    Visible = false;
                    ToolTip = 'Specifies how many units of the item charge will be assigned to the line.';
                }
                field("Qty. Assigned"; Rec."Qty. Assigned")
                {
                    Visible = false;
                    ToolTip = 'Specifies how much of the item charge that has been assigned.';
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the date that you want the vendor to deliver to the ship-to address. The value in the field is used to calculate the latest date you can order the items to have them delivered on the requested receipt date. If you do not need delivery on a specific date, you can leave the field blank.';
                }
                field("Promised Receipt Date"; Rec."Promised Receipt Date")
                {
                    Editable = "Promised Receipt DateEditable";
                    Visible = false;
                    ToolTip = 'Specifies the date that the vendor has promised to deliver the order.';
                }
                field("Planned Receipt Date"; Rec."Planned Receipt Date")
                {
                    Editable = "Planned Receipt DateEditable";
                    ToolTip = 'Specifies the date when the item is planned to arrive in inventory. Forward calculation: planned receipt date = order date + vendor lead time (per the vendor calendar and rounded to the next working day in first the vendor calendar and then the location calendar). If no vendor calendar exists, then: planned receipt date = order date + vendor lead time (per the location calendar). Backward calculation: order date = planned receipt date - vendor lead time (per the vendor calendar and rounded to the previous working day in first the vendor calendar and then the location calendar). If no vendor calendar exists, then: order date = planned receipt date - vendor lead time (per the location calendar).';
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    Editable = "Expected Receipt DateEditable";
                    ToolTip = 'Specifies the date you expect the items to be available in your warehouse.';
                }
                field("Whse. Outstanding Qty. (Base)"; Rec."Whse. Outstanding Qty. (Base)")
                {
                    Visible = false;
                    ToolTip = 'Specifies how many units on the purchase order line remain to be handled in warehouse documents.';
                }
                field("FA Posting Date"; Rec."FA Posting Date")
                {
                    Editable = "FA Posting DateEditable";
                    Visible = false;
                    ToolTip = 'Specifies the FA posting date if you have selected Fixed Asset in the Type field for this line.';
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    Editable = "Appl.-to Item EntryEditable";
                    Visible = false;
                    ToolTip = 'Specifies the number of the item ledger entry that the document or journal line is applied -to.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'Executes the Dimensions action.';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50044. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.PAGE.*/
                        _ShowDimensions();

                    end;
                }
                action("Item Charge &Assignment")
                {
                    Caption = 'Item Charge &Assignment';
                    Ellipsis = true;
                    Image = Item;
                    ToolTip = 'Executes the Item Charge &Assignment action.';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50044. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.PAGE.*/
                        ItemChargeAssgnt();

                    end;
                }
                action("Item &Tracking Lines")
                {
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ToolTip = 'Executes the Item &Tracking Lines action.';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50044. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.PAGE.*/
                        _OpenItemTrackingLines();

                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                group("Drop Shipments")
                {
                    Caption = 'Drop Shipment';
                    action("Sales &Orders")
                    {
                        Caption = 'Sales &Order';
                        Image = Document;
                        ToolTip = 'Executes the Sales &Order action.';

                        trigger OnAction()
                        begin
                            //This functionality was copied from page #50044. Unsupported part was commented. Please check it.
                            /*CurrPage.PurchLines.PAGE.*/
                            OpenPurchOrderForm();

                        end;
                    }
                }
                group("Special Orders")
                {
                    Caption = 'Special Order';
                    action("Sales &Order")
                    {
                        Caption = 'Sales &Order';
                        Image = Document;
                        ToolTip = 'Executes the Sales &Order action.';

                        trigger OnAction()
                        begin
                            //This functionality was copied from page #50044. Unsupported part was commented. Please check it.
                            /*CurrPage.PurchLines.PAGE.*/
                            OpenPurchOrderForm();

                        end;
                    }
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);

        //>>NIF MAK 050606
        IF Rec."Units per Parcel" <> 0 THEN
            CartonsToReceive := Rec."Qty. to Receive" / Rec."Units per Parcel"
        ELSE
            CartonsToReceive := 0;
        //<<NIF MAK 050606
    end;

    trigger OnInit()
    begin
        "Appl.-to Item EntryEditable" := TRUE;
        "FA Posting DateEditable" := TRUE;
        "Expected Receipt DateEditable" := TRUE;
        "Planned Receipt DateEditable" := TRUE;
        "Promised Receipt DateEditable" := TRUE;
        AllowItemChargeAssignmentEdita := TRUE;
        "Qty. to ReceiveEditable" := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := xRec.Type;
        CLEAR(ShortcutDimCode);
    end;

    var
        ItemCrossReference: Record "Item Reference";
        SalesHeader: Record "Sales Header";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        [InDataSet]
        AllowItemChargeAssignmentEdita: Boolean;
        [InDataSet]
        "Appl.-to Item EntryEditable": Boolean;
        [InDataSet]
        "Expected Receipt DateEditable": Boolean;
        [InDataSet]
        "FA Posting DateEditable": Boolean;
        [InDataSet]
        "Planned Receipt DateEditable": Boolean;
        [InDataSet]
        "Promised Receipt DateEditable": Boolean;
        [InDataSet]
        "Qty. to ReceiveEditable": Boolean;
        [InDataSet]
        "Variant CodeEditable": Boolean;
        ShortcutDimCode: array[8] of Code[20];
        CartonsToReceive: Decimal;

    procedure ApproveCalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Disc. (Yes/No)", Rec);
    end;

    procedure CalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Calc.Discount", Rec);
    end;

    procedure ExplodeBOM()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Explode BOM", Rec);
    end;

    procedure OpenPurchOrderForm()
    var
        SalesHeaderLRec: Record "Sales Header";
        SalesOrder: Page "Sales Order";
    begin
        SalesHeaderLRec.SETRANGE("No.", Rec."Sales Order No.");
        SalesOrder.SETTABLEVIEW(SalesHeaderLRec);
        SalesOrder.EDITABLE := FALSE;
        SalesOrder.RUN();
    end;

    procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        IF TransferExtendedText.PurchCheckIfAnyExtText(Rec, Unconditionally) THEN BEGIN
            CurrPage.SAVERECORD();
            TransferExtendedText.InsertPurchExtText(Rec);
        END;
        IF TransferExtendedText.MakeUpdate() THEN
            UpdateForm(TRUE);
    end;

    procedure ShowReservation()
    begin
        Rec.FIND();
        Rec.ShowReservation();
    end;

    procedure ShowReservationEntries()
    begin
        Rec.ShowReservationEntries(TRUE);
    end;

    procedure _ShowDimensions()
    begin
        Rec.ShowDimensions();
    end;

    procedure ShowDimensions()
    begin
        Rec.ShowDimensions();
    end;

    procedure _OpenItemTrackingLines()
    begin
        Rec.OpenItemTrackingLines();
    end;

    procedure OpenItemTrackingLines()
    begin
        Rec.OpenItemTrackingLines();
    end;

    procedure ShowTracking()
    var
        TrackingForm: Page "Order Tracking";
    begin
        TrackingForm.SetPurchLine(Rec);
        TrackingForm.RUNMODAL();
    end;

    procedure ItemChargeAssgnt()
    begin
        Rec.ShowItemChargeAssgnt();
    end;

    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;

    procedure OrderOnHold(OnHold: Boolean)
    begin
        "Variant CodeEditable" := NOT OnHold;
        "Qty. to ReceiveEditable" := NOT OnHold;
        AllowItemChargeAssignmentEdita := NOT OnHold;
        "Promised Receipt DateEditable" := NOT OnHold;
        "Planned Receipt DateEditable" := NOT OnHold;
        "Planned Receipt DateEditable" := NOT OnHold;
        "Expected Receipt DateEditable" := NOT OnHold;
        "FA Posting DateEditable" := NOT OnHold;
        "Appl.-to Item EntryEditable" := NOT OnHold;
    end;

    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(FALSE);
        IF (Rec.Type = Rec.Type::"Charge (Item)") AND (Rec."No." <> xRec."No.") AND
           (xRec."No." <> '')
        THEN
            CurrPage.SAVERECORD();
    end;

    local procedure QtytoReceiveOnAfterValidate()
    begin
        //>>NIF MAK 050606
        IF Rec."Units per Parcel" <> 0 THEN
            CartonsToReceive := Rec."Qty. to Receive" / Rec."Units per Parcel"
        ELSE
            CartonsToReceive := 0;
        //<<NIF MAK 050606
    end;

    /*  local procedure BinCodeOnActivate()
     var
         ItemChkWt: Record Item;
     begin
         //>>NIF MAK 20051213
         IF Rec.Type = Rec.Type::Item THEN
             IF ItemChkWt.GET(Rec."No.") THEN
                 IF ItemChkWt."Net Weight" = 0 THEN
                     MESSAGE('Item %1 does not have a net weight!', FORMAT(Rec."No."));
         //<<NIF MAK 20051213
     end; */
}

