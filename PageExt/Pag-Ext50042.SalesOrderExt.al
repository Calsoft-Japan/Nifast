pageextension 50042 "Sale Order Ext" extends "Sales Order"
{
    layout
    {
        modify("Due Date")
        {
            Editable = false;
        }
        modify("Payment Terms Code")
        {
            Editable = false;
        }
    }
    actions
    {
        addafter(Dimensions)
        {
            action("Create Purchase Order")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Create Purchase Order';
                ToolTip = 'Specifies the the creation of purchase order';
                Image = Purchase;
                trigger OnAction()
                var
                    PurchLines: Record 39;
                BEGIN
                    IF NVM.DropShipPOfromSO(Rec) THEN BEGIN
                        PurchLines.SETRANGE("Sales Order No.", Rec."No.");
                        PAGE.RUN(0, PurchLines);
                    END;
                END;


            }

        }
        addafter("Co&mments")
        {
            action("E-&Mail List")
            {
                CaptionML = ENU = 'E-&Mail List';
                Promoted = true;
                Image = Email;
                ToolTip = 'Email List';
                ApplicationArea = All;
                trigger OnAction()
                var

                    EMailListEntry: Record 14000908;
                BEGIN
                    EMailListEntry.RESET;
                    EMailListEntry.SETRANGE("Table ID", DATABASE::"Sales Header");
                    EMailListEntry.SETRANGE(Type, Rec."Document Type");
                    EMailListEntry.SETRANGE(Code, Rec."No.");
                    PAGE.RUNMODAL(PAGE::"lax E-Mail List Entries", EMailListEntry);
                END;
            }
            group("E-ship")
            {
                action("Bill of Ladings")
                {
                    RunObject = Page 14000828;

                    RunPageLink = "Source Type" = CONST(36),
                                  "Source Subtype" = FIELD("Document Type"),
                                  "Source ID" = FIELD("No."),
                                  Type = CONST(Order),
                                  "No." = FIELD("No.");
                    Image = Document;
                    ApplicationArea = All;

                }
                action("P&ackages")
                {
                    ApplicationArea = All;
                    Caption = 'Packages';
                    ToolTip = '';
                    Image = Table;
                    RunObject = Page 14000711;

                    RunPageView = sorting("Source Type", "Source Subtype", "Source ID") ORDER(Ascending);
                    RunPageLink = "Source Type" = CONST(36), "Source Subtype" = FIELD("Document Type"),
                                    "Source ID" = FIELD("No.");
                }
                action("E-Ship Agent Options")
                {

                    CaptionML = ENU = 'E-Ship Agent Options';
                    ApplicationArea = All;

                    trigger OnAction()
                    VAR
                        PackingControl: Record 14000717;
                        Shipping: Codeunit 14000701;
                    BEGIN
                        PackingControl.TransferFromSalesHeader(Rec);
                        Shipping.ShowOptPageShipDocument(PackingControl);
                    END;
                }

            }
            group("EDI")
            {
                action("1400369")
                {

                    CaptionML = ENU = 'Associated Receive Documents';
                    ToolTip = '';
                    ApplicationArea = All;
                    trigger OnAction()
                    VAR
                        EDIDocumentStatus: Codeunit 14000379;
                    BEGIN
                        CLEAR(EDIDocumentStatus);
                        EDIDocumentStatus.AssocChangeDocument(Rec);
                    END;
                }
                action("EDI Receive Elements")
                {
                    CaptionML = ENU = '&EDI Receive Elements';
                    ToolTip = 'Receive';
                    ApplicationArea = All;
                    trigger OnAction()
                    BEGIN
                        Rec.TESTFIELD("lax EDI Order");

                        EDIIntegration.ViewRecElements(rec."LAX EDI Internal Doc. No.");
                    END;
                }
                action("Send &EDI Warehouse Shipping Order")
                {
                    CaptionML = ENU = 'Send &EDI Warehouse Shipping Order';
                    ToolTip = '';
                    ApplicationArea = All;
                    trigger OnAction()
                    VAR
                        EDIIntegration: Codeunit 14000363;
                    BEGIN

                        Rec.TESTFIELD("LAX EDI Order");
                        rec.TESTFIELD("LAX EDI Released");
                        rec.TESTFIELD("Location Code");

                        EDIIntegration.SendWarehouseShippingOrder(Rec);
                    END;
                }
                action(Trace)
                {
                    CaptionML = ENU = 'Trace';
                    Image = Trace;
                    ApplicationArea = All;
                    Trigger OnAction()
                    VAR
                        EDITrace: Page 14002386;
                    BEGIN
                        CLEAR(EDITrace);
                        EDITrace.SetDoc(rec."lax EDI Internal Doc. No.");
                        EDITrace.RUNMODAL;
                    END;
                }
            }

        }
        modify(Release)
        {
            trigger OnBeforeAction()
            begin
                //>> NIF #10045 RTT 05-19-05
                SetCalledFromSalesOrder;
                //<< NIF #10045 RTT 05-19-05
            end;
        }
        addafter(Reopen)
        {
            action("std.ord")
            {
                Ellipsis = true;
                CaptionML = ENU = '&Std. Ord.';
                ToolTipML = ENU = 'ALT-F3   -   Get Standard Sales Lines For This Customer';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                VAR
                    StdCustSalesCode: Record 172;
                BEGIN
                    //>>NIF MAK 071105
                    StdCustSalesCode.InsertSalesLines(Rec);
                END;
            }
            action("Lot Entry")
            {
                Ellipsis = false;
                CaptionML = ENU = '&Lot Entry';
                Promoted = true;
                PromotedCategory = Process;
                Image = Entry;
                ApplicationArea = All;
                trigger OnAction()
                VAR
                    SalesLotEntry: Record 50002;
                BEGIN
                    SalesLotEntry.GetSalesLines(rec."Document Type".AsInteger(), rec."No.");
                    COMMIT();
                    SalesLotEntry.SETRANGE("Document Type", rec."Document Type");
                    SalesLotEntry.SETRANGE("Document No.", rec."No.");
                    IF PAGE.RUNMODAL(0, SalesLotEntry) = ACTION::LookupOK THEN
                        SalesLotEntry.AssignLots(rec."Document Type".AsInteger(), rec."No.");
                END;
            }
            action("Create Pick")
            {
                CaptionML = ENU = '&Create Pick';
                Promoted = true;
                Image = CreateInventoryPickup;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                BEGIN
                    Rec.CreateInvtPutAwayPick();
                END;

            }

        }
        addafter(CalculateInvoiceDiscount)
        {
            action("Lot ENtry1")
            {
                CaptionML = ENU = '&Lot Entry';
                ApplicationArea = All;
                trigger OnAction()
                VAR
                    SalesLotEntry: Record 50002;
                BEGIN
                    SalesLotEntry.GetSalesLines(rec."Document Type".AsInteger(), Rec."No.");
                    COMMIT();
                    SalesLotEntry.SETRANGE("Document Type", Rec."Document Type");
                    SalesLotEntry.SETRANGE("Document No.", rec."No.");
                    IF PAGE.RUNMODAL(0, SalesLotEntry) = ACTION::LookupOK THEN
                        SalesLotEntry.AssignLots(rec."Document Type".AsInteger(), rec."No.");
                END;
            }

        }
        addafter("Send IC Sales Order")
        {
            action("Email Confirmation")
            {
                CaptionML = ENU = 'E-&Mail Confirmation';
                ToolTip = '';
                Image = Email;
                ApplicationArea = All;
                trigger OnAction()
                VAR
                    EMailMgt: Codeunit 14000903;
                BEGIN
                    Rec.TESTFIELD("LAX E-Mail Confirm. Handled", FALSE);

                    EMailMgt.SendSalesConfirmation(Rec, TRUE, FALSE);
                END;
            }
        }
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                //-AKK1606.01--
                wNoCte := Rec."Bill-to Customer No.";
                wTipoDoc := REc."Document Type";
                wNoSerie := Rec."Posting No. Series";
                wNo := Rec."No.";
                fValida();
                //+AKK1606.01++

            end;
        }
        modify("Work Order")
        {

            trigger OnBeforeAction()
            begin
                //-AKK1606.01--
                wNoCte := rec."Bill-to Customer No.";
                wTipoDoc := rec."Document Type";
                wNoSerie := rec."Posting No. Series";
                wNo := rec."No.";
                fValida();
                //+AKK1606.01++

            end;
        }


    }
    trigger OnAfterGetRecord()
    var
        SalesLineTotal: Record 37;
    begin
        //>> NF1.00:CIS.NG  12/14/16
        Clear(OrderAmount_gDec);
        Clear(OrderWeight_gDec);
        SalesLineTotal.RESET();
        SalesLineTotal.SETRANGE("Document Type", Rec."Document Type");
        SalesLineTotal.SETRANGE("Document No.", rec."No.");
        SalesLineTotal.CALCSUMS("Line Amount", "Line Gross Weight", "Line Cost",
                                "Line Amount to Ship", "Line Amount to Invoice");
        OrderAmount_gDec := SalesLineTotal."Line Amount";
        OrderWeight_gDec := SalesLineTotal."Line Gross Weight";
        //<< NF1.00:CIS.NG  12/14/16
    end;

    // PROCEDURE CreateProdKit();
    // VAR
    //     SalesLine2: Record 37;
    //     Item: Record 27;
    // BEGIN
    //     //>> NF1.00:CIS.CM 09-29-15
    //     //SalesLine2.SETRANGE("Document Type","Document Type");
    //     //SalesLine2.SETRANGE("Document No.","No.");
    //     //SalesLine2.SETRANGE(Type,SalesLine2.Type::Item);
    //     //SalesLine2.SETFILTER("No.",'<>%1','');
    //     //SalesLine2.SETRANGE("BOM Item",TRUE);
    //     //SalesLine2.SETFILTER(Quantity,'<>%1',0);
    //     //IF SalesLine2.FIND('-') THEN
    //     //  REPEAT
    //     //    IF (Item.GET(SalesLine2."No.")) AND (Item."Costing Method"=Item."Costing Method"::Specific) THEN
    //     //      MESSAGE('Production Kit NOT created for Item %1 due to Costing Method Specific',Item."No.")
    //     //    ELSE
    //     //      ProdManagement.CreateProdKits(SalesLine2);
    //     //  UNTIL SalesLine2.NEXT=0;
    //     //<< NF1.00:CIS.CM 09-29-15
    // END;

    PROCEDURE fValida();
    VAR
        rSalesLine: Record 37;
        rSalesLine2: Record 37;
        //cItemCheckAvail: Codeunit 311;
        cItemCheckAvail: Codeunit CU311Subscriber;

    BEGIN
        //-AKK1606.01--
        rSalesLine.RESET();
        rSalesLine.SETRANGE("Document No.", wNo);
        rSalesLine.SETRANGE("Document Type", wTipoDoc);
        rSalesLine.SETFILTER(Type, '<>%1', rSalesLine.Type::" ");
        rSalesLine.SETFILTER("Qty. to Ship", '<>%1', 0);
        IF rSalesLine.FINDSET() THEN
            REPEAT
                rSalesLine2.GET(wTipoDoc, wNo, rSalesLine."Line No.");
                IF ((rSalesLine2."Drop Shipment") AND (rSalesLine2.National) AND (rSalesLine2.Type = rSalesLine2.Type::Item)) THEN BEGIN
                    rSalesLine2.TESTFIELD("Exit Point");
                    rSalesLine2.TESTFIELD("Entry/Exit No.");
                    rSalesLine2.TESTFIELD("Entry/Exit Date");
                END ELSE
                    IF (NOT (rSalesLine2."Drop Shipment") AND (rSalesLine2.National) AND (rSalesLine2.Type = rSalesLine2.Type::Item)) THEN
                        cItemCheckAvail.OrderSalesLineCheck(rSalesLine);
            UNTIL rSalesLine.NEXT() = 0;
        //+AKK1606.01++
    END;

    procedure SetCalledFromSalesOrder()
    begin
        CalledFromSalesOrder := TRUE
    end;


    var

        NVM: Codeunit 50021;
        EDIIntegration: Codeunit 14000363;
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        wNo: Code[20];
        CalledFromSalesOrder: Boolean;
        wNoCte: Code[20];
        wNoSerie: Code[20];
        OrderAmount_gDec: Decimal;
        OrderWeight_gDec: Decimal;
        wTipoDoc: Option Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order";

}
