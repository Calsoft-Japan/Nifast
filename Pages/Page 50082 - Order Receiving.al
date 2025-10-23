page 50082 "Order Receiving"
{
    // NF1.00:CIS.NG    12/05/15 Create New Page to show Receiving Order

    Caption = 'Order Receiving';
    CardPageID = "Purchase Order Receipt";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = CONST(Order));

    layout
    {
        area(content)
        {
            repeater(GeneralFilters)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ToolTip = 'Specifies the number of the vendor who delivers the products.';
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the order address code linked to the relevant vendor''s order address.';
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ToolTip = 'Specifies the name of the vendor who delivers the products.';
                }
                field("Vendor Authorization No."; Rec."Vendor Authorization No.")
                {
                    ToolTip = 'Specifies the compensation agreement identification number, sometimes referred to as the RMA No. (Returns Materials Authorization).';
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the postal code.';
                }
                field("Buy-from Country/Region Code"; Rec."Buy-from Country/Region Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the country or region of the address.';
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    Visible = false;
                    ToolTip = 'Specifies the name of the person to contact about shipment of the item from this vendor.';
                }
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the number of the vendor that you received the invoice from.';
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    Visible = false;
                    ToolTip = 'Specifies the name of the vendor sending the invoice.';
                }
                field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the postal code.';
                }
                field("Pay-to Country/Region Code"; Rec."Pay-to Country/Region Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the country/region code of the vendor on the purchase document.';
                }
                field("Pay-to Contact"; Rec."Pay-to Contact")
                {
                    Visible = false;
                    ToolTip = 'Specifies the name of the person to contact about an invoice from this vendor.';
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies a code for an alternate shipment address if you want to ship to another address than the one that has been entered automatically. This field is also used in case of drop shipment.';
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    Visible = false;
                    ToolTip = 'Specifies the name of the company at the address to which you want the items in the purchase order to be shipped.';
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the postal code.';
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the country/region code of the address that the items are shipped to.';
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    Visible = false;
                    ToolTip = 'Specifies the name of a contact person for the address where the items in the purchase order should be shipped.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Visible = false;
                    ToolTip = 'Specifies the date when the posting of the purchase document will be recorded.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        DimMgt.LookupDimValueCodeNoUpdate(1);
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        DimMgt.LookupDimValueCodeNoUpdate(2);
                    end;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Visible = true;
                    ToolTip = 'Specifies the location where the items are to be placed when they are received. This field acts as the default location for new lines. You can update the location code for individual lines as needed.';
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies which purchaser is assigned to the vendor.';
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the currency that is used on the entry.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    Visible = false;
                    ToolTip = 'Specifies the date when the related document was created.';
                }
                field(Status; Rec.Status)
                {
                    Visible = false;
                    ToolTip = 'Specifies whether the record is open, waiting to be approved, invoiced for prepayment, or released to the next stage of processing.';
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    Visible = false;
                    ToolTip = 'Specifies when the related sales invoice must be paid.';
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    Visible = false;
                    ToolTip = 'Specifies the payment discount percentage that is granted if you pay on or before the date entered in the Pmt. Discount Date field. The discount percentage is specified in the Payment Terms Code field.';
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies how to make payment, such as with bank transfer, cash, or check.';
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the delivery conditions of the related shipment, such as free on board (FOB).';
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    Visible = false;
                    ToolTip = 'Specifies the date that you want the vendor to deliver your order. The field is used to calculate the latest date you can order, as follows: requested receipt date - lead time calculation = order date. If you do not need delivery on a specific date, you can leave the field blank.';
                }
                field("Job Queue Status"; Rec."Job Queue Status")
                {
                    Visible = JobQueueActive;
                    ToolTip = 'Specifies the status of a job queue entry that handles the posting of purchase credit memos.';
                }
            }
        }
        area(factboxes)
        {
            part(VendorDetailsFactBox; "Vendor Details FactBox")
            {
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                Visible = true;
            }
            systempart(Links; Links)
            {
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                Visible = true;
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
                Image = "Order";
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
                    end;
                }
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F7';
                    ToolTip = 'Executes the Statistics action.';

                    trigger OnAction()
                    begin
                        Rec.CalcInvDiscForHeader();
                        COMMIT();
                        //PAGE.RUNMODAL(PAGE::"Purchase Order Statistics",Rec);
                        IF Rec."Tax Area Code" = '' THEN
                            PAGE.RUNMODAL(PAGE::"Purchase Order Statistics", Rec)
                        ELSE
                            PAGE.RUNMODAL(PAGE::"Purchase Order Stats.", Rec)
                    end;
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = false;
                    ToolTip = 'Executes the Approvals action.';
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        ApprovalEntries.SetRecordFilters(DATABASE::"Purchase Header", Rec."Document Type", Rec."No.");
                        ApprovalEntries.RUN();
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                    ToolTip = 'Executes the Co&mments action.';
                }
                action("E-&Mail List")
                {
                    Caption = 'E-&Mail List';
                    Image = Email;
                    ToolTip = 'Executes the E-&Mail List action.';

                    trigger OnAction()
                    var
                        EMailListEntry: Record "LAX E-Mail List Entry";
                    begin
                        EMailListEntry.RESET();
                        EMailListEntry.SETRANGE("Table ID", DATABASE::"Purchase Header");
                        EMailListEntry.SETRANGE(Type, Rec."Document Type");
                        EMailListEntry.SETRANGE(Code, Rec."No.");
                        PAGE.RUNMODAL(PAGE::"lax E-Mail List Entries", EMailListEntry);
                    end;
                }
                group(EDIs)
                {
                    Caption = 'EDI';
                    action("&EDI Received Elements")
                    {
                        Caption = '&EDI Received Elements';
                        Image = Receivables;
                        RunObject = Page "LAX EDI Receive Elements";
                        RunPageLink = "Internal Doc. No." = FIELD("LAX EDI Internal Doc. No.");
                        RunPageView = SORTING("Internal Doc. No.", "Line No.")
                                      ORDER(Ascending)
                                      WHERE(Viewable = CONST(true));
                        ToolTip = 'Executes the &EDI Received Elements action.';

                    }
                    action(Trace)
                    {
                        Caption = 'Trace';
                        Image = Trace;
                        ToolTip = 'Executes the Trace action.';

                        trigger OnAction()
                        var
                            EDITrace: Page "LAX EDI Trace";
                        begin
                            CLEAR(EDITrace);
                            EDITrace.SetDoc(Rec."LAX EDI Internal Doc. No.");
                            EDITrace.RUNMODAL();
                        end;
                    }
                }
                group("E-Ships")
                {
                    Caption = 'E-Ship';
                    action(Receives)
                    {
                        Caption = 'Receives';
                        Image = Receivables;
                        RunObject = Page "LAX Receives";
                        RunPageLink = "Source Type" = CONST(38),
                                      "Source Subtype" = FIELD("Document Type"),
                                      "Source ID" = FIELD("No.");
                        RunPageView = SORTING("Source Type", "Source Subtype", "Source ID");
                        ToolTip = 'Executes the Receives action.';
                    }
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Documents;
                action(Receiptss)
                {
                    Caption = 'Receipts';
                    Image = PostedReceipts;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Page "Posted Purchase Receipts";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    ToolTip = 'Executes the Receipts action.';
                }
                action(Invoicess)
                {
                    Caption = 'Invoices';
                    Image = Invoice;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Page "Posted Purchase Invoices";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    ToolTip = 'Executes the Invoices action.';
                }
                action("Prepa&yment Invoices")
                {
                    Caption = 'Prepa&yment Invoices';
                    Image = PrepaymentInvoice;
                    RunObject = Page "Posted Purchase Invoices";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                    ToolTip = 'Executes the Prepa&yment Invoices action.';
                }
                action("Prepayment Credi&t Memos")
                {
                    Caption = 'Prepayment Credi&t Memos';
                    Image = PrepaymentCreditMemo;
                    RunObject = Page "Posted Purchase Credit Memos";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                    ToolTip = 'Executes the Prepayment Credi&t Memos action.';
                }
                separator(" ")
                {
                }
            }
            group(Warehouses)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                action("In&vt. Put-away/Pick Lines")
                {
                    Caption = 'In&vt. Put-away/Pick Lines';
                    Image = PickLines;
                    RunObject = Page "Warehouse Activity List";
                    RunPageLink = "Source Document" = CONST("Purchase Order"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                    ToolTip = 'Executes the In&vt. Put-away/Pick Lines action.';
                }
                action("Whse. Receipt Lines")
                {
                    Caption = 'Whse. Receipt Lines';
                    Image = ReceiptLines;
                    RunObject = Page "Whse. Receipt Lines";
                    RunPageLink = "Source Type" = CONST(39),
                                  "Source Subtype" = FIELD("Document Type"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                    ToolTip = 'Executes the Whse. Receipt Lines action.';
                }
                separator("  ")
                {
                }
            }
        }
        area(processing)
        {
            group(General)
            {
                Caption = 'General';
                Image = Print;
                action("&Print")
                {
                    Caption = '&Print';
                    Ellipsis = true;
                    Image = Print;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ToolTip = 'Executes the &Print action.';

                    trigger OnAction()
                    begin
                        DocPrint.PrintPurchHeader(Rec);
                    end;
                }
            }
            group(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';
                    ToolTip = 'Executes the Re&lease action.';

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualRelease(Rec);
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
                        ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }
                separator("   ")
                {
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Send A&pproval Request")
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    ToolTip = 'Executes the Send A&pproval Request action.';

                    trigger OnAction()
                    var
                        // ApprovalMgt: Codeunit "Export F/O Consolidation";
                        ApprovalMgt: Codeunit "ApprovalS Mgmt.";
                    begin
                        ApprovalMgt.OnSendPurchaseDocForApproval(Rec);
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    ToolTip = 'Executes the Cancel Approval Re&quest action.';

                    trigger OnAction()
                    var
                        // ApprovalMgt: Codeunit "Export F/O Consolidation";
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalMgt.OnCancelPurchaseApprovalRequest(Rec)
                    end;
                }
                separator("    ")
                {
                }
                action("Send IC Purchase Order")
                {
                    AccessByPermission = TableData "IC G/L Account" = R;
                    Caption = 'Send IC Purchase Order';
                    Image = IntercompanyOrder;
                    ToolTip = 'Executes the Send IC Purchase Order action.';

                    trigger OnAction()
                    var
                        //SalesHeader: Record "Sales Header";
                        //ApprovalMgt: Codeunit "Export F/O Consolidation";
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                        ICInOutboxMgt: Codeunit ICInboxOutboxMgt;
                    begin
                        IF ApprovalMgt.PrePostApprovalCheckPurch(Rec) THEN
                            ICInOutboxMgt.SendPurchDoc(Rec, FALSE);
                    end;
                }
                action("E-Mail Confirmation")
                {
                    Caption = 'E-Mail Confirmation';
                    ToolTip = 'Executes the E-Mail Confirmation action.';

                    trigger OnAction()
                    var
                        EMailMgt: Codeunit "LAX E-Mail Management";
                    begin
                        Rec.TESTFIELD("LAX E-Mail Confirm. Handled", FALSE);

                        EMailMgt.SendPurchaseConfirmation(Rec, TRUE, FALSE);
                    end;
                }
                group("E-Ship")
                {
                    Caption = 'E-Ship';
                    action("Fast Receive")
                    {
                        Caption = 'Fast Receive';
                        ShortCutKey = 'Alt+F11';
                        Image = Receivables;
                        ToolTip = 'Executes the Fast Receive action.';

                        trigger OnAction()
                        var
                            FastReceiveLine: Record "LAX Fast Receive Line";
                        begin
                            FastReceiveLine.RESET();
                            FastReceiveLine.SETRANGE("Source Type", DATABASE::"Purchase Header");
                            FastReceiveLine.SETRANGE("Source Subtype", Rec."Document Type".AsInteger());
                            FastReceiveLine.SETRANGE("Source ID", Rec."No.");
                            PAGE.RUNMODAL(PAGE::"lax Fast Receive Order", FastReceiveLine);
                        end;
                    }
                }
                group(EDI)
                {
                    Caption = 'EDI';
                    action("Send EDI Purchase Order")
                    {
                        Caption = 'Send EDI Purchase Order';
                        Image = SendTo;
                        ToolTip = 'Executes the Send EDI Purchase Order action.';

                        trigger OnAction()
                        var
                            EDIIntegration: Codeunit "LAX EDI Integration";
                        begin
                            EDIIntegration.SendPurchaseOrder(Rec);
                        end;
                    }
                }
            }
            group(Warehouse)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                action("Create &Whse. Receipt")
                {
                    AccessByPermission = TableData "Warehouse Receipt Header" = R;
                    Caption = 'Create &Whse. Receipt';
                    Image = NewReceipt;
                    ToolTip = 'Executes the Create &Whse. Receipt action.';

                    trigger OnAction()
                    var
                        GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
                    begin
                        GetSourceDocInbound.CreateFromPurchOrder(Rec);

                        IF NOT Rec.FIND('=><') THEN
                            Rec.INIT();
                    end;
                }
                action("Create Inventor&y Put-away/Pick")
                {
                    AccessByPermission = TableData "Posted Invt. Put-away Header" = R;
                    Caption = 'Create Inventor&y Put-away/Pick';
                    Ellipsis = true;
                    Image = CreatePutawayPick;
                    ToolTip = 'Executes the Create Inventor&y Put-away/Pick action.';

                    trigger OnAction()
                    begin
                        Rec.CreateInvtPutAwayPick();

                        IF NOT Rec.FIND('=><') THEN
                            Rec.INIT();
                    end;
                }
                separator("-")
                {
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action("Test Report")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    ToolTip = 'Executes the Test Report action.';

                    trigger OnAction()
                    begin
                        ReportPrint.PrintPurchHeader(Rec);
                    end;
                }
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ToolTip = 'Executes the P&ost action.';

                    trigger OnAction()
                    begin
                        Rec.SendToPosting(CODEUNIT::"Purch.-Post (Yes/No)");
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
                    begin
                        Rec.SendToPosting(CODEUNIT::"Purch.-Post + Print");
                    end;
                }
                action("Post &Batch")
                {
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Executes the Post &Batch action.';

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Purchase Orders", TRUE, TRUE, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Remove From Job Queue")
                {
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    Visible = JobQueueActive;
                    ToolTip = 'Executes the Remove From Job Queue action.';

                    trigger OnAction()
                    begin
                        Rec.CancelBackgroundPosting();
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        UserMgt: Codeunit "User Setup Management";
    begin
        //SetSecurityFilterOnRespCenter;
        IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter());
            Rec.FILTERGROUP(0);
        END;

        //SETRANGE("Date Filter",0D,WORKDATE - 1);

        JobQueueActive := PurchasesPayablesSetup.JobQueueActive();
    end;

    var
        DimMgt: Codeunit DimensionManagement;
        DocPrint: Codeunit "Document-Print";
        ReportPrint: Codeunit "Test Report-Print";
        JobQueueActive: Boolean;
}

