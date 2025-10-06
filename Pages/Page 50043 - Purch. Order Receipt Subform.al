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
    SourceTable = Table39;
    SourceTableView = WHERE(Document Type=FILTER(Order),
                            Outstanding Quantity=FILTER(<>0));

    layout
    {
        area(content)
        {
            repeater()
            {
                field(Type;Type)
                {
                    Editable = false;
                }
                field("No.";"No.")
                {
                    Editable = false;

                    trigger OnValidate()
                    begin
                        ShowShortcutDimCode(ShortcutDimCode);
                          NoOnAfterValidate;
                    end;
                }
                field("Cross-Reference No.";"Cross-Reference No.")
                {
                    Editable = false;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        // Item Cross Ref - start
                        IF Type = Type::Item THEN BEGIN
                          SalesHeader.GET("Document Type","Document No.");
                          ItemCrossReference.RESET;
                          ItemCrossReference.SETCURRENTKEY("Cross-Reference Type","Cross-Reference Type No.");
                          ItemCrossReference.SETRANGE("Cross-Reference Type",ItemCrossReference."Cross-Reference Type"::Customer);
                          ItemCrossReference.SETRANGE(ItemCrossReference."Cross-Reference Type No.",SalesHeader."Sell-to Customer No.");
                          IF PAGE.RUNMODAL(PAGE::"Cross Reference List",ItemCrossReference) = ACTION::LookupOK THEN BEGIN
                            VALIDATE("Cross-Reference No.",ItemCrossReference."Cross-Reference No.");
                            InsertExtendedText(FALSE);
                          END;
                        END;
                        // Item Cross Ref - end
                    end;
                }
                field("Variant Code";"Variant Code")
                {
                    Editable = "Variant CodeEditable";
                    Visible = false;
                }
                field("Purchasing Code";"Purchasing Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Nonstock;Nonstock)
                {
                    Editable = false;
                    Visible = false;
                }
                field(Description;Description)
                {
                    Editable = false;
                }
                field(Manufacturer;Manufacturer)
                {
                }
                field("Country of Origin Code";"Country of Origin Code")
                {
                }
                field("Drop Shipment";"Drop Shipment")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Special Order";"Special Order")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Location Code";"Location Code")
                {
                    Editable = false;
                }
                field("Bin Code";"Bin Code")
                {
                }
                field(Quantity;Quantity)
                {
                    BlankZero = true;
                    Editable = false;
                }
                field("Reserved Quantity";"Reserved Quantity")
                {
                    BlankZero = true;
                    Editable = false;
                }
                field("Unit of Measure Code";"Unit of Measure Code")
                {
                    Editable = false;
                }
                field("Unit of Measure";"Unit of Measure")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Qty. to Receive";"Qty. to Receive")
                {
                    BlankZero = true;
                    Editable = "Qty. to ReceiveEditable";

                    trigger OnValidate()
                    begin
                        QtytoReceiveOnAfterValidate;
                    end;
                }
                field(CartonsToReceive;CartonsToReceive)
                {
                    BlankZero = true;
                    Caption = 'Cartons To Receive';
                    DecimalPlaces = 0:2;
                    Editable = false;
                }
                field("Units per Parcel";"Units per Parcel")
                {
                    Editable = false;
                }
                field("Quantity Received";"Quantity Received")
                {
                    BlankZero = true;
                }
                field("Allow Item Charge Assignment";"Allow Item Charge Assignment")
                {
                    Editable = AllowItemChargeAssignmentEdita;
                    Visible = false;
                }
                field("Qty. to Assign";"Qty. to Assign")
                {
                    Visible = false;
                }
                field("Qty. Assigned";"Qty. Assigned")
                {
                    Visible = false;
                }
                field("Requested Receipt Date";"Requested Receipt Date")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Promised Receipt Date";"Promised Receipt Date")
                {
                    Editable = "Promised Receipt DateEditable";
                    Visible = false;
                }
                field("Planned Receipt Date";"Planned Receipt Date")
                {
                    Editable = "Planned Receipt DateEditable";
                }
                field("Expected Receipt Date";"Expected Receipt Date")
                {
                    Editable = "Expected Receipt DateEditable";
                }
                field("Whse. Outstanding Qty. (Base)";"Whse. Outstanding Qty. (Base)")
                {
                    Visible = false;
                }
                field("FA Posting Date";"FA Posting Date")
                {
                    Editable = "FA Posting DateEditable";
                    Visible = false;
                }
                field("Appl.-to Item Entry";"Appl.-to Item Entry")
                {
                    Editable = "Appl.-to Item EntryEditable";
                    Visible = false;
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

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50044. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.PAGE.*/
                        _ShowDimensions;

                    end;
                }
                action("Item Charge &Assignment")
                {
                    Caption = 'Item Charge &Assignment';
                    Ellipsis = true;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50044. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.PAGE.*/
                        ItemChargeAssgnt;

                    end;
                }
                action("Item &Tracking Lines")
                {
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50044. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.PAGE.*/
                        _OpenItemTrackingLines;

                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                group("Drop Shipment")
                {
                    Caption = 'Drop Shipment';
                    action("Sales &Order")
                    {
                        Caption = 'Sales &Order';
                        Image = Document;

                        trigger OnAction()
                        begin
                            //This functionality was copied from page #50044. Unsupported part was commented. Please check it.
                            /*CurrPage.PurchLines.PAGE.*/
                            OpenPurchOrderForm;

                        end;
                    }
                }
                group("Special Order")
                {
                    Caption = 'Special Order';
                    action("Sales &Order")
                    {
                        Caption = 'Sales &Order';
                        Image = Document;

                        trigger OnAction()
                        begin
                            //This functionality was copied from page #50044. Unsupported part was commented. Please check it.
                            /*CurrPage.PurchLines.PAGE.*/
                            OpenPurchOrderForm;

                        end;
                    }
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        ShowShortcutDimCode(ShortcutDimCode);

        //>>NIF MAK 050606
        IF "Units per Parcel" <> 0 THEN
         CartonsToReceive := "Qty. to Receive" / "Units per Parcel"
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
        Type := xRec.Type;
        CLEAR(ShortcutDimCode);
    end;

    var
        SalesHeader: Record "36";
        ItemCrossReference: Record "5717";
        TransferExtendedText: Codeunit "378";
        ShortcutDimCode: array [8] of Code[20];
        NIF: Integer;
        CartonsToReceive: Decimal;
        [InDataSet]
        "Variant CodeEditable": Boolean;
        [InDataSet]
        "Qty. to ReceiveEditable": Boolean;
        [InDataSet]
        AllowItemChargeAssignmentEdita: Boolean;
        [InDataSet]
        "Promised Receipt DateEditable": Boolean;
        [InDataSet]
        "Planned Receipt DateEditable": Boolean;
        [InDataSet]
        "Expected Receipt DateEditable": Boolean;
        [InDataSet]
        "FA Posting DateEditable": Boolean;
        [InDataSet]
        "Appl.-to Item EntryEditable": Boolean;

    procedure ApproveCalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Disc. (Yes/No)",Rec);
    end;

    procedure CalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Calc.Discount",Rec);
    end;

    procedure ExplodeBOM()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Explode BOM",Rec);
    end;

    procedure OpenPurchOrderForm()
    var
        SalesHeader: Record "36";
        SalesOrder: Page "42";
    begin
        SalesHeader.SETRANGE("No.","Sales Order No.");
        SalesOrder.SETTABLEVIEW(SalesHeader);
        SalesOrder.EDITABLE := FALSE;
        SalesOrder.RUN;
    end;

    procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        IF TransferExtendedText.PurchCheckIfAnyExtText(Rec,Unconditionally) THEN BEGIN
          CurrPage.SAVERECORD;
          TransferExtendedText.InsertPurchExtText(Rec);
        END;
        IF TransferExtendedText.MakeUpdate THEN
          UpdateForm(TRUE);
    end;

    procedure ShowReservation()
    begin
        FIND;
        Rec.ShowReservation;
    end;

    procedure ShowReservationEntries()
    begin
        Rec.ShowReservationEntries(TRUE);
    end;

    procedure _ShowDimensions()
    begin
        Rec.ShowDimensions;
    end;

    procedure ShowDimensions()
    begin
        Rec.ShowDimensions;
    end;

    procedure _OpenItemTrackingLines()
    begin
        Rec.OpenItemTrackingLines;
    end;

    procedure OpenItemTrackingLines()
    begin
        Rec.OpenItemTrackingLines;
    end;

    procedure ShowTracking()
    var
        TrackingForm: Page "99000822";
    begin
        TrackingForm.SetPurchLine(Rec);
        TrackingForm.RUNMODAL;
    end;

    procedure ItemChargeAssgnt()
    begin
        Rec.ShowItemChargeAssgnt;
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
        IF (Type = Type::"Charge (Item)") AND ("No." <> xRec."No.") AND
           (xRec."No." <> '')
        THEN
          CurrPage.SAVERECORD;
    end;

    local procedure QtytoReceiveOnAfterValidate()
    begin
        //>>NIF MAK 050606
        IF "Units per Parcel"<>0 THEN
           CartonsToReceive := "Qty. to Receive" / "Units per Parcel"
        ELSE
           CartonsToReceive := 0;
        //<<NIF MAK 050606
    end;

    local procedure BinCodeOnActivate()
    var
        ItemChkWt: Record "27";
    begin
        //>>NIF MAK 20051213
        IF Type = Type::Item THEN
          IF ItemChkWt.GET("No.") THEN
            IF ItemChkWt."Net Weight" = 0 THEN
              MESSAGE('Item %1 does not have a net weight!', FORMAT("No."));
        //<<NIF MAK 20051213
    end;
}

