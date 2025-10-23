page 50044 "Purchase Order Receipt"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade
    // NF1.00:CIS.NG  09-29-15 Disable the page action - "Pre-Receiving Report"
    // //NIF MAK GOLIVE    Changed properties of "Order Date" to make it match other controls
    //                     Commented out some code that determined whether Order Date was editable
    //       MAK 20051213  Added code in the "Functions / Lot Entry" menu option to check the lines
    //                       associated with the PO to make sure that the Net Weight was entered in the
    //                       item card.

    Caption = 'Purchase Order Receipt';
    DeleteAllowed = false;
    InsertAllowed = false;
    UsageCategory = None;
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = FILTER(Order));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE();
                    end;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the number of the vendor who delivers the products.';

                    trigger OnValidate()
                    begin
                        BuyfromVendorNoOnAfterValidate();
                    end;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the name of the vendor who delivers the products.';
                }
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the number of the vendor that you received the invoice from.';

                    trigger OnValidate()
                    begin
                        PaytoVendorNoOnAfterValidate();
                    end;
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    Editable = false;
                    ToolTip = 'Specifies if this vendor charges you sales tax for purchases.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = "Posting DateEditable";
                    ToolTip = 'Specifies the date when the posting of the purchase document will be recorded.';
                }
                field("Order Date"; Rec."Order Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the date when the order was created.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    Editable = "Document DateEditable";
                    ToolTip = 'Specifies the date when the related document was created.';
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the date that you want the vendor to deliver your order. The field is used to calculate the latest date you can order, as follows: requested receipt date - lead time calculation = order date. If you do not need delivery on a specific date, you can leave the field blank.';
                }
                field("Promised Receipt Date"; Rec."Promised Receipt Date")
                {
                    ToolTip = 'Specifies the date that the vendor has promised to deliver the order.';
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    Editable = "Purchaser CodeEditable";
                    ToolTip = 'Specifies which purchaser is assigned to the vendor.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV();
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';

                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV();
                    end;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies whether the record is open, waiting to be approved, invoiced for prepayment, or released to the next stage of processing.';
                }
                field("On Hold"; Rec."On Hold")
                {
                    Editable = false;
                    ToolTip = 'Specifies that the related entry represents an unpaid invoice for which either a payment suggestion, a reminder, or a finance charge memo exists.';
                }
            }
            part(PurchLines; "Purch. Order Receipt Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    Editable = "Ship-to CodeEditable";
                    ToolTip = 'Specifies a code for an alternate shipment address if you want to ship to another address than the one that has been entered automatically. This field is also used in case of drop shipment.';
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    Editable = "Ship-to NameEditable";
                    ToolTip = 'Specifies the name of the company at the address to which you want the items in the purchase order to be shipped.';
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    Editable = "Ship-to AddressEditable";
                    ToolTip = 'Specifies the address that you want the items in the purchase order to be shipped to.';
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    Editable = "Ship-to Address 2Editable";
                    ToolTip = 'Specifies additional address information.';
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    Editable = "Ship-to CityEditable";
                    ToolTip = 'Specifies the city the items in the purchase order will be shipped to.';
                }
                field("Ship-to County"; Rec."Ship-to County")
                {
                    Caption = 'Ship-to State / ZIP Code';
                    Editable = "Ship-to CountyEditable";
                    ToolTip = 'Specifies the state where the vendor sending the invoice is located.';
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    Editable = "Ship-to Post CodeEditable";
                    ToolTip = 'Specifies the postal code.';
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    Editable = "Ship-to ContactEditable";
                    ToolTip = 'Specifies the name of a contact person for the address where the items in the purchase order should be shipped.';
                }
                field("Ship-to UPS Zone"; Rec."Ship-to UPS Zone")
                {
                    Editable = "Ship-to UPS ZoneEditable";
                    ToolTip = 'Specifies a UPS Zone code for this document if UPS is used for shipments.';
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    Editable = "Tax Area CodeEditable";
                    ToolTip = 'Specifies the tax area code used for this purchase to calculate and post sales tax.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = "Location CodeEditable";
                    ToolTip = 'Specifies the location where the items are to be placed when they are received. This field acts as the default location for new lines. You can update the location code for individual lines as needed.';
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    Editable = "Shipment Method CodeEditable";
                    ToolTip = 'Specifies the delivery conditions of the related shipment, such as free on board (FOB).';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("O&rder")
            {
                Caption = 'O&rder';
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';
                    ToolTip = 'Executes the Statistics action.';

                    trigger OnAction()
                    begin
                        PurchSetup.GET();
                        IF PurchSetup."Calc. Inv. Discount" THEN BEGIN
                            CurrPage.PurchLines.PAGE.CalcInvDisc();
                            COMMIT()
                        END;
                        IF Rec."Tax Area Code" = '' THEN
                            PAGE.RUNMODAL(PAGE::"Purchase Order Statistics", Rec)
                        ELSE
                            PAGE.RUNMODAL(PAGE::"Purchase Order Stats.", Rec)
                    end;
                }
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'Executes the Card action.';
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No.");
                    ToolTip = 'Executes the Co&mments action.';
                }
                action("&Receipts")
                {
                    Caption = '&Receipts';
                    Image = PostedReceipts;
                    RunObject = Page 145;
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    ToolTip = 'Executes the &Receipts action.';
                }
                action(Invoices)
                {
                    Caption = 'Invoices';
                    Image = Invoice;
                    RunObject = Page 146;
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    ToolTip = 'Executes the Invoices action.';
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'Executes the Dimensions action.';

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim();
                        CurrPage.SAVERECORD();
                    end;
                }
            }
        }
        area(processing)
        {
            action("Trkng. Lines")
            {
                Caption = 'Trkng. Lines';
                Promoted = true;
                Image = Line;
                PromotedOnly = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Trkng. Lines action.';

                trigger OnAction()
                begin
                    //>>NIF MAK 071205
                    CurrPage.PurchLines.PAGE.OpenItemTrackingLines();
                    //<<NIF MAK 071205
                end;
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Lot Entry")
                {
                    Caption = 'Lot Entry';
                    Image = Lot;
                    ToolTip = 'Executes the Lot Entry action.';

                    trigger OnAction()
                    var
                        ItemChkWt: Record Item;
                        LotEntry: Record "Lot Entry";
                        PurchLinesChkWt: Record "Purchase Line";
                    begin
                        //>>NIF MAK 20051213
                        PurchLinesChkWt.SETRANGE("Document Type", Rec."Document Type");
                        PurchLinesChkWt.SETRANGE("Document No.", Rec."No.");
                        PurchLinesChkWt.SETRANGE(Type, PurchLinesChkWt.Type::Item);
                        IF PurchLinesChkWt.FIND('-') THEN
                            REPEAT
                                ItemChkWt.GET(PurchLinesChkWt."No.");
                                IF ItemChkWt."Net Weight" = 0 THEN
                                    MESSAGE('Item %1 does not have a net weight!', ItemChkWt."No.");
                            UNTIL PurchLinesChkWt.NEXT() = 0;
                        //<<NIF MAK 20051213


                        LotEntry.GetPurchLines(LotEntry."Document Type"::"Purchase Order", Rec."No.");
                        COMMIT();
                        LotEntry.SETRANGE("Document Type", LotEntry."Document Type"::"Purchase Order");
                        LotEntry.SETRANGE("Document No.", Rec."No.");
                        PAGE.RUNMODAL(0, LotEntry);
                        CLEAR(LotEntry);
                    end;
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    ToolTip = 'Executes the Re&open action.';

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.Reopen(Rec);
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                /*   action("Pre-Receiving Report")
                  {
                      Caption = 'Pre-Receiving Report';
                      Enabled = false;
                      Visible = false;
                      Image = Report;
                      ToolTip = 'Executes the Pre-Receiving Report action.';

                      trigger OnAction()
                      begin
                          //>> NF1.00:CIS.NG 09-29-15
                          //CurrPage.SETSELECTIONFILTER(PurchHeader);
                          //REPORT.RUN(REPORT::Report50070,TRUE,FALSE,PurchHeader);
                          //<< NF1.00:CIS.NG 09-29-15
                      end;
                  } */
                action("Test Report")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    ToolTip = 'Executes the Test Report action.';

                    trigger OnAction()
                    var
                        PurchHeader: Record "Purchase Header";
                        PurchTestReport: Report "Purchase Document - Test";
                    begin
                        //>> RTT 09-26-05
                        //ReportPrint.PrintPurchHeader(Rec);
                        PurchHeader := Rec;
                        PurchHeader.SETRECFILTER();
                        // PurchTestReport.SetCalledFromReceiving;//TODO
                        PurchTestReport.SETTABLEVIEW(PurchHeader);
                        PurchTestReport.RUN();
                        //<< RTT 09-26-05
                    end;
                }
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ToolTip = 'Executes the P&ost action.';

                    trigger OnAction()
                    var
                        PurchPostYN: Codeunit "Purch.-Post (Yes/No)";
                        PurchPostYN1: Codeunit CU_91;
                    begin
                        PurchPostYN1.SetReceiveOnly;
                        PurchPostYN.RUN(Rec);
                        IF Rec."Receiving No." = '-1' THEN
                            ERROR('');
                    end;
                }
                action("Post and &Print")
                {
                    Caption = 'Post and &Print';
                    Ellipsis = true;
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';
                    ToolTip = 'Executes the Post and &Print action.';

                    trigger OnAction()
                    var
                        PurchPostPrint: Codeunit "Purch.-Post + Print";
                        PurchPostPrint1: Codeunit CU_92;
                    begin
                        PurchPostPrint1.SetReceiveOnly;
                        PurchPostPrint.RUN(Rec);
                        IF Rec."Receiving No." = '-1' THEN
                            ERROR('');
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord();
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD();
        EXIT(Rec.ConfirmDeletion);
    end;

    trigger OnInit()
    begin
        "Tax Area CodeEditable" := TRUE;
        "Shipment Method CodeEditable" := TRUE;
        "Location CodeEditable" := TRUE;
        "Ship-to UPS ZoneEditable" := TRUE;
        "Ship-to CountyEditable" := TRUE;
        "Ship-to CodeEditable" := TRUE;
        "Ship-to Post CodeEditable" := TRUE;
        "Ship-to ContactEditable" := TRUE;
        "Ship-to CityEditable" := TRUE;
        "Ship-to Address 2Editable" := TRUE;
        "Ship-to AddressEditable" := TRUE;
        "Ship-to NameEditable" := TRUE;
        "Document DateEditable" := TRUE;
        "Purchaser CodeEditable" := TRUE;
        "Posting DateEditable" := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter();
        OnAfterGetCurrRecord();
    end;

    trigger OnOpenPage()
    begin
        IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter());
            Rec.FILTERGROUP(0);
        END;

        //SETRANGE("Date Filter",0D,WORKDATE - 1);
    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";
        UserMgt: Codeunit "User Setup Management";
        "Document DateEditable": Boolean;
        "Location CodeEditable": Boolean;
        "Posting DateEditable": Boolean;
        "Purchaser CodeEditable": Boolean;
        "Ship-to Address 2Editable": Boolean;
        "Ship-to AddressEditable": Boolean;
        "Ship-to CityEditable": Boolean;
        "Ship-to CodeEditable": Boolean;
        "Ship-to ContactEditable": Boolean;
        "Ship-to CountyEditable": Boolean;
        "Ship-to NameEditable": Boolean;
        "Ship-to Post CodeEditable": Boolean;
        "Ship-to UPS ZoneEditable": Boolean;
        "Shipment Method CodeEditable": Boolean;
        "Tax Area CodeEditable": Boolean;
        FreightAmount: Decimal;
        Text000: Label 'Unable to execute this function while in view only mode.';

    procedure UpdateAllowed(): Boolean
    begin
        IF CurrPage.EDITABLE = FALSE THEN
            ERROR(Text000);
        EXIT(TRUE);
    end;

    procedure OrderOnHold(OnHold: Boolean)
    begin
        "Posting DateEditable" := NOT OnHold;
        //CurrForm."Order Date".EDITABLE := NOT OnHold;
        "Purchaser CodeEditable" := NOT OnHold;
        "Document DateEditable" := NOT OnHold;
        "Ship-to NameEditable" := NOT OnHold;
        "Ship-to AddressEditable" := NOT OnHold;
        "Ship-to Address 2Editable" := NOT OnHold;
        "Ship-to CityEditable" := NOT OnHold;
        "Ship-to ContactEditable" := NOT OnHold;
        "Ship-to Post CodeEditable" := NOT OnHold;
        "Ship-to CodeEditable" := NOT OnHold;
        "Ship-to CountyEditable" := NOT OnHold;
        "Ship-to UPS ZoneEditable" := NOT OnHold;
        "Location CodeEditable" := NOT OnHold;
        "Shipment Method CodeEditable" := NOT OnHold;
        "Tax Area CodeEditable" := NOT OnHold;

        CurrPage.PurchLines.PAGE.OrderOnHold(OnHold);
    end;

    local procedure BuyfromVendorNoOnAfterValidate()
    begin
        CurrPage.UPDATE();
    end;

    local procedure PaytoVendorNoOnAfterValidate()
    begin
        CurrPage.UPDATE();
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        OrderOnHold(Rec."On Hold" <> '');
        FreightAmount := 0;
    end;
}

