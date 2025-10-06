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
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = Table38;
    SourceTableView = WHERE(Document Type=FILTER(Order));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No.";"No.")
                {
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                          CurrPage.UPDATE;
                    end;
                }
                field("Buy-from Vendor No.";"Buy-from Vendor No.")
                {
                    Editable = false;

                    trigger OnValidate()
                    begin
                        BuyfromVendorNoOnAfterValidate;
                    end;
                }
                field("Buy-from Vendor Name";"Buy-from Vendor Name")
                {
                    Editable = false;
                }
                field("Pay-to Vendor No.";"Pay-to Vendor No.")
                {
                    Editable = false;

                    trigger OnValidate()
                    begin
                        PaytoVendorNoOnAfterValidate;
                    end;
                }
                field("Tax Liable";"Tax Liable")
                {
                    Editable = false;
                }
                field("Posting Date";"Posting Date")
                {
                    Editable = "Posting DateEditable";
                }
                field("Order Date";"Order Date")
                {
                    Editable = false;
                }
                field("Document Date";"Document Date")
                {
                    Editable = "Document DateEditable";
                }
                field("Requested Receipt Date";"Requested Receipt Date")
                {
                    Editable = false;
                }
                field("Promised Receipt Date";"Promised Receipt Date")
                {
                }
                field("Purchaser Code";"Purchaser Code")
                {
                    Editable = "Purchaser CodeEditable";
                }
                field("Shortcut Dimension 1 Code";"Shortcut Dimension 1 Code")
                {
                    Editable = false;

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code";"Shortcut Dimension 2 Code")
                {
                    Editable = false;

                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
                field(Status;Status)
                {
                    Editable = false;
                }
                field("On Hold";"On Hold")
                {
                    Editable = false;
                }
            }
            part(PurchLines;50043)
            {
                SubPageLink = Document No.=FIELD(No.);
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Code";"Ship-to Code")
                {
                    Editable = "Ship-to CodeEditable";
                }
                field("Ship-to Name";"Ship-to Name")
                {
                    Editable = "Ship-to NameEditable";
                }
                field("Ship-to Address";"Ship-to Address")
                {
                    Editable = "Ship-to AddressEditable";
                }
                field("Ship-to Address 2";"Ship-to Address 2")
                {
                    Editable = "Ship-to Address 2Editable";
                }
                field("Ship-to City";"Ship-to City")
                {
                    Editable = "Ship-to CityEditable";
                }
                field("Ship-to County";"Ship-to County")
                {
                    Caption = 'Ship-to State / ZIP Code';
                    Editable = "Ship-to CountyEditable";
                }
                field("Ship-to Post Code";"Ship-to Post Code")
                {
                    Editable = "Ship-to Post CodeEditable";
                }
                field("Ship-to Contact";"Ship-to Contact")
                {
                    Editable = "Ship-to ContactEditable";
                }
                field("Ship-to UPS Zone";"Ship-to UPS Zone")
                {
                    Editable = "Ship-to UPS ZoneEditable";
                }
                field("Tax Area Code";"Tax Area Code")
                {
                    Editable = "Tax Area CodeEditable";
                }
                field("Location Code";"Location Code")
                {
                    Editable = "Location CodeEditable";
                }
                field("Shipment Method Code";"Shipment Method Code")
                {
                    Editable = "Shipment Method CodeEditable";
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

                    trigger OnAction()
                    begin
                        PurchSetup.GET;
                        IF PurchSetup."Calc. Inv. Discount" THEN BEGIN
                          CurrPage.PurchLines.PAGE.CalcInvDisc;
                          COMMIT
                        END;
                        IF "Tax Area Code" = '' THEN
                          PAGE.RUNMODAL(PAGE::"Purchase Order Statistics",Rec)
                        ELSE
                          PAGE.RUNMODAL(PAGE::"Purchase Order Stats.",Rec)
                    end;
                }
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page 26;
                    RunPageLink = No.=FIELD(Buy-from Vendor No.);
                    ShortCutKey = 'Shift+F7';
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 66;
                    RunPageLink = Document Type=FIELD(Document Type),
                                  No.=FIELD(No.);
                }
                action("&Receipts")
                {
                    Caption = '&Receipts';
                    Image = PostedReceipts;
                    RunObject = Page 145;
                    RunPageLink = Order No.=FIELD(No.);
                    RunPageView = SORTING(Order No.);
                }
                action(Invoices)
                {
                    Caption = 'Invoices';
                    Image = Invoice;
                    RunObject = Page 146;
                    RunPageLink = Order No.=FIELD(No.);
                    RunPageView = SORTING(Order No.);
                }
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
                        CurrPage.SAVERECORD;
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
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //>>NIF MAK 071205
                    CurrPage.PurchLines.PAGE.OpenItemTrackingLines;
                    //<<NIF MAK 071205
                end;
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Lot Entry")
                {
                    Caption = 'Lot Entry';

                    trigger OnAction()
                    var
                        LotEntry: Record "50002";
                        PurchLinesChkWt: Record "39";
                        ItemChkWt: Record "27";
                    begin
                        //>>NIF MAK 20051213
                        PurchLinesChkWt.SETRANGE("Document Type", "Document Type");
                        PurchLinesChkWt.SETRANGE("Document No.", "No.");
                        PurchLinesChkWt.SETRANGE(Type, PurchLinesChkWt.Type::Item);
                        IF PurchLinesChkWt.FIND('-') THEN
                          REPEAT
                            ItemChkWt.GET(PurchLinesChkWt."No.");
                            IF ItemChkWt."Net Weight" = 0 THEN
                              MESSAGE('Item %1 does not have a net weight!', ItemChkWt."No.");
                          UNTIL PurchLinesChkWt.NEXT = 0;
                        //<<NIF MAK 20051213


                        LotEntry.GetPurchLines(LotEntry."Document Type"::"Purchase Order","No.");
                        COMMIT;
                        LotEntry.SETRANGE("Document Type",LotEntry."Document Type"::"Purchase Order");
                        LotEntry.SETRANGE("Document No.","No.");
                        PAGE.RUNMODAL(0,LotEntry);
                        CLEAR(LotEntry);
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
                        ReleasePurchDoc.Reopen(Rec);
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                action("Pre-Receiving Report")
                {
                    Caption = 'Pre-Receiving Report';
                    Enabled = false;
                    Visible = false;

                    trigger OnAction()
                    begin
                        //>> NF1.00:CIS.NG 09-29-15
                        //CurrPage.SETSELECTIONFILTER(PurchHeader);
                        //REPORT.RUN(REPORT::Report50070,TRUE,FALSE,PurchHeader);
                        //<< NF1.00:CIS.NG 09-29-15
                    end;
                }
                action("Test Report")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;

                    trigger OnAction()
                    var
                        ">>NIF_LV": Integer;
                        PurchTestReport: Report "402";
                        PurchHeader: Record "38";
                    begin
                        //>> RTT 09-26-05
                        //ReportPrint.PrintPurchHeader(Rec);
                        PurchHeader := Rec;
                        PurchHeader.SETRECFILTER;
                        PurchTestReport.SetCalledFromReceiving;
                        PurchTestReport.SETTABLEVIEW(PurchHeader);
                        PurchTestReport.RUN;
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

                    trigger OnAction()
                    var
                        ">>NIF_LV": Integer;
                        PurchPostYN: Codeunit "91";
                    begin
                        PurchPostYN.SetReceiveOnly;
                        PurchPostYN.RUN(Rec);
                        IF "Receiving No." = '-1' THEN
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

                    trigger OnAction()
                    var
                        PurchPostPrint: Codeunit "92";
                    begin
                        PurchPostPrint.SetReceiveOnly;
                        PurchPostPrint.RUN(Rec);
                        IF "Receiving No." = '-1' THEN
                          ERROR('');
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
        EXIT(ConfirmDeletion);
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
        "Responsibility Center" := UserMgt.GetPurchasesFilter();
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin
        IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Responsibility Center",UserMgt.GetPurchasesFilter());
          FILTERGROUP(0);
        END;

        //SETRANGE("Date Filter",0D,WORKDATE - 1);
    end;

    var
        Text000: Label 'Unable to execute this function while in view only mode.';
        CopyPurchDoc: Report "492";
        MoveNegPurchLines: Report "6698";
        PurchLine: Record "39";
        ReportPrint: Codeunit "228";
        DocPrint: Codeunit "229";
        PurchSetup: Record "312";
        ChangeExchangeRate: Page "511";
        UserMgt: Codeunit "5700";
        FreightAmount: Decimal;
        FreightLineExists: Boolean;
        tcFreightLineDescription: Label 'Freight Amount';
        NIF: Integer;
        PurchHeader: Record "38";
        [InDataSet]
        "Posting DateEditable": Boolean;
        [InDataSet]
        "Purchaser CodeEditable": Boolean;
        [InDataSet]
        "Document DateEditable": Boolean;
        [InDataSet]
        "Ship-to NameEditable": Boolean;
        [InDataSet]
        "Ship-to AddressEditable": Boolean;
        [InDataSet]
        "Ship-to Address 2Editable": Boolean;
        [InDataSet]
        "Ship-to CityEditable": Boolean;
        [InDataSet]
        "Ship-to ContactEditable": Boolean;
        [InDataSet]
        "Ship-to Post CodeEditable": Boolean;
        [InDataSet]
        "Ship-to CodeEditable": Boolean;
        [InDataSet]
        "Ship-to CountyEditable": Boolean;
        [InDataSet]
        "Ship-to UPS ZoneEditable": Boolean;
        [InDataSet]
        "Location CodeEditable": Boolean;
        [InDataSet]
        "Shipment Method CodeEditable": Boolean;
        [InDataSet]
        "Tax Area CodeEditable": Boolean;

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
        CurrPage.UPDATE;
    end;

    local procedure PaytoVendorNoOnAfterValidate()
    begin
        CurrPage.UPDATE;
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
        OrderOnHold("On Hold" <> '');
        FreightAmount := 0;
    end;
}

