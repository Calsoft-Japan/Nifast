page 50058 "Posted Sales Invoice Line NIF"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    AutoSplitKey = true;
    Caption = 'Posted Sales Invoice Line NIF';
    Editable = false;
    PageType = List;
    SourceTable = Table113;

    layout
    {
        area(content)
        {
            field(tShowOtherCustomers;tShowOtherCustomers)
            {
                Caption = 'Show Other Customers';

                trigger OnValidate()
                begin
                    IF tOrigCustNo = '' THEN
                      tOrigCustNo := "Sell-to Customer No.";

                    IF tShowOtherCustomers THEN
                      SETRANGE("Sell-to Customer No.")
                      ELSE SETRANGE("Sell-to Customer No.", tOrigCustNo);
                      tShowOtherCustomersOnAfterVali;
                end;
            }
            repeater()
            {
                field("Posting Date";"Posting Date")
                {
                }
                field(Type;Type)
                {
                }
                field("No.";"No.")
                {
                }
                field("Sell-to Customer No.";"Sell-to Customer No.")
                {
                }
                field("External Document No.";"External Document No.")
                {
                }
                field("Location Code";"Location Code")
                {
                }
                field(GetOrderNo;GetOrderNo)
                {
                    Caption = 'Order No.';
                }
                field("Cross-Reference No.";"Cross-Reference No.")
                {
                    Visible = false;
                }
                field("Variant Code";"Variant Code")
                {
                    Visible = false;
                }
                field(Description;Description)
                {
                }
                field("Return Reason Code";"Return Reason Code")
                {
                    Visible = false;
                }
                field(Quantity;Quantity)
                {
                    BlankZero = true;
                }
                field("Unit of Measure Code";"Unit of Measure Code")
                {
                }
                field("Unit of Measure";"Unit of Measure")
                {
                    Visible = false;
                }
                field("Unit Price";"Unit Price")
                {
                    Visible = false;
                }
                field("Line Amount";"Line Amount")
                {
                    BlankZero = true;
                }
                field("Line Discount %";"Line Discount %")
                {
                    BlankZero = true;
                }
                field("Line Discount Amount";"Line Discount Amount")
                {
                    Visible = false;
                }
                field("Allow Invoice Disc.";"Allow Invoice Disc.")
                {
                    Visible = false;
                }
                field("Job No.";"Job No.")
                {
                    Visible = false;
                }
                field("Depr. until FA Posting Date";"Depr. until FA Posting Date")
                {
                    Visible = false;
                }
                field("Depreciation Book Code";"Depreciation Book Code")
                {
                    Visible = false;
                }
                field("Alt. Quantity";"Alt. Quantity")
                {
                }
                field("Alt. Qty. UOM";"Alt. Qty. UOM")
                {
                }
                field("Alt. Price";"Alt. Price")
                {
                }
                field("Alt. Price UOM";"Alt. Price UOM")
                {
                }
                field("Appl.-to Item Entry";"Appl.-to Item Entry")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code";"Shortcut Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code";"Shortcut Dimension 2 Code")
                {
                    Visible = false;
                }
                field("Document No.";"Document No.")
                {
                }
                field("EDI Control No.";"EDI Control No.")
                {
                }
                field("Unit Cost (LCY)";"Unit Cost (LCY)")
                {
                    Editable = false;
                }
                field(mCustomer.Name;mCustomer.Name)
                {
                    Caption = 'Customer';
                    Editable = false;
                }
                field("Ship-to Code";"Ship-to Code")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Invoice")
            {
                Caption = '&Invoice';
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    ShortCutKey = 'Shift+F7';

                    trigger OnAction()
                    begin
                        SalesInvHdr.GET("Document No.");
                        SalesInvHdrForm.SETRECORD(SalesInvHdr);
                        SalesInvHdrForm.RUN;
                    end;
                }
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        IF "Tax Area Code" = '' THEN
                          PAGE.RUNMODAL(PAGE::"Sales Invoice Statistics",Rec,"No.")
                        ELSE
                          PAGE.RUNMODAL(PAGE::"Sales Invoice Stats.",Rec,"No.");
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 67;
                    RunPageLink = Document Type=CONST(Posted Invoice),
                                  No.=FIELD(No.);
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData 348=R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        ShowDimensions;
                    end;
                }
            }
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
                        ShowDimensions;
                    end;
                }
                action("Item &Tracking Entries")
                {
                    Caption = 'Item &Tracking Entries';
                    Image = ItemTrackingLedger;

                    trigger OnAction()
                    begin
                        ShowItemTrackingLines;
                    end;
                }
            }
        }
        area(processing)
        {
            action("&Navigate")
            {
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    SalesInvHdr.GET("Document No.");
                    SalesInvHdr.Navigate;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF NOT mCustomer.GET("Sell-to Customer No.") THEN
          mCustomer.Name := '<Customer not found>';
    end;

    var
        SalesInvHdr: Record "112";
        SalesInvHdrForm: Page "132";
        mCustomer: Record "18";
        tShowOtherCustomers: Boolean;
        tOrigCustNo: Code[20];

    procedure ShowDimensions()
    begin
        Rec.ShowDimensions;
    end;

    procedure ShowItemTrackingLines()
    begin
        Rec.ShowItemTrackingLines;
    end;

    procedure ShowLineComments(DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Receipt,"Posted Invoice","Posted Credit Memo","Posted Return Shipment")
    begin
        Rec.ShowLineComments(DocumentType);
    end;

    procedure GetOrderNo(): Code[20]
    begin
        IF NOT SalesInvHdr.GET("Document No.") THEN
          EXIT('')
        ELSE
          EXIT(SalesInvHdr."Order No.");
    end;

    local procedure tShowOtherCustomersOnAfterVali()
    begin
        CurrPage.UPDATE;
    end;
}

