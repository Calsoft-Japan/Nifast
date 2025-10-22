page 50058 "Posted Sales Invoice Line NIF"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    AutoSplitKey = true;
    Caption = 'Posted Sales Invoice Line NIF';
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sales Invoice Line";

    layout
    {
        area(content)
        {
            field(tShowOtherCustomers; tShowOtherCustomers)
            {
                Caption = 'Show Other Customers';
                ToolTip = 'Specifies the value of the Show Other Customers field.';

                trigger OnValidate()
                begin
                    IF tOrigCustNo = '' THEN
                        tOrigCustNo := Rec."Sell-to Customer No.";

                    IF tShowOtherCustomers THEN
                        Rec.SETRANGE("Sell-to Customer No.")
                    ELSE
                        Rec.SETRANGE("Sell-to Customer No.", tOrigCustNo);
                    tShowOtherCustomersOnAfterVali();
                end;
            }
            repeater(General)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                    Caption = 'Posting Date';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                    Caption = 'Type';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    Caption = 'No.';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Specifies the value of the Sell-to Customer No. field.';
                    Caption = 'Sell-to Customer No.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'Specifies the value of the External Document No. field.';
                    Caption = 'External Document No.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                    Caption = 'Location Code';
                }
                field(GetOrderNos; GetOrderNo())
                {
                    Caption = 'Order No.';
                    ToolTip = 'Specifies the value of the Order No. field.';
                }
                field("Cross-Reference No."; Rec."Item Reference No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Cross-Reference No. field.';
                    Caption = 'Cross-Reference No.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Variant Code field.';
                    Caption = 'Variant Code';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    Caption = 'Description';
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Return Reason Code field.';
                    Caption = 'Return Reason Code';
                }
                field(Quantity; Rec.Quantity)
                {
                    BlankZero = true;
                    ToolTip = 'Specifies the value of the Quantity field.';
                    Caption = 'Quantity';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                    Caption = 'Unit of Measure Code';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Unit of Measure field.';
                    Caption = 'Unit of Measure';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Unit Price field.';
                    Caption = 'Unit Price';
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    BlankZero = true;
                    ToolTip = 'Specifies the value of the Line Amount field.';
                    Caption = 'Line Amount';
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    BlankZero = true;
                    ToolTip = 'Specifies the value of the Line Discount % field.';
                    Caption = 'Line Discount %';
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Line Discount Amount field.';
                    Caption = 'Line Discount Amount';
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Allow Invoice Disc. field.';
                    Caption = 'Allow Invoice Disc.';
                }
                field("Job No."; Rec."Job No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Project No. field.';
                    Caption = 'Project No.';
                }
                field("Depr. until FA Posting Date"; Rec."Depr. until FA Posting Date")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Depr. until FA Posting Date field.';
                    Caption = 'Depr. until FA Posting Date';
                }
                field("Depreciation Book Code"; Rec."Depreciation Book Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Depreciation Book Code field.';
                    Caption = 'Depreciation Book Code';
                }
                field("Alt. Quantity"; Rec."Alt. Quantity")
                {
                    ToolTip = 'Specifies the value of the Alt. Quantity field.';
                    Caption = 'Alt. Quantity';
                }
                field("Alt. Qty. UOM"; Rec."Alt. Qty. UOM")
                {
                    ToolTip = 'Specifies the value of the Alt. Qty. UOM field.';
                    Caption = 'Alt. Qty. UOM';
                }
                field("Alt. Price"; Rec."Alt. Price")
                {
                    ToolTip = 'Specifies the value of the Alt. Price field.';
                    Caption = 'Alt. Price';
                }
                field("Alt. Price UOM"; Rec."Alt. Price UOM")
                {
                    ToolTip = 'Specifies the value of the Alt. Price UOM field.';
                    Caption = 'Alt. Price UOM';
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Appl.-to Item Entry field.';
                    Caption = 'Appl.-to Item Entry';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                    Caption = 'Shortcut Dimension 1 Code';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                    Caption = 'Shortcut Dimension 2 Code';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                    Caption = 'Document No.';
                }
                field("EDI Control No."; Rec."EDI Control No.")
                {
                    ToolTip = 'Specifies the value of the EDI Control No. field.';
                    Caption = 'EDI Control No.';
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Unit Cost (LCY) field.';
                    Caption = 'Unit Cost (LCY)';
                }
                field(Name; mCustomer.Name)
                {
                    Caption = 'Customer';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Customer field.';
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ToolTip = 'Specifies the value of the Ship-to Code field.';
                    Caption = 'Ship-to Code';
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
                    ToolTip = 'Executes the Card action.';

                    trigger OnAction()
                    begin
                        SalesInvHdr.GET(Rec."Document No.");
                        SalesInvHdrForm.SETRECORD(SalesInvHdr);
                        SalesInvHdrForm.RUN();
                    end;
                }
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
                        IF Rec."Tax Area Code" = '' THEN
                            PAGE.RUNMODAL(PAGE::"Sales Invoice Statistics", Rec, Rec."No.")
                        ELSE
                            PAGE.RUNMODAL(PAGE::"Sales Invoice Stats.", Rec, Rec."No.");
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = CONST("Posted Invoice"),
                                  "No." = FIELD("No.");
                    ToolTip = 'Executes the Co&mments action.';
                }
                action(Dimensionss)
                {
                    AccessByPermission = TableData Dimension = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'Executes the Dimensions action.';

                    trigger OnAction()
                    begin
                        ShowDimensions();
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
                    ToolTip = 'Executes the Dimensions action.';

                    trigger OnAction()
                    begin
                        ShowDimensions();
                    end;
                }
                action("Item &Tracking Entries")
                {
                    Caption = 'Item &Tracking Entries';
                    Image = ItemTrackingLedger;
                    ToolTip = 'Executes the Item &Tracking Entries action.';

                    trigger OnAction()
                    begin
                        ShowItemTrackingLines();
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
                PromotedOnly = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the &Navigate action.';

                trigger OnAction()
                begin
                    SalesInvHdr.GET(Rec."Document No.");
                    SalesInvHdr.Navigate();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF NOT mCustomer.GET(Rec."Sell-to Customer No.") THEN
            mCustomer.Name := '<Customer not found>';
    end;

    var
        mCustomer: Record Customer;
        SalesInvHdr: Record "Sales Invoice Header";
        SalesInvHdrForm: Page "Posted Sales Invoice";
        tShowOtherCustomers: Boolean;
        tOrigCustNo: Code[20];

    procedure ShowDimensions()
    begin
        Rec.ShowDimensions();
    end;

    procedure ShowItemTrackingLines()
    begin
        Rec.ShowItemTrackingLines();
    end;

    procedure ShowLineComments(DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Receipt,"Posted Invoice","Posted Credit Memo","Posted Return Shipment")
    begin
        Rec.ShowLineComments();
    end;

    procedure GetOrderNo(): Code[20]
    begin
        IF NOT SalesInvHdr.GET(Rec."Document No.") THEN
            EXIT('')
        ELSE
            EXIT(SalesInvHdr."Order No.");
    end;

    local procedure tShowOtherCustomersOnAfterVali()
    begin
        CurrPage.UPDATE();
    end;
}

