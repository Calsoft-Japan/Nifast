page 50082 "Order Receiving"
{
    // NF1.00:CIS.NG    12/05/15 Create New Page to show Receiving Order

    Caption = 'Order Receiving';
    CardPageID = "Purchase Order Receipt";
    Editable = false;
    PageType = List;
    SourceTable = Table38;
    SourceTableView = WHERE(Document Type=CONST(Order));

    layout
    {
        area(content)
        {
            repeater()
            {
                field("No.";"No.")
                {
                }
                field("Buy-from Vendor No.";"Buy-from Vendor No.")
                {
                }
                field("Order Address Code";"Order Address Code")
                {
                    Visible = false;
                }
                field("Buy-from Vendor Name";"Buy-from Vendor Name")
                {
                }
                field("Vendor Authorization No.";"Vendor Authorization No.")
                {
                }
                field("Buy-from Post Code";"Buy-from Post Code")
                {
                    Visible = false;
                }
                field("Buy-from Country/Region Code";"Buy-from Country/Region Code")
                {
                    Visible = false;
                }
                field("Buy-from Contact";"Buy-from Contact")
                {
                    Visible = false;
                }
                field("Pay-to Vendor No.";"Pay-to Vendor No.")
                {
                    Visible = false;
                }
                field("Pay-to Name";"Pay-to Name")
                {
                    Visible = false;
                }
                field("Pay-to Post Code";"Pay-to Post Code")
                {
                    Visible = false;
                }
                field("Pay-to Country/Region Code";"Pay-to Country/Region Code")
                {
                    Visible = false;
                }
                field("Pay-to Contact";"Pay-to Contact")
                {
                    Visible = false;
                }
                field("Ship-to Code";"Ship-to Code")
                {
                    Visible = false;
                }
                field("Ship-to Name";"Ship-to Name")
                {
                    Visible = false;
                }
                field("Ship-to Post Code";"Ship-to Post Code")
                {
                    Visible = false;
                }
                field("Ship-to Country/Region Code";"Ship-to Country/Region Code")
                {
                    Visible = false;
                }
                field("Ship-to Contact";"Ship-to Contact")
                {
                    Visible = false;
                }
                field("Posting Date";"Posting Date")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code";"Shortcut Dimension 1 Code")
                {
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        DimMgt.LookupDimValueCodeNoUpdate(1);
                    end;
                }
                field("Shortcut Dimension 2 Code";"Shortcut Dimension 2 Code")
                {
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        DimMgt.LookupDimValueCodeNoUpdate(2);
                    end;
                }
                field("Location Code";"Location Code")
                {
                    Visible = true;
                }
                field("Purchaser Code";"Purchaser Code")
                {
                    Visible = false;
                }
                field("Assigned User ID";"Assigned User ID")
                {
                }
                field("Currency Code";"Currency Code")
                {
                    Visible = false;
                }
                field("Document Date";"Document Date")
                {
                    Visible = false;
                }
                field(Status;Status)
                {
                    Visible = false;
                }
                field("Payment Terms Code";"Payment Terms Code")
                {
                    Visible = false;
                }
                field("Due Date";"Due Date")
                {
                    Visible = false;
                }
                field("Payment Discount %";"Payment Discount %")
                {
                    Visible = false;
                }
                field("Payment Method Code";"Payment Method Code")
                {
                    Visible = false;
                }
                field("Shipment Method Code";"Shipment Method Code")
                {
                    Visible = false;
                }
                field("Requested Receipt Date";"Requested Receipt Date")
                {
                    Visible = false;
                }
                field("Job Queue Status";"Job Queue Status")
                {
                    Visible = JobQueueActive;
                }
            }
        }
        area(factboxes)
        {
            part(;9093)
            {
                SubPageLink = No.=FIELD(Buy-from Vendor No.);
                Visible = true;
            }
            systempart(;Links)
            {
                Visible = false;
            }
            systempart(;Notes)
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
                    AccessByPermission = TableData 348=R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        ShowDocDim;
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

                    trigger OnAction()
                    begin
                        CalcInvDiscForHeader;
                        COMMIT;
                        //PAGE.RUNMODAL(PAGE::"Purchase Order Statistics",Rec);
                        IF "Tax Area Code" = '' THEN
                          PAGE.RUNMODAL(PAGE::"Purchase Order Statistics",Rec)
                        ELSE
                          PAGE.RUNMODAL(PAGE::"Purchase Order Stats.",Rec)
                    end;
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "658";
                    begin
                        ApprovalEntries.Setfilters(DATABASE::"Purchase Header","Document Type","No.");
                        ApprovalEntries.RUN;
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 66;
                    RunPageLink = Document Type=FIELD(Document Type),
                                  No.=FIELD(No.),
                                  Document Line No.=CONST(0);
                }
                action("E-&Mail List")
                {
                    Caption = 'E-&Mail List';

                    trigger OnAction()
                    var
                        EMailListEntry: Record "14000908";
                    begin
                        EMailListEntry.RESET;
                        EMailListEntry.SETRANGE("Table ID",DATABASE::"Purchase Header");
                        EMailListEntry.SETRANGE(Type,"Document Type");
                        EMailListEntry.SETRANGE(Code,"No.");
                        PAGE.RUNMODAL(PAGE::"E-Mail List Entries",EMailListEntry);
                    end;
                }
                group(EDI)
                {
                    Caption = 'EDI';
                    action("&EDI Received Elements")
                    {
                        Caption = '&EDI Received Elements';
                        RunObject = Page 14000365;
                        RunPageLink = Internal Doc No.=FIELD(EDI Internal Doc. No.);
                        RunPageView = SORTING(Internal Doc No.,Line No.)
                                      ORDER(Ascending)
                                      WHERE(Viewable=CONST(Yes));
                    }
                    action(Trace)
                    {
                        Caption = 'Trace';
                        Image = Trace;

                        trigger OnAction()
                        var
                            EDITrace: Page "14002386";
                        begin
                            CLEAR(EDITrace);
                            EDITrace.SetDoc("EDI Internal Doc. No.");
                            EDITrace.RUNMODAL;
                        end;
                    }
                }
                group("E-Ship")
                {
                    Caption = 'E-Ship';
                    action(Receives)
                    {
                        Caption = 'Receives';
                        RunObject = Page 14000608;
                        RunPageLink = Source Type=CONST(38),
                                      Source Subtype=FIELD(Document Type),
                                      Source ID=FIELD(No.);
                        RunPageView = SORTING(Source Type,Source Subtype,Source ID);
                    }
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Documents;
                action(Receipts)
                {
                    Caption = 'Receipts';
                    Image = PostedReceipts;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Page 145;
                    RunPageLink = Order No.=FIELD(No.);
                    RunPageView = SORTING(Order No.);
                }
                action(Invoices)
                {
                    Caption = 'Invoices';
                    Image = Invoice;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Page 146;
                    RunPageLink = Order No.=FIELD(No.);
                    RunPageView = SORTING(Order No.);
                }
                action("Prepa&yment Invoices")
                {
                    Caption = 'Prepa&yment Invoices';
                    Image = PrepaymentInvoice;
                    RunObject = Page 146;
                    RunPageLink = Prepayment Order No.=FIELD(No.);
                    RunPageView = SORTING(Prepayment Order No.);
                }
                action("Prepayment Credi&t Memos")
                {
                    Caption = 'Prepayment Credi&t Memos';
                    Image = PrepaymentCreditMemo;
                    RunObject = Page 147;
                    RunPageLink = Prepayment Order No.=FIELD(No.);
                    RunPageView = SORTING(Prepayment Order No.);
                }
                separator()
                {
                }
            }
            group(Warehouse)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                action("In&vt. Put-away/Pick Lines")
                {
                    Caption = 'In&vt. Put-away/Pick Lines';
                    Image = PickLines;
                    RunObject = Page 5774;
                    RunPageLink = Source Document=CONST(Purchase Order),
                                  Source No.=FIELD(No.);
                    RunPageView = SORTING(Source Document,Source No.,Location Code);
                }
                action("Whse. Receipt Lines")
                {
                    Caption = 'Whse. Receipt Lines';
                    Image = ReceiptLines;
                    RunObject = Page 7342;
                    RunPageLink = Source Type=CONST(39),
                                  Source Subtype=FIELD(Document Type),
                                  Source No.=FIELD(No.);
                    RunPageView = SORTING(Source Type,Source Subtype,Source No.,Source Line No.);
                }
                separator()
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
                    PromotedCategory = Process;

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

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "415";
                    begin
                        ReleasePurchDoc.PerformManualRelease(Rec);
                    end;
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "415";
                    begin
                        ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }
                separator()
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

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "439";
                    begin
                        IF ApprovalMgt.SendPurchaseApprovalRequest(Rec) THEN;
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "439";
                    begin
                        IF ApprovalMgt.CancelPurchaseApprovalRequest(Rec,TRUE,TRUE) THEN;
                    end;
                }
                separator()
                {
                }
                action("Send IC Purchase Order")
                {
                    AccessByPermission = TableData 410=R;
                    Caption = 'Send IC Purchase Order';
                    Image = IntercompanyOrder;

                    trigger OnAction()
                    var
                        ICInOutboxMgt: Codeunit "427";
                        SalesHeader: Record "36";
                        ApprovalMgt: Codeunit "439";
                    begin
                        IF ApprovalMgt.PrePostApprovalCheck(SalesHeader,Rec) THEN
                          ICInOutboxMgt.SendPurchDoc(Rec,FALSE);
                    end;
                }
                action("E-Mail Confirmation")
                {
                    Caption = 'E-Mail Confirmation';

                    trigger OnAction()
                    var
                        EMailMgt: Codeunit "14000903";
                    begin
                        TESTFIELD("E-Mail Confirmation Handled",FALSE);

                        EMailMgt.SendPurchaseConfirmation(Rec,TRUE,FALSE);
                    end;
                }
                group("E-Ship")
                {
                    Caption = 'E-Ship';
                    action("Fast Receive")
                    {
                        Caption = 'Fast Receive';
                        ShortCutKey = 'Alt+F11';

                        trigger OnAction()
                        var
                            FastReceiveLine: Record "14000609";
                        begin
                            FastReceiveLine.RESET;
                            FastReceiveLine.SETRANGE("Source Type",DATABASE::"Purchase Header");
                            FastReceiveLine.SETRANGE("Source Subtype","Document Type");
                            FastReceiveLine.SETRANGE("Source ID","No.");
                            PAGE.RUNMODAL(PAGE::"Fast Receive Order",FastReceiveLine);
                        end;
                    }
                }
                group(EDI)
                {
                    Caption = 'EDI';
                    action("Send EDI Purchase Order")
                    {
                        Caption = 'Send EDI Purchase Order';

                        trigger OnAction()
                        var
                            EDIIntegration: Codeunit "14000363";
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
                    AccessByPermission = TableData 7316=R;
                    Caption = 'Create &Whse. Receipt';
                    Image = NewReceipt;

                    trigger OnAction()
                    var
                        GetSourceDocInbound: Codeunit "5751";
                    begin
                        GetSourceDocInbound.CreateFromPurchOrder(Rec);

                        IF NOT FIND('=><') THEN
                          INIT;
                    end;
                }
                action("Create Inventor&y Put-away/Pick")
                {
                    AccessByPermission = TableData 7340=R;
                    Caption = 'Create Inventor&y Put-away/Pick';
                    Ellipsis = true;
                    Image = CreatePutawayPick;

                    trigger OnAction()
                    begin
                        CreateInvtPutAwayPick;

                        IF NOT FIND('=><') THEN
                          INIT;
                    end;
                }
                separator()
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

                    trigger OnAction()
                    begin
                        SendToPosting(CODEUNIT::"Purch.-Post (Yes/No)");
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

                    trigger OnAction()
                    begin
                        SendToPosting(CODEUNIT::"Purch.-Post + Print");
                    end;
                }
                action("Post &Batch")
                {
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Purchase Orders",TRUE,TRUE,Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Remove From Job Queue")
                {
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    Visible = JobQueueActive;

                    trigger OnAction()
                    begin
                        CancelBackgroundPosting;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        PurchasesPayablesSetup: Record "312";
        UserMgt: Codeunit "5700";
    begin
        //SetSecurityFilterOnRespCenter;
        IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Responsibility Center",UserMgt.GetPurchasesFilter());
          FILTERGROUP(0);
        END;

        //SETRANGE("Date Filter",0D,WORKDATE - 1);

        JobQueueActive := PurchasesPayablesSetup.JobQueueActive;
    end;

    var
        DimMgt: Codeunit "408";
        ReportPrint: Codeunit "228";
        DocPrint: Codeunit "229";
        [InDataSet]
        JobQueueActive: Boolean;
}

